Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63BA01A018B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 17:03:53 +1100 (AEDT)
Date: Thu, 19 Mar 2015 17:03:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: Fixes for hypervisor doorbell handling
Message-ID: <20150319060349.GA24870@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since we can now use hypervisor doorbells for host IPIs, this makes
sure we clear the host IPI flag when taking a doorbell interrupt, and
clears any pending doorbell IPI in pnv_smp_cpu_kill_self() (as we
already do for IPIs sent via the XICS interrupt controller).  Otherwise
if there did happen to be a leftover pending doorbell interrupt for
an offline CPU thread for any reason, it would prevent that thread from
going into a power-saving mode; it would instead keep waking up because
of the interrupt.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/reg.h       |  3 +++
 arch/powerpc/kernel/dbell.c          |  2 ++
 arch/powerpc/platforms/powernv/smp.c | 13 +++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1c874fb..af56b5c 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -608,13 +608,16 @@
 #define   SRR1_ISI_N_OR_G	0x10000000 /* ISI: Access is no-exec or G */
 #define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
 #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
+#define   SRR1_WAKEMASK_P8	0x003c0000 /* reason for wakeup on POWER8 */
 #define   SRR1_WAKESYSERR	0x00300000 /* System error */
 #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
 #define   SRR1_WAKEMT		0x00280000 /* mtctrl */
 #define	  SRR1_WAKEHMI		0x00280000 /* Hypervisor maintenance */
 #define   SRR1_WAKEDEC		0x00180000 /* Decrementer interrupt */
+#define   SRR1_WAKEDBELL	0x00140000 /* Privileged doorbell on P8 */
 #define   SRR1_WAKETHERM	0x00100000 /* Thermal management interrupt */
 #define	  SRR1_WAKERESET	0x00100000 /* System reset */
+#define   SRR1_WAKEHDBELL	0x000c0000 /* Hypervisor doorbell on P8 */
 #define	  SRR1_WAKESTATE	0x00030000 /* Powersave exit mask [46:47] */
 #define	  SRR1_WS_DEEPEST	0x00030000 /* Some resources not maintained,
 					  * may not be recoverable */
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index f421781..2128f3a 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -17,6 +17,7 @@
 
 #include <asm/dbell.h>
 #include <asm/irq_regs.h>
+#include <asm/kvm_ppc.h>
 
 #ifdef CONFIG_SMP
 void doorbell_setup_this_cpu(void)
@@ -41,6 +42,7 @@ void doorbell_exception(struct pt_regs *regs)
 
 	may_hard_irq_enable();
 
+	kvmppc_set_host_ipi(smp_processor_id(), 0);
 	__this_cpu_inc(irq_stat.doorbell_irqs);
 
 	smp_ipi_demux();
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index fc34025..7259a24 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -33,6 +33,7 @@
 #include <asm/runlatch.h>
 #include <asm/code-patching.h>
 #include <asm/dbell.h>
+#include <asm/kvm_ppc.h>
 
 #include "powernv.h"
 
@@ -149,7 +150,7 @@ static int pnv_smp_cpu_disable(void)
 static void pnv_smp_cpu_kill_self(void)
 {
 	unsigned int cpu;
-	unsigned long srr1;
+	unsigned long srr1, wmask;
 	u32 idle_states;
 
 	/* Standard hot unplug procedure */
@@ -161,6 +162,10 @@ static void pnv_smp_cpu_kill_self(void)
 	generic_set_cpu_dead(cpu);
 	smp_wmb();
 
+	wmask = SRR1_WAKEMASK;
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		wmask = SRR1_WAKEMASK_P8;
+
 	idle_states = pnv_get_supported_cpuidle_states();
 	/* We don't want to take decrementer interrupts while we are offline,
 	 * so clear LPCR:PECE1. We keep PECE2 enabled.
@@ -191,10 +196,14 @@ static void pnv_smp_cpu_kill_self(void)
 		 * having finished executing in a KVM guest, then srr1
 		 * contains 0.
 		 */
-		if ((srr1 & SRR1_WAKEMASK) == SRR1_WAKEEE) {
+		if ((srr1 & wmask) == SRR1_WAKEEE) {
 			icp_native_flush_interrupt();
 			local_paca->irq_happened &= PACA_IRQ_HARD_DIS;
 			smp_mb();
+		} else if ((srr1 & wmask) == SRR1_WAKEHDBELL) {
+			unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
+			asm volatile(PPC_MSGCLR(%0) : : "r" (msg));
+			kvmppc_set_host_ipi(cpu, 0);
 		}
 
 		if (cpu_core_split_required())
-- 
2.1.4
