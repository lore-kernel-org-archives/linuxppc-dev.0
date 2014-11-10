Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 340601A012A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 17:09:42 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 739BA1400EA
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2014 17:09:41 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Mon, 10 Nov 2014 11:39:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 24E64394005E
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2014 11:39:35 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAA697tR49938540
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2014 11:39:51 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAA678ob003218
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2014 11:37:09 +0530
Subject: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
To: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Mon, 10 Nov 2014 11:35:39 +0530
Message-ID: <20141110060424.9407.2498.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch exposes the available i2c busses on the PowerNV platform
to the kernel and implements the bus driver to support i2c and
smbus commands.
The driver uses the platform device infrastructure to probe the busses
on the platform and registers them with the i2c driver framework.

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h                |   21 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 arch/powerpc/platforms/powernv/opal.c          |   48 +++-
 drivers/i2c/busses/Kconfig                     |   11 +
 drivers/i2c/busses/Makefile                    |    1 
 drivers/i2c/busses/i2c-opal.c                  |  276 ++++++++++++++++++++++++
 6 files changed, 349 insertions(+), 9 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-opal.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9124b0e..7e94577 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -154,6 +154,7 @@ struct opal_sg_list {
 #define OPAL_HANDLE_HMI				98
 #define OPAL_REGISTER_DUMP_REGION		101
 #define OPAL_UNREGISTER_DUMP_REGION		102
+#define OPAL_I2C_REQUEST			109
 
 #ifndef __ASSEMBLY__
 
@@ -801,6 +802,24 @@ typedef struct oppanel_line {
 	uint64_t 	line_len;
 } oppanel_line_t;
 
+/* OPAL I2C request */
+struct opal_i2c_request {
+	uint8_t	type;
+#define OPAL_I2C_RAW_READ	0
+#define OPAL_I2C_RAW_WRITE	1
+#define OPAL_I2C_SM_READ	2
+#define OPAL_I2C_SM_WRITE	3
+	uint8_t flags;
+#define OPAL_I2C_ADDR_10	0x01	/* Not supported yet */
+	uint8_t	subaddr_sz;		/* Max 4 */
+	uint8_t reserved;
+	__be16 addr;			/* 7 or 10 bit address */
+	__be16 reserved2;
+	__be32 subaddr;		/* Sub-address if any */
+	__be32 size;			/* Data size */
+	__be64 buffer_ra;		/* Buffer real address */
+};
+
 /* /sys/firmware/opal */
 extern struct kobject *opal_kobj;
 
@@ -963,6 +982,8 @@ int64_t opal_handle_hmi(void);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
+int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
+			 struct opal_i2c_request *oreq);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e9e2450..b84224b 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -250,3 +250,4 @@ OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
 OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CXL_MODE);
+OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index d019b08..217630b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -644,17 +644,10 @@ static void __init opal_dump_region_init(void)
 		pr_warn("DUMP: Failed to register kernel log buffer. "
 			"rc = %d\n", rc);
 }
-static int __init opal_init(void)
+
+static void opal_console_create_devs(void)
 {
 	struct device_node *np, *consoles;
-	const __be32 *irqs;
-	int rc, i, irqlen;
-
-	opal_node = of_find_node_by_path("/ibm,opal");
-	if (!opal_node) {
-		pr_warn("opal: Node not found\n");
-		return -ENODEV;
-	}
 
 	/* Register OPAL consoles if any ports */
 	if (firmware_has_feature(FW_FEATURE_OPALv2))
@@ -670,6 +663,21 @@ static int __init opal_init(void)
 		of_node_put(consoles);
 	}
 
+}
+
+static void opal_i2c_create_devs(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "ibm,power8-i2c-port")
+		of_platform_device_create(np, NULL, NULL);
+}
+
+static void opal_request_interrupts(void)
+{
+	const __be32 *irqs;
+	int rc, i, irqlen;
+
 	/* Find all OPAL interrupts and request them */
 	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
 	pr_debug("opal: Found %d interrupts reserved for OPAL\n",
@@ -689,6 +697,26 @@ static int __init opal_init(void)
 				   " (0x%x)\n", rc, irq, hwirq);
 		opal_irqs[i] = irq;
 	}
+}
+
+static int __init opal_init(void)
+{
+	int rc;
+
+	opal_node = of_find_node_by_path("/ibm,opal");
+	if (!opal_node) {
+		pr_warn("opal: Node not found\n");
+		return -ENODEV;
+	}
+
+	/* Create console platform devices */
+	opal_console_create_devs();
+
+	/* Create i2c platform devices */
+	opal_i2c_create_devs();
+
+	/* Register OPAL interrupts */
+	opal_request_interrupts();
 
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
@@ -805,3 +833,5 @@ void opal_free_sg_list(struct opal_sg_list *sg)
 			sg = NULL;
 	}
 }
+
+EXPORT_SYMBOL_GPL(opal_i2c_request);
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 917c358..71ad6e1 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1044,4 +1044,15 @@ config SCx200_ACB
 	  This support is also available as a module.  If so, the module
 	  will be called scx200_acb.
 
+config I2C_OPAL
+	tristate "IBM OPAL I2C driver"
+	depends on PPC_POWERNV
+	default y
+	help
+	  This exposes the PowerNV platform i2c busses to the linux i2c layer,
+	  the driver is based on the OPAL interfaces.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called as i2c-opal.
+
 endmenu
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 78d56c5..350aa86 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -102,5 +102,6 @@ obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
 obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
+obj-$(CONFIG_I2C_OPAL)		+= i2c-opal.o
 
 ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
new file mode 100644
index 0000000..3261716
--- /dev/null
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -0,0 +1,276 @@
+/*
+ * IBM OPAL I2C driver
+ * Copyright (C) 2014 IBM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/mm.h>
+#include <asm/opal.h>
+#include <asm/firmware.h>
+
+static int i2c_opal_send_request(u32 bus_id, struct opal_i2c_request *req)
+{
+	struct opal_msg msg;
+	int token, rc;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0) {
+		if (token != -ERESTARTSYS)
+			pr_err("Failed to get the async token\n");
+
+		return token;
+	}
+
+	rc = opal_i2c_request(token, bus_id, req);
+	if (rc != OPAL_ASYNC_COMPLETION) {
+		rc = -EIO;
+		goto exit;
+	}
+
+	rc = opal_async_wait_response(token, &msg);
+	if (rc) {
+		rc = -EIO;
+		goto exit;
+	}
+
+	rc = be64_to_cpu(msg.params[1]);
+	if (rc != OPAL_SUCCESS) {
+		rc = -EIO;
+		goto exit;
+	}
+
+exit:
+	opal_async_release_token(token);
+	return rc;
+}
+
+static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+				int num)
+{
+	unsigned long opal_id = (unsigned long)adap->algo_data;
+	struct opal_i2c_request req;
+	int rc, i;
+
+	/* We only support fairly simple combinations here of one
+	 * or two messages
+	 */
+	memset(&req, 0, sizeof(req));
+	switch (num) {
+	case 0:
+		return 0;
+	case 1:
+		req.type = (msgs[0].flags & I2C_M_RD) ?
+			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
+		req.addr = cpu_to_be16(msgs[0].addr);
+		req.size = cpu_to_be32(msgs[0].len);
+		req.buffer_ra = cpu_to_be64(__pa(msgs[0].buf));
+		break;
+	case 2:
+		/* For two messages, we basically support only simple
+		 * smbus transactions of a write plus a read. We might
+		 * want to allow also two writes but we'd have to bounce
+		 * the data into a single buffer.
+		 */
+		if ((msgs[0].flags & I2C_M_RD) || !(msgs[1].flags & I2C_M_RD))
+			return -EIO;
+		if (msgs[0].len > 4)
+			return -EIO;
+		if (msgs[0].addr != msgs[1].addr)
+			return -EIO;
+		req.type = OPAL_I2C_SM_READ;
+		req.addr = cpu_to_be16(msgs[0].addr);
+		req.subaddr_sz = msgs[0].len;
+		for (i = 0; i < msgs[0].len; i++)
+			req.subaddr = (req.subaddr << 8) | msgs[0].buf[i];
+		req.subaddr = cpu_to_be32(req.subaddr);
+		req.size = cpu_to_be32(msgs[1].len);
+		req.buffer_ra = cpu_to_be64(__pa(msgs[1].buf));
+		break;
+	default:
+		return -EIO;
+	}
+
+	rc = i2c_opal_send_request(opal_id, &req);
+	if (rc)
+		return rc;
+
+	return num;
+}
+
+static int i2c_opal_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size, union i2c_smbus_data *data)
+{
+	unsigned long opal_id = (unsigned long)adap->algo_data;
+	struct opal_i2c_request req;
+	u8 local[2];
+	int rc;
+
+	memset(&req, 0, sizeof(req));
+
+	req.addr = cpu_to_be16(addr);
+	switch (size) {
+	case I2C_SMBUS_BYTE:
+		req.buffer_ra = cpu_to_be64(__pa(&data->byte));
+		req.size = cpu_to_be32(1);
+		/* Fall through */
+	case I2C_SMBUS_QUICK:
+		req.type = (read_write == I2C_SMBUS_READ) ?
+			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		req.buffer_ra = cpu_to_be64(__pa(&data->byte));
+		req.size = cpu_to_be32(1);
+		req.subaddr = cpu_to_be32(command);
+		req.subaddr_sz = 1;
+		req.type = (read_write == I2C_SMBUS_READ) ?
+			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		if (!read_write) {
+			local[0] = data->word & 0xff;
+			local[1] = (data->word >> 8) & 0xff;
+		}
+		req.buffer_ra = cpu_to_be64(__pa(local));
+		req.size = cpu_to_be32(2);
+		req.subaddr = cpu_to_be32(command);
+		req.subaddr_sz = 1;
+		req.type = (read_write == I2C_SMBUS_READ) ?
+			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
+		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		req.buffer_ra = cpu_to_be64(__pa(&data->block[1]));
+		req.size = cpu_to_be32(data->block[0]);
+		req.subaddr = cpu_to_be32(command);
+		req.subaddr_sz = 1;
+		req.type = (read_write == I2C_SMBUS_READ) ?
+			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rc = i2c_opal_send_request(opal_id, &req);
+	if (!rc && read_write && size == I2C_SMBUS_WORD_DATA) {
+		data->word = ((u16)local[1]) << 8;
+		data->word |= local[0];
+	}
+
+	return rc;
+}
+
+static u32 i2c_opal_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_I2C_BLOCK;
+}
+
+static const struct i2c_algorithm i2c_opal_algo = {
+	.master_xfer	= i2c_opal_master_xfer,
+	.smbus_xfer	= i2c_opal_smbus_xfer,
+	.functionality	= i2c_opal_func,
+};
+
+static int i2c_opal_probe(struct platform_device *pdev)
+{
+	struct i2c_adapter	*adapter;
+	const char		*pname;
+	u32			opal_id;
+	int			rc;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+	rc = of_property_read_u32(pdev->dev.of_node, "ibm,opal-id", &opal_id);
+	if (rc) {
+		dev_err(&pdev->dev, "Missing ibm,opal-id property !\n");
+		return -EIO;
+	}
+	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	if (!adapter)
+		return -ENOMEM;
+	adapter->algo = &i2c_opal_algo;
+	adapter->algo_data = (void *)(unsigned long)opal_id;
+	adapter->dev.parent = &pdev->dev;
+	adapter->dev.of_node = of_node_get(pdev->dev.of_node);
+	pname = of_get_property(pdev->dev.of_node, "port-name", NULL);
+	if (pname)
+		strlcpy(adapter->name, pname, sizeof(adapter->name));
+	else
+		strlcpy(adapter->name, "opal", sizeof(adapter->name));
+
+	platform_set_drvdata(pdev, adapter);
+	rc = i2c_add_adapter(adapter);
+	if (rc)
+		dev_err(&pdev->dev, "Failed to register the i2c adapter\n");
+
+	return rc;
+}
+
+static int i2c_opal_remove(struct platform_device *pdev)
+{
+	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(adapter);
+
+	kfree(adapter);
+
+	return 0;
+}
+
+static const struct of_device_id i2c_opal_of_match[] = {
+	{
+		.compatible = "ibm,power8-i2c-port",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, i2c_opal_of_match);
+
+static struct platform_driver i2c_opal_driver = {
+	.probe	= i2c_opal_probe,
+	.remove	= i2c_opal_remove,
+	.driver	= {
+		.name		= "i2c-opal",
+		.owner		= THIS_MODULE,
+		.of_match_table	= i2c_opal_of_match,
+	},
+};
+
+static int __init i2c_opal_init(void)
+{
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
+		return -ENODEV;
+
+	return platform_driver_register(&i2c_opal_driver);
+}
+
+static void __exit i2c_opal_exit(void)
+{
+	return platform_driver_unregister(&i2c_opal_driver);
+}
+
+MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("IBM OPAL I2C driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_opal_init);
+module_exit(i2c_opal_exit);
