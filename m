Return-Path: <r66093@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E3B7B705B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 19:30:42 +1000 (EST)
Received: from mail31-db3 (localhost [127.0.0.1])	by mail31-db3-R.bigfish.com
 (Postfix) with ESMTP id 533CA2C0556	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 17 Apr 2012 09:30:36 +0000 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.233])	by
 mail31-db3.bigfish.com (Postfix) with ESMTP id B9891A0184	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 09:30:34 +0000 (UTC)
From: <Chang-Ming.Huang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 1/2] powerpc/mpc85xx: support the MTD for p1022ds flash
Date: Tue, 17 Apr 2012 17:15:29 +0800
Message-ID: <1334654129-1044-1-git-send-email-Chang-Ming.Huang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

The compatilbe 'simple-bus' is removed from the latest DTS for NAND and
NOR flash partition, so we must add the new compatilbe support for p1022ds,
otherwise, the kernel can't parse the partition of NOR and NAND flash.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
changes for v2:
	correct the style

 arch/powerpc/platforms/85xx/p1022_ds.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index e74b7cd..0db3a7e 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -463,6 +463,7 @@ static void __init p1022_ds_setup_arch(void)
 static struct of_device_id __initdata p1022_ds_ids[] = {
 	/* So that the DMA channel nodes can be probed individually: */
 	{ .compatible = "fsl,eloplus-dma", },
+	{ .compatible = "fsl,p1022-elbc", },
 	{},
 };
 
-- 
1.7.5.4
