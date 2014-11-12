Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45E5F1A0185
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 17:34:30 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0EF3E140119
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 17:34:28 +1100 (AEDT)
Message-ID: <1415772441.5124.39.camel@kernel.crashing.org>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Wed, 12 Nov 2014 17:07:21 +1100
In-Reply-To: <20141110060424.9407.2498.stgit@localhost.localdomain>
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-10 at 11:35 +0530, Neelesh Gupta wrote:
> The patch exposes the available i2c busses on the PowerNV platform
> to the kernel and implements the bus driver to support i2c and
> smbus commands.
> The driver uses the platform device infrastructure to probe the busses
> on the platform and registers them with the i2c driver framework.
> 
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This version slightly modified removes the unrelated gunk in opal.c
(but needs to apply on top of some other patches in the powerpc tree)

The driver is the same, it's only the
arch/powerpc/platform/powernv/opal.c init bits that get cleaned up and
simplified.

From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Fri, 7 Nov 2014 16:20:07 +1100
Subject: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses

The patch exposes the available i2c busses on the PowerNV platform
to the kernel and implements the bus driver to support i2c and
smbus commands.

If the devices are found on the device tree for a given bus/adapter,
the platform init code registers them to the core and binds them
a static bus/adapter number, otherwise the driver registers the
adapter to get the adapter number dynamically.

Results:
--------
[root@tul176p1 ~]# ls -l /sys/class/i2c-adapter/
total 0
lrwxrwxrwx 1 root root 0 Oct 27 12:41 i2c-1 -> ../../devices/i2c-maxim:0/i2c-1
lrwxrwxrwx 1 root root 0 Oct 27 12:41 i2c-2 -> ../../devices/i2c-maxim:1/i2c-2
lrwxrwxrwx 1 root root 0 Oct 27 12:41 i2c-3 -> ../../devices/i2c-vpd:0/i2c-3
lrwxrwxrwx 1 root root 0 Oct 27 12:41 i2c-4 -> ../../devices/i2c-vpd:1/i2c-4
lrwxrwxrwx 1 root root 0 Oct 27 12:41 i2c-5 -> ../../devices/i2c-vpd:2/i2c-5
lrwxrwxrwx 1 root root 0 Oct 27 12:41 i2c-6 -> ../../devices/i2c-vpd:3/i2c-6
lrwxrwxrwx 1 root root 0 Oct 27 12:41 i2c-7 -> ../../devices/i2c-vpd:4/i2c-7
lrwxrwxrwx 1 root root 0 Oct 27 12:41 i2c-8 -> ../../devices/i2c-vpd:5/i2c-8
[root@tul176p1 ~]# ls -l /sys/class/i2c-adapter/i2c-1/
total 0
drwxr-xr-x 2 root root     0 Oct 27 12:41 1-0032
drwxr-xr-x 2 root root     0 Oct 27 12:41 1-0035
drwxr-xr-x 2 root root     0 Oct 27 12:41 1-0036
drwxr-xr-x 2 root root     0 Oct 27 12:41 1-0039
--w------- 1 root root 65536 Oct 27 12:44 delete_device
lrwxrwxrwx 1 root root     0 Oct 27 12:44 device -> ../../i2c-maxim:0
-r--r--r-- 1 root root 65536 Oct 27 12:41 name
--w------- 1 root root 65536 Oct 27 12:44 new_device
lrwxrwxrwx 1 root root     0 Oct 27 12:41 subsystem -> ../../../bus/i2c
-rw-r--r-- 1 root root 65536 Oct 27 12:41 uevent
[root@tul176p1 ~]# cat /sys/class/i2c-adapter/i2c-1/1-0032/name
slot-C10-C11
[root@tul176p1 ~]#

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h                |  22 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |  23 ++-
 drivers/i2c/busses/Kconfig                     |  11 +
 drivers/i2c/busses/Makefile                    |   1 +
 drivers/i2c/busses/i2c-opal.c                  | 276 +++++++++++++++++++++++++
 6 files changed, 328 insertions(+), 6 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-opal.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index a1bf400..a873193 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -153,6 +153,7 @@ struct opal_sg_list {
 #define OPAL_UNREGISTER_DUMP_REGION		102
 #define OPAL_IPMI_SEND				107
 #define OPAL_IPMI_RECV				108
+#define OPAL_I2C_REQUEST			109
 
 #ifndef __ASSEMBLY__
 
@@ -779,6 +780,24 @@ typedef struct oppanel_line {
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
 
@@ -941,7 +960,8 @@ int64_t opal_ipmi_send(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t msg_len);
 int64_t opal_ipmi_recv(uint64_t interface, struct opal_ipmi_msg *msg,
 		uint64_t *msg_len);
-
+int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
+			 struct opal_i2c_request *oreq);
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4ed13f8..a45148c 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -247,5 +247,6 @@ OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
 OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
+OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
 OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
 OPAL_CALL(opal_ipmi_recv,			OPAL_IPMI_RECV);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 0153064..a5b9b0e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -656,6 +656,14 @@ static void opal_console_create_devs(void)
 
 }
 
+static void opal_i2c_create_devs(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "ibm,power8-i2c-port")
+		of_platform_device_create(np, NULL, NULL);
+}
+
 static void opal_request_interrupts(void)
 {
 	const __be32 *irqs;
@@ -721,6 +729,9 @@ static int __init opal_init(void)
 	/* Create console platform devices */
 	opal_console_create_devs();
 
+	/* Create i2c platform devices */
+	opal_i2c_create_devs();
+
 	/* Register OPAL interrupts */
 	opal_request_interrupts();
 
@@ -777,11 +788,6 @@ void opal_shutdown(void)
 	opal_unregister_dump_region(OPAL_DUMP_REGION_LOG_BUF);
 }
 
-/* Export this so that test modules can use it */
-EXPORT_SYMBOL_GPL(opal_invalid_call);
-EXPORT_SYMBOL_GPL(opal_ipmi_send);
-EXPORT_SYMBOL_GPL(opal_ipmi_recv);
-
 /* Convert a region of vmalloc memory to an opal sg list */
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 					     unsigned long vmalloc_size)
@@ -844,3 +850,10 @@ void opal_free_sg_list(struct opal_sg_list *sg)
 			sg = NULL;
 	}
 }
+
+/* Export this so that test modules can use it */
+EXPORT_SYMBOL_GPL(opal_invalid_call);
+EXPORT_SYMBOL_GPL(opal_ipmi_send);
+EXPORT_SYMBOL_GPL(opal_ipmi_recv);
+EXPORT_SYMBOL_GPL(opal_i2c_request);
+
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2ac87fa..3ad6e17 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1021,4 +1021,15 @@ config SCx200_ACB
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
index 49bf07e..8f36ef7c 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -100,5 +100,6 @@ obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
 obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
+obj-$(CONFIG_I2C_OPAL)		+= i2c-opal.o
 
 ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
new file mode 100644
index 0000000..85aa089
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
+	switch(num) {
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
