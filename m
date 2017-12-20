Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gvT4Q98zF08Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:57:09 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3sa3m072956
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:57:07 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eyecfm92s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:57:07 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:57:05 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 17/17] powerpc/64s: Implement local_t using irq soft
 masking
Date: Wed, 20 Dec 2017 09:25:57 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-18-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

local_t is used for atomic modifications for per-CPU data, versus
re-entrant modifications via interrupts.

local_t read-modify-write atomic operations are currently implemented
with hardware atomics (larx/stcx), which are quite slow. This patch
implements them by masking all types of interrupts that may do local_t
operations ("standard" and perf interrupts).

Rusty's benchmark (https://lkml.org/lkml/2008/12/16/450) gives the
following timings for the local_t test, in nanoseconds per iteration:

             larx/stcx   irq+pmu disable
_inc                38                10
_add                38                10
_read                4                 4
_add_return         38                10

There are still some interrupt types (system reset, machine check, and
watchdog), which can not safely use local_t operations, because they
are not masked.

An alternative approach was proposed, using a CR bit to mark a critical
section, which is tested in the interrupt return path, and would then
branch to a fixup handler (similar to exception fixups), which re-starts
the operation. The problem with this was the complexity of the fixup
handler and the latency of the slow path.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-November/123024.html

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/local.h | 141 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index cfbcc31d43ad..fdd00939270b 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -2,6 +2,147 @@
 #ifndef _ARCH_POWERPC_LOCAL_H
 #define _ARCH_POWERPC_LOCAL_H
 
+#ifdef CONFIG_PPC_BOOK3S_64
+
+#include <linux/percpu.h>
+#include <linux/atomic.h>
+#include <linux/irqflags.h>
+
+#include <asm/hw_irq.h>
+
+typedef struct
+{
+	long v;
+} local_t;
+
+#define LOCAL_INIT(i)	{ (i) }
+
+static __inline__ long local_read(local_t *l)
+{
+	return READ_ONCE(l->v);
+}
+
+static __inline__ void local_set(local_t *l, long i)
+{
+	WRITE_ONCE(l->v, i);
+}
+
+#define LOCAL_OP(op, c_op)						\
+static __inline__ void local_##op(long i, local_t *l)			\
+{									\
+	unsigned long flags;						\
+									\
+	powerpc_local_irq_pmu_save(flags);				\
+	l->v c_op i;						\
+	powerpc_local_irq_pmu_restore(flags);				\
+}
+
+#define LOCAL_OP_RETURN(op, c_op)					\
+static __inline__ long local_##op##_return(long a, local_t *l)		\
+{									\
+	long t;								\
+	unsigned long flags;						\
+									\
+	powerpc_local_irq_pmu_save(flags);				\
+	t = (l->v c_op a);						\
+	powerpc_local_irq_pmu_restore(flags);				\
+									\
+	return t;							\
+}
+
+#define LOCAL_OPS(op, c_op)		\
+	LOCAL_OP(op, c_op)		\
+	LOCAL_OP_RETURN(op, c_op)
+
+LOCAL_OPS(add, +=)
+LOCAL_OPS(sub, -=)
+
+#define local_add_negative(a, l)	(local_add_return((a), (l)) < 0)
+#define local_inc_return(l)		local_add_return(1LL, l)
+#define local_inc(l)			local_inc_return(l)
+
+/*
+ * local_inc_and_test - increment and test
+ * @l: pointer of type local_t
+ *
+ * Atomically increments @l by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_inc_and_test(l)		(local_inc_return(l) == 0)
+
+#define local_dec_return(l)		local_sub_return(1LL, l)
+#define local_dec(l)			local_dec_return(l)
+#define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
+#define local_dec_and_test(l)		(local_dec_return((l)) == 0)
+
+static __inline__ long local_cmpxchg(local_t *l, long o, long n)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	t = l->v;
+	if (t == o)
+		l->v = n;
+	powerpc_local_irq_pmu_restore(flags);
+
+	return t;
+}
+
+static __inline__ long local_xchg(local_t *l, long n)
+{
+	long t;
+	unsigned long flags;
+
+	powerpc_local_irq_pmu_save(flags);
+	t = l->v;
+	l->v = n;
+	powerpc_local_irq_pmu_restore(flags);
+
+	return t;
+}
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
+	unsigned long flags;
+	int ret = 0;
+
+	powerpc_local_irq_pmu_save(flags);
+	if (l->v != u) {
+		l->v += a;
+		ret = 1;
+	}
+	powerpc_local_irq_pmu_restore(flags);
+
+	return ret;
+}
+
+#define local_inc_not_zero(l)		local_add_unless((l), 1, 0)
+
+/* Use these for per-cpu local_t variables: on some archs they are
+ * much more efficient than these naive implementations.  Note they take
+ * a variable, not an address.
+ */
+
+#define __local_inc(l)		((l)->v++)
+#define __local_dec(l)		((l)->v++)
+#define __local_add(i,l)	((l)->v+=(i))
+#define __local_sub(i,l)	((l)->v-=(i))
+
+#else /* CONFIG_PPC64 */
+
 #include <asm-generic/local.h>
 
+#endif /* CONFIG_PPC64 */
+
 #endif /* _ARCH_POWERPC_LOCAL_H */
-- 
2.7.4
