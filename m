Return-Path: <jean-baptiste.maneyrol@teamlog.com>
Received: from me-ml2.teamlog.fr (smtp-grenoble1.teamlog.com [194.2.68.40])
	by ozlabs.org (Postfix) with ESMTP id 88CF367BCE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 18:29:34 +1000 (EST)
Received: from teamlog.com
	by grenoble.teamlog.com (x.x.x/x.x.x) with ESMTP        
	id k8T8THr3032382
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Sep 2006 10:29:20 +0200
Subject: [PATCH] IBM GPIO driver for PowerPC 4xx is back from the dead
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="=-HFLHr4UwbcnybWqZEaO8"
Date: Fri, 29 Sep 2006 10:29:25 +0200
Message-Id: <1159518565.9269.1.camel@jb-portable>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-HFLHr4UwbcnybWqZEaO8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a patch for linux 2.6.18 that makes come back the old ibm gpio
driver from 2.6.10.

It is mainly useful for compatibility with old linux 2.4 from Montavista
I think, because direct memory access seems the new way to go.

Signed-off-by: Jean-Baptiste Maneyrol
<jean-baptiste.maneyrol@teamlog.com>


Jean-Baptiste Maneyrol
Teamlog - France

--=-HFLHr4UwbcnybWqZEaO8
Content-Disposition: attachment; filename=ibm_gpio.patch
Content-Type: text/x-patch; name=ibm_gpio.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.18_gpio/drivers/char/ibm_gpio.c tlgate_gpio/drivers/char/ibm_gpio.c
--- linux-2.6.18_gpio/drivers/char/ibm_gpio.c	1970-01-01 01:00:00.000000000 +0100
+++ tlgate_gpio/drivers/char/ibm_gpio.c	2006-09-28 16:46:42.000000000 +0200
@@ -0,0 +1,349 @@
+/*
+ * FILE NAME ibm_gpio.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *  API for IBM PowerPC 4xx GPIO device.
+ *  Driver for IBM PowerPC 4xx GPIO device.
+ *
+ *  Armin Kuster akuster@pacbell.net
+ *  Sept, 2001
+ *
+ *  Orignial driver
+ *  Author: MontaVista Software, Inc.  <source@mvista.com>
+ *          Frank Rowand <frank_rowand@mvista.com>
+ *          Debbie Chu   <debbie_chu@mvista.com>
+ *
+ * Copyright 2000,2001,2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE	LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *	TODO: devfs
+ *
+ *	Version: 02/01/12 - Armin
+ *			 converted to ocp and using ioremap
+ *
+ *	1.2 02/21/01 - Armin
+ *		minor compiler warning fixes
+ *
+ *	1.3 02/22/01 - Armin
+ *		added apm
+ *
+ *	1.4 05/07/02 - Armin/David Mueller
+ *		coverted to core_ocp[];
+ *
+ *	1.5 05/25/02 - Armin
+ *	 name change from *_driver to *_dev
+ *
+ *	1.6 06/04/02 - Matt Porter
+ *	ioremap paddr. Comment as 4xx generic driver.
+ *	Fix header to be userland safe and locate in
+ *	an accessible area.  Add ioctl to configure
+ *	multiplexed GPIO pins.
+ *
+ *	1.7 07/25/02 - Armin
+ *	added CPM to enable/disable in init/exit
+ *
+ */
+
+#define VUFX "07.25.02"
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/init.h>
+#include <linux/ioctl.h>
+#include <linux/fs.h>
+#include <asm/ibm_gpio.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ocp.h>
+#include <asm/ibm4xx.h>
+
+struct miscdevice ibm_gpio_miscdev;
+static struct gpio_regs *gpiop;
+
+int
+ibm_gpio_config(__u32 device, __u32 mask, __u32 data)
+{
+	u32 cfg_reg;
+
+	if (device != 0)
+		return -ENXIO;
+
+#ifdef CONFIG_40x
+#ifdef DCRN_CHCR0
+	/*
+	 * PPC405 uses CPC0_CR0 to select multiplexed GPIO pins.
+	 */
+	cfg_reg = mfdcr(DCRN_CHCR0);
+	cfg_reg = (cfg_reg & ~mask) | (data & mask);
+	mtdcr(DCRN_CHCR0, cfg_reg);
+#endif
+#elif CONFIG_440GP
+	/*
+	 * PPC440GP uses CPC0_GPIO to select multiplexed GPIO pins.
+	 */
+	cfg_reg = mfdcr(DCRN_CPC0_GPIO);
+	cfg_reg = (cfg_reg & ~mask) | (data & mask);
+	mtdcr(DCRN_CPC0_GPIO, cfg_reg);
+#elif CONFIG_440GX
+	/*
+	 * PPC440GX uses SDR0_PFC0 to select multiplexed GPIO pins
+	 */
+	cfg_reg = SDR_READ(DCRN_SDR_PFC0);
+	cfg_reg = (cfg_reg & ~mask) | (data & mask);
+	SDR_WRITE(DCRN_SDR_PFC0, cfg_reg);
+#else
+#error This driver is only supported on PPC40x and PPC440 CPUs
+#endif
+
+	return 0;
+}
+
+int
+ibm_gpio_tristate(__u32 device, __u32 mask, __u32 data)
+{
+	if (device != 0)
+		return -ENXIO;
+	gpiop->tcr = (gpiop->tcr & ~mask) | (data & mask);
+	return 0;
+}
+
+int
+ibm_gpio_open_drain(__u32 device, __u32 mask, __u32 data)
+{
+	if (device != 0)
+		return -ENXIO;
+	gpiop->odr = (gpiop->odr & ~mask) | (data & mask);
+
+	return 0;
+}
+
+int
+ibm_gpio_in(__u32 device, __u32 mask, volatile __u32 * data)
+{
+	if (device != 0)
+		return -ENXIO;
+	gpiop->tcr = gpiop->tcr & ~mask;
+	eieio();
+
+	/*
+	   ** If the previous state was OUT, and gpiop->ir is read once, then the
+	   ** data that was being OUTput will be read.  One way to get the right
+	   ** data is to read gpiop->ir twice.
+	 */
+
+	*data = gpiop->ir;
+	*data = gpiop->ir & mask;
+	eieio();
+	return 0;
+}
+
+int
+ibm_gpio_out(__u32 device, __u32 mask, __u32 data)
+{
+	if (device != 0)
+		return -ENXIO;
+	gpiop->or = (gpiop->or & ~mask) | (data & mask);
+	eieio();
+	gpiop->tcr = gpiop->tcr | mask;
+	eieio();
+	return 0;
+}
+
+static int
+ibm_gpio_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int
+ibm_gpio_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int
+ibm_gpio_ioctl(struct inode *inode, struct file *file,
+	       unsigned int cmd, unsigned long arg)
+{
+	static struct ibm_gpio_ioctl_data ioctl_data;
+	int status;
+
+	switch (cmd) {
+	case IBMGPIO_IN:
+		if (copy_from_user(&ioctl_data,
+				   (struct ibm_gpio_ioctl_data *) arg,
+				   sizeof (ioctl_data))) {
+			return -EFAULT;
+		}
+
+		status = ibm_gpio_in(ioctl_data.device,
+				     ioctl_data.mask, &ioctl_data.data);
+		if (status != 0)
+			return status;
+
+		if (copy_to_user((struct ibm_gpio_ioctl_data *) arg,
+				 &ioctl_data, sizeof (ioctl_data))) {
+			return -EFAULT;
+		}
+
+		break;
+
+	case IBMGPIO_OUT:
+		if (copy_from_user(&ioctl_data,
+				   (struct ibm_gpio_ioctl_data *) arg,
+				   sizeof (ioctl_data))) {
+			return -EFAULT;
+		}
+
+		return ibm_gpio_out(ioctl_data.device,
+				    ioctl_data.mask, ioctl_data.data);
+
+		break;
+
+	case IBMGPIO_OPEN_DRAIN:
+		if (copy_from_user(&ioctl_data,
+				   (struct ibm_gpio_ioctl_data *) arg,
+				   sizeof (ioctl_data))) {
+			return -EFAULT;
+		}
+
+		return ibm_gpio_open_drain(ioctl_data.device,
+					   ioctl_data.mask, ioctl_data.data);
+
+		break;
+
+	case IBMGPIO_TRISTATE:
+		if (copy_from_user(&ioctl_data,
+				   (struct ibm_gpio_ioctl_data *) arg,
+				   sizeof (ioctl_data)))
+			return -EFAULT;
+
+		return ibm_gpio_tristate(ioctl_data.device,
+					 ioctl_data.mask, ioctl_data.data);
+
+		break;
+
+	case IBMGPIO_CFG:
+		if (copy_from_user(&ioctl_data,
+				   (struct ibm_gpio_ioctl_data *) arg,
+				   sizeof (ioctl_data)))
+			return -EFAULT;
+
+		return ibm_gpio_config(ioctl_data.device,
+				ioctl_data.mask, ioctl_data.data);
+
+		break;
+
+	default:
+		return -ENOIOCTLCMD;
+
+	}
+	return 0;
+}
+
+static struct file_operations ibm_gpio_fops = {
+	.owner		= THIS_MODULE,
+	.ioctl		= ibm_gpio_ioctl,
+	.open		= ibm_gpio_open,
+	.release	= ibm_gpio_release,
+};
+
+static int __init
+ibm_gpio_probe(struct ocp_device *ocp)
+{
+	ibm_gpio_miscdev.minor = GPIO_MINOR;
+	ibm_gpio_miscdev.name = ocp->name;
+	ibm_gpio_miscdev.fops = &ibm_gpio_fops;
+	misc_register(&ibm_gpio_miscdev);
+
+	if (!request_mem_region(ocp->def->paddr, sizeof(struct gpio_regs), "ibm_gpio"))
+		return -EBUSY;
+	
+	gpiop = (struct gpio_regs *) ioremap(ocp->def->paddr,
+			sizeof(struct gpio_regs));
+	if (!gpiop) {
+		release_mem_region(ocp->def->paddr, sizeof(struct gpio_regs));
+		return -ENOMEM;
+	}
+	
+	printk("GPIO #%d at 0x%lx\n", ocp->def->index,
+			(unsigned long) gpiop);
+
+	return 0;
+}
+
+static void __exit
+ibm_gpio_remove(struct ocp_device *ocp)
+{
+	misc_deregister(&ibm_gpio_miscdev);
+
+	iounmap(gpiop);
+	gpiop = NULL;
+	
+	release_mem_region(ocp->def->paddr, sizeof(struct gpio_regs));
+}
+
+static struct ocp_device_id ibm_gpio_ids[] __devinitdata =
+{
+	{ .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_GPIO },
+	{ .vendor = OCP_VENDOR_INVALID }
+};
+
+MODULE_DEVICE_TABLE(ocp, ibm_gpio_ids);
+
+static struct ocp_driver ibm_gpio_driver =
+{
+	.name           = "ibm_gpio",
+	.id_table       = ibm_gpio_ids,
+	.probe          = ibm_gpio_probe,
+	.remove         = __devexit_p(ibm_gpio_remove),
+#if defined(CONFIG_PM)
+	.suspend        = NULL,
+	.resume         = NULL,
+#endif
+};
+
+static int __init
+ibm_gpio_init(void)
+{
+	printk("IBM GPIO driver version %s\n", VUFX);
+	return ocp_register_driver(&ibm_gpio_driver);
+}
+
+static void __exit
+ibm_gpio_exit(void)
+{
+	ocp_unregister_driver(&ibm_gpio_driver);
+}
+
+module_init(ibm_gpio_init);
+module_exit(ibm_gpio_exit);
+
+EXPORT_SYMBOL(ibm_gpio_tristate);
+EXPORT_SYMBOL(ibm_gpio_open_drain);
+EXPORT_SYMBOL(ibm_gpio_in);
+EXPORT_SYMBOL(ibm_gpio_out);
+
+MODULE_LICENSE("GPL");
diff -Naur linux-2.6.18_gpio/drivers/char/Kconfig tlgate_gpio/drivers/char/Kconfig
--- linux-2.6.18_gpio/drivers/char/Kconfig	2006-09-28 16:47:53.000000000 +0200
+++ tlgate_gpio/drivers/char/Kconfig	2006-09-28 16:50:15.000000000 +0200
@@ -936,6 +936,15 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called mwave.
 
+config IBM_GPIO
+	tristate "IBM PowerPC 4xx GPIO Support"
+	depends on IBM_OCP
+	help
+	  Give userspace access to the GPIO pins on the PowerPC
+	  4xx processors.
+	
+	  If compiled as a module, it will be called ibm_gpio.
+
 config SCx200_GPIO
 	tristate "NatSemi SCx200 GPIO Support"
 	depends on SCx200
diff -Naur linux-2.6.18_gpio/drivers/char/Makefile tlgate_gpio/drivers/char/Makefile
--- linux-2.6.18_gpio/drivers/char/Makefile	2006-09-28 16:47:57.000000000 +0200
+++ tlgate_gpio/drivers/char/Makefile	2006-09-28 16:46:42.000000000 +0200
@@ -81,6 +81,7 @@
 obj-$(CONFIG_PPDEV)		+= ppdev.o
 obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
 obj-$(CONFIG_NWFLASH)		+= nwflash.o
+obj-$(CONFIG_IBM_GPIO)		+= ibm_gpio.o
 obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
 obj-$(CONFIG_PC8736x_GPIO)	+= pc8736x_gpio.o
 obj-$(CONFIG_NSC_GPIO)		+= nsc_gpio.o
diff -Naur linux-2.6.18_gpio/include/asm-ppc/ibm_gpio.h tlgate_gpio/include/asm-ppc/ibm_gpio.h
--- linux-2.6.18_gpio/include/asm-ppc/ibm_gpio.h	1970-01-01 01:00:00.000000000 +0100
+++ tlgate_gpio/include/asm-ppc/ibm_gpio.h	2006-09-28 16:47:09.000000000 +0200
@@ -0,0 +1,71 @@
+/*
+ * FILE NAME ibm_ocp_gpio.h
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Generic gpio.
+ *
+ *  Armin Kuster akuster@pacbell.net
+ *  Sept, 2001
+ *
+ *  Orignial driver
+ *  Author: MontaVista Software, Inc.  <source@mvista.com>
+ *          Frank Rowand <frank_rowand@mvista.com>
+ *
+ * Copyright 2000 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __IBM_OCP_GPIO_H
+#define __IBM_OCP_GPIO_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#ifdef __KERNEL__
+
+typedef struct gpio_regs {
+	u32 or;
+	u32 tcr;
+	u32 pad[4];
+	u32 odr;
+	u32 ir;
+} gpio_t;
+
+#define GPIO_MINOR		185
+
+#endif		/* __KERNEL__ */
+
+struct ibm_gpio_ioctl_data {
+        __u32 device;
+        __u32 mask;
+        __u32 data;
+};
+
+#define IBMGPIO_IOCTL_BASE	'Z'
+
+#define IBMGPIO_IN		_IOWR(IBMGPIO_IOCTL_BASE, 0, struct ibm_gpio_ioctl_data)
+#define IBMGPIO_OUT		_IOW (IBMGPIO_IOCTL_BASE, 1, struct ibm_gpio_ioctl_data)
+#define IBMGPIO_OPEN_DRAIN	_IOW (IBMGPIO_IOCTL_BASE, 2, struct ibm_gpio_ioctl_data)
+#define IBMGPIO_TRISTATE	_IOW (IBMGPIO_IOCTL_BASE, 3, struct ibm_gpio_ioctl_data)
+#define IBMGPIO_CFG		_IOW (IBMGPIO_IOCTL_BASE, 4, struct ibm_gpio_ioctl_data)
+
+#endif

--=-HFLHr4UwbcnybWqZEaO8--
