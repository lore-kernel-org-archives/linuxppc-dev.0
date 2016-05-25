Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF4xr0wHczDqTG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:21:52 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 25 May 2016 18:21:51 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 631B32BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:21:48 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4P8LZtv36569196
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:21:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4P8KDsm015248
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:20:14 +1000
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com,
 rusty@rustcorp.com.au, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v3 3/6] powerpc: lib/locks.c: Add cpu yield/wake helper
 function
Date: Wed, 25 May 2016 16:18:06 +0800
Message-Id: <1464164289-6124-4-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
1.9.1
