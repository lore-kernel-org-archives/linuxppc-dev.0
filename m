Message-Id: <5.1.0.14.0.20010815184517.00ab30c0@spudcentral.com>
Date: Wed, 15 Aug 2001 20:35:41 -0600
To: linuxppc-embedded@lists.linuxppc.org
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: cross compiling 8xx glibc on x86
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks,

I've spend two days scouring the postings here and read much as I can find on cross compiling
glibc with no fpu options. I've read all kinds of things, compiled for hours, but nothing.  I've been somewhat unsuccessful,  I'm close to giving up but that's why I'm writing.

I can compile glibc-2.2.3 (no mention of no fpu on configure) but bash segment
faults (actually init respawns to fast). I can get bash running if I use the montavista compiled glibc* from their rpm. So I know that my kernel/filesystem works etc. But still I want to compile glibc for 8xx myself.

Here's my configure line

SRCFILELOC=/root/cross/
BUILDLOC=/root/cross/builds
PREFIX=/usr
ARCH=ppc
TARGET=powerpc-linux

CC=$TARGET-gcc CFLAGS="-msoft-float -D_SOFT_FLOAT -mcpu=860" \
../$GLIBVERSION/configure $TARGET --build=i586-linux \
                                  --prefix=$PREFIX/$TARGET \
                                  --enable-add-ons \
                                  -without-fp

I get this error (I'm not the first one with this error,
http://lists.linuxppc.org/linuxppc-embedded/200106/msg00178.html)

powerpc-linux-gcc -msoft-float ../sysdeps/powerpc/fclrexcpt.c -c -O2 -Wall -Winline -Wstrict-prototypes -Wwrite-strings -g -mnew-mnemonics -Wa,-mppc -mpowerpc   -fpic   -Wno-uninitialized  -I../include -I. -I/root/cross/builds/powerpc-linux-glibc/math -I.. -I../libio  -I/root/cross/builds/powerpc-linux-glibc -I../sysdeps/powerpc/elf -I../linuxthreads/sysdeps/unix/sysv/linux -I../linuxthreads/sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/powerpc -I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/powerpc -I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/powerpc -I../sysdeps/wordsize-32 -I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 -I../sysdeps/powerpc/soft-fp -I../sysdeps/ieee754 -I../sysdeps/generic/elf -I../sysdeps/generic   -D_LIBC_REENTRANT -include ../include/l!
ibc-symbols.h  -DPIC -DSHARED   -I../soft-fp/ -D__NO_MATH_INLINES -D__LIBC_INTERNAL_MATH_INLINES -DNO_LONG_DOUBLE -D_Mlong_double_=double -o /root/cross/builds/powerpc-linux-glibc/math/fclrexcpt.os
../sysdeps/powerpc/fclrexcpt.c:20: fenv_libc.h: No such file or directory

I fooled around a bit trying to pass the Ipath to gcc for fenv_libc.h. But didn't figure that out.

I then tried compiling the montavista glibc source but get errors because I don't know which of the  10 patches to apply. I've tried using compiled libs from debian but bash seg faults ( I guess because debian glibc is compiled with fpu).

That's when I figured I should write and ask these questions.

Has anyone cross compiled glibc2.2.3 successfully for the 8xx (no fpu)?
Did you use the GNU source or did you use the MontaVista source?
If you use the MontaVista source, which patches did you apply and in what order?
What's your configure line?
Once you got glibc compiled, how did you check the fpu operation? Printing pi or what?


I'm at a loss. Any ideas? I'm stuck and would really like some suggestions.

Thanks for any help.
Craig




___________________________________________________________
Dr. Craig Hollabaugh                           craig@hollabaugh.com
304 6th Avenue, P.O. Box 1405
Ouray, CO 81427-1405                       See my "kitchen sink" resume at
970 325 0319 home                                  www.hollabaugh.com/resume.html
970 325 0509 office
215 882 1880 cell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
