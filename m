Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scvW835mFzDsfG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:26:12 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J5NS1W122296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:26:10 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25h1wdqcwc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:26:10 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Sun, 18 Sep 2016 23:26:10 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, xinhui.pan@linux.vnet.ibm.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v7 4/6] powerpc: lib/locks.c: Add cpu yield/wake helper
 function
Date: Mon, 19 Sep 2016 05:23:55 -0400
In-Reply-To: <1474277037-15200-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1474277037-15200-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1474277037-15200-5-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add two corresponding helper functions to support pv-qspinlock.

For normal use, __spin_yield_cpu will confer current vcpu slices to the
target vcpu(say, a lock holder). If target vcpu is not specified or it
is in running state, such conferging to lpar happens or not depends.

Because hcall itself will introduce latency and a little overhead. And
we do NOT want to suffer any latency on some cases, e.g. in interrupt handler.
The second parameter *confer* can indicate such case.

__spin_wake_cpu is simpiler, it will wake up one vcpu regardless of its
current vcpu state.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/spinlock.h |  4 +++
 arch/powerpc/lib/locks.c            | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 6aef8dd..abb6b0f 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -56,9 +56,13 @@
 /* We only yield to the hypervisor if we are in shared processor mode */
 #define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
 extern void __spin_yield(arch_spinlock_t *lock);
+extern void __spin_yield_cpu(int cpu, int confer);
+extern void __spin_wake_cpu(int cpu);
 extern void __rw_yield(arch_rwlock_t *lock);
 #else /* SPLPAR */
 #define __spin_yield(x)	barrier()
+#define __spin_yield_cpu(x,y) barrier()
+#define __spin_wake_cpu(x) barrier()
 #define __rw_yield(x)	barrier()
 #define SHARED_PROCESSOR	0
 #endif
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 6574626..892df7d 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -23,6 +23,65 @@
 #include <asm/hvcall.h>
 #include <asm/smp.h>
 
+/*
+ * confer our slices to a specified cpu and return. If it is already running or
+ * cpu is -1, then we will check confer. If confer is NULL, we will return
+ * otherwise we confer our slices to lpar.
+ */
+void __spin_yield_cpu(int cpu, int confer)
+{
+	unsigned int holder_cpu = cpu, yield_count;
+
+	if (cpu == -1)
+		goto yield_to_lpar;
+
+	BUG_ON(holder_cpu >= nr_cpu_ids);
+	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
+
+	/* if cpu is running, confer slices to lpar conditionally*/
+	if ((yield_count & 1) == 0)
+		goto yield_to_lpar;
+
+	plpar_hcall_norets(H_CONFER,
+		get_hard_smp_processor_id(holder_cpu), yield_count);
+	return;
+
+yield_to_lpar:
+	if (confer)
+		plpar_hcall_norets(H_CONFER, -1, 0);
+}
+EXPORT_SYMBOL_GPL(__spin_yield_cpu);
+
+void __spin_wake_cpu(int cpu)
+{
+	unsigned int holder_cpu = cpu;
+
+	BUG_ON(holder_cpu >= nr_cpu_ids);
+	/*
+	 * NOTE: we should always do this hcall regardless of
+	 * the yield_count of the holder_cpu.
+	 * as thers might be a case like below;
+	 * CPU 	1				2
+	 *				yielded = true
+	 *	if (yielded)
+	 * 	__spin_wake_cpu()
+	 * 				__spin_yield_cpu()
+	 *
+	 * So we might lose a wake if we check the yield_count and
+	 * return directly if the holder_cpu is running.
+	 * IOW. do NOT code like below.
+	 *  yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
+	 *  if ((yield_count & 1) == 0)
+	 *  	return;
+	 *
+	 * a PROD hcall marks the target_cpu proded, which cause the next cede or confer
+	 * called on the target_cpu invalid.
+	 */
+	plpar_hcall_norets(H_PROD,
+		get_hard_smp_processor_id(holder_cpu));
+}
+EXPORT_SYMBOL_GPL(__spin_wake_cpu);
+
 #ifndef CONFIG_QUEUED_SPINLOCKS
 void __spin_yield(arch_spinlock_t *lock)
 {
-- 
2.4.11
