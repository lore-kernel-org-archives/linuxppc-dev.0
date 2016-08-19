Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBw3FJZzDr8k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:08 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 04/13] KVM: PPC: Book3S HV: Introduce kvmppc_passthru_irqmap
Date: Fri, 19 Aug 2016 15:35:48 +1000
Message-Id: <1471584957-21484-5-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
References: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suresh Warrier <warrier@linux.vnet.ibm.com>

This patch introduces an IRQ mapping structure, the
kvmppc_passthru_irqmap structure that is to be used
to map the real hardware IRQ in the host with the virtual
hardware IRQ (gsi) that is injected into a guest by KVM for
passthrough adapters.

Currently, we assume a separate IRQ mapping structure for
each guest. Each kvmppc_passthru_irqmap has a mapping arrays,
containing all defined real<->virtual IRQs.

[paulus@ozlabs.org - removed irq_chip field from struct
 kvmppc_passthru_irqmap; changed parameter for
 kvmppc_get_passthru_irqmap from struct kvm_vcpu * to struct
 kvm *, removed small cached array.]

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_host.h | 17 +++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  | 14 ++++++++++++++
 arch/powerpc/kvm/book3s_hv.c        | 13 +++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ec35af3..3eb5092 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -197,6 +197,8 @@ struct kvmppc_spapr_tce_table {
 struct kvmppc_xics;
 struct kvmppc_icp;
 
+struct kvmppc_passthru_irqmap;
+
 /*
  * The reverse mapping array has one entry for each HPTE,
  * which stores the guest's view of the second word of the HPTE
@@ -267,6 +269,7 @@ struct kvm_arch {
 #endif
 #ifdef CONFIG_KVM_XICS
 	struct kvmppc_xics *xics;
+	struct kvmppc_passthru_irqmap *pimap;
 #endif
 	struct kvmppc_ops *kvm_ops;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -397,6 +400,20 @@ struct kvmhv_tb_accumulator {
 	u64	tb_max;		/* max time */
 };
 
+#ifdef CONFIG_PPC_BOOK3S_64
+struct kvmppc_irq_map {
+	u32	r_hwirq;
+	u32	v_hwirq;
+	struct irq_desc *desc;
+};
+
+#define	KVMPPC_PIRQ_MAPPED	1024
+struct kvmppc_passthru_irqmap {
+	int n_mapped;
+	struct kvmppc_irq_map mapped[KVMPPC_PIRQ_MAPPED];
+};
+#endif
+
 # ifdef CONFIG_PPC_FSL_BOOK3E
 #define KVMPPC_BOOKE_IAC_NUM	2
 #define KVMPPC_BOOKE_DAC_NUM	2
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 94715e2..4ca2ba3 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -457,8 +457,18 @@ static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.irq_type == KVMPPC_IRQ_XICS;
 }
+
+static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
+				struct kvm *kvm)
+{
+	if (kvm)
+		return kvm->arch.pimap;
+	return NULL;
+}
+
 extern void kvmppc_alloc_host_rm_ops(void);
 extern void kvmppc_free_host_rm_ops(void);
+extern void kvmppc_free_pimap(struct kvm *kvm);
 extern void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu);
 extern int kvmppc_xics_create_icp(struct kvm_vcpu *vcpu, unsigned long server);
 extern int kvm_vm_ioctl_xics_irq(struct kvm *kvm, struct kvm_irq_level *args);
@@ -470,8 +480,12 @@ extern int kvmppc_xics_connect_vcpu(struct kvm_device *dev,
 extern void kvmppc_xics_ipi_action(void);
 extern int h_ipi_redirect;
 #else
+static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
+				struct kvm *kvm)
+	{ return NULL; }
 static inline void kvmppc_alloc_host_rm_ops(void) {};
 static inline void kvmppc_free_host_rm_ops(void) {};
+static inline void kvmppc_free_pimap(struct kvm *kvm) {};
 static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 	{ return 0; }
 static inline void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu) { }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2fd5580..413b5c2f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3282,6 +3282,19 @@ static int kvmppc_core_check_processor_compat_hv(void)
 	return 0;
 }
 
+#ifdef CONFIG_KVM_XICS
+
+void kvmppc_free_pimap(struct kvm *kvm)
+{
+	kfree(kvm->arch.pimap);
+}
+
+struct kvmppc_passthru_irqmap *kvmppc_alloc_pimap(void)
+{
+	return kzalloc(sizeof(struct kvmppc_passthru_irqmap), GFP_KERNEL);
+}
+#endif
+
 static long kvm_arch_vm_ioctl_hv(struct file *filp,
 				 unsigned int ioctl, unsigned long arg)
 {
-- 
2.8.1
