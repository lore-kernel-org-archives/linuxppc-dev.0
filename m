Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8B842B7E81
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 09:00:06 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/mpc5121: shared DIU framebuffer support
Date: Sat, 27 Feb 2010 22:58:22 +0100
Message-Id: <1267307902-31939-4-git-send-email-agust@denx.de>
In-Reply-To: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	Anatolij Gustschin <agust@denx.de>, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC5121 DIU configuration/setup as initialized by the boot
loader currently will get lost while booting Linux. As a
result displaying the boot splash is not possible through
the boot process.

To prevent this we reserve configured DIU frame buffer
address range while booting and preserve AOI descriptor
and gamma table so that DIU continues displaying through
the whole boot process. On first open from user space
DIU frame buffer driver releases the reserved frame
buffer area and continues to operate as usual.

The patch also moves drivers/video/fsl-diu-fb.h file to
include/linux as we use some DIU structures in platform
code.

'diu_ops' callbacks in platform code borrowed from John's
DIU code.

Signed-off-by: John Rigby <jrigby@gmail.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/512x/mpc5121_ads.c     |    7 +
 arch/powerpc/platforms/512x/mpc5121_generic.c |   13 ++
 arch/powerpc/platforms/512x/mpc512x.h         |    3 +
 arch/powerpc/platforms/512x/mpc512x_shared.c  |  282 +++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                 |    1 +
 drivers/video/fsl-diu-fb.c                    |   25 ++-
 drivers/video/fsl-diu-fb.h                    |  223 -------------------
 include/linux/fsl-diu-fb.h                    |  223 +++++++++++++++++++
 8 files changed, 549 insertions(+), 228 deletions(-)
 delete mode 100644 drivers/video/fsl-diu-fb.h
 create mode 100644 include/linux/fsl-diu-fb.h

diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index ee6ae12..aa4d5a8 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -42,6 +42,7 @@ static void __init mpc5121_ads_setup_arch(void)
 	for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
 		mpc83xx_add_bridge(np);
 #endif
+	mpc512x_setup_diu();
 }
 
 static void __init mpc5121_ads_init_IRQ(void)
@@ -60,11 +61,17 @@ static int __init mpc5121_ads_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,mpc5121ads");
 }
 
+void __init mpc5121_ads_init_early(void)
+{
+	mpc512x_init_diu();
+}
+
 define_machine(mpc5121_ads) {
 	.name			= "MPC5121 ADS",
 	.probe			= mpc5121_ads_probe,
 	.setup_arch		= mpc5121_ads_setup_arch,
 	.init			= mpc512x_init,
+	.init_early		= mpc5121_ads_init_early,
 	.init_IRQ		= mpc5121_ads_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
index a6c0e3a..3aaa281 100644
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -28,6 +28,7 @@
  */
 static char *board[] __initdata = {
 	"prt,prtlvt",
+	"ifm,pdm360ng",
 	NULL
 };
 
@@ -48,10 +49,22 @@ static int __init mpc5121_generic_probe(void)
 	return board[i] != NULL;
 }
 
+void __init mpc512x_generic_init_early(void)
+{
+	mpc512x_init_diu();
+}
+
+void __init mpc512x_generic_setup_arch(void)
+{
+	mpc512x_setup_diu();
+}
+
 define_machine(mpc5121_generic) {
 	.name			= "MPC5121 generic",
 	.probe			= mpc5121_generic_probe,
 	.init			= mpc512x_init,
+	.init_early		= mpc512x_generic_init_early,
+	.setup_arch		= mpc512x_generic_setup_arch,
 	.init_IRQ		= mpc512x_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index d72b2c7..1cfe9d5 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -17,4 +17,7 @@ extern int __init mpc5121_clk_init(void);
 void __init mpc512x_declare_of_platform_devices(void);
 extern void mpc512x_restart(char *cmd);
 extern void __init mpc5121_usb_init(void);
+extern void __init mpc512x_init_diu(void);
+extern void __init mpc512x_setup_diu(void);
+extern struct fsl_diu_shared_fb diu_shared_fb;
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index fbdf65f..a8c50a6 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -16,7 +16,11 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/of_platform.h>
+#include <linux/fsl-diu-fb.h>
+#include <linux/bootmem.h>
+#include <sysdev/fsl_soc.h>
 
+#include <asm/cacheflush.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
 #include <asm/prom.h>
@@ -53,6 +57,284 @@ void mpc512x_restart(char *cmd)
 		;
 }
 
+struct fsl_diu_shared_fb {
+	char		gamma[0x300];	/* 32-bit aligned! */
+	struct diu_ad	ad0;		/* 32-bit aligned! */
+	phys_addr_t	fb_phys;
+	size_t		fb_len;
+	bool		in_use;
+};
+
+unsigned int mpc512x_get_pixel_format(unsigned int bits_per_pixel,
+				      int monitor_port)
+{
+	unsigned int pix_fmt;
+
+	switch (bits_per_pixel) {
+	case 32:
+		pix_fmt = 0x88883316;
+		break;
+	case 24:
+		pix_fmt = 0x88082219;
+		break;
+	case 16:
+		pix_fmt = 0x65053118;
+		break;
+	default:
+		pix_fmt = 0x00000400;
+	}
+	return pix_fmt;
+}
+
+void mpc512x_set_gamma_table(int monitor_port, char *gamma_table_base)
+{
+}
+
+void mpc512x_set_monitor_port(int monitor_port)
+{
+}
+
+#define CCM_SCFR1	0x0000000c
+#define DIU_DIV_MASK	0x000000ff
+void mpc512x_set_pixel_clock(unsigned int pixclock)
+{
+	unsigned long bestval, bestfreq, speed_ccb, busfreq;
+	unsigned long minpixclock, maxpixclock, pixval;
+	struct device_node *np;
+	void __iomem *ccm;
+	u32 temp;
+	long err;
+	int i;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-clock");
+	if (!np) {
+		pr_err("Can't find clock control module.\n");
+		return;
+	}
+
+	ccm = of_iomap(np, 0);
+	if (!ccm) {
+		pr_err("Can't map clock control module reg.\n");
+		of_node_put(np);
+		return;
+	}
+	of_node_put(np);
+
+	busfreq = 200000000;
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np) {
+		unsigned int size;
+		const unsigned int *prop =
+			of_get_property(np, "bus-frequency", &size);
+		if (prop)
+			busfreq = *prop;
+		of_node_put(np);
+	}
+
+	/* Pixel Clock configuration */
+	pr_debug("DIU: Bus Frequency = %lu\n", busfreq);
+	speed_ccb = busfreq * 4;
+
+	/* Calculate the pixel clock with the smallest error */
+	/* calculate the following in steps to avoid overflow */
+	pr_debug("DIU pixclock in ps - %d\n", pixclock);
+	temp = 1;
+	temp *= 1000000000;
+	temp /= pixclock;
+	temp *= 1000;
+	pixclock = temp;
+	pr_debug("DIU pixclock freq - %u\n", pixclock);
+
+	temp *= 5;
+	temp /= 100;  /* pixclock * 0.05 */
+	pr_debug("deviation = %d\n", temp);
+	minpixclock = pixclock - temp;
+	maxpixclock = pixclock + temp;
+	pr_debug("DIU minpixclock - %lu\n", minpixclock);
+	pr_debug("DIU maxpixclock - %lu\n", maxpixclock);
+	pixval = speed_ccb/pixclock;
+	pr_debug("DIU pixval = %lu\n", pixval);
+
+	err = 100000000;
+	bestval = pixval;
+	pr_debug("DIU bestval = %lu\n", bestval);
+
+	bestfreq = 0;
+	for (i = -1; i <= 1; i++) {
+		temp = speed_ccb / (pixval+i);
+		pr_debug("DIU test pixval i=%d, pixval=%lu, temp freq. = %u\n",
+			i, pixval, temp);
+		if ((temp < minpixclock) || (temp > maxpixclock))
+			pr_debug("DIU exceeds monitor range (%lu to %lu)\n",
+				minpixclock, maxpixclock);
+		else if (abs(temp - pixclock) < err) {
+			pr_debug("Entered the else if block %d\n", i);
+			err = abs(temp - pixclock);
+			bestval = pixval + i;
+			bestfreq = temp;
+		}
+	}
+
+	pr_debug("DIU chose = %lx\n", bestval);
+	pr_debug("DIU error = %ld\n NomPixClk ", err);
+	pr_debug("DIU: Best Freq = %lx\n", bestfreq);
+	/* Modify DIU_DIV in CCM SCFR1 */
+	temp = in_be32(ccm + CCM_SCFR1);
+	pr_debug("DIU: Current value of SCFR1: 0x%08x\n", temp);
+	temp &= ~DIU_DIV_MASK;
+	temp |= (bestval & DIU_DIV_MASK);
+	out_be32(ccm + CCM_SCFR1, temp);
+	pr_debug("DIU: Modified value of SCFR1: 0x%08x\n", temp);
+	iounmap(ccm);
+}
+
+ssize_t mpc512x_show_monitor_port(int monitor_port, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0 - 5121 LCD\n");
+}
+
+int mpc512x_set_sysfs_monitor_port(int val)
+{
+	return 0;
+}
+
+struct fsl_diu_shared_fb __attribute__ ((__aligned__(8))) diu_shared_fb;
+EXPORT_SYMBOL_GPL(diu_shared_fb);
+
+#if defined(CONFIG_FB_FSL_DIU) || \
+    defined(CONFIG_FB_FSL_DIU_MODULE)
+static inline void mpc512x_free_bootmem(struct page *page)
+{
+	__ClearPageReserved(page);
+	BUG_ON(PageTail(page));
+	BUG_ON(atomic_read(&page->_count) > 1);
+	atomic_set(&page->_count, 1);
+	__free_page(page);
+	totalram_pages++;
+}
+
+void mpc512x_release_bootmem(void)
+{
+	unsigned long addr = diu_shared_fb.fb_phys & PAGE_MASK;
+	unsigned long size = diu_shared_fb.fb_len;
+	unsigned long start, end;
+
+	if (diu_shared_fb.in_use) {
+		start = PFN_UP(addr);
+		end = PFN_DOWN(addr + size);
+
+		for (; start < end; start++)
+			mpc512x_free_bootmem(pfn_to_page(start));
+
+		diu_shared_fb.in_use = false;
+	}
+	diu_ops.release_bootmem	= NULL;
+}
+#endif
+
+/*
+ * Check if DIU was pre-initialized. If so, perform steps
+ * needed to continue displaying through the whole boot process.
+ * Move area descriptor and gamma table elsewhere, they are
+ * destroyed by bootmem allocator otherwise. The frame buffer
+ * address range will be reserved in setup_arch() after bootmem
+ * allocator is up.
+ */
+void __init mpc512x_init_diu(void)
+{
+	struct device_node *np;
+	void __iomem *diu_reg;
+	phys_addr_t desc;
+	void __iomem *vaddr;
+	unsigned long mode, pix_fmt, res, bpp;
+	unsigned long dst;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-diu");
+	if (!np) {
+		pr_err("No DIU node\n");
+		return;
+	}
+
+	diu_reg = of_iomap(np, 0);
+	of_node_put(np);
+	if (!diu_reg) {
+		pr_err("Can't map DIU\n");
+		return;
+	}
+
+	mode = in_be32(diu_reg + 0x1c);
+	if (mode != 1) {
+		pr_info("%s: DIU OFF\n", __func__);
+		goto out;
+	}
+
+	desc = in_be32(diu_reg);
+	vaddr = ioremap(desc, sizeof(struct diu_ad));
+	if (!vaddr) {
+		pr_err("Can't map DIU area desc.\n");
+		goto out;
+	}
+	memcpy(&diu_shared_fb.ad0, vaddr, sizeof(struct diu_ad));
+	/* flush fb area descriptor */
+	dst = (unsigned long)&diu_shared_fb.ad0;
+	flush_dcache_range(dst, dst + sizeof(struct diu_ad) - 1);
+
+	res = in_be32(diu_reg + 0x28);
+	pix_fmt = in_le32(vaddr);
+	bpp = ((pix_fmt >> 16) & 0x3) + 1;
+	diu_shared_fb.fb_phys = in_le32(vaddr + 4);
+	diu_shared_fb.fb_len = ((res & 0xfff0000) >> 16) * (res & 0xfff) * bpp;
+	diu_shared_fb.in_use = true;
+	iounmap(vaddr);
+
+	desc = in_be32(diu_reg + 0xc);
+	vaddr = ioremap(desc, sizeof(diu_shared_fb.gamma));
+	if (!vaddr) {
+		pr_err("Can't map DIU area desc.\n");
+		diu_shared_fb.in_use = false;
+		goto out;
+	}
+	memcpy(&diu_shared_fb.gamma, vaddr, sizeof(diu_shared_fb.gamma));
+	/* flush gamma table */
+	dst = (unsigned long)&diu_shared_fb.gamma;
+	flush_dcache_range(dst, dst + sizeof(diu_shared_fb.gamma) - 1);
+
+	iounmap(vaddr);
+	out_be32(diu_reg + 0xc, virt_to_phys(&diu_shared_fb.gamma));
+	out_be32(diu_reg + 4, 0);
+	out_be32(diu_reg + 8, 0);
+	out_be32(diu_reg, virt_to_phys(&diu_shared_fb.ad0));
+
+out:
+	iounmap(diu_reg);
+}
+
+void __init mpc512x_setup_diu(void)
+{
+	int ret;
+
+	if (diu_shared_fb.in_use) {
+		ret = reserve_bootmem(diu_shared_fb.fb_phys,
+				      diu_shared_fb.fb_len,
+				      BOOTMEM_EXCLUSIVE);
+		if (ret) {
+			pr_err("%s: reserve bootmem failed\n", __func__);
+			diu_shared_fb.in_use = false;
+		}
+	}
+
+#if defined(CONFIG_FB_FSL_DIU) || \
+    defined(CONFIG_FB_FSL_DIU_MODULE)
+	diu_ops.get_pixel_format	= mpc512x_get_pixel_format;
+	diu_ops.set_gamma_table		= mpc512x_set_gamma_table;
+	diu_ops.set_monitor_port	= mpc512x_set_monitor_port;
+	diu_ops.set_pixel_clock		= mpc512x_set_pixel_clock;
+	diu_ops.show_monitor_port	= mpc512x_show_monitor_port;
+	diu_ops.set_sysfs_monitor_port	= mpc512x_set_sysfs_monitor_port;
+	diu_ops.release_bootmem		= mpc512x_release_bootmem;
+#endif
+}
+
 void __init mpc512x_init_IRQ(void)
 {
 	struct device_node *np;
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 19754be..346057d 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -30,6 +30,7 @@ struct platform_diu_data_ops {
 	void (*set_pixel_clock) (unsigned int pixclock);
 	ssize_t (*show_monitor_port) (int monitor_port, char *buf);
 	int (*set_sysfs_monitor_port) (int val);
+	void (*release_bootmem) (void);
 };
 
 extern struct platform_diu_data_ops diu_ops;
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 19ca1da..263f7da 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -34,7 +34,7 @@
 #include <linux/of_platform.h>
 
 #include <sysdev/fsl_soc.h>
-#include "fsl-diu-fb.h"
+#include <linux/fsl-diu-fb.h>
 
 #include "ofmode.h"
 
@@ -331,8 +331,11 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 	if (mfbi->type != MFB_TYPE_OFF) {
 		switch (mfbi->index) {
 		case 0:				/* plane 0 */
-			if (hw->desc[0] != ad->paddr)
+			if (in_be32(&hw->desc[0]) != ad->paddr) {
+				out_be32(&dr.diu_reg->diu_mode, 0);
 				out_be32(&hw->desc[0], ad->paddr);
+				out_be32(&dr.diu_reg->diu_mode, 1);
+			}
 			break;
 		case 1:				/* plane 1 AOI 0 */
 			cmfbi = machine_data->fsl_diu_info[2]->par;
@@ -391,7 +394,7 @@ static int fsl_diu_disable_panel(struct fb_info *info)
 
 	switch (mfbi->index) {
 	case 0:					/* plane 0 */
-		if (hw->desc[0] != machine_data->dummy_ad->paddr)
+		if (in_be32(&hw->desc[0]) != machine_data->dummy_ad->paddr)
 			out_be32(&hw->desc[0],
 				machine_data->dummy_ad->paddr);
 		break;
@@ -1102,6 +1105,10 @@ static int fsl_diu_open(struct fb_info *info, int user)
 	struct mfb_info *mfbi = info->par;
 	int res = 0;
 
+	/* free boot splash memory on first /dev/fb0 open */
+	if (!mfbi->index && diu_ops.release_bootmem)
+		diu_ops.release_bootmem();
+
 	spin_lock(&diu_lock);
 	mfbi->count++;
 	if (mfbi->count == 1) {
@@ -1436,6 +1443,7 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
 	int ret, i, error = 0;
 	struct resource res;
 	struct fsl_diu_data *machine_data;
+	int diu_mode;
 
 	machine_data = kzalloc(sizeof(struct fsl_diu_data), GFP_KERNEL);
 	if (!machine_data)
@@ -1472,7 +1480,9 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
 		goto error2;
 	}
 
-	out_be32(&dr.diu_reg->diu_mode, 0);		/* disable DIU anyway*/
+	diu_mode = in_be32(&dr.diu_reg->diu_mode);
+	if (diu_mode != MFB_MODE1)
+		out_be32(&dr.diu_reg->diu_mode, 0);	/* disable DIU */
 
 	/* Get the IRQ of the DIU */
 	machine_data->irq = irq_of_parse_and_map(np, 0);
@@ -1520,7 +1530,12 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
 	machine_data->dummy_ad->offset_xyd = 0;
 	machine_data->dummy_ad->next_ad = 0;
 
-	out_be32(&dr.diu_reg->desc[0], machine_data->dummy_ad->paddr);
+	/* Let DIU display splash screen if it was pre-initialized
+	 * by the bootloader, set dummy area descriptor otherwise.
+	 */
+	if (diu_mode != MFB_MODE1)
+		out_be32(&dr.diu_reg->desc[0], machine_data->dummy_ad->paddr);
+
 	out_be32(&dr.diu_reg->desc[1], machine_data->dummy_ad->paddr);
 	out_be32(&dr.diu_reg->desc[2], machine_data->dummy_ad->paddr);
 
diff --git a/drivers/video/fsl-diu-fb.h b/drivers/video/fsl-diu-fb.h
deleted file mode 100644
index fc295d7..0000000
--- a/drivers/video/fsl-diu-fb.h
+++ /dev/null
@@ -1,223 +0,0 @@
-/*
- * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- *  Freescale DIU Frame Buffer device driver
- *
- *  Authors: Hongjun Chen <hong-jun.chen@freescale.com>
- *           Paul Widmer <paul.widmer@freescale.com>
- *           Srikanth Srinivasan <srikanth.srinivasan@freescale.com>
- *           York Sun <yorksun@freescale.com>
- *
- *   Based on imxfb.c Copyright (C) 2004 S.Hauer, Pengutronix
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifndef __FSL_DIU_FB_H__
-#define __FSL_DIU_FB_H__
-
-/* Arbitrary threshold to determine the allocation method
- * See mpc8610fb_set_par(), map_video_memory(), and unmap_video_memory()
- */
-#define MEM_ALLOC_THRESHOLD (1024*768*4+32)
-/* Minimum value that the pixel clock can be set to in pico seconds
- * This is determined by platform clock/3 where the minimum platform
- * clock is 533MHz. This gives 5629 pico seconds.
- */
-#define MIN_PIX_CLK 5629
-#define MAX_PIX_CLK 96096
-
-#include <linux/types.h>
-
-struct mfb_alpha {
-	int enable;
-	int alpha;
-};
-
-struct mfb_chroma_key {
-	int enable;
-	__u8  red_max;
-	__u8  green_max;
-	__u8  blue_max;
-	__u8  red_min;
-	__u8  green_min;
-	__u8  blue_min;
-};
-
-struct aoi_display_offset {
-	int x_aoi_d;
-	int y_aoi_d;
-};
-
-#define MFB_SET_CHROMA_KEY	_IOW('M', 1, struct mfb_chroma_key)
-#define MFB_WAIT_FOR_VSYNC	_IOW('F', 0x20, u_int32_t)
-#define MFB_SET_BRIGHTNESS	_IOW('M', 3, __u8)
-
-#define MFB_SET_ALPHA		0x80014d00
-#define MFB_GET_ALPHA		0x40014d00
-#define MFB_SET_AOID		0x80084d04
-#define MFB_GET_AOID		0x40084d04
-#define MFB_SET_PIXFMT		0x80014d08
-#define MFB_GET_PIXFMT		0x40014d08
-
-#define FBIOGET_GWINFO		0x46E0
-#define FBIOPUT_GWINFO		0x46E1
-
-#ifdef __KERNEL__
-#include <linux/spinlock.h>
-
-/*
- * These are the fields of area descriptor(in DDR memory) for every plane
- */
-struct diu_ad {
-	/* Word 0(32-bit) in DDR memory */
-/* 	__u16 comp; */
-/* 	__u16 pixel_s:2; */
-/* 	__u16 pallete:1; */
-/* 	__u16 red_c:2; */
-/* 	__u16 green_c:2; */
-/* 	__u16 blue_c:2; */
-/* 	__u16 alpha_c:3; */
-/* 	__u16 byte_f:1; */
-/* 	__u16 res0:3; */
-
-	__be32 pix_fmt; /* hard coding pixel format */
-
-	/* Word 1(32-bit) in DDR memory */
-	__le32 addr;
-
-	/* Word 2(32-bit) in DDR memory */
-/* 	__u32 delta_xs:11; */
-/* 	__u32 res1:1; */
-/* 	__u32 delta_ys:11; */
-/* 	__u32 res2:1; */
-/* 	__u32 g_alpha:8; */
-	__le32 src_size_g_alpha;
-
-	/* Word 3(32-bit) in DDR memory */
-/* 	__u32 delta_xi:11; */
-/* 	__u32 res3:5; */
-/* 	__u32 delta_yi:11; */
-/* 	__u32 res4:3; */
-/* 	__u32 flip:2; */
-	__le32 aoi_size;
-
-	/* Word 4(32-bit) in DDR memory */
-	/*__u32 offset_xi:11;
-	__u32 res5:5;
-	__u32 offset_yi:11;
-	__u32 res6:5;
-	*/
-	__le32 offset_xyi;
-
-	/* Word 5(32-bit) in DDR memory */
-	/*__u32 offset_xd:11;
-	__u32 res7:5;
-	__u32 offset_yd:11;
-	__u32 res8:5; */
-	__le32 offset_xyd;
-
-
-	/* Word 6(32-bit) in DDR memory */
-	__u8 ckmax_r;
-	__u8 ckmax_g;
-	__u8 ckmax_b;
-	__u8 res9;
-
-	/* Word 7(32-bit) in DDR memory */
-	__u8 ckmin_r;
-	__u8 ckmin_g;
-	__u8 ckmin_b;
-	__u8 res10;
-/* 	__u32 res10:8; */
-
-	/* Word 8(32-bit) in DDR memory */
-	__le32 next_ad;
-
-	/* Word 9(32-bit) in DDR memory, just for 64-bit aligned */
-	__u32 paddr;
-} __attribute__ ((packed));
-
-/* DIU register map */
-struct diu {
-	__be32 desc[3];
-	__be32 gamma;
-	__be32 pallete;
-	__be32 cursor;
-	__be32 curs_pos;
-	__be32 diu_mode;
-	__be32 bgnd;
-	__be32 bgnd_wb;
-	__be32 disp_size;
-	__be32 wb_size;
-	__be32 wb_mem_addr;
-	__be32 hsyn_para;
-	__be32 vsyn_para;
-	__be32 syn_pol;
-	__be32 thresholds;
-	__be32 int_status;
-	__be32 int_mask;
-	__be32 colorbar[8];
-	__be32 filling;
-	__be32 plut;
-} __attribute__ ((packed));
-
-struct diu_hw {
-	struct diu *diu_reg;
-	spinlock_t reg_lock;
-
-	__u32 mode;		/* DIU operation mode */
-};
-
-struct diu_addr {
-	__u8 __iomem *vaddr;	/* Virtual address */
-	dma_addr_t paddr;	/* Physical address */
-	__u32 	   offset;
-};
-
-struct diu_pool {
-	struct diu_addr ad;
-	struct diu_addr gamma;
-	struct diu_addr pallete;
-	struct diu_addr cursor;
-};
-
-#define FSL_DIU_BASE_OFFSET	0x2C000	/* Offset of DIU */
-#define INT_LCDC		64	/* DIU interrupt number */
-
-#define FSL_AOI_NUM	6	/* 5 AOIs and one dummy AOI */
-				/* 1 for plane 0, 2 for plane 1&2 each */
-
-/* Minimum X and Y resolutions */
-#define MIN_XRES	64
-#define MIN_YRES	64
-
-/* HW cursor parameters */
-#define MAX_CURS		32
-
-/* Modes of operation of DIU */
-#define MFB_MODE0	0	/* DIU off */
-#define MFB_MODE1	1	/* All three planes output to display */
-#define MFB_MODE2	2	/* Plane 1 to display, planes 2+3 written back*/
-#define MFB_MODE3	3	/* All three planes written back to memory */
-#define MFB_MODE4	4	/* Color bar generation */
-
-/* INT_STATUS/INT_MASK field descriptions */
-#define INT_VSYNC	0x01	/* Vsync interrupt  */
-#define INT_VSYNC_WB	0x02	/* Vsync interrupt for write back operation */
-#define INT_UNDRUN	0x04	/* Under run exception interrupt */
-#define INT_PARERR	0x08	/* Display parameters error interrupt */
-#define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
-
-/* Panels'operation modes */
-#define MFB_TYPE_OUTPUT	0	/* Panel output to display */
-#define MFB_TYPE_OFF	1	/* Panel off */
-#define MFB_TYPE_WB	2	/* Panel written back to memory */
-#define MFB_TYPE_TEST	3	/* Panel generate color bar */
-
-#endif /* __KERNEL__ */
-#endif /* __FSL_DIU_FB_H__ */
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
new file mode 100644
index 0000000..fc295d7
--- /dev/null
+++ b/include/linux/fsl-diu-fb.h
@@ -0,0 +1,223 @@
+/*
+ * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ *  Freescale DIU Frame Buffer device driver
+ *
+ *  Authors: Hongjun Chen <hong-jun.chen@freescale.com>
+ *           Paul Widmer <paul.widmer@freescale.com>
+ *           Srikanth Srinivasan <srikanth.srinivasan@freescale.com>
+ *           York Sun <yorksun@freescale.com>
+ *
+ *   Based on imxfb.c Copyright (C) 2004 S.Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __FSL_DIU_FB_H__
+#define __FSL_DIU_FB_H__
+
+/* Arbitrary threshold to determine the allocation method
+ * See mpc8610fb_set_par(), map_video_memory(), and unmap_video_memory()
+ */
+#define MEM_ALLOC_THRESHOLD (1024*768*4+32)
+/* Minimum value that the pixel clock can be set to in pico seconds
+ * This is determined by platform clock/3 where the minimum platform
+ * clock is 533MHz. This gives 5629 pico seconds.
+ */
+#define MIN_PIX_CLK 5629
+#define MAX_PIX_CLK 96096
+
+#include <linux/types.h>
+
+struct mfb_alpha {
+	int enable;
+	int alpha;
+};
+
+struct mfb_chroma_key {
+	int enable;
+	__u8  red_max;
+	__u8  green_max;
+	__u8  blue_max;
+	__u8  red_min;
+	__u8  green_min;
+	__u8  blue_min;
+};
+
+struct aoi_display_offset {
+	int x_aoi_d;
+	int y_aoi_d;
+};
+
+#define MFB_SET_CHROMA_KEY	_IOW('M', 1, struct mfb_chroma_key)
+#define MFB_WAIT_FOR_VSYNC	_IOW('F', 0x20, u_int32_t)
+#define MFB_SET_BRIGHTNESS	_IOW('M', 3, __u8)
+
+#define MFB_SET_ALPHA		0x80014d00
+#define MFB_GET_ALPHA		0x40014d00
+#define MFB_SET_AOID		0x80084d04
+#define MFB_GET_AOID		0x40084d04
+#define MFB_SET_PIXFMT		0x80014d08
+#define MFB_GET_PIXFMT		0x40014d08
+
+#define FBIOGET_GWINFO		0x46E0
+#define FBIOPUT_GWINFO		0x46E1
+
+#ifdef __KERNEL__
+#include <linux/spinlock.h>
+
+/*
+ * These are the fields of area descriptor(in DDR memory) for every plane
+ */
+struct diu_ad {
+	/* Word 0(32-bit) in DDR memory */
+/* 	__u16 comp; */
+/* 	__u16 pixel_s:2; */
+/* 	__u16 pallete:1; */
+/* 	__u16 red_c:2; */
+/* 	__u16 green_c:2; */
+/* 	__u16 blue_c:2; */
+/* 	__u16 alpha_c:3; */
+/* 	__u16 byte_f:1; */
+/* 	__u16 res0:3; */
+
+	__be32 pix_fmt; /* hard coding pixel format */
+
+	/* Word 1(32-bit) in DDR memory */
+	__le32 addr;
+
+	/* Word 2(32-bit) in DDR memory */
+/* 	__u32 delta_xs:11; */
+/* 	__u32 res1:1; */
+/* 	__u32 delta_ys:11; */
+/* 	__u32 res2:1; */
+/* 	__u32 g_alpha:8; */
+	__le32 src_size_g_alpha;
+
+	/* Word 3(32-bit) in DDR memory */
+/* 	__u32 delta_xi:11; */
+/* 	__u32 res3:5; */
+/* 	__u32 delta_yi:11; */
+/* 	__u32 res4:3; */
+/* 	__u32 flip:2; */
+	__le32 aoi_size;
+
+	/* Word 4(32-bit) in DDR memory */
+	/*__u32 offset_xi:11;
+	__u32 res5:5;
+	__u32 offset_yi:11;
+	__u32 res6:5;
+	*/
+	__le32 offset_xyi;
+
+	/* Word 5(32-bit) in DDR memory */
+	/*__u32 offset_xd:11;
+	__u32 res7:5;
+	__u32 offset_yd:11;
+	__u32 res8:5; */
+	__le32 offset_xyd;
+
+
+	/* Word 6(32-bit) in DDR memory */
+	__u8 ckmax_r;
+	__u8 ckmax_g;
+	__u8 ckmax_b;
+	__u8 res9;
+
+	/* Word 7(32-bit) in DDR memory */
+	__u8 ckmin_r;
+	__u8 ckmin_g;
+	__u8 ckmin_b;
+	__u8 res10;
+/* 	__u32 res10:8; */
+
+	/* Word 8(32-bit) in DDR memory */
+	__le32 next_ad;
+
+	/* Word 9(32-bit) in DDR memory, just for 64-bit aligned */
+	__u32 paddr;
+} __attribute__ ((packed));
+
+/* DIU register map */
+struct diu {
+	__be32 desc[3];
+	__be32 gamma;
+	__be32 pallete;
+	__be32 cursor;
+	__be32 curs_pos;
+	__be32 diu_mode;
+	__be32 bgnd;
+	__be32 bgnd_wb;
+	__be32 disp_size;
+	__be32 wb_size;
+	__be32 wb_mem_addr;
+	__be32 hsyn_para;
+	__be32 vsyn_para;
+	__be32 syn_pol;
+	__be32 thresholds;
+	__be32 int_status;
+	__be32 int_mask;
+	__be32 colorbar[8];
+	__be32 filling;
+	__be32 plut;
+} __attribute__ ((packed));
+
+struct diu_hw {
+	struct diu *diu_reg;
+	spinlock_t reg_lock;
+
+	__u32 mode;		/* DIU operation mode */
+};
+
+struct diu_addr {
+	__u8 __iomem *vaddr;	/* Virtual address */
+	dma_addr_t paddr;	/* Physical address */
+	__u32 	   offset;
+};
+
+struct diu_pool {
+	struct diu_addr ad;
+	struct diu_addr gamma;
+	struct diu_addr pallete;
+	struct diu_addr cursor;
+};
+
+#define FSL_DIU_BASE_OFFSET	0x2C000	/* Offset of DIU */
+#define INT_LCDC		64	/* DIU interrupt number */
+
+#define FSL_AOI_NUM	6	/* 5 AOIs and one dummy AOI */
+				/* 1 for plane 0, 2 for plane 1&2 each */
+
+/* Minimum X and Y resolutions */
+#define MIN_XRES	64
+#define MIN_YRES	64
+
+/* HW cursor parameters */
+#define MAX_CURS		32
+
+/* Modes of operation of DIU */
+#define MFB_MODE0	0	/* DIU off */
+#define MFB_MODE1	1	/* All three planes output to display */
+#define MFB_MODE2	2	/* Plane 1 to display, planes 2+3 written back*/
+#define MFB_MODE3	3	/* All three planes written back to memory */
+#define MFB_MODE4	4	/* Color bar generation */
+
+/* INT_STATUS/INT_MASK field descriptions */
+#define INT_VSYNC	0x01	/* Vsync interrupt  */
+#define INT_VSYNC_WB	0x02	/* Vsync interrupt for write back operation */
+#define INT_UNDRUN	0x04	/* Under run exception interrupt */
+#define INT_PARERR	0x08	/* Display parameters error interrupt */
+#define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
+
+/* Panels'operation modes */
+#define MFB_TYPE_OUTPUT	0	/* Panel output to display */
+#define MFB_TYPE_OFF	1	/* Panel off */
+#define MFB_TYPE_WB	2	/* Panel written back to memory */
+#define MFB_TYPE_TEST	3	/* Panel generate color bar */
+
+#endif /* __KERNEL__ */
+#endif /* __FSL_DIU_FB_H__ */
-- 
1.6.3.3
