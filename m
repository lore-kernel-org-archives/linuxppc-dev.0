Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL2hw5QHYzDr1L
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 19:57:52 +1000 (AEST)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 03:27:30 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v5 3/6] powerpc: lib/locks.c: Add cpu yield/wake helper
 function
Date: Thu,  2 Jun 2016 17:26:27 +0800
Message-Id: <1464859590-5292-5-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pv-qspinlock core has pv_wait/pv_kick which will give a better
performace by yielding and kicking cpu at some cases.
lets support them by adding two corresponding helper functions.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/spinlock.h |  4 ++++
 arch/powerpc/lib/locks.c            | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 4359ee6..3b65372 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -56,9 +56,13 @@
 /* We only yield to the hypervisor if we are in shared processor mode */
 #define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
 extern void __spin_yield(arch_spinlock_t *lock);
+extern void __spin_yield_cpu(int cpu);
+extern void __spin_wake_cpu(int cpu);
 extern void __rw_yield(arch_rwlock_t *lock);
 #else /* SPLPAR */
 #define __spin_yield(x)	barrier()
+#define __spin_yield_cpu(x) barrier()
+#define __spin_wake_cpu(x) barrier()
 #define __rw_yield(x)	barrier()
 #define SHARED_PROCESSOR	0
 #endif
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index a9ebd71..3a58834 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -23,6 +23,39 @@
 #include <asm/hvcall.h>
 #include <asm/smp.h>
 
+void __spin_yield_cpu(int cpu)
+{
+	unsigned int holder_cpu = cpu, yield_count;
+
+	if (cpu == -1) {
+		plpar_hcall_norets(H_CONFER, -1, 0);
+		return;
+	}
+	BUG_ON(holder_cpu >= nr_cpu_ids);
+	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
+	if ((yield_count & 1) == 0) {
+		/* if target cpu is running, confer slices to lpar*/
+		plpar_hcall_norets(H_CONFER, -1, 0);
+		return;
+	}
+	plpar_hcall_norets(H_CONFER,
+		get_hard_smp_processor_id(holder_cpu), yield_count);
+}
+EXPORT_SYMBOL_GPL(__spin_yield_cpu);
+
+void __spin_wake_cpu(int cpu)
+{
+	unsigned int holder_cpu = cpu, yield_count;
+
+	BUG_ON(holder_cpu >= nr_cpu_ids);
+	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
+	if ((yield_count & 1) == 0)
+		return;		/* virtual cpu is currently running */
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
