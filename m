Return-Path: <SRS0=JDpv=TM=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 0E494DDF32
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 08:07:52 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/5] [POWERPC] Add AMCC 460EX/460GT support to cputable.c &
	cpu_setup_44x.S
Date: Sat, 23 Feb 2008 22:07:41 +0100
Message-Id: <1203800861-13778-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds basic support for the AMCC 460EX/460GT PPC's to arch/powerpc.
Currently those PPC's are still based on a 440 core and *not* a 460 core.

Here some basic features of those SoC's:

460EX:
- Up to 1.2GHz, 32kB L1 I-cache and D-cache, 256kB L2-cache, FPU
- 1 * PCI (max 66MHz), 2 * PCIe (one 4-lane, one 1-lane)
- 2 * GBit Ethernet with TCP/IP acceleration
- USB 2.0 Host/Device OTG and Host interface
- SATA controller
- Optional security feature

460GT (only changes to 460EX):
- 4 * GBit Ethernet with TCP/IP acceleration
- RapidIO
- No SATA
- No USB

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/kernel/cpu_setup_44x.S |    5 ++++-
 arch/powerpc/kernel/cputable.c      |   28 +++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_44x.S b/arch/powerpc/kernel/cpu_setup_44x.S
index 6250443..5465e8d 100644
--- a/arch/powerpc/kernel/cpu_setup_44x.S
+++ b/arch/powerpc/kernel/cpu_setup_44x.S
@@ -3,7 +3,7 @@
  * Valentine Barshak <vbarshak@ru.mvista.com>
  * MontaVista Software, Inc (c) 2007
  *
- * Based on cpu_setup_6xx code by 
+ * Based on cpu_setup_6xx code by
  * Benjamin Herrenschmidt <benh@kernel.crashing.org>
  *
  * This program is free software; you can redistribute it and/or
@@ -32,6 +32,9 @@ _GLOBAL(__setup_cpu_440grx)
 	bl	__fixup_440A_mcheck
 	mtlr	r4
 	blr
+_GLOBAL(__setup_cpu_460ex)
+_GLOBAL(__setup_cpu_460gt)
+	b	__init_fpu_44x
 _GLOBAL(__setup_cpu_440gx)
 _GLOBAL(__setup_cpu_440spe)
 	b	__fixup_440A_mcheck
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 2a8f5cc..26ffb44 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -36,6 +36,8 @@ extern void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440gx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440spe(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -1397,6 +1399,30 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{ /* 460EX */
+		.pvr_mask		= 0xffff0002,
+		.pvr_value		= 0x13020002,
+		.cpu_name		= "460EX",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_460ex,
+		.machine_check		= machine_check_440A,
+		.platform		= "ppc440",
+	},
+	{ /* 460GT */
+		.pvr_mask		= 0xffff0002,
+		.pvr_value		= 0x13020000,
+		.cpu_name		= "460GT",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_460gt,
+		.machine_check		= machine_check_440A,
+		.platform		= "ppc440",
+	},
 #endif /* CONFIG_44x */
 #ifdef CONFIG_FSL_BOOKE
 #ifdef CONFIG_E200
@@ -1512,7 +1538,7 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 				*t = *s;
 			*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
 #if defined(CONFIG_PPC64) || defined(CONFIG_BOOKE)
-			/* ppc64 and booke expect identify_cpu to also call 
+			/* ppc64 and booke expect identify_cpu to also call
 			 * setup_cpu for that processor. I will consolidate
 			 * that at a later time, for now, just use #ifdef.
 			 * we also don't need to PTRRELOC the function pointer
-- 
1.5.4.2
