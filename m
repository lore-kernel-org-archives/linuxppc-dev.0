Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKqP26mN8zDvt1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:28:54 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 11/13] KVM: PPC: Book3S HV: Use OPAL XICS emulation on POWER9
Date: Fri, 18 Nov 2016 18:28:40 +1100
Message-Id: <1479454122-26994-12-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 includes a new interrupt controller, called XIVE, which is
quite different from the XICS interrupt controller on POWER7 and
POWER8 machines.  KVM-HV accesses the XICS directly in several places
in order to send and clear IPIs and handle interrupts from PCI
devices being passed through to the guest.

In order to make the transition to XIVE easier, OPAL firmware will
include an emulation of XICS on top of XIVE.  Access to the emulated
XICS is via OPAL calls.  The one complication is that the EOI
(end-of-interrupt) function can now return a value indicating that
another interrupt is pending; in this case, the XIVE will not signal
an interrupt in hardware to the CPU, and software is supposed to
acknowledge the new interrupt without waiting for another interrupt
to be delivered in hardware.

This adapts KVM-HV to use the OPAL calls on machines where there is
no XICS hardware.  When there is no XICS, we look for a device-tree
node with "ibm,opal-intc" in its compatible property, which is how
OPAL indicates that it provides XICS emulation.

In order to handle the EOI return value, kvmppc_read_intr() has
become kvmppc_read_one_intr(), with a boolean variable passed by
reference which can be set by the EOI functions to indicate that
another interrupt is pending.  The new kvmppc_read_intr() keeps
calling kvmppc_read_one_intr() until there are no more interrupts
to process.  The return value from kvmppc_read_intr() is the
largest non-zero value of the returns from kvmppc_read_one_intr().

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_ppc.h   |  7 +++--
 arch/powerpc/kvm/book3s_hv.c         | 28 +++++++++++++++--
 arch/powerpc/kvm/book3s_hv_builtin.c | 59 ++++++++++++++++++++++++++++++------
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 23 ++++++++++----
 4 files changed, 96 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index f6e4964..a5b94be 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -483,9 +483,10 @@ extern void kvmppc_xics_set_mapped(struct kvm *kvm, unsigned long guest_irq,
 				   unsigned long host_irq);
 extern void kvmppc_xics_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
 				   unsigned long host_irq);
-extern long kvmppc_deliver_irq_passthru(struct kvm_vcpu *vcpu, u32 xirr,
-				 struct kvmppc_irq_map *irq_map,
-				 struct kvmppc_passthru_irqmap *pimap);
+extern long kvmppc_deliver_irq_passthru(struct kvm_vcpu *vcpu, __be32 xirr,
+					struct kvmppc_irq_map *irq_map,
+					struct kvmppc_passthru_irqmap *pimap,
+					bool *again);
 extern int h_ipi_redirect;
 #else
 static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ace89df..a1d2b5f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -55,6 +55,8 @@
 #include <asm/hmi.h>
 #include <asm/pnv-pci.h>
 #include <asm/mmu.h>
+#include <asm/opal.h>
+#include <asm/xics.h>
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
@@ -63,6 +65,7 @@
 #include <linux/irqbypass.h>
 #include <linux/module.h>
 #include <linux/compiler.h>
+#include <linux/of.h>
 
 #include "book3s.h"
 
@@ -172,8 +175,12 @@ static bool kvmppc_ipi_thread(int cpu)
 	}
 
 #if defined(CONFIG_PPC_ICP_NATIVE) && defined(CONFIG_SMP)
-	if (cpu >= 0 && cpu < nr_cpu_ids && paca[cpu].kvm_hstate.xics_phys) {
-		xics_wake_cpu(cpu);
+	if (cpu >= 0 && cpu < nr_cpu_ids) {
+		if (paca[cpu].kvm_hstate.xics_phys) {
+			xics_wake_cpu(cpu);
+			return true;
+		}
+		opal_int_set_mfrr(get_hard_smp_processor_id(cpu), IPI_PRIORITY);
 		return true;
 	}
 #endif
@@ -3729,6 +3736,23 @@ static int kvmppc_book3s_init_hv(void)
 	if (r)
 		return r;
 
+	/*
+	 * We need a way of accessing the XICS interrupt controller,
+	 * either directly, via paca[cpu].kvm_hstate.xics_phys, or
+	 * indirectly, via OPAL.
+	 */
+#ifdef CONFIG_SMP
+	if (!get_paca()->kvm_hstate.xics_phys) {
+		struct device_node *np;
+
+		np = of_find_compatible_node(NULL, NULL, "ibm,opal-intc");
+		if (!np) {
+			pr_err("KVM-HV: Cannot determine method for accessing XICS\n");
+			return -ENODEV;
+		}
+	}
+#endif
+
 	kvm_ops_hv.owner = THIS_MODULE;
 	kvmppc_hv_ops = &kvm_ops_hv;
 
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 37ed045..a09c917 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -26,6 +26,7 @@
 #include <asm/dbell.h>
 #include <asm/cputhreads.h>
 #include <asm/io.h>
+#include <asm/opal.h>
 
 #define KVM_CMA_CHUNK_ORDER	18
 
@@ -224,7 +225,11 @@ void kvmhv_rm_send_ipi(int cpu)
 
 	/* Else poke the target with an IPI */
 	xics_phys = paca[cpu].kvm_hstate.xics_phys;
-	rm_writeb(xics_phys + XICS_MFRR, IPI_PRIORITY);
+	if (xics_phys)
+		rm_writeb(xics_phys + XICS_MFRR, IPI_PRIORITY);
+	else
+		opal_rm_int_set_mfrr(get_hard_smp_processor_id(cpu),
+				     IPI_PRIORITY);
 }
 
 /*
@@ -335,7 +340,7 @@ static struct kvmppc_irq_map *get_irqmap(struct kvmppc_passthru_irqmap *pimap,
  * saved a copy of the XIRR in the PACA, it will be picked up by
  * the host ICP driver.
  */
-static int kvmppc_check_passthru(u32 xisr, __be32 xirr)
+static int kvmppc_check_passthru(u32 xisr, __be32 xirr, bool *again)
 {
 	struct kvmppc_passthru_irqmap *pimap;
 	struct kvmppc_irq_map *irq_map;
@@ -354,7 +359,7 @@ static int kvmppc_check_passthru(u32 xisr, __be32 xirr)
 	/* We're handling this interrupt, generic code doesn't need to */
 	local_paca->kvm_hstate.saved_xirr = 0;
 
-	return kvmppc_deliver_irq_passthru(vcpu, xirr, irq_map, pimap);
+	return kvmppc_deliver_irq_passthru(vcpu, xirr, irq_map, pimap, again);
 }
 
 #else
@@ -373,14 +378,31 @@ static inline int kvmppc_check_passthru(u32 xisr, __be32 xirr)
  *	-1 if there was a guest wakeup IPI (which has now been cleared)
  *	-2 if there is PCI passthrough external interrupt that was handled
  */
+static long kvmppc_read_one_intr(bool *again);
 
 long kvmppc_read_intr(void)
 {
+	long ret = 0;
+	long rc;
+	bool again;
+
+	do {
+		again = false;
+		rc = kvmppc_read_one_intr(&again);
+		if (rc && (ret == 0 || rc > ret))
+			ret = rc;
+	} while (again);
+	return ret;
+}
+
+static long kvmppc_read_one_intr(bool *again)
+{
 	unsigned long xics_phys;
 	u32 h_xirr;
 	__be32 xirr;
 	u32 xisr;
 	u8 host_ipi;
+	int64_t rc;
 
 	/* see if a host IPI is pending */
 	host_ipi = local_paca->kvm_hstate.host_ipi;
@@ -389,8 +411,14 @@ long kvmppc_read_intr(void)
 
 	/* Now read the interrupt from the ICP */
 	xics_phys = local_paca->kvm_hstate.xics_phys;
-	if (unlikely(!xics_phys))
-		return 1;
+	if (!xics_phys) {
+		/* Use OPAL to read the XIRR */
+		rc = opal_rm_int_get_xirr(&xirr, false);
+		if (rc < 0)
+			return 1;
+	} else {
+		xirr = _lwzcix(xics_phys + XICS_XIRR);
+	}
 
 	/*
 	 * Save XIRR for later. Since we get control in reverse endian
@@ -398,7 +426,6 @@ long kvmppc_read_intr(void)
 	 * host endian. Note that xirr is the value read from the
 	 * XIRR register, while h_xirr is the host endian version.
 	 */
-	xirr = _lwzcix(xics_phys + XICS_XIRR);
 	h_xirr = be32_to_cpu(xirr);
 	local_paca->kvm_hstate.saved_xirr = h_xirr;
 	xisr = h_xirr & 0xffffff;
@@ -417,8 +444,16 @@ long kvmppc_read_intr(void)
 	 * If it is an IPI, clear the MFRR and EOI it.
 	 */
 	if (xisr == XICS_IPI) {
-		_stbcix(xics_phys + XICS_MFRR, 0xff);
-		_stwcix(xics_phys + XICS_XIRR, xirr);
+		if (xics_phys) {
+			_stbcix(xics_phys + XICS_MFRR, 0xff);
+			_stwcix(xics_phys + XICS_XIRR, xirr);
+		} else {
+			opal_rm_int_set_mfrr(hard_smp_processor_id(), 0xff);
+			rc = opal_rm_int_eoi(h_xirr);
+			/* If rc > 0, there is another interrupt pending */
+			*again = rc > 0;
+		}
+
 		/*
 		 * Need to ensure side effects of above stores
 		 * complete before proceeding.
@@ -435,7 +470,11 @@ long kvmppc_read_intr(void)
 			/* We raced with the host,
 			 * we need to resend that IPI, bummer
 			 */
-			_stbcix(xics_phys + XICS_MFRR, IPI_PRIORITY);
+			if (xics_phys)
+				_stbcix(xics_phys + XICS_MFRR, IPI_PRIORITY);
+			else
+				opal_rm_int_set_mfrr(hard_smp_processor_id(),
+						     IPI_PRIORITY);
 			/* Let side effects complete */
 			smp_mb();
 			return 1;
@@ -446,5 +485,5 @@ long kvmppc_read_intr(void)
 		return -1;
 	}
 
-	return kvmppc_check_passthru(xisr, xirr);
+	return kvmppc_check_passthru(xisr, xirr, again);
 }
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index a0ea63a..06edc43 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -70,7 +70,11 @@ static inline void icp_send_hcore_msg(int hcore, struct kvm_vcpu *vcpu)
 	hcpu = hcore << threads_shift;
 	kvmppc_host_rm_ops_hv->rm_core[hcore].rm_data = vcpu;
 	smp_muxed_ipi_set_message(hcpu, PPC_MSG_RM_HOST_ACTION);
-	icp_native_cause_ipi_rm(hcpu);
+	if (paca[hcpu].kvm_hstate.xics_phys)
+		icp_native_cause_ipi_rm(hcpu);
+	else
+		opal_rm_int_set_mfrr(get_hard_smp_processor_id(hcpu),
+				     IPI_PRIORITY);
 }
 #else
 static inline void icp_send_hcore_msg(int hcore, struct kvm_vcpu *vcpu) { }
@@ -737,7 +741,7 @@ int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 
 unsigned long eoi_rc;
 
-static void icp_eoi(struct irq_chip *c, u32 hwirq, u32 xirr)
+static void icp_eoi(struct irq_chip *c, u32 hwirq, __be32 xirr, bool *again)
 {
 	unsigned long xics_phys;
 	int64_t rc;
@@ -751,7 +755,12 @@ static void icp_eoi(struct irq_chip *c, u32 hwirq, u32 xirr)
 
 	/* EOI it */
 	xics_phys = local_paca->kvm_hstate.xics_phys;
-	_stwcix(xics_phys + XICS_XIRR, xirr);
+	if (xics_phys) {
+		_stwcix(xics_phys + XICS_XIRR, xirr);
+	} else {
+		rc = opal_rm_int_eoi(be32_to_cpu(xirr));
+		*again = rc > 0;
+	}
 }
 
 static int xics_opal_rm_set_server(unsigned int hw_irq, int server_cpu)
@@ -809,9 +818,10 @@ static void kvmppc_rm_handle_irq_desc(struct irq_desc *desc)
 }
 
 long kvmppc_deliver_irq_passthru(struct kvm_vcpu *vcpu,
-				 u32 xirr,
+				 __be32 xirr,
 				 struct kvmppc_irq_map *irq_map,
-				 struct kvmppc_passthru_irqmap *pimap)
+				 struct kvmppc_passthru_irqmap *pimap,
+				 bool *again)
 {
 	struct kvmppc_xics *xics;
 	struct kvmppc_icp *icp;
@@ -825,7 +835,8 @@ long kvmppc_deliver_irq_passthru(struct kvm_vcpu *vcpu,
 	icp_rm_deliver_irq(xics, icp, irq);
 
 	/* EOI the interrupt */
-	icp_eoi(irq_desc_get_chip(irq_map->desc), irq_map->r_hwirq, xirr);
+	icp_eoi(irq_desc_get_chip(irq_map->desc), irq_map->r_hwirq, xirr,
+		again);
 
 	if (check_too_hard(xics, icp) == H_TOO_HARD)
 		return 2;
-- 
2.7.4
