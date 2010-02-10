Return-Path: <anton@ozlabs.org>
Date: Wed, 10 Feb 2010 22:04:06 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 4/6] powerpc: Rename LWSYNC_ON_SMP to PPC_RELEASE_BARRIER,
	ISYNC_ON_SMP to PPC_ACQUIRE_BARRIER
Message-ID: <20100210110406.GD3399@kryten>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210110306.GC3399@kryten>
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


For performance reasons we are about to change ISYNC_ON_SMP to sometimes be
lwsync. Now that the macro name doesn't make sense, change it and LWSYNC_ON_SMP
to better explain what the barriers are doing.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/atomic.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/atomic.h	2010-02-10 17:12:30.264322204 +1100
+++ powerpc.git/arch/powerpc/include/asm/atomic.h	2010-02-10 17:13:05.355571902 +1100
@@ -49,13 +49,13 @@ static __inline__ int atomic_add_return(
 	int t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx	%0,0,%2		# atomic_add_return\n\
 	add	%0,%1,%0\n"
 	PPC405_ERR77(0,%2)
 "	stwcx.	%0,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (a), "r" (&v->counter)
 	: "cc", "memory");
@@ -85,13 +85,13 @@ static __inline__ int atomic_sub_return(
 	int t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx	%0,0,%2		# atomic_sub_return\n\
 	subf	%0,%1,%0\n"
 	PPC405_ERR77(0,%2)
 "	stwcx.	%0,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (a), "r" (&v->counter)
 	: "cc", "memory");
@@ -119,13 +119,13 @@ static __inline__ int atomic_inc_return(
 	int t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx	%0,0,%1		# atomic_inc_return\n\
 	addic	%0,%0,1\n"
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
 	: "cc", "xer", "memory");
@@ -163,13 +163,13 @@ static __inline__ int atomic_dec_return(
 	int t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx	%0,0,%1		# atomic_dec_return\n\
 	addic	%0,%0,-1\n"
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
 	: "cc", "xer", "memory");
@@ -194,7 +194,7 @@ static __inline__ int atomic_add_unless(
 	int t;
 
 	__asm__ __volatile__ (
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx	%0,0,%1		# atomic_add_unless\n\
 	cmpw	0,%0,%3 \n\
 	beq-	2f \n\
@@ -202,7 +202,7 @@ static __inline__ int atomic_add_unless(
 	PPC405_ERR77(0,%2)
 "	stwcx.	%0,0,%1 \n\
 	bne-	1b \n"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 "	subf	%0,%2,%0 \n\
 2:"
 	: "=&r" (t)
@@ -227,7 +227,7 @@ static __inline__ int atomic_dec_if_posi
 	int t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
 	cmpwi	%0,1\n\
 	addi	%0,%0,-1\n\
@@ -235,7 +235,7 @@ static __inline__ int atomic_dec_if_posi
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	"\n\
 2:"	: "=&b" (t)
 	: "r" (&v->counter)
@@ -286,12 +286,12 @@ static __inline__ long atomic64_add_retu
 	long t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	ldarx	%0,0,%2		# atomic64_add_return\n\
 	add	%0,%1,%0\n\
 	stdcx.	%0,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (a), "r" (&v->counter)
 	: "cc", "memory");
@@ -320,12 +320,12 @@ static __inline__ long atomic64_sub_retu
 	long t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	ldarx	%0,0,%2		# atomic64_sub_return\n\
 	subf	%0,%1,%0\n\
 	stdcx.	%0,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (a), "r" (&v->counter)
 	: "cc", "memory");
@@ -352,12 +352,12 @@ static __inline__ long atomic64_inc_retu
 	long t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	ldarx	%0,0,%1		# atomic64_inc_return\n\
 	addic	%0,%0,1\n\
 	stdcx.	%0,0,%1 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
 	: "cc", "xer", "memory");
@@ -394,12 +394,12 @@ static __inline__ long atomic64_dec_retu
 	long t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	ldarx	%0,0,%1		# atomic64_dec_return\n\
 	addic	%0,%0,-1\n\
 	stdcx.	%0,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
 	: "cc", "xer", "memory");
@@ -419,13 +419,13 @@ static __inline__ long atomic64_dec_if_p
 	long t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	ldarx	%0,0,%1		# atomic64_dec_if_positive\n\
 	addic.	%0,%0,-1\n\
 	blt-	2f\n\
 	stdcx.	%0,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	"\n\
 2:"	: "=&r" (t)
 	: "r" (&v->counter)
@@ -451,14 +451,14 @@ static __inline__ int atomic64_add_unles
 	long t;
 
 	__asm__ __volatile__ (
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	ldarx	%0,0,%1		# atomic_add_unless\n\
 	cmpd	0,%0,%3 \n\
 	beq-	2f \n\
 	add	%0,%2,%0 \n"
 "	stdcx.	%0,0,%1 \n\
 	bne-	1b \n"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 "	subf	%0,%2,%0 \n\
 2:"
 	: "=&r" (t)
Index: powerpc.git/arch/powerpc/include/asm/futex.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/futex.h	2010-02-10 17:12:30.274322058 +1100
+++ powerpc.git/arch/powerpc/include/asm/futex.h	2010-02-10 17:13:05.355571902 +1100
@@ -11,7 +11,7 @@
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
   __asm__ __volatile ( \
-	LWSYNC_ON_SMP \
+	PPC_RELEASE_BARRIER \
 "1:	lwarx	%0,0,%2\n" \
 	insn \
 	PPC405_ERR77(0, %2) \
@@ -90,14 +90,14 @@ futex_atomic_cmpxchg_inatomic(int __user
 		return -EFAULT;
 
         __asm__ __volatile__ (
-        LWSYNC_ON_SMP
+        PPC_RELEASE_BARRIER
 "1:     lwarx   %0,0,%2         # futex_atomic_cmpxchg_inatomic\n\
         cmpw    0,%0,%3\n\
         bne-    3f\n"
         PPC405_ERR77(0,%2)
 "2:     stwcx.  %4,0,%2\n\
         bne-    1b\n"
-        ISYNC_ON_SMP
+        PPC_ACQUIRE_BARRIER
 "3:	.section .fixup,\"ax\"\n\
 4:	li	%0,%5\n\
 	b	3b\n\
Index: powerpc.git/arch/powerpc/include/asm/mutex.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/mutex.h	2010-02-10 17:12:30.244322286 +1100
+++ powerpc.git/arch/powerpc/include/asm/mutex.h	2010-02-10 17:13:05.355571902 +1100
@@ -15,7 +15,7 @@ static inline int __mutex_cmpxchg_lock(a
 	PPC405_ERR77(0,%1)
 "	stwcx.	%3,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	"\n\
 2:"
 	: "=&r" (t)
@@ -35,7 +35,7 @@ static inline int __mutex_dec_return_loc
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
 	: "cc", "memory");
@@ -48,7 +48,7 @@ static inline int __mutex_inc_return_unl
 	int t;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx	%0,0,%1		# mutex unlock\n\
 	addic	%0,%0,1\n"
 	PPC405_ERR77(0,%1)
Index: powerpc.git/arch/powerpc/include/asm/synch.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/synch.h	2010-02-10 17:12:30.274322058 +1100
+++ powerpc.git/arch/powerpc/include/asm/synch.h	2010-02-10 17:13:05.355571902 +1100
@@ -37,11 +37,11 @@ static inline void isync(void)
 #endif
 
 #ifdef CONFIG_SMP
-#define ISYNC_ON_SMP	"\n\tisync\n"
-#define LWSYNC_ON_SMP	stringify_in_c(LWSYNC) "\n"
+#define PPC_ACQUIRE_BARRIER	"\n\tisync\n"
+#define PPC_RELEASE_BARRIER	stringify_in_c(LWSYNC) "\n"
 #else
-#define ISYNC_ON_SMP
-#define LWSYNC_ON_SMP
+#define PPC_ACQUIRE_BARRIER
+#define PPC_RELEASE_BARRIER
 #endif
 
 #endif /* __KERNEL__ */
Index: powerpc.git/arch/powerpc/include/asm/bitops.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/bitops.h	2010-02-10 17:12:50.094322149 +1100
+++ powerpc.git/arch/powerpc/include/asm/bitops.h	2010-02-10 17:13:15.125572158 +1100
@@ -78,7 +78,7 @@ static __inline__ void fn(unsigned long 
 
 DEFINE_BITOP(set_bits, or, "", "")
 DEFINE_BITOP(clear_bits, andc, "", "")
-DEFINE_BITOP(clear_bits_unlock, andc, LWSYNC_ON_SMP, "")
+DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER, "")
 DEFINE_BITOP(change_bits, xor, "", "")
 
 static __inline__ void set_bit(int nr, volatile unsigned long *addr)
@@ -124,10 +124,14 @@ static __inline__ unsigned long fn(			\
 	return (old & mask);				\
 }
 
-DEFINE_TESTOP(test_and_set_bits, or, LWSYNC_ON_SMP, ISYNC_ON_SMP, 0)
-DEFINE_TESTOP(test_and_set_bits_lock, or, "", ISYNC_ON_SMP, 1)
-DEFINE_TESTOP(test_and_clear_bits, andc, LWSYNC_ON_SMP, ISYNC_ON_SMP, 0)
-DEFINE_TESTOP(test_and_change_bits, xor, LWSYNC_ON_SMP, ISYNC_ON_SMP, 0)
+DEFINE_TESTOP(test_and_set_bits, or, PPC_RELEASE_BARRIER,
+	      PPC_ACQUIRE_BARRIER, 0)
+DEFINE_TESTOP(test_and_set_bits_lock, or, "",
+	      PPC_ACQUIRE_BARRIER, 1)
+DEFINE_TESTOP(test_and_clear_bits, andc, PPC_RELEASE_BARRIER,
+	      PPC_ACQUIRE_BARRIER, 0)
+DEFINE_TESTOP(test_and_change_bits, xor, PPC_RELEASE_BARRIER,
+	      PPC_ACQUIRE_BARRIER, 0)
 
 static __inline__ int test_and_set_bit(unsigned long nr,
 				       volatile unsigned long *addr)
@@ -158,7 +162,7 @@ static __inline__ int test_and_change_bi
 
 static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
-	__asm__ __volatile__(LWSYNC_ON_SMP "" ::: "memory");
+	__asm__ __volatile__(PPC_RELEASE_BARRIER "" ::: "memory");
 	__clear_bit(nr, addr);
 }
 
Index: powerpc.git/arch/powerpc/include/asm/system.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/system.h	2010-02-10 17:12:30.284321702 +1100
+++ powerpc.git/arch/powerpc/include/asm/system.h	2010-02-10 17:13:05.355571902 +1100
@@ -232,12 +232,12 @@ __xchg_u32(volatile void *p, unsigned lo
 	unsigned long prev;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx	%0,0,%2 \n"
 	PPC405_ERR77(0,%2)
 "	stwcx.	%3,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
 	: "r" (p), "r" (val)
 	: "cc", "memory");
@@ -275,12 +275,12 @@ __xchg_u64(volatile void *p, unsigned lo
 	unsigned long prev;
 
 	__asm__ __volatile__(
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	ldarx	%0,0,%2 \n"
 	PPC405_ERR77(0,%2)
 "	stdcx.	%3,0,%2 \n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
 	: "r" (p), "r" (val)
 	: "cc", "memory");
@@ -366,14 +366,14 @@ __cmpxchg_u32(volatile unsigned int *p, 
 	unsigned int prev;
 
 	__asm__ __volatile__ (
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx	%0,0,%2		# __cmpxchg_u32\n\
 	cmpw	0,%0,%3\n\
 	bne-	2f\n"
 	PPC405_ERR77(0,%2)
 "	stwcx.	%4,0,%2\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	"\n\
 2:"
 	: "=&r" (prev), "+m" (*p)
@@ -412,13 +412,13 @@ __cmpxchg_u64(volatile unsigned long *p,
 	unsigned long prev;
 
 	__asm__ __volatile__ (
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	ldarx	%0,0,%2		# __cmpxchg_u64\n\
 	cmpd	0,%0,%3\n\
 	bne-	2f\n\
 	stdcx.	%4,0,%2\n\
 	bne-	1b"
-	ISYNC_ON_SMP
+	PPC_ACQUIRE_BARRIER
 	"\n\
 2:"
 	: "=&r" (prev), "+m" (*p)
Index: powerpc.git/arch/powerpc/include/asm/spinlock.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/spinlock.h	2010-02-10 17:12:48.464321650 +1100
+++ powerpc.git/arch/powerpc/include/asm/spinlock.h	2010-02-10 17:13:05.355571902 +1100
@@ -65,9 +65,10 @@ static inline unsigned long __arch_spin_
 	cmpwi		0,%0,0\n\
 	bne-		2f\n\
 	stwcx.		%1,0,%2\n\
-	bne-		1b\n\
-	isync\n\
-2:"	: "=&r" (tmp)
+	bne-		1b\n"
+	PPC_ACQUIRE_BARRIER
+"2:"
+	: "=&r" (tmp)
 	: "r" (token), "r" (&lock->slock)
 	: "cr0", "memory");
 
@@ -145,7 +146,7 @@ static inline void arch_spin_unlock(arch
 {
 	SYNC_IO;
 	__asm__ __volatile__("# arch_spin_unlock\n\t"
-				LWSYNC_ON_SMP: : :"memory");
+				PPC_RELEASE_BARRIER: : :"memory");
 	lock->slock = 0;
 }
 
@@ -193,9 +194,9 @@ static inline long __arch_read_trylock(a
 	ble-		2f\n"
 	PPC405_ERR77(0,%1)
 "	stwcx.		%0,0,%1\n\
-	bne-		1b\n\
-	isync\n\
-2:"	: "=&r" (tmp)
+	bne-		1b\n"
+	PPC_ACQUIRE_BARRIER
+"2:"	: "=&r" (tmp)
 	: "r" (&rw->lock)
 	: "cr0", "xer", "memory");
 
@@ -217,9 +218,9 @@ static inline long __arch_write_trylock(
 	bne-		2f\n"
 	PPC405_ERR77(0,%1)
 "	stwcx.		%1,0,%2\n\
-	bne-		1b\n\
-	isync\n\
-2:"	: "=&r" (tmp)
+	bne-		1b\n"
+	PPC_ACQUIRE_BARRIER
+"2:"	: "=&r" (tmp)
 	: "r" (token), "r" (&rw->lock)
 	: "cr0", "memory");
 
@@ -270,7 +271,7 @@ static inline void arch_read_unlock(arch
 
 	__asm__ __volatile__(
 	"# read_unlock\n\t"
-	LWSYNC_ON_SMP
+	PPC_RELEASE_BARRIER
 "1:	lwarx		%0,0,%1\n\
 	addic		%0,%0,-1\n"
 	PPC405_ERR77(0,%1)
@@ -284,7 +285,7 @@ static inline void arch_read_unlock(arch
 static inline void arch_write_unlock(arch_rwlock_t *rw)
 {
 	__asm__ __volatile__("# write_unlock\n\t"
-				LWSYNC_ON_SMP: : :"memory");
+				PPC_RELEASE_BARRIER: : :"memory");
 	rw->lock = 0;
 }
 
