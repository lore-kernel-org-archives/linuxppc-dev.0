Return-Path: <bzolnier@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id CB386DE772
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:31:33 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3580760pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:31:33 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:45:45 +0100
Message-Id: <20080208004545.17746.25806.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 12/18] ide: remove needless CONFIG_BLK_DEV_HD hack from
	init_hwif()
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

request_irq() will fail if there is already another IRQ handler
registered and IRQ flags are mismatched.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    7 -------
 1 file changed, 7 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1237,13 +1237,6 @@ static int hwif_init(ide_hwif_t *hwif)
 			return 0;
 		}
 	}
-#ifdef CONFIG_BLK_DEV_HD
-	if (hwif->irq == HD_IRQ && hwif->io_ports[IDE_DATA_OFFSET] != HD_DATA) {
-		printk("%s: CANNOT SHARE IRQ WITH OLD "
-			"HARDDISK DRIVER (hd.c)\n", hwif->name);
-		return 0;
-	}
-#endif /* CONFIG_BLK_DEV_HD */
 
 	if (register_blkdev(hwif->major, hwif->name))
 		return 0;
