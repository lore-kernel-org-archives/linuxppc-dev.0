Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 8EFB8DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 10:05:57 +1100 (EST)
Date: Fri, 24 Oct 2008 01:05:56 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>,
	Michael Weiser <michael@weiser.dinsnail.net>
Subject: [PATCH] fix i2c on PPC linkstation / kurobox machines
In-Reply-To: <20081023213309.GA19777@weiser.dinsnail.net>
Message-ID: <Pine.LNX.4.64.0810240059170.9657@axis700.grange>
References: <20081022191650.GA11406@weiser.dinsnail.net>
	<Pine.LNX.4.64.0810232029380.9657@axis700.grange>
	<20081023213309.GA19777@weiser.dinsnail.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?UTF-8?B?Um9nw6lyaW8gQnJpdG8=?= <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

i2c is broken on linkstation / kurobox machines since at least 2.6.27. Fix 
it. Also remove CONFIG_SERIAL_OF_PLATFORM, which, if enabled, breaks the 
serial console after the "console handover: boot [udbg0] -> real [ttyS1]" 
message.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

---

No, I do not really understand why I have to remove 
CONFIG_SERIAL_OF_PLATFORM now after adding a call to 
of_platform_bus_probe(), but it works this way. It must have something to 
do with the legacy serial driver... If accepted in this form, I'll also 
forward it to stable.

diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index 6fc4c21..d0846ec 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27-rc4
-# Thu Aug 21 00:52:05 2008
+# Linux kernel version: 2.6.27
+# Fri Oct 24 00:42:39 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -934,7 +934,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
-CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -1211,7 +1211,6 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_ALAUDA is not set
 # CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
-# CONFIG_USB_STORAGE_SIERRA is not set
 # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
 # CONFIG_USB_LIBUSUAL is not set
 
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index eb5d74e..2ca7be6 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/initrd.h>
 #include <linux/mtd/physmap.h>
+#include <linux/of_platform.h>
 
 #include <asm/time.h>
 #include <asm/prom.h>
@@ -54,6 +55,19 @@ static struct mtd_partition linkstation_physmap_partitions[] = {
 	},
 };
 
+static __initdata struct of_device_id of_bus_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	return 0;
+}
+machine_device_initcall(linkstation, declare_of_platform_devices);
+
 static int __init linkstation_add_bridge(struct device_node *dev)
 {
 #ifdef CONFIG_PCI
