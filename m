Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0131.outbound.protection.outlook.com [157.56.111.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DEAA1A2C26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 11:45:01 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v9 3/5] qe_common: add qe_muram_ functions to manage muram
Date: Mon, 14 Sep 2015 09:38:18 +0800
Message-ID: <1442194700-6194-3-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1442194700-6194-1-git-send-email-qiang.zhao@freescale.com>
References: <1442194700-6194-1-git-send-email-qiang.zhao@freescale.com>
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
Changes for v6:
	- using genalloc instead rheap to manage QE MURAM
	- remove qe_reset from platform file, using 
	- subsys_initcall to call qe_init function.
Changes for v7:
	- move this patch from 3/3 to 2/3
	- convert cpm with genalloc
	- check for gen_pool allocation failure
Changes for v8:
	- rebase
	- move BD_SC_* macro instead of copy
Changes for v9:
	- doesn't modify CPM, add a new patch to modify.
	- rebase

 arch/powerpc/include/asm/qe.h             |  43 +++++-
 arch/powerpc/platforms/83xx/km83xx.c      |   2 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c |   2 -
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   2 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c |   2 -
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |   3 -
 arch/powerpc/platforms/85xx/common.c      |   1 -
 arch/powerpc/platforms/Kconfig            |   1 +
 arch/powerpc/sysdev/qe_lib/Makefile       |   2 +-
 arch/powerpc/sysdev/qe_lib/qe.c           |  15 ++
 arch/powerpc/sysdev/qe_lib/qe_common.c    | 242 ++++++++++++++++++++++++++++++
 11 files changed, 294 insertions(+), 21 deletions(-)
 create mode 100644 arch/powerpc/sysdev/qe_lib/qe_common.c

diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index 32b9bfa..3af9033 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
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
 #include <asm/immap_qe.h>
 
 #define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
@@ -186,13 +189,16 @@ static inline int qe_alive_during_sleep(void)
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
+unsigned long qe_muram_alloc_fixed(unsigned long offset, unsigned long size);
+int qe_muram_free(unsigned long offset);
+void __iomem *qe_muram_addr(unsigned long offset);
+unsigned long qe_muram_offset(void __iomem *addr);
+dma_addr_t qe_muram_dma(void __iomem *addr);
+#endif /* defined(CONFIG_QUICC_ENGINE) */
 
 /* Structure that defines QE firmware binary files.
  *
@@ -266,6 +272,27 @@ struct qe_bd {
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
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index bf4c447..ae111581 100644
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
index 8d76220..aacc43f 100644
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
index eff5baa..0c7a43e 100644
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
index 1a26d2f..eb24abd 100644
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
index b63b42d..823e370 100644
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
index 7bfb9b1..0f91edc 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -105,7 +105,6 @@ void __init mpc85xx_qe_init(void)
 		return;
 	}
 
-	qe_reset();
 	of_node_put(np);
 
 }
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index b7f9c40..01f98a2 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -276,6 +276,7 @@ config QUICC_ENGINE
 	bool "Freescale QUICC Engine (QE) Support"
 	depends on FSL_SOC && PPC32
 	select PPC_LIB_RHEAP
+	select GENERIC_ALLOCATOR
 	select CRC32
 	help
 	  The QUICC Engine (QE) is a new generation of communications
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
index f1855c1..9507a27 100644
--- a/arch/powerpc/sysdev/qe_lib/Makefile
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux ppc-specific parts of QE
 #
-obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_ic.o qe_io.o
+obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_common.o qe_ic.o qe_io.o
 
 obj-$(CONFIG_UCC)	+= ucc.o
 obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index c2518cd..3f9f596 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
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
diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c b/arch/powerpc/sysdev/qe_lib/qe_common.c
new file mode 100644
index 0000000..1213458
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
@@ -0,0 +1,242 @@
+/*
+ * Freescale QE common code
+ *
+ * Author: Zhao Qiang  <qiang.zhao@freescale.com>
+ *
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
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
+#include <asm/qe.h>
+
+static struct gen_pool *muram_pool;
+static struct genpool_data_align muram_pool_data;
+static struct genpool_data_fixed muram_pool_data_fixed;
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
+#define GENPOOL_OFFSET		4096
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
+	muram_pool = gen_pool_create(1, -1);
+	muram_pbase = of_translate_address(np, zero);
+	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
+		pr_err("Cannot translate zero through CPM muram node");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	while (of_address_to_resource(np, i++, &r) == 0) {
+		if (r.end > max)
+			max = r.end;
+		ret = gen_pool_add(muram_pool, r.start - muram_pbase +
+				   GENPOOL_OFFSET, resource_size(&r), -1);
+		if (ret) {
+				pr_err("QE: couldn't add muram to pool!\n");
+				goto err;
+			}
+
+	}
+
+	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
+	if (!muram_vbase) {
+		pr_err("Cannot map QE muram");
+		ret = -ENOMEM;
+		goto err;
+	}
+	goto out;
+err:
+	gen_pool_destroy(muram_pool);
+out:
+	of_node_put(np);
+	return ret;
+}
+
+/*
+ * qe_muram_alloc - allocate the requested size worth of multi-user ram
+ * @size: number of bytes to allocate
+ * @align: requested alignment, in bytes
+ *
+ * This function returns an offset into the muram area.
+ */
+unsigned long qe_muram_alloc(unsigned long size, unsigned long align)
+{
+	unsigned long start;
+	unsigned long flags;
+	struct muram_block *entry;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	muram_pool_data.align = align;
+	gen_pool_set_algo(muram_pool, gen_pool_first_fit_align,
+			  &muram_pool_data);
+	start = gen_pool_alloc(muram_pool, size);
+	if (!start)
+		goto out2;
+	start = start - GENPOOL_OFFSET;
+	memset(qe_muram_addr(start), 0, size);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out1;
+	entry->start = start;
+	entry->size = size;
+	list_add(&entry->head, &muram_block_list);
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return start;
+out1:
+	gen_pool_free(muram_pool, start, size);
+out2:
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+	return (unsigned long) -ENOMEM;
+}
+EXPORT_SYMBOL(qe_muram_alloc);
+
+/*
+ * qe_muram_alloc_fixed - reserve a specific region of multi-user ram
+ * @size: number of bytes to allocate
+ * @offset: offset of allocation start address
+ *
+ * This function returns an offset into the muram area.
+ */
+unsigned long qe_muram_alloc_fixed(unsigned long offset, unsigned long size)
+{
+
+	unsigned long start;
+	unsigned long flags;
+	unsigned long size_alloc = size;
+	struct muram_block *entry;
+	int end_bit;
+	int order = muram_pool -> min_alloc_order;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	end_bit = (offset >> order) + ((size + (1UL << order) - 1) >> order);
+	if ((offset + size) > (end_bit << order))
+		size_alloc = size + (1UL << order);
+
+	muram_pool_data_fixed.offset = offset + GENPOOL_OFFSET;
+	gen_pool_set_algo(muram_pool, gen_pool_fixed_fit,
+			  &muram_pool_data_fixed);
+	start = gen_pool_alloc(muram_pool, size_alloc);
+	if (!start)
+		goto out2;
+	start = start - GENPOOL_OFFSET;
+	memset(qe_muram_addr(start), 0, size_alloc);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out1;
+	entry->start = start;
+	entry->size = size_alloc;
+	list_add(&entry->head, &muram_block_list);
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return start;
+out1:
+	gen_pool_free(muram_pool, start, size_alloc);
+out2:
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+	return (unsigned long) -ENOMEM;
+
+
+}
+EXPORT_SYMBOL(qe_muram_alloc_fixed);
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
+	gen_pool_free(muram_pool, offset + GENPOOL_OFFSET, size);
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
-- 
2.1.0.27.g96db324
