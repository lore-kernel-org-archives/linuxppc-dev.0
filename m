Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401byh3H5qzDr8F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 02:59:55 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 44/47] tty: remove bfin_jtag_comm and hvc_bfin_jtag drivers
Date: Wed, 14 Mar 2018 16:35:57 +0100
Message-Id: <20180314153603.3127932-45-arnd@arndb.de>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The blackfin architecture is getting removed, so these drivers
are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/Kconfig             |  13 --
 drivers/tty/Makefile            |   1 -
 drivers/tty/bfin_jtag_comm.c    | 353 ----------------------------------------
 drivers/tty/hvc/Kconfig         |   9 -
 drivers/tty/hvc/Makefile        |   1 -
 drivers/tty/hvc/hvc_bfin_jtag.c | 104 ------------
 6 files changed, 481 deletions(-)
 delete mode 100644 drivers/tty/bfin_jtag_comm.c
 delete mode 100644 drivers/tty/hvc/hvc_bfin_jtag.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index b68e71751cc5..0840d27381ea 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -151,19 +151,6 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
-config BFIN_JTAG_COMM
-	tristate "Blackfin JTAG Communication"
-	depends on BLACKFIN
-	help
-	  Add support for emulating a TTY device over the Blackfin JTAG.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_jtag_comm.
-
-config BFIN_JTAG_COMM_CONSOLE
-	bool "Console on Blackfin JTAG"
-	depends on BFIN_JTAG_COMM=y
-
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
 	depends on HAS_IOMEM
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 47c71f43a397..c72cafdf32b4 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
 
 # tty drivers
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
-obj-$(CONFIG_BFIN_JTAG_COMM)	+= bfin_jtag_comm.o
 obj-$(CONFIG_CYCLADES)		+= cyclades.o
 obj-$(CONFIG_ISI)		+= isicom.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
diff --git a/drivers/tty/bfin_jtag_comm.c b/drivers/tty/bfin_jtag_comm.c
deleted file mode 100644
index c369bf27a67b..000000000000
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index fec457edad14..3bade5ad3d71 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -88,15 +88,6 @@ config HVC_DCC
 	 driver. This console is used through a JTAG only on ARM. If you don't have
 	 a JTAG then you probably don't want this option.
 
-config HVC_BFIN_JTAG
-	bool "Blackfin JTAG console"
-	depends on BLACKFIN
-	select HVC_DRIVER
-	help
-	 This console uses the Blackfin JTAG to create a console under the
-	 the HVC driver.  If you don't have JTAG, then you probably don't
-	 want this option.
-
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES && HVC_CONSOLE
diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index 0b02ec7f1dfd..b82f9f68cd23 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -10,5 +10,4 @@ obj-$(CONFIG_HVC_IRQ)		+= hvc_irq.o
 obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
 obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
-obj-$(CONFIG_HVC_BFIN_JTAG)	+= hvc_bfin_jtag.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
diff --git a/drivers/tty/hvc/hvc_bfin_jtag.c b/drivers/tty/hvc/hvc_bfin_jtag.c
deleted file mode 100644
index dd7cae4c195b..000000000000
-- 
2.9.0
