Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0110.outbound.protection.outlook.com [65.55.169.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20C7B1A1D6D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 19:42:39 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage muram
Date: Mon, 24 Aug 2015 17:31:43 +0800
Message-ID: <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
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

muram is used for qe, add qe_muram_ functions to manage
muram.

Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
---
Changes for v2:
	- no changes
Changes for v3:
	- no changes
Changes for v4:
	- no changes
Changes for v5:
	- no changes
Changes for v5:
	- using genalloc instead rheap to manage QE MURAM
	- remove qe_reset from platform file, using 
	- subsys_initcall to call qe_init function.

 arch/powerpc/platforms/83xx/km83xx.c      |   2 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c |   2 -
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   2 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c |   2 -
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |   3 -
 arch/powerpc/platforms/85xx/common.c      |   1 -
 drivers/soc/fsl/qe/Kconfig                |   1 +
 drivers/soc/fsl/qe/Makefile               |   3 +-
 drivers/soc/fsl/qe/qe.c                   |  15 +++
 drivers/soc/fsl/qe/qe_common.c            | 193 ++++++++++++++++++++++++++++++
 include/linux/genalloc.h                  |   1 +
 include/soc/fsl/qe/qe.h                   |  67 +++++++++--
 12 files changed, 271 insertions(+), 21 deletions(-)
 create mode 100644 drivers/soc/fsl/qe/qe_common.c

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 996a109..7ecd758 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -136,8 +136,6 @@ static void __init mpc83xx_km_setup_arch(void)
 	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
 	np = of_find_node_by_name(NULL, "par_io");
 	if (np != NULL) {
 		par_io_init(np);
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 1efb6b4..20dce79 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -74,8 +74,6 @@ static void __init mpc832x_sys_setup_arch(void)
 	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
 	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 67b27b4..2e6a6a4 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -203,8 +203,6 @@ static void __init mpc832x_rdb_setup_arch(void)
 	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
 	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index a01d363..b1b8ab8 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -82,8 +82,6 @@ static void __init mpc836x_mds_setup_arch(void)
 	mpc83xx_setup_pci();
 
 #ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-
 	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index 64c5d17..9a5a00d 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -35,9 +35,6 @@ static void __init mpc836x_rdk_setup_arch(void)
 		ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
 
 	mpc83xx_setup_pci();
-#ifdef CONFIG_QUICC_ENGINE
-	qe_reset();
-#endif
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index a79d34e..d81ea0c 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -105,7 +105,6 @@ void __init mpc85xx_qe_init(void)
 		return;
 	}
 
-	qe_reset();
 	of_node_put(np);
 
 }
diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index ee692b0..6e82c89 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -5,6 +5,7 @@ config QUICC_ENGINE
 	bool "Freescale QUICC Engine (QE) Support"
 	depends on FSL_SOC && PPC32
 	select PPC_LIB_RHEAP
+	select GENERIC_ALLOCATOR
 	select CRC32
 	help
 	  The QUICC Engine (QE) is a new generation of communications
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
diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 4d17b2d..d8fd4cd 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -671,6 +671,21 @@ unsigned int qe_get_num_of_snums(void)
 }
 EXPORT_SYMBOL(qe_get_num_of_snums);
 
+static int __init qe_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np) {
+		pr_err("%s: Could not find Quicc Engine node\n", __func__);
+		return -ENODEV;
+	}
+	qe_reset();
+	of_node_put(np);
+	return 0;
+}
+subsys_initcall(qe_init);
+
 #if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC_85xx)
 static int qe_resume(struct platform_device *ofdev)
 {
diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
new file mode 100644
index 0000000..7f1762c
--- /dev/null
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -0,0 +1,193 @@
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
+#include <linux/genalloc.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/spinlock.h>
+#include <linux/export.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include <linux/io.h>
+#include <soc/fsl/qe/qe.h>
+
+static struct gen_pool *muram_pool;
+static struct genpool_data_align muram_pool_data;
+static spinlock_t qe_muram_lock;
+static u8 __iomem *muram_vbase;
+static phys_addr_t muram_pbase;
+
+struct muram_block {
+	struct list_head head;
+	unsigned long start;
+	int size;
+};
+
+static LIST_HEAD(muram_block_list);
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
+	muram_pool = gen_pool_create(1, -1);
+	gen_pool_set_algo(muram_pool, gen_pool_first_fit_align,
+			  &muram_pool_data);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-muram-data");
+	if (!np) {
+		/* try legacy bindings */
+		np = of_find_node_by_name(NULL, "data-only");
+		if (!np) {
+			pr_err("Cannot find CPM muram data node");
+			ret = -ENODEV;
+			goto out;
+		}
+	}
+
+	muram_pbase = of_translate_address(np, zero);
+	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
+		pr_err("Cannot translate zero through CPM muram node");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	while (of_address_to_resource(np, i++, &r) == 0) {
+		if (r.end > max)
+			max = r.end;
+		ret = gen_pool_add(muram_pool, r.start - muram_pbase,
+				   resource_size(&r), -1);
+		if (ret) {
+				pr_err("QE MURAM: could not add muram ");
+				pr_err("remainder to pool!\n");
+				return ret;
+			}
+
+	}
+
+	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
+	if (!muram_vbase) {
+		pr_err("Cannot map CPM muram");
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
+	struct muram_block *entry;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	muram_pool_data.align = align;
+	start = gen_pool_alloc(muram_pool, size);
+	memset(qe_muram_addr(start), 0, size);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out;
+	entry->start = start;
+	entry->size = size;
+	list_add(&entry->head, &muram_block_list);
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return start;
+out:
+	gen_pool_free(muram_pool, start, size);
+	return (unsigned long) -ENOMEM;
+}
+EXPORT_SYMBOL(qe_muram_alloc);
+
+/**
+ * qe_muram_free - free a chunk of multi-user ram
+ * @offset: The beginning of the chunk as returned by qe_muram_alloc().
+ */
+int qe_muram_free(unsigned long offset)
+{
+	unsigned long flags;
+	int size;
+	struct muram_block *tmp;
+
+	size = 0;
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	list_for_each_entry(tmp, &muram_block_list, head) {
+		if (tmp->start == offset) {
+			size = tmp->size;
+			list_del(&tmp->head);
+			kfree(tmp);
+			break;
+		}
+	}
+	gen_pool_free(muram_pool, offset, size);
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return size;
+}
+EXPORT_SYMBOL(qe_muram_free);
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
diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 55da07e..aaf3dc2 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -30,6 +30,7 @@
 #ifndef __GENALLOC_H__
 #define __GENALLOC_H__
 
+#include <linux/types.h>
 #include <linux/spinlock_types.h>
 
 struct device;
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 8bdd3fe..f8c02dd 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
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
 #include <soc/fsl/qe/immap_qe.h>
 
 #define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
@@ -187,12 +190,41 @@ static inline int qe_alive_during_sleep(void)
 }
 
 /* we actually use cpm_muram implementation, define this for convenience */
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
@@ -266,6 +298,27 @@ struct qe_bd {
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
