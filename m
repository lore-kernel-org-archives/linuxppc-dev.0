Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 675F01009A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 16:33:26 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5I6XItC002799 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 23:33:18 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5I6h9mo016659
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 01:43:13 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/4] powerpc: add e500 HID1 bit definition
Date: Fri, 18 Jun 2010 14:24:22 +0800
Message-Id: <1276842263-4186-3-git-send-email-leoli@freescale.com>
In-Reply-To: <1276842263-4186-2-git-send-email-leoli@freescale.com>
References: <1276842263-4186-1-git-send-email-leoli@freescale.com>
	<1276842263-4186-2-git-send-email-leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also make 74xx HID1 definition conditional.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/reg.h       |    2 ++
 arch/powerpc/include/asm/reg_booke.h |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d62fdf4..235d356 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -283,6 +283,7 @@
 #define HID0_NOPTI	(1<<0)		/* No-op dcbt and dcbst instr. */
 
 #define SPRN_HID1	0x3F1		/* Hardware Implementation Register 1 */
+#ifdef CONFIG_6xx
 #define HID1_EMCP	(1<<31)		/* 7450 Machine Check Pin Enable */
 #define HID1_DFS	(1<<22)		/* 7447A Dynamic Frequency Scaling */
 #define HID1_PC0	(1<<16)		/* 7450 PLL_CFG[0] */
@@ -292,6 +293,7 @@
 #define HID1_SYNCBE	(1<<11)		/* 7450 ABE for sync, eieio */
 #define HID1_ABE	(1<<10)		/* 7450 Address Broadcast Enable */
 #define HID1_PS		(1<<16)		/* 750FX PLL selection */
+#endif
 #define SPRN_HID2	0x3F8		/* Hardware Implementation Register 2 */
 #define SPRN_HID2_GEKKO	0x398		/* Gekko HID2 Register */
 #define SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 2360317..6d393f7 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -245,6 +245,22 @@
 					store or cache line push */
 #endif
 
+/* Bit definitions for the HID1 */
+#ifdef CONFIG_E500
+#ifndef CONFIG_PPC_E500MC
+/* e500v1/v2 */
+#define HID1_PLL_CFG_MASK 0xfc000000UL	/* PLL_CFG input pins */
+#define HID1_RFXE	0x00020000UL	/* Read fault exception enable */
+#define HID1_R1DPE	0x00008000UL	/* R1 data bus parity enable */
+#define HID1_R2DPE	0x00004000UL	/* R2 data bus parity enable */
+#define HID1_ASTME	0x00002000UL	/* Address bus streaming mode enable */
+#define HID1_ABE	0x00001000UL	/* Address broadcast enable */
+#define HID1_MPXTT	0x00000400UL	/* MPX re-map transfer type */
+#define HID1_ATS	0x00000080UL	/* Atomic status */
+#define HID1_MID_MASK	0x0000000fUL	/* MID input pins */
+#endif
+#endif
+
 /* Bit definitions for the DBSR. */
 /*
  * DBSR bits which have conflicting definitions on true Book E versus IBM 40x.
-- 
1.6.4
