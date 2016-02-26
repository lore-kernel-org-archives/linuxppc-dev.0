Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 910641A0B8E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:21 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C3C88140307
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:20 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:19 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 904261FF002A
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:29:15 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIf6cu45744286
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:06 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIf4Ek017032
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:05 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 04/14] KVM: PPC: Book3S HV: Introduce kvmppc_passthru_irqmap
Date: Fri, 26 Feb 2016 12:40:22 -0600
Message-Id: <1456512032-31286-5-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces an IRQ mapping structure, the
kvmppc_passthru_irqmap structure that is to be used
to map the real hardware IRQ in the host with the virtual
hardware IRQ (gsi) that is injected into a guest by KVM for
passthrough adapters.

Currently, we assume a separate IRQ mapping structure for
each guest. Each kvmppc_passthru_irqmap has two mapping arrays,
the mapped array contains all defined real<->virtual IRQs, the
cached array can be used to limit the real<->virtual IRQs to
a smaller subset, like a cache of the most frequently used
mappings.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h | 21 +++++++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  | 15 +++++++++++++++
 arch/powerpc/kvm/book3s_hv.c        | 19 +++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ffdbc2d..fc10248 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -191,6 +191,8 @@ struct kvmppc_spapr_tce_table {
 struct kvmppc_xics;
 struct kvmppc_icp;
 
+struct kvmppc_passthru_irqmap;
+
 /*
  * The reverse mapping array has one entry for each HPTE,
  * which stores the guest's view of the second word of the HPTE
@@ -261,6 +263,7 @@ struct kvm_arch {
 #endif
 #ifdef CONFIG_KVM_XICS
 	struct kvmppc_xics *xics;
+	struct kvmppc_passthru_irqmap *pimap;
 #endif
 	struct kvmppc_ops *kvm_ops;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -391,6 +394,24 @@ struct kvmhv_tb_accumulator {
 	u64	tb_max;		/* max time */
 };
 
+#ifdef CONFIG_PPC_BOOK3S_64
+struct kvmppc_irq_map {
+	u32	r_hwirq;
+	u32	v_hwirq;
+	struct irq_desc *desc;
+};
+
+#define	KVMPPC_PIRQ_CACHED	16
+#define	KVMPPC_PIRQ_MAPPED	1024
+struct kvmppc_passthru_irqmap {
+	int n_cached;
+	int n_mapped;
+	struct irq_chip *irq_chip;
+	struct kvmppc_irq_map cached[KVMPPC_PIRQ_CACHED];
+	struct kvmppc_irq_map mapped[KVMPPC_PIRQ_MAPPED];
+};
+#endif
+
 # ifdef CONFIG_PPC_FSL_BOOK3E
 #define KVMPPC_BOOKE_IAC_NUM	2
 #define KVMPPC_BOOKE_DAC_NUM	2
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 780a017..75d4c64 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -457,8 +457,19 @@ static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.irq_type == KVMPPC_IRQ_XICS;
 }
+
+static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
+				struct kvm_vcpu *vcpu)
+{
+	if (vcpu)
+		return vcpu->kvm->arch.pimap;
+	else
+		return NULL;
+}
+
 extern void kvmppc_alloc_host_rm_ops(void);
 extern void kvmppc_free_host_rm_ops(void);
+extern void kvmppc_free_pimap(struct kvm *kvm);
 extern void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu);
 extern int kvmppc_xics_create_icp(struct kvm_vcpu *vcpu, unsigned long server);
 extern int kvm_vm_ioctl_xics_irq(struct kvm *kvm, struct kvm_irq_level *args);
@@ -470,8 +481,12 @@ extern int kvmppc_xics_connect_vcpu(struct kvm_device *dev,
 extern void kvmppc_xics_ipi_action(void);
 extern int h_ipi_redirect;
 #else
+static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
+				struct kvm_vcpu *vcpu)
+	{ return NULL; }
 static inline void kvmppc_alloc_host_rm_ops(void) {};
 static inline void kvmppc_free_host_rm_ops(void) {};
+static inline void kvmppc_free_pimap(struct kvm *kvm) {};
 static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 	{ return 0; }
 static inline void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu) { }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f47fffe..22d3054 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3275,6 +3275,25 @@ static int kvmppc_core_check_processor_compat_hv(void)
 	return 0;
 }
 
+#ifdef CONFIG_KVM_XICS
+
+void kvmppc_free_pimap(struct kvm *kvm)
+{
+	kfree(kvm->arch.pimap);
+}
+
+struct kvmppc_passthru_irqmap *kvmppc_alloc_pimap(struct irq_desc *desc)
+{
+	struct kvmppc_passthru_irqmap *pimap;
+
+	pimap = kzalloc(sizeof(struct kvmppc_passthru_irqmap), GFP_KERNEL);
+	if (pimap != NULL)
+		pimap->irq_chip = irq_data_get_irq_chip(&desc->irq_data);
+
+	return pimap;
+}
+#endif
+
 static long kvm_arch_vm_ioctl_hv(struct file *filp,
 				 unsigned int ioctl, unsigned long arg)
 {
-- 
1.8.3.4
