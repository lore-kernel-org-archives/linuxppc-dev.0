Message-ID: <3BB25339.41537A8B@opensource.se>
Date: Thu, 27 Sep 2001 00:14:17 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Cindy Peters <cinpet@adaptivemicro.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compiling standard utilities for MPC823
References: <41EDEC3C1B88D51186EB00A0C9CFADF702FA88@AMWMAIL>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you're cross-compiling applications that use autoconf "configure"
scripts, you will need to set some variables to override tests that
configure is unable to perform when you're cross-compiling.

Here are some mpc8xx-specific variables:

ac_cv_c_cross=yes
ac_cv_c_bigendian=yes
ac_cv_c_char_unsigned=no
ac_cv_sizeof_long_long=8
ac_cv_sizeof_long=4
ac_cv_sizeof_int=4
ac_cv_sizeof_short=2
ac_cv_sizeof_unsigned_long=4
ac_cv_sizeof_unsigned_int=4

..and some other ones if you use glibc-2.1.3:

ac_cv_header_stdc=yes
ac_cv_func_closedir_void=no
ac_cv_func_setvbuf_reversed=no
ac_cv_func_getpgrp_void=yes
ac_cv_func_setpgrp_void=yes
ac_cv_func_mmap=yes
ac_cv_func_setpgrp_void=yes
ac_cv_func_strcoll_works=yes
ac_cv_func_vfork=yes
ac_cv_func_wait3_rusage=yes
ac_cv_sys_restartable_syscalls=yes

The variables above will make it possible to cross-compile
fileutils-4.1. Other packages (bash, readline) might need
more variables, but if you read the configure-file, you
will figure out what is missing.

Or, you can take the blue pill and go the RPM-way ... ;)

Cheers  /

magnus


opensource.se - custom linux distributions

Cindy Peters wrote:
>
> I am attempting to cross-compile the file utilities that I downloaded from
> the linuxppc ftp site for the MPC823 on an x86 PC running Redhat 6.2. I am
> getting an error when configure is trying to determine the byte ordering.
> Following is a clip from the config.log file.
>
> configure:2220: checking whether byte ordering is bigendian
> configure:2242: powerpc-linux-gcc -c -g -O2  conftest.c >&5
> configure: In function `main':
> configure:2236: `bogus' undeclared (first use in this function)
> configure:2236: (Each undeclared identifier is reported only once
> configure:2236: for each function it appears in.)
> configure:2236: parse error before `endian'
> configure: failed program was:
> #line 2228 "configure"
> #include "confdefs.h"
> #include <sys/types.h>
> #include <sys/param.h>
>
> int
> main ()
> {
> #if !BYTE_ORDER || !BIG_ENDIAN || !LITTLE_ENDIAN
>  bogus endian macros
> #endif
>
>   ;
>   return 0;
> }
>
> I have tried defining BIG_ENDIAN and BYTE_ORDERING but that is not helping.
> Can someone tell me what I need to do to successfully cross-compile this?
> Here is the command line I am using.
>
> AR=powerpc-linux-ar AS=powerpc-linux-as LD=powerpc-linux-ld \
>   RANLIB=powerpc-linux-ranlib CC=powerpc-linux-gcc NM=powerpc-linux-nm \
>   ./configure --build=i686-pc-linux-gnu --host=powerpc-unknown-linux-gnu \
>   --target=powerpc-unknown-linux-gnu \
>         --prefix=/opt/usr/local/powerpc-linux
>
> Thanks,
>
> Cindy Peters
> Adaptive Micro-Ware, Inc.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
