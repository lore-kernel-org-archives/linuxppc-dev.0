Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ADB47DE17E
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 04:36:03 +1100 (EST)
Date: Wed, 12 Dec 2007 11:35:59 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 2/8] pm: Add TLF_SLEEPING hack to delay interrupt delivery
	when waking from sleep.
Message-ID: <20071212173559.GA5596@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071212173519.GA5577@loki.buserror.net>
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
 arch/powerpc/kernel/entry_32.S    |    6 ++--
 arch/powerpc/kernel/idle_6xx.S    |   41 ++++++++++++++++++++++++++++++++++++-
 include/asm-powerpc/thread_info.h |    2 +
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 69a91bd..4099a6f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -138,8 +138,8 @@ transfer_to_handler:
 #ifdef CONFIG_6xx
 	tophys(r9,r9)			/* check local flags */
 	lwz	r12,TI_LOCAL_FLAGS(r9)
-	mtcrf	0x01,r12
-	bt-	31-TLF_NAPPING,4f
+	andi.	r8, r12, _TLF_NAPPING | _TLF_SLEEPING
+	bne-	4f
 #endif /* CONFIG_6xx */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
@@ -154,7 +154,7 @@ transfer_to_handler_cont:
 	RFI				/* jump to handler, enable MMU */
 
 #ifdef CONFIG_6xx
-4:	rlwinm	r12,r12,0,~_TLF_NAPPING
+4:	rlwinm	r12,r12,0,~(_TLF_NAPPING | _TLF_SLEEPING)
 	stw	r12,TI_LOCAL_FLAGS(r9)
 	b	power_save_6xx_restore
 #endif
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 01bcd52..341f474 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -147,16 +147,30 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
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
  * address of current.  R11 points to the exception frame (physical
- * address).  We have to preserve r10.
+ * address).  r8 contains _TLF_NAPPING or _TLF_SLEEPING.  We have to
+ * preserve r10.
  */
 _GLOBAL(power_save_6xx_restore)
 	lwz	r9,_LINK(r11)		/* interrupted in ppc6xx_idle: */
+#ifdef CONFIG_SUSPEND
+	andi.	r12, r8, _TLF_SLEEPING
+#endif
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
+#ifdef CONFIG_SUSPEND
+	bne-	sleep_6xx_restore
+#endif
+
 #ifdef CONFIG_SMP
 	mfspr	r12,SPRN_SPRG3
 	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
@@ -185,6 +199,31 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_DUAL_PLL_750FX)
 	b	transfer_to_handler_cont
 
+#ifdef CONFIG_SUSPEND
+sleep_6xx_restore:
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
+
+	b	transfer_to_handler_cont
+#endif
+
 	.data
 
 _GLOBAL(nap_save_msscr0)
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index 40d5f98..f7cb48b 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -151,8 +151,10 @@ static inline struct thread_info *current_thread_info(void)
 /* Bits in local_flags */
 /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
 #define TLF_NAPPING		0	/* idle thread enabled NAP mode */
+#define TLF_SLEEPING		1	/* suspend code enabled SLEEP mode */
 
 #define _TLF_NAPPING		(1 << TLF_NAPPING)
+#define _TLF_SLEEPING		(1 << TLF_SLEEPING)
 
 #endif /* __KERNEL__ */
 
-- 
1.5.3.7
