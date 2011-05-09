Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B63CB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 May 2011 07:26:10 +1000 (EST)
Date: Mon, 9 May 2011 16:26:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/e5500: set non-base IVORs
Message-ID: <20110509212600.GA29190@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Without this, we attempt to use doorbells for IPIs, and end up
branching to some bad address.  Plus, even for the exceptions
we don't implement, it's good to handle it and get a message out.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/reg_booke.h      |    4 ++
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    3 ++
 arch/powerpc/kernel/exceptions-64e.S      |   47 +++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 817bd1a..0f0ad9f 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -83,6 +83,10 @@
 #define SPRN_IVOR13	0x19D	/* Interrupt Vector Offset Register 13 */
 #define SPRN_IVOR14	0x19E	/* Interrupt Vector Offset Register 14 */
 #define SPRN_IVOR15	0x19F	/* Interrupt Vector Offset Register 15 */
+#define SPRN_IVOR38	0x1B0	/* Interrupt Vector Offset Register 38 */
+#define SPRN_IVOR39	0x1B1	/* Interrupt Vector Offset Register 39 */
+#define SPRN_IVOR40	0x1B2	/* Interrupt Vector Offset Register 40 */
+#define SPRN_IVOR41	0x1B3	/* Interrupt Vector Offset Register 41 */
 #define SPRN_SPEFSCR	0x200	/* SPE & Embedded FP Status & Control */
 #define SPRN_BBEAR	0x201	/* Branch Buffer Entry Address Register */
 #define SPRN_BBTAR	0x202	/* Branch Buffer Target Address Register */
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 9136111..8053db0 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -88,6 +88,9 @@ _GLOBAL(__setup_cpu_e5500)
 	bl	__e500_dcache_setup
 #ifdef CONFIG_PPC_BOOK3E_64
 	bl	.__setup_base_ivors
+	bl	.setup_perfmon_ivor
+	bl	.setup_doorbell_ivors
+	bl	.setup_ehv_ivors
 #else
 	bl	__setup_e500mc_ivors
 #endif
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 4d0abb4..69de473 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -272,8 +272,13 @@ interrupt_base_book3e:					/* fake trap */
 	EXCEPTION_STUB(0x1a0, watchdog)			/* 0x09f0 */
 	EXCEPTION_STUB(0x1c0, data_tlb_miss)
 	EXCEPTION_STUB(0x1e0, instruction_tlb_miss)
+	EXCEPTION_STUB(0x260, perfmon)
 	EXCEPTION_STUB(0x280, doorbell)
 	EXCEPTION_STUB(0x2a0, doorbell_crit)
+	EXCEPTION_STUB(0x2c0, guest_doorbell)
+	EXCEPTION_STUB(0x2e0, guest_doorbell_crit)
+	EXCEPTION_STUB(0x300, hypercall)
+	EXCEPTION_STUB(0x320, ehpriv)
 
 	.globl interrupt_end_book3e
 interrupt_end_book3e:
@@ -455,6 +460,8 @@ interrupt_end_book3e:
 kernel_dbg_exc:
 	b	.	/* NYI */
 
+	MASKABLE_EXCEPTION(0x260, perfmon, .performance_monitor_exception, ACK_NONE)
+
 /* Doorbell interrupt */
 	MASKABLE_EXCEPTION(0x2070, doorbell, .doorbell_exception, ACK_NONE)
 
@@ -469,6 +476,11 @@ kernel_dbg_exc:
 //	b	ret_from_crit_except
 	b	.
 
+	MASKABLE_EXCEPTION(0x2c0, guest_doorbell, .unknown_exception, ACK_NONE)
+	MASKABLE_EXCEPTION(0x2e0, guest_doorbell_crit, .unknown_exception, ACK_NONE)
+	MASKABLE_EXCEPTION(0x310, hypercall, .unknown_exception, ACK_NONE)
+	MASKABLE_EXCEPTION(0x320, ehpriv, .unknown_exception, ACK_NONE)
+
 
 /*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
@@ -588,7 +600,12 @@ fast_exception_return:
 BAD_STACK_TRAMPOLINE(0x000)
 BAD_STACK_TRAMPOLINE(0x100)
 BAD_STACK_TRAMPOLINE(0x200)
+BAD_STACK_TRAMPOLINE(0x260)
+BAD_STACK_TRAMPOLINE(0x2c0)
+BAD_STACK_TRAMPOLINE(0x2e0)
 BAD_STACK_TRAMPOLINE(0x300)
+BAD_STACK_TRAMPOLINE(0x310)
+BAD_STACK_TRAMPOLINE(0x320)
 BAD_STACK_TRAMPOLINE(0x400)
 BAD_STACK_TRAMPOLINE(0x500)
 BAD_STACK_TRAMPOLINE(0x600)
@@ -1124,3 +1141,33 @@ _GLOBAL(__setup_base_ivors)
 	sync
 
 	blr
+
+_GLOBAL(setup_perfmon_ivor)
+	SET_IVOR(35, 0x260) /* Performance Monitor */
+	blr
+
+_GLOBAL(setup_doorbell_ivors)
+	SET_IVOR(36, 0x280) /* Processor Doorbell */
+	SET_IVOR(37, 0x2a0) /* Processor Doorbell Crit */
+
+	/* Check MMUCFG[LPIDSIZE] to determine if we have category E.HV */
+	mfspr	r10,SPRN_MMUCFG
+	rlwinm.	r10,r10,0,MMUCFG_LPIDSIZE
+	beqlr
+
+	SET_IVOR(38, 0x2c0) /* Guest Processor Doorbell */
+	SET_IVOR(39, 0x2e0) /* Guest Processor Doorbell Crit/MC */
+	blr
+
+_GLOBAL(setup_ehv_ivors)
+	/*
+	 * We may be running as a guest and lack E.HV even on a chip
+	 * that normally has it.
+	 */
+	mfspr	r10,SPRN_MMUCFG
+	rlwinm.	r10,r10,0,MMUCFG_LPIDSIZE
+	beqlr
+
+	SET_IVOR(40, 0x300) /* Embedded Hypervisor System Call */
+	SET_IVOR(41, 0x320) /* Embedded Hypervisor Privilege */
+	blr
-- 
1.7.4.1
