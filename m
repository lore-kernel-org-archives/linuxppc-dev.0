Message-ID: <3777360C.2FFDC3CC@switchboard.ericsson.se>
Date: Mon, 28 Jun 1999 10:45:00 +0200
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: kd@flaga.is
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Glibc 2.1 and MPC 8xx
References: <0025679B.003F3EB4.00@notes.flaga.is>
Content-Type: multipart/mixed; boundary="------------9826E5650AE8436130839BE8"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------9826E5650AE8436130839BE8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

kd@flaga.is wrote:
> 
> Hello,
> 
> Thanks to Wolfgang Denk and Leif Lindholm regarding my problems with the
> interrupt vectors.
> I examined even better what was happening and it is probably a faulty
> device driver causing the strange crasses.
> At least the application is always running in the driver when it
> crashes......... So a stupid user error 8-).
> 
> Anyway I am now trying to get the system to run on a self contained
> Glibc2.1 system that will eventually be running from
> flash. I have a lot of applications crassing all over. I believe it is due
> to the cache size assumption made in Glibc2.1 that so many have mentioned
> in the past few weeks. Does any one have a quick-hack-patch for fixing this
> before I start to hack up a
> code I do not understand the least 8-)? Are there any other known problems
> with Glibc 2.1?

Apply this diff, and simply move sysdeps/powerpc/memset.S out of the
way for now:

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

This did the trick for me.

If you want to use soft floats (you will have to compile all libraries
and programs with -msoft-float) you should pipe this diff into the
attached script (standing in sysdeps/powerpc):

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

There was also a PPC linker bug mentioned on the glibc list a while
ago, which was said to be fixed in CVS, but I haven't checked this out
yet as I have enough trouble debugging kernel problems right now.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se
--------------9826E5650AE8436130839BE8
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

--------------9826E5650AE8436130839BE8--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
