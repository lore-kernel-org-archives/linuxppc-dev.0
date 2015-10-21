Return-Path: <paulus@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0D6C1A03C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 16:07:32 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A105F140549
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:07:32 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulus@au1.ibm.com>;
 Wed, 21 Oct 2015 15:07:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 327662BB003F
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:07:28 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9L577TB30736480
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:07:15 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9L56tJE024470
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:06:55 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t9L56tPZ023827
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:06:55 +1100
Date: Wed, 21 Oct 2015 16:06:24 +1100
From: Paul Mackerras <paulus@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/powernv: Handle irq_happened flag correctly in
 off-line loop
Message-ID: <20151021050624.GB17764@fergus.ozlabs.ibm.com>
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

This fixes a bug where it is possible for an off-line CPU to fail to
go into a low-power state (nap/sleep/winkle), and to become unresponsive
to requests from the KVM subsystem to wake up and run a VCPU.  What
can happen is that a maskable interrupt of some kind (external,
decrementer, hypervisor doorbell, or HMI) after we have called
local_irq_disable() at the beginning of pnv_smp_cpu_kill_self() and
before interrupts are hard-disabled inside power7_nap/sleep/winkle().
In this situation, the pending event is marked in the irq_happened
flag in the PACA.  This pending event prevents power7_nap/sleep/winkle
from going to the requested low-power state; instead they return
immediately.  We don't deal with any of these pending event flags
in the off-line loop in pnv_smp_cpu_kill_self() because power7_nap
et al. return 0 in this case, so we will have srr1 == 0, and none of
the processing to clear interrupts or doorbells will be done.

Usually, the most obvious symptom of this is that a KVM guest will fail
with a console message saying "KVM: couldn't grab cpu N".

This fixes the problem by making sure we handle the irq_happened flags
properly.  First, we hard-disable before the off-line loop.  Once we
have hard-disabled, the irq_happened flags can't change underneath us.
We unconditionally clear the DEC and HMI flags: there is no processing
of timer interrupts while off-line, and the necessary HMI processing is
all done in lower-level code.  We leave the EE and DBELL flags alone for
the first iteration of the loop, so that we won't fail to respond to a
split-core request that came in just before hard-disabling.  Within the
loop, we handle external interrupts if the EE bit is set in irq_happened
as well as if the low-power state was interrupted by an external
interrupt.  (We don't need to do the msgclr for a pending doorbell in
irq_happened, because doorbells are edge-triggered and don't remain
pending in hardware.)  Then we clear both the EE and DBELL flags, and
once clear, they cannot be set again (until this CPU comes online again,
that is).

This also fixes the debug check to not be done when we just ran a KVM
guest or when the sleep didn't happen because of a pending event in
irq_happened.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/platforms/powernv/smp.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 8f70ba6..ca26483 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -171,7 +171,26 @@ static void pnv_smp_cpu_kill_self(void)
 	 * so clear LPCR:PECE1. We keep PECE2 enabled.
 	 */
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
+
+	/*
+	 * Hard-disable interrupts, and then clear irq_happened flags
+	 * that we can safely ignore while off-line, since they
+	 * are for things for which we do no processing when off-line
+	 * (or in the case of HMI, all the processing we need to do
+	 * is done in lower-level real-mode code).
+	 */
+	hard_irq_disable();
+	local_paca->irq_happened &= ~(PACA_IRQ_DEC | PACA_IRQ_HMI);
+
 	while (!generic_check_cpu_restart(cpu)) {
+		/*
+		 * Clear IPI flag, since we don't handle IPIs while
+		 * offline, except for those when changing micro-threading
+		 * mode, which are handled explicitly below, and those
+		 * for coming online, which are handled via
+		 * generic_check_cpu_restart() calls.
+		 */
+		kvmppc_set_host_ipi(cpu, 0);
 
 		ppc64_runlatch_off();
 
@@ -196,20 +215,20 @@ static void pnv_smp_cpu_kill_self(void)
 		 * having finished executing in a KVM guest, then srr1
 		 * contains 0.
 		 */
-		if ((srr1 & wmask) == SRR1_WAKEEE) {
+		if (((srr1 & wmask) == SRR1_WAKEEE) ||
+		    (local_paca->irq_happened & PACA_IRQ_EE)) {
 			icp_native_flush_interrupt();
-			local_paca->irq_happened &= PACA_IRQ_HARD_DIS;
-			smp_mb();
 		} else if ((srr1 & wmask) == SRR1_WAKEHDBELL) {
 			unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
 			asm volatile(PPC_MSGCLR(%0) : : "r" (msg));
-			kvmppc_set_host_ipi(cpu, 0);
 		}
+		local_paca->irq_happened &= ~(PACA_IRQ_EE | PACA_IRQ_DBELL);
+		smp_mb();
 
 		if (cpu_core_split_required())
 			continue;
 
-		if (!generic_check_cpu_restart(cpu))
+		if (srr1 && !generic_check_cpu_restart(cpu))
 			DBG("CPU%d Unexpected exit while offline !\n", cpu);
 	}
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_PECE1);
-- 
2.1.4
