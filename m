Mime-Version: 1.0
Message-Id: <v04220802b48ea8ff2961@[206.163.71.146]>
In-Reply-To: <19991228025900.A1950@drow.res.cmu.edu>
References: <Pine.LNX.4.10.9912262058050.21529-100000@altus.drgw.net>
 <19991228025900.A1950@drow.res.cmu.edu>
Date: Tue, 28 Dec 1999 09:53:58 -0800
To: linuxppc-dev@lists.linuxppc.org
From: Joel Klecker <jk@espy.org>
Subject: Re: DB_THREAD support in Berkeley DB/glibc
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 02:59 -0500 1999-12-28, Daniel Jacobowitz wrote:
>If I'm not mistaken, David Huggins-Daines did this recently.  It is in
>the debian packages of glibc in the latest release.

For convenience, here it is (note that this hasn't really been tested on powerpc):

diff -urN --exclude=*.info glibc-2.1.2/db2/config.h glibc-2.1.2.new/db2/config.h
--- glibc-2.1.2/db2/config.h	Tue Jun  9 11:02:06 1998
+++ glibc-2.1.2.new/db2/config.h	Tue Nov 30 21:33:33 1999
@@ -66,6 +66,12 @@
 /* Define if you want to use sparc/gcc assembly spinlocks. */
 /* #undef HAVE_ASSEM_SPARC_GCC */
 
+/* Define if you want to use alpha/gcc assembly spinlocks. */
+/* #undef HAVE_ASSEM_ALPHA_GCC */
+
+/* Define if you want to use powerpc/gcc assembly spinlocks. */
+/* #undef HAVE_ASSEM_POWERPC_GCC */
+
 /* Define if you want to use uts4/cc assembly spinlocks. */
 /* #undef HAVE_ASSEM_UTS4_CC */
 
diff -urN --exclude=*.info glibc-2.1.2/db2/mutex/alpha.gcc glibc-2.1.2.new/db2/mutex/alpha.gcc
--- glibc-2.1.2/db2/mutex/alpha.gcc	Wed Aug 27 15:32:54 1997
+++ glibc-2.1.2.new/db2/mutex/alpha.gcc	Tue Nov 30 23:09:14 1999
@@ -31,22 +31,23 @@
 	register tsl_t *__l = (tsl);					\
 	register tsl_t __r1, __r2;					\
 	__asm__ volatile("						\n\
-	   10: ldq_l %0,(%2)						\n\
+	   10: ldl_l %0,%3						\n\
 	       blbs  %0,30f						\n\
 	       or    %0,1,%1						\n\
-	       stq_c %1,(%2)						\n\
+	       stl_c %1,%2						\n\
 	       beq   %1,20f						\n\
 	       mb							\n\
 	       br    30f						\n\
 	   20: br    10b						\n\
 	   30: "							\
-	  : "=&r" (__r1), "=&r" (__r2)					\
-	  : "r" (__l));							\
+	  : "=&r" (__r1), "=&r" (__r2), "=m"(*__l)			\
+	  : "2" (*__l)							\
+	  : "memory");							\
 	!__r1;								\
 })
 
 #define TSL_UNSET(tsl) ({						\
 	register tsl_t *__l = (tsl);					\
-	__asm__ volatile("mb; stq $31,(%0);" : : "r" (__l));		\
+	__asm__ volatile("mb; stl $31,%0;" : "=m" (*__l) : : "memory");	\
 })
 #define	TSL_INIT(tsl)	TSL_UNSET(tsl)
diff -urN --exclude=*.info glibc-2.1.2/db2/mutex/mutex.c glibc-2.1.2.new/db2/mutex/mutex.c
--- glibc-2.1.2/db2/mutex/mutex.c	Tue Jun  9 11:04:35 1998
+++ glibc-2.1.2.new/db2/mutex/mutex.c	Tue Nov 30 21:33:33 1999
@@ -86,6 +86,14 @@
 #include "sparc.gcc"
 #endif
 
+#ifdef HAVE_ASSEM_ALPHA_GCC
+#include "alpha.gcc"
+#endif
+
+#ifdef HAVE_ASSEM_POWERPC_GCC
+#include "powerpc.gcc"
+#endif
+
 #ifdef HAVE_ASSEM_UTS4_CC
 #define TSL_INIT(x)
 #define TSL_SET(x)	(!uts_lock(x, 1))
diff -urN --exclude=*.info glibc-2.1.2/db2/mutex/powerpc.gcc glibc-2.1.2.new/db2/mutex/powerpc.gcc
--- glibc-2.1.2/db2/mutex/powerpc.gcc	Wed Dec 31 19:00:00 1969
+++ glibc-2.1.2.new/db2/mutex/powerpc.gcc	Tue Nov 30 22:54:56 1999
@@ -0,0 +1,22 @@
+/*
+ * PowerPC spinlock, adapted from the Alpha and m68k ones by dhd@debian.org
+ *
+ * For gcc/powerpc, 0 is clear, 1 is set (but *tsl will always be 0 since it's a char)
+ */
+#define TSL_SET(tsl) ({						\
+	register tsl_t *__l = (tsl);					\
+	register tsl_t __r1;						\
+	__asm__ volatile("						\n\
+	   10: lwarx  %0,0,%1						\n\
+	       cmpwi  %0,0						\n\
+	       bne+   20f						\n\
+	       stwcx. %2,0,%1						\n\
+	       bne-   10b						\n\
+	   20: "							\
+	  : "=&r" (__r1)						\
+	  : "r" (__l), "r" (-1) : "cr0", "memory");			\
+	!__r1;								\
+})
+
+#define	TSL_UNSET(tsl)	(*(tsl) = 0)
+#define	TSL_INIT(tsl)	TSL_UNSET(tsl)
diff -urN --exclude=*.info glibc-2.1.2/sysdeps/alpha/Makefile glibc-2.1.2.new/sysdeps/alpha/Makefile
--- glibc-2.1.2/sysdeps/alpha/Makefile	Sat Jun 27 02:50:41 1998
+++ glibc-2.1.2.new/sysdeps/alpha/Makefile	Sun Dec 12 03:36:34 1999
@@ -34,6 +34,10 @@
 CFLAGS-rtld.c = -mbuild-constants
 endif
 
+ifeq ($(subdir),db2)
+CPPFLAGS += -DHAVE_SPINLOCKS=1 -DHAVE_ASSEM_ALPHA_GCC=1 -DMUTEX_ALIGNMENT=4
+endif
+
 divrem := divl divq reml remq
 
 # For now, build everything with full IEEE math support.
diff -urN --exclude=*.info glibc-2.1.2/sysdeps/powerpc/Makefile glibc-2.1.2.new/sysdeps/powerpc/Makefile
--- glibc-2.1.2/sysdeps/powerpc/Makefile	Tue Sep  1 07:30:52 1998
+++ glibc-2.1.2.new/sysdeps/powerpc/Makefile	Sun Dec 12 03:43:15 1999
@@ -25,6 +25,10 @@
 CFLAGS-gmon-start.o = -G0
 endif
 
+ifeq ($(subdir),db2)
+CPPFLAGS += -DHAVE_SPINLOCKS=1 -DHAVE_ASSEM_POWERPC_GCC=1  -DMUTEX_ALIGNMENT=4
+endif
+
 ifeq ($(subdir),string)
 CFLAGS-memcmp.c += -Wno-uninitialized
 endif
--- glibc-2.1.2/db2/db_int.h	Mon Aug 31 11:57:53 1998
+++ glibc-2.1.2/db2/db_int.h.fixx0red	Tue Nov 30 23:47:25 1999
@@ -165,7 +165,9 @@
  * region.  This ensures the alignment is as returned by mmap(2), which should
  * be sufficient.  All other mutex users must ensure proper alignment locally.
  */
+#ifndef MUTEX_ALIGNMENT
 #define	MUTEX_ALIGNMENT	1
+#endif
 
 /*
  * The offset of a mutex in memory.

-- 
Joel Klecker (aka Espy)       <URL:mailto:espy@debian.org>
Debian Package Maintainer for the GNU C Library.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
