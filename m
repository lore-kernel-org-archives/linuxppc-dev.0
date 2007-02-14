Return-Path: <parabelboi@bopserverein.de>
Date: Wed, 14 Feb 2007 14:09:45 +0100
From: Christian Krafft <parabelboi@bopserverein.de>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [patch v3] powerpc: add PMI driver for cell blade
Message-ID: <20070214140945.4ad0d772@localhost>
In-Reply-To: <20070214140743.18fafe37@localhost>
References: <20070209183529.67d542d5@localhost>
	<20070209184530.4c8bc2be@localhost>
	<20070209222956.GH1827@localdomain>
	<20070212101222.24abe14c@localhost>
	<20070213143418.06fa01b5@localhost>
	<20070213194436.0306d18a@localhost>
	<20070213194806.3c266282@localhost>
	<20070213202854.09332582@localhost>
	<17874.22587.981499.55058@cargo.ozlabs.ibm.com>
	<20070214093941.08ec4c7f@localhost>
	<17874.58072.316004.517233@cargo.ozlabs.ibm.com>
	<20070214140743.18fafe37@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
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
with the BMC (Baseboard Management Controller).
It provides bidirectional communication with a low latency.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linux/arch/powerpc/sysdev/pmi.c
===================================================================
--- /dev/null
+++ linux/arch/powerpc/sysdev/pmi.c
@@ -0,0 +1,305 @@
+/*
+ * pmi driver
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * PMI (Platform Management Interrupt) is a way to communicate
+ * with the BMC (Baseboard Management Controller) via interrupts.
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
+#include <linux/workqueue.h>
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
+	struct work_struct	work;
+};
+
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
+	u8 type;
+	int rc;
+
+	data = dev_id;
+
+	spin_lock(&data->pmi_spinlock);
+
+	type = ioread8(data->pmi_reg + PMI_READ_TYPE);
+	pr_debug("pmi: got message of type %d\n", type);
+
+	if (type & PMI_ACK && !data->completion) {
+		printk(KERN_WARNING "pmi: got unexpected ACK message.\n");
+		rc = -EIO;
+		goto unlock;
+	}
+
+	if (data->completion && !(type & PMI_ACK)) {
+		printk(KERN_WARNING "pmi: expected ACK, but got %d\n", type);
+		rc = -EIO;
+		goto unlock;
+	}
+
+	data->msg.type = type;
+	data->msg.data0 = ioread8(data->pmi_reg + PMI_READ_DATA0);
+	data->msg.data1 = ioread8(data->pmi_reg + PMI_READ_DATA1);
+	data->msg.data2 = ioread8(data->pmi_reg + PMI_READ_DATA2);
+	rc = 0;
+unlock:
+	spin_unlock(&data->pmi_spinlock);
+
+	if (rc == -EIO) {
+		rc = IRQ_HANDLED;
+		goto out;
+	}
+
+	if (data->msg.type & PMI_ACK) {
+		complete(data->completion);
+		rc = IRQ_HANDLED;
+		goto out;
+	}
+
+	schedule_work(&data->work);
+
+	rc = IRQ_HANDLED;
+out:
+	return rc;
+}
+
+
+static struct of_device_id pmi_match[] = {
+	{ .type = "ibm,pmi", .name = "ibm,pmi" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, pmi_match);
+
+static void pmi_notify_handlers(struct work_struct *work)
+{
+	struct pmi_data *data;
+	struct pmi_handler *handler;
+
+	data = container_of(work, struct pmi_data, work);
+
+	spin_lock(&data->handler_spinlock);
+	list_for_each_entry(handler, &data->handler, node) {
+		pr_debug(KERN_INFO "pmi: notifying handler %p\n", handler);
+		if (handler->type == data->msg.type)
+			handler->handle_pmi_message(data->dev, data->msg);
+	}
+	spin_unlock(&data->handler_spinlock);
+}
+
+static int pmi_of_probe(struct of_device *dev,
+			const struct of_device_id *match)
+{
+	struct device_node *np = dev->node;
+	struct pmi_data *data;
+	int rc;
+
+	data = kzalloc(sizeof(struct pmi_data), GFP_KERNEL);
+	if (!data) {
+		printk(KERN_ERR "pmi: could not allocate memory.\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	data->pmi_reg = of_iomap(np);
+	if (!data->pmi_reg) {
+		printk(KERN_ERR "pmi: invalid register address.\n");
+		rc = -EFAULT;
+		goto error_cleanup_data;
+	}
+
+	INIT_LIST_HEAD(&data->handler);
+
+	mutex_init(&data->msg_mutex);
+	spin_lock_init(&data->pmi_spinlock);
+	spin_lock_init(&data->handler_spinlock);
+
+	INIT_WORK(&data->work, pmi_notify_handlers);
+
+	dev->dev.driver_data = data;
+	data->dev = dev;
+
+	data->irq = irq_of_parse_and_map(np, 0);
+	if (data->irq == NO_IRQ) {
+		printk(KERN_ERR "pmi: invalid interrupt.\n");
+		rc = -EFAULT;
+		goto error_cleanup_iomap;
+	}
+
+	rc = request_irq(data->irq, pmi_irq_handler, 0, "pmi", data);
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
+	data = dev->dev.driver_data;
+
+	free_irq(data->irq, data);
+	iounmap(data->pmi_reg);
+
+	spin_lock(&data->handler_spinlock);
+
+	list_for_each_entry_safe(handler, tmp, &data->handler, node)
+		list_del(&handler->node);
+
+	spin_unlock(&data->handler_spinlock);
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
+void pmi_send_message(struct of_device *device, pmi_message_t msg)
+{
+	struct pmi_data *data;
+	unsigned long flags;
+	DECLARE_COMPLETION_ONSTACK(completion);
+
+	data = device->dev.driver_data;
+
+	mutex_lock(&data->msg_mutex);
+
+	data->msg = msg;
+	pr_debug("pmi_send_message: msg is %08x\n", *(u32*)&msg);
+
+	data->completion = &completion;
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
+	data->completion = NULL;
+
+	mutex_unlock(&data->msg_mutex);
+}
+EXPORT_SYMBOL_GPL(pmi_send_message);
+
+void pmi_register_handler(struct of_device *device,
+			  struct pmi_handler *handler)
+{
+	struct pmi_data *data;
+	data = device->dev.driver_data;
+
+	spin_lock(&data->handler_spinlock);
+	list_add_tail(&handler->node, &data->handler);
+	spin_unlock(&data->handler_spinlock);
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
+	data = device->dev.driver_data;
+
+	spin_lock(&data->handler_spinlock);
+	list_del(&handler->node);
+	spin_unlock(&data->handler_spinlock);
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
@@ -0,0 +1,67 @@
+#ifndef _POWERPC_PMI_H
+#define _POWERPC_PMI_H
+
+/*
+ * Definitions for talking with PMI device on PowerPC
+ *
+ * PMI (Platform Management Interrupt) is a way to communicate
+ * with the BMC (Baseboard Management Controller) via interrupts.
+ * Unlike IPMI it is bidirectional and has a low latency.
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
Index: linux/arch/powerpc/Kconfig
===================================================================
--- linux.orig/arch/powerpc/Kconfig
+++ linux/arch/powerpc/Kconfig
@@ -577,6 +577,15 @@ config RTAS_FLASH
 	tristate "Firmware flash interface"
 	depends on PPC64 && RTAS_PROC
 
+config PPC_PMI
+	tristate "Support for PMI"
+	depends PPC_IBM_CELL_BLADE
+	help
+	  PMI (Platform Management Interrupt) is a way to
+	  communicate with the BMC (Baseboard Mangement Controller).
+	  It is used in some IBM Cell blades.
+	default m
+
 config MMIO_NVRAM
 	bool
 	default n
Index: linux/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux.orig/arch/powerpc/configs/cell_defconfig
+++ linux/arch/powerpc/configs/cell_defconfig
@@ -147,6 +147,7 @@ CONFIG_PPC_RTAS=y
 # CONFIG_RTAS_ERROR_LOGGING is not set
 CONFIG_RTAS_PROC=y
 CONFIG_RTAS_FLASH=y
+CONFIG_PPC_PMI=m
 CONFIG_MMIO_NVRAM=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
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
