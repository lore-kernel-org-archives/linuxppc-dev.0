Return-Path: <bgill@freescale.com>
Date: Thu, 22 Sep 2005 14:20:04 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509221417380.612@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] powerpc: merge atomic.h, memory.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Merge atomic.h and memory.h into powerpc

Merged atomic.h into include/powerpc.  Moved asm-style HMT_ defines from
memory.h into ppc_asm.h, where there were already HMT_defines; moved c-style
HMT_ defines to processor.h. Renamed memory.h to synch.h to better reflect
its contents.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Jon Loeliger <linuxppc@jdl.com>

---
commit ab08c88845ac6e755db2ef806c36d1e469ef4180
tree 628c01b9dcfff035603ac372fe86fe6946ec15e2
parent 1124b50f3b383405d5737663e2445171fa5828fb
author Becky Bruce <becky.bruce@freescale.com> Thu, 22 Sep 2005 14:15:15 -0500
committer Becky Bruce <becky.bruce@freescale.com> Thu, 22 Sep 2005 14:15:15 -0500

 include/asm-powerpc/atomic.h  |  209 ++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/auxvec.h  |    2 
 include/asm-powerpc/ppc_asm.h |    3 +
 include/asm-powerpc/synch.h   |   51 ++++++++++
 include/asm-ppc/atomic.h      |  214 -----------------------------------------
 include/asm-ppc/io.h          |   11 --
 include/asm-ppc64/atomic.h    |  197 --------------------------------------
 include/asm-ppc64/bitops.h    |    2 
 include/asm-ppc64/futex.h     |    2 
 include/asm-ppc64/io.h        |    2 
 include/asm-ppc64/memory.h    |   61 ------------
 include/asm-ppc64/processor.h |    8 ++
 include/asm-ppc64/system.h    |    4 -
 13 files changed, 279 insertions(+), 487 deletions(-)

diff --git a/include/asm-powerpc/atomic.h b/include/asm-powerpc/atomic.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/atomic.h
@@ -0,0 +1,209 @@
+#ifndef _ASM_POWERPC_ATOMIC_H_
+#define _ASM_POWERPC_ATOMIC_H_
+
+/*
+ * PowerPC atomic operations
+ */
+
+typedef struct { volatile int counter; } atomic_t;
+
+#ifdef __KERNEL__
+#include <asm/synch.h>
+
+#define ATOMIC_INIT(i)		{ (i) }
+
+#define atomic_read(v)		((v)->counter)
+#define atomic_set(v,i)		(((v)->counter) = (i))
+
+/* Erratum #77 on the 405 means we need a sync or dcbt before every stwcx.
+ * The old ATOMIC_SYNC_FIX covered some but not all of this.
+ */
+#ifdef CONFIG_IBM405_ERR77
+#define PPC405_ERR77(ra,rb)	"dcbt " #ra "," #rb ";"
+#else
+#define PPC405_ERR77(ra,rb)
+#endif
+
+static __inline__ void atomic_add(int a, atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%3		# atomic_add\n\
+	add	%0,%2,%0\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
+	bne-	1b"
+	: "=&r" (t), "=m" (v->counter)
+	: "r" (a), "r" (&v->counter), "m" (v->counter)
+	: "cc");
+}
+
+static __inline__ int atomic_add_return(int a, atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+	EIEIO_ON_SMP
+"1:	lwarx	%0,0,%2		# atomic_add_return\n\
+	add	%0,%1,%0\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%2 \n\
+	bne-	1b"
+	ISYNC_ON_SMP
+	: "=&r" (t)
+	: "r" (a), "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
+
+static __inline__ void atomic_sub(int a, atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%3		# atomic_sub\n\
+	subf	%0,%2,%0\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%0,0,%3 \n\
+	bne-	1b"
+	: "=&r" (t), "=m" (v->counter)
+	: "r" (a), "r" (&v->counter), "m" (v->counter)
+	: "cc");
+}
+
+static __inline__ int atomic_sub_return(int a, atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+	EIEIO_ON_SMP
+"1:	lwarx	%0,0,%2		# atomic_sub_return\n\
+	subf	%0,%1,%0\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%2 \n\
+	bne-	1b"
+	ISYNC_ON_SMP
+	: "=&r" (t)
+	: "r" (a), "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+static __inline__ void atomic_inc(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2		# atomic_inc\n\
+	addic	%0,%0,1\n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%0,0,%2 \n\
+	bne-	1b"
+	: "=&r" (t), "=m" (v->counter)
+	: "r" (&v->counter), "m" (v->counter)
+	: "cc");
+}
+
+static __inline__ int atomic_inc_return(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+	EIEIO_ON_SMP
+"1:	lwarx	%0,0,%1		# atomic_inc_return\n\
+	addic	%0,%0,1\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1 \n\
+	bne-	1b"
+	ISYNC_ON_SMP
+	: "=&r" (t)
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
+static __inline__ void atomic_dec(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+"1:	lwarx	%0,0,%2		# atomic_dec\n\
+	addic	%0,%0,-1\n"
+	PPC405_ERR77(0,%2)\
+"	stwcx.	%0,0,%2\n\
+	bne-	1b"
+	: "=&r" (t), "=m" (v->counter)
+	: "r" (&v->counter), "m" (v->counter)
+	: "cc");
+}
+
+static __inline__ int atomic_dec_return(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+	EIEIO_ON_SMP
+"1:	lwarx	%0,0,%1		# atomic_dec_return\n\
+	addic	%0,%0,-1\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1\n\
+	bne-	1b"
+	ISYNC_ON_SMP
+	: "=&r" (t)
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+#define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
+#define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
+
+/*
+ * Atomically test *v and decrement if it is greater than 0.
+ * The function returns the old value of *v minus 1.
+ */
+static __inline__ int atomic_dec_if_positive(atomic_t *v)
+{
+	int t;
+
+	__asm__ __volatile__(
+	EIEIO_ON_SMP
+"1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
+	addic.	%0,%0,-1\n\
+	blt-	2f\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1\n\
+	bne-	1b"
+	ISYNC_ON_SMP
+	"\n\
+2:"	: "=&r" (t)
+	: "r" (&v->counter)
+	: "cc", "memory");
+
+	return t;
+}
+
+#define smp_mb__before_atomic_dec()     smp_mb()
+#define smp_mb__after_atomic_dec()      smp_mb()
+#define smp_mb__before_atomic_inc()     smp_mb()
+#define smp_mb__after_atomic_inc()      smp_mb()
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_ATOMIC_H_ */
diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -75,8 +75,11 @@
 #define REST_32EVRS(n,s,base)	REST_16EVRS(n,s,base); REST_16EVRS(n+16,s,base)
 
 /* Macros to adjust thread priority for Iseries hardware multithreading */
+#define HMT_VERY_LOW    or   31,31,31	# very low priority\n"
 #define HMT_LOW		or 1,1,1
+#define HMT_MEDIUM_LOW  or   6,6,6	# medium low priority\n"
 #define HMT_MEDIUM	or 2,2,2
+#define HMT_MEDIUM_HIGH or   5,5,5	# medium high priority\n"
 #define HMT_HIGH	or 3,3,3
 
 /* handle instructions that older assemblers may not know */
diff --git a/include/asm-powerpc/synch.h b/include/asm-powerpc/synch.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/synch.h
@@ -0,0 +1,51 @@
+#ifndef _ASM_POWERPC_SYNCH_H 
+#define _ASM_POWERPC_SYNCH_H 
+
+#include <linux/config.h>
+
+#ifdef __powerpc64__
+#define __SUBARCH_HAS_LWSYNC
+#endif
+
+#ifdef __SUBARCH_HAS_LWSYNC
+#    define LWSYNC	lwsync
+#else
+#    define LWSYNC	sync
+#endif
+
+
+/*
+ * Arguably the bitops and *xchg operations don't imply any memory barrier
+ * or SMP ordering, but in fact a lot of drivers expect them to imply
+ * both, since they do on x86 cpus.
+ */
+#ifdef CONFIG_SMP
+#define EIEIO_ON_SMP	"eieio\n"
+#define ISYNC_ON_SMP	"\n\tisync"
+#define SYNC_ON_SMP	__stringify(LWSYNC) "\n"
+#else
+#define EIEIO_ON_SMP
+#define ISYNC_ON_SMP
+#define SYNC_ON_SMP
+#endif
+
+static inline void eieio(void)
+{
+	__asm__ __volatile__ ("eieio" : : : "memory");
+}
+
+static inline void isync(void)
+{
+	__asm__ __volatile__ ("isync" : : : "memory");
+}
+
+#ifdef CONFIG_SMP
+#define eieio_on_smp()	eieio()
+#define isync_on_smp()	isync()
+#else
+#define eieio_on_smp()	__asm__ __volatile__("": : :"memory")
+#define isync_on_smp()	__asm__ __volatile__("": : :"memory")
+#endif
+
+#endif	/* _ASM_POWERPC_SYNCH_H */
+
diff --git a/include/asm-ppc/atomic.h b/include/asm-ppc/atomic.h
deleted file mode 100644
--- a/include/asm-ppc/atomic.h
+++ /dev/null
@@ -1,214 +0,0 @@
-/*
- * PowerPC atomic operations
- */
-
-#ifndef _ASM_PPC_ATOMIC_H_
-#define _ASM_PPC_ATOMIC_H_
-
-typedef struct { volatile int counter; } atomic_t;
-
-#ifdef __KERNEL__
-
-#define ATOMIC_INIT(i)	{ (i) }
-
-#define atomic_read(v)		((v)->counter)
-#define atomic_set(v,i)		(((v)->counter) = (i))
-
-extern void atomic_clear_mask(unsigned long mask, unsigned long *addr);
-
-#ifdef CONFIG_SMP
-#define SMP_SYNC	"sync"
-#define SMP_ISYNC	"\n\tisync"
-#else
-#define SMP_SYNC	""
-#define SMP_ISYNC
-#endif
-
-/* Erratum #77 on the 405 means we need a sync or dcbt before every stwcx.
- * The old ATOMIC_SYNC_FIX covered some but not all of this.
- */
-#ifdef CONFIG_IBM405_ERR77
-#define PPC405_ERR77(ra,rb)	"dcbt " #ra "," #rb ";"
-#else
-#define PPC405_ERR77(ra,rb)
-#endif
-
-static __inline__ void atomic_add(int a, atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%3		# atomic_add\n\
-	add	%0,%2,%0\n"
-	PPC405_ERR77(0,%3)
-"	stwcx.	%0,0,%3 \n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (a), "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_add_return(int a, atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_add_return\n\
-	add	%0,%1,%0\n"
-	PPC405_ERR77(0,%2)
-"	stwcx.	%0,0,%2 \n\
-	bne-	1b"
-	SMP_ISYNC
-	: "=&r" (t)
-	: "r" (a), "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
-
-static __inline__ void atomic_sub(int a, atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%3		# atomic_sub\n\
-	subf	%0,%2,%0\n"
-	PPC405_ERR77(0,%3)
-"	stwcx.	%0,0,%3 \n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (a), "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_sub_return(int a, atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_sub_return\n\
-	subf	%0,%1,%0\n"
-	PPC405_ERR77(0,%2)
-"	stwcx.	%0,0,%2 \n\
-	bne-	1b"
-	SMP_ISYNC
-	: "=&r" (t)
-	: "r" (a), "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-static __inline__ void atomic_inc(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_inc\n\
-	addic	%0,%0,1\n"
-	PPC405_ERR77(0,%2)
-"	stwcx.	%0,0,%2 \n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_inc_return(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%1		# atomic_inc_return\n\
-	addic	%0,%0,1\n"
-	PPC405_ERR77(0,%1)
-"	stwcx.	%0,0,%1 \n\
-	bne-	1b"
-	SMP_ISYNC
-	: "=&r" (t)
-	: "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-/*
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
-
-static __inline__ void atomic_dec(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_dec\n\
-	addic	%0,%0,-1\n"
-	PPC405_ERR77(0,%2)\
-"	stwcx.	%0,0,%2\n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_dec_return(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%1		# atomic_dec_return\n\
-	addic	%0,%0,-1\n"
-	PPC405_ERR77(0,%1)
-"	stwcx.	%0,0,%1\n\
-	bne-	1b"
-	SMP_ISYNC
-	: "=&r" (t)
-	: "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-#define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
-#define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
-
-/*
- * Atomically test *v and decrement if it is greater than 0.
- * The function returns the old value of *v minus 1.
- */
-static __inline__ int atomic_dec_if_positive(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
-	addic.	%0,%0,-1\n\
-	blt-	2f\n"
-	PPC405_ERR77(0,%1)
-"	stwcx.	%0,0,%1\n\
-	bne-	1b"
-	SMP_ISYNC
-	"\n\
-2:"	: "=&r" (t)
-	: "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-#define __MB	__asm__ __volatile__ (SMP_SYNC : : : "memory")
-#define smp_mb__before_atomic_dec()	__MB
-#define smp_mb__after_atomic_dec()	__MB
-#define smp_mb__before_atomic_inc()	__MB
-#define smp_mb__after_atomic_inc()	__MB
-
-#endif /* __KERNEL__ */
-#endif /* _ASM_PPC_ATOMIC_H_ */
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -8,6 +8,7 @@
 
 #include <asm/page.h>
 #include <asm/byteorder.h>
+#include <asm/synch.h>
 #include <asm/mmu.h>
 
 #define SIO_CONFIG_RA	0x398
@@ -440,16 +441,6 @@ extern inline void * phys_to_virt(unsign
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 #define page_to_bus(page)	(page_to_phys(page) + PCI_DRAM_OFFSET)
 
-/*
- * Enforce In-order Execution of I/O:
- * Acts as a barrier to ensure all previous I/O accesses have
- * completed before any further ones are issued.
- */
-extern inline void eieio(void)
-{
-	__asm__ __volatile__ ("eieio" : : : "memory");
-}
-
 /* Enforce in-order execution of data I/O.
  * No distinction between read/write on PPC; use eieio for all three.
  */
diff --git a/include/asm-ppc64/atomic.h b/include/asm-ppc64/atomic.h
deleted file mode 100644
--- a/include/asm-ppc64/atomic.h
+++ /dev/null
@@ -1,197 +0,0 @@
-/*
- * PowerPC64 atomic operations
- *
- * Copyright (C) 2001 Paul Mackerras <paulus@au.ibm.com>, IBM
- * Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _ASM_PPC64_ATOMIC_H_ 
-#define _ASM_PPC64_ATOMIC_H_
-
-#include <asm/memory.h>
-
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	{ (i) }
-
-#define atomic_read(v)		((v)->counter)
-#define atomic_set(v,i)		(((v)->counter) = (i))
-
-static __inline__ void atomic_add(int a, atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%3		# atomic_add\n\
-	add	%0,%2,%0\n\
-	stwcx.	%0,0,%3\n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (a), "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_add_return(int a, atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-	EIEIO_ON_SMP
-"1:	lwarx	%0,0,%2		# atomic_add_return\n\
-	add	%0,%1,%0\n\
-	stwcx.	%0,0,%2\n\
-	bne-	1b"
-	ISYNC_ON_SMP
-	: "=&r" (t)
-	: "r" (a), "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
-
-static __inline__ void atomic_sub(int a, atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%3		# atomic_sub\n\
-	subf	%0,%2,%0\n\
-	stwcx.	%0,0,%3\n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (a), "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_sub_return(int a, atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-	EIEIO_ON_SMP
-"1:	lwarx	%0,0,%2		# atomic_sub_return\n\
-	subf	%0,%1,%0\n\
-	stwcx.	%0,0,%2\n\
-	bne-	1b"
-	ISYNC_ON_SMP
-	: "=&r" (t)
-	: "r" (a), "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-static __inline__ void atomic_inc(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_inc\n\
-	addic	%0,%0,1\n\
-	stwcx.	%0,0,%2\n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_inc_return(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-	EIEIO_ON_SMP
-"1:	lwarx	%0,0,%1		# atomic_inc_return\n\
-	addic	%0,%0,1\n\
-	stwcx.	%0,0,%1\n\
-	bne-	1b"
-	ISYNC_ON_SMP
-	: "=&r" (t)
-	: "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-/*
- * atomic_inc_and_test - increment and test
- * @v: pointer of type atomic_t
- *
- * Atomically increments @v by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
-
-static __inline__ void atomic_dec(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-"1:	lwarx	%0,0,%2		# atomic_dec\n\
-	addic	%0,%0,-1\n\
-	stwcx.	%0,0,%2\n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_dec_return(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-	EIEIO_ON_SMP
-"1:	lwarx	%0,0,%1		# atomic_dec_return\n\
-	addic	%0,%0,-1\n\
-	stwcx.	%0,0,%1\n\
-	bne-	1b"
-	ISYNC_ON_SMP
-	: "=&r" (t)
-	: "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-#define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
-#define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
-
-/*
- * Atomically test *v and decrement if it is greater than 0.
- * The function returns the old value of *v minus 1.
- */
-static __inline__ int atomic_dec_if_positive(atomic_t *v)
-{
-	int t;
-
-	__asm__ __volatile__(
-	EIEIO_ON_SMP
-"1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
-	addic.	%0,%0,-1\n\
-	blt-	2f\n\
-	stwcx.	%0,0,%1\n\
-	bne-	1b"
-	ISYNC_ON_SMP
-	"\n\
-2:"	: "=&r" (t)
-	: "r" (&v->counter)
-	: "cc", "memory");
-
-	return t;
-}
-
-#define smp_mb__before_atomic_dec()     smp_mb()
-#define smp_mb__after_atomic_dec()      smp_mb()
-#define smp_mb__before_atomic_inc()     smp_mb()
-#define smp_mb__after_atomic_inc()      smp_mb()
-
-#endif /* _ASM_PPC64_ATOMIC_H_ */
diff --git a/include/asm-ppc64/bitops.h b/include/asm-ppc64/bitops.h
--- a/include/asm-ppc64/bitops.h
+++ b/include/asm-ppc64/bitops.h
@@ -42,7 +42,7 @@
 
 #ifdef __KERNEL__
 
-#include <asm/memory.h>
+#include <asm/synch.h>
 
 /*
  * clear_bit doesn't imply a memory barrier
diff --git a/include/asm-ppc64/futex.h b/include/asm-ppc64/futex.h
--- a/include/asm-ppc64/futex.h
+++ b/include/asm-ppc64/futex.h
@@ -5,7 +5,7 @@
 
 #include <linux/futex.h>
 #include <asm/errno.h>
-#include <asm/memory.h>
+#include <asm/synch.h>
 #include <asm/uaccess.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
diff --git a/include/asm-ppc64/io.h b/include/asm-ppc64/io.h
--- a/include/asm-ppc64/io.h
+++ b/include/asm-ppc64/io.h
@@ -15,7 +15,7 @@
 #ifdef CONFIG_PPC_ISERIES 
 #include <asm/iSeries/iSeries_io.h>
 #endif  
-#include <asm/memory.h>
+#include <asm/synch.h>
 #include <asm/delay.h>
 
 #include <asm-generic/iomap.h>
diff --git a/include/asm-ppc64/memory.h b/include/asm-ppc64/memory.h
deleted file mode 100644
--- a/include/asm-ppc64/memory.h
+++ /dev/null
@@ -1,61 +0,0 @@
-#ifndef _ASM_PPC64_MEMORY_H_ 
-#define _ASM_PPC64_MEMORY_H_ 
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/config.h>
-
-/*
- * Arguably the bitops and *xchg operations don't imply any memory barrier
- * or SMP ordering, but in fact a lot of drivers expect them to imply
- * both, since they do on x86 cpus.
- */
-#ifdef CONFIG_SMP
-#define EIEIO_ON_SMP	"eieio\n"
-#define ISYNC_ON_SMP	"\n\tisync"
-#define SYNC_ON_SMP	"lwsync\n\t"
-#else
-#define EIEIO_ON_SMP
-#define ISYNC_ON_SMP
-#define SYNC_ON_SMP
-#endif
-
-static inline void eieio(void)
-{
-	__asm__ __volatile__ ("eieio" : : : "memory");
-}
-
-static inline void isync(void)
-{
-	__asm__ __volatile__ ("isync" : : : "memory");
-}
-
-#ifdef CONFIG_SMP
-#define eieio_on_smp()	eieio()
-#define isync_on_smp()	isync()
-#else
-#define eieio_on_smp()	__asm__ __volatile__("": : :"memory")
-#define isync_on_smp()	__asm__ __volatile__("": : :"memory")
-#endif
-
-/* Macros for adjusting thread priority (hardware multi-threading) */
-#define HMT_very_low()    asm volatile("or 31,31,31   # very low priority")
-#define HMT_low()	asm volatile("or 1,1,1		# low priority")
-#define HMT_medium_low()  asm volatile("or 6,6,6      # medium low priority")
-#define HMT_medium()	asm volatile("or 2,2,2		# medium priority")
-#define HMT_medium_high() asm volatile("or 5,5,5      # medium high priority")
-#define HMT_high()	asm volatile("or 3,3,3		# high priority")
-
-#define HMT_VERY_LOW    "\tor   31,31,31        # very low priority\n"
-#define HMT_LOW		"\tor	1,1,1		# low priority\n"
-#define HMT_MEDIUM_LOW  "\tor   6,6,6           # medium low priority\n"
-#define HMT_MEDIUM	"\tor	2,2,2		# medium priority\n"
-#define HMT_MEDIUM_HIGH "\tor   5,5,5           # medium high priority\n"
-#define HMT_HIGH	"\tor	3,3,3		# high priority\n"
-
-#endif
diff --git a/include/asm-ppc64/processor.h b/include/asm-ppc64/processor.h
--- a/include/asm-ppc64/processor.h
+++ b/include/asm-ppc64/processor.h
@@ -368,6 +368,14 @@ GLUE(.,name):
 #define mfasr()		({unsigned long rval; \
 			asm volatile("mfasr %0" : "=r" (rval)); rval;})
 
+/* Macros for adjusting thread priority (hardware multi-threading) */
+#define HMT_very_low()    asm volatile("or 31,31,31   # very low priority")
+#define HMT_low()	asm volatile("or 1,1,1		# low priority")
+#define HMT_medium_low()  asm volatile("or 6,6,6      # medium low priority")
+#define HMT_medium()	asm volatile("or 2,2,2		# medium priority")
+#define HMT_medium_high() asm volatile("or 5,5,5      # medium high priority")
+#define HMT_high()	asm volatile("or 3,3,3		# high priority")
+
 static inline void set_tb(unsigned int upper, unsigned int lower)
 {
 	mttbl(0);
diff --git a/include/asm-ppc64/system.h b/include/asm-ppc64/system.h
--- a/include/asm-ppc64/system.h
+++ b/include/asm-ppc64/system.h
@@ -13,7 +13,7 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/hw_irq.h>
-#include <asm/memory.h>
+#include <asm/synch.h>
 
 /*
  * Memory barrier.
@@ -48,7 +48,7 @@
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
-#define smp_wmb()	__asm__ __volatile__ ("eieio" : : : "memory")
+#define smp_wmb()	eieio()
 #define smp_read_barrier_depends()  read_barrier_depends()
 #else
 #define smp_mb()	__asm__ __volatile__("": : :"memory")
