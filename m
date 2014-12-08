Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86BEF1A0588
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 17:38:10 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 558A11400A0
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 17:38:10 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Mon, 8 Dec 2014 16:38:09 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AACBD2CE8067
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2014 17:38:04 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB86c4kx34930886
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2014 17:38:04 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB86c45O010452
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2014 17:38:04 +1100
Subject: [PATCH v3] i2c: Driver to expose PowerNV platform i2c busses
To: linuxppc-dev@ozlabs.org, devicetree@vger.kernel.org,
 linux-i2c@vger.kernel.org, wsa@the-dreams.de
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Mon, 08 Dec 2014 12:06:16 +0530
Message-ID: <20141208063039.14356.34770.stgit@localhost.localdomain>
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

v2 -> v3:
- Added the device tree binding documentation for the driver.
- Sorted the ordering of this new driver added in Makefile.
- Removed populating the superfluous .owner field in 'struct driver'.

 Documentation/devicetree/bindings/i2c/i2c-opal.txt |   37 +++
 arch/powerpc/include/asm/opal.h                    |   29 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |    1 
 arch/powerpc/platforms/powernv/opal.c              |   11 +
 drivers/i2c/busses/Kconfig                         |   11 +
 drivers/i2c/busses/Makefile                        |    1 
 drivers/i2c/busses/i2c-opal.c                      |  294 ++++++++++++++++++++
 7 files changed, 384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-opal.txt
 create mode 100644 drivers/i2c/busses/i2c-opal.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-opal.txt b/Documentation/devicetree/bindings/i2c/i2c-opal.txt
new file mode 100644
index 0000000..12bc614
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-opal.txt
@@ -0,0 +1,37 @@
+Device-tree bindings for I2C OPAL driver
+----------------------------------------
+
+Most of the device node and properties layout is specific to the firmware and
+used by the firmware itself for configuring the port. From the linux
+perspective, the properties of use are "ibm,port-name" and "ibm,opal-id".
+
+Required properties:
+
+- reg: Port-id within a given master
+- compatible: must be "ibm,opal-i2c"
+- ibm,opal-id: Refers to a specific bus and used to identify it when calling
+	       the relevant OPAL functions.
+- bus-frequency: Operating frequency of the i2c bus (in HZ). Informational for
+		 linux, used by the FW though.
+
+Optional properties:
+- ibm,port-name: Firmware provides this name that uniquely identifies the i2c
+		 port.
+
+The node contains a number of other properties that are used by the FW itself
+and depend on the specific hardware implementation. The example below depicts
+a P8 on-chip bus.
+
+Example:
+
+i2c-bus@0 {
+	reg = <0x0>;
+	bus-frequency = <0x61a80>;
+	compatible = "ibm,power8-i2c-port", "ibm,opal-i2c";
+	ibm,opal-id = <0x1>;
+	ibm,port-name = "p8_00000000_e1p0";
+	#address-cells = <0x1>;
+	phandle = <0x10000006>;
+	#size-cells = <0x0>;
+	linux,phandle = <0x10000006>;
+};
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9124b0e..537807b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -56,6 +56,14 @@ struct opal_sg_list {
 #define OPAL_HARDWARE_FROZEN	-13
 #define OPAL_WRONG_STATE	-14
 #define OPAL_ASYNC_COMPLETION	-15
+#define OPAL_I2C_TIMEOUT	-17
+#define OPAL_I2C_INVALID_CMD	-18
+#define OPAL_I2C_LBUS_PARITY	-19
+#define OPAL_I2C_BKEND_OVERRUN	-20
+#define OPAL_I2C_BKEND_ACCESS	-21
+#define OPAL_I2C_ARBT_LOST	-22
+#define OPAL_I2C_NACK_RCVD	-23
+#define OPAL_I2C_STOP_ERR	-24
 
 /* API Tokens (in r0) */
 #define OPAL_INVALID_CALL			-1
@@ -154,6 +162,7 @@ struct opal_sg_list {
 #define OPAL_HANDLE_HMI				98
 #define OPAL_REGISTER_DUMP_REGION		101
 #define OPAL_UNREGISTER_DUMP_REGION		102
+#define OPAL_I2C_REQUEST			109
 
 #ifndef __ASSEMBLY__
 
@@ -801,6 +810,24 @@ typedef struct oppanel_line {
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
 
@@ -963,6 +990,8 @@ int64_t opal_handle_hmi(void);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
+int64_t opal_i2c_request(uint64_t async_token, uint32_t bus_id,
+			 struct opal_i2c_request *oreq);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index feb549a..4673c02 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -250,3 +250,4 @@ OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
 OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CXL_MODE);
+OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index bb90e6e..994975e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -667,6 +667,14 @@ static void opal_console_create_devs(void)
 
 }
 
+static void opal_i2c_create_devs(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "ibm,opal-i2c")
+		of_platform_device_create(np, NULL, NULL);
+}
+
 static void opal_request_interrupts(void)
 {
 	const __be32 *irqs;
@@ -732,6 +740,9 @@ static int __init opal_init(void)
 	/* Create console platform devices */
 	opal_console_create_devs();
 
+	/* Create i2c platform devices */
+	opal_i2c_create_devs();
+
 	/* Register OPAL interrupts */
 	opal_request_interrupts();
 
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
index 78d56c5..e23ec81 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_I2C_ACORN)		+= i2c-acorn.o
 obj-$(CONFIG_I2C_BCM_KONA)	+= i2c-bcm-kona.o
 obj-$(CONFIG_I2C_CROS_EC_TUNNEL)	+= i2c-cros-ec-tunnel.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
+obj-$(CONFIG_I2C_OPAL)		+= i2c-opal.o
 obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
 obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
new file mode 100644
index 0000000..16f90b1
--- /dev/null
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -0,0 +1,294 @@
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
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <asm/firmware.h>
+#include <asm/opal.h>
+
+static int i2c_opal_translate_error(int rc)
+{
+	switch (rc) {
+	case OPAL_NO_MEM:
+		return -ENOMEM;
+	case OPAL_PARAMETER:
+		return -EINVAL;
+	case OPAL_I2C_ARBT_LOST:
+		return -EAGAIN;
+	case OPAL_I2C_TIMEOUT:
+		return -ETIMEDOUT;
+	case OPAL_I2C_NACK_RCVD:
+		return -ENXIO;
+	case OPAL_I2C_STOP_ERR:
+		return -EBUSY;
+	default:
+		return -EIO;
+	}
+}
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
+		rc = i2c_opal_translate_error(rc);
+		goto exit;
+	}
+
+	rc = opal_async_wait_response(token, &msg);
+	if (rc)
+		goto exit;
+
+	rc = be64_to_cpu(msg.params[1]);
+	if (rc != OPAL_SUCCESS) {
+		rc = i2c_opal_translate_error(rc);
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
+			return -EOPNOTSUPP;
+		if (msgs[0].len > 4)
+			return -EOPNOTSUPP;
+		if (msgs[0].addr != msgs[1].addr)
+			return -EOPNOTSUPP;
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
+		return -EOPNOTSUPP;
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
+
+	rc = of_property_read_u32(pdev->dev.of_node, "ibm,opal-id", &opal_id);
+	if (rc) {
+		dev_err(&pdev->dev, "Missing ibm,opal-id property !\n");
+		return -EIO;
+	}
+
+	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return -ENOMEM;
+
+	adapter->algo = &i2c_opal_algo;
+	adapter->algo_data = (void *)(unsigned long)opal_id;
+	adapter->dev.parent = &pdev->dev;
+	adapter->dev.of_node = of_node_get(pdev->dev.of_node);
+	pname = of_get_property(pdev->dev.of_node, "ibm,port-name", NULL);
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
+	return 0;
+}
+
+static const struct of_device_id i2c_opal_of_match[] = {
+	{
+		.compatible = "ibm,opal-i2c",
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
+module_init(i2c_opal_init);
+
+static void __exit i2c_opal_exit(void)
+{
+	return platform_driver_unregister(&i2c_opal_driver);
+}
+module_exit(i2c_opal_exit);
+
+MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("IBM OPAL I2C driver");
+MODULE_LICENSE("GPL");
