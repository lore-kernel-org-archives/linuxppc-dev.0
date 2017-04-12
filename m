Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2xH71js1zDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:02:43 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3C7u7mb119025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:02:33 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sesmkjr6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:02:32 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 18:02:30 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3C82JW138535240
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:02:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3C81o32003340
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:01:51 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v7 11/11] powerpc: rewrite local_t using soft_irq
Date: Wed, 12 Apr 2017 13:30:40 +0530
In-Reply-To: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491984040-28801-12-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Local atomic operations are fast and highly reentrant per CPU counters.
Used for percpu variable updates. Local atomic operations only guarantee
variable modification atomicity wrt the CPU which owns the data and
these needs to be executed in a preemption safe way.

Here is the design of this patch. Since local_* operations
are only need to be atomic to interrupts (IIUC), we have two options.
Either replay the "op" if interrupted or replay the interrupt after
the "op". Initial patchset posted was based on implementing local_* operation
based on CR5 which replay's the "op". Patchset had issues in case of
rewinding the address pointor from an array. This make the slow path
really slow. Since CR5 based implementation proposed using __ex_table to find
the rewind addressr, this rasied concerns about size of __ex_table and vmlinux.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123115.html

But this patch uses, powerpc_local_irq_pmu_save to soft_disable
interrupts (including PMIs). After finishing the "op", powerpc_local_irq_pmu_restore()
called and correspondingly interrupts are replayed if any occured.

patch re-write the current local_* functions to use arch_local_irq_disbale.
Base flow for each function is

{
	powerpc_local_irq_pmu_save(flags)
	load
	..
	store
	powerpc_local_irq_pmu_restore(flags)
}

Reason for the approach is that, currently l[w/d]arx/st[w/d]cx.
instruction pair is used for local_* operations, which are heavy
on cycle count and they dont support a local variant. So to
see whether the new implementation helps, used a modified
version of Rusty's benchmark code on local_t.

https://lkml.org/lkml/2008/12/16/450

Modifications to Rusty's benchmark code:
- Executed only local_t test

Here are the values with the patch.

Time in ns per iteration

Local_t             Without Patch           With Patch

_inc                        28              8
_add                        28              8
_read                       3               3
_add_return	            28              7

Currently only asm/local.h has been rewritten, and also
the entire change is tested only in PPC64 (pseries guest)
and PPC64 host (LE)

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/local.h | 201 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index b8da91363864..7d117c07b0b1 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -3,6 +3,9 @@
 
 #include <linux/percpu.h>
 #include <linux/atomic.h>
+#include <linux/irqflags.h>
+
+#include <asm/hw_irq.h>
 
 typedef struct
 {
@@ -14,6 +17,202 @@ typedef struct
 #define local_read(l)	atomic_long_read(&(l)->a)
 #define local_set(l,i)	atomic_long_set(&(l)->a, (i))
 
+#ifdef CONFIG_PPC64
+
+static __inline__ void local_add(long i, local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%2)\n\
+	add	%0,%1,%0\n"
+	PPC_STL" %0,0(%2)\n"
+	: "=&r" (t)
+	: "r" (i), "r" (&(l->a.counter)));
+	powerpc_local_irq_pmu_restore(flags);
+}
+
+static __inline__ void local_sub(long i, local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%2)\n\
+	subf	%0,%1,%0\n"
+	PPC_STL" %0,0(%2)\n"
+	: "=&r" (t)
+	: "r" (i), "r" (&(l->a.counter)));
+	powerpc_local_irq_pmu_restore(flags);
+}
+
+static __inline__ long local_add_return(long a, local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%2)\n\
+	add	%0,%1,%0\n"
+	PPC_STL "%0,0(%2)\n"
+	: "=&r" (t)
+	: "r" (a), "r" (&(l->a.counter))
+	: "memory");
+	powerpc_local_irq_pmu_restore(flags);
+
+	return t;
+}
+
+#define local_add_negative(a, l)	(local_add_return((a), (l)) < 0)
+
+static __inline__ long local_sub_return(long a, local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%2)\n\
+	subf	%0,%1,%0\n"
+	PPC_STL "%0,0(%2)\n"
+	: "=&r" (t)
+	: "r" (a), "r" (&(l->a.counter))
+	: "memory");
+	powerpc_local_irq_pmu_restore(flags);
+
+	return t;
+}
+
+static __inline__ long local_inc_return(local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%1)\n\
+	addic	%0,%0,1\n"
+	PPC_STL "%0,0(%1)\n"
+	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "xer", "memory");
+	powerpc_local_irq_pmu_restore(flags);
+
+	return t;
+}
+
+/*
+ * local_inc_and_test - increment and test
+ * @l: pointer of type local_t
+ *
+ * Atomically increments @l by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_inc_and_test(l) (local_inc_return(l) == 0)
+
+static __inline__ long local_dec_return(local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%1)\n\
+	addic	%0,%0,-1\n"
+	PPC_STL "%0,0(%1)\n"
+	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "xer", "memory");
+	powerpc_local_irq_pmu_restore(flags);
+
+	return t;
+}
+
+#define local_inc(l)	local_inc_return(l)
+#define local_dec(l)	local_dec_return(l)
+
+#define local_cmpxchg(l, o, n) \
+	(cmpxchg_local(&((l)->a.counter), (o), (n)))
+#define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
+
+/**
+ * local_add_unless - add unless the number is a given value
+ * @l: pointer of type local_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @l, so long as it was not @u.
+ * Returns non-zero if @l was not @u, and zero otherwise.
+ */
+static __inline__ int local_add_unless(local_t *l, long a, long u)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	__asm__ __volatile__ (
+	PPC_LL" %0,0(%1)\n\
+	cmpw	0,%0,%3 \n\
+	beq-	2f \n\
+	add	%0,%2,%0 \n"
+	PPC_STL" %0,0(%1) \n"
+"       subf	%0,%2,%0 \n\
+2:"
+        : "=&r" (t)
+        : "r" (&(l->a.counter)), "r" (a), "r" (u)
+        : "cc", "memory");
+        powerpc_local_irq_pmu_restore(flags);
+
+	return t != u;
+}
+
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
+#define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
+#define local_dec_and_test(l)		(local_dec_return((l)) == 0)
+
+/*
+ * Atomically test *l and decrement if it is greater than 0.
+ * The function returns the old value of *l minus 1.
+ */
+static __inline__ long local_dec_if_positive(local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%1)\n\
+	cmpwi	%0,1\n\
+	addi	%0,%0,-1\n\
+	blt-	2f\n"
+	PPC_STL "%0,0(%1)\n"
+	"\n\
+2:"	: "=&b" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "memory");
+	powerpc_local_irq_pmu_restore(flags);
+
+	return t;
+}
+
+/* Use these for per-cpu local_t variables: on some archs they are
+ * much more efficient than these naive implementations.  Note they take
+ * a variable, not an address.
+ */
+
+#define __local_inc(l)		((l)->a.counter++)
+#define __local_dec(l)		((l)->a.counter++)
+#define __local_add(i,l)	((l)->a.counter+=(i))
+#define __local_sub(i,l)	((l)->a.counter-=(i))
+
+#else
+
 #define local_add(i,l)	atomic_long_add((i),(&(l)->a))
 #define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
 #define local_inc(l)	atomic_long_inc(&(l)->a)
@@ -172,4 +371,6 @@ static __inline__ long local_dec_if_positive(local_t *l)
 #define __local_add(i,l)	((l)->a.counter+=(i))
 #define __local_sub(i,l)	((l)->a.counter-=(i))
 
+#endif /* CONFIG_PPC64 */
+
 #endif /* _ARCH_POWERPC_LOCAL_H */
-- 
2.7.4
