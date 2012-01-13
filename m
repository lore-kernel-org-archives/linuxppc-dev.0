Return-Path: <B32616@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
 [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FF34B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 20:03:23 +1100 (EST)
From: Qiang Liu <qiang.liu@freescale.com>
To: <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][SDK v1.2] sata: I/O load balancing
Date: Fri, 13 Jan 2012 16:21:57 +0800
Message-ID: <1326442917-26562-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Qiang Liu <b32616@freescale.com>, Qiang Liu <qiang.liu@freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Qiang Liu <b32616@freescale.com>

Reduce interrupt singnals through reset Interrupt Coalescing Control Reg.
Increase the threshold value of interrupt and timer will reduce the number
of complete interrupt sharply. Improve the system performance effectively.

Signed-off-by: Qiang Liu <qiang.liu@freescale.net>
---
Description:
  1. sata-fsl interrupt will be raised 130 thousand times when write 8G file
(dd if=/dev/zero of=/dev/sda2 bs=128K count=65536);
  2. most of interrupts raised because of only 1-4 commands completed;
  3. only 30 thousand times will be raised after set max interrupt threshold,
more interrupts are coalesced as the description of ICC;

Performance Improvement:
  use top command,
  [root@p2020ds root]# dd if=/dev/zero of=/dev/sda2 bs=128K count=65536 &
  [root@p2020ds root]# top

   CPU %  |  dd   |  flush-8:0 | softirq
  ---------------------------------------
   before | 20-22 |    17-19   |    7
  ---------------------------------------
   after  | 18-21 |    15-16   |    5
  ---------------------------------------

 drivers/ata/sata_fsl.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 3547000..93f8b00 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -6,7 +6,7 @@
  * Author: Ashish Kalra <ashish.kalra@freescale.com>
  * Li Yang <leoli@freescale.com>
  *
- * Copyright (c) 2006-2007, 2011 Freescale Semiconductor, Inc.
+ * Copyright (c) 2006-2007, 2011-2012 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -162,6 +162,16 @@ enum {
 };

 /*
+ * Interrupt Coalescing Control Register bitdefs
+ */
+enum {
+	ICC_MIN_INT_THRESHOLD_COUNT = (1 << 24),
+	ICC_MAX_INT_THRESHOLD_COUNT = (((1 << 4) - 1) << 24),
+	ICC_MIN_INT_THRESHOLD_TIMER = 1,
+	ICC_MAX_INT_THRESHOLD_TIMER = ((1 << 18) - 1),
+};
+
+/*
  * SATA Superset Registers
  */
 enum {
@@ -460,6 +470,13 @@ static unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *qc)
 	/* Simply queue command to the controller/device */
 	iowrite32(1 << tag, CQ + hcr_base);

+	/*
+	 * reset the number of command complete bits which will cause the
+	 * interrupt to be signaled
+	 */
+	iowrite32(ICC_MAX_INT_THRESHOLD_COUNT | ICC_MAX_INT_THRESHOLD_TIMER,
+			ICC + hcr_base);
+
 	VPRINTK("xx_qc_issue called, tag=%d, CQ=0x%x, CA=0x%x\n",
 		tag, ioread32(CQ + hcr_base), ioread32(CA + hcr_base));

--
1.6.4
