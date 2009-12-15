Return-Path: <vitb@kernel.crashing.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id F3C68B6F0E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 10:51:54 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D7E4A1C00116
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 00:44:32 +0100 (CET)
Received: from vitb-lp.localdomain (unknown [89.169.232.222])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 3B0F69025C
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 00:44:32 +0100 (CET)
Received: from vitb-lp (vitb-lp [127.0.0.1])
	by vitb-lp.localdomain (Postfix) with ESMTP id E33FC14109
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 02:47:33 +0300 (MSK)
Date: Wed, 16 Dec 2009 02:47:30 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org <linuxppc-dev@ozlabs.org>
Subject: [POWERPC] add U-Boot bootcount driver.
Message-ID: <20091216024730.455b90fd@vitb-lp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


From: Heiko Schocher <hs@denx.de>

This driver provides (read/write) access to the
U-Boot bootcounter via PROC FS or sysFS.

in u-boot, it uses a 8 byte mem area (it must hold the value over a
soft reset of course), for storing a bootcounter (it counts many soft
resets are done, on hard reset it starts with 0). If the bootcountvalue
exceeds the value in the env variable "bootlimit", and alternative
bootcmd stored in the env variable "altbootcmd" is run.

The bootcountregister gets configured via DTS.
for example on the mgsuvd board:

bootcount@0x3eb0 {
                  device_type = "bootcount";
                  compatible = "uboot,bootcount";
                  reg = <0x3eb0 0x08>;
                 };

This driver is tested on the mgcoge(82xx) and mgsuvd(8xx) board.

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Signed-off-by: Vitaly Bordyug <vitb@kernel.crashing.org>
---
I think there is no reason not to have this in mainline. Thoughts? And
I'm not sure what is right direction to push this - it's representation
of u-boot feature in fact, pretty useful tho.


 arch/powerpc/boot/dts/mgcoge.dts      |    6 +
 arch/powerpc/boot/dts/mgsuvd.dts      |    6 +
 arch/powerpc/configs/mgsuvd_defconfig |    1 
 drivers/char/Kconfig                  |    6 +
 drivers/char/Makefile                 |    1 
 drivers/char/bootcount.c              |  222
 +++++++++++++++++++++++++++++++++ 6 files changed, 242 insertions(+),
 0 deletions(-) create mode 100644 drivers/char/bootcount.c


diff --git a/arch/powerpc/boot/dts/mgcoge.dts
b/arch/powerpc/boot/dts/mgcoge.dts index 0ce9664..7136fee 100644
--- a/arch/powerpc/boot/dts/mgcoge.dts
+++ b/arch/powerpc/boot/dts/mgcoge.dts
@@ -215,6 +215,12 @@
 				linux,network-index = <2>;
 				fsl,cpm-command = <0x16200300>;
 			};
+
+			bootcount@0x80f4 {
+				device_type = "bootcount";
+				compatible = "uboot,bootcount";
+				reg = <0x80f4 0x08>;
+			};
 		};
 
 		PIC: interrupt-controller@10c00 {
diff --git a/arch/powerpc/boot/dts/mgsuvd.dts
b/arch/powerpc/boot/dts/mgsuvd.dts index e4fc53a..59216a7 100644
--- a/arch/powerpc/boot/dts/mgsuvd.dts
+++ b/arch/powerpc/boot/dts/mgsuvd.dts
@@ -158,6 +158,12 @@
 				fsl,cpm-command = <0x80>;
 				fixed-link = <0 0 10 0 0>;
 			};
+
+			bootcount@0x3eb0 {
+				device_type = "bootcount";
+				compatible = "uboot,bootcount";
+				reg = <0x3eb0 0x08>;
+			};
 		};
 	};
 };
diff --git a/arch/powerpc/configs/mgsuvd_defconfig
b/arch/powerpc/configs/mgsuvd_defconfig index 43c3c4f..298ced6 100644
--- a/arch/powerpc/configs/mgsuvd_defconfig
+++ b/arch/powerpc/configs/mgsuvd_defconfig
@@ -626,6 +626,7 @@ CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
+CONFIG_BOOTCOUNT=y
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 6aad99e..5fe2d6c 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -1049,6 +1049,12 @@ config MAX_RAW_DEVS
 	  Default is 256. Increase this number in case you need lots of
 	  raw devices.
 
+config BOOTCOUNT
+	tristate "UBoot Bootcount driver"
+	depends on PPC
+	help
+	  The UBoot Bootcount driver ...
+
 config HPET
 	bool "HPET - High Precision Event Timer" if (X86 || IA64)
 	default n
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 19a79dd..e3e2b1a 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_NSC_GPIO)		+= nsc_gpio.o
 obj-$(CONFIG_CS5535_GPIO)	+= cs5535_gpio.o
 obj-$(CONFIG_GPIO_TB0219)	+= tb0219.o
 obj-$(CONFIG_TELCLOCK)		+= tlclk.o
+obj-$(CONFIG_BOOTCOUNT)		+= bootcount.o
 
 obj-$(CONFIG_MWAVE)		+= mwave/
 obj-$(CONFIG_AGP)		+= agp/
diff --git a/drivers/char/bootcount.c b/drivers/char/bootcount.c
new file mode 100644
index 0000000..62fcabd
--- /dev/null
+++ b/drivers/char/bootcount.c
@@ -0,0 +1,222 @@
+/*
+ * This driver gives access(read/write) to the bootcounter used by
u-boot.
+ * Access is supported via procFS and sysFS.
+ *
+ * Copyright 2008 DENX Software Engineering GmbH
+ * Author: Heiko Schocher <hs@denx.de>
+ * Based on work from: Steffen Rumler  (Steffen.Rumler@siemens.com)
+ *
+ * This program is free software; you can redistribute  it and/or
modify it
+ * under  the terms of  the GNU General  Public License as published
by the
+ * Free Software Foundation;  either version 2 of the  License, or (at
your
+ * option) any later version.
+ */
+
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/init.h>
+#include <linux/capability.h>
+#include <linux/ptrace.h>
+#include <linux/device.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#include <linux/of_platform.h>
+
+#ifndef CONFIG_PROC_FS
+#error "PROC FS support must be switched-on"
+#endif
+
+
+#define	UBOOT_BOOTCOUNT_MAGIC_OFFSET	0x04	/*
offset of magic number */ +#define
UBOOT_BOOTCOUNT_MAGIC		0xB001C041	/* magic number
value */ + +#define
UBOOT_BOOTCOUNT_PROC_ENTRY	"driver/bootcount"	/* PROC FS
entry under '/proc' */ + +/*
+ * This macro frees the machine specific function from bounds checking
and
+ * this like that... 
+ */
+#define PRINT_PROC(fmt,args...) \
+	do { \
+		*len += sprintf( buffer+*len, fmt, ##args ); \
+		if (*begin + *len > offset + size) \
+			return( 0 ); \
+		if (*begin + *len < offset) { \
+			*begin += *len; \
+			*len = 0; \
+		} \
+	} while(0)
+
+void __iomem *mem = NULL;
+/*
+ * read U-Boot bootcounter
+ */
+static int
+read_bootcounter_info(char *buffer, int *len, off_t * begin, off_t
offset,
+		       int size)
+{
+	unsigned long magic;
+	unsigned long counter;
+
+
+	magic = *((unsigned long *) (mem +
UBOOT_BOOTCOUNT_MAGIC_OFFSET));
+	counter = *((unsigned long *) (mem));
+
+	if (magic == UBOOT_BOOTCOUNT_MAGIC) {
+		PRINT_PROC ("%lu\n", counter);
+	} else {
+		PRINT_PROC ("bad magic: 0x%lu != 0x%lu\n", magic,
+			    (unsigned long)UBOOT_BOOTCOUNT_MAGIC);
+	}
+
+	return 1;
+}
+
+/*
+ * read U-Boot bootcounter (wrapper)
+ */
+static int
+read_bootcounter(char *buffer, char **start, off_t offset, int size,
+		  int *eof, void *arg)
+{
+	int len = 0;
+	off_t begin = 0;
+
+
+	*eof = read_bootcounter_info(buffer, &len, &begin, offset,
size); +
+	if (offset >= begin + len)
+		return 0;
+
+	*start = buffer + (offset - begin);
+	return size < begin + len - offset ? size : begin + len -
offset; +}
+
+/*
+ * write new value to U-Boot bootcounter
+ */
+static int
+write_bootcounter(struct file *file, const char *buffer, unsigned long
count,
+		   void *data)
+{
+	unsigned long magic;
+	unsigned long *counter_ptr;
+
+
+	magic = *((unsigned long *) (mem +
UBOOT_BOOTCOUNT_MAGIC_OFFSET));
+	counter_ptr = (unsigned long *) (mem);
+
+	if (magic == UBOOT_BOOTCOUNT_MAGIC)
+		*counter_ptr = simple_strtol(buffer, NULL, 10);
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+/* helper for the sysFS */
+static int show_str_bootcount(struct device *device,
+				struct device_attribute *attr,
+				char *buf)
+{
+	int ret = 0;
+	off_t begin = 0;
+
+	read_bootcounter_info(buf, &ret, &begin, 0, 20);
+        return ret;
+}
+static int store_str_bootcount(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf,
+			size_t count)
+{
+	write_bootcounter(NULL, buf, count, NULL);
+	return count;
+}
+static DEVICE_ATTR(bootcount, S_IWUSR | S_IRUGO, show_str_bootcount,
store_str_bootcount); +
+static int __devinit bootcount_probe(struct of_device *ofdev,
+                                        const struct of_device_id
*match) +{
+	struct device_node *np = NULL;
+	struct proc_dir_entry *bootcount;
+
+	printk("%s (%d) %s:  ", __FILE__, __LINE__, __FUNCTION__);
+	np = of_find_node_by_type(np, "bootcount");
+	if (!np) {
+		printk("%s no node, trying compatible node\n",
__FUNCTION__);
+		np =  of_find_compatible_node(NULL, NULL,
"uboot,bootcount");
+		if (!np) {
+			printk("%s no node\n", __FUNCTION__);
+			return -ENODEV;
+		}
+	}
+	mem = of_iomap(np, 0);
+	if (mem == NULL) {
+		printk("%s couldnt map register.\n", __FUNCTION__);
+	}
+
+	/* init ProcFS */
+	if ((bootcount =
+	     create_proc_entry(UBOOT_BOOTCOUNT_PROC_ENTRY, 0600,
+				NULL)) == NULL) {
+
+		printk(KERN_ERR "\n%s (%d): cannot create /proc/%s\n",
+			__FILE__, __LINE__,
UBOOT_BOOTCOUNT_PROC_ENTRY);
+	} else {
+
+		bootcount->read_proc = read_bootcounter;
+		bootcount->write_proc = write_bootcounter;
+		printk("created \"/proc/%s\"\n",
UBOOT_BOOTCOUNT_PROC_ENTRY);
+	}
+
+	if (device_create_file(&ofdev->dev, &dev_attr_bootcount))
+		printk("%s couldnt register sysFS entry.\n",
__FUNCTION__); +
+        return 0;
+}
+
+static int bootcount_remove(struct of_device *ofdev)
+{
+        BUG();
+        return 0;
+}
+
+static const struct of_device_id bootcount_match[] = {
+        {
+                .compatible = "uboot,bootcount",
+        },
+        {},
+};
+
+static struct of_platform_driver bootcount_driver = {
+        .driver = {
+                .name = "bootcount",
+        },
+        .match_table = bootcount_match,
+        .probe = bootcount_probe,
+        .remove = bootcount_remove,
+};
+
+
+static int __init uboot_bootcount_init(void)
+{
+	of_register_platform_driver(&bootcount_driver);
+	return 0;
+}
+
+static void __exit uboot_bootcount_cleanup(void)
+{
+	if (mem != NULL)
+		iounmap(mem);
+	remove_proc_entry(UBOOT_BOOTCOUNT_PROC_ENTRY, NULL);
+}
+
+module_init(uboot_bootcount_init);
+module_exit(uboot_bootcount_cleanup);
+
+MODULE_LICENSE ("GPL");
+MODULE_AUTHOR ("Steffen Rumler <steffen.rumler@siemens.com>");
+MODULE_DESCRIPTION ("Provide (read/write) access to the U-Boot
bootcounter via PROC FS");
