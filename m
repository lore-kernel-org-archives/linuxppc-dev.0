Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4537BDE0D2
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:29:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l47ITsrx003484
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:29:54 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l47ITrNQ019066
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:29:53 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l47I86pH022251
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:08:06 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 7F771AEFC9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 13:29:52 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l47ITqpq026954
	for linuxppc-dev@ozlabs.org; Mon, 7 May 2007 13:29:52 -0500
Date: Mon, 7 May 2007 13:29:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/13] pm: Handle HID0_SLEEP in the TLF_NAPPING hack.
Message-ID: <20070507182952.GG26920@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/kernel/idle_6xx.S |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 01bcd52..f45d634 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -147,6 +147,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	isync
 	b	1b
 
+#ifdef CONFIG_PM
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
+#ifdef CONFIG_PM
+	mfspr	r9, SPRN_HID0
+	andis.	r9, r9, HID0_SLEEP@h
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
-- 
1.5.0.3
