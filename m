Date: Tue, 28 Dec 1999 17:05:39 -0500
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org, libc-alpha@cygnus.com
Subject: Re: DB_THREAD support in Berkeley DB/glibc
Message-ID: <19991228170539.A18218@drow.res.cmu.edu>
References: <jk@espy.org> <199912281902.OAA25964@mal-ach.watson.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
In-Reply-To: <199912281902.OAA25964@mal-ach.watson.ibm.com>; from dje@watson.ibm.com on Tue, Dec 28, 1999 at 02:02:03PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii

I'm fixing this up right now...  From what I could see, the tsl_t is a
char but this accesses it as a long; dare I just assume that struct
alignment will do the right thing?  My current code conditionally sets
tsl_t to an unsigned long on powerpc, via sysdeps.

And no, UNSET is not sufficient, from what I can tell - at least on
SMP.

I used sync at both ends, by analogy to the mutexes for linuxthreads;
is this wrong/unnecessary?

Does this implementation look right?  I'm away from my powerpc at the
moment, so I haven't even been able to verify that it compiles.


On Tue, Dec 28, 1999 at 02:02:03PM -0500, David Edelsohn wrote:
> 
> +/*
> + * PowerPC spinlock, adapted from the Alpha and m68k ones by dhd@debian.org
> + *
> + * For gcc/powerpc, 0 is clear, 1 is set (but *tsl will always be 0 since it's a char)
> + */
> +#define TSL_SET(tsl) ({						\
> +	register tsl_t *__l = (tsl);					\
> +	register tsl_t __r1;						\
> +	__asm__ volatile("						\n\
> +	   10: lwarx  %0,0,%1						\n\
> +	       cmpwi  %0,0						\n\
> +	       bne+   20f						\n\
> +	       stwcx. %2,0,%1						\n\
> +	       bne-   10b						\n\
> +	   20: "							\
> +	  : "=&r" (__r1)						\
> +	  : "r" (__l), "r" (-1) : "cr0", "memory");			\
> +	!__r1;								\
> +})
> +
> +#define	TSL_UNSET(tsl)	(*(tsl) = 0)
> +#define	TSL_INIT(tsl)	TSL_UNSET(tsl)
> 
> 	The TSL_SET macro is basically correct for PowerPC uniprocessor,
> but it is not MP safe.  For cases where this needs to be safe across a
> multiprocessor complex, it should be preceded by a "sync" instruction and
> ended with an "isync" instruction, or something similar depending on the
> semantics one uses for accessing the word.
> 
> 	It is not clear to me why the TSL_UNSET macro is sufficient.


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mydb2.diff"

diff -uNr db2.orig/config.h db2/config.h
--- db2.orig/config.h	Tue Jun  9 11:02:06 1998
+++ db2/config.h	Tue Dec 28 15:52:12 1999
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
 
diff -uNr db2.orig/db_int.h db2/db_int.h
--- db2.orig/db_int.h	Mon Aug 31 11:57:53 1998
+++ db2/db_int.h	Tue Dec 28 15:55:05 1999
@@ -153,8 +153,11 @@
 /*******************************************************
  * Mutex support.
  *******************************************************/
+#ifdef SPINLOCK_TYPE
+typedef SPINLOCK_TYPE tsl_t;
+#else
 typedef unsigned char tsl_t;
-
+#endif
 
 
 /*
@@ -165,7 +168,10 @@
  * region.  This ensures the alignment is as returned by mmap(2), which should
  * be sufficient.  All other mutex users must ensure proper alignment locally.
  */
+
+#ifndef MUTEX_ALIGNMENT
 #define	MUTEX_ALIGNMENT	1
+#endif
 
 /*
  * The offset of a mutex in memory.
diff -uNr db2.orig/mutex/alpha.gcc db2/mutex/alpha.gcc
--- db2.orig/mutex/alpha.gcc	Wed Aug 27 15:32:54 1997
+++ db2/mutex/alpha.gcc	Tue Dec 28 15:52:12 1999
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
diff -uNr db2.orig/mutex/mutex.c db2/mutex/mutex.c
--- db2.orig/mutex/mutex.c	Tue Jun  9 11:04:35 1998
+++ db2/mutex/mutex.c	Tue Dec 28 15:52:12 1999
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
diff -uNr db2.orig/mutex/powerpc.gcc db2/mutex/powerpc.gcc
--- db2.orig/mutex/powerpc.gcc	Wed Dec 31 19:00:00 1969
+++ db2/mutex/powerpc.gcc	Tue Dec 28 16:57:31 1999
@@ -0,0 +1,31 @@
+/*
+ * PowerPC spinlock, adapted from the Alpha and m68k ones by dhd@debian.org
+ * and dan@debian.org.
+ *
+ * For gcc/powerpc, 0 is clear, 1 is set.
+ */
+#define TSL_SET(tsl) ({							\
+	register tsl_t *__l = (tsl);					\
+	register tsl_t __r1;						\
+	__asm__ volatile("						\n\
+	       sync							\n\
+	   10: lwarx  %0,0,%1						\n\
+	       cmpwi  %0,0						\n\
+	       bne+   20f						\n\
+	       stwcx. %2,0,%1						\n\
+	       bne-   10b						\n\
+	       sync							\n\
+	   20: "							\
+	  : "=&r" (__r1)						\
+	  : "r" (__l), "r" (1) : "cr0", "memory");			\
+	!__r1;								\
+})
+
+#define TSL_UNSET(tsl) ({						\
+	register tsl_t *__l = (tsl);					\
+	__asm__ __volatile__("						\n\
+		sync							\n\
+		stw	%1, %0" : "=&r" (__l) : "r" (0));		\
+	})
+
+#define	TSL_INIT(tsl)	TSL_UNSET(tsl)
diff -uNr sysdeps/powerpc.orig/Makefile sysdeps/powerpc/Makefile
--- sysdeps/powerpc.orig/Makefile	Tue Dec 28 15:50:56 1999
+++ sysdeps/powerpc/Makefile	Tue Dec 28 15:53:01 1999
@@ -25,6 +25,10 @@
 CFLAGS-gmon-start.o = -G0
 endif
 
+ifeq ($(subdir),db2)
+CPPFLAGS += -DHAVE_SPINLOCKS=1 -DHAVE_ASSEM_POWERPC_GCC=1 -DSPINLOCK_TYPE='unsigned long' -DMUTEX_ALIGNMENT=4
+endif
+
 ifeq ($(subdir),string)
 CFLAGS-memcmp.c += -Wno-uninitialized
 endif
diff -uNr sysdeps/alpha.orig/Makefile sysdeps/alpha/Makefile
--- sysdeps/alpha.orig/Makefile	Tue Dec 28 15:50:56 1999
+++ sysdeps/alpha/Makefile	Tue Dec 28 15:52:12 1999
@@ -34,6 +34,10 @@
 CFLAGS-rtld.c = -mbuild-constants
 endif
 
+ifeq ($(subdir),db2)
+CPPFLAGS += -DHAVE_SPINLOCKS=1 -DHAVE_ASSEM_ALPHA_GCC=1 -DMUTEX_ALIGNMENT=4
+endif
+
 divrem := divl divq reml remq
 
 # For now, build everything with full IEEE math support.

--n8g4imXOkfNTN/H1--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
