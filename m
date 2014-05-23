Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8F761A0547
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 18:15:41 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH v2 1/6] KVM: PPC: Book3S HV: Rework the secondary inhibit code
Date: Fri, 23 May 2014 18:15:25 +1000
Message-Id: <1400832930-17050-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1400832930-17050-1-git-send-email-mikey@neuling.org>
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

As part of the support for split core on POWER8, we want to be able to
block splitting of the core while KVM VMs are active.

The logic to do that would be exactly the same as the code we currently
have for inhibiting onlining of secondaries.

Instead of adding an identical mechanism to block split core, rework the
secondary inhibit code to be a "HV KVM is active" check. We can then use
that in both the cpu hotplug code and the upcoming split core code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Alexander Graf <agraf@suse.de>
Acked-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_ppc.h   |  7 +++++++
 arch/powerpc/include/asm/smp.h       |  8 --------
 arch/powerpc/kernel/smp.c            | 34 +++-------------------------------
 arch/powerpc/kvm/book3s_hv.c         |  8 ++++----
 arch/powerpc/kvm/book3s_hv_builtin.c | 31 +++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 4096f16..2c8e399 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -337,6 +337,10 @@ static inline void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
 	vcpu->kvm->arch.kvm_ops->fast_vcpu_kick(vcpu);
 }
 
+extern void kvm_hv_vm_activated(void);
+extern void kvm_hv_vm_deactivated(void);
+extern bool kvm_hv_mode_active(void);
+
 #else
 static inline void __init kvm_cma_reserve(void)
 {}
@@ -356,6 +360,9 @@ static inline void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
 {
 	kvm_vcpu_kick(vcpu);
 }
+
+static inline bool kvm_hv_mode_active(void)		{ return false; }
+
 #endif
 
 #ifdef CONFIG_KVM_XICS
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index ff51046..5a6614a 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -68,14 +68,6 @@ void generic_mach_cpu_die(void);
 void generic_set_cpu_dead(unsigned int cpu);
 void generic_set_cpu_up(unsigned int cpu);
 int generic_check_cpu_restart(unsigned int cpu);
-
-extern void inhibit_secondary_onlining(void);
-extern void uninhibit_secondary_onlining(void);
-
-#else /* HOTPLUG_CPU */
-static inline void inhibit_secondary_onlining(void) {}
-static inline void uninhibit_secondary_onlining(void) {}
-
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e2a4232..6edae3d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -36,6 +36,7 @@
 #include <linux/atomic.h>
 #include <asm/irq.h>
 #include <asm/hw_irq.h>
+#include <asm/kvm_ppc.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
@@ -457,38 +458,9 @@ int generic_check_cpu_restart(unsigned int cpu)
 	return per_cpu(cpu_state, cpu) == CPU_UP_PREPARE;
 }
 
-static atomic_t secondary_inhibit_count;
-
-/*
- * Don't allow secondary CPU threads to come online
- */
-void inhibit_secondary_onlining(void)
-{
-	/*
-	 * This makes secondary_inhibit_count stable during cpu
-	 * online/offline operations.
-	 */
-	get_online_cpus();
-
-	atomic_inc(&secondary_inhibit_count);
-	put_online_cpus();
-}
-EXPORT_SYMBOL_GPL(inhibit_secondary_onlining);
-
-/*
- * Allow secondary CPU threads to come online again
- */
-void uninhibit_secondary_onlining(void)
-{
-	get_online_cpus();
-	atomic_dec(&secondary_inhibit_count);
-	put_online_cpus();
-}
-EXPORT_SYMBOL_GPL(uninhibit_secondary_onlining);
-
-static int secondaries_inhibited(void)
+static bool secondaries_inhibited(void)
 {
-	return atomic_read(&secondary_inhibit_count);
+	return kvm_hv_mode_active();
 }
 
 #else /* HOTPLUG_CPU */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8227dba..d7b74f8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2317,10 +2317,10 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	spin_lock_init(&kvm->arch.slot_phys_lock);
 
 	/*
-	 * Don't allow secondary CPU threads to come online
-	 * while any KVM VMs exist.
+	 * Track that we now have a HV mode VM active. This blocks secondary
+	 * CPU threads from coming online.
 	 */
-	inhibit_secondary_onlining();
+	kvm_hv_vm_activated();
 
 	return 0;
 }
@@ -2336,7 +2336,7 @@ static void kvmppc_free_vcores(struct kvm *kvm)
 
 static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 {
-	uninhibit_secondary_onlining();
+	kvm_hv_vm_deactivated();
 
 	kvmppc_free_vcores(kvm);
 	if (kvm->arch.rma) {
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 8cd0dae..7cde8a6 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/kvm_host.h>
 #include <linux/preempt.h>
 #include <linux/export.h>
@@ -181,3 +182,33 @@ void __init kvm_cma_reserve(void)
 		kvm_cma_declare_contiguous(selected_size, align_size);
 	}
 }
+
+/*
+ * When running HV mode KVM we need to block certain operations while KVM VMs
+ * exist in the system. We use a counter of VMs to track this.
+ *
+ * One of the operations we need to block is onlining of secondaries, so we
+ * protect hv_vm_count with get/put_online_cpus().
+ */
+static atomic_t hv_vm_count;
+
+void kvm_hv_vm_activated(void)
+{
+	get_online_cpus();
+	atomic_inc(&hv_vm_count);
+	put_online_cpus();
+}
+EXPORT_SYMBOL_GPL(kvm_hv_vm_activated);
+
+void kvm_hv_vm_deactivated(void)
+{
+	get_online_cpus();
+	atomic_dec(&hv_vm_count);
+	put_online_cpus();
+}
+EXPORT_SYMBOL_GPL(kvm_hv_vm_deactivated);
+
+bool kvm_hv_mode_active(void)
+{
+	return atomic_read(&hv_vm_count) != 0;
+}
-- 
1.9.1
