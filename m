Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F951A0027
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Nov 2014 11:42:53 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ulrich.weigand@de.ibm.com
Subject: [PATCH] powerpc: Replace cc constraint in inline assembly with cr0
Date: Sat,  1 Nov 2014 11:42:51 +1100
Message-Id: <1414802571-20225-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our inline assembly only clobbers the first condition register field,
but we mark all of them as being clobbered.

This will cause LLVM to save and restore the non volatile condition
register fields around the inline assembly, which is completely
unnecessary. A simple example:

void foo(void)
{
        asm volatile("":::"cc");
}

gives:

<foo>:
   0:	26 00 80 7d 	mfcr    r12
   4:	08 00 81 91 	stw     r12,8(r1)
   8:	08 00 61 81 	lwz     r11,8(r1)
   c:	20 01 72 7d 	mtocrf  32,r11
  10:	20 01 71 7d 	mtocrf  16,r11
  14:	20 81 70 7d 	mtocrf  8,r11
  18:	20 00 80 4e 	blr

Replacing cc with cr0:

<foo>:
   0:	20 00 80 4e 	blr

This patch produces no difference to a kernel built with gcc.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/atomic.h        | 36 ++++++++++++++++----------------
 arch/powerpc/include/asm/bitops.h        |  4 ++--
 arch/powerpc/include/asm/cmpxchg.h       | 16 +++++++-------
 arch/powerpc/include/asm/futex.h         |  2 +-
 arch/powerpc/include/asm/kvm_book3s_64.h |  2 +-
 arch/powerpc/include/asm/local.h         | 12 +++++------
 arch/powerpc/include/asm/mutex.h         |  6 +++---
 arch/powerpc/include/asm/pgtable-ppc32.h |  4 ++--
 arch/powerpc/include/asm/pgtable-ppc64.h |  4 ++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  2 +-
 arch/powerpc/mm/pgtable_64.c             |  4 ++--
 11 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 512d278..ef2172c 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -39,7 +39,7 @@ static __inline__ void atomic_##op(int a, atomic_t *v)			\
 "	bne-	1b\n"							\
 	: "=&r" (t), "+m" (v->counter)					\
 	: "r" (a), "r" (&v->counter)					\
-	: "cc");							\
+	: "cr0");							\
 }									\
 
 #define ATOMIC_OP_RETURN(op, asm_op)					\
@@ -57,7 +57,7 @@ static __inline__ int atomic_##op##_return(int a, atomic_t *v)		\
 	PPC_ATOMIC_EXIT_BARRIER						\
 	: "=&r" (t)							\
 	: "r" (a), "r" (&v->counter)					\
-	: "cc", "memory");						\
+	: "cr0", "memory");						\
 									\
 	return t;							\
 }
@@ -85,7 +85,7 @@ static __inline__ void atomic_inc(atomic_t *v)
 	bne-	1b"
 	: "=&r" (t), "+m" (v->counter)
 	: "r" (&v->counter)
-	: "cc", "xer");
+	: "cr0", "xer");
 }
 
 static __inline__ int atomic_inc_return(atomic_t *v)
@@ -102,7 +102,7 @@ static __inline__ int atomic_inc_return(atomic_t *v)
 	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cr0", "xer", "memory");
 
 	return t;
 }
@@ -129,7 +129,7 @@ static __inline__ void atomic_dec(atomic_t *v)
 	bne-	1b"
 	: "=&r" (t), "+m" (v->counter)
 	: "r" (&v->counter)
-	: "cc", "xer");
+	: "cr0", "xer");
 }
 
 static __inline__ int atomic_dec_return(atomic_t *v)
@@ -146,7 +146,7 @@ static __inline__ int atomic_dec_return(atomic_t *v)
 	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cr0", "xer", "memory");
 
 	return t;
 }
@@ -181,7 +181,7 @@ static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
 2:"
 	: "=&r" (t)
 	: "r" (&v->counter), "r" (a), "r" (u)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t;
 }
@@ -211,7 +211,7 @@ static __inline__ int atomic_inc_not_zero(atomic_t *v)
 2:"
 	: "=&r" (t1), "=&r" (t2)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cr0", "xer", "memory");
 
 	return t1;
 }
@@ -242,7 +242,7 @@ static __inline__ int atomic_dec_if_positive(atomic_t *v)
 	"\n\
 2:"	: "=&b" (t)
 	: "r" (&v->counter)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t;
 }
@@ -278,7 +278,7 @@ static __inline__ void atomic64_##op(long a, atomic64_t *v)		\
 "	bne-	1b\n"							\
 	: "=&r" (t), "+m" (v->counter)					\
 	: "r" (a), "r" (&v->counter)					\
-	: "cc");							\
+	: "cr0");							\
 }
 
 #define ATOMIC64_OP_RETURN(op, asm_op)					\
@@ -295,7 +295,7 @@ static __inline__ long atomic64_##op##_return(long a, atomic64_t *v)	\
 	PPC_ATOMIC_EXIT_BARRIER						\
 	: "=&r" (t)							\
 	: "r" (a), "r" (&v->counter)					\
-	: "cc", "memory");						\
+	: "cr0", "memory");						\
 									\
 	return t;							\
 }
@@ -322,7 +322,7 @@ static __inline__ void atomic64_inc(atomic64_t *v)
 	bne-	1b"
 	: "=&r" (t), "+m" (v->counter)
 	: "r" (&v->counter)
-	: "cc", "xer");
+	: "cr0", "xer");
 }
 
 static __inline__ long atomic64_inc_return(atomic64_t *v)
@@ -338,7 +338,7 @@ static __inline__ long atomic64_inc_return(atomic64_t *v)
 	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cr0", "xer", "memory");
 
 	return t;
 }
@@ -364,7 +364,7 @@ static __inline__ void atomic64_dec(atomic64_t *v)
 	bne-	1b"
 	: "=&r" (t), "+m" (v->counter)
 	: "r" (&v->counter)
-	: "cc", "xer");
+	: "cr0", "xer");
 }
 
 static __inline__ long atomic64_dec_return(atomic64_t *v)
@@ -380,7 +380,7 @@ static __inline__ long atomic64_dec_return(atomic64_t *v)
 	PPC_ATOMIC_EXIT_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cr0", "xer", "memory");
 
 	return t;
 }
@@ -407,7 +407,7 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 	"\n\
 2:"	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cr0", "xer", "memory");
 
 	return t;
 }
@@ -441,7 +441,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 2:"
 	: "=&r" (t)
 	: "r" (&v->counter), "r" (a), "r" (u)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t != u;
 }
@@ -470,7 +470,7 @@ static __inline__ long atomic64_inc_not_zero(atomic64_t *v)
 2:"
 	: "=&r" (t1), "=&r" (t2)
 	: "r" (&v->counter)
-	: "cc", "xer", "memory");
+	: "cr0", "xer", "memory");
 
 	return t1;
 }
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index c633f05..5263771 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -69,7 +69,7 @@ static __inline__ void fn(unsigned long mask,	\
 	"bne- 1b\n"				\
 	: "=&r" (old), "+m" (*p)		\
 	: "r" (mask), "r" (p)			\
-	: "cc", "memory");			\
+	: "cr0", "memory");			\
 }
 
 DEFINE_BITOP(set_bits, or, "")
@@ -116,7 +116,7 @@ static __inline__ unsigned long fn(			\
 	postfix						\
 	: "=&r" (old), "=&r" (t)			\
 	: "r" (mask), "r" (p)				\
-	: "cc", "memory");				\
+	: "cr0", "memory");				\
 	return (old & mask);				\
 }
 
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index d463c68..aee7d4e 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -26,7 +26,7 @@ __xchg_u32(volatile void *p, unsigned long val)
 	PPC_ACQUIRE_BARRIER
 	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
 	: "r" (p), "r" (val)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return prev;
 }
@@ -49,7 +49,7 @@ __xchg_u32_local(volatile void *p, unsigned long val)
 	bne-	1b"
 	: "=&r" (prev), "+m" (*(volatile unsigned int *)p)
 	: "r" (p), "r" (val)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return prev;
 }
@@ -69,7 +69,7 @@ __xchg_u64(volatile void *p, unsigned long val)
 	PPC_ACQUIRE_BARRIER
 	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
 	: "r" (p), "r" (val)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return prev;
 }
@@ -86,7 +86,7 @@ __xchg_u64_local(volatile void *p, unsigned long val)
 	bne-	1b"
 	: "=&r" (prev), "+m" (*(volatile unsigned long *)p)
 	: "r" (p), "r" (val)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return prev;
 }
@@ -164,7 +164,7 @@ __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long new)
 2:"
 	: "=&r" (prev), "+m" (*p)
 	: "r" (p), "r" (old), "r" (new)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return prev;
 }
@@ -186,7 +186,7 @@ __cmpxchg_u32_local(volatile unsigned int *p, unsigned long old,
 2:"
 	: "=&r" (prev), "+m" (*p)
 	: "r" (p), "r" (old), "r" (new)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return prev;
 }
@@ -209,7 +209,7 @@ __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
 2:"
 	: "=&r" (prev), "+m" (*p)
 	: "r" (p), "r" (old), "r" (new)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return prev;
 }
@@ -230,7 +230,7 @@ __cmpxchg_u64_local(volatile unsigned long *p, unsigned long old,
 2:"
 	: "=&r" (prev), "+m" (*p)
 	: "r" (p), "r" (old), "r" (new)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return prev;
 }
diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 2a9cf84..4d6a784 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -111,7 +111,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	.previous" \
         : "+r" (ret), "=&r" (prev), "+m" (*uaddr)
         : "r" (uaddr), "r" (oldval), "r" (newval), "i" (-EFAULT)
-        : "cc", "memory");
+        : "cr0", "memory");
 
 	*uval = prev;
         return ret;
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 0aa8179..f2b2af0 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -82,7 +82,7 @@ static inline long try_lock_hpte(__be64 *hpte, unsigned long bits)
 		     "2:	isync"
 		     : "=&r" (tmp), "=&r" (old)
 		     : "r" (hpte), "r" (be_bits), "r" (be_lockbit)
-		     : "cc", "memory");
+		     : "cr0", "memory");
 	return old == 0;
 }
 
diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index b8da913..91a64ea 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -31,7 +31,7 @@ static __inline__ long local_add_return(long a, local_t *l)
 	bne-	1b"
 	: "=&r" (t)
 	: "r" (a), "r" (&(l->a.counter))
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t;
 }
@@ -50,7 +50,7 @@ static __inline__ long local_sub_return(long a, local_t *l)
 	bne-	1b"
 	: "=&r" (t)
 	: "r" (a), "r" (&(l->a.counter))
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t;
 }
@@ -67,7 +67,7 @@ static __inline__ long local_inc_return(local_t *l)
 	bne-	1b"
 	: "=&r" (t)
 	: "r" (&(l->a.counter))
-	: "cc", "xer", "memory");
+	: "cr0", "xer", "memory");
 
 	return t;
 }
@@ -94,7 +94,7 @@ static __inline__ long local_dec_return(local_t *l)
 	bne-	1b"
 	: "=&r" (t)
 	: "r" (&(l->a.counter))
-	: "cc", "xer", "memory");
+	: "cr0", "xer", "memory");
 
 	return t;
 }
@@ -128,7 +128,7 @@ static __inline__ int local_add_unless(local_t *l, long a, long u)
 2:"
 	: "=&r" (t)
 	: "r" (&(l->a.counter)), "r" (a), "r" (u)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t != u;
 }
@@ -157,7 +157,7 @@ static __inline__ long local_dec_if_positive(local_t *l)
 	"\n\
 2:"	: "=&b" (t)
 	: "r" (&(l->a.counter))
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t;
 }
diff --git a/arch/powerpc/include/asm/mutex.h b/arch/powerpc/include/asm/mutex.h
index 127ab23..dc1e08e 100644
--- a/arch/powerpc/include/asm/mutex.h
+++ b/arch/powerpc/include/asm/mutex.h
@@ -20,7 +20,7 @@ static inline int __mutex_cmpxchg_lock(atomic_t *v, int old, int new)
 2:"
 	: "=&r" (t)
 	: "r" (&v->counter), "r" (old), "r" (new)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t;
 }
@@ -38,7 +38,7 @@ static inline int __mutex_dec_return_lock(atomic_t *v)
 	PPC_ACQUIRE_BARRIER
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t;
 }
@@ -56,7 +56,7 @@ static inline int __mutex_inc_return_unlock(atomic_t *v)
 	bne-	1b"
 	: "=&r" (t)
 	: "r" (&v->counter)
-	: "cc", "memory");
+	: "cr0", "memory");
 
 	return t;
 }
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 945e47a..d52e4ec 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -179,7 +179,7 @@ static inline unsigned long pte_update(pte_t *p,
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" (clr), "r" (set), "m" (*p)
-	: "cc" );
+	: "cr0" );
 #else /* PTE_ATOMIC_UPDATES */
 	unsigned long old = pte_val(*p);
 	*p = __pte((old & ~clr) | set);
@@ -210,7 +210,7 @@ static inline unsigned long long pte_update(pte_t *p,
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), "m" (*p)
-	: "cc" );
+	: "cr0" );
 #else /* PTE_ATOMIC_UPDATES */
 	unsigned long long old = pte_val(*p);
 	*p = __pte((old & ~(unsigned long long)clr) | set);
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 29c3624..49b8a06 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -211,7 +211,7 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
 	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
-	: "cc" );
+	: "cr0" );
 #else
 	unsigned long old = pte_val(*ptep);
 	*ptep = __pte((old & ~clr) | set);
@@ -317,7 +317,7 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 		bne-	1b"
 	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
 	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
-	:"cc");
+	:"cr0");
 #else
 	unsigned long old = pte_val(*ptep);
 	*ptep = __pte(old | bits);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 084ad54..8db17a1 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -391,7 +391,7 @@ static inline int try_lock_tlbie(unsigned int *lock)
 		     "2:"
 		     : "=&r" (tmp), "=&r" (old)
 		     : "r" (lock), "r" (token)
-		     : "cc", "memory");
+		     : "cr0", "memory");
 	return old == 0;
 }
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e0c7185..66f2bab 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -527,7 +527,7 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 		bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*pmdp)
 	: "r" (pmdp), "r" (clr), "m" (*pmdp), "i" (_PAGE_BUSY), "r" (set)
-	: "cc" );
+	: "cr0" );
 #else
 	old = pmd_val(*pmdp);
 	*pmdp = __pmd((old & ~clr) | set);
@@ -629,7 +629,7 @@ void pmdp_splitting_flush(struct vm_area_struct *vma,
 		bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*pmdp)
 	: "r" (pmdp), "i" (_PAGE_SPLITTING), "m" (*pmdp), "i" (_PAGE_BUSY)
-	: "cc" );
+	: "cr0" );
 #else
 	old = pmd_val(*pmdp);
 	*pmdp = __pmd(old | _PAGE_SPLITTING);
-- 
1.9.1
