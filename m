Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE871B71DE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:42 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286Xr1Y024950
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:33:53 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bdqp2343026
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bdqq005180
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/18] powerpc/pmac/smp: Properly NAP offlined CPU on G5
Date: Tue,  8 Mar 2011 17:37:23 +1100
Message-Id: <1299566250-10516-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current code soft-disables, and then goes to NAP mode which
turns interrupts on. That means that if an interrupt occurs, we
will hit the masked interrupt code path which isn't what we want,
as it will return with EE off, which will either get us out of
NAP mode, or fail to enter it (according to spec).

Instead, let's just rely on the fact that it is safe to take
decrementer interrupts on an offline CPU and leave interrupts
enabled. We can also get rid of the special case in asm for
power4_cpu_offline_powersave() and just use power4_idle().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/machdep.h    |    1 -
 arch/powerpc/kernel/head_64.S         |    7 +++++++
 arch/powerpc/kernel/idle_power4.S     |   21 ---------------------
 arch/powerpc/platforms/powermac/smp.c |   14 ++++++++------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index bcfc0da..578d330 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -266,7 +266,6 @@ struct machdep_calls {
 
 extern void e500_idle(void);
 extern void power4_idle(void);
-extern void power4_cpu_offline_powersave(void);
 extern void ppc6xx_idle(void);
 extern void book3e_idle(void);
 
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 782f23d..271140b 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -536,6 +536,13 @@ _GLOBAL(pmac_secondary_start)
 	add	r13,r13,r4		/* for this processor.		*/
 	mtspr	SPRN_SPRG_PACA,r13	/* Save vaddr of paca in an SPRG*/
 
+	/* Mark interrupts soft and hard disabled (they might be enabled
+	 * in the PACA when doing hotplug)
+	 */
+	li	r0,0
+	stb	r0,PACASOFTIRQEN(r13)
+	stb	r0,PACAHARDIRQEN(r13)
+
 	/* Create a temp kernel stack for use before relocation is on.	*/
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index 5328709..ba31954 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -53,24 +53,3 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	isync
 	b	1b
 
-_GLOBAL(power4_cpu_offline_powersave)
-	/* Go to NAP now */
-	mfmsr	r7
-	rldicl	r0,r7,48,1
-	rotldi	r0,r0,16
-	mtmsrd	r0,1			/* hard-disable interrupts */
-	li	r0,1
-	li	r6,0
-	stb	r0,PACAHARDIRQEN(r13)	/* we'll hard-enable shortly */
-	stb	r6,PACASOFTIRQEN(r13)	/* soft-disable irqs */
-BEGIN_FTR_SECTION
-	DSSALL
-	sync
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	ori	r7,r7,MSR_EE
-	oris	r7,r7,MSR_POW@h
-	sync
-	isync
-	mtmsrd	r7
-	isync
-	blr
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 53bee66..837989e 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -916,18 +916,20 @@ static void pmac_cpu_die(void)
 	preempt_enable();
 
 	/*
-	 * hard-disable interrupts for the non-NAP case, the NAP code
-	 * needs to re-enable interrupts (but soft-disables them)
+	 * Re-enable interrupts. The NAP code needs to enable them
+	 * anyways, do it now so we deal with the case where one already
+	 * happened while soft-disabled.
+	 * We shouldn't get any external interrupts, only decrementer, and the
+	 * decrementer handler is safe for use on offline CPUs
 	 */
-	hard_irq_disable();
+	local_irq_enable();
 
 	while (1) {
 		/* let's not take timer interrupts too often ... */
 		set_dec(0x7fffffff);
 
-		/* should always be true at this point */
-		if (cpu_has_feature(CPU_FTR_CAN_NAP))
-			power4_cpu_offline_powersave();
+		/* Enter NAP mode */
+		power4_idle();
 	}
 }
 
-- 
1.7.1
