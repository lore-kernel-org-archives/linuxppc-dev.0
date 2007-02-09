Return-Path: <krafft@de.ibm.com>
Date: Fri, 9 Feb 2007 18:45:30 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [patch 1/1] pmi: initial version
Message-ID: <20070209184530.4c8bc2be@localhost>
In-Reply-To: <20070209183529.67d542d5@localhost>
References: <20070209183529.67d542d5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds driver code for the PMI device found in future IBM products.
PMI stands for "Platform Management Interrupt" and is a way to communicate
with the BMC. It provides bidirectional communication with a low latency.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/arch/powerpc/Kconfig
===================================================================
--- linux.orig/arch/powerpc/Kconfig
+++ linux/arch/powerpc/Kconfig
@@ -524,6 +524,7 @@ config PPC_IBM_CELL_BLADE
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
+#	select PPC_PMI
 
 config PPC_PS3
 	bool "Sony PS3 (incomplete)"
@@ -577,6 +578,14 @@ config RTAS_FLASH
 	tristate "Firmware flash interface"
 	depends on PPC64 && RTAS_PROC
 
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
===================================================================
--- linux.orig/arch/powerpc/sysdev/Makefile
+++ linux/arch/powerpc/sysdev/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indire
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
+obj-$(CONFIG_PPC_PMI)		+= pmi.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
Index: linux/arch/powerpc/sysdev/pmi.c
===================================================================
--- /dev/null
+++ linux/arch/powerpc/sysdev/pmi.c
@@ -0,0 +1,275 @@
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
+struct pmi_data {
+	struct list_head handler;
+	spinlock_t handler_spinlock;
+	spinlock_t pmi_spinlock;
+	struct mutex msg_mutex;
+	struct pmi_message *msg;
+	struct completion *completion;
+	struct of_device *dev;
+	int irq;
+	u8 __iomem *pmi_reg;
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
+        pr_debug("Resource end: 0x%lx\n", res.end);
+
+	return ioremap(res.start, 1 + res.end - res.start);
+}
+
+static int pmi_irq_handler(int irq, void *dev_id)
+{
+	struct pmi_data *data;
+	int type;
+	struct pmi_handler *handler;
+
+	data = dev_id;
+
+	BUG_ON(!data);
+
+	pr_debug("pmi: got a PMI message\n");
+
+	spin_lock(&data->pmi_spinlock);
+	type = ioread8(data->pmi_reg + PMI_READ_TYPE);
+	spin_unlock(&data->pmi_spinlock);
+
+	pr_debug("pmi: message type is %d\n", type);
+
+	if (type & PMI_ACK) {
+		BUG_ON(!data->msg);
+		BUG_ON(!data->completion);
+		pr_debug("pmi: got an ACK\n");
+		data->msg->type = type;
+		data->msg->data0 = ioread8(data->pmi_reg + PMI_READ_DATA0);
+		data->msg->data1 = ioread8(data->pmi_reg + PMI_READ_DATA1);
+		data->msg->data2 = ioread8(data->pmi_reg + PMI_READ_DATA2);
+		complete(data->completion);
+		return IRQ_HANDLED;
+	}
+
+	spin_lock(&data->handler_spinlock);
+	list_for_each_entry(handler, &data->handler, node) {
+		pr_debug("pmi: notifying handlers\n");
+		if (handler->type == type) {
+			pr_debug("pmi: notify handler %p\n", handler);
+			handler->handle_pmi_message(data->dev, data->msg);
+		}
+	}
+	spin_unlock(&data->handler_spinlock);
+
+	return IRQ_HANDLED;
+}
+
+
+static struct of_device_id pmi_match[] = {
+	{ .type = "ibm,pmi", .name = "pmi" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, pmi_match);
+
+static int pmi_of_probe(struct of_device *dev,
+			const struct of_device_id *match)
+{
+	DEFINE_SPINLOCK(handler_spinlock);
+	DEFINE_SPINLOCK(pmi_spinlock);
+
+	struct device_node *np = dev->node;
+	struct pmi_data *data;
+	int rc;
+
+	data = kzalloc(sizeof(struct pmi_data), GFP_KERNEL);
+	if (!data) {
+		printk(KERN_ERR "pmi: could not allocate memory.\n");
+		return -EFAULT;
+	}
+
+	data->pmi_reg = of_iomap(np);
+
+	if (!data->pmi_reg) {
+		printk(KERN_ERR "pmi: invalid register address.\n");
+		kfree(data);
+		return -EFAULT;
+	}
+
+	INIT_LIST_HEAD(&data->handler);
+
+	data->irq = irq_of_parse_and_map(np, 0);
+	if (data->irq == NO_IRQ) {
+		printk(KERN_ERR "pmi: invalid interrupt.\n");
+		iounmap(data->pmi_reg);
+		kfree(data);
+		return -EFAULT;
+	}
+
+	data->handler_spinlock = handler_spinlock;
+	data->pmi_spinlock = pmi_spinlock;
+
+	rc = request_irq(data->irq, pmi_irq_handler,
+			IRQF_SHARED, "pmi", data);
+	if (rc) {
+		printk(KERN_ERR "pmi: can't request IRQ %d: returned %d\n",
+			data->irq, rc);
+		iounmap(data->pmi_reg);
+		kfree(data);
+		return -EFAULT;
+	}
+
+	dev->dev.driver_data = data;
+	data->dev = dev;
+
+	printk(KERN_INFO "pmi: found pmi device at address %p.\n", data->pmi_reg);
+
+	return 0;
+}
+
+static int pmi_of_remove(struct of_device *dev)
+{
+	struct pmi_data *data;
+	struct pmi_handler *handler, *tmp;
+
+	data = dev->dev.driver_data;
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
+static struct of_platform_driver pmi_of_platform_driver = {
+	.name		= "pmi",
+	.match_table	= pmi_match,
+	.probe		= pmi_of_probe,
+	.remove		= pmi_of_remove
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
+void pmi_send_message(struct of_device *device, struct pmi_message *msg)
+{
+	struct pmi_data *data;
+	unsigned long flags;
+	DECLARE_COMPLETION_ONSTACK(completion);
+
+	BUG_ON(!device || !msg);
+
+	data = device->dev.driver_data;
+	pr_debug("pmi_send_message: data is %p\n", data);
+
+	mutex_lock(&data->msg_mutex);
+
+	data->msg = msg;
+
+	pr_debug("pmi_send_message: msg is %p\n", msg);
+
+	data->completion = &completion;
+
+	spin_lock_irqsave(&data->pmi_spinlock, flags);
+	iowrite8(msg->data0, data->pmi_reg + PMI_WRITE_DATA0);
+	iowrite8(msg->data1, data->pmi_reg + PMI_WRITE_DATA1);
+	iowrite8(msg->data2, data->pmi_reg + PMI_WRITE_DATA2);
+	iowrite8(msg->type, data->pmi_reg + PMI_WRITE_TYPE);
+	spin_unlock_irqrestore(&data->pmi_spinlock, flags);
+
+	pr_debug(KERN_INFO "pmi_send_message: wait for completion %p\n", data->completion);
+
+	wait_for_completion_interruptible_timeout(data->completion, PMI_TIMEOUT);
+
+	data->msg = NULL;
+	data->completion = NULL;
+
+	mutex_unlock(&data->msg_mutex);
+}
+EXPORT_SYMBOL_GPL(pmi_send_message);
+
+void pmi_register_handler(struct of_device *device, struct pmi_handler *handler)
+{
+	struct pmi_data *data;
+
+	pr_debug("pmi: registering handler %p\n", handler);
+
+	data = device->dev.driver_data;
+
+	spin_lock_irq(&data->handler_spinlock);
+	list_add_tail(&handler->node, &data->handler);
+	spin_unlock_irq(&data->handler_spinlock);
+}
+EXPORT_SYMBOL_GPL(pmi_register_handler);
+
+void pmi_unregister_handler(struct of_device *device, struct pmi_handler *handler)
+{
+	struct pmi_data *data;
+
+	pr_debug("pmi: unregistering handler %p\n", handler);
+
+	data = device->dev.driver_data;
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
===================================================================
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
+struct pmi_message {
+	u8	type;
+	u8	data0;
+	u8	data1;
+	u8	data2;
+};
+
+struct pmi_handler {
+	struct list_head node;
+	u8 type;
+	void (*handle_pmi_message) (struct of_device *, struct pmi_message *);
+};
+
+void pmi_register_handler(struct of_device *, struct pmi_handler *);
+void pmi_unregister_handler(struct of_device *, struct pmi_handler *);
+
+void pmi_send_message(struct of_device *, struct pmi_message *);
+
+#endif /* __KERNEL__ */
+#endif /* _POWERPC_PMI_H */
