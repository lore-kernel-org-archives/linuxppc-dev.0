Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4D8E1A1A1D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 07:59:41 +1100 (AEDT)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E565140B9A
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2015 07:59:40 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 13:59:39 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2710D19D8047
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:47:40 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHKxZ1c20447290
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:35 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHKxZYt015463
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:35 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v3 8/9] KVM: PPC: Book3S HV: Send IPI to host core to wake VCPU
Date: Thu, 17 Dec 2015 14:59:10 -0600
Message-Id: <1450385951-25128-9-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support to real-mode KVM to search for a core
running in the host partition and send it an IPI message with
VCPU to be woken. This avoids having to switch to the host
partition to complete an H_IPI hypercall when the VCPU which
is the target of the the H_IPI is not loaded (is not running
in the guest).

The patch also includes the support in the IPI handler running
in the host to do the wakeup by calling kvmppc_xics_ipi_action
for the PPC_MSG_RM_HOST_ACTION message.

When a guest is being destroyed, we need to ensure that there
are no pending IPIs waiting to wake up a VCPU before we free
the VCPUs of the guest. This is accomplished by:
- Forces a PPC_MSG_CALL_FUNCTION IPI to be completed by all CPUs
  before freeing any VCPUs in kvm_arch_destroy_vm()
- Any PPC_MSG_RM_HOST_ACTION messages must be executed first
  before any other PPC_MSG_CALL_FUNCTION messages

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c            | 11 +++++
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 81 ++++++++++++++++++++++++++++++++++--
 arch/powerpc/kvm/powerpc.c           | 10 +++++
 3 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e222efc..cb8be5d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -257,6 +257,17 @@ irqreturn_t smp_ipi_demux(void)
 
 	do {
 		all = xchg(&info->messages, 0);
+#if defined(CONFIG_KVM_XICS) && defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
+		/*
+		 * Must check for PPC_MSG_RM_HOST_ACTION messages
+		 * before PPC_MSG_CALL_FUNCTION messages because when
+		 * a VM is destroyed, we call kick_all_cpus_sync()
+		 * to ensure that any pending PPC_MSG_RM_HOST_ACTION
+		 * messages have completed before we free any VCPUs.
+		 */
+		if (all & IPI_MESSAGE(PPC_MSG_RM_HOST_ACTION))
+			kvmppc_xics_ipi_action();
+#endif
 		if (all & IPI_MESSAGE(PPC_MSG_CALL_FUNCTION))
 			generic_smp_call_function_interrupt();
 		if (all & IPI_MESSAGE(PPC_MSG_RESCHEDULE))
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 43ffbfe..a8ca3ed 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -51,11 +51,70 @@ static void ics_rm_check_resend(struct kvmppc_xics *xics,
 
 /* -- ICP routines -- */
 
+/*
+ * We start the search from our current CPU Id in the core map
+ * and go in a circle until we get back to our ID looking for a
+ * core that is running in host context and that hasn't already
+ * been targeted for another rm_host_ops.
+ *
+ * In the future, could consider using a fairer algorithm (one
+ * that distributes the IPIs better)
+ *
+ * Returns -1, if no CPU could be found in the host
+ * Else, returns a CPU Id which has been reserved for use
+ */
+static inline int grab_next_hostcore(int start,
+		struct kvmppc_host_rm_core *rm_core, int max, int action)
+{
+	bool success;
+	int core;
+	union kvmppc_rm_state old, new;
+
+	for (core = start + 1; core < max; core++)  {
+		old = new = READ_ONCE(rm_core[core].rm_state);
+
+		if (!old.in_host || old.rm_action)
+			continue;
+
+		/* Try to grab this host core if not taken already. */
+		new.rm_action = action;
+
+		success = cmpxchg64(&rm_core[core].rm_state.raw,
+						old.raw, new.raw) == old.raw;
+		if (success) {
+			/*
+			 * Make sure that the store to the rm_action is made
+			 * visible before we return to caller (and the
+			 * subsequent store to rm_data) to synchronize with
+			 * the IPI handler.
+			 */
+			smp_wmb();
+			return core;
+		}
+	}
+
+	return -1;
+}
+
+static inline int find_available_hostcore(int action)
+{
+	int core;
+	int my_core = smp_processor_id() >> threads_shift;
+	struct kvmppc_host_rm_core *rm_core = kvmppc_host_rm_ops_hv->rm_core;
+
+	core = grab_next_hostcore(my_core, rm_core, cpu_nr_cores(), action);
+	if (core == -1)
+		core = grab_next_hostcore(core, rm_core, my_core, action);
+
+	return core;
+}
+
 static void icp_rm_set_vcpu_irq(struct kvm_vcpu *vcpu,
 				struct kvm_vcpu *this_vcpu)
 {
 	struct kvmppc_icp *this_icp = this_vcpu->arch.icp;
 	int cpu;
+	int hcore, hcpu;
 
 	/* Mark the target VCPU as having an interrupt pending */
 	vcpu->stat.queue_intr++;
@@ -67,11 +126,25 @@ static void icp_rm_set_vcpu_irq(struct kvm_vcpu *vcpu,
 		return;
 	}
 
-	/* Check if the core is loaded, if not, too hard */
+	/*
+	 * Check if the core is loaded,
+	 * if not, find an available host core to post to wake the VCPU,
+	 * if we can't find one, set up state to eventually return too hard.
+	 */
 	cpu = vcpu->arch.thread_cpu;
 	if (cpu < 0 || cpu >= nr_cpu_ids) {
-		this_icp->rm_action |= XICS_RM_KICK_VCPU;
-		this_icp->rm_kick_target = vcpu;
+		hcore = -1;
+		if (kvmppc_host_rm_ops_hv)
+			hcore = find_available_hostcore(XICS_RM_KICK_VCPU);
+		if (hcore != -1) {
+			hcpu = hcore << threads_shift;
+			kvmppc_host_rm_ops_hv->rm_core[hcore].rm_data = vcpu;
+			smp_muxed_ipi_set_message(hcpu, PPC_MSG_RM_HOST_ACTION);
+			icp_native_cause_ipi_rm(hcpu);
+		} else {
+			this_icp->rm_action |= XICS_RM_KICK_VCPU;
+			this_icp->rm_kick_target = vcpu;
+		}
 		return;
 	}
 
@@ -655,7 +728,9 @@ void kvmppc_xics_ipi_action(void)
 	if (rm_corep->rm_data) {
 		rm_host_ipi_action(rm_corep->rm_state.rm_action,
 							rm_corep->rm_data);
+		/* Order these stores against the real mode KVM */
 		rm_corep->rm_data = NULL;
+		smp_wmb();
 		rm_corep->rm_state.rm_action = 0;
 	}
 }
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 6fd2405..6f7cc9e 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -437,6 +437,16 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
 
+#ifdef CONFIG_KVM_XICS
+	/*
+	 * We call kick_all_cpus_sync() to ensure that all
+	 * CPUs have executed any pending IPIs before we
+	 * continue and free VCPUs structures below.
+	 */
+	if (is_kvmppc_hv_enabled(kvm))
+		kick_all_cpus_sync();
+#endif
+
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_arch_vcpu_free(vcpu);
 
-- 
1.8.3.4
