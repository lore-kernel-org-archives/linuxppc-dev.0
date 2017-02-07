Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHQNq3kZszDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 11:35:39 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vHQNp3hTLz9s2P
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2017 11:35:38 +1100 (AEDT)
Message-ID: <1486427731.4850.102.camel@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/powernv: Fix CPU hotplug to handle waking on HVI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Paul Mackerras <pmac@au1.ibm.com>
Date: Tue, 07 Feb 2017 11:35:31 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IPIs come in as HVI not EE, so we need to test the appropriate
SRR1 bits. The encoding is such that it won't have false positives
on P7 and P8 so we can just test it like that. We also need to handle
the icp-opal variant of the flush.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/reg.h       |  3 ++-
 arch/powerpc/include/asm/xics.h      |  1 +
 arch/powerpc/platforms/powernv/smp.c | 12 ++++++++++--
 arch/powerpc/sysdev/xics/icp-opal.c  | 29 +++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index aa44a83..763ae4f 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -653,9 +653,10 @@
 #define   SRR1_ISI_N_OR_G	0x10000000 /* ISI: Access is no-exec or G */
 #define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
 #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
-#define   SRR1_WAKEMASK_P8	0x003c0000 /* reason for wakeup on POWER8 */
+#define   SRR1_WAKEMASK_P8	0x003c0000 /* reason for wakeup on POWER8 and 9 */
 #define   SRR1_WAKESYSERR	0x00300000 /* System error */
 #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
+#define   SRR1_WAKEHVI		0x00240000 /* Hypervisor Virtualization Interrupt (P9) */
 #define   SRR1_WAKEMT		0x00280000 /* mtctrl */
 #define	  SRR1_WAKEHMI		0x00280000 /* Hypervisor maintenance */
 #define   SRR1_WAKEDEC		0x00180000 /* Decrementer interrupt */
diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index f0b2385..e0b9e57 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -44,6 +44,7 @@ static inline int icp_hv_init(void) { return -ENODEV; }
 
 #ifdef CONFIG_PPC_POWERNV
 extern int icp_opal_init(void);
+extern void icp_opal_flush_interrupt(void);
 #else
 static inline int icp_opal_init(void) { return -ENODEV; }
 #endif
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c789258..eec0e8d 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -155,8 +155,10 @@ static void pnv_smp_cpu_kill_self(void)
 		wmask = SRR1_WAKEMASK_P8;
 
 	idle_states = pnv_get_supported_cpuidle_states();
+
 	/* We don't want to take decrementer interrupts while we are offline,
-	 * so clear LPCR:PECE1. We keep PECE2 enabled.
+	 * so clear LPCR:PECE1. We keep PECE2 (and LPCR_PECE_HVEE on P9)
+	 * enabled as to let IPIs in.
 	 */
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
 
@@ -206,8 +208,12 @@ static void pnv_smp_cpu_kill_self(void)
 		 * contains 0.
 		 */
 		if (((srr1 & wmask) == SRR1_WAKEEE) ||
+		    ((srr1 & wmask) == SRR1_WAKEHVI) ||
 		    (local_paca->irq_happened & PACA_IRQ_EE)) {
-			icp_native_flush_interrupt();
+			if (cpu_has_feature(CPU_FTR_ARCH_300))
+				icp_opal_flush_interrupt();
+			else
+				icp_native_flush_interrupt();
 		} else if ((srr1 & wmask) == SRR1_WAKEHDBELL) {
 			unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
 			asm volatile(PPC_MSGCLR(%0) : : "r" (msg));
@@ -221,6 +227,8 @@ static void pnv_smp_cpu_kill_self(void)
 		if (srr1 && !generic_check_cpu_restart(cpu))
 			DBG("CPU%d Unexpected exit while offline !\n", cpu);
 	}
+
+	/* Re-enable decrementer interrupts */
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_PECE1);
 	DBG("CPU%d coming online...\n", cpu);
 }
diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index 60c5765..c96c0cb 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -132,6 +132,35 @@ static irqreturn_t icp_opal_ipi_action(int irq, void *dev_id)
 	return smp_ipi_demux();
 }
 
+/*
+ * Called when an interrupt is received on an off-line CPU to
+ * clear the interrupt, so that the CPU can go back to nap mode.
+ */
+void icp_opal_flush_interrupt(void)
+{
+	unsigned int xirr;
+	unsigned int vec;
+
+	do {
+		xirr = icp_opal_get_xirr();
+		vec = xirr & 0x00ffffff;
+		if (vec == XICS_IRQ_SPURIOUS)
+			break;
+		if (vec == XICS_IPI) {
+			/* Clear pending IPI */
+			int cpu = smp_processor_id();
+			kvmppc_set_host_ipi(cpu, 0);
+			opal_int_set_mfrr(get_hard_smp_processor_id(cpu), 0xff);
+		} else {
+			pr_err("XICS: hw interrupt 0x%x to offline cpu, "
+			       "disabling\n", vec);
+			xics_mask_unknown_vec(vec);
+		}
+
+		/* EOI the interrupt */
+	} while (opal_int_eoi(xirr) > 0);
+}
+
 #endif /* CONFIG_SMP */
 
 static const struct icp_ops icp_opal_ops = {
