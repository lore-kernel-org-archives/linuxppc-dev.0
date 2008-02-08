Return-Path: <bzolnier@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by ozlabs.org (Postfix) with ESMTP id 6C74ADE0D0
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:31:07 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so4153914fkz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:31:04 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:45:16 +0100
Message-Id: <20080208004516.17746.18498.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 08/18] ide: move ide_port_setup_devices() call to
	ide_device_add_all()
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

Add ide_cfg_mtx lock/unlock to ide_port_setup_devices() and then move
ide_port_setup_devices() call from init_irq() to ide_device_add_all().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -947,6 +947,7 @@ static void ide_port_setup_devices(ide_h
 {
 	int i;
 
+	mutex_lock(&ide_cfg_mtx);
 	for (i = 0; i < MAX_DRIVES; i++) {
 		ide_drive_t *drive = &hwif->drives[i];
 
@@ -961,6 +962,7 @@ static void ide_port_setup_devices(ide_h
 
 		ide_add_drive_to_hwgroup(drive);
 	}
+	mutex_unlock(&ide_cfg_mtx);
 }
 
 /*
@@ -1086,8 +1088,6 @@ static int init_irq (ide_hwif_t *hwif)
 			hwif->sharing_irq ? "shar" : "serializ", match->name);
 	printk("\n");
 
-	ide_port_setup_devices(hwif);
-
 	mutex_unlock(&ide_cfg_mtx);
 	return 0;
 out_unlink:
@@ -1443,6 +1443,8 @@ int ide_device_add_all(u8 *idx, const st
 			continue;
 		}
 
+		ide_port_setup_devices(hwif);
+
 		ide_acpi_init(hwif);
 		ide_acpi_port_init_devices(hwif);
 	}
