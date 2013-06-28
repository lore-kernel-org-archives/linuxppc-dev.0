Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78C292C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2013 05:30:58 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/7] rapidio/tsi721: convert to modular mport driver
Date: Fri, 28 Jun 2013 15:18:53 -0400
Message-Id: <1372447136-5751-5-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1372447136-5751-1-git-send-email-alexandre.bounine@idt.com>
References: <1372447136-5751-1-git-send-email-alexandre.bounine@idt.com>
Cc: Stef van Os <stef.van.os@Prodrive.nl>,
 Micha Nelissen <micha.nelissen@Prodrive.nl>,
 Andre van Herk <andre.van.herk@Prodrive.nl>,
 Alexandre Bounine <alexandre.bounine@idt.com>, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds an option to build device driver for Tsi721 PCIe-to-SRIO bridge
device as a kernel module.

Currently this module cannot be unloaded because the existing RapidIO subsystem
code does not support dynamic removal of local RapidIO controllers (TODO).

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Andre van Herk <andre.van.herk@Prodrive.nl>
Cc: Micha Nelissen <micha.nelissen@Prodrive.nl>
Cc: Stef van Os <stef.van.os@Prodrive.nl>
Cc: Jean Delvare <jdelvare@suse.de>
---
 drivers/rapidio/devices/Kconfig  |    2 +-
 drivers/rapidio/devices/Makefile |    7 +++----
 drivers/rapidio/devices/tsi721.c |    9 ++++-----
 drivers/rapidio/rio.c            |    1 +
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/rapidio/devices/Kconfig b/drivers/rapidio/devices/Kconfig
index 12a9d7f..c4cb087 100644
--- a/drivers/rapidio/devices/Kconfig
+++ b/drivers/rapidio/devices/Kconfig
@@ -3,7 +3,7 @@
 #
 
 config RAPIDIO_TSI721
-	bool "IDT Tsi721 PCI Express SRIO Controller support"
+	tristate "IDT Tsi721 PCI Express SRIO Controller support"
 	depends on RAPIDIO && PCIEPORTBUS
 	default "n"
 	---help---
diff --git a/drivers/rapidio/devices/Makefile b/drivers/rapidio/devices/Makefile
index 7b62860..9432c49 100644
--- a/drivers/rapidio/devices/Makefile
+++ b/drivers/rapidio/devices/Makefile
@@ -2,7 +2,6 @@
 # Makefile for RapidIO devices
 #
 
-obj-$(CONFIG_RAPIDIO_TSI721)	+= tsi721.o
-ifeq ($(CONFIG_RAPIDIO_DMA_ENGINE),y)
-obj-$(CONFIG_RAPIDIO_TSI721)	+= tsi721_dma.o
-endif
+obj-$(CONFIG_RAPIDIO_TSI721)	+= tsi721_mport.o
+tsi721_mport-y			:= tsi721.o
+tsi721_mport-$(CONFIG_RAPIDIO_DMA_ENGINE) += tsi721_dma.o
diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index a8b2c23..ff7cbf2 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2515,9 +2515,8 @@ static int __init tsi721_init(void)
 	return pci_register_driver(&tsi721_driver);
 }
 
-static void __exit tsi721_exit(void)
-{
-	pci_unregister_driver(&tsi721_driver);
-}
-
 device_initcall(tsi721_init);
+
+MODULE_DESCRIPTION("IDT Tsi721 PCIExpress-to-SRIO bridge driver");
+MODULE_AUTHOR("Integrated Device Technology, Inc.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index 5eb727c..2054b62 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -1911,6 +1911,7 @@ int rio_register_mport(struct rio_mport *port)
 	pr_debug("RIO: %s %s id=%d\n", __func__, port->name, port->id);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rio_register_mport);
 
 EXPORT_SYMBOL_GPL(rio_local_get_device_id);
 EXPORT_SYMBOL_GPL(rio_get_device);
-- 
1.7.8.4
