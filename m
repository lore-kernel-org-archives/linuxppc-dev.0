To: Stuart Adams <sja@brightstareng.com>
Cc: linuxppc-embedded@lists.linuxppc.org, Dan Malek <dan@netx4.com>,
        reekes@kerbango.com
Subject: Re: does soft-float work?
References: <382B5CCB.8FB26DD8@brightstareng.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 19 Nov 1999 18:10:35 +0100
In-Reply-To: Stuart Adams's message of "Thu, 11 Nov 1999 19:18:19 -0500"
Message-ID: <kfybt8q4dbo.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stuart Adams <sja@brightstareng.com> writes:

> We saw similar problems and found that there was a compiler
> bug which emitted bad code when using varargs to pass doubles.
> 
> This only occurred when using -mcpu=8xx not with -msoft-float.
> 
> For example the following code did not work with egcs-1.1 when using
> -mcpu=8xx
> 
> ------
>   #include <stdarg.h>
> 
>   double d = 500.0;
> 
>   vtst(char *fmt, ...) {
>    double z;
>    va_list ap;
>    va_start(ap,fmt);
>    z = va_arg(ap,double);
>    printf("vatst=%d\n",(int)z);  // should print 500
>  }
> 
> 
>  main() {
>    vtst("jj",d);
>  }
> ------
> 
> I have not tried gcc 2.95.X so the bug may have been fixed.

Not fixed as of 2.95.1 at least.

> The problem with printf is that libc was probably compiled with
> -mcpu=8xx with a version of gcc with this bug. (libc/printf uses varags
> to pass doubles internally) We recompiled libc with -msoft-float
> and now things work fine.

The bug is in the installed specs file that gcc uses, not in the
compiler itself. See my other mail for details.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
