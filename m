Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0136.outbound.protection.outlook.com [65.55.169.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED8291A0914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 18:22:56 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v12 4/6] QE/CPM: move muram management functions to qe_common
Date: Wed, 14 Oct 2015 15:16:06 +0800
Message-ID: <1444806968-4627-4-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
References: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
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

QE and CPM have the same muram, they use the same management
functions. Now QE support both ARM and PowerPC, it is necessary
to move QE to "driver/soc", so move the muram management functions
from cpm_common to qe_common for preparing to move QE code to "driver/soc"

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
Changes for v10:
	- rebase
Changes for v11:
	- remove renaming
	- delete removing qe_reset and delete adding qe_init.
Changes for v12:
	- SPI_FSL_CPM depends on QE-MURAM, select QUICC_ENGINE for it. 

 arch/powerpc/include/asm/cpm.h                     |  44 -----
 arch/powerpc/include/asm/qe.h                      |  16 ++
 arch/powerpc/sysdev/cpm_common.c                   | 210 +--------------------
 arch/powerpc/sysdev/qe_lib/Makefile                |   2 +-
 .../sysdev/{cpm_common.c => qe_lib/qe_common.c}    | 188 +-----------------
 drivers/spi/Kconfig                                |   1 +
 6 files changed, 28 insertions(+), 433 deletions(-)
 copy arch/powerpc/sysdev/{cpm_common.c => qe_lib/qe_common.c} (54%)

diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
index 0e1ac3f..05a1c15 100644
--- a/arch/powerpc/include/asm/cpm.h
+++ b/arch/powerpc/include/asm/cpm.h
@@ -155,50 +155,6 @@ typedef struct cpm_buf_desc {
  */
 #define BD_I2C_START		(0x0400)
 
-int cpm_muram_init(void);
-
-#if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
-unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
-int cpm_muram_free(unsigned long offset);
-unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
-unsigned long cpm_muram_alloc_common(unsigned long size, void *data);
-void __iomem *cpm_muram_addr(unsigned long offset);
-unsigned long cpm_muram_offset(void __iomem *addr);
-dma_addr_t cpm_muram_dma(void __iomem *addr);
-#else
-static inline unsigned long cpm_muram_alloc(unsigned long size,
-					    unsigned long align)
-{
-	return -ENOSYS;
-}
-
-static inline int cpm_muram_free(unsigned long offset)
-{
-	return -ENOSYS;
-}
-
-static inline unsigned long cpm_muram_alloc_fixed(unsigned long offset,
-						  unsigned long size)
-{
-	return -ENOSYS;
-}
-
-static inline void __iomem *cpm_muram_addr(unsigned long offset)
-{
-	return NULL;
-}
-
-static inline unsigned long cpm_muram_offset(void __iomem *addr)
-{
-	return -ENOSYS;
-}
-
-static inline dma_addr_t cpm_muram_dma(void __iomem *addr)
-{
-	return 0;
-}
-#endif /* defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE) */
-
 #ifdef CONFIG_CPM
 int cpm_command(u32 command, u8 opcode);
 #else
diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index 32b9bfa..c2dd8e6 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -16,11 +16,15 @@
 #define _ASM_POWERPC_QE_H
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <asm/cpm.h>
 #include <asm/immap_qe.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/types.h>
 
 #define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
 #define QE_NUM_OF_BRGS	16
@@ -92,6 +96,18 @@ extern void qe_reset(void);
 static inline void qe_reset(void) {}
 #endif
 
+int cpm_muram_init(void);
+
+#if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
+unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
+int cpm_muram_free(unsigned long offset);
+unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
+unsigned long cpm_muram_alloc_common(unsigned long size, void *data);
+void __iomem *cpm_muram_addr(unsigned long offset);
+unsigned long cpm_muram_offset(void __iomem *addr);
+dma_addr_t cpm_muram_dma(void __iomem *addr);
+#endif /* defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE) */
+
 /* QE PIO */
 #define QE_PIO_PINS 32
 
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index ff47072..6993aa8 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -17,7 +17,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/genalloc.h>
 #include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/spinlock.h>
@@ -29,6 +28,7 @@
 #include <asm/udbg.h>
 #include <asm/io.h>
 #include <asm/cpm.h>
+#include <asm/qe.h>
 
 #include <mm/mmu_decl.h>
 
@@ -65,214 +65,6 @@ void __init udbg_init_cpm(void)
 }
 #endif
 
-static struct gen_pool *muram_pool;
-static spinlock_t cpm_muram_lock;
-static u8 __iomem *muram_vbase;
-static phys_addr_t muram_pbase;
-
-struct muram_block {
-	struct list_head head;
-	unsigned long start;
-	int size;
-};
-
-static LIST_HEAD(muram_block_list);
-
-/* max address size we deal with */
-#define OF_MAX_ADDR_CELLS	4
-#define GENPOOL_OFFSET		(4096 * 8)
-
-int cpm_muram_init(void)
-{
-	struct device_node *np;
-	struct resource r;
-	u32 zero[OF_MAX_ADDR_CELLS] = {};
-	resource_size_t max = 0;
-	int i = 0;
-	int ret = 0;
-
-	if (muram_pbase)
-		return 0;
-
-	spin_lock_init(&cpm_muram_lock);
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
-	if (!np) {
-		/* try legacy bindings */
-		np = of_find_node_by_name(NULL, "data-only");
-		if (!np) {
-			pr_err("Cannot find CPM muram data node");
-			ret = -ENODEV;
-			goto out_muram;
-		}
-	}
-
-	muram_pool = gen_pool_create(0, -1);
-	muram_pbase = of_translate_address(np, zero);
-	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
-		pr_err("Cannot translate zero through CPM muram node");
-		ret = -ENODEV;
-		goto out_pool;
-	}
-
-	while (of_address_to_resource(np, i++, &r) == 0) {
-		if (r.end > max)
-			max = r.end;
-		ret = gen_pool_add(muram_pool, r.start - muram_pbase +
-				   GENPOOL_OFFSET, resource_size(&r), -1);
-		if (ret) {
-				pr_err("QE: couldn't add muram to pool!\n");
-				goto out_pool;
-			}
-
-	}
-
-	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
-	if (!muram_vbase) {
-		pr_err("Cannot map QE muram");
-		ret = -ENOMEM;
-		goto out_pool;
-	}
-	goto out_muram;
-out_pool:
-	gen_pool_destroy(muram_pool);
-out_muram:
-	of_node_put(np);
-	return ret;
-}
-
-/*
- * cpm_muram_alloc - allocate the requested size worth of multi-user ram
- * @size: number of bytes to allocate
- * @align: requested alignment, in bytes
- *
- * This function returns an offset into the muram area.
- * Use cpm_dpram_addr() to get the virtual address of the area.
- * Use cpm_muram_free() to free the allocation.
- */
-unsigned long cpm_muram_alloc(unsigned long size, unsigned long align)
-{
-	unsigned long flags;
-	unsigned long start;
-	static struct genpool_data_align muram_pool_data;
-	spin_lock_irqsave(&cpm_muram_lock, flags);
-	muram_pool_data.align = align;
-	gen_pool_set_algo(muram_pool, gen_pool_first_fit_align,
-			  &muram_pool_data);
-	start = cpm_muram_alloc_common(size, &muram_pool_data);
-	spin_unlock_irqrestore(&cpm_muram_lock, flags);
-	return start;
-}
-EXPORT_SYMBOL(cpm_muram_alloc);
-
-
-/**
- * cpm_muram_free - free a chunk of multi-user ram
- * @offset: The beginning of the chunk as returned by cpm_muram_alloc().
- */
-int cpm_muram_free(unsigned long offset)
-{
-	unsigned long flags;
-	int size;
-	struct muram_block *tmp;
-
-	size = 0;
-	spin_lock_irqsave(&cpm_muram_lock, flags);
-	list_for_each_entry(tmp, &muram_block_list, head) {
-		if (tmp->start == offset) {
-			size = tmp->size;
-			list_del(&tmp->head);
-			kfree(tmp);
-			break;
-		}
-	}
-	gen_pool_free(muram_pool, offset + GENPOOL_OFFSET, size);
-	spin_unlock_irqrestore(&cpm_muram_lock, flags);
-
-	return size;
-}
-EXPORT_SYMBOL(cpm_muram_free);
-
-/*
- * cpm_muram_alloc_fixed - reserve a specific region of multi-user ram
- * @size: number of bytes to allocate
- * @offset: offset of allocation start address
- *
- * This function returns an offset into the muram area.
- */
-unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size)
-{
-
-	unsigned long start;
-	unsigned long flags;
-	static struct genpool_data_fixed muram_pool_data_fixed;
-
-	spin_lock_irqsave(&cpm_muram_lock, flags);
-	muram_pool_data_fixed.offset = offset + GENPOOL_OFFSET;
-	gen_pool_set_algo(muram_pool, gen_pool_fixed_alloc,
-			  &muram_pool_data_fixed);
-	start = cpm_muram_alloc_common(size, &muram_pool_data_fixed);
-	spin_unlock_irqrestore(&cpm_muram_lock, flags);
-	return start;
-}
-EXPORT_SYMBOL(cpm_muram_alloc_fixed);
-
-/*
- * cpm_muram_alloc_common - cpm_muram_alloc common code
- * @size: number of bytes to allocate
- * @data: data for genalloc's algorithm.
- *
- * This function returns an offset into the muram area.
- */
-unsigned long cpm_muram_alloc_common(unsigned long size, void *data)
-{
-	struct muram_block *entry;
-	unsigned long start;
-
-	start = gen_pool_alloc_data(muram_pool, size, data);
-	if (!start)
-		goto out2;
-	start = start - GENPOOL_OFFSET;
-	memset(cpm_muram_addr(start), 0, size);
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		goto out1;
-	entry->start = start;
-	entry->size = size;
-	list_add(&entry->head, &muram_block_list);
-
-	return start;
-out1:
-	gen_pool_free(muram_pool, start, size);
-out2:
-	return (unsigned long) -ENOMEM;
-}
-
-/**
- * cpm_muram_addr - turn a muram offset into a virtual address
- * @offset: muram offset to convert
- */
-void __iomem *cpm_muram_addr(unsigned long offset)
-{
-	return muram_vbase + offset;
-}
-EXPORT_SYMBOL(cpm_muram_addr);
-
-unsigned long cpm_muram_offset(void __iomem *addr)
-{
-	return addr - (void __iomem *)muram_vbase;
-}
-EXPORT_SYMBOL(cpm_muram_offset);
-
-/**
- * cpm_muram_dma - turn a muram virtual address into a DMA address
- * @offset: virtual address from cpm_muram_addr() to convert
- */
-dma_addr_t cpm_muram_dma(void __iomem *addr)
-{
-	return muram_pbase + ((u8 __iomem *)addr - muram_vbase);
-}
-EXPORT_SYMBOL(cpm_muram_dma);
-
 #if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
 
 struct cpm2_ioports {
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
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/qe_lib/qe_common.c
similarity index 54%
copy from arch/powerpc/sysdev/cpm_common.c
copy to arch/powerpc/sysdev/qe_lib/qe_common.c
index ff47072..0aa74ca 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
@@ -1,23 +1,18 @@
 /*
- * Common CPM code
+ * Freescale QE common code
  *
- * Author: Scott Wood <scottwood@freescale.com>
+ * Author: Zhao Qiang  <qiang.zhao@freescale.com>
  *
- * Copyright 2007-2008,2010 Freescale Semiconductor, Inc.
- *
- * Some parts derived from commproc.c/cpm2_common.c, which is:
- * Copyright (c) 1997 Dan error_act (dmalek@jlc.net)
- * Copyright (c) 1999-2001 Dan Malek <dan@embeddedalley.com>
- * Copyright (c) 2000 MontaVista Software, Inc (source@mvista.com)
- * 2006 (c) MontaVista Software, Inc.
- * Vitaly Bordug <vbordug@ru.mvista.com>
+ * Copyright 2015 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  */
 
 #include <linux/genalloc.h>
+#include <linux/list.h>
 #include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/spinlock.h>
@@ -26,44 +21,8 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 
-#include <asm/udbg.h>
-#include <asm/io.h>
-#include <asm/cpm.h>
-
-#include <mm/mmu_decl.h>
-
-#if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
-#include <linux/of_gpio.h>
-#endif
-
-#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
-static u32 __iomem *cpm_udbg_txdesc =
-	(u32 __iomem __force *)CONFIG_PPC_EARLY_DEBUG_CPM_ADDR;
-
-static void udbg_putc_cpm(char c)
-{
-	u8 __iomem *txbuf = (u8 __iomem __force *)in_be32(&cpm_udbg_txdesc[1]);
-
-	if (c == '\n')
-		udbg_putc_cpm('\r');
-
-	while (in_be32(&cpm_udbg_txdesc[0]) & 0x80000000)
-		;
-
-	out_8(txbuf, c);
-	out_be32(&cpm_udbg_txdesc[0], 0xa0000001);
-}
-
-void __init udbg_init_cpm(void)
-{
-	if (cpm_udbg_txdesc) {
-#ifdef CONFIG_CPM2
-		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
-#endif
-		udbg_putc = udbg_putc_cpm;
-	}
-}
-#endif
+#include <linux/io.h>
+#include <asm/qe.h>
 
 static struct gen_pool *muram_pool;
 static spinlock_t cpm_muram_lock;
@@ -272,132 +231,3 @@ dma_addr_t cpm_muram_dma(void __iomem *addr)
 	return muram_pbase + ((u8 __iomem *)addr - muram_vbase);
 }
 EXPORT_SYMBOL(cpm_muram_dma);
-
-#if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
-
-struct cpm2_ioports {
-	u32 dir, par, sor, odr, dat;
-	u32 res[3];
-};
-
-struct cpm2_gpio32_chip {
-	struct of_mm_gpio_chip mm_gc;
-	spinlock_t lock;
-
-	/* shadowed data register to clear/set bits safely */
-	u32 cpdata;
-};
-
-static inline struct cpm2_gpio32_chip *
-to_cpm2_gpio32_chip(struct of_mm_gpio_chip *mm_gc)
-{
-	return container_of(mm_gc, struct cpm2_gpio32_chip, mm_gc);
-}
-
-static void cpm2_gpio32_save_regs(struct of_mm_gpio_chip *mm_gc)
-{
-	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
-	struct cpm2_ioports __iomem *iop = mm_gc->regs;
-
-	cpm2_gc->cpdata = in_be32(&iop->dat);
-}
-
-static int cpm2_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
-{
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm2_ioports __iomem *iop = mm_gc->regs;
-	u32 pin_mask;
-
-	pin_mask = 1 << (31 - gpio);
-
-	return !!(in_be32(&iop->dat) & pin_mask);
-}
-
-static void __cpm2_gpio32_set(struct of_mm_gpio_chip *mm_gc, u32 pin_mask,
-	int value)
-{
-	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
-	struct cpm2_ioports __iomem *iop = mm_gc->regs;
-
-	if (value)
-		cpm2_gc->cpdata |= pin_mask;
-	else
-		cpm2_gc->cpdata &= ~pin_mask;
-
-	out_be32(&iop->dat, cpm2_gc->cpdata);
-}
-
-static void cpm2_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
-{
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
-	unsigned long flags;
-	u32 pin_mask = 1 << (31 - gpio);
-
-	spin_lock_irqsave(&cpm2_gc->lock, flags);
-
-	__cpm2_gpio32_set(mm_gc, pin_mask, value);
-
-	spin_unlock_irqrestore(&cpm2_gc->lock, flags);
-}
-
-static int cpm2_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
-{
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
-	struct cpm2_ioports __iomem *iop = mm_gc->regs;
-	unsigned long flags;
-	u32 pin_mask = 1 << (31 - gpio);
-
-	spin_lock_irqsave(&cpm2_gc->lock, flags);
-
-	setbits32(&iop->dir, pin_mask);
-	__cpm2_gpio32_set(mm_gc, pin_mask, val);
-
-	spin_unlock_irqrestore(&cpm2_gc->lock, flags);
-
-	return 0;
-}
-
-static int cpm2_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
-{
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
-	struct cpm2_ioports __iomem *iop = mm_gc->regs;
-	unsigned long flags;
-	u32 pin_mask = 1 << (31 - gpio);
-
-	spin_lock_irqsave(&cpm2_gc->lock, flags);
-
-	clrbits32(&iop->dir, pin_mask);
-
-	spin_unlock_irqrestore(&cpm2_gc->lock, flags);
-
-	return 0;
-}
-
-int cpm2_gpiochip_add32(struct device_node *np)
-{
-	struct cpm2_gpio32_chip *cpm2_gc;
-	struct of_mm_gpio_chip *mm_gc;
-	struct gpio_chip *gc;
-
-	cpm2_gc = kzalloc(sizeof(*cpm2_gc), GFP_KERNEL);
-	if (!cpm2_gc)
-		return -ENOMEM;
-
-	spin_lock_init(&cpm2_gc->lock);
-
-	mm_gc = &cpm2_gc->mm_gc;
-	gc = &mm_gc->gc;
-
-	mm_gc->save_regs = cpm2_gpio32_save_regs;
-	gc->ngpio = 32;
-	gc->direction_input = cpm2_gpio32_dir_in;
-	gc->direction_output = cpm2_gpio32_dir_out;
-	gc->get = cpm2_gpio32_get;
-	gc->set = cpm2_gpio32_set;
-
-	return of_mm_gpiochip_add(np, mm_gc);
-}
-#endif /* CONFIG_CPM2 || CONFIG_8xx_GPIO */
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 198f96b..406ece4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -286,6 +286,7 @@ config SPI_FSL_LIB
 config SPI_FSL_CPM
 	tristate
 	depends on FSL_SOC
+	select QUICC_ENGINE
 
 config SPI_FSL_SPI
 	tristate "Freescale SPI controller and Aeroflex Gaisler GRLIB SPI controller"
-- 
2.1.0.27.g96db324
