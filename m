Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D863068141
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 16:50:11 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Mon, 29 Aug 2005 08:45:33 +0200
References: <20050829130133.519391c6.sfr@canb.auug.org.au>
In-Reply-To: <20050829130133.519391c6.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508290845.34544.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3] Start the merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Maandag 29 August 2005 05:01, Stephen Rothwell wrote:

> Please send at least the first upstream.  The other two can also probably
> be sent.

These certainly look good to me.

This is another patch to merge the atomic.h file. It is not completely
trivial and changes the semantics for 32 bit SMP systems, which previously
did not do EIEIO_ON_SMP within the atomic operations. AFAICT, that was
a bug in the 32 bit version, which is now fixed as a side-effect of
the merge.

The combined version of this file also prevents building user space
applications using atomic.h on ppc64. That was already impossible
on 32 bit ppc, but probably also created broken output on ppc64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--

 include/asm-ppc/atomic.h                  |  214 ------------------------------
 include/asm-ppc64/atomic.h                |  197 ---------------------------
 include/asm-ppc64/memory.h                |   59 --------
 linux-2.6.12/include/asm-powerpc/atomic.h |  209 +++++++++++++++++++++++++++++
 linux-2.6.12/include/asm-powerpc/memory.h |   59 ++++++++
 linux-2.6.12/include/asm-ppc/io.h         |   11 -
 6 files changed, 269 insertions(+), 480 deletions(-)

Index: linux-2.6.12/include/asm-ppc/atomic.h
===================================================================
--- linux-2.6.12.orig/include/asm-ppc/atomic.h	2005-08-29 08:04:06.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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
Index: linux-2.6.12/include/asm-ppc64/memory.h
===================================================================
--- linux-2.6.12.orig/include/asm-ppc64/memory.h	2005-08-29 08:04:06.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,59 +0,0 @@
-#ifndef _ASM_POWERPC_MEMORY_H_ 
-#define _ASM_POWERPC_MEMORY_H_ 
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
-#else
-#define EIEIO_ON_SMP
-#define ISYNC_ON_SMP
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
Index: linux-2.6.12/include/asm-ppc/io.h
===================================================================
--- linux-2.6.12.orig/include/asm-ppc/io.h	2005-08-29 08:04:06.000000000 +0200
+++ linux-2.6.12/include/asm-ppc/io.h	2005-08-29 08:04:26.000000000 +0200
@@ -8,6 +8,7 @@
 
 #include <asm/page.h>
 #include <asm/byteorder.h>
+#include <asm/memory.h>
 #include <asm/mmu.h>
 
 #define SIO_CONFIG_RA	0x398
@@ -440,16 +441,6 @@
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
Index: linux-2.6.12/include/asm-ppc64/atomic.h
===================================================================
--- linux-2.6.12.orig/include/asm-ppc64/atomic.h	2005-08-29 08:04:06.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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
Index: linux-2.6.12/include/asm-powerpc/memory.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/include/asm-powerpc/memory.h	2005-08-29 08:04:26.000000000 +0200
@@ -0,0 +1,59 @@
+#ifndef _ASM_PPC64_MEMORY_H_ 
+#define _ASM_PPC64_MEMORY_H_ 
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+
+/*
+ * Arguably the bitops and *xchg operations don't imply any memory barrier
+ * or SMP ordering, but in fact a lot of drivers expect them to imply
+ * both, since they do on x86 cpus.
+ */
+#ifdef CONFIG_SMP
+#define EIEIO_ON_SMP	"eieio\n"
+#define ISYNC_ON_SMP	"\n\tisync"
+#else
+#define EIEIO_ON_SMP
+#define ISYNC_ON_SMP
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
+/* Macros for adjusting thread priority (hardware multi-threading) */
+#define HMT_very_low()    asm volatile("or 31,31,31   # very low priority")
+#define HMT_low()	asm volatile("or 1,1,1		# low priority")
+#define HMT_medium_low()  asm volatile("or 6,6,6      # medium low priority")
+#define HMT_medium()	asm volatile("or 2,2,2		# medium priority")
+#define HMT_medium_high() asm volatile("or 5,5,5      # medium high priority")
+#define HMT_high()	asm volatile("or 3,3,3		# high priority")
+
+#define HMT_VERY_LOW    "\tor   31,31,31        # very low priority\n"
+#define HMT_LOW		"\tor	1,1,1		# low priority\n"
+#define HMT_MEDIUM_LOW  "\tor   6,6,6           # medium low priority\n"
+#define HMT_MEDIUM	"\tor	2,2,2		# medium priority\n"
+#define HMT_MEDIUM_HIGH "\tor   5,5,5           # medium high priority\n"
+#define HMT_HIGH	"\tor	3,3,3		# high priority\n"
+
+#endif
Index: linux-2.6.12/include/asm-powerpc/atomic.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/include/asm-powerpc/atomic.h	2005-08-29 08:04:26.000000000 +0200
@@ -0,0 +1,209 @@
+/*
+ * PowerPC atomic operations
+ */
+
+#ifndef _ASM_POWERPC_ATOMIC_H_
+#define _ASM_POWERPC_ATOMIC_H_
+
+typedef struct { volatile int counter; } atomic_t;
+
+#ifdef __KERNEL__
+#include <asm/memory.h>
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
