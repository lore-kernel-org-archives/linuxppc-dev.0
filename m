Date: Sun, 18 Jan 2004 13:28:22 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Greg Kroah-Hartman <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH 2.6] Hydra i2c
Message-ID: <Pine.LNX.4.58.0401181323130.653@callisto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The patch below adds support for the i2c interface on the Apple Hydra
Mac I/O, which is used in the CHRP LongTrail. It was tested using the
eeprom driver, which detected my 2 SDRAM DIMMs.

The patch is relative to 2.6.0 in the linuxppc-2.5 tree on December 22,
but it should apply fairly easy to any recent 2.6 tree.

--- linux-ppc-2.6.0/drivers/i2c/busses/i2c-hydra.c.orig	2003-12-21 12:47:29.000000000 +0100
+++ linux-ppc-2.6.0/drivers/i2c/busses/i2c-hydra.c	2004-01-18 12:28:39.000000000 +0100
@@ -0,0 +1,175 @@
+/*
+    i2c-hydra.c - Part of lm_sensors,  Linux kernel modules
+                  for hardware monitoring
+
+    i2c Support for the Apple `Hydra' Mac I/O
+
+    Copyright (c) 1999-2004 Geert Uytterhoeven <geert@linux-m68k.org>
+
+    Based on i2c Support for Via Technologies 82C586B South Bridge
+    Copyright (c) 1998, 1999 Kyösti Mälkki <kmalkki@cc.hut.fi>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/system.h>
+
+MODULE_LICENSE("GPL");
+
+
+#define HYDRA_CACHE_PD	0x00000030
+
+#define HYDRA_CPD_PD0	0x00000001	/* CachePD lines */
+#define HYDRA_CPD_PD1	0x00000002
+#define HYDRA_CPD_PD2	0x00000004
+#define HYDRA_CPD_PD3	0x00000008
+
+#define HYDRA_SCLK	HYDRA_CPD_PD0
+#define HYDRA_SDAT	HYDRA_CPD_PD1
+#define HYDRA_SCLK_OE	0x00000010
+#define HYDRA_SDAT_OE	0x00000020
+
+static inline void pdregw(void *hydra_base, u32 val)
+{
+	writel(val, (unsigned long)hydra_base + HYDRA_CACHE_PD);
+}
+
+static inline u32 pdregr(void *hydra_base)
+{
+	u32 val = readl((unsigned long)hydra_base + HYDRA_CACHE_PD);
+	return val;
+}
+
+static void hydra_bit_setscl(void *hydra_base, int state)
+{
+	u32 val = pdregr(hydra_base);
+	if (state)
+		val &= ~HYDRA_SCLK_OE;
+	else {
+		val &= ~HYDRA_SCLK;
+		val |= HYDRA_SCLK_OE;
+	}
+	pdregw(hydra_base, val);
+	pdregr(hydra_base);	/* flush posted write */
+}
+
+static void hydra_bit_setsda(void *hydra_base, int state)
+{
+	u32 val = pdregr(hydra_base);
+	if (state)
+		val &= ~HYDRA_SDAT_OE;
+	else {
+		val &= ~HYDRA_SDAT;
+		val |= HYDRA_SDAT_OE;
+	}
+	pdregw(hydra_base, val);
+	pdregr(hydra_base);	/* flush posted write */
+}
+
+static int hydra_bit_getscl(void *hydra_base)
+{
+	return (pdregr(hydra_base) & HYDRA_SCLK) != 0;
+}
+
+static int hydra_bit_getsda(void *hydra_base)
+{
+	return (pdregr(hydra_base) & HYDRA_SDAT) != 0;
+}
+
+/* ------------------------------------------------------------------------ */
+
+static struct i2c_algo_bit_data hydra_bit_data = {
+	.setsda		= hydra_bit_setsda,
+	.setscl		= hydra_bit_setscl,
+	.getsda		= hydra_bit_getsda,
+	.getscl		= hydra_bit_getscl,
+	.udelay		= 5,
+	.mdelay		= 5,
+	.timeout	= HZ
+};
+
+static struct i2c_adapter hydra_adap = {
+	.owner		= THIS_MODULE,
+	.name		= "Hydra i2c",
+	.id		= I2C_HW_B_HYDRA,
+	.algo_data	= &hydra_bit_data,
+};
+
+static struct pci_device_id hydra_ids[] = {
+	{
+		.vendor		= PCI_VENDOR_ID_APPLE,
+		.device		= PCI_DEVICE_ID_APPLE_HYDRA,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{ 0, }
+};
+
+static int __devinit hydra_probe(struct pci_dev *dev,
+				 const struct pci_device_id *id)
+{
+	unsigned int base_addr;
+
+	base_addr = dev->resource[0].start;
+	hydra_bit_data.data = ioremap(base_addr, 0x100);
+
+	pdregw(hydra_bit_data.data, 0);		/* clear SCLK_OE and SDAT_OE */
+	hydra_adap.dev.parent = &dev->dev;
+	return i2c_bit_add_bus(&hydra_adap);
+}
+
+static void __devexit hydra_remove(struct pci_dev *dev)
+{
+	pdregw(hydra_bit_data.data, 0);	/* clear SCLK_OE and SDAT_OE */
+	i2c_bit_del_bus(&hydra_adap);
+}
+
+
+static struct pci_driver hydra_driver = {
+	.name		= "hydra smbus",
+	.id_table	= hydra_ids,
+	.probe		= hydra_probe,
+	.remove		= __devexit_p(hydra_remove),
+};
+
+static int __init i2c_hydra_init(void)
+{
+	return pci_module_init(&hydra_driver);
+}
+
+
+static void __exit i2c_hydra_exit(void)
+{
+	pci_unregister_driver(&hydra_driver);
+	iounmap(hydra_bit_data.data);
+}
+
+
+
+MODULE_AUTHOR("Geert Uytterhoeven <geert@linux-m68k.org>");
+MODULE_DESCRIPTION("i2c for Apple Hydra Mac I/O");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_hydra_init);
+module_exit(i2c_hydra_exit);
+
--- linux-ppc-2.6.0/drivers/i2c/busses/Makefile.orig	2003-12-18 10:18:52.000000000 +0100
+++ linux-ppc-2.6.0/drivers/i2c/busses/Makefile	2004-01-18 12:31:40.000000000 +0100
@@ -8,6 +8,7 @@
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
+obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
--- linux-ppc-2.6.0/drivers/i2c/busses/Kconfig.orig	2003-12-18 10:21:05.000000000 +0100
+++ linux-ppc-2.6.0/drivers/i2c/busses/Kconfig	2004-01-18 12:33:30.000000000 +0100
@@ -66,6 +66,17 @@
 	  This support is also available as a module.  If so, the module
 	  will be called i2c-elv.

+config I2C_HYDRA
+	tristate "CHRP Apple Hydra Mac I/O I2C interface"
+	depends on I2C_ALGOBIT && PCI && PPC_CHRP && EXPERIMENTAL
+	help
+	  This supports the use of the I2C interface in the Apple Hydra Mac
+	  I/O chip on some CHRP machines (e.g. the LongTrail).  Say Y if you
+	  have such a machine.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-hydra.
+
 config I2C_I801
 	tristate "Intel 801"
 	depends on I2C && PCI && EXPERIMENTAL

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
