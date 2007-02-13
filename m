Return-Path: <krafft@de.ibm.com>
Date: Tue, 13 Feb 2007 14:34:18 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [patch v2] pmi: initial version
Message-ID: <20070213143418.06fa01b5@localhost>
In-Reply-To: <20070212101222.24abe14c@localhost>
References: <20070209183529.67d542d5@localhost>
	<20070209184530.4c8bc2be@localhost>
	<20070209222956.GH1827@localdomain>
	<20070212101222.24abe14c@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: powerpc: add PMI driver for cell blade

From: Christian Krafft <krafft@de.ibm.com>
This patch adds driver code for the PMI device found in future IBM products.
PMI stands for "Platform Management Interrupt" and is a way to communicate
with the BMC. It provides bidirectional communication with a low latency.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linux/arch/powerpc/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/Kconfig
+++ linux/arch/powerpc/Kconfig
@@ -577,6 +577,14 @@ config RTAS_FLASH
 	tristate "Firmware flash interface"
 	depends on PPC64 && RTAS_PROC
=20
+config PPC_PMI
+	tristate "Support for PMI"
+	depends PPC_IBM_CELL_BLADE
+	help
+	  PMI is a way to communicate with the board mangement controller.
+	  It is used in some IBM Cell blades.
+	default m
+
 config MMIO_NVRAM
 	bool
 	default n
Index: linux/arch/powerpc/sysdev/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/sysdev/Makefile
+++ linux/arch/powerpc/sysdev/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PPC_INDIRECT_PCI)	+=3D indire
 obj-$(CONFIG_PPC_MPC106)	+=3D grackle.o
 obj-$(CONFIG_PPC_DCR)		+=3D dcr.o
 obj-$(CONFIG_PPC_DCR_NATIVE)	+=3D dcr-low.o
+obj-$(CONFIG_PPC_PMI)		+=3D pmi.o
 obj-$(CONFIG_U3_DART)		+=3D dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+=3D mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o
Index: linux/arch/powerpc/sysdev/pmi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux/arch/powerpc/sysdev/pmi.c
@@ -0,0 +1,291 @@
+/*
+ * pmi driver
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * PMI is a way to communicate with the BMC via interrupts.
+ * Unlike IPMI it is bidirectional and has a low latency.
+ *
+ * Author: Christian Krafft <krafft@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+#include <linux/spinlock.h>
+
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#include <asm/io.h>
+#include <asm/pmi.h>
+
+
+struct pmi_data {
+	struct list_head	handler;
+	spinlock_t		handler_spinlock;
+	spinlock_t		pmi_spinlock;
+	struct mutex		msg_mutex;
+	pmi_message_t		msg;
+	struct completion	*completion;
+	struct of_device	*dev;
+	int			irq;
+	u8 __iomem		*pmi_reg;
+};
+
+
+static void __iomem *of_iomap(struct device_node *np)
+{
+	struct resource res;
+
+	if (of_address_to_resource(np, 0, &res))
+		return NULL;
+
+	pr_debug("Resource start: 0x%lx\n", res.start);
+	pr_debug("Resource end: 0x%lx\n", res.end);
+
+	return ioremap(res.start, 1 + res.end - res.start);
+}
+
+
+static int pmi_irq_handler(int irq, void *dev_id)
+{
+	struct pmi_data *data;
+	struct pmi_handler *handler;
+	u8 type;
+	int rc;
+
+	data =3D dev_id;
+
+	spin_lock(&data->pmi_spinlock);
+
+	type =3D ioread8(data->pmi_reg + PMI_READ_TYPE);
+	pr_debug("pmi: got message of type %d\n", type);
+
+	if (type & PMI_ACK && !data->completion) {
+		printk(KERN_WARNING "pmi: got unexpected ACK message.\n");
+		rc =3D -EIO;
+		goto unlock;
+	}
+
+	if (data->completion && !(type & PMI_ACK)) {
+		printk(KERN_WARNING "pmi: expected ACK, but got %d\n", type);
+		rc =3D -EIO;
+		goto unlock;
+	}
+
+	data->msg.type =3D type;
+	data->msg.data0 =3D ioread8(data->pmi_reg + PMI_READ_DATA0);
+	data->msg.data1 =3D ioread8(data->pmi_reg + PMI_READ_DATA1);
+	data->msg.data2 =3D ioread8(data->pmi_reg + PMI_READ_DATA2);
+	rc =3D 0;
+unlock:
+	spin_unlock(&data->pmi_spinlock);
+
+	if (rc =3D=3D -EIO) {
+		rc =3D IRQ_HANDLED;
+		goto out;
+	}
+
+	if (data->msg.type & PMI_ACK) {
+		complete(data->completion);
+		rc =3D IRQ_HANDLED;
+		goto out;
+	}
+
+	list_for_each_entry(handler, &data->handler, node) {
+		pr_debug(KERN_INFO "pmi: notifying handler %p\n", handler);
+		if (handler->type =3D=3D data->msg.type)
+			handler->handle_pmi_message(data->dev, data->msg);
+	}
+
+	rc =3D IRQ_HANDLED;
+out:
+	return rc;
+}
+
+
+static struct of_device_id pmi_match[] =3D {
+	{ .type =3D "ibm,pmi", .name =3D "ibm,pmi" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, pmi_match);
+
+static int pmi_of_probe(struct of_device *dev,
+			const struct of_device_id *match)
+{
+	struct device_node *np =3D dev->node;
+	struct pmi_data *data;
+	int rc;
+
+	data =3D kzalloc(sizeof(struct pmi_data), GFP_KERNEL);
+	if (!data) {
+		printk(KERN_ERR "pmi: could not allocate memory.\n");
+		rc =3D -ENOMEM;
+		goto out;
+	}
+
+	data->pmi_reg =3D of_iomap(np);
+	if (!data->pmi_reg) {
+		printk(KERN_ERR "pmi: invalid register address.\n");
+		rc =3D -EFAULT;
+		goto error_cleanup_data;
+	}
+
+	INIT_LIST_HEAD(&data->handler);
+
+	mutex_init(&data->msg_mutex);
+	spin_lock_init(&data->pmi_spinlock);
+	spin_lock_init(&data->handler_spinlock);
+
+	dev->dev.driver_data =3D data;
+	data->dev =3D dev;
+
+	data->irq =3D irq_of_parse_and_map(np, 0);
+	if (data->irq =3D=3D NO_IRQ) {
+		printk(KERN_ERR "pmi: invalid interrupt.\n");
+		rc =3D -EFAULT;
+		goto error_cleanup_iomap;
+	}
+
+	rc =3D request_irq(data->irq, pmi_irq_handler, 0, "pmi", data);
+	if (rc) {
+		printk(KERN_ERR "pmi: can't request IRQ %d: returned %d\n",
+				data->irq, rc);
+		goto error_cleanup_iomap;
+	}
+
+	printk(KERN_INFO "pmi: found pmi device at addr %p.\n", data->pmi_reg);
+
+	goto out;
+
+error_cleanup_iomap:
+	iounmap(data->pmi_reg);
+
+error_cleanup_data:
+	kfree(data);
+
+out:
+	return rc;
+}
+
+static int pmi_of_remove(struct of_device *dev)
+{
+	struct pmi_data *data;
+	struct pmi_handler *handler, *tmp;
+
+	data =3D dev->dev.driver_data;
+
+	free_irq(data->irq, data);
+	iounmap(data->pmi_reg);
+
+	spin_lock_irq(&data->handler_spinlock);
+
+	list_for_each_entry_safe(handler, tmp, &data->handler, node)
+		list_del(&handler->node);
+
+	spin_unlock_irq(&data->handler_spinlock);
+
+	kfree(dev->dev.driver_data);
+
+	return 0;
+}
+
+static struct of_platform_driver pmi_of_platform_driver =3D {
+	.name		=3D "pmi",
+	.match_table	=3D pmi_match,
+	.probe		=3D pmi_of_probe,
+	.remove		=3D pmi_of_remove
+};
+
+static int __init pmi_module_init(void)
+{
+	return of_register_platform_driver(&pmi_of_platform_driver);
+}
+module_init(pmi_module_init);
+
+static void __exit pmi_module_exit(void)
+{
+	of_unregister_platform_driver(&pmi_of_platform_driver);
+}
+module_exit(pmi_module_exit);
+
+void pmi_send_message(struct of_device *device, pmi_message_t msg)
+{
+	struct pmi_data *data;
+	unsigned long flags;
+	DECLARE_COMPLETION_ONSTACK(completion);
+
+	data =3D device->dev.driver_data;
+
+	mutex_lock(&data->msg_mutex);
+
+	data->msg =3D msg;
+	pr_debug("pmi_send_message: msg is %08x\n", *(u32*)&msg);
+
+	data->completion =3D &completion;
+
+	spin_lock_irqsave(&data->pmi_spinlock, flags);
+	iowrite8(msg.data0, data->pmi_reg + PMI_WRITE_DATA0);
+	iowrite8(msg.data1, data->pmi_reg + PMI_WRITE_DATA1);
+	iowrite8(msg.data2, data->pmi_reg + PMI_WRITE_DATA2);
+	iowrite8(msg.type, data->pmi_reg + PMI_WRITE_TYPE);
+	spin_unlock_irqrestore(&data->pmi_spinlock, flags);
+
+	pr_debug("pmi_send_message: wait for completion\n");
+
+	wait_for_completion_interruptible_timeout(data->completion,
+						  PMI_TIMEOUT);
+
+	data->completion =3D NULL;
+
+	mutex_unlock(&data->msg_mutex);
+}
+EXPORT_SYMBOL_GPL(pmi_send_message);
+
+void pmi_register_handler(struct of_device *device,
+			  struct pmi_handler *handler)
+{
+	struct pmi_data *data;
+
+	pr_debug("pmi: registering handler %p\n", handler);
+
+	data =3D device->dev.driver_data;
+
+	spin_lock_irq(&data->handler_spinlock);
+	list_add_tail(&handler->node, &data->handler);
+	spin_unlock_irq(&data->handler_spinlock);
+}
+EXPORT_SYMBOL_GPL(pmi_register_handler);
+
+void pmi_unregister_handler(struct of_device *device,
+			    struct pmi_handler *handler)
+{
+	struct pmi_data *data;
+
+	pr_debug("pmi: unregistering handler %p\n", handler);
+
+	data =3D device->dev.driver_data;
+
+	spin_lock_irq(&data->handler_spinlock);
+	list_del(&handler->node);
+	spin_unlock_irq(&data->handler_spinlock);
+}
+EXPORT_SYMBOL_GPL(pmi_unregister_handler);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
+MODULE_DESCRIPTION("IBM Platform Management Interrupt driver");
Index: linux/include/asm-powerpc/pmi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux/include/asm-powerpc/pmi.h
@@ -0,0 +1,63 @@
+#ifndef _POWERPC_PMI_H
+#define _POWERPC_PMI_H
+
+/*
+ * Definitions for talking with PMI device on PowerPC
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Christian Krafft <krafft@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifdef __KERNEL__
+
+#include <asm/of_device.h>
+
+#define PMI_TYPE_FREQ_CHANGE	0x01
+#define PMI_READ_TYPE		0
+#define PMI_READ_DATA0		1
+#define PMI_READ_DATA1		2
+#define PMI_READ_DATA2		3
+#define PMI_WRITE_TYPE		4
+#define PMI_WRITE_DATA0		5
+#define PMI_WRITE_DATA1		6
+#define PMI_WRITE_DATA2		7
+
+#define PMI_ACK			0x80
+
+#define PMI_TIMEOUT		100
+
+typedef struct {
+	u8	type;
+	u8	data0;
+	u8	data1;
+	u8	data2;
+} pmi_message_t;
+
+struct pmi_handler {
+	struct list_head node;
+	u8 type;
+	void (*handle_pmi_message) (struct of_device *, pmi_message_t);
+};
+
+void pmi_register_handler(struct of_device *, struct pmi_handler *);
+void pmi_unregister_handler(struct of_device *, struct pmi_handler *);
+
+void pmi_send_message(struct of_device *, pmi_message_t);
+
+#endif /* __KERNEL__ */
+#endif /* _POWERPC_PMI_H */
Index: linux/arch/powerpc/configs/cell_defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/configs/cell_defconfig
+++ linux/arch/powerpc/configs/cell_defconfig
@@ -147,6 +147,7 @@ CONFIG_PPC_RTAS=3Dy
 # CONFIG_RTAS_ERROR_LOGGING is not set
 CONFIG_RTAS_PROC=3Dy
 CONFIG_RTAS_FLASH=3Dy
+CONFIG_PPC_PMI=3Dm
 CONFIG_MMIO_NVRAM=3Dy
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
