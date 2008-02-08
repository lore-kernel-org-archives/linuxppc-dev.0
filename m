Return-Path: <bzolnier@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 72A83DEEBA
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:32:17 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3581029pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:32:16 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:46:26 +0100
Message-Id: <20080208004626.17746.19452.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 17/18] ide: remove init_hwif_default()
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

init_hwif_default() is only used by init_ide_data() now, inline it there.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -168,19 +168,6 @@ static void ide_port_init_devices_data(i
 }
 
 
-static void init_hwif_default(ide_hwif_t *hwif, unsigned int index)
-{
-	hw_regs_t hw;
-
-	memset(&hw, 0, sizeof(hw_regs_t));
-
-	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
-
-	memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
-
-	hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
-}
-
 /*
  * init_ide_data() sets reasonable default values into all fields
  * of all instances of the hwifs and drives, but only on the first call.
@@ -201,9 +188,9 @@ static void init_hwif_default(ide_hwif_t
 #define MAGIC_COOKIE 0x12345678
 static void __init init_ide_data (void)
 {
-	ide_hwif_t *hwif;
 	unsigned int index;
 	static unsigned long magic_cookie = MAGIC_COOKIE;
+	hw_regs_t hw;
 
 	if (magic_cookie != MAGIC_COOKIE)
 		return;		/* already initialized */
@@ -211,9 +198,15 @@ static void __init init_ide_data (void)
 
 	/* Initialise all interface structures */
 	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = &ide_hwifs[index];
+		ide_hwif_t *hwif = &ide_hwifs[index];
+
 		ide_init_port_data(hwif, index);
-		init_hwif_default(hwif, index);
+
+		memset(&hw, 0, sizeof(hw));
+		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0,
+				    &hwif->irq);
+		memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
+		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
 #if !defined(CONFIG_PPC32) || !defined(CONFIG_PCI)
 		hwif->irq =
 			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
