Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnHXH4CtszDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 03:57:03 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5DHrpA5125315
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 13:57:00 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b2mqr8cd4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 13:57:00 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 14 Jun 2017 03:56:57 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5DHut8a4784424
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 03:56:55 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5DHuk1r001319
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 03:56:47 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V2 2/2] powerpc/powernv : Add support for OPAL-OCC
 command/response interface
Date: Tue, 13 Jun 2017 23:26:41 +0530
In-Reply-To: <1497376601-23604-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1497376601-23604-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1497376601-23604-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In P9, OCC (On-Chip-Controller) supports shared memory based
commad-response interface. Within the shared memory there is an OPAL
command buffer and OCC response buffer that can be used to send
inband commands to OCC. This patch adds a platform driver to support
the command/response interface between OCC and the host.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V2:
- Remove spinlock and use atomic_t for setting and clearing flags
- Fix endian swapping
- Use pa() and va() before and after opal call for accessing buffer
  data
- Replace (u8 *) with __be64 for buffer pointers
- User reads the previous OCC response if the user does a read()
  before a write(). Is this wrong?
- Add WARN_ON check for nr_occs > 254

 arch/powerpc/include/asm/opal-api.h            |  41 +++-
 arch/powerpc/include/asm/opal.h                |   3 +
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/opal-occ.c      | 314 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |   8 +
 6 files changed, 367 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index cb3e624..011d86c 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -42,6 +42,10 @@
 #define OPAL_I2C_STOP_ERR	-24
 #define OPAL_XIVE_PROVISIONING	-31
 #define OPAL_XIVE_FREE_ACTIVE	-32
+#define OPAL_OCC_INVALID_STATE	-33
+#define OPAL_OCC_BUSY		-34
+#define OPAL_OCC_CMD_TIMEOUT	-35
+#define OPAL_OCC_RSP_MISMATCH	-36
 
 /* API Tokens (in r0) */
 #define OPAL_INVALID_CALL		       -1
@@ -190,7 +194,8 @@
 #define OPAL_NPU_INIT_CONTEXT			146
 #define OPAL_NPU_DESTROY_CONTEXT		147
 #define OPAL_NPU_MAP_LPAR			148
-#define OPAL_LAST				148
+#define OPAL_OCC_COMMAND			149
+#define OPAL_LAST				149
 
 /* Device tree flags */
 
@@ -829,6 +834,40 @@ struct opal_prd_msg_header {
 
 struct opal_prd_msg;
 
+enum occ_cmd {
+	OCC_CMD_AMESTER_PASS_THRU = 0,
+	OCC_CMD_CLEAR_SENSOR_DATA,
+	OCC_CMD_SET_POWER_CAP,
+	OCC_CMD_SET_POWER_SHIFTING_RATIO,
+	OCC_CMD_SELECT_SENSOR_GROUPS,
+	OCC_CMD_LAST
+};
+
+struct opal_occ_cmd_rsp_msg {
+	__be64 cdata;
+	__be64 rdata;
+	__be16 cdata_size;
+	__be16 rdata_size;
+	u8 cmd;
+	u8 request_id;
+	u8 status;
+};
+
+struct opal_occ_cmd_data {
+	__be16 size;
+	u8 cmd;
+	u8 data[];
+};
+
+struct opal_occ_rsp_data {
+	__be16 size;
+	u8 status;
+	u8 data[];
+};
+
+#define MAX_OPAL_CMD_DATA_LENGTH        4090
+#define MAX_OCC_RSP_DATA_LENGTH         8698
+
 #define OCC_RESET                       0
 #define OCC_LOAD                        1
 #define OCC_THROTTLE                    2
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 03ed493..e55ed79 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -346,6 +346,9 @@ static inline int opal_get_async_rc(struct opal_msg msg)
 
 void opal_wake_poller(void);
 
+int64_t opal_occ_command(int chip_id, struct opal_occ_cmd_rsp_msg *msg,
+			 bool retry);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..f5f0902 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o
+obj-y			+= opal-kmsg.o opal-occ.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-occ.c b/arch/powerpc/platforms/powernv/opal-occ.c
new file mode 100644
index 0000000..912cdc4
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-occ.c
@@ -0,0 +1,314 @@
+/*
+ * Copyright IBM Corporation 2017
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) "opal-occ: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+#include <linux/highmem.h>
+#include <linux/slab.h>
+#include <asm/opal.h>
+
+struct occ {
+	struct miscdevice dev;
+	struct opal_occ_rsp_data *rsp;
+	atomic_t session;
+	atomic_t cmd_in_progress;
+	int id;
+	u8 last_token;
+} *occs;
+static int nr_occs;
+
+static int __send_occ_command(struct opal_occ_cmd_rsp_msg *msg,
+			      int chip_id, bool retry)
+{
+	struct opal_msg async_msg;
+	int rc;
+
+	if (!retry) {
+		msg->cdata = cpu_to_be64(__pa(msg->cdata));
+		msg->cdata_size = cpu_to_be16(msg->cdata_size);
+		msg->rdata = cpu_to_be64(__pa(msg->rdata));
+	}
+
+	rc = opal_occ_command(chip_id, msg, retry);
+	if (rc == OPAL_ASYNC_COMPLETION) {
+		rc = opal_async_wait_response(msg->request_id, &async_msg);
+		if (rc) {
+			pr_info("Failed to wait for async response %d\n", rc);
+			return rc;
+		}
+	} else if (rc) {
+		pr_info("Failed to send opal_occ_command %d\n", rc);
+		return rc;
+	}
+
+	rc = opal_get_async_rc(async_msg);
+	if (rc) {
+		pr_info("opal_occ_command failed with %d\n", rc);
+		return rc;
+	}
+
+	msg->rdata_size = be16_to_cpu(msg->rdata_size);
+	msg->rdata = be64_to_cpu(__va(msg->rdata));
+	msg->cdata_size = be16_to_cpu(msg->cdata_size);
+	msg->cdata = be64_to_cpu(__va(msg->cdata));
+
+	if (msg->rdata_size > MAX_OCC_RSP_DATA_LENGTH) {
+		pr_info("Opal sent bigger data, clipping to the max response size\n");
+		msg->rdata_size = MAX_OCC_RSP_DATA_LENGTH;
+	}
+
+	return rc;
+}
+
+static int send_occ_command(struct opal_occ_cmd_rsp_msg *msg, struct occ *occ)
+{
+	int token, rc;
+
+	token = opal_async_get_unique_token_interruptible(occ->last_token);
+	if (token < 0) {
+		pr_info("Failed to get the request_id/token for command %d (%d)\n",
+			msg->cmd, token);
+		return token;
+	}
+
+	msg->request_id = token;
+	rc = __send_occ_command(msg, occ->id, false);
+
+	switch (rc) {
+	case OPAL_OCC_CMD_TIMEOUT:
+	case OPAL_OCC_RSP_MISMATCH:
+		occ->last_token = token;
+		opal_async_release_token(token);
+		token = opal_async_get_unique_token_interruptible(token);
+		if (token < 0) {
+			pr_info("Failed to get the request_id/token for retry command %d (%d)\n",
+				msg->cmd, token);
+
+			return opal_error_code(rc);
+		}
+
+		msg->request_id = token;
+		rc = __send_occ_command(msg, occ->id, true);
+		break;
+	default:
+		break;
+	}
+
+	occ->last_token = token;
+	opal_async_release_token(token);
+	return opal_error_code(rc);
+}
+
+static int opal_occ_cmd_prepare(struct opal_occ_cmd_data *cmd, struct occ *occ)
+{
+	struct opal_occ_cmd_rsp_msg msg;
+	int rc;
+
+	msg.cmd = cmd->cmd;
+	msg.cdata_size = cmd->size;
+	msg.rdata = (u64)occ->rsp->data;
+	msg.cdata = (u64)cmd->data;
+	rc = send_occ_command(&msg, occ);
+	if (rc)
+		return rc;
+
+	occ->rsp->size = msg.rdata_size;
+	occ->rsp->status = msg.status;
+
+	return rc;
+}
+
+static ssize_t opal_occ_write(struct file *file, const char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct miscdevice *dev = file->private_data;
+	struct occ *occ = container_of(dev, struct occ, dev);
+	struct opal_occ_cmd_data *cmd;
+	int rc;
+
+	if (count < sizeof(*cmd))
+		return -EINVAL;
+
+	if (atomic_xchg(&occ->cmd_in_progress, 1) == 1)
+		return -EBUSY;
+
+	cmd = kmalloc(count, GFP_KERNEL);
+	if (!cmd) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = copy_from_user(cmd, buf, count);
+	if (rc) {
+		pr_err("Failed to copy OCC command request message\n");
+		rc = -EFAULT;
+		goto free_cmd;
+	}
+
+	if (cmd->size > MAX_OPAL_CMD_DATA_LENGTH) {
+		rc = -EINVAL;
+		goto free_cmd;
+	}
+
+	rc = opal_occ_cmd_prepare(cmd, occ);
+	if (!rc)
+		rc = count;
+
+free_cmd:
+	kfree(cmd);
+out:
+	atomic_xchg(&occ->cmd_in_progress, 0);
+	return rc;
+}
+
+static ssize_t opal_occ_read(struct file *file, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	struct miscdevice *dev = file->private_data;
+	struct occ *occ = container_of(dev, struct occ, dev);
+	int rc;
+
+	if (count < sizeof(*occ->rsp) + occ->rsp->size)
+		return -EINVAL;
+
+	rc = copy_to_user((void __user *)buf, occ->rsp,
+			  sizeof(occ->rsp) + occ->rsp->size);
+	if (rc) {
+		pr_err("Failed to copy OCC response data to user\n");
+		return rc;
+	}
+
+	return sizeof(*occ->rsp) + occ->rsp->size;
+}
+
+static int opal_occ_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *dev = file->private_data;
+	struct occ *occ = container_of(dev, struct occ, dev);
+
+	if (atomic_xchg(&occ->session, 1) == 1)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int opal_occ_release(struct inode *inode, struct file *file)
+{
+	struct miscdevice *dev = file->private_data;
+	struct occ *occ = container_of(dev, struct occ, dev);
+
+	atomic_xchg(&occ->session, 0);
+
+	return 0;
+}
+
+static const struct file_operations opal_occ_fops = {
+	.open		= opal_occ_open,
+	.read		= opal_occ_read,
+	.write		= opal_occ_write,
+	.release	= opal_occ_release,
+	.owner		= THIS_MODULE,
+};
+
+static int opal_occ_probe(struct platform_device *pdev)
+{
+	unsigned int chip[256];
+	unsigned int cpu;
+	unsigned int prev_chip_id = UINT_MAX;
+	int i, rc;
+
+	for_each_possible_cpu(cpu) {
+		unsigned int id = cpu_to_chip_id(cpu);
+
+		if (prev_chip_id != id) {
+			prev_chip_id = id;
+			chip[nr_occs++] = id;
+			WARN_ON(nr_occs > 254);
+		}
+	}
+
+	occs = kcalloc(nr_occs, sizeof(*occs), GFP_KERNEL);
+	if (!occs)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_occs; i++) {
+		char name[10];
+
+		occs[i].id = chip[i];
+		occs[i].dev.minor = MISC_DYNAMIC_MINOR;
+		snprintf(name, 10, "occ%d", chip[i]);
+		occs[i].dev.name = name;
+		occs[i].dev.fops = &opal_occ_fops;
+		occs[i].last_token = -1;
+		occs[i].rsp = kmalloc(sizeof(occs[i].rsp) +
+				      MAX_OCC_RSP_DATA_LENGTH,
+				      GFP_KERNEL);
+		if (!occs[i].rsp) {
+			rc = -ENOMEM;
+			goto free_occs;
+		}
+
+		rc = misc_register(&occs[i].dev);
+		if (rc)
+			goto free_occ_rsp_data;
+	}
+
+	return 0;
+
+free_occ_rsp_data:
+	kfree(occs[i].rsp);
+free_occs:
+	while (--i >= 0) {
+		kfree(occs[i].rsp);
+		misc_deregister(&occs[i].dev);
+	}
+	kfree(occs);
+
+	return rc;
+}
+
+static int opal_occ_remove(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < nr_occs; i++) {
+		kfree(occs[i].rsp);
+		misc_deregister(&occs[i].dev);
+	}
+
+	kfree(occs);
+	return 0;
+}
+
+static const struct of_device_id opal_occ_match[] = {
+	{ .compatible = "ibm,opal-occ-cmd-rsp-interface" },
+	{ },
+};
+
+static struct platform_driver opal_occ_driver = {
+	.driver = {
+		.name           = "opal-occ",
+		.of_match_table = opal_occ_match,
+	},
+	.probe	= opal_occ_probe,
+	.remove	= opal_occ_remove,
+};
+
+module_platform_driver(opal_occ_driver);
+
+MODULE_DESCRIPTION("PowerNV OPAL-OCC driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f620572..e6bf18d 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -310,3 +310,4 @@ OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
 OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
 OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
 OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
+OPAL_CALL(opal_occ_command,			OPAL_OCC_COMMAND);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 59684b4..d87c61b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -815,6 +815,9 @@ static int __init opal_init(void)
 	opal_pdev_init("ibm,opal-flash");
 	opal_pdev_init("ibm,opal-prd");
 
+	/* Initialize platform device: OCC_OPAL command-response interface */
+	opal_pdev_init("ibm,opal-occ-cmd-rsp-interface");
+
 	/* Initialise platform device: oppanel interface */
 	opal_pdev_init("ibm,opal-oppanel");
 
@@ -859,6 +862,7 @@ void opal_shutdown(void)
 EXPORT_SYMBOL_GPL(opal_flash_write);
 EXPORT_SYMBOL_GPL(opal_flash_erase);
 EXPORT_SYMBOL_GPL(opal_prd_msg);
+EXPORT_SYMBOL_GPL(opal_occ_command);
 
 /* Convert a region of vmalloc memory to an opal sg list */
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
@@ -937,6 +941,10 @@ int opal_error_code(int rc)
 	case OPAL_UNSUPPORTED:		return -EIO;
 	case OPAL_HARDWARE:		return -EIO;
 	case OPAL_INTERNAL_ERROR:	return -EIO;
+	case OPAL_OCC_BUSY:		return -EBUSY;
+	case OPAL_OCC_INVALID_STATE:
+	case OPAL_OCC_CMD_TIMEOUT:
+	case OPAL_OCC_RSP_MISMATCH:	return -EIO;
 	default:
 		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
 		return -EIO;
-- 
1.8.3.1
