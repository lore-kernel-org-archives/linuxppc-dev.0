Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 35D9167C52
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 08:03:18 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k58MK4rA029730
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 15:20:04 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k58M3H3j021247
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 17:03:17 -0500 (CDT)
Subject: [PATCH 5/10 v2] Add 8641 CPU and i8259 Setup
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149803956.23938.284.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 16:59:17 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add 8641 CPU table entry.
Add SMP CPU id determination and clear BATS.
Use level triggers on i8259.

Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 arch/powerpc/kernel/cputable.c |   12 ++++++++++++
 arch/powerpc/kernel/head_32.S  |   15 +++++++++++++++
 arch/powerpc/sysdev/i8259.c    |    5 +++++
 3 files changed, 32 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 0c487ee..2c8ac7e 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -704,6 +704,18 @@ #if CLASSIC_PPC
 		.oprofile_type		= PPC_OPROFILE_G4,
 		.platform		= "ppc7450",
 	},
+        {       /* 8641 */
+               .pvr_mask               = 0xffffffff,
+               .pvr_value              = 0x80040010,
+               .cpu_name               = "8641",
+               .cpu_features           = CPU_FTRS_7447A,
+               .cpu_user_features      = COMMON_USER | PPC_FEATURE_HAS_ALTIVEC_COMP,
+               .icache_bsize           = 32,
+               .dcache_bsize           = 32,
+               .num_pmcs               = 6,
+               .cpu_setup              = __setup_cpu_745x
+        },
+
 	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 		.pvr_mask		= 0x7fff0000,
 		.pvr_value		= 0x00810000,
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index a0579e8..e8f6bfa 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -224,6 +224,10 @@ turn_on_mmu:
 	li	r3,1			/* MTX only has 1 cpu */
 	.globl	__secondary_hold
 __secondary_hold:
+#ifdef CONFIG_PPC_86xx
+	/* get the cpu id */
+	mfspr	r3, SPRN_PIR
+#endif
 	/* tell the master we're here */
 	stw	r3,__secondary_hold_acknowledge@l(0)
 #ifdef CONFIG_SMP
@@ -348,6 +352,16 @@ #define EXC_XFER_EE_LITE(n, hdlr)	\
 #if defined(CONFIG_GEMINI) && defined(CONFIG_SMP)
 	. = 0x100
 	b	__secondary_start_gemini
+#endif
+/* we need to ensure that the address translation is disabled */
+#if defined(CONFIG_PPC_86xx) && defined(CONFIG_SMP)
+        . = 0x100
+        mfmsr   r3
+        andi.   r0, r3, (MSR_IR | MSR_DR)
+        andc    r3, r3, r0
+        mtmsr   r3
+        isync
+        b       __secondary_hold
 #else
 	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
 #endif
@@ -1019,6 +1033,7 @@ #endif /* CONFIG_6xx */
 	stw	r0,0(r3)
 
 	/* load up the MMU */
+	bl	clear_bats
 	bl	load_up_mmu
 
 	/* ptr to phys current thread */
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index b7ac32f..9b755e1 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -201,6 +201,11 @@ void __init i8259_init(unsigned long int
 	outb(0x0B, 0x20);
 	outb(0x0B, 0xA0);
 
+#ifdef CONFIG_I8259_LEVEL_TRIGGER
+	outb(0xfa, 0x4d0); /* level triggered */
+	outb(0xde, 0x4d1);
+#endif
+
 	/* Mask all interrupts */
 	outb(cached_A1, 0xA1);
 	outb(cached_21, 0x21);
