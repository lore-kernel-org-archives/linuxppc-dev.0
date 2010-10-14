Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF0211009FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 13:32:15 +1100 (EST)
Received: from mail134-va3 (localhost.localdomain [127.0.0.1])	by
	mail134-va3-R.bigfish.com (Postfix) with ESMTP id ECA0114D0284	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 02:31:53 +0000 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.250])	by
	mail134-va3.bigfish.com (Postfix) with ESMTP id 384FFE8050	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 02:31:39 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9E2VWUh029957	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 19:31:33 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9E2kfp7024805	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 21:46:42 -0500 (CDT)
From: Shaohui Xie <b21989@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/3] fsl_rio: Add comments for sRIO registers.
Date: Thu, 14 Oct 2010 10:04:02 +0800
Message-ID: <1287021842-22015-1-git-send-email-b21989@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alexandre.bounine@idt.com, b21989@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add some comments to make sRIO registers map better readable.

Signed-off-by: Shaohui Xie <b21989@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |   65 +++++++++++++++++++++++++----------------
 1 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 3017532..4127636 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -117,44 +117,59 @@ struct rio_atmu_regs {
 };
 
 struct rio_msg_regs {
-	u32 omr;
-	u32 osr;
+	u32 omr;	/* 0xD_3000 - Outbound message 0 mode register */
+	u32 osr;	/* 0xD_3004 - Outbound message 0 status register */
 	u32 pad1;
-	u32 odqdpar;
+	u32 odqdpar;	/* 0xD_300C - Outbound message 0 descriptor queue
+			   dequeue pointer address register */
 	u32 pad2;
-	u32 osar;
-	u32 odpr;
-	u32 odatr;
-	u32 odcr;
+	u32 osar;	/* 0xD_3014 - Outbound message 0 source address
+			   register */
+	u32 odpr;	/* 0xD_3018 - Outbound message 0 destination port
+			   register */
+	u32 odatr;	/* 0xD_301C - Outbound message 0 destination attributes
+			   Register*/
+	u32 odcr;	/* 0xD_3020 - Outbound message 0 double-word count
+			   register */
 	u32 pad3;
-	u32 odqepar;
+	u32 odqepar;	/* 0xD_3028 - Outbound message 0 descriptor queue
+			   enqueue pointer address register */
 	u32 pad4[13];
-	u32 imr;
-	u32 isr;
+	u32 imr;	/* 0xD_3060 - Inbound message 0 mode register */
+	u32 isr;	/* 0xD_3064 - Inbound message 0 status register */
 	u32 pad5;
-	u32 ifqdpar;
+	u32 ifqdpar;	/* 0xD_306C - Inbound message 0 frame queue dequeue
+			   pointer address register*/
 	u32 pad6;
-	u32 ifqepar;
+	u32 ifqepar;	/* 0xD_3074 - Inbound message 0 frame queue enqueue
+			   pointer address register */
 	u32 pad7[226];
-	u32 odmr;
-	u32 odsr;
+	u32 odmr;	/* 0xD_3400 - Outbound doorbell mode register */
+	u32 odsr;	/* 0xD_3404 - Outbound doorbell status register */
 	u32 res0[4];
-	u32 oddpr;
-	u32 oddatr;
+	u32 oddpr;	/* 0xD_3418 - Outbound doorbell destination port
+			   register */
+	u32 oddatr;	/* 0xD_341c - Outbound doorbell destination attributes
+			   register */
 	u32 res1[3];
-	u32 odretcr;
+	u32 odretcr;	/* 0xD_342C - Outbound doorbell retry error threshold
+			   configuration register */
 	u32 res2[12];
-	u32 dmr;
-	u32 dsr;
+	u32 dmr;	/* 0xD_3460 - Inbound doorbell mode register */
+	u32 dsr;	/* 0xD_3464 - Inbound doorbell status register */
 	u32 pad8;
-	u32 dqdpar;
+	u32 dqdpar;	/* 0xD_346C - Inbound doorbell queue dequeue Pointer
+			   address register */
 	u32 pad9;
-	u32 dqepar;
+	u32 dqepar;	/* 0xD_3474 - Inbound doorbell Queue enqueue pointer
+			   address register */
 	u32 pad10[26];
-	u32 pwmr;
-	u32 pwsr;
-	u32 epwqbar;
-	u32 pwqbar;
+	u32 pwmr;	/* 0xD_34E0 - Inbound port-write mode register */
+	u32 pwsr;	/* 0xD_34E4 - Inbound port-write status register */
+	u32 epwqbar;	/* 0xD_34E8 - Extended Port-Write Queue Base Address
+			   register */
+	u32 pwqbar;	/* 0xD_34EC - Inbound port-write queue base address
+			   register */
 };
 
 struct rio_tx_desc {
-- 
1.6.4
