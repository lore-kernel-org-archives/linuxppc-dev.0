Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7CE81A0384
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 10:45:20 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D9C14140307
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 10:45:19 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 16:45:18 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 329BC1FF0021
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:33:27 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAPNjFs226869870
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:45:15 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAPNjEEm022838
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:45:15 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v2 4/9] KVM: PPC: Book3S HV: Host-side RM data structures
Date: Wed, 25 Nov 2015 17:44:51 -0600
Message-Id: <1448495096-24759-5-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1448495096-24759-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1448495096-24759-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch defines the data structures to support the setting up
of host side operations while running in real mode in the guest,
and also the functions to allocate and free it.

The operations are for now limited to virtual XICS operations.
Currently, we have only defined one operation in the data
structure:
         - Wake up a VCPU sleeping in the host when it
           receives a virtual interrupt

The operations are assigned at the core level because PowerKVM
requires that the host run in SMT off mode. For each core,
we will need to manage its state atomically - where the state
is defined by:
1. Is the core running in the host?
2. Is there a Real Mode (RM) operation pending on the host?

Currently, core state is only managed at the whole-core level
even when the system is in split-core mode. This just limits
the number of free or "available" cores in the host to perform
any host-side operations.

The kvmppc_host_rm_core.rm_data allows any data to be passed by
KVM in real mode to the host core along with the operation to
be performed.

The kvmppc_host_rm_ops structure is allocated the very first time
a guest VM is started. Initial core state is also set - all online
cores are in the host. This structure is never deleted, not even
when there are no active guests. However, it needs to be freed
when the module is unloaded because the kvmppc_host_rm_ops_hv
can contain function pointers to kvm-hv.ko functions for the
different supported host operations.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h   | 31 ++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c         | 70 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_builtin.c |  3 ++
 3 files changed, 104 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index c6ef05b..47cd441 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -437,6 +437,8 @@ static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.irq_type == KVMPPC_IRQ_XICS;
 }
+extern void kvmppc_alloc_host_rm_ops(void);
+extern void kvmppc_free_host_rm_ops(void);
 extern void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu);
 extern int kvmppc_xics_create_icp(struct kvm_vcpu *vcpu, unsigned long server);
 extern int kvm_vm_ioctl_xics_irq(struct kvm *kvm, struct kvm_irq_level *args);
@@ -446,6 +448,8 @@ extern int kvmppc_xics_set_icp(struct kvm_vcpu *vcpu, u64 icpval);
 extern int kvmppc_xics_connect_vcpu(struct kvm_device *dev,
 			struct kvm_vcpu *vcpu, u32 cpu);
 #else
+static inline void kvmppc_alloc_host_rm_ops(void) {};
+static inline void kvmppc_free_host_rm_ops(void) {};
 static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 	{ return 0; }
 static inline void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu) { }
@@ -459,6 +463,33 @@ static inline int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd)
 	{ return 0; }
 #endif
 
+/*
+ * Host-side operations we want to set up while running in real
+ * mode in the guest operating on the xics.
+ * Currently only VCPU wakeup is supported.
+ */
+
+union kvmppc_rm_state {
+	unsigned long raw;
+	struct {
+		u32 in_host;
+		u32 rm_action;
+	};
+};
+
+struct kvmppc_host_rm_core {
+	union kvmppc_rm_state rm_state;
+	void *rm_data;
+	char pad[112];
+};
+
+struct kvmppc_host_rm_ops {
+	struct kvmppc_host_rm_core	*rm_core;
+	void		(*vcpu_kick)(struct kvm_vcpu *vcpu);
+};
+
+extern struct kvmppc_host_rm_ops *kvmppc_host_rm_ops_hv;
+
 static inline unsigned long kvmppc_get_epr(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_KVM_BOOKE_HV
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 54b45b7..4042623 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2967,6 +2967,73 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 	goto out_srcu;
 }
 
+#ifdef CONFIG_KVM_XICS
+/*
+ * Allocate a per-core structure for managing state about which cores are
+ * running in the host versus the guest and for exchanging data between
+ * real mode KVM and CPU running in the host.
+ * This is only done for the first VM.
+ * The allocated structure stays even if all VMs have stopped.
+ * It is only freed when the kvm-hv module is unloaded.
+ * It's OK for this routine to fail, we just don't support host
+ * core operations like redirecting H_IPI wakeups.
+ */
+void kvmppc_alloc_host_rm_ops(void)
+{
+	struct kvmppc_host_rm_ops *ops;
+	unsigned long l_ops;
+	int cpu, core;
+	int size;
+
+	/* Not the first time here ? */
+	if (kvmppc_host_rm_ops_hv != NULL)
+		return;
+
+	ops = kzalloc(sizeof(struct kvmppc_host_rm_ops), GFP_KERNEL);
+	if (!ops)
+		return;
+
+	size = cpu_nr_cores() * sizeof(struct kvmppc_host_rm_core);
+	ops->rm_core = kzalloc(size, GFP_KERNEL);
+
+	if (!ops->rm_core) {
+		kfree(ops);
+		return;
+	}
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu += threads_per_core) {
+		if (!cpu_online(cpu))
+			continue;
+
+		core = cpu >> threads_shift;
+		ops->rm_core[core].rm_state.in_host = 1;
+	}
+
+	/*
+	 * Make the contents of the kvmppc_host_rm_ops structure visible
+	 * to other CPUs before we assign it to the global variable.
+	 * Do an atomic assignment (no locks used here), but if someone
+	 * beats us to it, just free our copy and return.
+	 */
+	smp_wmb();
+	l_ops = (unsigned long) ops;
+
+	if (cmpxchg64((unsigned long *)&kvmppc_host_rm_ops_hv, 0, l_ops)) {
+		kfree(ops->rm_core);
+		kfree(ops);
+	}
+}
+
+void kvmppc_free_host_rm_ops(void)
+{
+	if (kvmppc_host_rm_ops_hv) {
+		kfree(kvmppc_host_rm_ops_hv->rm_core);
+		kfree(kvmppc_host_rm_ops_hv);
+		kvmppc_host_rm_ops_hv = NULL;
+	}
+}
+#endif
+
 static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 {
 	unsigned long lpcr, lpid;
@@ -2979,6 +3046,8 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 		return -ENOMEM;
 	kvm->arch.lpid = lpid;
 
+	kvmppc_alloc_host_rm_ops();
+
 	/*
 	 * Since we don't flush the TLB when tearing down a VM,
 	 * and this lpid might have previously been used,
@@ -3212,6 +3281,7 @@ static int kvmppc_book3s_init_hv(void)
 
 static void kvmppc_book3s_exit_hv(void)
 {
+	kvmppc_free_host_rm_ops();
 	kvmppc_hv_ops = NULL;
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index fd7006b..5f0380d 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -283,3 +283,6 @@ void kvmhv_commence_exit(int trap)
 			kvmhv_interrupt_vcore(vc, ee);
 	}
 }
+
+struct kvmppc_host_rm_ops *kvmppc_host_rm_ops_hv;
+EXPORT_SYMBOL_GPL(kvmppc_host_rm_ops_hv);
-- 
1.8.3.4
