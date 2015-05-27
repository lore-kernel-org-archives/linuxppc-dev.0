Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0117.outbound.protection.outlook.com [65.55.169.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E98581A0FE0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 19:49:59 +1000 (AEST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
CC: <R63061@freescale.com>, Zhao Qiang <B45475@freescale.com>
Subject: [PATCH 1/2] qe_common: add qe common functions into qe_common.c
Date: Wed, 27 May 2015 17:11:59 +0800
Message-ID: <1432717920-43563-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

qe need to call some common functions,
add a new file drivers/soc/fsl/qe/qe_common.c
for them.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 drivers/soc/fsl/qe/Makefile    |   3 +-
 drivers/soc/fsl/qe/qe_common.c | 185 +++++++++++++++++++++++++++++++++++++++++
 include/soc/fsl/qe.h           |  75 +++++++++++++++--
 3 files changed, 253 insertions(+), 10 deletions(-)
 create mode 100644 drivers/soc/fsl/qe/qe_common.c

diff --git a/drivers/soc/fsl/qe/Makefile b/drivers/soc/fsl/qe/Makefile
index 703793f..49acb89 100644
--- a/drivers/soc/fsl/qe/Makefile
+++ b/drivers/soc/fsl/qe/Makefile
@@ -1,8 +1,7 @@
 #
 # Makefile for the linux ppc-specific parts of QE
 #
-obj-$(CONFIG_QUICC_ENGINE)	+= qe.o
-
+obj-$(CONFIG_QUICC_ENGINE)	+= qe.o qe_common.o
 obj-$(CONFIG_UCC)		+= ucc.o
 obj-$(CONFIG_UCC_SLOW)		+= ucc_slow.o
 obj-$(CONFIG_UCC_FAST)		+= ucc_fast.o
diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
new file mode 100644
index 0000000..382ee7c
--- /dev/null
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -0,0 +1,185 @@
+/*
+ * common qe code
+ *
+ * author: scott wood <scottwood@freescale.com>
+ *
+ * copyright 2007-2008,2010 freescale Semiconductor, Inc.
+ *
+ * some parts derived from commproc.c/qe2_common.c, which is:
+ * copyright (c) 1997 dan error_act (dmalek@jlc.net)
+ * copyright (c) 1999-2001 dan Malek <dan@embeddedalley.com>
+ * copyright (c) 2000 montavista Software, Inc (source@mvista.com)
+ * 2006 (c) montavista software, Inc.
+ * vitaly bordug <vbordug@ru.mvista.com>
+ *
+ * this program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the free software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/spinlock.h>
+#include <linux/export.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include <linux/io.h>
+#include <asm/rheap.h>
+#include <soc/fsl/qe.h>
+
+static spinlock_t qe_muram_lock;
+static rh_block_t qe_boot_muram_rh_block[16];
+static rh_info_t qe_muram_info;
+static u8 __iomem *muram_vbase;
+static phys_addr_t muram_pbase;
+
+/* max address size we deal with */
+#define OF_MAX_ADDR_CELLS	4
+
+int qe_muram_init(void)
+{
+	struct device_node *np;
+	struct resource r;
+	u32 zero[OF_MAX_ADDR_CELLS] = {};
+	resource_size_t max = 0;
+	int i = 0;
+	int ret = 0;
+
+	if (muram_pbase)
+		return 0;
+
+	spin_lock_init(&qe_muram_lock);
+	/* initialize the info header */
+	rh_init(&qe_muram_info, 1,
+	        sizeof(qe_boot_muram_rh_block) /
+	        sizeof(qe_boot_muram_rh_block[0]),
+	        qe_boot_muram_rh_block);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-muram-data");
+	if (!np) {
+		/* try legacy bindings */
+		np = of_find_node_by_name(NULL, "data-only");
+		if (!np) {
+			printk(KERN_ERR "Cannot find CPM muram data node");
+			ret = -ENODEV;
+			goto out;
+		}
+	}
+
+	muram_pbase = of_translate_address(np, zero);
+	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
+		printk(KERN_ERR "Cannot translate zero through CPM muram node");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	while (of_address_to_resource(np, i++, &r) == 0) {
+		if (r.end > max)
+			max = r.end;
+
+		rh_attach_region(&qe_muram_info, r.start - muram_pbase,
+				 resource_size(&r));
+	}
+
+	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
+	if (!muram_vbase) {
+		printk(KERN_ERR "Cannot map CPM muram");
+		ret = -ENOMEM;
+	}
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
+/**
+ * qe_muram_alloc - allocate the requested size worth of multi-user ram
+ * @size: number of bytes to allocate
+ * @align: requested alignment, in bytes
+ *
+ * This function returns an offset into the muram area.
+ * Use qe_dpram_addr() to get the virtual address of the area.
+ * Use qe_muram_free() to free the allocation.
+ */
+unsigned long qe_muram_alloc(unsigned long size, unsigned long align)
+{
+	unsigned long start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	qe_muram_info.alignment = align;
+	start = rh_alloc(&qe_muram_info, size, "commproc");
+	memset(qe_muram_addr(start), 0, size);
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return start;
+}
+EXPORT_SYMBOL(qe_muram_alloc);
+
+/**
+ * qe_muram_free - free a chunk of multi-user ram
+ * @offset: The beginning of the chunk as returned by qe_muram_alloc().
+ */
+int qe_muram_free(unsigned long offset)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	ret = rh_free(&qe_muram_info, offset);
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(qe_muram_free);
+
+/**
+ * qe_muram_alloc_fixed - reserve a specific region of multi-user ram
+ * @offset: the offset into the muram area to reserve
+ * @size: the number of bytes to reserve
+ *
+ * This function returns "start" on success, -ENOMEM on failure.
+ * Use qe_dpram_addr() to get the virtual address of the area.
+ * Use qe_muram_free() to free the allocation.
+ */
+unsigned long qe_muram_alloc_fixed(unsigned long offset, unsigned long size)
+{
+	unsigned long start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	qe_muram_info.alignment = 1;
+	start = rh_alloc_fixed(&qe_muram_info, offset, size, "commproc");
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return start;
+}
+EXPORT_SYMBOL(qe_muram_alloc_fixed);
+
+/**
+ * qe_muram_addr - turn a muram offset into a virtual address
+ * @offset: muram offset to convert
+ */
+void __iomem *qe_muram_addr(unsigned long offset)
+{
+	return muram_vbase + offset;
+}
+EXPORT_SYMBOL(qe_muram_addr);
+
+unsigned long qe_muram_offset(void __iomem *addr)
+{
+	return addr - (void __iomem *)muram_vbase;
+}
+EXPORT_SYMBOL(qe_muram_offset);
+
+/**
+ * qe_muram_dma - turn a muram virtual address into a DMA address
+ * @offset: virtual address from qe_muram_addr() to convert
+ */
+dma_addr_t qe_muram_dma(void __iomem *addr)
+{
+	return muram_pbase + ((u8 __iomem *)addr - muram_vbase);
+}
+EXPORT_SYMBOL(qe_muram_dma);
diff --git a/include/soc/fsl/qe.h b/include/soc/fsl/qe.h
index 5b54099..7291f7e 100644
--- a/include/soc/fsl/qe.h
+++ b/include/soc/fsl/qe.h
@@ -16,10 +16,13 @@
 #define _ASM_POWERPC_QE_H
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <asm/cpm.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/types.h>
 #include <soc/fsl/immap_qe.h>
 
 #define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
@@ -186,13 +189,48 @@ static inline int qe_alive_during_sleep(void)
 #endif
 }
 
-/* we actually use cpm_muram implementation, define this for convenience */
-#define qe_muram_init cpm_muram_init
-#define qe_muram_alloc cpm_muram_alloc
-#define qe_muram_alloc_fixed cpm_muram_alloc_fixed
-#define qe_muram_free cpm_muram_free
-#define qe_muram_addr cpm_muram_addr
-#define qe_muram_offset cpm_muram_offset
+int qe_muram_init(void);
+
+#if defined(CONFIG_QUICC_ENGINE)
+unsigned long qe_muram_alloc(unsigned long size, unsigned long align);
+int qe_muram_free(unsigned long offset);
+unsigned long qe_muram_alloc_fixed(unsigned long offset, unsigned long size);
+void __iomem *qe_muram_addr(unsigned long offset);
+unsigned long qe_muram_offset(void __iomem *addr);
+dma_addr_t qe_muram_dma(void __iomem *addr);
+#else
+static inline unsigned long qe_muram_alloc(unsigned long size,
+					    unsigned long align)
+{
+	return -ENOSYS;
+}
+
+static inline int qe_muram_free(unsigned long offset)
+{
+	return -ENOSYS;
+}
+
+static inline unsigned long qe_muram_alloc_fixed(unsigned long offset,
+						  unsigned long size)
+{
+	return -ENOSYS;
+}
+
+static inline void __iomem *qe_muram_addr(unsigned long offset)
+{
+	return NULL;
+}
+
+static inline unsigned long qe_muram_offset(void __iomem *addr)
+{
+	return -ENOSYS;
+}
+
+static inline dma_addr_t qe_muram_dma(void __iomem *addr)
+{
+	return 0;
+}
+#endif /* defined(CONFIG_QUICC_ENGINE) */
 
 /* Structure that defines QE firmware binary files.
  *
@@ -266,6 +304,27 @@ struct qe_bd {
 #define BD_STATUS_MASK	0xffff0000
 #define BD_LENGTH_MASK	0x0000ffff
 
+/* Buffer descriptor control/status used by serial
+ */
+
+#define BD_SC_EMPTY	(0x8000)	/* Receive is empty */
+#define BD_SC_READY	(0x8000)	/* Transmit is ready */
+#define BD_SC_WRAP	(0x2000)	/* Last buffer descriptor */
+#define BD_SC_INTRPT	(0x1000)	/* Interrupt on change */
+#define BD_SC_LAST	(0x0800)	/* Last buffer in frame */
+#define BD_SC_TC	(0x0400)	/* Transmit CRC */
+#define BD_SC_CM	(0x0200)	/* Continuous mode */
+#define BD_SC_ID	(0x0100)	/* Rec'd too many idles */
+#define BD_SC_P		(0x0100)	/* xmt preamble */
+#define BD_SC_BR	(0x0020)	/* Break received */
+#define BD_SC_FR	(0x0010)	/* Framing error */
+#define BD_SC_PR	(0x0008)	/* Parity error */
+#define BD_SC_NAK	(0x0004)	/* NAK - did not respond */
+#define BD_SC_OV	(0x0002)	/* Overrun */
+#define BD_SC_UN	(0x0002)	/* Underrun */
+#define BD_SC_CD	(0x0001)	/* */
+#define BD_SC_CL	(0x0001)	/* Collision */
+
 /* Alignment */
 #define QE_INTR_TABLE_ALIGN	16	/* ??? */
 #define QE_ALIGNMENT_OF_BD	8
-- 
2.1.0.27.g96db324
