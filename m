Return-Path: <bzolnier@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id D76BBDE01B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:30:51 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so79992wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:30:50 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:45:02 +0100
Message-Id: <20080208004502.17746.73284.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 06/18] ide: factor out code unregistering devices from
	ide_unregister()
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

Factor out code unregistering devices from ide_unregister() to
ide_port_unregister_devices().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -494,6 +494,23 @@ void ide_remove_port_from_hwgroup(ide_hw
 	spin_unlock_irq(&ide_lock);
 }
 
+/* Called with ide_lock held. */
+static void ide_port_unregister_devices(ide_hwif_t *hwif)
+{
+	int i;
+
+	for (i = 0; i < MAX_DRIVES; i++) {
+		ide_drive_t *drive = &hwif->drives[i];
+
+		if (drive->present) {
+			spin_unlock_irq(&ide_lock);
+			device_unregister(&drive->gendev);
+			wait_for_completion(&drive->gendev_rel_comp);
+			spin_lock_irq(&ide_lock);
+		}
+	}
+}
+
 /**
  *	ide_unregister		-	free an IDE interface
  *	@index: index of interface (will change soon to a pointer)
@@ -520,11 +537,10 @@ void ide_remove_port_from_hwgroup(ide_hw
 
 void ide_unregister(unsigned int index, int init_default, int restore)
 {
-	ide_drive_t *drive;
 	ide_hwif_t *hwif, *g;
 	static ide_hwif_t tmp_hwif; /* protected by ide_cfg_mtx */
 	ide_hwgroup_t *hwgroup;
-	int irq_count = 0, unit;
+	int irq_count = 0;
 
 	BUG_ON(index >= MAX_HWIFS);
 
@@ -535,15 +551,7 @@ void ide_unregister(unsigned int index, 
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		drive = &hwif->drives[unit];
-		if (!drive->present)
-			continue;
-		spin_unlock_irq(&ide_lock);
-		device_unregister(&drive->gendev);
-		wait_for_completion(&drive->gendev_rel_comp);
-		spin_lock_irq(&ide_lock);
-	}
+	ide_port_unregister_devices(hwif);
 	hwif->present = 0;
 
 	spin_unlock_irq(&ide_lock);
