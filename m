Return-Path: <B21989@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 725ABB70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 18:59:06 +1100 (EST)
Received: from mail68-am1 (localhost.localdomain [127.0.0.1])	by
	mail68-am1-R.bigfish.com (Postfix) with ESMTP id C97CF4A8431	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 29 Oct 2010 07:43:50 +0000 (UTC)
Received: from AM1EHSMHS006.bigfish.com (unknown [10.3.201.248])	by
	mail68-am1.bigfish.com (Postfix) with ESMTP id 43A6876804E	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 29 Oct 2010 07:43:50 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9T7heZl015551	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 29 Oct 2010 00:43:40 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9T7xJ2A014800	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 02:59:20 -0500 (CDT)
From: Shaohui Xie <b21989@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/4][v2] powerpc: add e500 HID1 bit definition
Date: Fri, 29 Oct 2010 15:13:29 +0800
Message-ID: <1288336409-10550-1-git-send-email-b21989@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Kumar Gala <kumar.gala@freescale.com>, Shaohui Xie <b21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>

Also make 74xx HID1 definition conditional.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Shaohui Xie <b21989@freescale.com>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <kumar.gala@freescale.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
---
 arch/powerpc/include/asm/reg.h       |    2 ++
 arch/powerpc/include/asm/reg_booke.h |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index ff0005e..125fc1a 100644
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
index 667a498..dc6adff 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -246,6 +246,20 @@
 					store or cache line push */
 #endif
 
+/* Bit definitions for the HID1 */
+#ifdef CONFIG_E500
+/* e500v1/v2 */
+#define HID1_PLL_CFG_MASK 0xfc000000	/* PLL_CFG input pins */
+#define HID1_RFXE	0x00020000	/* Read fault exception enable */
+#define HID1_R1DPE	0x00008000	/* R1 data bus parity enable */
+#define HID1_R2DPE	0x00004000	/* R2 data bus parity enable */
+#define HID1_ASTME	0x00002000	/* Address bus streaming mode enable */
+#define HID1_ABE	0x00001000	/* Address broadcast enable */
+#define HID1_MPXTT	0x00000400	/* MPX re-map transfer type */
+#define HID1_ATS	0x00000080	/* Atomic status */
+#define HID1_MID_MASK	0x0000000f	/* MID input pins */
+#endif
+
 /* Bit definitions for the DBSR. */
 /*
  * DBSR bits which have conflicting definitions on true Book E versus IBM 40x.
-- 
1.6.4
