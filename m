Message-ID: <378DB42A.56184419@switchboard.ericsson.se>
Date: Thu, 15 Jul 1999 12:12:58 +0200
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Grant Carter <gcarter@eng.uct.ac.za>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Some Cross Compiling Questions
References: <378CAFAD.32A1660D@eng.uct.ac.za>
Content-Type: multipart/mixed; boundary="------------1AB2FF6A414D21050AEFB251"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------1AB2FF6A414D21050AEFB251
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Grant Carter wrote:
> 
> Hi all
> 
> I am very new at using the GNU tools and cross compilers etc and am
> wanting to compile Linux for the RPXLite Board running a PowerPC 823. I
> have gone throught the CrossGCC FAQ as well as a document on Cross
> Development for Linux/PPC but I still have a few questions/problems
> which I hope someone can help me with please.
> 
> I am running an i386-FreeBSD system and, as I said before, am wanting to
> build a PowerPC-linux system. I have built binutils-2.9.1.0.25 and
> egcs-1.1.2 successfully and have used that to build the LinuxPPC kernel
> (2.2.5). Everything compiled fine but I want to know 2 things: I have
> read about libgcc.o and was wondering if I had to provide my own one or
> if gcc knew enough about the 823 to build its own.

To build libgcc gcc must find some of the C-library include files.
But you can't build the C-library until you have a compiler...
I don't rember exectly how I solved this as it was a long time since
I did a rebuild from scratch, but basicly you have to do a "multipass"
installation, first compile and install gcc without libgcc, then get
the necessary include files out of glibc and install them, and finally
build the rest of gcc with libgcc and such.

> Secondly, how do I
> get floating point emulation running as the 823 doesn't provide hardware
> floating point. I saw a --nfp in the configuration options - should I
> enable this?

Using --nfp and --with-cpu=823 when compiling egcs will make it generate
soft float code by default, but it will _NOT_ make _SOFT_FLOAT be defined
in the preprocessor by default, unless you hack the specs file. This caused
me great confusion as the va_* variable argument macros check for the
_SOFT_FLOAT define to know whether floating point arguments are in fp
registers or in memory. As the compiler doesn't use this define things
will get really messed up when you pass float arguments to things like
printf().

The simple solution is to _not_ use --nfp and pass -msoft-float to gcc
when compiling PPC code instead.

> Next I tried to compile both glibc which failed. The error message was
> as follows:
> 
> ../sysdeps/powerpc/s_isnan.c: In function `__isnan':
> ../sysdeps/powerpc/s_isnan.c:32: fixed or forbidden register 32 (0) was
> spilled for class FLOAT_REGS. This may be due to a compiler bug or to
> impossible asm statements or clauses.

I believe it is a compiler bug, but this file should not be used anyway
if you want to have a soft float glibc.

Note that there are two kinds of people here:
Those that (like me) want to use MPC8xx processors as purely embedded
processors, compiling all libraries and apps themselves with -msoft-float,
and only doing cross-development.
And then those that want full floating point emulation in the kernel
in order to use normal PPC binaries and libraries, and who wants to
do native development on 8xx boards.

I don't consider any method "right", it's simply matter of taste and
of the particulart application you want to use your 8xx board for.
Therefore I believe that both the kernel (I already know one person
working on full fp emulation) and glibc should allow both ways by
the means of a simple config option.

As for glibc and embedded powerpc the very least you have to do is
to move sysdeps/powerpc/memset.S out of the way and apply this diff:
diff -ur orig/glibc-2.1.1/sysdeps/powerpc/dl-machine.c glibc-2.1.1/sysdeps/powerpc/dl-machine.c
--- orig/glibc-2.1.1/sysdeps/powerpc/dl-machine.c	Fri Mar  5 23:41:23 1999
+++ glibc-2.1.1/sysdeps/powerpc/dl-machine.c	Mon May 17 20:59:06 1999
@@ -250,7 +250,11 @@
 	 PowerPC processors have line sizes of exactly 32 bytes.  */
 
       size_modified = lazy ? rel_offset_words : PLT_INITIAL_ENTRY_WORDS;
+#ifdef PPC_CACHELINESIZE_32
       for (i = 0; i < size_modified; i+= 8)
+#else
+      for (i = 0; i < size_modified; i+= 4)
+#endif
 	PPC_DCBST (plt + i);
       PPC_DCBST (plt + size_modified - 1);
       PPC_SYNC;

This will fix the infamous cache line size problem.
If you want a soft float library (incompatible with normal PPC binaries)
you need to pipe this diff though the attached script:

diff -ur orig/glibc-2.1.1/sysdeps/powerpc/Dist glibc-2.1.1/sysdeps/powerpc/Dist
--- orig/glibc-2.1.1/sysdeps/powerpc/Dist	Tue Sep 15 00:57:08 1998
+++ glibc-2.1.1/sysdeps/powerpc/Dist	Tue May  4 17:00:33 1999
@@ -1,7 +1,3 @@
 dl-machine.c
 dl-start.S
-fenv_const.c
-fenv_libc.h
 ppc-mcount.S
-fe_nomask.c
-t_sqrt.c
diff -ur orig/glibc-2.1.1/sysdeps/powerpc/Makefile glibc-2.1.1/sysdeps/powerpc/Makefile
--- orig/glibc-2.1.1/sysdeps/powerpc/Makefile	Wed Nov 18 00:48:00 1998
+++ glibc-2.1.1/sysdeps/powerpc/Makefile	Tue May  4 17:01:07 1999
@@ -1,7 +1,3 @@
-ifeq ($(subdir),math)
-libm-support += fenv_const fe_nomask t_sqrt
-endif
-
 ifeq ($(subdir),gmon)
 sysdep_routines += ppc-mcount
 endif

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se
--------------1AB2FF6A414D21050AEFB251
Content-Type: text/plain; charset=us-ascii; name="glibcpatch"
Content-Disposition: inline; filename="glibcpatch"
Content-Transfer-Encoding: 7bit

#!/bin/sh

FPUFILES="
Versions
bits/fenv.h
bits/mathdef.h
bits/mathinline.h
e_sqrt.c
e_sqrtf.c
fclrexcpt.c
fe_nomask.c
fegetenv.c
fegetround.c
feholdexcpt.c
fenv_const.c
fenv_libc.h
fesetenv.c
fesetround.c
feupdateenv.c
fgetexcptflg.c
fpu_control.h
fraiseexcpt.c
fsetexcptflg.c
ftestexcept.c
s_copysign.S
s_copysignf.S
s_fabs.S
s_fabsf.S
s_fmax.S
s_fmaxf.S
s_fmin.S
s_fminf.S
s_isnan.c
s_isnanf.S
s_lrint.c
s_lrintf.S
s_rint.c
s_rintf.c
t_sqrt.c
w_sqrt.c
w_sqrtf.c
"

FPUDISTFILES="fenv_const.c
fenv_libc.h
fe_nomask.c
t_sqrt.c
"

MAKEFILE='-ifeq ($(subdir),math)
-libm-support += fenv_const fe_nomask t_sqrt
-endif'

patch -p1

cd sysdeps/powerpc #|| exit 1
mkdir -p fpu/bits || exit 2

for a in $FPUFILES; do
  mv "$a" "fpu/$a" && echo "Moved $a -> fpu/$a"
done

fail=
for a in $FPUDISTFILES; do
  echo "$a" >> fpu/Dist || fail=1
done
test "$fail" || echo "Created fpu/Dist"

echo "$MAKEFILE" >fpu/Makefile && echo "Created fpu/Makefile"

--------------1AB2FF6A414D21050AEFB251--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
