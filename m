From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 21 Jun 2004 14:39:48 -0700
To: linuxppc-embedded@lists.linuxppc.org
Subject: 2.6 networking support for Redwood[56]
Message-ID: <20040621213948.GA8849@zenos.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm adding network support for the IBM Redwood5 and Redwood6 in 2.6.

It looks like the best supported driver for the smc91111 chip
is used by the ARM folks and is found in drivers/net/arm/smc91x.[ch]
This driver recently went into the linux-2.5 tree.

I moved these two files into drivers/net so they are available for
PPC as well as ARM and added some Redwood-specific support.  That
was straightforward.  This driver calls a couple of ARM-specific
functions platform_get_resource() and platform_get_irq().  ARM
implements these functions in arch/arm/common/platform.c.  I
copied arch/arm/common/platform.c into arch/ppc/syslib/platform.c
which works fine, but I don't care for duplicated code.  Maybe a
better approach would be to add these functions to drivers/base/platform.c

Comments?  Suggestions on how to go about getting this into linux-2.5?

Thanks,
-Dale Farnsworth

Do "mv drivers/net/arm/smc91x.[ch] drivers/net" before applying
the following patch.

===== drivers/net/smc91x.h 1.2 vs edited =====
--- 1.2/drivers/net/smc91x.h	2004-06-21 10:16:40 -07:00
+++ edited/drivers/net/smc91x.h	2004-06-21 10:26:08 -07:00
@@ -59,6 +59,43 @@
 #define SMC_insw(a, r, p, l)	readsw((a) + (r), p, l)
 #define SMC_outsw(a, r, p, l)	writesw((a) + (r), p, l)

+#elif defined(CONFIG_REDWOOD_5) || defined(CONFIG_REDWOOD_6)
+
+/* We can only do 16-bit reads and writes in the static memory space. */
+#define SMC_CAN_USE_8BIT	0
+#define SMC_CAN_USE_16BIT	1
+#define SMC_CAN_USE_32BIT	0
+#define SMC_NOWAIT		1
+
+#define SMC_IO_SHIFT		0
+
+#define SMC_inw(a, r)		in_be16((volatile u16 *)((a) + (r)))
+#define SMC_outw(v, a, r)	out_be16((volatile u16 *)((a) + (r)), v)
+#define SMC_insw(a, r, p, l) 						\
+	do {								\
+		unsigned long __port = (a) + (r);			\
+		u16 *__p = (u16 *)(p);				\
+		int __l = (l);						\
+		insw(__port, __p, __l);					\
+		while (__l > 0) {					\
+			*__p = swab16(*__p);				\
+			__p++;						\
+			__l--;						\
+		}							\
+	} while (0)
+#define SMC_outsw(a, r, p, l) 						\
+	do {								\
+		unsigned long __port = (a) + (r);			\
+		u16 *__p = (u16 *)(p);				\
+		int __l = (l);						\
+		while (__l > 0) {					\
+			/* Believe it or not, the swab isn't needed. */	\
+			outw( /* swab16 */ (*__p++), __port);		\
+			__l--;						\
+		}							\
+	} while (0)
+#define set_irq_type(irq, type)
+
 #elif defined(CONFIG_SA1100_ASSABET)

diff -Nru a/arch/ppc/platforms/4xx/redwood5.c b/arch/ppc/platforms/4xx/redwood5.c
--- a/arch/ppc/platforms/4xx/redwood5.c	2004-06-21 13:52:45 -07:00
+++ b/arch/ppc/platforms/4xx/redwood5.c	2004-06-21 13:52:45 -07:00
@@ -14,8 +14,41 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
+#include <syslib/platform.h>
+
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start	= SMC91111_BASE_ADDR,
+		.end	= SMC91111_BASE_ADDR + SMC91111_REG_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= SMC91111_IRQ,
+		.end	= SMC91111_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(smc91x_resources),
+	.resource	= smc91x_resources,
+};
+
+static struct platform_device *redwood5_devs[] __initdata = {
+	&smc91x_device,
+};
+
+static int __init
+redwood5_platform_add_devices(void)
+{
+	return platform_add_devices(redwood5_devs, ARRAY_SIZE(redwood5_devs));
+}

 void __init
 redwood5_setup_arch(void)
@@ -44,7 +77,7 @@

 	printk("\n");
 #endif
-
+	device_initcall(redwood5_platform_add_devices);
 }

 void __init
diff -Nru a/arch/ppc/platforms/4xx/redwood5.h b/arch/ppc/platforms/4xx/redwood5.h
--- a/arch/ppc/platforms/4xx/redwood5.h	2004-06-21 13:52:45 -07:00
+++ b/arch/ppc/platforms/4xx/redwood5.h	2004-06-21 13:52:45 -07:00
@@ -34,6 +34,7 @@


 #define SMC91111_BASE_ADDR	0xf2000300
+#define SMC91111_REG_SIZE	16
 #define SMC91111_IRQ		28

 #ifdef MAX_HWIFS
diff -Nru a/arch/ppc/platforms/4xx/redwood6.c b/arch/ppc/platforms/4xx/redwood6.c
--- a/arch/ppc/platforms/4xx/redwood6.c	2004-06-21 13:52:45 -07:00
+++ b/arch/ppc/platforms/4xx/redwood6.c	2004-06-21 13:52:45 -07:00
@@ -12,10 +12,13 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
 #include <asm/io.h>
 #include <asm/ppc4xx_pic.h>
 #include <linux/delay.h>
 #include <asm/machdep.h>
+#include <syslib/platform.h>


 /*
@@ -57,6 +60,36 @@
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 31: Ext Int 6 */
 };

+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start	= SMC91111_BASE_ADDR,
+		.end	= SMC91111_BASE_ADDR + SMC91111_REG_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= SMC91111_IRQ,
+		.end	= SMC91111_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(smc91x_resources),
+	.resource	= smc91x_resources,
+};
+
+static struct platform_device *redwood6_devs[] __initdata = {
+	&smc91x_device,
+};
+
+static int __init
+redwood6_platform_add_devices(void)
+{
+	return platform_add_devices(redwood6_devs, ARRAY_SIZE(redwood6_devs));
+}
+

 void __init
 redwood6_setup_arch(void)
@@ -119,6 +152,8 @@
 	printk(KERN_INFO "IBM Redwood6 (STBx25XX) Platform\n");
 	printk(KERN_INFO
 	       "Port by MontaVista Software, Inc. (source@mvista.com)\n");
+
+	device_initcall(redwood6_platform_add_devices);
 }

 void __init
diff -Nru a/arch/ppc/platforms/4xx/redwood6.h b/arch/ppc/platforms/4xx/redwood6.h
--- a/arch/ppc/platforms/4xx/redwood6.h	2004-06-21 13:52:45 -07:00
+++ b/arch/ppc/platforms/4xx/redwood6.h	2004-06-21 13:52:45 -07:00
@@ -33,6 +33,7 @@
 #endif				/* !__ASSEMBLY__ */

 #define SMC91111_BASE_ADDR	0xf2030300
+#define SMC91111_REG_SIZE	16
 #define SMC91111_IRQ		27
 #define IDE_XLINUX_MUX_BASE        0xf2040000
 #define IDE_DMA_ADDR	0xfce00000
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2004-06-21 13:52:45 -07:00
+++ b/arch/ppc/syslib/Makefile	2004-06-21 13:52:45 -07:00
@@ -65,6 +65,8 @@
 					hawk_common.o
 obj-$(CONFIG_HARRIER)		+= harrier.o
 obj-$(CONFIG_PRPMC800)		+= open_pic.o indirect_pci.o pci_auto.o
+obj-$(CONFIG_REDWOOD_5)		+= platform.o
+obj-$(CONFIG_REDWOOD_6)		+= platform.o
 obj-$(CONFIG_SANDPOINT)		+= i8259.o open_pic.o pci_auto.o todc_time.o
 obj-$(CONFIG_SBC82xx)		+= todc_time.o
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
diff -Nru a/arch/ppc/syslib/platform.c b/arch/ppc/syslib/platform.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/platform.c	2004-06-21 13:52:45 -07:00
@@ -0,0 +1,64 @@
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/init.h>
+
+struct resource * platform_get_resource(struct platform_device *dev,
+					unsigned int type, unsigned int num)
+{
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if ((r->flags & (IORESOURCE_IO|IORESOURCE_MEM|IORESOURCE_IRQ))
+		    == type)
+			if (num-- == 0)
+				return r;
+	}
+	return NULL;
+}
+
+int platform_get_irq(struct platform_device *dev, unsigned int num)
+{
+	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
+
+	return r ? r->start : -1;
+}
+
+int __init platform_add_device(struct platform_device *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct resource *r = &dev->resource[i];
+
+		r->name = dev->dev.bus_id;
+
+		if (r->flags & IORESOURCE_MEM &&
+		    request_resource(&iomem_resource, r)) {
+			printk(KERN_ERR
+			       "%s%d: failed to claim resource %d\n",
+			       dev->name, dev->id, i);
+			break;
+		}
+	}
+	if (i == dev->num_resources)
+		platform_device_register(dev);
+	return 0;
+}
+
+int __init platform_add_devices(struct platform_device **devs, int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		platform_add_device(devs[i]);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(platform_get_resource);
+EXPORT_SYMBOL(platform_get_irq);
+EXPORT_SYMBOL(platform_add_device);
+EXPORT_SYMBOL(platform_add_devices);
diff -Nru a/arch/ppc/syslib/platform.h b/arch/ppc/syslib/platform.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/platform.h	2004-06-21 13:52:45 -07:00
@@ -0,0 +1,18 @@
+/*
+ * linux/arch/ppc/syslib/platform.h
+ */
+
+#ifndef __SYSLIB_PLATFORM_H
+#define __SYSLIB_PLATFORM_H
+
+
+struct platform_device;
+struct resource;
+
+extern struct resource * platform_get_resource(struct platform_device *dev,
+			unsigned int type, unsigned int num);
+extern int platform_get_irq(struct platform_device *dev, unsigned int num);
+extern int platform_add_devices(struct platform_device **, int);
+extern int platform_add_device(struct platform_device *);
+
+#endif
diff -Nru a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2004-06-21 13:52:45 -07:00
+++ b/drivers/net/Kconfig	2004-06-21 13:52:45 -07:00
@@ -813,6 +813,24 @@
 	  <file:Documentation/networking/net-modules.txt>. The module
 	  will be called smc-ultra32.

+config SMC91X
+	tristate "SMC 91C9x/91C1xxx support"
+	select CRC32
+	select MII
+	depends on NET_ETHERNET && (ARM || REDWOOD_5 || REDWOOD_6)
+	help
+	  This is a driver for SMC's 91x series of Ethernet chipsets,
+	  including the SMC91C94 and the SMC91C111. Say Y if you want it
+	  compiled into the kernel, and read the file
+	  <file:Documentation/networking/smc9.txt>  and the Ethernet-HOWTO,
+	  available from  <http://www.linuxdoc.org/docs.html#howto>.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called smc91x.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt> as well
+	  as <file:Documentation/networking/net-modules.txt>.
+
 config SMC9194
 	tristate "SMC 9194 support"
 	depends on NET_VENDOR_SMC && (ISA || MAC && BROKEN)
diff -Nru a/drivers/net/Makefile b/drivers/net/Makefile
--- a/drivers/net/Makefile	2004-06-21 13:52:45 -07:00
+++ b/drivers/net/Makefile	2004-06-21 13:52:45 -07:00
@@ -175,6 +175,7 @@
 obj-$(CONFIG_AMD8111_ETH) += amd8111e.o
 obj-$(CONFIG_IBMVETH) += ibmveth.o
 obj-$(CONFIG_S2IO) += s2io.o
+obj-$(CONFIG_SMC91X) += smc91x.o

 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_NET_FC) += fc/
diff -Nru a/drivers/net/arm/Kconfig b/drivers/net/arm/Kconfig
--- a/drivers/net/arm/Kconfig	2004-06-21 13:52:45 -07:00
+++ b/drivers/net/arm/Kconfig	2004-06-21 13:52:45 -07:00
@@ -44,21 +44,3 @@
 	  will generate a suitable hw address based on the board serial
 	  number (MTD support is required for this). Otherwise you will
 	  need to set a suitable hw address using ifconfig.
-
-config SMC91X
-	tristate "SMC 91C9x/91C1xxx support"
-	select CRC32
-	select MII
-	depends on ARM
-	help
-	  This is a driver for SMC's 91x series of Ethernet chipsets,
-	  including the SMC91C94 and the SMC91C111. Say Y if you want it
-	  compiled into the kernel, and read the file
-	  <file:Documentation/networking/smc9.txt>  and the Ethernet-HOWTO,
-	  available from  <http://www.linuxdoc.org/docs.html#howto>.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called smc91x.  If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt> as well
-	  as <file:Documentation/networking/net-modules.txt>.
diff -Nru a/drivers/net/arm/Makefile b/drivers/net/arm/Makefile
--- a/drivers/net/arm/Makefile	2004-06-21 13:52:45 -07:00
+++ b/drivers/net/arm/Makefile	2004-06-21 13:52:45 -07:00
@@ -8,4 +8,3 @@
 obj-$(CONFIG_ARM_ETHERH)	+= etherh.o
 obj-$(CONFIG_ARM_ETHER3)	+= ether3.o
 obj-$(CONFIG_ARM_ETHER1)	+= ether1.o
-obj-$(CONFIG_SMC91X)		+= smc91x.o
===== drivers/net/smc91x.c 1.2 vs edited =====
--- 1.2/drivers/net/smc91x.c	2004-06-21 10:16:40 -07:00
+++ edited/drivers/net/smc91x.c	2004-06-21 11:10:26 -07:00
@@ -86,7 +86,12 @@
 #include <linux/skbuff.h>

 #include <asm/io.h>
+#ifdef CONFIG_ARM
 #include <asm/hardware.h>
+#endif
+#ifdef CONFIG_PPC
+#include <syslib/platform.h>
+#endif
 #include <asm/irq.h>

 #include "smc91x.h"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
