Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCNl00nDSzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 12:07:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org
Subject: [PATCH v3] KVM: PPC: Book3S HV: Native usage of the XIVE interrupt
 controller
Date: Wed, 26 Apr 2017 12:07:30 +1000
Message-Id: <1493172450-19636-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch makes KVM capable of using the XIVE interrupt controller
to provide the standard PAPR "XICS" style hypercalls. It is necessary
for proper operations when the host uses XIVE natively.

This has been lightly tested on an actual system, including PCI
pass-through with a TG3 device.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[mpe: Cleanup pr_xxx(), unsplit pr_xxx() strings, etc., fix build
 failures by adding KVM_XIVE which depends on KVM_XICS and XIVE, and
 adding empty stubs for the kvm_xive_xxx() routines, fixup subject]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/kvm_book3s_asm.h |    2 +
 arch/powerpc/include/asm/kvm_host.h       |   28 +-
 arch/powerpc/include/asm/kvm_ppc.h        |   74 ++
 arch/powerpc/include/asm/xive.h           |    9 +-
 arch/powerpc/kernel/asm-offsets.c         |   10 +
 arch/powerpc/kvm/Kconfig                  |    5 +
 arch/powerpc/kvm/Makefile                 |    4 +-
 arch/powerpc/kvm/book3s.c                 |   75 +-
 arch/powerpc/kvm/book3s_hv.c              |   51 +-
 arch/powerpc/kvm/book3s_hv_builtin.c      |  101 ++
 arch/powerpc/kvm/book3s_hv_rm_xics.c      |   10 +-
 arch/powerpc/kvm/book3s_hv_rm_xive.c      |   47 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   62 +-
 arch/powerpc/kvm/book3s_rtas.c            |   21 +-
 arch/powerpc/kvm/book3s_xics.c            |   35 +-
 arch/powerpc/kvm/book3s_xics.h            |    5 +
 arch/powerpc/kvm/book3s_xive.c            | 1893 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_xive.h            |  254 ++++
 arch/powerpc/kvm/book3s_xive_template.c   |  503 ++++++++
 arch/powerpc/kvm/irq.h                    |    1 +
 arch/powerpc/kvm/powerpc.c                |   17 +-
 arch/powerpc/platforms/powernv/opal.c     |    1 +
 arch/powerpc/sysdev/xive/common.c         |  142 ++-
 arch/powerpc/sysdev/xive/native.c         |   84 +-
 include/linux/kvm_host.h                  |    1 -
 virt/kvm/kvm_main.c                       |    4 -
 26 files changed, 3350 insertions(+), 89 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_hv_rm_xive.c
 create mode 100644 arch/powerpc/kvm/book3s_xive.c
 create mode 100644 arch/powerpc/kvm/book3s_xive.h
 create mode 100644 arch/powerpc/kvm/book3s_xive_template.c

v3: As mentioned in the change log:
    Cleanup pr_xxx(), unsplit pr_xxx() strings, etc., fix build failures by
    adding KVM_XIVE which depends on KVM_XICS and XIVE, and adding empty stubs
    for the kvm_xive_xxx() routines, fixup subject.

diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 0593d9479f74..b148496ffe36 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -111,6 +111,8 @@ struct kvmppc_host_state {
 	struct kvm_vcpu *kvm_vcpu;
 	struct kvmppc_vcore *kvm_vcore;
 	void __iomem *xics_phys;
+	void __iomem *xive_tima_phys;
+	void __iomem *xive_tima_virt;
 	u32 saved_xirr;
 	u64 dabr;
 	u64 host_mmcr[7];	/* MMCR 0,1,A, SIAR, SDAR, MMCR2, SIER */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7bba8f415627..5a8ab4a758f1 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -205,6 +205,12 @@ struct kvmppc_spapr_tce_table {
 /* XICS components, defined in book3s_xics.c */
 struct kvmppc_xics;
 struct kvmppc_icp;
+extern struct kvm_device_ops kvm_xics_ops;
+
+/* XIVE components, defined in book3s_xive.c */
+struct kvmppc_xive;
+struct kvmppc_xive_vcpu;
+extern struct kvm_device_ops kvm_xive_ops;
 
 struct kvmppc_passthru_irqmap;
 
@@ -293,6 +299,7 @@ struct kvm_arch {
 #endif
 #ifdef CONFIG_KVM_XICS
 	struct kvmppc_xics *xics;
+	struct kvmppc_xive *xive;
 	struct kvmppc_passthru_irqmap *pimap;
 #endif
 	struct kvmppc_ops *kvm_ops;
@@ -421,7 +428,7 @@ struct kvmppc_passthru_irqmap {
 
 #define KVMPPC_IRQ_DEFAULT	0
 #define KVMPPC_IRQ_MPIC		1
-#define KVMPPC_IRQ_XICS		2
+#define KVMPPC_IRQ_XICS		2 /* Includes a XIVE option */
 
 #define MMIO_HPTE_CACHE_SIZE	4
 
@@ -443,6 +450,21 @@ struct mmio_hpte_cache {
 
 struct openpic;
 
+/* W0 and W1 of a XIVE thread management context */
+union xive_tma_w01 {
+	struct {
+		u8	nsr;
+		u8	cppr;
+		u8	ipb;
+		u8	lsmfb;
+		u8	ack;
+		u8	inc;
+		u8	age;
+		u8	pipr;
+	};
+	__be64 w01;
+};
+
 struct kvm_vcpu_arch {
 	ulong host_stack;
 	u32 host_pid;
@@ -688,6 +710,10 @@ struct kvm_vcpu_arch {
 	struct openpic *mpic;	/* KVM_IRQ_MPIC */
 #ifdef CONFIG_KVM_XICS
 	struct kvmppc_icp *icp; /* XICS presentation controller */
+	struct kvmppc_xive_vcpu *xive_vcpu; /* XIVE virtual CPU data */
+	__be32 xive_cam_word;    /* Cooked W2 in proper endian with valid bit */
+	u32 xive_pushed;	 /* Is the VP pushed on the physical CPU ? */
+	union xive_tma_w01 xive_saved_state; /* W0..1 of XIVE thread state */
 #endif
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index c3877992eff9..ed52b13d9ffb 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -225,6 +225,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq);
 extern int kvm_vm_ioctl_rtas_define_token(struct kvm *kvm, void __user *argp);
 extern int kvmppc_rtas_hcall(struct kvm_vcpu *vcpu);
 extern void kvmppc_rtas_tokens_free(struct kvm *kvm);
+
 extern int kvmppc_xics_set_xive(struct kvm *kvm, u32 irq, u32 server,
 				u32 priority);
 extern int kvmppc_xics_get_xive(struct kvm *kvm, u32 irq, u32 *server,
@@ -412,6 +413,14 @@ static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
 	paca[cpu].kvm_hstate.xics_phys = (void __iomem *)addr;
 }
 
+static inline void kvmppc_set_xive_tima(int cpu,
+					unsigned long phys_addr,
+					void __iomem *virt_addr)
+{
+	paca[cpu].kvm_hstate.xive_tima_phys = (void __iomem *)phys_addr;
+	paca[cpu].kvm_hstate.xive_tima_virt = virt_addr;
+}
+
 static inline u32 kvmppc_get_xics_latch(void)
 {
 	u32 xirr;
@@ -442,6 +451,11 @@ static inline void __init kvm_cma_reserve(void)
 static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
 {}
 
+static inline void kvmppc_set_xive_tima(int cpu,
+					unsigned long phys_addr,
+					void __iomem *virt_addr)
+{}
+
 static inline u32 kvmppc_get_xics_latch(void)
 {
 	return 0;
@@ -492,6 +506,10 @@ extern long kvmppc_deliver_irq_passthru(struct kvm_vcpu *vcpu, __be32 xirr,
 					struct kvmppc_irq_map *irq_map,
 					struct kvmppc_passthru_irqmap *pimap,
 					bool *again);
+
+extern int kvmppc_xics_set_irq(struct kvm *kvm, int irq_source_id, u32 irq,
+			       int level, bool line_status);
+
 extern int h_ipi_redirect;
 #else
 static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
@@ -509,6 +527,60 @@ static inline int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd)
 	{ return 0; }
 #endif
 
+#ifdef CONFIG_KVM_XIVE
+/*
+ * Below the first "xive" is the "eXternal Interrupt Virtualization Engine"
+ * ie. P9 new interrupt controller, while the second "xive" is the legacy
+ * "eXternal Interrupt Vector Entry" which is the configuration of an
+ * interrupt on the "xics" interrupt controller on P8 and earlier. Those
+ * two function consume or produce a legacy "XIVE" state from the
+ * new "XIVE" interrupt controller.
+ */
+extern int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
+				u32 priority);
+extern int kvmppc_xive_get_xive(struct kvm *kvm, u32 irq, u32 *server,
+				u32 *priority);
+extern int kvmppc_xive_int_on(struct kvm *kvm, u32 irq);
+extern int kvmppc_xive_int_off(struct kvm *kvm, u32 irq);
+extern void kvmppc_xive_init_module(void);
+extern void kvmppc_xive_exit_module(void);
+
+extern int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
+				    struct kvm_vcpu *vcpu, u32 cpu);
+extern void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu);
+extern int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
+				  struct irq_desc *host_desc);
+extern int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
+				  struct irq_desc *host_desc);
+extern u64 kvmppc_xive_get_icp(struct kvm_vcpu *vcpu);
+extern int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval);
+
+extern int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 irq,
+			       int level, bool line_status);
+#else
+static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
+				       u32 priority) { return -1; }
+static inline int kvmppc_xive_get_xive(struct kvm *kvm, u32 irq, u32 *server,
+				       u32 *priority) { return -1; }
+static inline int kvmppc_xive_int_on(struct kvm *kvm, u32 irq) { return -1; }
+static inline int kvmppc_xive_int_off(struct kvm *kvm, u32 irq) { return -1; }
+static inline void kvmppc_xive_init_module(void) { }
+static inline void kvmppc_xive_exit_module(void) { }
+
+static inline int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
+					   struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
+static inline void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
+static inline int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
+					 struct irq_desc *host_desc) { return -ENODEV; }
+static inline int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
+					 struct irq_desc *host_desc) { return -ENODEV; }
+static inline u64 kvmppc_xive_get_icp(struct kvm_vcpu *vcpu) { return 0; }
+static inline int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval) { return -ENOENT; }
+
+static inline int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 irq,
+				      int level, bool line_status) { return -ENODEV; }
+#endif /* CONFIG_KVM_XIVE */
+
 /*
  * Prototypes for functions called only from assembler code.
  * Having prototypes reduces sparse errors.
@@ -546,6 +618,8 @@ long kvmppc_h_clear_mod(struct kvm_vcpu *vcpu, unsigned long flags,
 long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
                           unsigned long slb_v, unsigned int status, bool data);
 unsigned long kvmppc_rm_h_xirr(struct kvm_vcpu *vcpu);
+unsigned long kvmppc_rm_h_xirr_x(struct kvm_vcpu *vcpu);
+unsigned long kvmppc_rm_h_ipoll(struct kvm_vcpu *vcpu, unsigned long server);
 int kvmppc_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
                     unsigned long mfrr);
 int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 3cdbeaeac397..c8a822acf962 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -99,7 +99,6 @@ struct xive_q {
 #define XIVE_ESB_SET_PQ_01	0xd00
 #define XIVE_ESB_SET_PQ_10	0xe00
 #define XIVE_ESB_SET_PQ_11	0xf00
-#define XIVE_ESB_MASK		XIVE_ESB_SET_PQ_01
 
 #define XIVE_ESB_VAL_P		0x2
 #define XIVE_ESB_VAL_Q		0x1
@@ -136,11 +135,11 @@ extern int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
 				       __be32 *qpage, u32 order, bool can_escalate);
 extern void xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio);
 
-extern bool __xive_irq_trigger(struct xive_irq_data *xd);
-extern bool __xive_irq_retrigger(struct xive_irq_data *xd);
-extern void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd);
-
+extern void xive_native_sync_source(u32 hw_irq);
 extern bool is_xive_irq(struct irq_chip *chip);
+extern int xive_native_enable_vp(u32 vp_id);
+extern int xive_native_disable_vp(u32 vp_id);
+extern int xive_native_get_vp_info(u32 vp_id, u32 *out_cam_id, u32 *out_chip_id);
 
 #else
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4367e7df51a1..1822187813dc 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -630,6 +630,8 @@ int main(void)
 	HSTATE_FIELD(HSTATE_KVM_VCPU, kvm_vcpu);
 	HSTATE_FIELD(HSTATE_KVM_VCORE, kvm_vcore);
 	HSTATE_FIELD(HSTATE_XICS_PHYS, xics_phys);
+	HSTATE_FIELD(HSTATE_XIVE_TIMA_PHYS, xive_tima_phys);
+	HSTATE_FIELD(HSTATE_XIVE_TIMA_VIRT, xive_tima_virt);
 	HSTATE_FIELD(HSTATE_SAVED_XIRR, saved_xirr);
 	HSTATE_FIELD(HSTATE_HOST_IPI, host_ipi);
 	HSTATE_FIELD(HSTATE_PTID, ptid);
@@ -715,6 +717,14 @@ int main(void)
 	OFFSET(VCPU_HOST_MAS6, kvm_vcpu, arch.host_mas6);
 #endif
 
+#ifdef CONFIG_KVM_XICS
+	DEFINE(VCPU_XIVE_SAVED_STATE, offsetof(struct kvm_vcpu,
+					       arch.xive_saved_state));
+	DEFINE(VCPU_XIVE_CAM_WORD, offsetof(struct kvm_vcpu,
+					    arch.xive_cam_word));
+	DEFINE(VCPU_XIVE_PUSHED, offsetof(struct kvm_vcpu, arch.xive_pushed));
+#endif
+
 #ifdef CONFIG_KVM_EXIT_TIMING
 	OFFSET(VCPU_TIMING_EXIT_TBU, kvm_vcpu, arch.timing_exit.tv32.tbu);
 	OFFSET(VCPU_TIMING_EXIT_TBL, kvm_vcpu, arch.timing_exit.tv32.tbl);
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 029be26b5a17..cd6772722aa8 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -196,6 +196,11 @@ config KVM_XICS
 	  Specification) interrupt controller architecture used on
 	  IBM POWER (pSeries) servers.
 
+config KVM_XIVE
+	bool
+	default y
+	depends on KVM_XICS && XIVE_NATIVE
+
 source drivers/vhost/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index b87ccde2137a..d91a2604c496 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -74,7 +74,7 @@ kvm-hv-y += \
 	book3s_64_mmu_radix.o
 
 kvm-book3s_64-builtin-xics-objs-$(CONFIG_KVM_XICS) := \
-	book3s_hv_rm_xics.o
+	book3s_hv_rm_xics.o book3s_hv_rm_xive.o
 
 ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
@@ -89,6 +89,8 @@ endif
 kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
 	book3s_xics.o
 
+kvm-book3s_64-objs-$(CONFIG_KVM_XIVE) += book3s_xive.o
+
 kvm-book3s_64-module-objs := \
 	$(common-objs-y) \
 	book3s.o \
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index aedacefd961d..cb8009cd688d 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -35,6 +35,7 @@
 #include <asm/kvm_book3s.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/xive.h>
 
 #include "book3s.h"
 #include "trace.h"
@@ -578,11 +579,14 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
 			break;
 #ifdef CONFIG_KVM_XICS
 		case KVM_REG_PPC_ICP_STATE:
-			if (!vcpu->arch.icp) {
+			if (!vcpu->arch.icp && !vcpu->arch.xive_vcpu) {
 				r = -ENXIO;
 				break;
 			}
-			*val = get_reg_val(id, kvmppc_xics_get_icp(vcpu));
+			if (xive_enabled())
+				*val = get_reg_val(id, kvmppc_xive_get_icp(vcpu));
+			else
+				*val = get_reg_val(id, kvmppc_xics_get_icp(vcpu));
 			break;
 #endif /* CONFIG_KVM_XICS */
 		case KVM_REG_PPC_FSCR:
@@ -648,12 +652,14 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_KVM_XICS
 		case KVM_REG_PPC_ICP_STATE:
-			if (!vcpu->arch.icp) {
+			if (!vcpu->arch.icp && !vcpu->arch.xive_vcpu) {
 				r = -ENXIO;
 				break;
 			}
-			r = kvmppc_xics_set_icp(vcpu,
-						set_reg_val(id, *val));
+			if (xive_enabled())
+				r = kvmppc_xive_set_icp(vcpu, set_reg_val(id, *val));
+			else
+				r = kvmppc_xics_set_icp(vcpu, set_reg_val(id, *val));
 			break;
 #endif /* CONFIG_KVM_XICS */
 		case KVM_REG_PPC_FSCR:
@@ -924,6 +930,50 @@ int kvmppc_book3s_hcall_implemented(struct kvm *kvm, unsigned long hcall)
 	return kvm->arch.kvm_ops->hcall_implemented(hcall);
 }
 
+#ifdef CONFIG_KVM_XICS
+int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
+		bool line_status)
+{
+	if (xive_enabled())
+		return kvmppc_xive_set_irq(kvm, irq_source_id, irq, level,
+					   line_status);
+	else
+		return kvmppc_xics_set_irq(kvm, irq_source_id, irq, level,
+					   line_status);
+}
+
+int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *irq_entry,
+			      struct kvm *kvm, int irq_source_id,
+			      int level, bool line_status)
+{
+	return kvm_set_irq(kvm, irq_source_id, irq_entry->gsi,
+			   level, line_status);
+}
+static int kvmppc_book3s_set_irq(struct kvm_kernel_irq_routing_entry *e,
+				 struct kvm *kvm, int irq_source_id, int level,
+				 bool line_status)
+{
+	return kvm_set_irq(kvm, irq_source_id, e->gsi, level, line_status);
+}
+
+int kvm_irq_map_gsi(struct kvm *kvm,
+		    struct kvm_kernel_irq_routing_entry *entries, int gsi)
+{
+	entries->gsi = gsi;
+	entries->type = KVM_IRQ_ROUTING_IRQCHIP;
+	entries->set = kvmppc_book3s_set_irq;
+	entries->irqchip.irqchip = 0;
+	entries->irqchip.pin = gsi;
+	return 1;
+}
+
+int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
+{
+	return pin;
+}
+
+#endif /* CONFIG_KVM_XICS */
+
 static int kvmppc_book3s_init(void)
 {
 	int r;
@@ -934,12 +984,25 @@ static int kvmppc_book3s_init(void)
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	r = kvmppc_book3s_init_pr();
 #endif
-	return r;
 
+#ifdef CONFIG_KVM_XICS
+#ifdef CONFIG_KVM_XIVE
+	if (xive_enabled()) {
+		kvmppc_xive_init_module();
+		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
+	} else
+#endif
+		kvm_register_device_ops(&kvm_xics_ops, KVM_DEV_TYPE_XICS);
+#endif
+	return r;
 }
 
 static void kvmppc_book3s_exit(void)
 {
+#ifdef CONFIG_KVM_XICS
+	if (xive_enabled())
+		kvmppc_xive_exit_module();
+#endif
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	kvmppc_book3s_exit_pr();
 #endif
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index fadb75abfe37..128efb42ec4e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -67,6 +67,7 @@
 #include <asm/mmu.h>
 #include <asm/opal.h>
 #include <asm/xics.h>
+#include <asm/xive.h>
 
 #include "book3s.h"
 
@@ -837,6 +838,10 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 	case H_IPOLL:
 	case H_XIRR_X:
 		if (kvmppc_xics_enabled(vcpu)) {
+			if (xive_enabled()) {
+				ret = H_NOT_AVAILABLE;
+				return RESUME_GUEST;
+			}
 			ret = kvmppc_xics_hcall(vcpu, req);
 			break;
 		}
@@ -2947,8 +2952,12 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			r = kvmppc_book3s_hv_page_fault(run, vcpu,
 				vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
 			srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
-		} else if (r == RESUME_PASSTHROUGH)
-			r = kvmppc_xics_rm_complete(vcpu, 0);
+		} else if (r == RESUME_PASSTHROUGH) {
+			if (WARN_ON(xive_enabled()))
+				r = H_SUCCESS;
+			else
+				r = kvmppc_xics_rm_complete(vcpu, 0);
+		}
 	} while (is_kvmppc_resume_guest(r));
 
  out:
@@ -3400,10 +3409,20 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	/*
 	 * On POWER9, VPM0 bit is reserved (VPM0=1 behaviour is assumed)
 	 * Set HVICE bit to enable hypervisor virtualization interrupts.
+	 * Set HEIC to prevent OS interrupts to go to hypervisor (should
+	 * be unnecessary but better safe than sorry in case we re-enable
+	 * EE in HV mode with this LPCR still set)
 	 */
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		lpcr &= ~LPCR_VPM0;
-		lpcr |= LPCR_HVICE;
+		lpcr |= LPCR_HVICE | LPCR_HEIC;
+
+		/*
+		 * If xive is enabled, we route 0x500 interrupts directly
+		 * to the guest.
+		 */
+		if (xive_enabled())
+			lpcr |= LPCR_LPES;
 	}
 
 	/*
@@ -3533,7 +3552,7 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	struct kvmppc_irq_map *irq_map;
 	struct kvmppc_passthru_irqmap *pimap;
 	struct irq_chip *chip;
-	int i;
+	int i, rc = 0;
 
 	if (!kvm_irq_bypass)
 		return 1;
@@ -3558,10 +3577,10 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	/*
 	 * For now, we only support interrupts for which the EOI operation
 	 * is an OPAL call followed by a write to XIRR, since that's
-	 * what our real-mode EOI code does.
+	 * what our real-mode EOI code does, or a XIVE interrupt
 	 */
 	chip = irq_data_get_irq_chip(&desc->irq_data);
-	if (!chip || !is_pnv_opal_msi(chip)) {
+	if (!chip || !(is_pnv_opal_msi(chip) || is_xive_irq(chip))) {
 		pr_warn("kvmppc_set_passthru_irq_hv: Could not assign IRQ map for (%d,%d)\n",
 			host_irq, guest_gsi);
 		mutex_unlock(&kvm->lock);
@@ -3603,7 +3622,12 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	if (i == pimap->n_mapped)
 		pimap->n_mapped++;
 
-	kvmppc_xics_set_mapped(kvm, guest_gsi, desc->irq_data.hwirq);
+	if (xive_enabled())
+		rc = kvmppc_xive_set_mapped(kvm, guest_gsi, desc);
+	else
+		kvmppc_xics_set_mapped(kvm, guest_gsi, desc->irq_data.hwirq);
+	if (rc)
+		irq_map->r_hwirq = 0;
 
 	mutex_unlock(&kvm->lock);
 
@@ -3614,7 +3638,7 @@ static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 {
 	struct irq_desc *desc;
 	struct kvmppc_passthru_irqmap *pimap;
-	int i;
+	int i, rc = 0;
 
 	if (!kvm_irq_bypass)
 		return 0;
@@ -3641,9 +3665,12 @@ static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 		return -ENODEV;
 	}
 
-	kvmppc_xics_clr_mapped(kvm, guest_gsi, pimap->mapped[i].r_hwirq);
+	if (xive_enabled())
+		rc = kvmppc_xive_clr_mapped(kvm, guest_gsi, pimap->mapped[i].desc);
+	else
+		kvmppc_xics_clr_mapped(kvm, guest_gsi, pimap->mapped[i].r_hwirq);
 
-	/* invalidate the entry */
+	/* invalidate the entry (what do do on error from the above ?) */
 	pimap->mapped[i].r_hwirq = 0;
 
 	/*
@@ -3652,7 +3679,7 @@ static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	 */
 
 	mutex_unlock(&kvm->lock);
-	return 0;
+	return rc;
 }
 
 static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
@@ -3930,7 +3957,7 @@ static int kvmppc_book3s_init_hv(void)
 	 * indirectly, via OPAL.
 	 */
 #ifdef CONFIG_SMP
-	if (!get_paca()->kvm_hstate.xics_phys) {
+	if (!xive_enabled() && !get_paca()->kvm_hstate.xics_phys) {
 		struct device_node *np;
 
 		np = of_find_compatible_node(NULL, NULL, "ibm,opal-intc");
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index a752e29977e0..5c00813e1e0e 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -32,6 +32,24 @@
 
 #define KVM_CMA_CHUNK_ORDER	18
 
+#include "book3s_xics.h"
+#include "book3s_xive.h"
+
+/*
+ * The XIVE module will populate these when it loads
+ */
+unsigned long (*__xive_vm_h_xirr)(struct kvm_vcpu *vcpu);
+unsigned long (*__xive_vm_h_ipoll)(struct kvm_vcpu *vcpu, unsigned long server);
+int (*__xive_vm_h_ipi)(struct kvm_vcpu *vcpu, unsigned long server,
+		       unsigned long mfrr);
+int (*__xive_vm_h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr);
+int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
+EXPORT_SYMBOL_GPL(__xive_vm_h_xirr);
+EXPORT_SYMBOL_GPL(__xive_vm_h_ipoll);
+EXPORT_SYMBOL_GPL(__xive_vm_h_ipi);
+EXPORT_SYMBOL_GPL(__xive_vm_h_cppr);
+EXPORT_SYMBOL_GPL(__xive_vm_h_eoi);
+
 /*
  * Hash page table alignment on newer cpus(CPU_FTR_ARCH_206)
  * should be power of 2.
@@ -210,6 +228,7 @@ void kvmhv_rm_send_ipi(int cpu)
 		__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
 		return;
 	}
+
 	/* On POWER8 for IPIs to threads in the same core, use msgsnd. */
 	if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
 	    cpu_first_thread_sibling(cpu) ==
@@ -406,6 +425,9 @@ static long kvmppc_read_one_intr(bool *again)
 	u8 host_ipi;
 	int64_t rc;
 
+	if (xive_enabled())
+		return 1;
+
 	/* see if a host IPI is pending */
 	host_ipi = local_paca->kvm_hstate.host_ipi;
 	if (host_ipi)
@@ -490,3 +512,82 @@ static long kvmppc_read_one_intr(bool *again)
 
 	return kvmppc_check_passthru(xisr, xirr, again);
 }
+
+static inline bool is_rm(void)
+{
+	return !(mfmsr() & MSR_DR);
+}
+
+unsigned long kvmppc_rm_h_xirr(struct kvm_vcpu *vcpu)
+{
+	if (xive_enabled()) {
+		if (is_rm())
+			return xive_rm_h_xirr(vcpu);
+		if (unlikely(!__xive_vm_h_xirr))
+			return H_NOT_AVAILABLE;
+		return __xive_vm_h_xirr(vcpu);
+	} else
+		return xics_rm_h_xirr(vcpu);
+}
+
+unsigned long kvmppc_rm_h_xirr_x(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.gpr[5] = get_tb();
+	if (xive_enabled()) {
+		if (is_rm())
+			return xive_rm_h_xirr(vcpu);
+		if (unlikely(!__xive_vm_h_xirr))
+			return H_NOT_AVAILABLE;
+		return __xive_vm_h_xirr(vcpu);
+	} else
+		return xics_rm_h_xirr(vcpu);
+}
+
+unsigned long kvmppc_rm_h_ipoll(struct kvm_vcpu *vcpu, unsigned long server)
+{
+	if (xive_enabled()) {
+		if (is_rm())
+			return xive_rm_h_ipoll(vcpu, server);
+		if (unlikely(!__xive_vm_h_ipoll))
+			return H_NOT_AVAILABLE;
+		return __xive_vm_h_ipoll(vcpu, server);
+	} else
+		return H_TOO_HARD;
+}
+
+int kvmppc_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
+		    unsigned long mfrr)
+{
+	if (xive_enabled()) {
+		if (is_rm())
+			return xive_rm_h_ipi(vcpu, server, mfrr);
+		if (unlikely(!__xive_vm_h_ipi))
+			return H_NOT_AVAILABLE;
+		return __xive_vm_h_ipi(vcpu, server, mfrr);
+	} else
+		return xics_rm_h_ipi(vcpu, server, mfrr);
+}
+
+int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr)
+{
+	if (xive_enabled()) {
+		if (is_rm())
+			return xive_rm_h_cppr(vcpu, cppr);
+		if (unlikely(!__xive_vm_h_cppr))
+			return H_NOT_AVAILABLE;
+		return __xive_vm_h_cppr(vcpu, cppr);
+	} else
+		return xics_rm_h_cppr(vcpu, cppr);
+}
+
+int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
+{
+	if (xive_enabled()) {
+		if (is_rm())
+			return xive_rm_h_eoi(vcpu, xirr);
+		if (unlikely(!__xive_vm_h_eoi))
+			return H_NOT_AVAILABLE;
+		return __xive_vm_h_eoi(vcpu, xirr);
+	} else
+		return xics_rm_h_eoi(vcpu, xirr);
+}
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 3a1a463a039a..f8068801ac36 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -485,7 +485,7 @@ static void icp_rm_down_cppr(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 }
 
 
-unsigned long kvmppc_rm_h_xirr(struct kvm_vcpu *vcpu)
+unsigned long xics_rm_h_xirr(struct kvm_vcpu *vcpu)
 {
 	union kvmppc_icp_state old_state, new_state;
 	struct kvmppc_xics *xics = vcpu->kvm->arch.xics;
@@ -523,8 +523,8 @@ unsigned long kvmppc_rm_h_xirr(struct kvm_vcpu *vcpu)
 	return check_too_hard(xics, icp);
 }
 
-int kvmppc_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
-		    unsigned long mfrr)
+int xics_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
+		  unsigned long mfrr)
 {
 	union kvmppc_icp_state old_state, new_state;
 	struct kvmppc_xics *xics = vcpu->kvm->arch.xics;
@@ -610,7 +610,7 @@ int kvmppc_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
 	return check_too_hard(xics, this_icp);
 }
 
-int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr)
+int xics_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr)
 {
 	union kvmppc_icp_state old_state, new_state;
 	struct kvmppc_xics *xics = vcpu->kvm->arch.xics;
@@ -730,7 +730,7 @@ static int ics_rm_eoi(struct kvm_vcpu *vcpu, u32 irq)
 	return check_too_hard(xics, icp);
 }
 
-int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
+int xics_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 {
 	struct kvmppc_xics *xics = vcpu->kvm->arch.xics;
 	struct kvmppc_icp *icp = vcpu->arch.icp;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xive.c b/arch/powerpc/kvm/book3s_hv_rm_xive.c
new file mode 100644
index 000000000000..abf5f01b6eb1
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_rm_xive.c
@@ -0,0 +1,47 @@
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/err.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/kvm_book3s.h>
+#include <asm/kvm_ppc.h>
+#include <asm/hvcall.h>
+#include <asm/xics.h>
+#include <asm/debug.h>
+#include <asm/synch.h>
+#include <asm/cputhreads.h>
+#include <asm/pgtable.h>
+#include <asm/ppc-opcode.h>
+#include <asm/pnv-pci.h>
+#include <asm/opal.h>
+#include <asm/smp.h>
+#include <asm/asm-prototypes.h>
+#include <asm/xive.h>
+#include <asm/xive-regs.h>
+
+#include "book3s_xive.h"
+
+/* XXX */
+#include <asm/udbg.h>
+//#define DBG(fmt...) udbg_printf(fmt)
+#define DBG(fmt...) do { } while(0)
+
+static inline void __iomem *get_tima_phys(void)
+{
+	return local_paca->kvm_hstate.xive_tima_phys;
+}
+
+#undef XIVE_RUNTIME_CHECKS
+#define X_PFX xive_rm_
+#define X_STATIC
+#define X_STAT_PFX stat_rm_
+#define __x_tima		get_tima_phys()
+#define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_page))
+#define __x_trig_page(xd)	((void __iomem *)((xd)->trig_page))
+#define __x_readb	__raw_rm_readb
+#define __x_writeb	__raw_rm_writeb
+#define __x_readw	__raw_rm_readw
+#define __x_readq	__raw_rm_readq
+#define __x_writeq	__raw_rm_writeq
+
+#include "book3s_xive_template.c"
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 7c6477d1840a..bdb3f76ceb6b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -30,6 +30,7 @@
 #include <asm/book3s/64/mmu-hash.h>
 #include <asm/tm.h>
 #include <asm/opal.h>
+#include <asm/xive-regs.h>
 
 #define VCPU_GPRS_TM(reg) (((reg) * ULONG_SIZE) + VCPU_GPR_TM)
 
@@ -970,6 +971,23 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	cmpwi	r3, 512		/* 1 microsecond */
 	blt	hdec_soon
 
+#ifdef CONFIG_KVM_XICS
+	/* We are entering the guest on that thread, push VCPU to XIVE */
+	ld	r10, HSTATE_XIVE_TIMA_PHYS(r13)
+	cmpldi	cr0, r10, r0
+	beq	no_xive
+	ld	r11, VCPU_XIVE_SAVED_STATE(r4)
+	li	r9, TM_QW1_OS
+	stdcix	r11,r9,r10
+	eieio
+	lwz	r11, VCPU_XIVE_CAM_WORD(r4)
+	li	r9, TM_QW1_OS + TM_WORD2
+	stwcix	r11,r9,r10
+	li	r9, 1
+	stw	r9, VCPU_XIVE_PUSHED(r4)
+no_xive:
+#endif /* CONFIG_KVM_XICS */
+
 deliver_guest_interrupt:
 	ld	r6, VCPU_CTR(r4)
 	ld	r7, VCPU_XER(r4)
@@ -1307,6 +1325,42 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	blt	deliver_guest_interrupt
 
 guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
+#ifdef CONFIG_KVM_XICS
+	/* We are exiting, pull the VP from the XIVE */
+	lwz	r0, VCPU_XIVE_PUSHED(r9)
+	cmpwi	cr0, r0, 0
+	beq	1f
+	li	r7, TM_SPC_PULL_OS_CTX
+	li	r6, TM_QW1_OS
+	mfmsr	r0
+	andi.	r0, r0, MSR_IR		/* in real mode? */
+	beq	2f
+	ld	r10, HSTATE_XIVE_TIMA_VIRT(r13)
+	cmpldi	cr0, r10, 0
+	beq	1f
+	/* First load to pull the context, we ignore the value */
+	lwzx	r11, r7, r10
+	eieio
+	/* Second load to recover the context state (Words 0 and 1) */
+	ldx	r11, r6, r10
+	b	3f
+2:	ld	r10, HSTATE_XIVE_TIMA_PHYS(r13)
+	cmpldi	cr0, r10, 0
+	beq	1f
+	/* First load to pull the context, we ignore the value */
+	lwzcix	r11, r7, r10
+	eieio
+	/* Second load to recover the context state (Words 0 and 1) */
+	ldcix	r11, r6, r10
+3:	std	r11, VCPU_XIVE_SAVED_STATE(r9)
+	/* Fixup some of the state for the next load */
+	li	r10, 0
+	li	r0, 0xff
+	stw	r10, VCPU_XIVE_PUSHED(r9)
+	stb	r10, (VCPU_XIVE_SAVED_STATE+3)(r9)
+	stb	r0, (VCPU_XIVE_SAVED_STATE+4)(r9)
+1:
+#endif /* CONFIG_KVM_XICS */
 	/* Save more register state  */
 	mfdar	r6
 	mfdsisr	r7
@@ -2011,7 +2065,7 @@ hcall_real_table:
 	.long	DOTSYM(kvmppc_rm_h_eoi) - hcall_real_table
 	.long	DOTSYM(kvmppc_rm_h_cppr) - hcall_real_table
 	.long	DOTSYM(kvmppc_rm_h_ipi) - hcall_real_table
-	.long	0		/* 0x70 - H_IPOLL */
+	.long	DOTSYM(kvmppc_rm_h_ipoll) - hcall_real_table
 	.long	DOTSYM(kvmppc_rm_h_xirr) - hcall_real_table
 #else
 	.long	0		/* 0x64 - H_EOI */
@@ -2181,7 +2235,11 @@ hcall_real_table:
 	.long	0		/* 0x2f0 */
 	.long	0		/* 0x2f4 */
 	.long	0		/* 0x2f8 */
-	.long	0		/* 0x2fc */
+#ifdef CONFIG_KVM_XICS
+	.long	DOTSYM(kvmppc_rm_h_xirr_x) - hcall_real_table
+#else
+	.long	0		/* 0x2fc - H_XIRR_X*/
+#endif
 	.long	DOTSYM(kvmppc_h_random) - hcall_real_table
 	.globl	hcall_real_table_end
 hcall_real_table_end:
diff --git a/arch/powerpc/kvm/book3s_rtas.c b/arch/powerpc/kvm/book3s_rtas.c
index 20528701835b..2d3b2b1cc272 100644
--- a/arch/powerpc/kvm/book3s_rtas.c
+++ b/arch/powerpc/kvm/book3s_rtas.c
@@ -16,6 +16,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/hvcall.h>
 #include <asm/rtas.h>
+#include <asm/xive.h>
 
 #ifdef CONFIG_KVM_XICS
 static void kvm_rtas_set_xive(struct kvm_vcpu *vcpu, struct rtas_args *args)
@@ -32,7 +33,10 @@ static void kvm_rtas_set_xive(struct kvm_vcpu *vcpu, struct rtas_args *args)
 	server = be32_to_cpu(args->args[1]);
 	priority = be32_to_cpu(args->args[2]);
 
-	rc = kvmppc_xics_set_xive(vcpu->kvm, irq, server, priority);
+	if (xive_enabled())
+		rc = kvmppc_xive_set_xive(vcpu->kvm, irq, server, priority);
+	else
+		rc = kvmppc_xics_set_xive(vcpu->kvm, irq, server, priority);
 	if (rc)
 		rc = -3;
 out:
@@ -52,7 +56,10 @@ static void kvm_rtas_get_xive(struct kvm_vcpu *vcpu, struct rtas_args *args)
 	irq = be32_to_cpu(args->args[0]);
 
 	server = priority = 0;
-	rc = kvmppc_xics_get_xive(vcpu->kvm, irq, &server, &priority);
+	if (xive_enabled())
+		rc = kvmppc_xive_get_xive(vcpu->kvm, irq, &server, &priority);
+	else
+		rc = kvmppc_xics_get_xive(vcpu->kvm, irq, &server, &priority);
 	if (rc) {
 		rc = -3;
 		goto out;
@@ -76,7 +83,10 @@ static void kvm_rtas_int_off(struct kvm_vcpu *vcpu, struct rtas_args *args)
 
 	irq = be32_to_cpu(args->args[0]);
 
-	rc = kvmppc_xics_int_off(vcpu->kvm, irq);
+	if (xive_enabled())
+		rc = kvmppc_xive_int_off(vcpu->kvm, irq);
+	else
+		rc = kvmppc_xics_int_off(vcpu->kvm, irq);
 	if (rc)
 		rc = -3;
 out:
@@ -95,7 +105,10 @@ static void kvm_rtas_int_on(struct kvm_vcpu *vcpu, struct rtas_args *args)
 
 	irq = be32_to_cpu(args->args[0]);
 
-	rc = kvmppc_xics_int_on(vcpu->kvm, irq);
+	if (xive_enabled())
+		rc = kvmppc_xive_int_on(vcpu->kvm, irq);
+	else
+		rc = kvmppc_xics_int_on(vcpu->kvm, irq);
 	if (rc)
 		rc = -3;
 out:
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index ef4fd528c193..e6829c415bc8 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1307,8 +1307,8 @@ static int xics_set_source(struct kvmppc_xics *xics, long irq, u64 addr)
 	return 0;
 }
 
-int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
-		bool line_status)
+int kvmppc_xics_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
+			bool line_status)
 {
 	struct kvmppc_xics *xics = kvm->arch.xics;
 
@@ -1317,14 +1317,6 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
 	return ics_deliver_irq(xics, irq, level);
 }
 
-int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *irq_entry,
-			      struct kvm *kvm, int irq_source_id,
-			      int level, bool line_status)
-{
-	return kvm_set_irq(kvm, irq_source_id, irq_entry->gsi,
-			   level, line_status);
-}
-
 static int xics_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	struct kvmppc_xics *xics = dev->private;
@@ -1458,29 +1450,6 @@ void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu)
 	vcpu->arch.irq_type = KVMPPC_IRQ_DEFAULT;
 }
 
-static int xics_set_irq(struct kvm_kernel_irq_routing_entry *e,
-			struct kvm *kvm, int irq_source_id, int level,
-			bool line_status)
-{
-	return kvm_set_irq(kvm, irq_source_id, e->gsi, level, line_status);
-}
-
-int kvm_irq_map_gsi(struct kvm *kvm,
-		    struct kvm_kernel_irq_routing_entry *entries, int gsi)
-{
-	entries->gsi = gsi;
-	entries->type = KVM_IRQ_ROUTING_IRQCHIP;
-	entries->set = xics_set_irq;
-	entries->irqchip.irqchip = 0;
-	entries->irqchip.pin = gsi;
-	return 1;
-}
-
-int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
-{
-	return pin;
-}
-
 void kvmppc_xics_set_mapped(struct kvm *kvm, unsigned long irq,
 			    unsigned long host_irq)
 {
diff --git a/arch/powerpc/kvm/book3s_xics.h b/arch/powerpc/kvm/book3s_xics.h
index ec5474cf70c6..5016676847c9 100644
--- a/arch/powerpc/kvm/book3s_xics.h
+++ b/arch/powerpc/kvm/book3s_xics.h
@@ -144,5 +144,10 @@ static inline struct kvmppc_ics *kvmppc_xics_find_ics(struct kvmppc_xics *xics,
 	return ics;
 }
 
+extern unsigned long xics_rm_h_xirr(struct kvm_vcpu *vcpu);
+extern int xics_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
+			 unsigned long mfrr);
+extern int xics_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
+extern int xics_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
 
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
new file mode 100644
index 000000000000..7807ee17af4b
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -0,0 +1,1893 @@
+/*
+ * Copyright 2017 Benjamin Herrenschmidt, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "xive-kvm: " fmt
+
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/percpu.h>
+#include <linux/cpumask.h>
+#include <asm/uaccess.h>
+#include <asm/kvm_book3s.h>
+#include <asm/kvm_ppc.h>
+#include <asm/hvcall.h>
+#include <asm/xics.h>
+#include <asm/xive.h>
+#include <asm/xive-regs.h>
+#include <asm/debug.h>
+#include <asm/time.h>
+#include <asm/opal.h>
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "book3s_xive.h"
+
+
+/*
+ * Virtual mode variants of the hcalls for use on radix/radix
+ * with AIL. They require the VCPU's VP to be "pushed"
+ *
+ * We still instanciate them here because we use some of the
+ * generated utility functions as well in this file.
+ */
+#define XIVE_RUNTIME_CHECKS
+#define X_PFX xive_vm_
+#define X_STATIC static
+#define X_STAT_PFX stat_vm_
+#define __x_tima		xive_tima
+#define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_mmio))
+#define __x_trig_page(xd)	((void __iomem *)((xd)->trig_mmio))
+#define __x_readb	__raw_readb
+#define __x_writeb	__raw_writeb
+#define __x_readw	__raw_readw
+#define __x_readq	__raw_readq
+#define __x_writeq	__raw_writeq
+
+#include "book3s_xive_template.c"
+
+/*
+ * We leave a gap of a couple of interrupts in the queue to
+ * account for the IPI and additional safety guard.
+ */
+#define XIVE_Q_GAP	2
+
+/*
+ * This is a simple trigger for a generic XIVE IRQ. This must
+ * only be called for interrupts that support a trigger page
+ */
+static bool xive_irq_trigger(struct xive_irq_data *xd)
+{
+	/* This should be only for MSIs */
+	if (WARN_ON(xd->flags & XIVE_IRQ_FLAG_LSI))
+		return false;
+
+	/* Those interrupts should always have a trigger page */
+	if (WARN_ON(!xd->trig_mmio))
+		return false;
+
+	out_be64(xd->trig_mmio, 0);
+
+	return true;
+}
+
+static irqreturn_t xive_esc_irq(int irq, void *data)
+{
+	struct kvm_vcpu *vcpu = data;
+
+	/* We use the existing H_PROD mechanism to wake up the target */
+	vcpu->arch.prodded = 1;
+	smp_mb();
+	if (vcpu->arch.ceded)
+		kvmppc_fast_vcpu_kick(vcpu);
+
+	return IRQ_HANDLED;
+}
+
+static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct xive_q *q = &xc->queues[prio];
+	char *name = NULL;
+	int rc;
+
+	/* Already there ? */
+	if (xc->esc_virq[prio])
+		return 0;
+
+	/* Hook up the escalation interrupt */
+	xc->esc_virq[prio] = irq_create_mapping(NULL, q->esc_irq);
+	if (!xc->esc_virq[prio]) {
+		pr_err("Failed to map escalation interrupt for queue %d of VCPU %d\n",
+		       prio, xc->server_num);
+		return -EIO;
+	}
+
+	/*
+	 * Future improvement: start with them disabled
+	 * and handle DD2 and later scheme of merged escalation
+	 * interrupts
+	 */
+	name = kasprintf(GFP_KERNEL, "kvm-%d-%d-%d",
+			 vcpu->kvm->arch.lpid, xc->server_num, prio);
+	if (!name) {
+		pr_err("Failed to allocate escalation irq name for queue %d of VCPU %d\n",
+		       prio, xc->server_num);
+		rc = -ENOMEM;
+		goto error;
+	}
+	rc = request_irq(xc->esc_virq[prio], xive_esc_irq,
+			 IRQF_NO_THREAD, name, vcpu);
+	if (rc) {
+		pr_err("Failed to request escalation interrupt for queue %d of VCPU %d\n",
+		       prio, xc->server_num);
+		goto error;
+	}
+	xc->esc_virq_names[prio] = name;
+	return 0;
+error:
+	irq_dispose_mapping(xc->esc_virq[prio]);
+	xc->esc_virq[prio] = 0;
+	kfree(name);
+	return rc;
+}
+
+static int xive_provision_queue(struct kvm_vcpu *vcpu, u8 prio)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvmppc_xive *xive = xc->xive;
+	struct xive_q *q =  &xc->queues[prio];
+	void *qpage;
+	int rc;
+
+	if (WARN_ON(q->qpage))
+		return 0;
+
+	/* Allocate the queue and retrieve infos on current node for now */
+	qpage = (__be32 *)__get_free_pages(GFP_KERNEL, xive->q_page_order);
+	if (!qpage) {
+		pr_err("Failed to allocate queue %d for VCPU %d\n",
+		       prio, xc->server_num);
+		return -ENOMEM;;
+	}
+	memset(qpage, 0, 1 << xive->q_order);
+
+	/*
+	 * Reconfigure the queue. This will set q->qpage only once the
+	 * queue is fully configured. This is a requirement for prio 0
+	 * as we will stop doing EOIs for every IPI as soon as we observe
+	 * qpage being non-NULL, and instead will only EOI when we receive
+	 * corresponding queue 0 entries
+	 */
+	rc = xive_native_configure_queue(xc->vp_id, q, prio, qpage,
+					 xive->q_order, true);
+	if (rc)
+		pr_err("Failed to configure queue %d for VCPU %d\n",
+		       prio, xc->server_num);
+	return rc;
+}
+
+/* Called with kvm_lock held */
+static int xive_check_provisioning(struct kvm *kvm, u8 prio)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	struct kvm_vcpu *vcpu;
+	int i, rc;
+
+	lockdep_assert_held(&kvm->lock);
+
+	/* Already provisioned ? */
+	if (xive->qmap & (1 << prio))
+		return 0;
+
+	pr_devel("Provisioning prio... %d\n", prio);
+
+	/* Provision each VCPU and enable escalations */
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!vcpu->arch.xive_vcpu)
+			continue;
+		rc = xive_provision_queue(vcpu, prio);
+		if (rc == 0)
+			xive_attach_escalation(vcpu, prio);
+		if (rc)
+			return rc;
+	}
+
+	/* Order previous stores and mark it as provisioned */
+	mb();
+	xive->qmap |= (1 << prio);
+	return 0;
+}
+
+static void xive_inc_q_pending(struct kvm *kvm, u32 server, u8 prio)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvmppc_xive_vcpu *xc;
+	struct xive_q *q;
+
+	/* Locate target server */
+	vcpu = kvmppc_xive_find_server(kvm, server);
+	if (!vcpu) {
+		pr_warn("%s: Can't find server %d\n", __func__, server);
+		return;
+	}
+	xc = vcpu->arch.xive_vcpu;
+	if (WARN_ON(!xc))
+		return;
+
+	q = &xc->queues[prio];
+	atomic_inc(&q->pending_count);
+}
+
+static int xive_try_pick_queue(struct kvm_vcpu *vcpu, u8 prio)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct xive_q *q;
+	u32 max;
+
+	if (WARN_ON(!xc))
+		return -ENXIO;
+	if (!xc->valid)
+		return -ENXIO;
+
+	q = &xc->queues[prio];
+	if (WARN_ON(!q->qpage))
+		return -ENXIO;
+
+	/* Calculate max number of interrupts in that queue. */
+	max = (q->msk + 1) - XIVE_Q_GAP;
+	return atomic_add_unless(&q->count, 1, max) ? 0 : -EBUSY;
+}
+
+static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
+{
+	struct kvm_vcpu *vcpu;
+	int i, rc;
+
+	/* Locate target server */
+	vcpu = kvmppc_xive_find_server(kvm, *server);
+	if (!vcpu) {
+		pr_devel("Can't find server %d\n", *server);
+		return -EINVAL;
+	}
+
+	pr_devel("Finding irq target on 0x%x/%d...\n", *server, prio);
+
+	/* Try pick it */
+	rc = xive_try_pick_queue(vcpu, prio);
+	if (rc == 0)
+		return rc;
+
+	pr_devel(" .. failed, looking up candidate...\n");
+
+	/* Failed, pick another VCPU */
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!vcpu->arch.xive_vcpu)
+			continue;
+		rc = xive_try_pick_queue(vcpu, prio);
+		if (rc == 0) {
+			*server = vcpu->arch.xive_vcpu->server_num;
+			pr_devel("  found on 0x%x/%d\n", *server, prio);
+			return rc;
+		}
+	}
+	pr_devel("  no available target !\n");
+
+	/* No available target ! */
+	return -EBUSY;
+}
+
+static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
+			     struct kvmppc_xive_src_block *sb,
+			     struct kvmppc_xive_irq_state *state)
+{
+	struct xive_irq_data *xd;
+	u32 hw_num;
+	u8 old_prio;
+	u64 val;
+
+	/*
+	 * Take the lock, set masked, try again if racing
+	 * with H_EOI
+	 */
+	for (;;) {
+		arch_spin_lock(&sb->lock);
+		old_prio = state->guest_priority;
+		state->guest_priority = MASKED;
+		mb();
+		if (!state->in_eoi)
+			break;
+		state->guest_priority = old_prio;
+		arch_spin_unlock(&sb->lock);
+	}
+
+	/* No change ? Bail */
+	if (old_prio == MASKED)
+		return old_prio;
+
+	/* Get the right irq */
+	kvmppc_xive_select_irq(state, &hw_num, &xd);
+
+	/*
+	 * If the interrupt is marked as needing masking via
+	 * firmware, we do it here. Firmware masking however
+	 * is "lossy", it won't return the old p and q bits
+	 * and won't set the interrupt to a state where it will
+	 * record queued ones. If this is an issue we should do
+	 * lazy masking instead.
+	 *
+	 * For now, we work around this in unmask by forcing
+	 * an interrupt whenever we unmask a non-LSI via FW
+	 * (if ever).
+	 */
+	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
+		xive_native_configure_irq(hw_num,
+					  xive->vp_base + state->act_server,
+					  MASKED, state->number);
+		/* set old_p so we can track if an H_EOI was done */
+		state->old_p = true;
+		state->old_q = false;
+	} else {
+		/* Set PQ to 10, return old P and old Q and remember them */
+		val = xive_vm_esb_load(xd, XIVE_ESB_SET_PQ_10);
+		state->old_p = !!(val & 2);
+		state->old_q = !!(val & 1);
+
+		/*
+		 * Synchronize hardware to sensure the queues are updated
+		 * when masking
+		 */
+		xive_native_sync_source(hw_num);
+	}
+
+	return old_prio;
+}
+
+static void xive_lock_for_unmask(struct kvmppc_xive_src_block *sb,
+				 struct kvmppc_xive_irq_state *state)
+{
+	/*
+	 * Take the lock try again if racing with H_EOI
+	 */
+	for (;;) {
+		arch_spin_lock(&sb->lock);
+		if (!state->in_eoi)
+			break;
+		arch_spin_unlock(&sb->lock);
+	}
+}
+
+static void xive_finish_unmask(struct kvmppc_xive *xive,
+			       struct kvmppc_xive_src_block *sb,
+			       struct kvmppc_xive_irq_state *state,
+			       u8 prio)
+{
+	struct xive_irq_data *xd;
+	u32 hw_num;
+
+	/* If we aren't changing a thing, move on */
+	if (state->guest_priority != MASKED)
+		goto bail;
+
+	/* Get the right irq */
+	kvmppc_xive_select_irq(state, &hw_num, &xd);
+
+	/*
+	 * See command in xive_lock_and_mask() concerning masking
+	 * via firmware.
+	 */
+	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
+		xive_native_configure_irq(hw_num,
+					  xive->vp_base + state->act_server,
+					  state->act_priority, state->number);
+		/* If an EOI is needed, do it here */
+		if (!state->old_p)
+			xive_vm_source_eoi(hw_num, xd);
+		/* If this is not an LSI, force a trigger */
+		if (!(xd->flags & OPAL_XIVE_IRQ_LSI))
+			xive_irq_trigger(xd);
+		goto bail;
+	}
+
+	/* Old Q set, set PQ to 11 */
+	if (state->old_q)
+		xive_vm_esb_load(xd, XIVE_ESB_SET_PQ_11);
+
+	/*
+	 * If not old P, then perform an "effective" EOI,
+	 * on the source. This will handle the cases where
+	 * FW EOI is needed.
+	 */
+	if (!state->old_p)
+		xive_vm_source_eoi(hw_num, xd);
+
+	/* Synchronize ordering and mark unmasked */
+	mb();
+bail:
+	state->guest_priority = prio;
+}
+
+/*
+ * Target an interrupt to a given server/prio, this will fallback
+ * to another server if necessary and perform the HW targetting
+ * updates as needed
+ *
+ * NOTE: Must be called with the state lock held
+ */
+static int xive_target_interrupt(struct kvm *kvm,
+				 struct kvmppc_xive_irq_state *state,
+				 u32 server, u8 prio)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	u32 hw_num;
+	int rc;
+
+	/*
+	 * This will return a tentative server and actual
+	 * priority. The count for that new target will have
+	 * already been incremented.
+	 */
+	rc = xive_select_target(kvm, &server, prio);
+
+	/*
+	 * We failed to find a target ? Not much we can do
+	 * at least until we support the GIQ.
+	 */
+	if (rc)
+		return rc;
+
+	/*
+	 * Increment the old queue pending count if there
+	 * was one so that the old queue count gets adjusted later
+	 * when observed to be empty.
+	 */
+	if (state->act_priority != MASKED)
+		xive_inc_q_pending(kvm,
+				   state->act_server,
+				   state->act_priority);
+	/*
+	 * Update state and HW
+	 */
+	state->act_priority = prio;
+	state->act_server = server;
+
+	/* Get the right irq */
+	kvmppc_xive_select_irq(state, &hw_num, NULL);
+
+	return xive_native_configure_irq(hw_num,
+					 xive->vp_base + server,
+					 prio, state->number);
+}
+
+/*
+ * Targetting rules: In order to avoid losing track of
+ * pending interrupts accross mask and unmask, which would
+ * allow queue overflows, we implement the following rules:
+ *
+ *  - Unless it was never enabled (or we run out of capacity)
+ *    an interrupt is always targetted at a valid server/queue
+ *    pair even when "masked" by the guest. This pair tends to
+ *    be the last one used but it can be changed under some
+ *    circumstances. That allows us to separate targetting
+ *    from masking, we only handle accounting during (re)targetting,
+ *    this also allows us to let an interrupt drain into its target
+ *    queue after masking, avoiding complex schemes to remove
+ *    interrupts out of remote processor queues.
+ *
+ *  - When masking, we set PQ to 10 and save the previous value
+ *    of P and Q.
+ *
+ *  - When unmasking, if saved Q was set, we set PQ to 11
+ *    otherwise we leave PQ to the HW state which will be either
+ *    10 if nothing happened or 11 if the interrupt fired while
+ *    masked. Effectively we are OR'ing the previous Q into the
+ *    HW Q.
+ *
+ *    Then if saved P is clear, we do an effective EOI (Q->P->Trigger)
+ *    which will unmask the interrupt and shoot a new one if Q was
+ *    set.
+ *
+ *    Otherwise (saved P is set) we leave PQ unchanged (so 10 or 11,
+ *    effectively meaning an H_EOI from the guest is still expected
+ *    for that interrupt).
+ *
+ *  - If H_EOI occurs while masked, we clear the saved P.
+ *
+ *  - When changing target, we account on the new target and
+ *    increment a separate "pending" counter on the old one.
+ *    This pending counter will be used to decrement the old
+ *    target's count when its queue has been observed empty.
+ */
+
+int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
+			 u32 priority)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u8 new_act_prio;
+	int rc = 0;
+	u16 idx;
+
+	if (!xive)
+		return -ENODEV;
+
+	pr_devel("set_xive ! irq 0x%x server 0x%x prio %d\n",
+		 irq, server, priority);
+
+	/* First, check provisioning of queues */
+	if (priority != MASKED)
+		rc = xive_check_provisioning(xive->kvm,
+			      xive_prio_from_guest(priority));
+	if (rc) {
+		pr_devel("  provisioning failure %d !\n", rc);
+		return rc;
+	}
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb)
+		return -EINVAL;
+	state = &sb->irq_state[idx];
+
+	/*
+	 * We first handle masking/unmasking since the locking
+	 * might need to be retried due to EOIs, we'll handle
+	 * targetting changes later. These functions will return
+	 * with the SB lock held.
+	 *
+	 * xive_lock_and_mask() will also set state->guest_priority
+	 * but won't otherwise change other fields of the state.
+	 *
+	 * xive_lock_for_unmask will not actually unmask, this will
+	 * be done later by xive_finish_unmask() once the targetting
+	 * has been done, so we don't try to unmask an interrupt
+	 * that hasn't yet been targetted.
+	 */
+	if (priority == MASKED)
+		xive_lock_and_mask(xive, sb, state);
+	else
+		xive_lock_for_unmask(sb, state);
+
+
+	/*
+	 * Then we handle targetting.
+	 *
+	 * First calculate a new "actual priority"
+	 */
+	new_act_prio = state->act_priority;
+	if (priority != MASKED)
+		new_act_prio = xive_prio_from_guest(priority);
+
+	pr_devel(" new_act_prio=%x act_server=%x act_prio=%x\n",
+		 new_act_prio, state->act_server, state->act_priority);
+
+	/*
+	 * Then check if we actually need to change anything,
+	 *
+	 * The condition for re-targetting the interrupt is that
+	 * we have a valid new priority (new_act_prio is not 0xff)
+	 * and either the server or the priority changed.
+	 *
+	 * Note: If act_priority was ff and the new priority is
+	 *       also ff, we don't do anything and leave the interrupt
+	 *       untargetted. An attempt of doing an int_on on an
+	 *       untargetted interrupt will fail. If that is a problem
+	 *       we could initialize interrupts with valid default
+	 */
+
+	if (new_act_prio != MASKED &&
+	    (state->act_server != server ||
+	     state->act_priority != new_act_prio))
+		rc = xive_target_interrupt(kvm, state, server, new_act_prio);
+
+	/*
+	 * Perform the final unmasking of the interrupt source
+	 * if necessary
+	 */
+	if (priority != MASKED)
+		xive_finish_unmask(xive, sb, state, priority);
+
+	/*
+	 * Finally Update saved_priority to match. Only int_on/off
+	 * set this field to a different value.
+	 */
+	state->saved_priority = priority;
+
+	arch_spin_unlock(&sb->lock);
+	return rc;
+}
+
+int kvmppc_xive_get_xive(struct kvm *kvm, u32 irq, u32 *server,
+			 u32 *priority)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u16 idx;
+
+	if (!xive)
+		return -ENODEV;
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb)
+		return -EINVAL;
+	state = &sb->irq_state[idx];
+	arch_spin_lock(&sb->lock);
+	*server = state->guest_server;
+	*priority = state->guest_priority;
+	arch_spin_unlock(&sb->lock);
+
+	return 0;
+}
+
+int kvmppc_xive_int_on(struct kvm *kvm, u32 irq)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u16 idx;
+
+	if (!xive)
+		return -ENODEV;
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb)
+		return -EINVAL;
+	state = &sb->irq_state[idx];
+
+	pr_devel("int_on(irq=0x%x)\n", irq);
+
+	/*
+	 * Check if interrupt was not targetted
+	 */
+	if (state->act_priority == MASKED) {
+		pr_devel("int_on on untargetted interrupt\n");
+		return -EINVAL;
+	}
+
+	/* If saved_priority is 0xff, do nothing */
+	if (state->saved_priority == MASKED)
+		return 0;
+
+	/*
+	 * Lock and unmask it.
+	 */
+	xive_lock_for_unmask(sb, state);
+	xive_finish_unmask(xive, sb, state, state->saved_priority);
+	arch_spin_unlock(&sb->lock);
+
+	return 0;
+}
+
+int kvmppc_xive_int_off(struct kvm *kvm, u32 irq)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u16 idx;
+
+	if (!xive)
+		return -ENODEV;
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb)
+		return -EINVAL;
+	state = &sb->irq_state[idx];
+
+	pr_devel("int_off(irq=0x%x)\n", irq);
+
+	/*
+	 * Lock and mask
+	 */
+	state->saved_priority = xive_lock_and_mask(xive, sb, state);
+	arch_spin_unlock(&sb->lock);
+
+	return 0;
+}
+
+static bool xive_restore_pending_irq(struct kvmppc_xive *xive, u32 irq)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u16 idx;
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb)
+		return false;
+	state = &sb->irq_state[idx];
+	if (!state->valid)
+		return false;
+
+	/*
+	 * Trigger the IPI. This assumes we never restore a pass-through
+	 * interrupt which should be safe enough
+	 */
+	xive_irq_trigger(&state->ipi_data);
+
+	return true;
+}
+
+u64 kvmppc_xive_get_icp(struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+
+	if (!xc)
+		return 0;
+
+	/* Return the per-cpu state for state saving/migration */
+	return (u64)xc->cppr << KVM_REG_PPC_ICP_CPPR_SHIFT |
+	       (u64)xc->mfrr << KVM_REG_PPC_ICP_MFRR_SHIFT;
+}
+
+int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	u8 cppr, mfrr;
+	u32 xisr;
+
+	if (!xc || !xive)
+		return -ENOENT;
+
+	/* Grab individual state fields. We don't use pending_pri */
+	cppr = icpval >> KVM_REG_PPC_ICP_CPPR_SHIFT;
+	xisr = (icpval >> KVM_REG_PPC_ICP_XISR_SHIFT) &
+		KVM_REG_PPC_ICP_XISR_MASK;
+	mfrr = icpval >> KVM_REG_PPC_ICP_MFRR_SHIFT;
+
+	pr_devel("set_icp vcpu %d cppr=0x%x mfrr=0x%x xisr=0x%x\n",
+		 xc->server_num, cppr, mfrr, xisr);
+
+	/*
+	 * We can't update the state of a "pushed" VCPU, but that
+	 * shouldn't happen.
+	 */
+	if (WARN_ON(vcpu->arch.xive_pushed))
+		return -EIO;
+
+	/* Update VCPU HW saved state */
+	vcpu->arch.xive_saved_state.cppr = cppr;
+	xc->hw_cppr = xc->cppr = cppr;
+
+	/*
+	 * Update MFRR state. If it's not 0xff, we mark the VCPU as
+	 * having a pending MFRR change, which will re-evaluate the
+	 * target. The VCPU will thus potentially get a spurious
+	 * interrupt but that's not a big deal.
+	 */
+	xc->mfrr = mfrr;
+	if (mfrr < cppr)
+		xive_irq_trigger(&xc->vp_ipi_data);
+
+	/*
+	 * Now saved XIRR is "interesting". It means there's something in
+	 * the legacy "1 element" queue... for an IPI we simply ignore it,
+	 * as the MFRR restore will handle that. For anything else we need
+	 * to force a resend of the source.
+	 * However the source may not have been setup yet. If that's the
+	 * case, we keep that info and increment a counter in the xive to
+	 * tell subsequent xive_set_source() to go look.
+	 */
+	if (xisr > XICS_IPI && !xive_restore_pending_irq(xive, xisr)) {
+		xc->delayed_irq = xisr;
+		xive->delayed_irqs++;
+		pr_devel("  xisr restore delayed\n");
+	}
+
+	return 0;
+}
+
+int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
+			   struct irq_desc *host_desc)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	struct irq_data *host_data = irq_desc_get_irq_data(host_desc);
+	unsigned int host_irq = irq_desc_get_irq(host_desc);
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(host_data);
+	u16 idx;
+	u8 prio;
+	int rc;
+
+	if (!xive)
+		return -ENODEV;
+
+	pr_devel("set_mapped girq 0x%lx host HW irq 0x%x...\n",guest_irq, hw_irq);
+
+	sb = kvmppc_xive_find_source(xive, guest_irq, &idx);
+	if (!sb)
+		return -EINVAL;
+	state = &sb->irq_state[idx];
+
+	/*
+	 * Mark the passed-through interrupt as going to a VCPU,
+	 * this will prevent further EOIs and similar operations
+	 * from the XIVE code. It will also mask the interrupt
+	 * to either PQ=10 or 11 state, the latter if the interrupt
+	 * is pending. This will allow us to unmask or retrigger it
+	 * after routing it to the guest with a simple EOI.
+	 *
+	 * The "state" argument is a "token", all it needs is to be
+	 * non-NULL to switch to passed-through or NULL for the
+	 * other way around. We may not yet have an actual VCPU
+	 * target here and we don't really care.
+	 */
+	rc = irq_set_vcpu_affinity(host_irq, state);
+	if (rc) {
+		pr_err("Failed to set VCPU affinity for irq %d\n", host_irq);
+		return rc;
+	}
+
+	/*
+	 * Mask and read state of IPI. We need to know if its P bit
+	 * is set as that means it's potentially already using a
+	 * queue entry in the target
+	 */
+	prio = xive_lock_and_mask(xive, sb, state);
+	pr_devel(" old IPI prio %02x P:%d Q:%d\n", prio,
+		 state->old_p, state->old_q);
+
+	/* Turn the IPI hard off */
+	xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
+
+	/* Grab info about irq */
+	state->pt_number = hw_irq;
+	state->pt_data = irq_data_get_irq_handler_data(host_data);
+
+	/*
+	 * Configure the IRQ to match the existing configuration of
+	 * the IPI if it was already targetted. Otherwise this will
+	 * mask the interrupt in a lossy way (act_priority is 0xff)
+	 * which is fine for a never started interrupt.
+	 */
+	xive_native_configure_irq(hw_irq,
+				  xive->vp_base + state->act_server,
+				  state->act_priority, state->number);
+
+	/*
+	 * We do an EOI to enable the interrupt (and retrigger if needed)
+	 * if the guest has the interrupt unmasked and the P bit was *not*
+	 * set in the IPI. If it was set, we know a slot may still be in
+	 * use in the target queue thus we have to wait for a guest
+	 * originated EOI
+	 */
+	if (prio != MASKED && !state->old_p)
+		xive_vm_source_eoi(hw_irq, state->pt_data);
+
+	/* Clear old_p/old_q as they are no longer relevant */
+	state->old_p = state->old_q = false;
+
+	/* Restore guest prio (unlocks EOI) */
+	mb();
+	state->guest_priority = prio;
+	arch_spin_unlock(&sb->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvmppc_xive_set_mapped);
+
+int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
+			   struct irq_desc *host_desc)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	unsigned int host_irq = irq_desc_get_irq(host_desc);
+	u16 idx;
+	u8 prio;
+	int rc;
+
+	if (!xive)
+		return -ENODEV;
+
+	pr_devel("clr_mapped girq 0x%lx...\n", guest_irq);
+
+	sb = kvmppc_xive_find_source(xive, guest_irq, &idx);
+	if (!sb)
+		return -EINVAL;
+	state = &sb->irq_state[idx];
+
+	/*
+	 * Mask and read state of IRQ. We need to know if its P bit
+	 * is set as that means it's potentially already using a
+	 * queue entry in the target
+	 */
+	prio = xive_lock_and_mask(xive, sb, state);
+	pr_devel(" old IRQ prio %02x P:%d Q:%d\n", prio,
+		 state->old_p, state->old_q);
+
+	/*
+	 * If old_p is set, the interrupt is pending, we switch it to
+	 * PQ=11. This will force a resend in the host so the interrupt
+	 * isn't lost to whatver host driver may pick it up
+	 */
+	if (state->old_p)
+		xive_vm_esb_load(state->pt_data, XIVE_ESB_SET_PQ_11);
+
+	/* Release the passed-through interrupt to the host */
+	rc = irq_set_vcpu_affinity(host_irq, NULL);
+	if (rc) {
+		pr_err("Failed to clr VCPU affinity for irq %d\n", host_irq);
+		return rc;
+	}
+
+	/* Forget about the IRQ */
+	state->pt_number = 0;
+	state->pt_data = NULL;
+
+	/* Reconfigure the IPI */
+	xive_native_configure_irq(state->ipi_number,
+				  xive->vp_base + state->act_server,
+				  state->act_priority, state->number);
+
+	/*
+	 * If old_p is set (we have a queue entry potentially
+	 * occupied) or the interrupt is masked, we set the IPI
+	 * to PQ=10 state. Otherwise we just re-enable it (PQ=00).
+	 */
+	if (prio == MASKED || state->old_p)
+		xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_10);
+	else
+		xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_00);
+
+	/* Restore guest prio (unlocks EOI) */
+	mb();
+	state->guest_priority = prio;
+	arch_spin_unlock(&sb->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvmppc_xive_clr_mapped);
+
+static void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	int i, j;
+
+	for (i = 0; i <= xive->max_sbid; i++) {
+		struct kvmppc_xive_src_block *sb = xive->src_blocks[i];
+
+		if (!sb)
+			continue;
+		for (j = 0; j < KVMPPC_XICS_IRQ_PER_ICS; j++) {
+			struct kvmppc_xive_irq_state *state = &sb->irq_state[j];
+
+			if (!state->valid)
+				continue;
+			if (state->act_priority == MASKED)
+				continue;
+			if (state->act_server != xc->server_num)
+				continue;
+
+			/* Clean it up */
+			arch_spin_lock(&sb->lock);
+			state->act_priority = MASKED;
+			xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
+			xive_native_configure_irq(state->ipi_number, 0, MASKED, 0);
+			if (state->pt_number) {
+				xive_vm_esb_load(state->pt_data, XIVE_ESB_SET_PQ_01);
+				xive_native_configure_irq(state->pt_number, 0, MASKED, 0);
+			}
+			arch_spin_unlock(&sb->lock);
+		}
+	}
+}
+
+void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvmppc_xive *xive = xc->xive;
+	int i;
+
+	pr_devel("cleanup_vcpu(cpu=%d)\n", xc->server_num);
+
+	/* Ensure no interrupt is still routed to that VP */
+	xc->valid = false;
+	kvmppc_xive_disable_vcpu_interrupts(vcpu);
+
+	/* Mask the VP IPI */
+	xive_vm_esb_load(&xc->vp_ipi_data, XIVE_ESB_SET_PQ_01);
+
+	/* Disable the VP */
+	xive_native_disable_vp(xc->vp_id);
+
+	/* Free the queues & associated interrupts */
+	for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
+		struct xive_q *q = &xc->queues[i];
+
+		/* Free the escalation irq */
+		if (xc->esc_virq[i]) {
+			free_irq(xc->esc_virq[i], vcpu);
+			irq_dispose_mapping(xc->esc_virq[i]);
+			kfree(xc->esc_virq_names[i]);
+		}
+		/* Free the queue */
+		xive_native_disable_queue(xc->vp_id, q, i);
+		if (q->qpage) {
+			free_pages((unsigned long)q->qpage,
+				   xive->q_page_order);
+			q->qpage = NULL;
+		}
+	}
+
+	/* Free the IPI */
+	if (xc->vp_ipi) {
+		xive_cleanup_irq_data(&xc->vp_ipi_data);
+		xive_native_free_irq(xc->vp_ipi);
+	}
+	/* Free the VP */
+	kfree(xc);
+}
+
+int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
+			     struct kvm_vcpu *vcpu, u32 cpu)
+{
+	struct kvmppc_xive *xive = dev->private;
+	struct kvmppc_xive_vcpu *xc;
+	int i, r = -EBUSY;
+
+	pr_devel("connect_vcpu(cpu=%d)\n", cpu);
+
+	if (dev->ops != &kvm_xive_ops) {
+		pr_devel("Wrong ops !\n");
+		return -EPERM;
+	}
+	if (xive->kvm != vcpu->kvm)
+		return -EPERM;
+	if (vcpu->arch.irq_type)
+		return -EBUSY;
+	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
+		pr_devel("Duplicate !\n");
+		return -EEXIST;
+	}
+	if (cpu >= KVM_MAX_VCPUS) {
+		pr_devel("Out of bounds !\n");
+		return -EINVAL;
+	}
+	xc = kzalloc(sizeof(*xc), GFP_KERNEL);
+	if (!xc)
+		return -ENOMEM;
+
+	/* We need to synchronize with queue provisioning */
+	mutex_lock(&vcpu->kvm->lock);
+	vcpu->arch.xive_vcpu = xc;
+	xc->xive = xive;
+	xc->vcpu = vcpu;
+	xc->server_num = cpu;
+	xc->vp_id = xive->vp_base + cpu;
+	xc->mfrr = 0xff;
+	xc->valid = true;
+
+	r = xive_native_get_vp_info(xc->vp_id, &xc->vp_cam, &xc->vp_chip_id);
+	if (r)
+		goto bail;
+
+	/* Configure VCPU fields for use by assembly push/pull */
+	vcpu->arch.xive_saved_state.w01 = cpu_to_be64(0xff000000);
+	vcpu->arch.xive_cam_word = cpu_to_be32(xc->vp_cam | TM_QW1W2_VO);
+
+	/* Allocate IPI */
+	xc->vp_ipi = xive_native_alloc_irq();
+	if (!xc->vp_ipi) {
+		r = -EIO;
+		goto bail;
+	}
+	pr_devel(" IPI=0x%x\n", xc->vp_ipi);
+
+	r = xive_native_populate_irq_data(xc->vp_ipi, &xc->vp_ipi_data);
+	if (r)
+		goto bail;
+
+	/*
+	 * Initialize queues. Initially we set them all for no queueing
+	 * and we enable escalation for queue 0 only which we'll use for
+	 * our mfrr change notifications. If the VCPU is hot-plugged, we
+	 * do handle provisioning however.
+	 */
+	for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
+		struct xive_q *q = &xc->queues[i];
+
+		/* Is queue already enabled ? Provision it */
+		if (xive->qmap & (1 << i)) {
+			r = xive_provision_queue(vcpu, i);
+			if (r == 0)
+				xive_attach_escalation(vcpu, i);
+			if (r)
+				goto bail;
+		} else {
+			r = xive_native_configure_queue(xc->vp_id,
+							q, i, NULL, 0, true);
+			if (r) {
+				pr_err("Failed to configure queue %d for VCPU %d\n",
+				       i, cpu);
+				goto bail;
+			}
+		}
+	}
+
+	/* If not done above, attach priority 0 escalation */
+	r = xive_attach_escalation(vcpu, 0);
+	if (r)
+		goto bail;
+
+	/* Enable the VP */
+	r = xive_native_enable_vp(xc->vp_id);
+	if (r)
+		goto bail;
+
+	/* Route the IPI */
+	r = xive_native_configure_irq(xc->vp_ipi, xc->vp_id, 0, XICS_IPI);
+	if (!r)
+		xive_vm_esb_load(&xc->vp_ipi_data, XIVE_ESB_SET_PQ_00);
+
+bail:
+	mutex_unlock(&vcpu->kvm->lock);
+	if (r) {
+		kvmppc_xive_cleanup_vcpu(vcpu);
+		return r;
+	}
+
+	vcpu->arch.irq_type = KVMPPC_IRQ_XICS;
+	return 0;
+}
+
+/*
+ * Scanning of queues before/after migration save
+ */
+static void xive_pre_save_set_queued(struct kvmppc_xive *xive, u32 irq)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u16 idx;
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb)
+		return;
+
+	state = &sb->irq_state[idx];
+
+	/* Some sanity checking */
+	if (!state->valid) {
+		pr_err("invalid irq 0x%x in cpu queue!\n", irq);
+		return;
+	}
+
+	/*
+	 * If the interrupt is in a queue it should have P set.
+	 * We warn so that gets reported. A backtrace isn't useful
+	 * so no need to use a WARN_ON.
+	 */
+	if (!state->saved_p)
+		pr_err("Interrupt 0x%x is marked in a queue but P not set !\n", irq);
+
+	/* Set flag */
+	state->in_queue = true;
+}
+
+static void xive_pre_save_mask_irq(struct kvmppc_xive *xive,
+				   struct kvmppc_xive_src_block *sb,
+				   u32 irq)
+{
+	struct kvmppc_xive_irq_state *state = &sb->irq_state[irq];
+
+	if (!state->valid)
+		return;
+
+	/* Mask and save state, this will also sync HW queues */
+	state->saved_scan_prio = xive_lock_and_mask(xive, sb, state);
+
+	/* Transfer P and Q */
+	state->saved_p = state->old_p;
+	state->saved_q = state->old_q;
+
+	/* Unlock */
+	arch_spin_unlock(&sb->lock);
+}
+
+static void xive_pre_save_unmask_irq(struct kvmppc_xive *xive,
+				     struct kvmppc_xive_src_block *sb,
+				     u32 irq)
+{
+	struct kvmppc_xive_irq_state *state = &sb->irq_state[irq];
+
+	if (!state->valid)
+		return;
+
+	/*
+	 * Lock / exclude EOI (not technically necessary if the
+	 * guest isn't running concurrently. If this becomes a
+	 * performance issue we can probably remove the lock.
+	 */
+	xive_lock_for_unmask(sb, state);
+
+	/* Restore mask/prio if it wasn't masked */
+	if (state->saved_scan_prio != MASKED)
+		xive_finish_unmask(xive, sb, state, state->saved_scan_prio);
+
+	/* Unlock */
+	arch_spin_unlock(&sb->lock);
+}
+
+static void xive_pre_save_queue(struct kvmppc_xive *xive, struct xive_q *q)
+{
+	u32 idx = q->idx;
+	u32 toggle = q->toggle;
+	u32 irq;
+
+	do {
+		irq = __xive_read_eq(q->qpage, q->msk, &idx, &toggle);
+		if (irq > XICS_IPI)
+			xive_pre_save_set_queued(xive, irq);
+	} while(irq);
+}
+
+static void xive_pre_save_scan(struct kvmppc_xive *xive)
+{
+	struct kvm_vcpu *vcpu = NULL;
+	int i, j;
+
+	/*
+	 * See comment in xive_get_source() about how this
+	 * work. Collect a stable state for all interrupts
+	 */
+	for (i = 0; i <= xive->max_sbid; i++) {
+		struct kvmppc_xive_src_block *sb = xive->src_blocks[i];
+		if (!sb)
+			continue;
+		for (j = 0;  j < KVMPPC_XICS_IRQ_PER_ICS; j++)
+			xive_pre_save_mask_irq(xive, sb, j);
+	}
+
+	/* Then scan the queues and update the "in_queue" flag */
+	kvm_for_each_vcpu(i, vcpu, xive->kvm) {
+		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+		if (!xc)
+			continue;
+		for (j = 0; j < KVMPPC_XIVE_Q_COUNT; j++) {
+			if (xc->queues[i].qpage)
+				xive_pre_save_queue(xive, &xc->queues[i]);
+		}
+	}
+
+	/* Finally restore interrupt states */
+	for (i = 0; i <= xive->max_sbid; i++) {
+		struct kvmppc_xive_src_block *sb = xive->src_blocks[i];
+		if (!sb)
+			continue;
+		for (j = 0;  j < KVMPPC_XICS_IRQ_PER_ICS; j++)
+			xive_pre_save_unmask_irq(xive, sb, j);
+	}
+}
+
+static void xive_post_save_scan(struct kvmppc_xive *xive)
+{
+	u32 i, j;
+
+	/* Clear all the in_queue flags */
+	for (i = 0; i <= xive->max_sbid; i++) {
+		struct kvmppc_xive_src_block *sb = xive->src_blocks[i];
+		if (!sb)
+			continue;
+		for (j = 0;  j < KVMPPC_XICS_IRQ_PER_ICS; j++)
+			sb->irq_state[j].in_queue = false;
+	}
+
+	/* Next get_source() will do a new scan */
+	xive->saved_src_count = 0;
+}
+
+/*
+ * This returns the source configuration and state to user space.
+ */
+static int xive_get_source(struct kvmppc_xive *xive, long irq, u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u64 __user *ubufp = (u64 __user *) addr;
+	u64 val, prio;
+	u16 idx;
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb)
+		return -ENOENT;
+
+	state = &sb->irq_state[idx];
+
+	if (!state->valid)
+		return -ENOENT;
+
+	pr_devel("get_source(%ld)...\n", irq);
+
+	/*
+	 * So to properly save the state into something that looks like a
+	 * XICS migration stream we cannot treat interrupts individually.
+	 *
+	 * We need, instead, mask them all (& save their previous PQ state)
+	 * to get a stable state in the HW, then sync them to ensure that
+	 * any interrupt that had already fired hits its queue, and finally
+	 * scan all the queues to collect which interrupts are still present
+	 * in the queues, so we can set the "pending" flag on them and
+	 * they can be resent on restore.
+	 *
+	 * So we do it all when the "first" interrupt gets saved, all the
+	 * state is collected at that point, the rest of xive_get_source()
+	 * will merely collect and convert that state to the expected
+	 * userspace bit mask.
+	 */
+	if (xive->saved_src_count == 0)
+		xive_pre_save_scan(xive);
+	xive->saved_src_count++;
+
+	/* Convert saved state into something compatible with xics */
+	val = state->guest_server;
+	prio = state->saved_scan_prio;
+
+	if (prio == MASKED) {
+		val |= KVM_XICS_MASKED;
+		prio = state->saved_priority;
+	}
+	val |= prio << KVM_XICS_PRIORITY_SHIFT;
+	if (state->lsi) {
+		val |= KVM_XICS_LEVEL_SENSITIVE;
+		if (state->saved_p)
+			val |= KVM_XICS_PENDING;
+	} else {
+		if (state->saved_p)
+			val |= KVM_XICS_PRESENTED;
+
+		if (state->saved_q)
+			val |= KVM_XICS_QUEUED;
+
+		/*
+		 * We mark it pending (which will attempt a re-delivery)
+		 * if we are in a queue *or* we were masked and had
+		 * Q set which is equivalent to the XICS "masked pending"
+		 * state
+		 */
+		if (state->in_queue || (prio == MASKED && state->saved_q))
+			val |= KVM_XICS_PENDING;
+	}
+
+	/*
+	 * If that was the last interrupt saved, reset the
+	 * in_queue flags
+	 */
+	if (xive->saved_src_count == xive->src_count)
+		xive_post_save_scan(xive);
+
+	/* Copy the result to userspace */
+	if (put_user(val, ubufp))
+		return -EFAULT;
+
+	return 0;
+}
+
+static struct kvmppc_xive_src_block *xive_create_src_block(struct kvmppc_xive *xive,
+							   int irq)
+{
+	struct kvm *kvm = xive->kvm;
+	struct kvmppc_xive_src_block *sb;
+	int i, bid;
+
+	bid = irq >> KVMPPC_XICS_ICS_SHIFT;
+
+	mutex_lock(&kvm->lock);
+
+	/* block already exists - somebody else got here first */
+	if (xive->src_blocks[bid])
+		goto out;
+
+	/* Create the ICS */
+	sb = kzalloc(sizeof(*sb), GFP_KERNEL);
+	if (!sb)
+		goto out;
+
+	sb->id = bid;
+
+	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
+		sb->irq_state[i].number = (bid << KVMPPC_XICS_ICS_SHIFT) | i;
+		sb->irq_state[i].guest_priority = MASKED;
+		sb->irq_state[i].saved_priority = MASKED;
+		sb->irq_state[i].act_priority = MASKED;
+	}
+	smp_wmb();
+	xive->src_blocks[bid] = sb;
+
+	if (bid > xive->max_sbid)
+		xive->max_sbid = bid;
+
+out:
+	mutex_unlock(&kvm->lock);
+	return xive->src_blocks[bid];
+}
+
+static bool xive_check_delayed_irq(struct kvmppc_xive *xive, u32 irq)
+{
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu = NULL;
+	int i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+
+		if (!xc)
+			continue;
+
+		if (xc->delayed_irq == irq) {
+			xc->delayed_irq = 0;
+			xive->delayed_irqs--;
+			return true;
+		}
+	}
+	return false;
+}
+
+static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u64 __user *ubufp = (u64 __user *) addr;
+	u16 idx;
+	u64 val;
+	u8 act_prio, guest_prio;
+	u32 server;
+	int rc = 0;
+
+	if (irq < KVMPPC_XICS_FIRST_IRQ || irq >= KVMPPC_XICS_NR_IRQS)
+		return -ENOENT;
+
+	pr_devel("set_source(irq=0x%lx)\n", irq);
+
+	/* Find the source */
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb) {
+		pr_devel("No source, creating source block...\n");
+		sb = xive_create_src_block(xive, irq);
+		if (!sb) {
+			pr_devel("Failed to create block...\n");
+			return -ENOMEM;
+		}
+	}
+	state = &sb->irq_state[idx];
+
+	/* Read user passed data */
+	if (get_user(val, ubufp)) {
+		pr_devel("fault getting user info !\n");
+		return -EFAULT;
+	}
+
+	server = val & KVM_XICS_DESTINATION_MASK;
+	guest_prio = val >> KVM_XICS_PRIORITY_SHIFT;
+
+	pr_devel("  val=0x016%llx (server=0x%x, guest_prio=%d)\n",
+		 val, server, guest_prio);
+	/*
+	 * If the source doesn't already have an IPI, allocate
+	 * one and get the corresponding data
+	 */
+	if (!state->ipi_number) {
+		state->ipi_number = xive_native_alloc_irq();
+		if (state->ipi_number == 0) {
+			pr_devel("Failed to allocate IPI !\n");
+			return -ENOMEM;
+		}
+		xive_native_populate_irq_data(state->ipi_number, &state->ipi_data);
+		pr_devel(" src_ipi=0x%x\n", state->ipi_number);
+	}
+
+	/*
+	 * We use lock_and_mask() to set us in the right masked
+	 * state. We will override that state from the saved state
+	 * further down, but this will handle the cases of interrupts
+	 * that need FW masking. We set the initial guest_priority to
+	 * 0 before calling it to ensure it actually performs the masking.
+	 */
+	state->guest_priority = 0;
+	xive_lock_and_mask(xive, sb, state);
+
+	/*
+	 * Now, we select a target if we have one. If we don't we
+	 * leave the interrupt untargetted. It means that an interrupt
+	 * can become "untargetted" accross migration if it was masked
+	 * by set_xive() but there is little we can do about it.
+	 */
+
+	/* First convert prio and mark interrupt as untargetted */
+	act_prio = xive_prio_from_guest(guest_prio);
+	state->act_priority = MASKED;
+	state->guest_server = server;
+
+	/*
+	 * We need to drop the lock due to the mutex below. Hopefully
+	 * nothing is touching that interrupt yet since it hasn't been
+	 * advertized to a running guest yet
+	 */
+	arch_spin_unlock(&sb->lock);
+
+	/* If we have a priority target the interrupt */
+	if (act_prio != MASKED) {
+		/* First, check provisioning of queues */
+		mutex_lock(&xive->kvm->lock);
+		rc = xive_check_provisioning(xive->kvm, act_prio);
+		mutex_unlock(&xive->kvm->lock);
+
+		/* Target interrupt */
+		if (rc == 0)
+			rc = xive_target_interrupt(xive->kvm, state,
+						   server, act_prio);
+		/*
+		 * If provisioning or targetting failed, leave it
+		 * alone and masked. It will remain disabled until
+		 * the guest re-targets it.
+		 */
+	}
+
+	/*
+	 * Find out if this was a delayed irq stashed in an ICP,
+	 * in which case, treat it as pending
+	 */
+	if (xive->delayed_irqs && xive_check_delayed_irq(xive, irq)) {
+		val |= KVM_XICS_PENDING;
+		pr_devel("  Found delayed ! forcing PENDING !\n");
+	}
+
+	/* Cleanup the SW state */
+	state->old_p = false;
+	state->old_q = false;
+	state->lsi = false;
+	state->asserted = false;
+
+	/* Restore LSI state */
+	if (val & KVM_XICS_LEVEL_SENSITIVE) {
+		state->lsi = true;
+		if (val & KVM_XICS_PENDING)
+			state->asserted = true;
+		pr_devel("  LSI ! Asserted=%d\n", state->asserted);
+	}
+
+	/*
+	 * Restore P and Q. If the interrupt was pending, we
+	 * force both P and Q, which will trigger a resend.
+	 *
+	 * That means that a guest that had both an interrupt
+	 * pending (queued) and Q set will restore with only
+	 * one instance of that interrupt instead of 2, but that
+	 * is perfectly fine as coalescing interrupts that haven't
+	 * been presented yet is always allowed.
+	 */
+	if (val & KVM_XICS_PRESENTED || val & KVM_XICS_PENDING)
+		state->old_p = true;
+	if (val & KVM_XICS_QUEUED || val & KVM_XICS_PENDING)
+		state->old_q = true;
+
+	pr_devel("  P=%d, Q=%d\n", state->old_p, state->old_q);
+
+	/*
+	 * If the interrupt was unmasked, update guest priority and
+	 * perform the appropriate state transition and do a
+	 * re-trigger if necessary.
+	 */
+	if (val & KVM_XICS_MASKED) {
+		pr_devel("  masked, saving prio\n");
+		state->guest_priority = MASKED;
+		state->saved_priority = guest_prio;
+	} else {
+		pr_devel("  unmasked, restoring to prio %d\n", guest_prio);
+		xive_finish_unmask(xive, sb, state, guest_prio);
+		state->saved_priority = guest_prio;
+	}
+
+	/* Increment the number of valid sources and mark this one valid */
+	if (!state->valid)
+		xive->src_count++;
+	state->valid = true;
+
+	return 0;
+}
+
+int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
+			bool line_status)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u16 idx;
+
+	if (!xive)
+		return -ENODEV;
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb)
+		return -EINVAL;
+
+	/* Perform locklessly .... (we need to do some RCUisms here...) */
+	state = &sb->irq_state[idx];
+	if (!state->valid)
+		return -EINVAL;
+
+	/* We don't allow a trigger on a passed-through interrupt */
+	if (state->pt_number)
+		return -EINVAL;
+
+	if ((level == 1 && state->lsi) || level == KVM_INTERRUPT_SET_LEVEL)
+		state->asserted = 1;
+	else if (level == 0 || level == KVM_INTERRUPT_UNSET) {
+		state->asserted = 0;
+		return 0;
+	}
+
+	/* Trigger the IPI */
+	xive_irq_trigger(&state->ipi_data);
+
+	return 0;
+}
+
+static int xive_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	struct kvmppc_xive *xive = dev->private;
+
+	/* We honor the existing XICS ioctl */
+	switch (attr->group) {
+	case KVM_DEV_XICS_GRP_SOURCES:
+		return xive_set_source(xive, attr->attr, attr->addr);
+	}
+	return -ENXIO;
+}
+
+static int xive_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	struct kvmppc_xive *xive = dev->private;
+
+	/* We honor the existing XICS ioctl */
+	switch (attr->group) {
+	case KVM_DEV_XICS_GRP_SOURCES:
+		return xive_get_source(xive, attr->attr, attr->addr);
+	}
+	return -ENXIO;
+}
+
+static int xive_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
+{
+	/* We honor the same limits as XICS, at least for now */
+	switch (attr->group) {
+	case KVM_DEV_XICS_GRP_SOURCES:
+		if (attr->attr >= KVMPPC_XICS_FIRST_IRQ &&
+		    attr->attr < KVMPPC_XICS_NR_IRQS)
+			return 0;
+		break;
+	}
+	return -ENXIO;
+}
+
+static void kvmppc_xive_cleanup_irq(u32 hw_num, struct xive_irq_data *xd)
+{
+	xive_vm_esb_load(xd, XIVE_ESB_SET_PQ_01);
+	xive_native_configure_irq(hw_num, 0, MASKED, 0);
+	xive_cleanup_irq_data(xd);
+}
+
+static void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
+{
+	int i;
+
+	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
+		struct kvmppc_xive_irq_state *state = &sb->irq_state[i];
+
+		if (!state->valid)
+			continue;
+
+		kvmppc_xive_cleanup_irq(state->ipi_number, &state->ipi_data);
+		xive_native_free_irq(state->ipi_number);
+
+		/* Pass-through, cleanup too */
+		if (state->pt_number)
+			kvmppc_xive_cleanup_irq(state->pt_number, state->pt_data);
+
+		state->valid = false;
+	}
+}
+
+static void kvmppc_xive_free(struct kvm_device *dev)
+{
+	struct kvmppc_xive *xive = dev->private;
+	struct kvm *kvm = xive->kvm;
+	int i;
+
+	debugfs_remove(xive->dentry);
+
+	if (kvm)
+		kvm->arch.xive = NULL;
+
+	/* Mask and free interrupts */
+	for (i = 0; i <= xive->max_sbid; i++) {
+		if (xive->src_blocks[i])
+			kvmppc_xive_free_sources(xive->src_blocks[i]);
+		kfree(xive->src_blocks[i]);
+		xive->src_blocks[i] = NULL;
+	}
+
+	if (xive->vp_base != XIVE_INVALID_VP)
+		xive_native_free_vp_block(xive->vp_base);
+
+
+	kfree(xive);
+	kfree(dev);
+}
+
+static int kvmppc_xive_create(struct kvm_device *dev, u32 type)
+{
+	struct kvmppc_xive *xive;
+	struct kvm *kvm = dev->kvm;
+	int ret = 0;
+
+	pr_devel("Creating xive for partition\n");
+
+	xive = kzalloc(sizeof(*xive), GFP_KERNEL);
+	if (!xive)
+		return -ENOMEM;
+
+	dev->private = xive;
+	xive->dev = dev;
+	xive->kvm = kvm;
+
+	/* Already there ? */
+	if (kvm->arch.xive)
+		ret = -EEXIST;
+	else
+		kvm->arch.xive = xive;
+
+	/* We use the default queue size set by the host */
+	xive->q_order = xive_native_default_eq_shift();
+	if (xive->q_order < PAGE_SHIFT)
+		xive->q_page_order = 0;
+	else
+		xive->q_page_order = xive->q_order - PAGE_SHIFT;
+
+	/* Allocate a bunch of VPs */
+	xive->vp_base = xive_native_alloc_vp_block(KVM_MAX_VCPUS);
+	pr_devel("VP_Base=%x\n", xive->vp_base);
+
+	if (xive->vp_base == XIVE_INVALID_VP)
+		ret = -ENOMEM;
+
+	if (ret) {
+		kfree(xive);
+		return ret;
+	}
+
+	return 0;
+}
+
+
+static int xive_debug_show(struct seq_file *m, void *private)
+{
+	struct kvmppc_xive *xive = m->private;
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	u64 t_rm_h_xirr = 0;
+	u64 t_rm_h_ipoll = 0;
+	u64 t_rm_h_cppr = 0;
+	u64 t_rm_h_eoi = 0;
+	u64 t_rm_h_ipi = 0;
+	u64 t_vm_h_xirr = 0;
+	u64 t_vm_h_ipoll = 0;
+	u64 t_vm_h_cppr = 0;
+	u64 t_vm_h_eoi = 0;
+	u64 t_vm_h_ipi = 0;
+	unsigned int i;
+
+	if (!kvm)
+		return 0;
+
+	seq_printf(m, "=========\nVCPU state\n=========\n");
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+
+		if (!xc)
+			continue;
+
+		seq_printf(m, "cpu server %#x CPPR:%#x HWCPPR:%#x"
+			   " MFRR:%#x PEND:%#x h_xirr: R=%lld V=%lld\n",
+			   xc->server_num, xc->cppr, xc->hw_cppr,
+			   xc->mfrr, xc->pending,
+			   xc->stat_rm_h_xirr, xc->stat_vm_h_xirr);
+
+		t_rm_h_xirr += xc->stat_rm_h_xirr;
+		t_rm_h_ipoll += xc->stat_rm_h_ipoll;
+		t_rm_h_cppr += xc->stat_rm_h_cppr;
+		t_rm_h_eoi += xc->stat_rm_h_eoi;
+		t_rm_h_ipi += xc->stat_rm_h_ipi;
+		t_vm_h_xirr += xc->stat_vm_h_xirr;
+		t_vm_h_ipoll += xc->stat_vm_h_ipoll;
+		t_vm_h_cppr += xc->stat_vm_h_cppr;
+		t_vm_h_eoi += xc->stat_vm_h_eoi;
+		t_vm_h_ipi += xc->stat_vm_h_ipi;
+	}
+
+	seq_printf(m, "Hcalls totals\n");
+	seq_printf(m, " H_XIRR  R=%10lld V=%10lld\n", t_rm_h_xirr, t_vm_h_xirr);
+	seq_printf(m, " H_IPOLL R=%10lld V=%10lld\n", t_rm_h_ipoll, t_vm_h_ipoll);
+	seq_printf(m, " H_CPPR  R=%10lld V=%10lld\n", t_rm_h_cppr, t_vm_h_cppr);
+	seq_printf(m, " H_EOI   R=%10lld V=%10lld\n", t_rm_h_eoi, t_vm_h_eoi);
+	seq_printf(m, " H_IPI   R=%10lld V=%10lld\n", t_rm_h_ipi, t_vm_h_ipi);
+
+	return 0;
+}
+
+static int xive_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, xive_debug_show, inode->i_private);
+}
+
+static const struct file_operations xive_debug_fops = {
+	.open = xive_debug_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void xive_debugfs_init(struct kvmppc_xive *xive)
+{
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, "kvm-xive-%p", xive);
+	if (!name) {
+		pr_err("%s: no memory for name\n", __func__);
+		return;
+	}
+
+	xive->dentry = debugfs_create_file(name, S_IRUGO, powerpc_debugfs_root,
+					   xive, &xive_debug_fops);
+
+	pr_debug("%s: created %s\n", __func__, name);
+	kfree(name);
+}
+
+static void kvmppc_xive_init(struct kvm_device *dev)
+{
+	struct kvmppc_xive *xive = (struct kvmppc_xive *)dev->private;
+
+	/* Register some debug interfaces */
+	xive_debugfs_init(xive);
+}
+
+struct kvm_device_ops kvm_xive_ops = {
+	.name = "kvm-xive",
+	.create = kvmppc_xive_create,
+	.init = kvmppc_xive_init,
+	.destroy = kvmppc_xive_free,
+	.set_attr = xive_set_attr,
+	.get_attr = xive_get_attr,
+	.has_attr = xive_has_attr,
+};
+
+void kvmppc_xive_init_module(void)
+{
+	__xive_vm_h_xirr = xive_vm_h_xirr;
+	__xive_vm_h_ipoll = xive_vm_h_ipoll;
+	__xive_vm_h_ipi = xive_vm_h_ipi;
+	__xive_vm_h_cppr = xive_vm_h_cppr;
+	__xive_vm_h_eoi = xive_vm_h_eoi;
+}
+
+void kvmppc_xive_exit_module(void)
+{
+	__xive_vm_h_xirr = NULL;
+	__xive_vm_h_ipoll = NULL;
+	__xive_vm_h_ipi = NULL;
+	__xive_vm_h_cppr = NULL;
+	__xive_vm_h_eoi = NULL;
+}
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
new file mode 100644
index 000000000000..fcccfbc2c4f4
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -0,0 +1,254 @@
+/*
+ * Copyright 2017 Benjamin Herrenschmidt, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _KVM_PPC_BOOK3S_XIVE_H
+#define _KVM_PPC_BOOK3S_XIVE_H
+
+#include "book3s_xics.h"
+
+/*
+ * State for one guest irq source.
+ *
+ * For each guest source we allocate a HW interrupt in the XIVE
+ * which we use for all SW triggers. It will be unused for
+ * pass-through but it's easier to keep around as the same
+ * guest interrupt can alternatively be emulated or pass-through
+ * if a physical device is hot unplugged and replaced with an
+ * emulated one.
+ *
+ * This state structure is very similar to the XICS one with
+ * additional XIVE specific tracking.
+ */
+struct kvmppc_xive_irq_state {
+	bool valid;			/* Interrupt entry is valid */
+
+	u32 number;			/* Guest IRQ number */
+	u32 ipi_number;			/* XIVE IPI HW number */
+	struct xive_irq_data ipi_data;	/* XIVE IPI associated data */
+	u32 pt_number;			/* XIVE Pass-through number if any */
+	struct xive_irq_data *pt_data;	/* XIVE Pass-through associated data */
+
+	/* Targetting as set by guest */
+	u32 guest_server;		/* Current guest selected target */
+	u8 guest_priority;		/* Guest set priority */
+	u8 saved_priority;		/* Saved priority when masking */
+
+	/* Actual targetting */
+	u32 act_server;			/* Actual server */
+	u8 act_priority;		/* Actual priority */
+
+	/* Various state bits */
+	bool in_eoi;			/* Synchronize with H_EOI */
+	bool old_p;			/* P bit state when masking */
+	bool old_q;			/* Q bit state when masking */
+	bool lsi;			/* level-sensitive interrupt */
+	bool asserted;			/* Only for emulated LSI: current state */
+
+	/* Saved for migration state */
+	bool in_queue;
+	bool saved_p;
+	bool saved_q;
+	u8 saved_scan_prio;
+};
+
+/* Select the "right" interrupt (IPI vs. passthrough) */
+static inline void kvmppc_xive_select_irq(struct kvmppc_xive_irq_state *state,
+					  u32 *out_hw_irq,
+					  struct xive_irq_data **out_xd)
+{
+	if (state->pt_number) {
+		if (out_hw_irq)
+			*out_hw_irq = state->pt_number;
+		if (out_xd)
+			*out_xd = state->pt_data;
+	} else {
+		if (out_hw_irq)
+			*out_hw_irq = state->ipi_number;
+		if (out_xd)
+			*out_xd = &state->ipi_data;
+	}
+}
+
+/*
+ * This corresponds to an "ICS" in XICS terminology, we use it
+ * as a mean to break up source information into multiple structures.
+ */
+struct kvmppc_xive_src_block {
+	arch_spinlock_t lock;
+	u16 id;
+	struct kvmppc_xive_irq_state irq_state[KVMPPC_XICS_IRQ_PER_ICS];
+};
+
+
+struct kvmppc_xive {
+	struct kvm *kvm;
+	struct kvm_device *dev;
+	struct dentry *dentry;
+
+	/* VP block associated with the VM */
+	u32	vp_base;
+
+	/* Blocks of sources */
+	struct kvmppc_xive_src_block *src_blocks[KVMPPC_XICS_MAX_ICS_ID + 1];
+	u32	max_sbid;
+
+	/*
+	 * For state save, we lazily scan the queues on the first interrupt
+	 * being migrated. We don't have a clean way to reset that flags
+	 * so we keep track of the number of valid sources and how many of
+	 * them were migrated so we can reset when all of them have been
+	 * processed.
+	 */
+	u32	src_count;
+	u32	saved_src_count;
+
+	/*
+	 * Some irqs are delayed on restore until the source is created,
+	 * keep track here of how many of them
+	 */
+	u32	delayed_irqs;
+
+	/* Which queues (priorities) are in use by the guest */
+	u8	qmap;
+
+	/* Queue orders */
+	u32	q_order;
+	u32	q_page_order;
+
+};
+
+#define KVMPPC_XIVE_Q_COUNT	8
+
+struct kvmppc_xive_vcpu {
+	struct kvmppc_xive	*xive;
+	struct kvm_vcpu		*vcpu;
+	bool			valid;
+
+	/* Server number. This is the HW CPU ID from a guest perspective */
+	u32			server_num;
+
+	/*
+	 * HW VP corresponding to this VCPU. This is the base of the VP
+	 * block plus the server number.
+	 */
+	u32			vp_id;
+	u32			vp_chip_id;
+	u32			vp_cam;
+
+	/* IPI used for sending ... IPIs */
+	u32			vp_ipi;
+	struct xive_irq_data	vp_ipi_data;
+
+	/* Local emulation state */
+	uint8_t			cppr;	/* guest CPPR */
+	uint8_t			hw_cppr;/* Hardware CPPR */
+	uint8_t			mfrr;
+	uint8_t			pending;
+
+	/* Each VP has 8 queues though we only provision some */
+	struct xive_q		queues[KVMPPC_XIVE_Q_COUNT];
+	u32			esc_virq[KVMPPC_XIVE_Q_COUNT];
+	char			*esc_virq_names[KVMPPC_XIVE_Q_COUNT];
+
+	/* Stash a delayed irq on restore from migration (see set_icp) */
+	u32			delayed_irq;
+
+	/* Stats */
+	u64			stat_rm_h_xirr;
+	u64			stat_rm_h_ipoll;
+	u64			stat_rm_h_cppr;
+	u64			stat_rm_h_eoi;
+	u64			stat_rm_h_ipi;
+	u64			stat_vm_h_xirr;
+	u64			stat_vm_h_ipoll;
+	u64			stat_vm_h_cppr;
+	u64			stat_vm_h_eoi;
+	u64			stat_vm_h_ipi;
+};
+
+static inline struct kvm_vcpu *kvmppc_xive_find_server(struct kvm *kvm, u32 nr)
+{
+	struct kvm_vcpu *vcpu = NULL;
+	int i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (vcpu->arch.xive_vcpu && nr == vcpu->arch.xive_vcpu->server_num)
+			return vcpu;
+	}
+	return NULL;
+}
+
+static inline struct kvmppc_xive_src_block *kvmppc_xive_find_source(struct kvmppc_xive *xive,
+		u32 irq, u16 *source)
+{
+	u32 bid = irq >> KVMPPC_XICS_ICS_SHIFT;
+	u16 src = irq & KVMPPC_XICS_SRC_MASK;
+
+	if (source)
+		*source = src;
+	if (bid > KVMPPC_XICS_MAX_ICS_ID)
+		return NULL;
+	return xive->src_blocks[bid];
+}
+
+/*
+ * Mapping between guest priorities and host priorities
+ * is as follow.
+ *
+ * Guest request for 0...6 are honored. Guest request for anything
+ * higher results in a priority of 7 being applied.
+ *
+ * However, when XIRR is returned via H_XIRR, 7 is translated to 0xb
+ * in order to match AIX expectations
+ *
+ * Similar mapping is done for CPPR values
+ */
+static inline u8 xive_prio_from_guest(u8 prio)
+{
+	if (prio == 0xff || prio < 8)
+		return prio;
+	return 7;
+}
+
+static inline u8 xive_prio_to_guest(u8 prio)
+{
+	if (prio == 0xff || prio < 7)
+		return prio;
+	return 0xb;
+}
+
+static inline u32 __xive_read_eq(__be32 *qpage, u32 msk, u32 *idx, u32 *toggle)
+{
+	u32 cur;
+
+	if (!qpage)
+		return 0;
+	cur = be32_to_cpup(qpage + *idx);
+	if ((cur >> 31) == *toggle)
+		return 0;
+	*idx = (*idx + 1) & msk;
+	if (*idx == 0)
+		(*toggle) ^= 1;
+	return cur & 0x7fffffff;
+}
+
+extern unsigned long xive_rm_h_xirr(struct kvm_vcpu *vcpu);
+extern unsigned long xive_rm_h_ipoll(struct kvm_vcpu *vcpu, unsigned long server);
+extern int xive_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
+			 unsigned long mfrr);
+extern int xive_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
+extern int xive_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
+
+extern unsigned long (*__xive_vm_h_xirr)(struct kvm_vcpu *vcpu);
+extern unsigned long (*__xive_vm_h_ipoll)(struct kvm_vcpu *vcpu, unsigned long server);
+extern int (*__xive_vm_h_ipi)(struct kvm_vcpu *vcpu, unsigned long server,
+			      unsigned long mfrr);
+extern int (*__xive_vm_h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr);
+extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
+
+#endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
new file mode 100644
index 000000000000..023a31133c37
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -0,0 +1,503 @@
+/*
+ * Copyright 2017 Benjamin Herrenschmidt, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+/* File to be included by other .c files */
+
+#define XGLUE(a,b) a##b
+#define GLUE(a,b) XGLUE(a,b)
+
+static void GLUE(X_PFX,ack_pending)(struct kvmppc_xive_vcpu *xc)
+{
+	u8 cppr;
+	u16 ack;
+
+	/* XXX DD1 bug workaround: Check PIPR vs. CPPR first ! */
+
+	/* Perform the acknowledge OS to register cycle. */
+	ack = be16_to_cpu(__x_readw(__x_tima + TM_SPC_ACK_OS_REG));
+
+	/* Synchronize subsequent queue accesses */
+	mb();
+
+	/* XXX Check grouping level */
+
+	/* Anything ? */
+	if (!((ack >> 8) & TM_QW1_NSR_EO))
+		return;
+
+	/* Grab CPPR of the most favored pending interrupt */
+	cppr = ack & 0xff;
+	if (cppr < 8)
+		xc->pending |= 1 << cppr;
+
+#ifdef XIVE_RUNTIME_CHECKS
+	/* Check consistency */
+	if (cppr >= xc->hw_cppr)
+		pr_warn("KVM-XIVE: CPU %d odd ack CPPR, got %d at %d\n",
+			smp_processor_id(), cppr, xc->hw_cppr);
+#endif
+
+	/*
+	 * Update our image of the HW CPPR. We don't yet modify
+	 * xc->cppr, this will be done as we scan for interrupts
+	 * in the queues.
+	 */
+	xc->hw_cppr = cppr;
+}
+
+static u8 GLUE(X_PFX,esb_load)(struct xive_irq_data *xd, u32 offset)
+{
+	u64 val;
+
+	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
+		offset |= offset << 4;
+
+	val =__x_readq(__x_eoi_page(xd) + offset);
+#ifdef __LITTLE_ENDIAN__
+	val >>= 64-8;
+#endif
+	return (u8)val;
+}
+
+
+static void GLUE(X_PFX,source_eoi)(u32 hw_irq, struct xive_irq_data *xd)
+{
+	/* If the XIVE supports the new "store EOI facility, use it */
+	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
+		__x_writeq(0, __x_eoi_page(xd));
+	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
+		opal_int_eoi(hw_irq);
+	} else {
+		uint64_t eoi_val;
+
+		/*
+		 * Otherwise for EOI, we use the special MMIO that does
+		 * a clear of both P and Q and returns the old Q,
+		 * except for LSIs where we use the "EOI cycle" special
+		 * load.
+		 *
+		 * This allows us to then do a re-trigger if Q was set
+		 * rather than synthetizing an interrupt in software
+		 *
+		 * For LSIs, using the HW EOI cycle works around a problem
+		 * on P9 DD1 PHBs where the other ESB accesses don't work
+		 * properly.
+		 */
+		if (xd->flags & XIVE_IRQ_FLAG_LSI)
+			__x_readq(__x_eoi_page(xd));
+		else {
+			eoi_val = GLUE(X_PFX,esb_load)(xd, XIVE_ESB_SET_PQ_00);
+
+			/* Re-trigger if needed */
+			if ((eoi_val & 1) && __x_trig_page(xd))
+				__x_writeq(0, __x_trig_page(xd));
+		}
+	}
+}
+
+enum {
+	scan_fetch,
+	scan_poll,
+	scan_eoi,
+};
+
+static u32 GLUE(X_PFX,scan_interrupts)(struct kvmppc_xive_vcpu *xc,
+				       u8 pending, int scan_type)
+{
+	u32 hirq = 0;
+	u8 prio = 0xff;
+
+	/* Find highest pending priority */
+	while ((xc->mfrr != 0xff || pending != 0) && hirq == 0) {
+		struct xive_q *q;
+		u32 idx, toggle;
+		__be32 *qpage;
+
+		/*
+		 * If pending is 0 this will return 0xff which is what
+		 * we want
+		 */
+		prio = ffs(pending) - 1;
+
+		/*
+		 * If the most favoured prio we found pending is less
+		 * favored (or equal) than a pending IPI, we return
+		 * the IPI instead.
+		 *
+		 * Note: If pending was 0 and mfrr is 0xff, we will
+		 * not spurriously take an IPI because mfrr cannot
+		 * then be smaller than cppr.
+		 */
+		if (prio >= xc->mfrr && xc->mfrr < xc->cppr) {
+			prio = xc->mfrr;
+			hirq = XICS_IPI;
+			break;
+		}
+
+		/* Don't scan past the guest cppr */
+		if (prio >= xc->cppr || prio > 7)
+			break;
+
+		/* Grab queue and pointers */
+		q = &xc->queues[prio];
+		idx = q->idx;
+		toggle = q->toggle;
+
+		/*
+		 * Snapshot the queue page. The test further down for EOI
+		 * must use the same "copy" that was used by __xive_read_eq
+		 * since qpage can be set concurrently and we don't want
+		 * to miss an EOI.
+		 */
+		qpage = READ_ONCE(q->qpage);
+
+skip_ipi:
+		/*
+		 * Try to fetch from the queue. Will return 0 for a
+		 * non-queueing priority (ie, qpage = 0).
+		 */
+		hirq = __xive_read_eq(qpage, q->msk, &idx, &toggle);
+
+		/*
+		 * If this was a signal for an MFFR change done by
+		 * H_IPI we skip it. Additionally, if we were fetching
+		 * we EOI it now, thus re-enabling reception of a new
+		 * such signal.
+		 *
+		 * We also need to do that if prio is 0 and we had no
+		 * page for the queue. In this case, we have non-queued
+		 * IPI that needs to be EOId.
+		 *
+		 * This is safe because if we have another pending MFRR
+		 * change that wasn't observed above, the Q bit will have
+		 * been set and another occurrence of the IPI will trigger.
+		 */
+		if (hirq == XICS_IPI || (prio == 0 && !qpage)) {
+			if (scan_type == scan_fetch)
+				GLUE(X_PFX,source_eoi)(xc->vp_ipi,
+						       &xc->vp_ipi_data);
+			/* Loop back on same queue with updated idx/toggle */
+#ifdef XIVE_RUNTIME_CHECKS
+			WARN_ON(hirq && hirq != XICS_IPI);
+#endif
+			if (hirq)
+				goto skip_ipi;
+		}
+
+		/* If fetching, update queue pointers */
+		if (scan_type == scan_fetch) {
+			q->idx = idx;
+			q->toggle = toggle;
+		}
+
+		/* Something found, stop searching */
+		if (hirq)
+			break;
+
+		/* Clear the pending bit on the now empty queue */
+		pending &= ~(1 << prio);
+
+		/*
+		 * Check if the queue count needs adjusting due to
+		 * interrupts being moved away.
+		 */
+		if (atomic_read(&q->pending_count)) {
+			int p = atomic_xchg(&q->pending_count, 0);
+			if (p) {
+#ifdef XIVE_RUNTIME_CHECKS
+				WARN_ON(p > atomic_read(&q->count));
+#endif
+				atomic_sub(p, &q->count);
+			}
+		}
+	}
+
+	/* If we are just taking a "peek", do nothing else */
+	if (scan_type == scan_poll)
+		return hirq;
+
+	/* Update the pending bits */
+	xc->pending = pending;
+
+	/*
+	 * If this is an EOI that's it, no CPPR adjustment done here,
+	 * all we needed was cleanup the stale pending bits and check
+	 * if there's anything left.
+	 */
+	if (scan_type == scan_eoi)
+		return hirq;
+
+	/*
+	 * If we found an interrupt, adjust what the guest CPPR should
+	 * be as if we had just fetched that interrupt from HW.
+	 */
+	if (hirq)
+		xc->cppr = prio;
+	/*
+	 * If it was an IPI the HW CPPR might have been lowered too much
+	 * as the HW interrupt we use for IPIs is routed to priority 0.
+	 *
+	 * We re-sync it here.
+	 */
+	if (xc->cppr != xc->hw_cppr) {
+		xc->hw_cppr = xc->cppr;
+		__x_writeb(xc->cppr, __x_tima + TM_QW1_OS + TM_CPPR);
+	}
+
+	return hirq;
+}
+
+X_STATIC unsigned long GLUE(X_PFX,h_xirr)(struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	u8 old_cppr;
+	u32 hirq;
+
+	pr_devel("H_XIRR\n");
+
+	xc->GLUE(X_STAT_PFX,h_xirr)++;
+
+	/* First collect pending bits from HW */
+	GLUE(X_PFX,ack_pending)(xc);
+
+	/*
+	 * Cleanup the old-style bits if needed (they may have been
+	 * set by pull or an escalation interrupts).
+	 */
+	if (test_bit(BOOK3S_IRQPRIO_EXTERNAL, &vcpu->arch.pending_exceptions))
+		clear_bit(BOOK3S_IRQPRIO_EXTERNAL_LEVEL,
+			  &vcpu->arch.pending_exceptions);
+
+	pr_devel(" new pending=0x%02x hw_cppr=%d cppr=%d\n",
+		 xc->pending, xc->hw_cppr, xc->cppr);
+
+	/* Grab previous CPPR and reverse map it */
+	old_cppr = xive_prio_to_guest(xc->cppr);
+
+	/* Scan for actual interrupts */
+	hirq = GLUE(X_PFX,scan_interrupts)(xc, xc->pending, scan_fetch);
+
+	pr_devel(" got hirq=0x%x hw_cppr=%d cppr=%d\n",
+		 hirq, xc->hw_cppr, xc->cppr);
+
+#ifdef XIVE_RUNTIME_CHECKS
+	/* That should never hit */
+	if (hirq & 0xff000000)
+		pr_warn("XIVE: Weird guest interrupt number 0x%08x\n", hirq);
+#endif
+
+	/*
+	 * XXX We could check if the interrupt is masked here and
+	 * filter it. If we chose to do so, we would need to do:
+	 *
+	 *    if (masked) {
+	 *        lock();
+	 *        if (masked) {
+	 *            old_Q = true;
+	 *            hirq = 0;
+	 *        }
+	 *        unlock();
+	 *    }
+	 */
+
+	/* Return interrupt and old CPPR in GPR4 */
+	vcpu->arch.gpr[4] = hirq | (old_cppr << 24);
+
+	return H_SUCCESS;
+}
+
+X_STATIC unsigned long GLUE(X_PFX,h_ipoll)(struct kvm_vcpu *vcpu, unsigned long server)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	u8 pending = xc->pending;
+	u32 hirq;
+	u8 pipr;
+
+	pr_devel("H_IPOLL(server=%ld)\n", server);
+
+	xc->GLUE(X_STAT_PFX,h_ipoll)++;
+
+	/* Grab the target VCPU if not the current one */
+	if (xc->server_num != server) {
+		vcpu = kvmppc_xive_find_server(vcpu->kvm, server);
+		if (!vcpu)
+			return H_PARAMETER;
+		xc = vcpu->arch.xive_vcpu;
+
+		/* Scan all priorities */
+		pending = 0xff;
+	} else {
+		/* Grab pending interrupt if any */
+		pipr = __x_readb(__x_tima + TM_QW1_OS + TM_PIPR);
+		if (pipr < 8)
+			pending |= 1 << pipr;
+	}
+
+	hirq = GLUE(X_PFX,scan_interrupts)(xc, pending, scan_poll);
+
+	/* Return interrupt and old CPPR in GPR4 */
+	vcpu->arch.gpr[4] = hirq | (xc->cppr << 24);
+
+	return H_SUCCESS;
+}
+
+static void GLUE(X_PFX,push_pending_to_hw)(struct kvmppc_xive_vcpu *xc)
+{
+	u8 pending, prio;
+
+	pending = xc->pending;
+	if (xc->mfrr != 0xff) {
+		if (xc->mfrr < 8)
+			pending |= 1 << xc->mfrr;
+		else
+			pending |= 0x80;
+	}
+	if (!pending)
+		return;
+	prio = ffs(pending) - 1;
+
+	__x_writeb(prio, __x_tima + TM_SPC_SET_OS_PENDING);
+}
+
+X_STATIC int GLUE(X_PFX,h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	u8 old_cppr;
+
+	pr_devel("H_CPPR(cppr=%ld)\n", cppr);
+
+	xc->GLUE(X_STAT_PFX,h_cppr)++;
+
+	/* Map CPPR */
+	cppr = xive_prio_from_guest(cppr);
+
+	/* Remember old and update SW state */
+	old_cppr = xc->cppr;
+	xc->cppr = cppr;
+
+	/*
+	 * We are masking less, we need to look for pending things
+	 * to deliver and set VP pending bits accordingly to trigger
+	 * a new interrupt otherwise we might miss MFRR changes for
+	 * which we have optimized out sending an IPI signal.
+	 */
+	if (cppr > old_cppr)
+		GLUE(X_PFX,push_pending_to_hw)(xc);
+
+	/* Apply new CPPR */
+	xc->hw_cppr = cppr;
+	__x_writeb(cppr, __x_tima + TM_QW1_OS + TM_CPPR);
+
+	return H_SUCCESS;
+}
+
+X_STATIC int GLUE(X_PFX,h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct xive_irq_data *xd;
+	u8 new_cppr = xirr >> 24;
+	u32 irq = xirr & 0x00ffffff, hw_num;
+	u16 src;
+	int rc = 0;
+
+	pr_devel("H_EOI(xirr=%08lx)\n", xirr);
+
+	xc->GLUE(X_STAT_PFX,h_eoi)++;
+
+	xc->cppr = xive_prio_from_guest(new_cppr);
+
+	/*
+	 * IPIs are synthetized from MFRR and thus don't need
+	 * any special EOI handling. The underlying interrupt
+	 * used to signal MFRR changes is EOId when fetched from
+	 * the queue.
+	 */
+	if (irq == XICS_IPI || irq == 0)
+		goto bail;
+
+	/* Find interrupt source */
+	sb = kvmppc_xive_find_source(xive, irq, &src);
+	if (!sb) {
+		pr_devel(" source not found !\n");
+		rc = H_PARAMETER;
+		goto bail;
+	}
+	state = &sb->irq_state[src];
+	kvmppc_xive_select_irq(state, &hw_num, &xd);
+
+	state->in_eoi = true;
+	mb();
+
+again:
+	if (state->guest_priority == MASKED) {
+		arch_spin_lock(&sb->lock);
+		if (state->guest_priority != MASKED) {
+			arch_spin_unlock(&sb->lock);
+			goto again;
+		}
+		pr_devel(" EOI on saved P...\n");
+
+		/* Clear old_p, that will cause unmask to perform an EOI */
+		state->old_p = false;
+
+		arch_spin_unlock(&sb->lock);
+	} else {
+		pr_devel(" EOI on source...\n");
+
+		/* Perform EOI on the source */
+		GLUE(X_PFX,source_eoi)(hw_num, xd);
+
+		/* If it's an emulated LSI, check level and resend */
+		if (state->lsi && state->asserted)
+			__x_writeq(0, __x_trig_page(xd));
+
+	}
+
+	mb();
+	state->in_eoi = false;
+bail:
+
+	/* Re-evaluate pending IRQs and update HW */
+	GLUE(X_PFX,scan_interrupts)(xc, xc->pending, scan_eoi);
+	GLUE(X_PFX,push_pending_to_hw)(xc);
+	pr_devel(" after scan pending=%02x\n", xc->pending);
+
+	/* Apply new CPPR */
+	xc->hw_cppr = xc->cppr;
+	__x_writeb(xc->cppr, __x_tima + TM_QW1_OS + TM_CPPR);
+
+	return rc;
+}
+
+X_STATIC int GLUE(X_PFX,h_ipi)(struct kvm_vcpu *vcpu, unsigned long server,
+			       unsigned long mfrr)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+
+	pr_devel("H_IPI(server=%08lx,mfrr=%ld)\n", server, mfrr);
+
+	xc->GLUE(X_STAT_PFX,h_ipi)++;
+
+	/* Find target */
+	vcpu = kvmppc_xive_find_server(vcpu->kvm, server);
+	if (!vcpu)
+		return H_PARAMETER;
+	xc = vcpu->arch.xive_vcpu;
+
+	/* Locklessly write over MFRR */
+	xc->mfrr = mfrr;
+
+	/* Shoot the IPI if most favored than target cppr */
+	if (mfrr < xc->cppr)
+		__x_writeq(0, __x_trig_page(&xc->vp_ipi_data));
+
+	return H_SUCCESS;
+}
diff --git a/arch/powerpc/kvm/irq.h b/arch/powerpc/kvm/irq.h
index 5a9a10b90762..3f1be85a83bc 100644
--- a/arch/powerpc/kvm/irq.h
+++ b/arch/powerpc/kvm/irq.h
@@ -12,6 +12,7 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 #endif
 #ifdef CONFIG_KVM_XICS
 	ret = ret || (kvm->arch.xics != NULL);
+	ret = ret || (kvm->arch.xive != NULL);
 #endif
 	smp_rmb();
 	return ret;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 95c91a9de351..de79bd721ec7 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -37,6 +37,8 @@
 #include <asm/cputhreads.h>
 #include <asm/irqflags.h>
 #include <asm/iommu.h>
+#include <asm/xive.h>
+
 #include "timing.h"
 #include "irq.h"
 #include "../mm/mmu_decl.h"
@@ -699,7 +701,10 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 		kvmppc_mpic_disconnect_vcpu(vcpu->arch.mpic, vcpu);
 		break;
 	case KVMPPC_IRQ_XICS:
-		kvmppc_xics_free_icp(vcpu);
+		if (xive_enabled())
+			kvmppc_xive_cleanup_vcpu(vcpu);
+		else
+			kvmppc_xics_free_icp(vcpu);
 		break;
 	}
 
@@ -1219,8 +1224,12 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 
 		r = -EPERM;
 		dev = kvm_device_from_filp(f.file);
-		if (dev)
-			r = kvmppc_xics_connect_vcpu(dev, vcpu, cap->args[1]);
+		if (dev) {
+			if (xive_enabled())
+				r = kvmppc_xive_connect_vcpu(dev, vcpu, cap->args[1]);
+			else
+				r = kvmppc_xics_connect_vcpu(dev, vcpu, cap->args[1]);
+		}
 
 		fdput(f);
 		break;
@@ -1244,7 +1253,7 @@ bool kvm_arch_intc_initialized(struct kvm *kvm)
 		return true;
 #endif
 #ifdef CONFIG_KVM_XICS
-	if (kvm->arch.xics)
+	if (kvm->arch.xics || kvm->arch.xive)
 		return true;
 #endif
 	return false;
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index e0f856bfbfe8..d71cd773d870 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -890,3 +890,4 @@ EXPORT_SYMBOL_GPL(opal_leds_set_ind);
 EXPORT_SYMBOL_GPL(opal_write_oppanel_async);
 /* Export this for KVM */
 EXPORT_SYMBOL_GPL(opal_int_set_mfrr);
+EXPORT_SYMBOL_GPL(opal_int_eoi);
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index d9cd7f705f21..496036c93531 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -46,13 +46,15 @@
 #endif
 
 bool __xive_enabled;
+EXPORT_SYMBOL_GPL(__xive_enabled);
 bool xive_cmdline_disabled;
 
 /* We use only one priority for now */
 static u8 xive_irq_priority;
 
-/* TIMA */
+/* TIMA exported to KVM */
 void __iomem *xive_tima;
+EXPORT_SYMBOL_GPL(xive_tima);
 u32 xive_tima_offset;
 
 /* Backend ops */
@@ -345,8 +347,11 @@ static void xive_irq_eoi(struct irq_data *d)
 	DBG_VERBOSE("eoi_irq: irq=%d [0x%lx] pending=%02x\n",
 		    d->irq, irqd_to_hwirq(d), xc->pending_prio);
 
-	/* EOI the source if it hasn't been disabled */
-	if (!irqd_irq_disabled(d))
+	/*
+	 * EOI the source if it hasn't been disabled and hasn't
+	 * been passed-through to a KVM guest
+	 */
+	if (!irqd_irq_disabled(d) && !irqd_is_forwarded_to_vcpu(d))
 		xive_do_source_eoi(irqd_to_hwirq(d), xd);
 
 	/*
@@ -689,9 +694,14 @@ static int xive_irq_set_affinity(struct irq_data *d,
 
 	old_target = xd->target;
 
-	rc = xive_ops->configure_irq(hw_irq,
-				     get_hard_smp_processor_id(target),
-				     xive_irq_priority, d->irq);
+	/*
+	 * Only configure the irq if it's not currently passed-through to
+	 * a KVM guest
+	 */
+	if (!irqd_is_forwarded_to_vcpu(d))
+		rc = xive_ops->configure_irq(hw_irq,
+					     get_hard_smp_processor_id(target),
+					     xive_irq_priority, d->irq);
 	if (rc < 0) {
 		pr_err("Error %d reconfiguring irq %d\n", rc, d->irq);
 		return rc;
@@ -771,6 +781,123 @@ static int xive_irq_retrigger(struct irq_data *d)
 	return 1;
 }
 
+static int xive_irq_set_vcpu_affinity(struct irq_data *d, void *state)
+{
+	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
+	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
+	int rc;
+	u8 pq;
+
+	/*
+	 * We only support this on interrupts that do not require
+	 * firmware calls for masking and unmasking
+	 */
+	if (xd->flags & XIVE_IRQ_FLAG_MASK_FW)
+		return -EIO;
+
+	/*
+	 * This is called by KVM with state non-NULL for enabling
+	 * pass-through or NULL for disabling it
+	 */
+	if (state) {
+		irqd_set_forwarded_to_vcpu(d);
+
+		/* Set it to PQ=10 state to prevent further sends */
+		pq = xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
+
+		/* No target ? nothing to do */
+		if (xd->target == XIVE_INVALID_TARGET) {
+			/*
+			 * An untargetted interrupt should have been
+			 * also masked at the source
+			 */
+			WARN_ON(pq & 2);
+
+			return 0;
+		}
+
+		/*
+		 * If P was set, adjust state to PQ=11 to indicate
+		 * that a resend is needed for the interrupt to reach
+		 * the guest. Also remember the value of P.
+		 *
+		 * This also tells us that it's in flight to a host queue
+		 * or has already been fetched but hasn't been EOIed yet
+		 * by the host. This it's potentially using up a host
+		 * queue slot. This is important to know because as long
+		 * as this is the case, we must not hard-unmask it when
+		 * "returning" that interrupt to the host.
+		 *
+		 * This saved_p is cleared by the host EOI, when we know
+		 * for sure the queue slot is no longer in use.
+		 */
+		if (pq & 2) {
+			pq = xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
+			xd->saved_p = true;
+
+			/*
+			 * Sync the XIVE source HW to ensure the interrupt
+			 * has gone through the EAS before we change its
+			 * target to the guest. That should guarantee us
+			 * that we *will* eventually get an EOI for it on
+			 * the host. Otherwise there would be a small window
+			 * for P to be seen here but the interrupt going
+			 * to the guest queue.
+			 */
+			if (xive_ops->sync_source)
+				xive_ops->sync_source(hw_irq);
+		} else
+			xd->saved_p = false;
+	} else {
+		irqd_clr_forwarded_to_vcpu(d);
+
+		/* No host target ? hard mask and return */
+		if (xd->target == XIVE_INVALID_TARGET) {
+			xive_do_source_set_mask(xd, true);
+			return 0;
+		}
+
+		/*
+		 * Sync the XIVE source HW to ensure the interrupt
+		 * has gone through the EAS before we change its
+		 * target to the host.
+		 */
+		if (xive_ops->sync_source)
+			xive_ops->sync_source(hw_irq);
+
+		/*
+		 * By convention we are called with the interrupt in
+		 * a PQ=10 or PQ=11 state, ie, it won't fire and will
+		 * have latched in Q whether there's a pending HW
+		 * interrupt or not.
+		 *
+		 * First reconfigure the target.
+		 */
+		rc = xive_ops->configure_irq(hw_irq,
+					     get_hard_smp_processor_id(xd->target),
+					     xive_irq_priority, d->irq);
+		if (rc)
+			return rc;
+
+		/*
+		 * Then if saved_p is not set, effectively re-enable the
+		 * interrupt with an EOI. If it is set, we know there is
+		 * still a message in a host queue somewhere that will be
+		 * EOId eventually.
+		 *
+		 * Note: We don't check irqd_irq_disabled(). Effectively,
+		 * we *will* let the irq get through even if masked if the
+		 * HW is still firing it in order to deal with the whole
+		 * saved_p business properly. If the interrupt triggers
+		 * while masked, the generic code will re-mask it anyway.
+		 */
+		if (!xd->saved_p)
+			xive_do_source_eoi(hw_irq, xd);
+
+	}
+	return 0;
+}
+
 static struct irq_chip xive_irq_chip = {
 	.name = "XIVE-IRQ",
 	.irq_startup = xive_irq_startup,
@@ -781,12 +908,14 @@ static struct irq_chip xive_irq_chip = {
 	.irq_set_affinity = xive_irq_set_affinity,
 	.irq_set_type = xive_irq_set_type,
 	.irq_retrigger = xive_irq_retrigger,
+	.irq_set_vcpu_affinity = xive_irq_set_vcpu_affinity,
 };
 
 bool is_xive_irq(struct irq_chip *chip)
 {
 	return chip == &xive_irq_chip;
 }
+EXPORT_SYMBOL_GPL(is_xive_irq);
 
 void xive_cleanup_irq_data(struct xive_irq_data *xd)
 {
@@ -801,6 +930,7 @@ void xive_cleanup_irq_data(struct xive_irq_data *xd)
 		xd->trig_mmio = NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(xive_cleanup_irq_data);
 
 static int xive_irq_alloc_data(unsigned int virq, irq_hw_number_t hw)
 {
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 5fae59186cb2..9d312c96a897 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -31,6 +31,7 @@
 #include <asm/xive.h>
 #include <asm/xive-regs.h>
 #include <asm/opal.h>
+#include <asm/kvm_ppc.h>
 
 #include "xive-internal.h"
 
@@ -95,6 +96,7 @@ int xive_native_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xive_native_populate_irq_data);
 
 int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
 {
@@ -108,6 +110,8 @@ int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
 	}
 	return rc == 0 ? 0 : -ENXIO;
 }
+EXPORT_SYMBOL_GPL(xive_native_configure_irq);
+
 
 /* This can be called multiple time to change a queue configuration */
 int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
@@ -172,6 +176,7 @@ int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
 fail:
 	return rc;
 }
+EXPORT_SYMBOL_GPL(xive_native_configure_queue);
 
 static void __xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio)
 {
@@ -191,6 +196,7 @@ void xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio)
 {
 	__xive_native_disable_queue(vp_id, q, prio);
 }
+EXPORT_SYMBOL_GPL(xive_native_disable_queue);
 
 static int xive_native_setup_queue(unsigned int cpu, struct xive_cpu *xc, u8 prio)
 {
@@ -276,6 +282,7 @@ u32 xive_native_alloc_irq(void)
 		return 0;
 	return rc;
 }
+EXPORT_SYMBOL_GPL(xive_native_alloc_irq);
 
 void xive_native_free_irq(u32 irq)
 {
@@ -286,6 +293,7 @@ void xive_native_free_irq(u32 irq)
 		msleep(1);
 	}
 }
+EXPORT_SYMBOL_GPL(xive_native_free_irq);
 
 static void xive_native_put_ipi(unsigned int cpu, struct xive_cpu *xc)
 {
@@ -382,7 +390,7 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
 		return;
 
 	/* Enable the pool VP */
-	vp = xive_pool_vps + get_hard_smp_processor_id(cpu);
+	vp = xive_pool_vps + cpu;
 	pr_debug("CPU %d setting up pool VP 0x%x\n", cpu, vp);
 	for (;;) {
 		rc = opal_xive_set_vp_info(vp, OPAL_XIVE_VP_ENABLED, 0);
@@ -427,7 +435,7 @@ static void xive_native_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
 	in_be64(xive_tima + TM_SPC_PULL_POOL_CTX);
 
 	/* Disable it */
-	vp = xive_pool_vps + get_hard_smp_processor_id(cpu);
+	vp = xive_pool_vps + cpu;
 	for (;;) {
 		rc = opal_xive_set_vp_info(vp, 0, 0);
 		if (rc != OPAL_BUSY)
@@ -436,10 +444,11 @@ static void xive_native_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
 	}
 }
 
-static void xive_native_sync_source(u32 hw_irq)
+void xive_native_sync_source(u32 hw_irq)
 {
 	opal_xive_sync(XIVE_SYNC_EAS, hw_irq);
 }
+EXPORT_SYMBOL_GPL(xive_native_sync_source);
 
 static const struct xive_ops xive_native_ops = {
 	.populate_irq_data	= xive_native_populate_irq_data,
@@ -500,10 +509,24 @@ static bool xive_parse_provisioning(struct device_node *np)
 	return true;
 }
 
+static void xive_native_setup_pools(void)
+{
+	/* Allocate a pool big enough */
+	pr_debug("XIVE: Allocating VP block for pool size %d\n", nr_cpu_ids);
+
+	xive_pool_vps = xive_native_alloc_vp_block(nr_cpu_ids);
+	if (WARN_ON(xive_pool_vps == XIVE_INVALID_VP))
+		pr_err("XIVE: Failed to allocate pool VP, KVM might not function\n");
+
+	pr_debug("XIVE: Pool VPs allocated at 0x%x for %d max CPUs\n",
+		 xive_pool_vps, nr_cpu_ids);
+}
+
 u32 xive_native_default_eq_shift(void)
 {
 	return xive_queue_shift;
 }
+EXPORT_SYMBOL_GPL(xive_native_default_eq_shift);
 
 bool xive_native_init(void)
 {
@@ -513,7 +536,7 @@ bool xive_native_init(void)
 	struct property *prop;
 	u8 max_prio = 7;
 	const __be32 *p;
-	u32 val;
+	u32 val, cpu;
 	s64 rc;
 
 	if (xive_cmdline_disabled)
@@ -549,7 +572,11 @@ bool xive_native_init(void)
 			break;
 	}
 
-	/* Grab size of provisioning pages */
+	/* Configure Thread Management areas for KVM */
+	for_each_possible_cpu(cpu)
+		kvmppc_set_xive_tima(cpu, r.start, tima);
+
+	/* Grab size of provisionning pages */
 	xive_parse_provisioning(np);
 
 	/* Switch the XIVE to exploitation mode */
@@ -559,6 +586,9 @@ bool xive_native_init(void)
 		return false;
 	}
 
+	/* Setup some dummy HV pool VPs */
+	xive_native_setup_pools();
+
 	/* Initialize XIVE core with our backend */
 	if (!xive_core_init(&xive_native_ops, tima, TM_QW3_HV_PHYS,
 			    max_prio)) {
@@ -637,3 +667,47 @@ void xive_native_free_vp_block(u32 vp_base)
 		pr_warn("OPAL error %lld freeing VP block\n", rc);
 }
 EXPORT_SYMBOL_GPL(xive_native_free_vp_block);
+
+int xive_native_enable_vp(u32 vp_id)
+{
+	s64 rc;
+
+	for (;;) {
+		rc = opal_xive_set_vp_info(vp_id, OPAL_XIVE_VP_ENABLED, 0);
+		if (rc != OPAL_BUSY)
+			break;
+		msleep(1);
+	}
+	return rc ? -EIO : 0;
+}
+EXPORT_SYMBOL_GPL(xive_native_enable_vp);
+
+int xive_native_disable_vp(u32 vp_id)
+{
+	s64 rc;
+
+	for (;;) {
+		rc = opal_xive_set_vp_info(vp_id, 0, 0);
+		if (rc != OPAL_BUSY)
+			break;
+		msleep(1);
+	}
+	return rc ? -EIO : 0;
+}
+EXPORT_SYMBOL_GPL(xive_native_disable_vp);
+
+int xive_native_get_vp_info(u32 vp_id, u32 *out_cam_id, u32 *out_chip_id)
+{
+	__be64 vp_cam_be;
+	__be32 vp_chip_id_be;
+	s64 rc;
+
+	rc = opal_xive_get_vp_info(vp_id, NULL, &vp_cam_be, NULL, &vp_chip_id_be);
+	if (rc)
+		return -EIO;
+	*out_cam_id = be64_to_cpu(vp_cam_be) & 0xffffffffu;
+	*out_chip_id = be32_to_cpu(vp_chip_id_be);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xive_native_get_vp_info);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2c14ad9809da..d1a6e554ee68 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1165,7 +1165,6 @@ int kvm_register_device_ops(struct kvm_device_ops *ops, u32 type);
 void kvm_unregister_device_ops(u32 type);
 
 extern struct kvm_device_ops kvm_mpic_ops;
-extern struct kvm_device_ops kvm_xics_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v3_ops;
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a17d78759727..1b0da5771f71 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2839,10 +2839,6 @@ static struct kvm_device_ops *kvm_device_ops_table[KVM_DEV_TYPE_MAX] = {
 	[KVM_DEV_TYPE_FSL_MPIC_20]	= &kvm_mpic_ops,
 	[KVM_DEV_TYPE_FSL_MPIC_42]	= &kvm_mpic_ops,
 #endif
-
-#ifdef CONFIG_KVM_XICS
-	[KVM_DEV_TYPE_XICS]		= &kvm_xics_ops,
-#endif
 };
 
 int kvm_register_device_ops(struct kvm_device_ops *ops, u32 type)
-- 
2.7.4
