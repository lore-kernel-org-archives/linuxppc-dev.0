Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBx6Hd3zDr8p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:09 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 11/13] KVM: PPC: Book3S HV: Update irq stats for IRQs handled
 in real mode
Date: Fri, 19 Aug 2016 15:35:55 +1000
Message-Id: <1471584957-21484-12-git-send-email-paulus@ozlabs.org>
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

When a passthrough IRQ is handled completely within KVM real
mode code, it has to also update the IRQ stats since this
does not go through the generic IRQ handling code.

However, the per CPU kstat_irqs field is an allocated (not static)
field and so cannot be directly accessed in real mode safely.

The function this_cpu_inc_rm() is introduced to safely increment
per CPU fields (currently coded for unsigned integers only) that
are allocated and could thus be vmalloced also.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 00b9dfde..554cdfa 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/kvm_host.h>
 #include <linux/err.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/kvm_book3s.h>
 #include <asm/kvm_ppc.h>
@@ -18,6 +19,7 @@
 #include <asm/debug.h>
 #include <asm/synch.h>
 #include <asm/cputhreads.h>
+#include <asm/pgtable.h>
 #include <asm/ppc-opcode.h>
 #include <asm/pnv-pci.h>
 
@@ -734,6 +736,53 @@ static void icp_eoi(struct irq_chip *c, u32 hwirq, u32 xirr)
 	_stwcix(xics_phys + XICS_XIRR, xirr);
 }
 
+/*
+ * Increment a per-CPU 32-bit unsigned integer variable.
+ * Safe to call in real-mode. Handles vmalloc'ed addresses
+ *
+ * ToDo: Make this work for any integral type
+ */
+
+static inline void this_cpu_inc_rm(unsigned int __percpu *addr)
+{
+	unsigned long l;
+	unsigned int *raddr;
+	int cpu = smp_processor_id();
+
+	raddr = per_cpu_ptr(addr, cpu);
+	l = (unsigned long)raddr;
+
+	if (REGION_ID(l) == VMALLOC_REGION_ID) {
+		l = vmalloc_to_phys(raddr);
+		raddr = (unsigned int *)l;
+	}
+	++*raddr;
+}
+
+/*
+ * We don't try to update the flags in the irq_desc 'istate' field in
+ * here as would happen in the normal IRQ handling path for several reasons:
+ *  - state flags represent internal IRQ state and are not expected to be
+ *    updated outside the IRQ subsystem
+ *  - more importantly, these are useful for edge triggered interrupts,
+ *    IRQ probing, etc., but we are only handling MSI/MSIx interrupts here
+ *    and these states shouldn't apply to us.
+ *
+ * However, we do update irq_stats - we somewhat duplicate the code in
+ * kstat_incr_irqs_this_cpu() for this since this function is defined
+ * in irq/internal.h which we don't want to include here.
+ * The only difference is that desc->kstat_irqs is an allocated per CPU
+ * variable and could have been vmalloc'ed, so we can't directly
+ * call __this_cpu_inc() on it. The kstat structure is a static
+ * per CPU variable and it should be accessible by real-mode KVM.
+ *
+ */
+static void kvmppc_rm_handle_irq_desc(struct irq_desc *desc)
+{
+	this_cpu_inc_rm(desc->kstat_irqs);
+	__this_cpu_inc(kstat.irqs_sum);
+}
+
 long kvmppc_deliver_irq_passthru(struct kvm_vcpu *vcpu,
 				 u32 xirr,
 				 struct kvmppc_irq_map *irq_map,
@@ -747,6 +796,7 @@ long kvmppc_deliver_irq_passthru(struct kvm_vcpu *vcpu,
 	xics = vcpu->kvm->arch.xics;
 	icp = vcpu->arch.icp;
 
+	kvmppc_rm_handle_irq_desc(irq_map->desc);
 	icp_rm_deliver_irq(xics, icp, irq);
 
 	/* EOI the interrupt */
-- 
2.8.1
