Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BAB9DDDFF3
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 08:06:46 +1000 (EST)
Date: Wed, 5 Sep 2007 17:06:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 2/3] pm: Handle HID0_SLEEP in the TLF_NAPPING hack.
Message-ID: <20070905220638.GA11353@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905220438.GA11283@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The e300 core (and probably most other 6xx chips) can only come out of
sleep mode with an interrupt.  However, interrupts are logically disabled
by the power management layer.

This hack extends the existing doze/nap hack to also suppress the running
of the interrupt handler when in sleep mode.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/idle_6xx.S |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 01bcd52..d176042 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -147,6 +147,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	isync
 	b	1b
 
+#ifdef CONFIG_SUSPEND
+ret_from_sleep:
+	.long	ret_from_except
+	.long	ret_from_except
+#endif
+
 /*
  * Return from NAP/DOZE mode, restore some CPU specific registers,
  * we are called with DR/IR still off and r2 containing physical
@@ -154,7 +160,33 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
  * address).  We have to preserve r10.
  */
 _GLOBAL(power_save_6xx_restore)
-	lwz	r9,_LINK(r11)		/* interrupted in ppc6xx_idle: */
+#ifdef CONFIG_SUSPEND
+	mfspr	r8, SPRN_HID0
+	andis.	r9, r8, HID0_SLEEP@h
+	beq+	1f
+
+	/*
+	 * SLEEP mode is invoked through the PM subsystem, which means
+	 * that interrupts should be disabled.  However, the hardware
+	 * requires them to be enabled to wake up.  To prevent the
+	 * interrupt from being visible to Linux, return immediately
+	 * rather than run the interrupt handler.
+	 */
+	lis	r9, ret_from_sleep@h
+	ori	r9, r9, ret_from_sleep@l
+	tophys(r9, r9)
+	mtlr	r9
+
+	/*
+	 * Disable interrupts, so that the interrupt doesn't happen
+	 * again until the PM code sets MSR[EE].
+	 */
+	lwz	r9, _MSR(r11)
+	rlwinm	r9, r9, 0, ~MSR_EE
+	stw	r9, _MSR(r11)
+#endif
+
+1:	lwz	r9,_LINK(r11)		/* interrupted in ppc6xx_idle: */
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
@@ -168,8 +200,10 @@ _GLOBAL(power_save_6xx_restore)
 	 * and load r11 (@ha part + CPU offset) only once
 	 */
 BEGIN_FTR_SECTION
-	mfspr	r9,SPRN_HID0
-	andis.	r9,r9,HID0_NAP@h
+#ifndef CONFIG_SUSPEND
+	mfspr 	r8,SPRN_HID0
+#endif
+	andis.	r9,r8,HID0_NAP@h
 	beq	1f
 	addis	r9,r11,(nap_save_msscr0-KERNELBASE)@ha
 	lwz	r9,nap_save_msscr0@l(r9)
-- 
1.5.3
