Return-Path: <timur@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id CA5F0B70AE
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 02:24:13 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, linux-watchdog@vger.kernel.org, jwboyer@gmail.com
Subject: [PATCH 2/2] [v2] powerpc/watchdog: allow the e500 watchdog driver to
	be compiled as a module
Date: Mon, 20 Sep 2010 11:23:42 -0500
Message-ID: <1284999822-24753-2-git-send-email-timur@freescale.com>
In-Reply-To: <1284999822-24753-1-git-send-email-timur@freescale.com>
References: <1284999822-24753-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register the __init and __exit functions in the PowerPC e500 watchdog driver
as module entry/exit functions, and modify the Kconfig entry.

Add a .release method for the PowerPC e500 watchdog driver, so that the
watchdog is disabled when the driver is closed.

Loosely based on original code from Jiang Yutang <b14898@freescale.com>.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch requires:

	powerpc: export ppc_proc_freq and ppc_tb_freq as GPL symbols

 drivers/watchdog/Kconfig     |    5 ++++-
 drivers/watchdog/booke_wdt.c |   39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 24efd8e..a6812eb 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -957,9 +957,12 @@ config PIKA_WDT
 	  the Warp platform.
 
 config BOOKE_WDT
-	bool "PowerPC Book-E Watchdog Timer"
+	tristate "PowerPC Book-E Watchdog Timer"
 	depends on BOOKE || 4xx
 	---help---
+	  Watchdog driver for PowerPC Book-E chips, such as the Freescale
+	  MPC85xx SOCs and the IBM PowerPC 440.
+
 	  Please see Documentation/watchdog/watchdog-api.txt for
 	  more information.
 
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 3d49671..a989998 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -4,7 +4,7 @@
  * Author: Matthew McClintock
  * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
- * Copyright 2005, 2008 Freescale Semiconductor Inc.
+ * Copyright 2005, 2008, 2010 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -114,6 +114,27 @@ static void __booke_wdt_enable(void *data)
 	mtspr(SPRN_TCR, val);
 }
 
+/**
+ * booke_wdt_disable - disable the watchdog on the given CPU
+ *
+ * This function is called on each CPU.  It disables the watchdog on that CPU.
+ *
+ * TCR[WRC] cannot be changed once it has been set to non-zero, but we can
+ * effectively disable the watchdog by setting its period to the maximum value.
+ */
+static void __booke_wdt_disable(void *data)
+{
+	u32 val;
+
+	val = mfspr(SPRN_TCR);
+	val &= ~(TCR_WIE | WDTP_MASK);
+	mtspr(SPRN_TCR, val);
+
+	/* clear status to make sure nothing is pending */
+	__booke_wdt_ping(NULL);
+
+}
+
 static ssize_t booke_wdt_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -193,12 +214,21 @@ static int booke_wdt_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
+static int booke_wdt_release(struct inode *inode, struct file *file)
+{
+	on_each_cpu(__booke_wdt_disable, NULL, 0);
+	booke_wdt_enabled = 0;
+
+	return 0;
+}
+
 static const struct file_operations booke_wdt_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.write = booke_wdt_write,
 	.unlocked_ioctl = booke_wdt_ioctl,
 	.open = booke_wdt_open,
+	.release = booke_wdt_release,
 };
 
 static struct miscdevice booke_wdt_miscdev = {
@@ -237,4 +267,9 @@ static int __init booke_wdt_init(void)
 
 	return ret;
 }
-device_initcall(booke_wdt_init);
+
+module_init(booke_wdt_init);
+module_exit(booke_wdt_exit);
+
+MODULE_DESCRIPTION("PowerPC Book-E watchdog driver");
+MODULE_LICENSE("GPL");
-- 
1.7.2.3
