Message-ID: <38CF94BE.E62C4353@cray.com>
Date: Wed, 15 Mar 2000 07:48:46 -0600
From: Mike Wolf <mwolf@sgi.com>
MIME-Version: 1.0
To: embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: compiling glibc for 4xx core powerpc
References: <38CEEF3B.2665CD22@m2tech.co.nz>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ben,
  I've been hitting this problem also.  I've been working is a cross
compiling enviroment.  I found an posting from Marcus Sundberg that
outlined the problems and how to fix them.  I have included that post
at the bottom of this.

I got a patch from Wolfgang Denk.  He also has a site that talks about
what needs to be done. http://www.denx.de/solutions-en.html

 The patch is here:
-----------------------------------------------------------------------------
--- dl-machine.c.ORIG   Fri Mar  5 00:26:43 1999
+++ dl-machine.c        Sat Nov  6 14:33:47 1999
@@ -250,7 +250,11 @@
         PowerPC processors have line sizes of exactly 32 bytes.  */

       size_modified = lazy ? rel_offset_words :
PLT_INITIAL_ENTRY_WORDS;
+#ifdef PPC_CACHELINESIZE_32
       for (i = 0; i < size_modified; i+= 8)
+#else
+      for (i = 0; i < size_modified; i+= 4)
+#endif
        PPC_DCBST (plt + i);
       PPC_DCBST (plt + size_modified - 1);
       PPC_SYNC;

-----------------------------------------------------------------------------
--- Dist.ORIG   Mon Sep 14 18:37:37 1998
+++ Dist        Sat Nov  6 14:35:45 1999
@@ -1,7 +1,3 @@
 dl-machine.c
 dl-start.S
-fenv_const.c
-fenv_libc.h
 ppc-mcount.S
-fe_nomask.c
-t_sqrt.c

-----------------------------------------------------------------------------
--- Makefile.ORIG       Tue Sep  1 16:30:52 1998
+++ Makefile    Sat Nov  6 14:39:22 1999
@@ -1,7 +1,3 @@
-ifeq ($(subdir),math)
-libm-support += fenv_const fe_nomask t_sqrt
-endif
-
 ifeq ($(subdir),gmon)
 sysdep_routines += ppc-mcount
 endif


I applied that patch from the glibc/sysdeps/powerpc directory.  Then
I ran the following script.  I tried to run the one Marcus had in his
email, but it is bash specific and I am running under IRIX.

#!/bin/ksh
echo "mv bits/fenv.h bits/mathdef.h bits/mathinline.h fpu/bits"

mv bits/fenv.h bits/mathdef.h bits/mathinline.h fpu/bits

echo "mv Versions e_sqrt.c e_sqrtf.c fclrexcpt.c fe_nomask.c fegetenv.c
fegetround.c feholdexcpt.c fenv_const.c fenv_libc.h fesetenv.c
fesetround.c feupdateenv.c fgetexcptflg.c fpu_control.h fraiseexcpt.c
fsetexcptflg.c ftestexcept.c s_copysign.S s_copysignf.S s_fabs.S
s_fabsf.S s_fmax.S s_fmaxf.S s_fmin.S s_fminf.S s_isnan.c s_isnanf.S
s_lrint.c s_lrintf.S s_rint.c s_rintf.c t_sqrt.c w_sqrt.c w_sqrtf.c fpu"

mv Versions e_sqrt.c e_sqrtf.c fclrexcpt.c fe_nomask.c fegetenv.c
fegetround.c feholdexcpt.c fenv_const.c fenv_libc.h fesetenv.c
fesetround.c feupdateenv.c fgetexcptflg.c fpu_control.h fraiseexcpt.c
fsetexcptflg.c ftestexcept.c s_copysign.S s_copysignf.S s_fabs.S
s_fabsf.S s_fmax.S s_fmaxf.S s_fmin.S s_fminf.S s_isnan.c s_isnanf.S
s_lrint.c s_lrintf.S s_rint.c s_rintf.c t_sqrt.c w_sqrt.c w_sqrtf.c fpu

echo "cat fpu/fenv_libc.h fpu/fe_nomask.c fpu/t_sqrt.c >> fpu/Dist"
cat fpu/fenv_libc.h fpu/fe_nomask.c fpu/t_sqrt.c >> fpu/Dist

echo "ifeq ($(subdir),math)\nlibm-support += fenv_const fe_nomask
t_sqrt\nendif\n" > fpu/Makefile
echo "Created fpu/Makefile"


Then I configured and compiled and it compiled up fine.  I havent gotten
a chance to test it yet.

Following is the post from Marcus:
Hi,

first note the "Reply To" - we have a new list, so why not use it.

Scott Wood wrote:
&gt;
&gt; Graham Stoney wrote:
&gt; &gt;
&gt; &gt; Scott Wood writes:
&gt; &gt; &gt; The MPC8xx have no floating point, so it should be
compiled with -msoft-float,
&gt; &gt; &gt; (I think)...  ./configure --without-fp  will do it.
&gt; &gt;
&gt; &gt; Is this implied when gcc has been configured --with-cpu=860?

Configuring gcc with --with-cpu=860 and --nfp will make the
_compiler_ default to -msoft-float. It will however _not_ make the
pre-processor define -D_SOFT_FLOAT by default, which will cause
all variable arguments functions taking floating point arguments
(like the *print[fs] family) to be mis-compiled.

The fix is to add this code to your gcc's 'specs' file under the
section '*cpp_sysv':
%{!mhard-float: -D_SOFT_FLOAT}

Likewise, passing -mcpu=860 to gcc will imply -msoft-float, but
not -D_SOFT_FLOAT. So either fix your specs file or always
explicitly pass -msoft-float to gcc.

&gt; I don't think so...  I put -msoft-float into the
sysdeps/powerpc/Makefile and I see
&gt; it twice below, so I would imagine that if you use both flags then
-msoft-float
&gt; will be used.
&gt;
&gt; I am using YellowDog Linux now and instead of an 'internal compiler
error',
&gt; I get:
&gt;
&gt; make[1]: Entering directory
`/usr/src/redhat/SOURCES/glibc-2.1.1/math'
&gt; gcc ../sysdeps/powerpc/s_isnan.c -c -Wall -Winline
-Wstrict-prototypes -Wwrite-strings -mcpu=860 -msoft-float   -fpic
&gt; -msoft-float   -Wno-uninitialized -Wno-write-strings  -I../include
-I.  -I.. -I../libio  -I../sysdeps/powerpc/elf
&gt; -I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux
-I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman
&gt; -I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix
-I../sysdeps/posix -I../sysdeps/powerpc -I../sysdeps/wordsize-32
&gt; -I../sysdeps/ieee754 -I../sysdeps/libm-ieee754
-I../sysdeps/generic/elf -I../sysdeps/generic    -include
&gt; ../include/libc-symbols.h  -DPIC   -D__NO_MATH_INLINES
-D__LIBC_INTERNAL_MATH_INLINES -DNO_LONG_DOUBLE -D_Mlong_double_=double
-o
&gt; s_isnan.os
&gt; ../sysdeps/powerpc/s_isnan.c: In function `__isnan':
&gt; ../sysdeps/powerpc/s_isnan.c:32: fixed or forbidden register 32 (0)
was spilled for class FLOAT_REGS.
&gt; This may be due to a compiler bug or to impossible asm
&gt; statements or clauses.
&gt; make[1]: *** [s_isnan.os] Error 1

Ok, here's how to build glibc for embedded PPC:

First you must remove the assumption that cachelines are 32 bytes:
Apply this diff, and simply move sysdeps/powerpc/memset.S out of the
way for now:

diff -ur orig/glibc-2.1.1/sysdeps/powerpc/dl-machine.c
glibc-2.1.1/sysdeps/powerpc/dl-machine.c
--- orig/glibc-2.1.1/sysdeps/powerpc/dl-machine.c       Fri Mar  5
23:41:23 1999
+++ glibc-2.1.1/sysdeps/powerpc/dl-machine.c    Mon May 17 20:59:06 1999
@@ -250,7 +250,11 @@
         PowerPC processors have line sizes of exactly 32 bytes.  */

       size_modified = lazy ? rel_offset_words :
PLT_INITIAL_ENTRY_WORDS;
+#ifdef PPC_CACHELINESIZE_32
       for (i = 0; i &lt; size_modified; i+= 8)
+#else
+      for (i = 0; i &lt; size_modified; i+= 4)
+#endif
        PPC_DCBST (plt + i);
       PPC_DCBST (plt + size_modified - 1);
       PPC_SYNC;

(The ifdef is bogus - PPC_CACHELINESIZE_32 is actually never defined,
and this should really be handled runtime anyway. The problem is that
reading the PVR is a supervisor level operation for some stupid reason,
and afaik there is no other way to find out what the line size is.
My vote is to have a special sysctl entry for the cacheline size,
for fast and easy access (one syscall compared to the
open()/read()/close()
triplet for normal /proc entries, and you also don't have to have the
/proc fs mounted), and then cache the result in a static variable.)

Secondly you will want to remove the floating point assembler.
This is done by piping the following diff into the attached script
(with sysdeps/powerpc as your cwd):

diff -ur orig/glibc-2.1.1/sysdeps/powerpc/Dist
glibc-2.1.1/sysdeps/powerpc/Dist
--- orig/glibc-2.1.1/sysdeps/powerpc/Dist       Tue Sep 15 00:57:08 1998
+++ glibc-2.1.1/sysdeps/powerpc/Dist    Tue May  4 17:00:33 1999
@@ -1,7 +1,3 @@
 dl-machine.c
 dl-start.S
-fenv_const.c
<A NAME="hilite"><B>-fenv_libc.h
</B></A> ppc-mcount.S
-fe_nomask.c
-t_sqrt.c
diff -ur orig/glibc-2.1.1/sysdeps/powerpc/Makefile
glibc-2.1.1/sysdeps/powerpc/Makefile
--- orig/glibc-2.1.1/sysdeps/powerpc/Makefile   Wed Nov 18 00:48:00 1998
+++ glibc-2.1.1/sysdeps/powerpc/Makefile        Tue May  4 17:01:07 1999
@@ -1,7 +1,3 @@
-ifeq ($(subdir),math)
-libm-support += fenv_const fe_nomask t_sqrt
-endif
-
 ifeq ($(subdir),gmon)
 sysdep_routines += ppc-mcount
 endif

Now you can simply configure glibc with --without-fp and build it.
It is possible that some of the more advanced stuff in the math
library will not work - I get warnings about fe_* functions being
stubs, but as I have no idea of what a "floating point environment"
is or how to implement it when using soft floats it's nothing I can
do about it. Most programs work fine here.

//Marcus
--
-------------------------------+------------------------------------
        Marcus Sundberg        | <A
HREF="http://www.stacken.kth.se/~mackan/">http://www.stacken.kth.se/~mackan/</A>
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se</PRE>
<PRE>
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
  mv "$a" "fpu/$a" &amp;&amp; echo "Moved $a -&gt; fpu/$a"
done

fail=
for a in $FPUDISTFILES; do
  echo "$a" &gt;&gt; fpu/Dist || fail=1
done
test "$fail" || echo "Created fpu/Dist"

Hi,

first note the "Reply To" - we have a new list, so why not use it.

Scott Wood wrote:
&gt;
&gt; Graham Stoney wrote:
&gt; &gt;
&gt; &gt; Scott Wood writes:
&gt; &gt; &gt; The MPC8xx have no floating point, so it should be
compiled with -msoft-float,
&gt; &gt; &gt; (I think)...  ./configure --without-fp  will do it.
&gt; &gt;
&gt; &gt; Is this implied when gcc has been configured --with-cpu=860?

Configuring gcc with --with-cpu=860 and --nfp will make the
_compiler_ default to -msoft-float. It will however _not_ make the
pre-processor define -D_SOFT_FLOAT by default, which will cause
all variable arguments functions taking floating point arguments
(like the *print[fs] family) to be mis-compiled.

The fix is to add this code to your gcc's 'specs' file under the
section '*cpp_sysv':
%{!mhard-float: -D_SOFT_FLOAT}

Likewise, passing -mcpu=860 to gcc will imply -msoft-float, but
not -D_SOFT_FLOAT. So either fix your specs file or always
explicitly pass -msoft-float to gcc.

&gt; I don't think so...  I put -msoft-float into the
sysdeps/powerpc/Makefile and I see
&gt; it twice below, so I would imagine that if you use both flags then
-msoft-float
&gt; will be used.
&gt;
&gt; I am using YellowDog Linux now and instead of an 'internal compiler
error',
&gt; I get:
&gt;
&gt; make[1]: Entering directory
`/usr/src/redhat/SOURCES/glibc-2.1.1/math'
&gt; gcc ../sysdeps/powerpc/s_isnan.c -c -Wall -Winline
-Wstrict-prototypes -Wwrite-strings -mcpu=860 -msoft-float   -fpic
&gt; -msoft-float   -Wno-uninitialized -Wno-write-strings  -I../include
-I.  -I.. -I../libio  -I../sysdeps/powerpc/elf
&gt; -I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux
-I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman
&gt; -I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix
-I../sysdeps/posix -I../sysdeps/powerpc -I../sysdeps/wordsize-32
&gt; -I../sysdeps/ieee754 -I../sysdeps/libm-ieee754
-I../sysdeps/generic/elf -I../sysdeps/generic    -include
&gt; ../include/libc-symbols.h  -DPIC   -D__NO_MATH_INLINES
-D__LIBC_INTERNAL_MATH_INLINES -DNO_LONG_DOUBLE -D_Mlong_double_=double
-o
&gt; s_isnan.os
&gt; ../sysdeps/powerpc/s_isnan.c: In function `__isnan':
&gt; ../sysdeps/powerpc/s_isnan.c:32: fixed or forbidden register 32 (0)
was spilled for class FLOAT_REGS.
&gt; This may be due to a compiler bug or to impossible asm
&gt; statements or clauses.
&gt; make[1]: *** [s_isnan.os] Error 1

Ok, here's how to build glibc for embedded PPC:

First you must remove the assumption that cachelines are 32 bytes:
Apply this diff, and simply move sysdeps/powerpc/memset.S out of the
way for now:

diff -ur orig/glibc-2.1.1/sysdeps/powerpc/dl-machine.c
glibc-2.1.1/sysdeps/powerpc/dl-machine.c
--- orig/glibc-2.1.1/sysdeps/powerpc/dl-machine.c       Fri Mar  5
23:41:23 1999
+++ glibc-2.1.1/sysdeps/powerpc/dl-machine.c    Mon May 17 20:59:06 1999
@@ -250,7 +250,11 @@
         PowerPC processors have line sizes of exactly 32 bytes.  */

       size_modified = lazy ? rel_offset_words :
PLT_INITIAL_ENTRY_WORDS;
+#ifdef PPC_CACHELINESIZE_32
       for (i = 0; i &lt; size_modified; i+= 8)
+#else
+      for (i = 0; i &lt; size_modified; i+= 4)
+#endif
        PPC_DCBST (plt + i);
       PPC_DCBST (plt + size_modified - 1);
       PPC_SYNC;

(The ifdef is bogus - PPC_CACHELINESIZE_32 is actually never defined,
and this should really be handled runtime anyway. The problem is that
reading the PVR is a supervisor level operation for some stupid reason,
and afaik there is no other way to find out what the line size is.
My vote is to have a special sysctl entry for the cacheline size,
for fast and easy access (one syscall compared to the
open()/read()/close()
triplet for normal /proc entries, and you also don't have to have the
/proc fs mounted), and then cache the result in a static variable.)

Secondly you will want to remove the floating point assembler.
This is done by piping the following diff into the attached script
(with sysdeps/powerpc as your cwd):

diff -ur orig/glibc-2.1.1/sysdeps/powerpc/Dist
glibc-2.1.1/sysdeps/powerpc/Dist
--- orig/glibc-2.1.1/sysdeps/powerpc/Dist       Tue Sep 15 00:57:08 1998
+++ glibc-2.1.1/sysdeps/powerpc/Dist    Tue May  4 17:00:33 1999
@@ -1,7 +1,3 @@
 dl-machine.c
 dl-start.S
-fenv_const.c
<A NAME="hilite"><B>-fenv_libc.h
</B></A> ppc-mcount.S
-fe_nomask.c
-t_sqrt.c
diff -ur orig/glibc-2.1.1/sysdeps/powerpc/Makefile
glibc-2.1.1/sysdeps/powerpc/Makefile
--- orig/glibc-2.1.1/sysdeps/powerpc/Makefile   Wed Nov 18 00:48:00 1998
+++ glibc-2.1.1/sysdeps/powerpc/Makefile        Tue May  4 17:01:07 1999
@@ -1,7 +1,3 @@
-ifeq ($(subdir),math)
-libm-support += fenv_const fe_nomask t_sqrt
-endif
-
 ifeq ($(subdir),gmon)
 sysdep_routines += ppc-mcount
 endif

Now you can simply configure glibc with --without-fp and build it.
It is possible that some of the more advanced stuff in the math
library will not work - I get warnings about fe_* functions being
stubs, but as I have no idea of what a "floating point environment"
is or how to implement it when using soft floats it's nothing I can
do about it. Most programs work fine here.

//Marcus
--
-------------------------------+------------------------------------
        Marcus Sundberg        | <A
HREF="http://www.stacken.kth.se/~mackan/">http://www.stacken.kth.se/~mackan/</A>
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se</PRE>
<PRE>
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
  mv "$a" "fpu/$a" &amp;&amp; echo "Moved $a -&gt; fpu/$a"
done

fail=
for a in $FPUDISTFILES; do
  echo "$a" &gt;&gt; fpu/Dist || fail=1
done
test "$fail" || echo "Created fpu/Dist"

echo "$MAKEFILE" &gt;fpu/Makefile &amp;&ampecho "$MAKEFILE"
&gt;fpu/Makefile &amp;&amp; echo "Created fpu/Makefile"

--
Mike Wolf
Cray Research
655-F Lone Oak Drive, Eagan, MN 55121
mwolf@cray.com          (651)683-5313

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
