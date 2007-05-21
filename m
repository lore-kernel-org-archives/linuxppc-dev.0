Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8E961DDE27
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 00:12:51 +1000 (EST)
Date: Mon, 21 May 2007 14:54:26 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] set module owner in ps3 modules
Message-ID: <20070521125426.GA27730@aepfle.de>
References: <20070521125311.GA27626@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070521125311.GA27626@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

setting ->owner will help with refcounting (?) and it provides proper
symlinks in sysfs.


Signed-off-by: Olaf Hering <olaf@aepfle.de>


Index: linux-2.6.22-rc2/drivers/block/ps3disk.c
===================================================================
--- linux-2.6.22-rc2.orig/drivers/block/ps3disk.c
+++ linux-2.6.22-rc2/drivers/block/ps3disk.c
@@ -425,6 +411,7 @@ static int ps3disk_remove(struct ps3_sys
 static struct ps3_system_bus_driver ps3disk = {
 	.match_id	= PS3_MATCH_ID_STOR_DISK,
 	.core.name	= DEVICE_NAME,
+	.core.owner	= THIS_MODULE,
 	.probe		= ps3disk_probe,
 	.remove		= ps3disk_remove,
 	.shutdown	= ps3disk_remove,
Index: linux-2.6.22-rc2/drivers/char/ps3flash.c
===================================================================
--- linux-2.6.22-rc2.orig/drivers/char/ps3flash.c
+++ linux-2.6.22-rc2/drivers/char/ps3flash.c
@@ -467,6 +467,7 @@ static int ps3flash_remove(struct ps3_sy
 static struct ps3_system_bus_driver ps3flash = {
 	.match_id	= PS3_MATCH_ID_STOR_FLASH,
 	.core.name	= DEVICE_NAME,
+	.core.owner	= THIS_MODULE,
 	.probe		= ps3flash_probe,
 	.remove		= ps3flash_remove,
 	.shutdown	= ps3flash_remove,
Index: linux-2.6.22-rc2/drivers/net/gelic_net.c
===================================================================
--- linux-2.6.22-rc2.orig/drivers/net/gelic_net.c
+++ linux-2.6.22-rc2/drivers/net/gelic_net.c
@@ -1576,6 +1576,7 @@ static struct ps3_system_bus_driver ps3_
 	.shutdown = ps3_gelic_driver_remove,
 	.core = {
 		.name = "ps3_gelic_driver",
+		.owner = THIS_MODULE,
 	},
 };
 
Index: linux-2.6.22-rc2/drivers/scsi/ps3rom.c
===================================================================
--- linux-2.6.22-rc2.orig/drivers/scsi/ps3rom.c
+++ linux-2.6.22-rc2/drivers/scsi/ps3rom.c
@@ -907,6 +907,7 @@ static int ps3rom_remove(struct ps3_syst
 static struct ps3_system_bus_driver ps3rom = {
 	.match_id	= PS3_MATCH_ID_STOR_ROM,
 	.core.name	= DEVICE_NAME,
+	.core.owner	= THIS_MODULE,
 	.probe		= ps3rom_probe,
 	.remove		= ps3rom_remove
 };
Index: linux-2.6.22-rc2/drivers/usb/host/ehci-ps3.c
===================================================================
--- linux-2.6.22-rc2.orig/drivers/usb/host/ehci-ps3.c
+++ linux-2.6.22-rc2/drivers/usb/host/ehci-ps3.c
@@ -229,6 +229,7 @@ static struct ps3_system_bus_driver ps3_
 	.match_id = PS3_MATCH_ID_EHCI,
 	.core = {
 		.name = "ps3-ehci-driver",
+		.owner = THIS_MODULE,
 	},
 	.probe = ps3_ehci_probe,
 	.remove = ps3_ehci_remove,
Index: linux-2.6.22-rc2/drivers/usb/host/ohci-ps3.c
===================================================================
--- linux-2.6.22-rc2.orig/drivers/usb/host/ohci-ps3.c
+++ linux-2.6.22-rc2/drivers/usb/host/ohci-ps3.c
@@ -233,6 +233,7 @@ static struct ps3_system_bus_driver ps3_
 	.match_id = PS3_MATCH_ID_OHCI,
 	.core = {
 		.name = "ps3-ohci-driver",
+		.owner = THIS_MODULE,
 	},
 	.probe = ps3_ohci_probe,
 	.remove = ps3_ohci_remove,
Index: linux-2.6.22-rc2/sound/ppc/snd_ps3.c
===================================================================
--- linux-2.6.22-rc2.orig/sound/ppc/snd_ps3.c
+++ linux-2.6.22-rc2/sound/ppc/snd_ps3.c
@@ -1020,6 +1020,7 @@ static struct ps3_system_bus_driver snd_
 	.shutdown = snd_ps3_driver_remove,
 	.core = {
 		.name = SND_PS3_DRIVER_NAME,
+		.owner = THIS_MODULE,
 	},
 };
 
