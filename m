Message-ID: <382B5CCB.8FB26DD8@brightstareng.com>
Date: Thu, 11 Nov 1999 19:18:19 -0500
From: Stuart Adams <sja@brightstareng.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
CC: Dan Malek <dan@netx4.com>, reekes@kerbango.com
Subject: Re: does soft-float work?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We saw similar problems and found that there was a compiler
bug which emitted bad code when using varargs to pass doubles.

This only occurred when using -mcpu=8xx not with -msoft-float.

For example the following code did not work with egcs-1.1 when using
-mcpu=8xx

------
  #include <stdarg.h>

  double d = 500.0;

  vtst(char *fmt, ...) {
   double z;
   va_list ap;
   va_start(ap,fmt);
   z = va_arg(ap,double);
   printf("vatst=%d\n",(int)z);  // should print 500
 }


 main() {
   vtst("jj",d);
 }
------

I have not tried gcc 2.95.X so the bug may have been fixed.

The problem with printf is that libc was probably compiled with
-mcpu=8xx with a version of gcc with this bug. (libc/printf uses varags
to pass doubles internally) We recompiled libc with -msoft-float
and now things work fine.

-- Stuart

------------------------------------- 

Stuart Adams
Bright Star Engineering Inc.
19 Enfield Drive
Andover MA 01810 USA
Tel: +1-978-470-8738
Fax: +1-978-470-8878
Email: sja@brightstareng.com
Web: http://www.brightstareng.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
