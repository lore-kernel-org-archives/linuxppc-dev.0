Message-Id: <4.2.0.37.19990512114944.0370d030@mail.lauterbach.com>
Date: Wed, 12 May 1999 12:21:33 +0200
To: Richard Henderson <rth@cygnus.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems
Cc: law@cygnus.com, egcs-patches@egcs.cygnus.com, meissner@cygnus.com,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990511234842.A26784@cygnus.com>
References: <6498.926489993@upchuck.cygnus.com>
 <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>
 <6498.926489993@upchuck.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 08:48 12.05.99 , Richard Henderson wrote:
>On Wed, May 12, 1999 at 12:19:53AM -0600, Jeffrey A Law wrote:
> > Has this problem been fixed?  I see patch from Richard which looks like it
> > is related:
>
>No, this is a different, though related, problem.  I need to sit
>down with the ABI to properly evaluate the patch.  PPC SVR4 varargs
>seems needlessly complex.

To me it looked more like some 95%-finished stuff with untested corner cases.

>Franz, could you point me at the test cases for this?

Oops, sure. I meant them to attach to my last mail, which contained my new 
patch fixing both problems below.

Thanks again for your expand_builtin_saveregs() patch, it makes life a lot 
easier on PPC :-).

Franz.

-----< testcase1
/* this testcase is a modified testcase from execute/980608-1.c.
    It additionally tests the handling of float args. The varargs
    handling on SYSV ABI contained a bug where using more than 8 float
    args before all GP regs were consumed caused a wrong stack/register
    layout to be passed by the caller. The overflowed (not fitting in FP
    registers) float args virtually consumed args fitting in GP regs (counted
    by cum->words).
    This was uncovered in real world by gnuplot.
*/

#include <stdarg.h>

static int test=23;

void f1(int a1,int a2,int a3,int a4,int a5, int a6,int a7,int a8,int a9,
         int a10)
{
        test = a9;
        return;
}

inline void debug(const char *fp,const char *msg,...)
{
        int local_var[10] = {10,};
        va_list ap;
        double df;

        local_var[0] += test;

        if (*fp != '1')
              abort();
        if (*msg != '2')
              abort();
        f1(1,2,3,4,5,6,7,8,9,local_var[0]);

        va_start( ap, msg );

        df = va_arg(ap,double);
        if (df <1.09 || df >1.11)
              abort();
        df = va_arg(ap,double);
        if (df <1.19 || df >1.21)
              abort();
        df = va_arg(ap,double);
        if (df <1.29 || df >1.31)
              abort();
        df = va_arg(ap,double);
        if (df <1.39 || df >1.41)
              abort();
        df = va_arg(ap,double);
        if (df <1.49 || df >1.51)
              abort();
        if ( *va_arg(ap,char*) != '3')
              abort();
        if ( *va_arg(ap,char*) != '4')
              abort();
        if ( *va_arg(ap,char*) != '5')
              abort();
        df = va_arg(ap,double);
        if (df <1.59 || df >1.61)
              abort();
        df = va_arg(ap,double);
        if (df <1.69 || df >1.71)
              abort();
        df = va_arg(ap,double);
        if (df <1.79 || df >1.81)
              abort();
        df = va_arg(ap,double);
        if (df <1.89 || df >1.91)
              abort();
        if ( va_arg(ap,int) != 101)
              abort();
        if ( va_arg(ap,int) != 102)
              abort();
        if ( va_arg(ap,int) != 103)
              abort();
        if ( va_arg(ap,int) != 104)
              abort();
        if ( *va_arg(ap,char*) != '6')
              abort();
        if ( va_arg(ap,int) != 105)
              abort();
        if ( va_arg(ap,int) != 106)
              abort();
        if ( va_arg(ap,int) != 107)
              abort();
        if ( va_arg(ap,int) != 108)
              abort();
        if ( va_arg(ap,int) != 109)
              abort();


        if ( va_arg(ap,int) != 110)
              abort();

        va_end( ap );
}

int main(void)
{
      debug("1 filepointer", "2 format", 1.1,1.2,1.3,1.4,1.5, "3","4","5", 
1.6,1.7,1.8,1.9, 101,102,103,104, "6", 105,106,107,108,109,110);
      exit(0);
}
-----< testcase1


-----< testcase2
/* Yet another bug in PPC/SYSV ABI varargs handling.
    If the float args overflowed from FP regs into stack space before the
    varargs started, the calculation of the overflow_area pointer in va_list
    was buggy.
    Not uncovered in real world (yet?), constructed by staring at the varargs
    code.
*/

#include <stdarg.h>

inline void debug2(const char *fp,
                   double d1,double d2,double d3,double d4,
                   double d5,double d6,double d7,double d8,double d9,
                   const char *msg,...)
{
        va_list ap;
        double df;

        if (*fp != '1')
              abort();
        if (*msg != '2')
              abort();

        va_start( ap, msg );

        df = va_arg(ap,double);
        if (df <1.09 || df >1.11)
              abort();
        df = va_arg(ap,double);
        if (df <1.19 || df >1.21)
              abort();
        df = va_arg(ap,double);
        if (df <1.29 || df >1.31)
              abort();
        df = va_arg(ap,double);
        if (df <1.39 || df >1.41)
              abort();
        df = va_arg(ap,double);
        if (df <1.49 || df >1.51)
              abort();
        if ( *va_arg(ap,char*) != '3')
              abort();
        if ( *va_arg(ap,char*) != '4')
              abort();
        if ( *va_arg(ap,char*) != '5')
              abort();
        df = va_arg(ap,double);
        if (df <1.59 || df >1.61)
              abort();
        df = va_arg(ap,double);
        if (df <1.69 || df >1.71)
              abort();
        df = va_arg(ap,double);
        if (df <1.79 || df >1.81)
              abort();
        df = va_arg(ap,double);
        if (df <1.89 || df >1.91)
              abort();
        if ( va_arg(ap,int) != 101)
              abort();
        if ( va_arg(ap,int) != 102)
              abort();
        if ( va_arg(ap,int) != 103)
              abort();
        if ( va_arg(ap,int) != 104)
              abort();
        if ( *va_arg(ap,char*) != '6')
              abort();
        if ( va_arg(ap,int) != 105)
              abort();
        if ( va_arg(ap,int) != 106)
              abort();
        if ( va_arg(ap,int) != 107)
              abort();
        if ( va_arg(ap,int) != 108)
              abort();
        if ( va_arg(ap,int) != 109)
              abort();


        df = va_arg(ap,double);
        if (df <1.99 || df >2.01)
              abort();

        if ( va_arg(ap,int) != 110)
              abort();

        va_end( ap );
}

int main(void)
{
      debug2("1 filepointer", 20.1,20.2,20.3,20.4,20.5,20.6,20.7,20.8,20.9, 
"2 format", 1.1,1.2,1.3,1.4,1.5, "3","4","5", 1.6,1.7,1.8,1.9, 
101,102,103,104, "6", 105,106,107,108,109, 2.0, 110);
      exit(0);
}
-----< testcase2

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
