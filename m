Return-Path: <hrai@nmglablinux22.freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FD0BB70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 20:33:45 +1100 (EST)
Received: from mail26-am1 (localhost.localdomain [127.0.0.1])	by
	mail26-am1-R.bigfish.com (Postfix) with ESMTP id 08D941AF823F	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 09:18:28 +0000 (UTC)
Received: from am1ehsmhs008.bigfish.com (unknown [10.3.201.242])	by
	mail26-am1.bigfish.com (Postfix) with ESMTP id 6784F15F8077	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 09:17:32 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9D9HJ5v017607	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 02:17:29 -0700 (MST)
From: <harninder.rai@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v1] powerpc/fsl: 85xx: add cache-sram support
Date: Wed, 13 Oct 2010 14:47:15 +0530
Message-ID: <1286961435-3010-1-git-send-email-harninder.rai@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Harninder Rai <harninder.rai@freescale.com>,
	Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Harninder Rai <harninder.rai@freescale.com>

It adds cache-sram support in P1/P2 QorIQ platforms as under:

    * A small abstraction over powerpc's remote heap allocator
    * Exports mpc85xx_cache_sram_alloc()/free() APIs
    * Supports only one contiguous SRAM window
    * Drivers can do the following in Kconfig to use these APIs
        "select FSL_85XX_CACHE_SRAM if MPC85xx"
    * Required SRAM size and the offset where SRAM should be mapped must be
      provided at kernel command line as :-
        cache-sram-size=<value>
        cache-sram-offset=<offset>

Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
---
incorporates review comments

 arch/powerpc/include/asm/fsl_85xx_cache_sram.h |   48 +++++
 arch/powerpc/sysdev/Makefile                   |    1 +
 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h      |  101 +++++++++++
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c      |  149 +++++++++++++++
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c          |  231 ++++++++++++++++++++++++
 5 files changed, 530 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsl_85xx_cache_sram.h
 create mode 100644 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
 create mode 100644 arch/powerpc/sysdev/fsl_85xx_cache_sram.c
 create mode 100644 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c

diff --git a/arch/powerpc/include/asm/fsl_85xx_cache_sram.h b/arch/powerpc/include/asm/fsl_85xx_cache_sram.h
new file mode 100644
index 0000000..2af2bdc
--- /dev/null
+++ b/arch/powerpc/include/asm/fsl_85xx_cache_sram.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2009 Freescale Semiconductor, Inc.
+ *
+ * Cache SRAM handling for QorIQ platform
+ *
+ * Author: Vivek Mahajan <vivek.mahajan@freescale.com>
+
+ * This file is derived from the original work done
+ * by Sylvain Munaut for the Bestcomm SRAM allocator.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_POWERPC_FSL_85XX_CACHE_SRAM_H__
+#define __ASM_POWERPC_FSL_85XX_CACHE_SRAM_H__
+
+#include <asm/rheap.h>
+#include <linux/spinlock.h>
+
+/*
+ * Cache-SRAM
+ */
+
+struct mpc85xx_cache_sram {
+	phys_addr_t base_phys;
+	void *base_virt;
+	unsigned int size;
+	rh_info_t *rh;
+	spinlock_t lock;
+};
+
+extern void mpc85xx_cache_sram_free(void *ptr);
+extern void *mpc85xx_cache_sram_alloc(unsigned int size,
+				  phys_addr_t *phys, unsigned int align);
+
+#endif /* __AMS_POWERPC_FSL_85XX_CACHE_SRAM_H__ */
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 5642924..fb60eb1 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
+obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
 obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
 obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
new file mode 100644
index 0000000..60c9c0b
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
@@ -0,0 +1,101 @@
+/*
+ * Copyright 2009-2010 Freescale Semiconductor, Inc
+ *
+ * QorIQ based Cache Controller Memory Mapped Registers
+ *
+ * Author: Vivek Mahajan <vivek.mahajan@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __FSL_85XX_CACHE_CTLR_H__
+#define __FSL_85XX_CACHE_CTLR_H__
+
+#define L2CR_L2FI		0x40000000	/* L2 flash invalidate */
+#define L2CR_L2IO		0x00200000	/* L2 instruction only */
+#define L2CR_SRAM_ZERO		0x00000000	/* L2SRAM zero size */
+#define L2CR_SRAM_FULL		0x00010000	/* L2SRAM full size */
+#define L2CR_SRAM_HALF		0x00020000	/* L2SRAM half size */
+#define L2CR_SRAM_TWO_HALFS	0x00030000	/* L2SRAM two half sizes */
+#define L2CR_SRAM_QUART		0x00040000	/* L2SRAM one quarter size */
+#define L2CR_SRAM_TWO_QUARTS	0x00050000	/* L2SRAM two quarter size */
+#define L2CR_SRAM_EIGHTH	0x00060000	/* L2SRAM one eighth size */
+#define L2CR_SRAM_TWO_EIGHTH	0x00070000	/* L2SRAM two eighth size */
+
+#define L2SRAM_OPTIMAL_SZ_SHIFT	0x00000003	/* Optimum size for L2SRAM */
+
+#define L2SRAM_BAR_MSK_LO18	0xFFFFC000	/* Lower 18 bits */
+#define L2SRAM_BARE_MSK_HI4	0x0000000F	/* Upper 4 bits */
+
+enum cache_sram_lock_ways {
+	LOCK_WAYS_ZERO,
+	LOCK_WAYS_EIGHTH,
+	LOCK_WAYS_TWO_EIGHTH,
+	LOCK_WAYS_HALF = 4,
+	LOCK_WAYS_FULL = 8,
+};
+
+struct mpc85xx_l2ctlr {
+	u32	ctl;		/* 0x000 - L2 control */
+	u8	res1[0xC];
+	u32	ewar0;		/* 0x010 - External write address 0 */
+	u32	ewarea0;	/* 0x014 - External write address extended 0 */
+	u32	ewcr0;		/* 0x018 - External write ctrl */
+	u8	res2[4];
+	u32	ewar1;		/* 0x020 - External write address 1 */
+	u32	ewarea1;	/* 0x024 - External write address extended 1 */
+	u32	ewcr1;		/* 0x028 - External write ctrl 1 */
+	u8	res3[4];
+	u32	ewar2;		/* 0x030 - External write address 2 */
+	u32	ewarea2;	/* 0x034 - External write address extended 2 */
+	u32	ewcr2;		/* 0x038 - External write ctrl 2 */
+	u8	res4[4];
+	u32	ewar3;		/* 0x040 - External write address 3 */
+	u32	ewarea3;	/* 0x044 - External write address extended 3 */
+	u32	ewcr3;		/* 0x048 - External write ctrl 3 */
+	u8	res5[0xB4];
+	u32	srbar0;		/* 0x100 - SRAM base address 0 */
+	u32	srbarea0;	/* 0x104 - SRAM base addr reg ext address 0 */
+	u32	srbar1;		/* 0x108 - SRAM base address 1 */
+	u32	srbarea1;	/* 0x10C - SRAM base addr reg ext address 1 */
+	u8	res6[0xCF0];
+	u32	errinjhi;	/* 0xE00 - Error injection mask high */
+	u32	errinjlo;	/* 0xE04 - Error injection mask low */
+	u32	errinjctl;	/* 0xE08 - Error injection tag/ecc control */
+	u8	res7[0x14];
+	u32	captdatahi;	/* 0xE20 - Error data high capture */
+	u32	captdatalo;	/* 0xE24 - Error data low capture */
+	u32	captecc;	/* 0xE28 - Error syndrome */
+	u8	res8[0x14];
+	u32	errdet;		/* 0xE40 - Error detect */
+	u32	errdis;		/* 0xE44 - Error disable */
+	u32	errinten;	/* 0xE48 - Error interrupt enable */
+	u32	errattr;	/* 0xE4c - Error attribute capture */
+	u32	erradrrl;	/* 0xE50 - Error address capture low */
+	u32	erradrrh;	/* 0xE54 - Error address capture high */
+	u32	errctl;		/* 0xE58 - Error control */
+	u8	res9[0x1A4];
+};
+
+struct sram_parameters {
+	unsigned int sram_size;
+	uint64_t sram_offset;
+};
+
+extern int instantiate_cache_sram(struct platform_device *dev,
+		struct sram_parameters sram_params);
+extern void remove_cache_sram(struct platform_device *dev);
+
+#endif /* __FSL_85XX_CACHE_CTLR_H__ */
diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
new file mode 100644
index 0000000..5a2a623
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
@@ -0,0 +1,149 @@
+/*
+ * Copyright 2009-2010 Freescale Semiconductor, Inc.
+ *
+ * Simple memory allocator abstraction for QorIQ (P1/P2) based Cache-SRAM
+ *
+ * Author: Vivek Mahajan <vivek.mahajan@freescale.com>
+ *
+ * This file is derived from the original work done
+ * by Sylvain Munaut for the Bestcomm SRAM allocator.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/of_platform.h>
+#include <asm/pgtable.h>
+#include <asm/fsl_85xx_cache_sram.h>
+
+#include "fsl_85xx_cache_ctlr.h"
+
+struct mpc85xx_cache_sram *cache_sram;
+
+void *mpc85xx_cache_sram_alloc(unsigned int size,
+				phys_addr_t *phys, unsigned int align)
+{
+	unsigned long offset;
+	unsigned long flags;
+
+	if (unlikely(cache_sram == NULL))
+		return NULL;
+
+	if (!size || (size > cache_sram->size) || (align > cache_sram->size)) {
+		pr_err("%s(): size(=%x) or align(=%x) zero or too big\n",
+			__func__, size, align);
+		return NULL;
+	}
+
+	if ((align & (align - 1)) || align <= 1) {
+		pr_err("%s(): align(=%x) must be power of two and >1\n",
+			__func__, align);
+		return NULL;
+	}
+
+	spin_lock_irqsave(&cache_sram->lock, flags);
+	offset = rh_alloc_align(cache_sram->rh, size, align, NULL);
+	spin_unlock_irqrestore(&cache_sram->lock, flags);
+
+	if (IS_ERR_VALUE(offset))
+		return NULL;
+
+	*phys = cache_sram->base_phys + offset;
+
+	return (unsigned char *)cache_sram->base_virt + offset;
+}
+EXPORT_SYMBOL(mpc85xx_cache_sram_alloc);
+
+void mpc85xx_cache_sram_free(void *ptr)
+{
+	unsigned long flags;
+	BUG_ON(!ptr);
+
+	spin_lock_irqsave(&cache_sram->lock, flags);
+	rh_free(cache_sram->rh, ptr - cache_sram->base_virt);
+	spin_unlock_irqrestore(&cache_sram->lock, flags);
+}
+EXPORT_SYMBOL(mpc85xx_cache_sram_free);
+
+int __init instantiate_cache_sram(struct platform_device *dev,
+		struct sram_parameters sram_params)
+{
+	if (cache_sram) {
+		dev_err(&dev->dev, "Already initialized cache-sram\n");
+		return -EBUSY;
+	}
+
+	cache_sram = kzalloc(sizeof(struct mpc85xx_cache_sram), GFP_KERNEL);
+	if (!cache_sram) {
+		dev_err(&dev->dev, "Out of memory for cache_sram structure\n");
+		return -ENOMEM;
+	}
+
+	cache_sram->base_phys = sram_params.sram_offset;
+	cache_sram->size = sram_params.sram_size;
+
+	if (!request_mem_region(cache_sram->base_phys, cache_sram->size,
+						"fsl_85xx_cache_sram")) {
+		dev_err(&dev->dev, "%s: request memory failed\n",
+				dev->dev.of_node->full_name);
+		kfree(cache_sram);
+		return -ENXIO;
+	}
+
+	cache_sram->base_virt = ioremap_flags(cache_sram->base_phys,
+				cache_sram->size, _PAGE_COHERENT | PAGE_KERNEL);
+	if (!cache_sram->base_virt) {
+		dev_err(&dev->dev, "%s: ioremap_flags failed\n",
+				dev->dev.of_node->full_name);
+		release_mem_region(cache_sram->base_phys, cache_sram->size);
+		kfree(cache_sram);
+		return -ENOMEM;
+	}
+
+	cache_sram->rh = rh_create(sizeof(unsigned int));
+	if (IS_ERR(cache_sram->rh)) {
+		dev_err(&dev->dev, "%s: Unable to create remote heap\n",
+				dev->dev.of_node->full_name);
+		iounmap(cache_sram->base_virt);
+		release_mem_region(cache_sram->base_phys, cache_sram->size);
+		kfree(cache_sram);
+		return PTR_ERR(cache_sram->rh);
+	}
+
+	rh_attach_region(cache_sram->rh, 0, cache_sram->size);
+	spin_lock_init(&cache_sram->lock);
+
+	dev_info(&dev->dev, "[base:0x%llx, size:0x%x] configured and loaded\n",
+		(unsigned long long)cache_sram->base_phys, cache_sram->size);
+	return 0;
+}
+
+void remove_cache_sram(struct platform_device *dev)
+{
+	BUG_ON(!cache_sram);
+
+	rh_detach_region(cache_sram->rh, 0, cache_sram->size);
+	rh_destroy(cache_sram->rh);
+
+	iounmap(cache_sram->base_virt);
+	release_mem_region(cache_sram->base_phys, cache_sram->size);
+
+	kfree(cache_sram);
+	cache_sram = NULL;
+
+	dev_info(&dev->dev, "MPC85xx Cache-SRAM driver unloaded\n");
+}
diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
new file mode 100644
index 0000000..cc8d655
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -0,0 +1,231 @@
+/*
+ * Copyright 2009-2010 Freescale Semiconductor, Inc.
+ *
+ * QorIQ (P1/P2) L2 controller init for Cache-SRAM instantiation
+ *
+ * Author: Vivek Mahajan <vivek.mahajan@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <asm/io.h>
+
+#include "fsl_85xx_cache_ctlr.h"
+
+static char *sram_size;
+static char *sram_offset;
+struct mpc85xx_l2ctlr __iomem *l2ctlr;
+
+static long get_cache_sram_size(void)
+{
+	unsigned long val;
+
+	if (!sram_size || (strict_strtoul(sram_size, 0, &val) < 0))
+		return -EINVAL;
+
+	return val;
+}
+
+static long get_cache_sram_offset(void)
+{
+	unsigned long val;
+
+	if (!sram_offset || (strict_strtoul(sram_offset, 0, &val) < 0))
+		return -EINVAL;
+
+	return val;
+}
+
+static int __init get_size_from_cmdline(char *str)
+{
+	if (!str)
+		return 0;
+
+	sram_size = str;
+	return 1;
+}
+
+static int __init get_offset_from_cmdline(char *str)
+{
+	if (!str)
+		return 0;
+
+	sram_offset = str;
+	return 1;
+}
+
+__setup("cache-sram-size=", get_size_from_cmdline);
+__setup("cache-sram-offset=", get_offset_from_cmdline);
+
+static int __devinit mpc85xx_l2ctlr_of_probe(struct platform_device *dev,
+					  const struct of_device_id *match)
+{
+	long rval;
+	unsigned int rem;
+	unsigned char ways;
+	const unsigned int *prop;
+	unsigned int l2cache_size;
+	struct sram_parameters sram_params;
+
+	if (!dev->dev.of_node) {
+		dev_err(&dev->dev, "Device's OF-node is NULL\n");
+		return -EINVAL;
+	}
+
+	prop = of_get_property(dev->dev.of_node, "cache-size", NULL);
+	if (!prop) {
+		dev_err(&dev->dev, "Missing L2 cache-size\n");
+		return -EINVAL;
+	}
+	l2cache_size = *prop;
+
+	sram_params.sram_size  = get_cache_sram_size();
+	if (sram_params.sram_size <= 0) {
+		dev_err(&dev->dev,
+			"Entire L2 as cache, Aborting Cache-SRAM stuff\n");
+		return -EINVAL;
+	}
+
+	sram_params.sram_offset  = get_cache_sram_offset();
+	if (sram_params.sram_offset <= 0) {
+		dev_err(&dev->dev,
+			"Entire L2 as cache, provide a valid sram offset\n");
+		return -EINVAL;
+	}
+
+
+	rem = l2cache_size % sram_params.sram_size;
+	ways = LOCK_WAYS_FULL * sram_params.sram_size / l2cache_size;
+	if (rem || (ways & (ways - 1))) {
+		dev_err(&dev->dev, "Illegal cache-sram-size in command line\n");
+		return -EINVAL;
+	}
+
+	l2ctlr = of_iomap(dev->dev.of_node, 0);
+	if (!l2ctlr) {
+		dev_err(&dev->dev, "Can't map L2 controller\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Write bits[0-17] to srbar0
+	 */
+	out_be32(&l2ctlr->srbar0,
+		sram_params.sram_offset & L2SRAM_BAR_MSK_LO18);
+
+	/*
+	 * Write bits[18-21] to srbare0
+	 */
+#ifdef CONFIG_PHYS_64BIT
+	out_be32(&l2ctlr->srbarea0,
+		(sram_params.sram_offset >> 32) & L2SRAM_BARE_MSK_HI4);
+#endif
+
+	clrsetbits_be32(&l2ctlr->ctl, L2CR_L2E, L2CR_L2FI);
+
+	switch (ways) {
+	case LOCK_WAYS_EIGHTH:
+		setbits32(&l2ctlr->ctl,
+			L2CR_L2E | L2CR_L2FI | L2CR_SRAM_EIGHTH);
+		break;
+
+	case LOCK_WAYS_TWO_EIGHTH:
+		setbits32(&l2ctlr->ctl,
+			L2CR_L2E | L2CR_L2FI | L2CR_SRAM_QUART);
+		break;
+
+	case LOCK_WAYS_HALF:
+		setbits32(&l2ctlr->ctl,
+			L2CR_L2E | L2CR_L2FI | L2CR_SRAM_HALF);
+		break;
+
+	case LOCK_WAYS_FULL:
+	default:
+		setbits32(&l2ctlr->ctl,
+			L2CR_L2E | L2CR_L2FI | L2CR_SRAM_FULL);
+		break;
+	}
+	eieio();
+
+	rval = instantiate_cache_sram(dev, sram_params);
+	if (rval < 0) {
+		dev_err(&dev->dev, "Can't instantiate Cache-SRAM\n");
+		iounmap(l2ctlr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __devexit mpc85xx_l2ctlr_of_remove(struct platform_device *dev)
+{
+	BUG_ON(!l2ctlr);
+
+	iounmap(l2ctlr);
+	remove_cache_sram(dev);
+	dev_info(&dev->dev, "MPC85xx L2 controller unloaded\n");
+
+	return 0;
+}
+
+static struct of_device_id mpc85xx_l2ctlr_of_match[] = {
+	{
+		.compatible = "fsl,p2020-l2-cache-controller",
+	},
+	{
+		.compatible = "fsl,p2010-l2-cache-controller",
+	},
+	{
+		.compatible = "fsl,p1020-l2-cache-controller",
+	},
+	{
+		.compatible = "fsl,p1011-l2-cache-controller",
+	},
+	{
+		.compatible = "fsl,p1013-l2-cache-controller",
+	},
+	{
+		.compatible = "fsl,p1022-l2-cache-controller",
+	},
+	{},
+};
+
+static struct of_platform_driver mpc85xx_l2ctlr_of_platform_driver = {
+	.driver	= {
+		.name		= "fsl-l2ctlr",
+		.owner		= THIS_MODULE,
+		.of_match_table	= mpc85xx_l2ctlr_of_match,
+	},
+	.probe		= mpc85xx_l2ctlr_of_probe,
+	.remove		= __devexit_p(mpc85xx_l2ctlr_of_remove),
+};
+
+static __init int mpc85xx_l2ctlr_of_init(void)
+{
+	return of_register_platform_driver(&mpc85xx_l2ctlr_of_platform_driver);
+}
+
+static void __exit mpc85xx_l2ctlr_of_exit(void)
+{
+	of_unregister_platform_driver(&mpc85xx_l2ctlr_of_platform_driver);
+}
+
+subsys_initcall(mpc85xx_l2ctlr_of_init);
+module_exit(mpc85xx_l2ctlr_of_exit);
+
+MODULE_DESCRIPTION("Freescale MPC85xx L2 controller init");
+MODULE_LICENSE("GPL v2");
-- 
1.5.6.5
