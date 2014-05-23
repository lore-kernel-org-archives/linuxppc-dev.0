Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56CEA1A060D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 18:15:43 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH v2 2/6] powerpc/powernv: Make it possible to skip the
 IRQHAPPENED check in power7_nap()
Date: Fri, 23 May 2014 18:15:26 +1000
Message-Id: <1400832930-17050-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1400832930-17050-1-git-send-email-mikey@neuling.org>
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

To support split core we need to be able to force all secondaries into
nap, so the core can detect they are idle and do an unsplit.

Currently power7_nap() will return without napping if there is an irq
pending. We want to ignore the pending irq and nap anyway, we will deal
with the interrupt later.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/processor.h | 2 +-
 arch/powerpc/kernel/idle_power7.S    | 9 +++++++++
 arch/powerpc/platforms/powernv/smp.c | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index d660dc3..6d59072 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -449,7 +449,7 @@ extern unsigned long cpuidle_disable;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
-extern void power7_nap(void);
+extern void power7_nap(int check_irq);
 extern void power7_sleep(void);
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index dca6e16..2480256 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -39,6 +39,10 @@
  * Pass requested state in r3:
  * 	0 - nap
  * 	1 - sleep
+ *
+ * To check IRQ_HAPPENED in r4
+ * 	0 - don't check
+ * 	1 - check
  */
 _GLOBAL(power7_powersave_common)
 	/* Use r3 to pass state nap/sleep/winkle */
@@ -71,6 +75,8 @@ _GLOBAL(power7_powersave_common)
 	lbz	r0,PACAIRQHAPPENED(r13)
 	cmpwi	cr0,r0,0
 	beq	1f
+	cmpwi	cr0,r4,0
+	beq	1f
 	addi	r1,r1,INT_FRAME_SIZE
 	ld	r0,16(r1)
 	mtlr	r0
@@ -114,15 +120,18 @@ _GLOBAL(power7_idle)
 	lwz	r4,ADDROFF(powersave_nap)(r3)
 	cmpwi	0,r4,0
 	beqlr
+	li	r3, 1
 	/* fall through */
 
 _GLOBAL(power7_nap)
+	mr	r4,r3
 	li	r3,0
 	b	power7_powersave_common
 	/* No return */
 
 _GLOBAL(power7_sleep)
 	li	r3,1
+	li	r4,0
 	b	power7_powersave_common
 	/* No return */
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 1601a1e..65faf99 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -159,7 +159,7 @@ static void pnv_smp_cpu_kill_self(void)
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
 	while (!generic_check_cpu_restart(cpu)) {
 		ppc64_runlatch_off();
-		power7_nap();
+		power7_nap(1);
 		ppc64_runlatch_on();
 		if (!generic_check_cpu_restart(cpu)) {
 			DBG("CPU%d Unexpected exit while offline !\n", cpu);
-- 
1.9.1
