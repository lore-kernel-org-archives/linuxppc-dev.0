Return-Path: <bzolnier@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id E1C4DDE2AB
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:30:57 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so3283355wra.13
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:30:57 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:45:09 +0100
Message-Id: <20080208004509.17746.70379.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 07/18] ide: factor out devices init from ide_init_port_data()
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

* Factor out devices init from ide_init_port_data() to
  ide_port_init_devices_data().

While at it:

* Add explicit clearing of IDE device structure.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -109,13 +109,13 @@ ide_hwif_t ide_hwifs[MAX_HWIFS];	/* mast
 
 EXPORT_SYMBOL(ide_hwifs);
 
+static void ide_port_init_devices_data(ide_hwif_t *);
+
 /*
  * Do not even *think* about calling this!
  */
 void ide_init_port_data(ide_hwif_t *hwif, unsigned int index)
 {
-	unsigned int unit;
-
 	/* bulk initialize hwif & drive info with zeros */
 	memset(hwif, 0, sizeof(ide_hwif_t));
 
@@ -134,8 +134,20 @@ void ide_init_port_data(ide_hwif_t *hwif
 
 	default_hwif_iops(hwif);
 	default_hwif_transport(hwif);
+
+	ide_port_init_devices_data(hwif);
+}
+EXPORT_SYMBOL_GPL(ide_init_port_data);
+
+static void ide_port_init_devices_data(ide_hwif_t *hwif)
+{
+	int unit;
+
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
+		u8 j = (hwif->index * MAX_DRIVES) + unit;
+
+		memset(drive, 0, sizeof(*drive));
 
 		drive->media			= ide_disk;
 		drive->select.all		= (unit<<4)|0xa0;
@@ -147,15 +159,14 @@ void ide_init_port_data(ide_hwif_t *hwif
 		drive->special.b.set_geometry	= 1;
 		drive->name[0]			= 'h';
 		drive->name[1]			= 'd';
-		drive->name[2]			= 'a' + (index * MAX_DRIVES) + unit;
+		drive->name[2]			= 'a' + j;
 		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
-		drive->using_dma		= 0;
-		drive->vdma			= 0;
+
 		INIT_LIST_HEAD(&drive->list);
 		init_completion(&drive->gendev_rel_comp);
 	}
 }
-EXPORT_SYMBOL_GPL(ide_init_port_data);
+
 
 static void init_hwif_default(ide_hwif_t *hwif, unsigned int index)
 {
