Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF6AFB7D5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Jun 2010 17:15:50 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o527FjKs022946
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Jun 2010 02:15:46 -0500
Subject: [PATCH] powerpc/macio: Fix probing of macio devices by using the
	right of match table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 17:15:45 +1000
Message-ID: <1275462945.1931.771.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant patches added an of mach table to struct device_driver. However,
while he changed the macio device code to use that, he left the match
table pointer in struct macio_driver and didn't update drivers to use
the "new" one, thus breaking the probing.

This completes the change by moving all drivers to setup the "new"
one, removing all traces of the old one, and while at it (since it
changes the exact same locations), I also remove two other duplicates
from struct driver which are the name and owner fields.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/macio.h       |    4 ----
 drivers/ata/pata_macio.c               |   10 +++++-----
 drivers/block/swim3.c                  |    6 ++++--
 drivers/ide/pmac.c                     |    7 +++++--
 drivers/macintosh/macio_asic.c         |    1 -
 drivers/macintosh/mediabay.c           |    6 ++++--
 drivers/macintosh/rack-meter.c         |    8 +++++---
 drivers/net/bmac.c                     |    7 +++++--
 drivers/net/mace.c                     |    7 +++++--
 drivers/net/wireless/orinoco/airport.c |    7 +++++--
 drivers/scsi/mac53c94.c                |    7 +++++--
 drivers/scsi/mesh.c                    |    7 +++++--
 drivers/serial/pmac_zilog.c            |    7 +++++--
 sound/aoa/soundbus/i2sbus/core.c       |    8 +++++---
 14 files changed, 58 insertions(+), 34 deletions(-)

I'm going to send that to Linus today btw...

diff --git a/arch/powerpc/include/asm/macio.h b/arch/powerpc/include/asm/macio.h
index 19a661b..675e159 100644
--- a/arch/powerpc/include/asm/macio.h
+++ b/arch/powerpc/include/asm/macio.h
@@ -123,10 +123,6 @@ static inline struct pci_dev *macio_get_pci_dev(struct macio_dev *mdev)
  */
 struct macio_driver
 {
-	char			*name;
-	struct of_device_id	*match_table;
-	struct module		*owner;
-
 	int	(*probe)(struct macio_dev* dev, const struct of_device_id *match);
 	int	(*remove)(struct macio_dev* dev);
 
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 76640ac..75b49d0 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1355,8 +1355,11 @@ static struct of_device_id pata_macio_match[] =
 
 static struct macio_driver pata_macio_driver =
 {
-	.name 		= "pata-macio",
-	.match_table	= pata_macio_match,
+	.driver = {
+		.name 		= "pata-macio",
+		.owner		= THIS_MODULE,
+		.of_match_table	= pata_macio_match,
+	},
 	.probe		= pata_macio_attach,
 	.remove		= pata_macio_detach,
 #ifdef CONFIG_PM
@@ -1366,9 +1369,6 @@ static struct macio_driver pata_macio_driver =
 #ifdef CONFIG_PMAC_MEDIABAY
 	.mediabay_event	= pata_macio_mb_event,
 #endif
-	.driver = {
-		.owner		= THIS_MODULE,
-	},
 };
 
 static const struct pci_device_id pata_macio_pci_match[] = {
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 52f2d11..ed6fb91 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1159,8 +1159,10 @@ static struct of_device_id swim3_match[] =
 
 static struct macio_driver swim3_driver =
 {
-	.name 		= "swim3",
-	.match_table	= swim3_match,
+	.driver = {
+		.name 		= "swim3",
+		.of_match_table	= swim3_match,
+	},
 	.probe		= swim3_attach,
 #if 0
 	.suspend	= swim3_suspend,
diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 183fa38..ebcf8e4 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1400,8 +1400,11 @@ static struct of_device_id pmac_ide_macio_match[] =
 
 static struct macio_driver pmac_ide_macio_driver = 
 {
-	.name 		= "ide-pmac",
-	.match_table	= pmac_ide_macio_match,
+	.driver = {
+		.name 		= "ide-pmac",
+		.owner		= THIS_MODULE,
+		.of_match_table	= pmac_ide_macio_match,
+	},
 	.probe		= pmac_ide_macio_attach,
 	.suspend	= pmac_ide_macio_suspend,
 	.resume		= pmac_ide_macio_resume,
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 40390ac..b6e7ddc 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -526,7 +526,6 @@ static void macio_pci_add_devices(struct macio_chip *chip)
 int macio_register_driver(struct macio_driver *drv)
 {
 	/* initialize common driver fields */
-	drv->driver.name = drv->name;
 	drv->driver.bus = &macio_bus_type;
 
 	/* register with core */
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 288acce..2fd435b 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -728,8 +728,10 @@ static struct of_device_id media_bay_match[] =
 
 static struct macio_driver media_bay_driver =
 {
-	.name		= "media-bay",
-	.match_table	= media_bay_match,
+	.driver = {
+		.name		= "media-bay",
+		.of_match_table	= media_bay_match,
+	},
 	.probe		= media_bay_attach,
 	.suspend	= media_bay_suspend,
 	.resume		= media_bay_resume
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 12946c5..53cce3a 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -584,9 +584,11 @@ static struct of_device_id rackmeter_match[] = {
 };
 
 static struct macio_driver rackmeter_driver = {
-	.name = "rackmeter",
-	.owner = THIS_MODULE,
-	.match_table = rackmeter_match,
+	.driver = {
+		.name = "rackmeter",
+		.owner = THIS_MODULE,
+		.of_match_table = rackmeter_match,
+	},
 	.probe = rackmeter_probe,
 	.remove = __devexit_p(rackmeter_remove),
 	.shutdown = rackmeter_shutdown,
diff --git a/drivers/net/bmac.c b/drivers/net/bmac.c
index 39250b2..959add2 100644
--- a/drivers/net/bmac.c
+++ b/drivers/net/bmac.c
@@ -1654,8 +1654,11 @@ MODULE_DEVICE_TABLE (of, bmac_match);
 
 static struct macio_driver bmac_driver =
 {
-	.name 		= "bmac",
-	.match_table	= bmac_match,
+	.driver = {
+		.name 		= "bmac",
+		.owner		= THIS_MODULE,
+		.of_match_table	= bmac_match,
+	},
 	.probe		= bmac_probe,
 	.remove		= bmac_remove,
 #ifdef CONFIG_PM
diff --git a/drivers/net/mace.c b/drivers/net/mace.c
index b6855a6..1c5221f 100644
--- a/drivers/net/mace.c
+++ b/drivers/net/mace.c
@@ -997,8 +997,11 @@ MODULE_DEVICE_TABLE (of, mace_match);
 
 static struct macio_driver mace_driver =
 {
-	.name 		= "mace",
-	.match_table	= mace_match,
+	.driver = {
+		.name 		= "mace",
+		.owner		= THIS_MODULE,
+		.of_match_table	= mace_match,
+	},
 	.probe		= mace_probe,
 	.remove		= mace_remove,
 };
diff --git a/drivers/net/wireless/orinoco/airport.c b/drivers/net/wireless/orinoco/airport.c
index 9bcee10..4a0a0e5 100644
--- a/drivers/net/wireless/orinoco/airport.c
+++ b/drivers/net/wireless/orinoco/airport.c
@@ -239,8 +239,11 @@ static struct of_device_id airport_match[] =
 MODULE_DEVICE_TABLE(of, airport_match);
 
 static struct macio_driver airport_driver = {
-	.name 		= DRIVER_NAME,
-	.match_table	= airport_match,
+	.driver = {
+		.name 		= DRIVER_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= airport_match,
+	},
 	.probe		= airport_attach,
 	.remove		= airport_detach,
 	.suspend	= airport_suspend,
diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index 18735b3..3ddb4dc 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -542,8 +542,11 @@ MODULE_DEVICE_TABLE (of, mac53c94_match);
 
 static struct macio_driver mac53c94_driver = 
 {
-	.name 		= "mac53c94",
-	.match_table	= mac53c94_match,
+	.driver = {
+		.name 		= "mac53c94",
+		.owner		= THIS_MODULE,
+		.of_match_table	= mac53c94_match,
+	},
 	.probe		= mac53c94_probe,
 	.remove		= mac53c94_remove,
 };
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index a1c97e8..1f784fd 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -2036,8 +2036,11 @@ MODULE_DEVICE_TABLE (of, mesh_match);
 
 static struct macio_driver mesh_driver = 
 {
-	.name 		= "mesh",
-	.match_table	= mesh_match,
+	.driver = {
+		.name 		= "mesh",
+		.owner		= THIS_MODULE,
+		.of_match_table	= mesh_match,
+	},
 	.probe		= mesh_probe,
 	.remove		= mesh_remove,
 	.shutdown	= mesh_shutdown,
diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
index cabbdc7..5b9cde7 100644
--- a/drivers/serial/pmac_zilog.c
+++ b/drivers/serial/pmac_zilog.c
@@ -2005,8 +2005,11 @@ static struct of_device_id pmz_match[] =
 MODULE_DEVICE_TABLE (of, pmz_match);
 
 static struct macio_driver pmz_driver = {
-	.name 		= "pmac_zilog",
-	.match_table	= pmz_match,
+	.driver = {
+		.name 		= "pmac_zilog",
+		.owner		= THIS_MODULE,
+		.of_match_table	= pmz_match,
+	},
 	.probe		= pmz_attach,
 	.remove		= pmz_detach,
 	.suspend	= pmz_suspend,
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 6789337..3ff8cc5 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -437,9 +437,11 @@ static int i2sbus_shutdown(struct macio_dev* dev)
 }
 
 static struct macio_driver i2sbus_drv = {
-	.name = "soundbus-i2s",
-	.owner = THIS_MODULE,
-	.match_table = i2sbus_match,
+	.driver = {
+		.name = "soundbus-i2s",
+		.owner = THIS_MODULE,
+		.of_match_table = i2sbus_match,
+	},
 	.probe = i2sbus_probe,
 	.remove = i2sbus_remove,
 #ifdef CONFIG_PM
