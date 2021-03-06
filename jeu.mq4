/*------------------------------------------------------------------+
 |                                     jfxdp 240 1440 All close.mq4 |
 |                                                 Copyright © 2000 |
 |                                             javaeurusd@gmail.com |
 +------------------------------------------------------------------*/
#property copyright "Copyright © 2000, javaeurusd@gmail.com"
#property link      "OPEN SOURCE"
//-----
#property indicator_chart_window
#property indicator_buffers 14
#property indicator_color1 White
#property indicator_color2 White
#property indicator_color3 White
#property indicator_color4 White
#property indicator_color5 Blue
#property indicator_color6 Red
//-----
extern bool       AlertsEnabled  = false;
extern bool       TF9            = true;
extern bool       TF8            = true; 
extern bool       TF7            = true;
extern bool       TF6            = true;
extern bool       TF5            = true;
extern bool       TF4            = true; 
extern bool       TF3            = true; 
extern bool       TF2            = true;
//-----
extern double     Step           = 1.0;
extern double     Maximum        = 1.0;
//-----
double s1[];
double s2[];
double s3[];
double s4[];
double s5[];
double s6[];
double s7[];
double s8[];
double s9[];
double bullish[];
double bearish[];
double sarUp[];
double sarDn[];
double alertBar;
bool sar9,sar8,sar7,sar6,sar5,sar4,sar3,sar2;
//+------------------------------------------------------------------+
int init()
 {
   SetIndexBuffer(0, s1);
   SetIndexBuffer(1, s2);
   SetIndexBuffer(2, s3);
   SetIndexBuffer(3, s4);
   SetIndexBuffer(6, s5);
   SetIndexBuffer(7, s6);
   SetIndexBuffer(8, s7);
   SetIndexBuffer(9, s8);
   SetIndexBuffer(10, s9);
  
   
   
   //-----
   SetIndexStyle(0, DRAW_ARROW); //unneccessary code
   SetIndexArrow(0, 159);
   SetIndexStyle(1, DRAW_ARROW);
   SetIndexArrow(1, 159);
   SetIndexStyle(2, DRAW_ARROW);
   SetIndexArrow(2, 159);
   SetIndexStyle(3, DRAW_ARROW); //unneccessary code
   SetIndexArrow(3, 159);
   //------
   SetIndexStyle(4, DRAW_ARROW);// UP___UP___UP 
   SetIndexArrow(4, 241);
   SetIndexBuffer(4, bullish);
   //-----
   SetIndexStyle(5, DRAW_ARROW);// DOWN____DOWN
   SetIndexArrow(5, 242);       
   SetIndexBuffer(5, bearish);
   //-----
   return(0);
 }
//+------------------------------------------------------------------+
void GetBool()
   {
      if(TF9 == true)
         {
            sar9 = true; sar8 = true; sar7 = true; sar6 = true; sar5 = true; sar4 = true; sar3 = true; sar2 = true;
         }
      else if(TF9 == false && TF8 == true)
         {
            sar9 = false; sar8 = true; sar7 = true; sar6 = true; sar5 = true; sar4 = true; sar3 = true; sar2 = true;
         }
      else if(TF9 == false && TF8 == false && TF7 == true)
         {
            sar9 = false; sar8 = false; sar7 = true; sar6 = true; sar5 = true; sar4 = true; sar3 = true; sar2 = true;
         }
      else if(TF9 == false && TF8 == false && TF7 == false && TF6 == true)
         {
            sar9 = false; sar8 = false; sar7 = false; sar6 = true; sar5 = true; sar4 = true; sar3 = true; sar2 = true;
         }
      else if(TF9 == false && TF8 == false && TF7 == false && TF6 == false && TF5 == true)
         {
            sar9 = false; sar8 = false; sar7 = false; sar6 = false; sar5 = true; sar4 = true; sar3 = true; sar2 = true;
         }    
      else if(TF9 == false && TF8 == false && TF7 == false && TF6 == false && TF5 == false && TF4 == true)
         {
            sar9 = false; sar8 = false; sar7 = false; sar6 = false; sar5 = false; sar4 = true; sar3 = true; sar2 = true;
         }
      else if(TF9 == false && TF8 == false && TF7 == false && TF6 == false && TF5 == false && TF4 == false && TF3 == true)
         {
            sar9 = false; sar8 = false; sar7 = false; sar6 = false; sar5 = false; sar4 = false; sar3 = true; sar2 = true;
         }
      else if(TF9 == false && TF8 == false && TF7 == false && TF6 == false && TF5 == false && TF4 == false && TF3 == false && TF2 == true)
         {
            sar9 = false; sar8 = false; sar7 = false; sar6 = false; sar5 = false; sar4 = false; sar3 = false; sar2 = true;
         }
      else if(TF9 == false && TF8 == false && TF7 == false && TF6 == false && TF5 == false && TF4 == false && TF3 == false && TF2 == false)
         {
            sar9 = false; sar8 = false; sar7 = false; sar6 = false; sar5 = false; sar4 = false; sar3 = false; sar2 = false;
         } 
 }
//+------------------------------------------------------------------+
string GetNextTF(int curTF)
 {
   switch(curTF)
    {
      case 1:
        return("5=15#30*60&240^1440`10080'43200");
        break;
      case 5:
        return("15=30#60*240&1440^10080`43200");
        break; 
      case 15:
        return("30=60#240*1440&10080^43200");
        break;
      case 30:
        return("60=240#1440*100800&43200");
        break;
      case 60:
        return("240=1440#10080*43200");
        break;
      case 240:
        return("1440=10080#43200");
        break;        
      
    }
    return("");
 }
//+------------------------------------------------------------------+
void AlertDn(double sar)
 {
   int limit;
   int counted_bars=IndicatorCounted();
   if(counted_bars < 0) counted_bars = 0;
   if(counted_bars > 0) counted_bars--;
   limit = Bars - counted_bars;
   //---- 
   for(int i = 0; i < limit ;i++)
    {
      if(sar >= iClose(Symbol(),0,i))
       {
         if(AlertsEnabled == true && sarUp[i] == 0 && Bars > alertBar)
          {
            Alert("PSAR Going Down on ", Symbol(), " - ", Period(), " min");
            alertBar = Bars;
          }
         sarUp[i] = sar;  
         sarDn[i] = 0;
       }
    }
 }
//+------------------------------------------------------------------+ 
void AlertUp(double sar)
 {
   int limit;
   int counted_bars = IndicatorCounted();
   if(counted_bars < 0) counted_bars = 0;
   if(counted_bars > 0) counted_bars--;
   limit = Bars - counted_bars;
   //---- 
   for(int i = 0; i<limit ;i++)
    {
      if(sar <= iClose(Symbol(), 0, i))
       {
         if(AlertsEnabled == true && sarDn[i] == 0 && Bars > alertBar)
          {
            Alert("PSAR Going Up on ",Symbol(), " - ", Period(), " min");
            alertBar = Bars;
          }
         sarUp[i] = 0;
         sarDn[i] = sar;
       }
    }
 }
//+------------------------------------------------------------------+ 
int start()
 {   
      //responsible for rechecking and updating current signal, start
      //have it check all values
   int limit; 
   int counted_bars = IndicatorCounted();
   if(counted_bars < 0) return(-1);
   if(counted_bars > 0) counted_bars--;
   //-----
   string T = GetNextTF(Period());
   int tf1 = StrToDouble(StringSubstr(T, 0, StringFind(T, "=", 0)));
   int tf2 = StrToDouble(StringSubstr(T, StringFind(T, "=", 0) + 1, StringFind(T, "#", 0))); //TF3
   int tf3 = StrToDouble(StringSubstr(T, StringFind(T, "#", 0) + 1, StringFind(T, "*", 0))); //TF4
   int tf4 = StrToDouble(StringSubstr(T, StringFind(T, "*", 0) + 1, StringFind(T, "&", 0))); //TF5
   int tf5 = StrToDouble(StringSubstr(T, StringFind(T, "&", 0) + 1, StringFind(T, "^", 0))); //TF6
   int tf6 = StrToDouble(StringSubstr(T, StringFind(T, "^", 0) + 1, StringFind(T, "`", 0))); //TF7
   int tf7 = StrToDouble(StringSubstr(T, StringFind(T, "`", 0) + 1, StringFind(T, "'", 0))); //TF8
   int tf8 = StrToDouble(StringSubstr(T, StringFind(T, "'", 0) + 1, StringLen(T))); //TF9
   //int maxtf = MathMax(MathMax(tf1,tf2),tf3);
   //limit = MathMin(MathMax(Bars - counted_bars,3*maxtf/Period()),Bars-1);
   
   int maxtf = MathMax(MathMax(MathMax(MathMax(MathMax(MathMax(MathMax(tf1,tf2),tf3),tf4),tf5),tf6),tf7),tf8);
   limit = MathMin(MathMax(Bars - counted_bars,8*maxtf/Period()),Bars-1);
   //-----
   GetBool();
   //-----
   for(int i = limit - 1; i >= 0; i--)
    {
      bearish[i] = EMPTY_VALUE;
      bullish[i] = EMPTY_VALUE; 
      //responsible for rechecking and updating current signal, stop
      
      //-start TF9
          if(sar2 == true && sar3 == true && sar4 == true && sar5 == true && sar6 == true && sar7 == true && sar8 == true && sar9 == true)
          {
            Comment(Period(), " ON", "\n", tf1, " ON", "\n", tf2, " ON", "\n", tf3, " ON", "\n", tf4, " ON", "\n", tf5, " ON", "\n", tf6, " ON", "\n", tf7, " ON", "\n", tf8, " ON", "\n", "All close");
            s1[i]  = iSAR(NULL, Period(), Step, Maximum, i);
            s2[i]  = iSAR(NULL, tf1, Step, Maximum, i / (tf1 / Period()));
            s3[i]  = iSAR(NULL, tf2, Step, Maximum, i / (tf2 / Period()));
            s4[i]  = iSAR(NULL, tf3, Step, Maximum, i / (tf3 / Period()));
            s5[i]  = iSAR(NULL, tf4, Step, Maximum, i / (tf4 / Period()));
            s6[i]  = iSAR(NULL, tf5, Step, Maximum, i / (tf5 / Period()));
            s7[i]  = iSAR(NULL, tf6, Step, Maximum, i / (tf6 / Period()));
            s8[i]  = iSAR(NULL, tf7, Step, Maximum, i / (tf7 / Period()));
            s9[i]  = iSAR(NULL, tf8, Step, Maximum, i / (tf8 / Period()));
            //============================================================
            if((s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i] && s9[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] < Close[i] && s9[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] < Close[i] && s8[i] > Close[i] && s9[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] < Close[i] && s7[i] > Close[i] && s8[i] > Close[i] && s9[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] < Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i] && s9[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i] && s9[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i] && s9[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i] && s9[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i] && s9[i] > Close[i]))
            {
                bearish[i] = s1[i] + 5 * Point;//       SELL__SELL__SELL
                AlertDn(s1[i]);
             }
            //-----
            if((s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i] && s9[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] > Close[i] && s9[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] > Close[i] && s8[i] < Close[i] && s9[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] > Close[i] && s7[i] < Close[i] && s8[i] < Close[i] && s9[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] > Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i] && s9[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i] && s9[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i] && s9[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i] && s9[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i] && s9[i] < Close[i])) 
             {
               bullish[i] =  s1[i] - 5 * Point;//      BUY___BUY___BUY
               AlertUp(s1[i]);
             } 
          }
         //-end TF9
      
      
      //-start TF8
          else if(sar2 == true && sar3 == true && sar4 == true && sar5 == true && sar6 == true && sar7 == true && sar8 == true && sar9 == false)
          {
            Comment(Period(), " ON", "\n", tf1, " ON", "\n", tf2, " ON", "\n", tf3, " ON", "\n", tf4, " ON", "\n", tf5, " ON", "\n", tf6, " ON", "\n", tf7, " ON", "\n", tf8, " OFF", "\n", "All close");
            s1[i]  = iSAR(NULL, Period(), Step, Maximum, i);
            s2[i]  = iSAR(NULL, tf1, Step, Maximum, i / (tf1 / Period()));
            s3[i]  = iSAR(NULL, tf2, Step, Maximum, i / (tf2 / Period()));
            s4[i]  = iSAR(NULL, tf3, Step, Maximum, i / (tf3 / Period()));
            s5[i]  = iSAR(NULL, tf4, Step, Maximum, i / (tf4 / Period()));
            s6[i]  = iSAR(NULL, tf5, Step, Maximum, i / (tf5 / Period()));
            s7[i]  = iSAR(NULL, tf6, Step, Maximum, i / (tf6 / Period()));
            s8[i]  = iSAR(NULL, tf7, Step, Maximum, i / (tf7 / Period()));
            //============================================================
            if((s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] < Close[i] && s8[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] < Close[i] && s7[i] > Close[i] && s8[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] < Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i] && s8[i] > Close[i]))
           {
                bearish[i] = s1[i] + 5 * Point;//       SELL__SELL__SELL
                AlertDn(s1[i]);
             }
            //-----
            if((s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] > Close[i] && s8[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] > Close[i] && s7[i] < Close[i] && s8[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] > Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i] && s8[i] < Close[i])) 
            {
               bullish[i] =  s1[i] - 5 * Point;//      BUY___BUY___BUY
               AlertUp(s1[i]);
             } 
          }
         //-end TF8
      
         //-start TF7
          else if(sar2 == true && sar3 == true && sar4 == true && sar5 == true && sar6 == true && sar7 == true)
          {
            Comment(Period(), " ON", "\n", tf1, " ON", "\n", tf2, " ON", "\n", tf3, " ON", "\n", tf4, " ON", "\n", tf5, " ON", "\n", tf6, " ON", "\n", tf7, " OFF", "\n", tf8, " OFF", "\n", "All close");
            s1[i]  = iSAR(NULL, Period(), Step, Maximum, i);
            s2[i]  = iSAR(NULL, tf1, Step, Maximum, i / (tf1 / Period()));
            s3[i]  = iSAR(NULL, tf2, Step, Maximum, i / (tf2 / Period()));
            s4[i]  = iSAR(NULL, tf3, Step, Maximum, i / (tf3 / Period()));
            s5[i]  = iSAR(NULL, tf4, Step, Maximum, i / (tf4 / Period()));
            s6[i]  = iSAR(NULL, tf5, Step, Maximum, i / (tf5 / Period()));
            s7[i]  = iSAR(NULL, tf6, Step, Maximum, i / (tf6 / Period()));
            //============================================================
            if((s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] < Close[i] && s7[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] < Close[i] && s6[i] > Close[i] && s7[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i] && s7[i] > Close[i]))
            {
                bearish[i] = s1[i] + 5 * Point;//       SELL__SELL__SELL
                AlertDn(s1[i]);
             }
            //-----
            if((s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] > Close[i] && s7[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] > Close[i] && s6[i] < Close[i] && s7[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i] && s7[i] < Close[i]))
             {
               bullish[i] =  s1[i] - 5 * Point;//      BUY___BUY___BUY
               AlertUp(s1[i]);
             } 
          }
         //-end TF7
         
         //-start TF6
          else if(sar2 == true && sar3 == true && sar4 == true && sar5 == true && sar6 == true && sar7 == false)
          {
           Comment(Period(), " ON", "\n", tf1, " ON", "\n", tf2, " ON", "\n", tf3, " ON", "\n", tf4, " ON", "\n", tf5, " ON", "\n", tf6, " OFF", "\n", tf7, " OFF", "\n", tf8, " OFF", "\n", "All close");
            s1[i]  = iSAR(NULL, Period(), Step, Maximum, i);
            s2[i]  = iSAR(NULL, tf1, Step, Maximum, i / (tf1 / Period()));
            s3[i]  = iSAR(NULL, tf2, Step, Maximum, i / (tf2 / Period()));
            s4[i]  = iSAR(NULL, tf3, Step, Maximum, i / (tf3 / Period()));
            s5[i]  = iSAR(NULL, tf4, Step, Maximum, i / (tf4 / Period()));
            s6[i]  = iSAR(NULL, tf5, Step, Maximum, i / (tf5 / Period()));
            //============================================================
            if((s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] < Close[i] && s6[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] > Close[i] && s6[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i] && s6[i] > Close[i]))
           {
                bearish[i] = s1[i] + 10 * Point;//       SELL__SELL__SELL
                AlertDn(s1[i]);
             }
            //-----
            if((s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] > Close[i] && s6[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] < Close[i] && s6[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i] && s6[i] < Close[i]))
             {
               bullish[i] =  s1[i] - 10 * Point;//      BUY___BUY___BUY
               AlertUp(s1[i]);
             } 
          }
         //-end TF6
         
         
         
         //-start TF5
          else if(sar2 == true && sar3 == true && sar4 == true && sar5 == true && sar6 == false && sar7 == false)
          {
            Comment(Period(), " ON", "\n", tf1, " ON", "\n", tf2, " ON", "\n", tf3, " ON", "\n", tf4, " ON", "\n", tf5, " OFF", "\n", tf6, " OFF", "\n", tf7, " OFF", "\n", tf8, " OFF", "\n", "All close");
            s1[i]  = iSAR(NULL, Period(), Step, Maximum, i);
            s2[i]  = iSAR(NULL, tf1, Step, Maximum, i / (tf1 / Period()));
            s3[i]  = iSAR(NULL, tf2, Step, Maximum, i / (tf2 / Period()));
            s4[i]  = iSAR(NULL, tf3, Step, Maximum, i / (tf3 / Period()));
            s5[i]  = iSAR(NULL, tf4, Step, Maximum, i / (tf4 / Period()));
             
            //============================================================
            if(
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i] && s5[i] > Close[i]))
           {
                bearish[i] = s1[i] + 5 * Point;//       SELL__SELL__SELL
                AlertDn(s1[i]);
             }
            //-----
            if(
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] > Close[i] && s5[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] < Close[i] && s5[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i] && s5[i] < Close[i]))
             {
               bullish[i] =  s1[i] - 5 * Point;//      BUY___BUY___BUY
               AlertUp(s1[i]);
             } 
          }
         //-end TF5
         //===============================================         __________________________________________________   sar1  &  sar2  &  sar3  & sar4
        else if(sar2 == true && sar3 == true && sar4 == true)
          {
            Comment(Period(), " ON", "\n", tf1, " ON", "\n", tf2, " ON", "\n", tf3, " ON", "\n", tf4, " OFF", "\n", tf5, " OFF", "\n", tf6, " OFF", "\n", tf7, " OFF", "\n", tf8, " OFF", "\n", "All close");
            s1[i]  = iSAR(NULL, Period(), Step, Maximum, i);
            s2[i]  = iSAR(NULL, tf1, Step, Maximum, i / (tf1 / Period()));
            s3[i]  = iSAR(NULL, tf2, Step, Maximum, i / (tf2 / Period()));
            s4[i]  = iSAR(NULL, tf3, Step, Maximum, i / (tf3 / Period()));
            //============================================================
            if((s1[i] > Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] > Close[i]) || 
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] > Close[i] && s4[i] > Close[i]))
             {
                bearish[i] = s1[i] + 5 * Point;//       SELL__SELL__SELL
                AlertDn(s1[i]);
             }
            //-----
            if((s1[i] < Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] < Close[i] && s3[i] > Close[i] && s4[i] < Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] < Close[i] && s4[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] < Close[i] && s4[i] < Close[i]))
             {
               bullish[i] =  s1[i] - 5 * Point;//      BUY___BUY___BUY
               AlertUp(s1[i]);
             } 
          }
          //===============================================         __________________________________________________   sar1  &  sar2  &  sar3 
         else if(sar2 == true && sar3 == true && sar4 == false)
          {     
            Comment(Period(), " ON", "\n", tf1, " ON", "\n", tf2, " ON", "\n", tf3, " OFF", "\n", tf4, " OFF", "\n", tf5, " OFF", "\n", tf6, " OFF", "\n", tf7, " OFF", "\n", tf8, " OFF", "\n", "All close");
            s1[i]  = iSAR(NULL, Period(), Step, Maximum, i);
            s2[i]  = iSAR(NULL, tf1, Step, Maximum, i / (tf1 / Period()));
            s3[i]  = iSAR(NULL, tf2, Step, Maximum, i / (tf2 / Period()));
            //============================================================
            if((s1[i] > Close[i] && s2[i] > Close[i] && s3[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] > Close[i]) || 
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] > Close[i]))
             {
               bearish[i] = s1[i] + 5 * Point;//       SELL__SELL__SELL
               AlertDn(s1[i]);
             }
            //-----
            if((s1[i] < Close[i] && s2[i] < Close[i] && s3[i] > Close[i]) ||
               (s1[i] < Close[i] && s2[i] > Close[i] && s3[i] < Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i] && s3[i] < Close[i]))
             {
               bullish[i] =  s1[i] - 5 * Point;//      BUY___BUY___BUY
               AlertUp(s1[i]);
             } 
          }
         //===============================================          __________________________________________________   sar1  &  sar2
         else if(sar2 == true && sar3 == false && sar4 == false)
          {     
            Comment(Period(), " ON", "\n", tf1, " ON", "\n", tf2, " OFF", "\n", tf3, " OFF", "\n", tf4, " OFF", "\n", tf5, " OFF", "\n", tf6, " OFF", "\n", tf7, " OFF", "\n", tf8, " OFF", "\n", "All close");
            s1[i]  = iSAR(NULL, Period(), Step, Maximum, i);
            s2[i]  = iSAR(NULL, tf1, Step, Maximum, i / (tf1 / Period()));
            //============================================================
            if((s1[i] > Close[i] && s2[i] < Close[i]) || 
               (s1[i] < Close[i] && s2[i] > Close[i]))
             {
               bearish[i] = s1[i] + 5 * Point;//       SELL__SELL__SELL
               AlertDn(s1[i]);
             }
            //-----
            if((s1[i] < Close[i] && s2[i] > Close[i]) ||
               (s1[i] > Close[i] && s2[i] < Close[i]))
             {
               bullish[i] =  s1[i] - 5 * Point;//      BUY___BUY___BUY
               AlertUp(s1[i]);
             }
          }
         //===============================================          __________________________________________________   sar1
         else if(sar2 == false && sar3 == false && sar4 == false)
          {
            Comment(Period(), " ON", "\n", tf1, " OFF", "\n", tf2, " OFF", "\n", tf3, " OFF", "\n", tf4, " OFF", "\n", tf5, " OFF", "\n", tf6, " OFF", "\n", tf7, " OFF", "\n", tf8, " OFF", "\n", "All close");
            s1[i]  = iSAR(NULL, Period(), Step, Maximum, i);
            //============================================================
            if(s1[i] > Close[i])
             {
               bearish[i] = s1[i] + 5 * Point;//       SELL__SELL__SELL
               AlertDn(s1[i]);
             }
            //----- 
            if(s1[i] < Close[i])
             {
               bullish[i] =  s1[i] - 5 * Point;//      BUY___BUY___BUY
               AlertUp(s1[i]);
             }
          }        
    }  
   //==============================================================================================================================================
   return(0);
 }

