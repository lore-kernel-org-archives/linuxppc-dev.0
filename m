Message-ID: <37CD8C4B.43C595EE@broadlink.com>
Date: Wed, 01 Sep 1999 13:27:55 -0700
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: GLIBC wont compile for MPC860
References: <19990831003953.707A564E@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Graham Stoney wrote:
> 
> Scott Wood writes:
> > The MPC8xx have no floating point, so it should be compiled with -msoft-float,
> > (I think)...  ./configure --without-fp  will do it.
> 
> Is this implied when gcc has been configured --with-cpu=860?

I don't think so...  I put -msoft-float into the sysdeps/powerpc/Makefile and I see
it twice below, so I would imagine that if you use both flags then -msoft-float
will be used.

I am using YellowDog Linux now and instead of an 'internal compiler error',
I get:

make[1]: Entering directory `/usr/src/redhat/SOURCES/glibc-2.1.1/math'
gcc ../sysdeps/powerpc/s_isnan.c -c -Wall -Winline -Wstrict-prototypes -Wwrite-strings -mcpu=860 -msoft-float   -fpic
-msoft-float   -Wno-uninitialized -Wno-write-strings  -I../include -I.  -I.. -I../libio  -I../sysdeps/powerpc/elf
-I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman
-I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/powerpc -I../sysdeps/wordsize-32
-I../sysdeps/ieee754 -I../sysdeps/libm-ieee754 -I../sysdeps/generic/elf -I../sysdeps/generic    -include
../include/libc-symbols.h  -DPIC   -D__NO_MATH_INLINES -D__LIBC_INTERNAL_MATH_INLINES -DNO_LONG_DOUBLE -D_Mlong_double_=double -o
s_isnan.os
../sysdeps/powerpc/s_isnan.c: In function `__isnan':
../sysdeps/powerpc/s_isnan.c:32: fixed or forbidden register 32 (0) was spilled for class FLOAT_REGS.
This may be due to a compiler bug or to impossible asm
statements or clauses.
make[1]: *** [s_isnan.os] Error 1

I haven't even got a PowerPC 750 native build to work yet (even
though I ran configure with the --disable-time and --disable-db2 options).  Any
idea how I can exclude db2 (and other unnecessary things like locale and nis) 
support so I can get a (c)lean build?  

I have been able to run many static binaries compiled for the 750 with
--msoft-float on the MPC850 just fine, although snmpd and dhcpd segfault.  The
glibc should work as well if it doesn't do hardware floating point, but it doesn't
seem to compile without it.

-Scott

> 
> Thanks,
> Graham

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
