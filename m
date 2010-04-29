Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 55F9CB7D6C
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 09:49:40 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
Date: Fri, 30 Apr 2010 01:49:36 +0200
Message-Id: <1272584978-19063-4-git-send-email-agust@denx.de>
In-Reply-To: <1272584978-19063-1-git-send-email-agust@denx.de>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	John Rigby <jrigby@gmail.com>,
	devicetree-discuss@lists.ozlabs.org, yorksun@freescale.com
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

Signed-off-by: John Rigby <jrigby@gmail.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
Changes since previous patch version:
 - split out moving fsl-diu-fb.h file to separate patch
 - drop unrelated changes
 - remove __init annotations in header file
 - drop unneeded code
 - don't hardcode default busfreq, error out
   forcing users to supply a valid tree
 - simplify pixelclock calculation

 arch/powerpc/platforms/512x/mpc5121_ads.c     |    7 +
 arch/powerpc/platforms/512x/mpc5121_generic.c |   12 +
 arch/powerpc/platforms/512x/mpc512x.h         |    2 +
 arch/powerpc/platforms/512x/mpc512x_shared.c  |  284 +++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                 |    1 +
 drivers/video/fsl-diu-fb.c                    |   17 ++-
 6 files changed, 321 insertions(+), 2 deletions(-)

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
index a6c0e3a..c5ecb3d 100644
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -48,10 +48,22 @@ static int __init mpc5121_generic_probe(void)
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
index b2daca0..1ab6d11 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -16,4 +16,6 @@ extern void __init mpc512x_init(void);
 extern int __init mpc5121_clk_init(void);
 void __init mpc512x_declare_of_platform_devices(void);
 extern void mpc512x_restart(char *cmd);
+extern void mpc512x_init_diu(void);
+extern void mpc512x_setup_diu(void);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index b7f518a..8e297fa 100644
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
@@ -53,6 +57,286 @@ void mpc512x_restart(char *cmd)
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
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np) {
+		unsigned int size;
+		const unsigned int *prop =
+			of_get_property(np, "bus-frequency", &size);
+
+		of_node_put(np);
+		if (prop) {
+			busfreq = *prop;
+		} else {
+			pr_err("Can't get bus-frequency property\n");
+			return;
+		}
+	} else {
+		pr_err("Can't find \"cpu\" node.\n");
+		return;
+	}
+
+	/* Pixel Clock configuration */
+	pr_debug("DIU: Bus Frequency = %lu\n", busfreq);
+	speed_ccb = busfreq * 4;
+
+	/* Calculate the pixel clock with the smallest error */
+	/* calculate the following in steps to avoid overflow */
+	pr_debug("DIU pixclock in ps - %d\n", pixclock);
+	temp = (1000000000 / pixclock) * 1000;
+	pixclock = temp;
+	pr_debug("DIU pixclock freq - %u\n", pixclock);
+
+	temp = (temp * 5) / 100; /* pixclock * 0.05 */
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
+static struct fsl_diu_shared_fb __attribute__ ((__aligned__(8))) diu_shared_fb;
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
index 42381bb..5360948 100644
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
index 7acdc09..81dec09 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1103,6 +1103,10 @@ static int fsl_diu_open(struct fb_info *info, int user)
 	struct mfb_info *mfbi = info->par;
 	int res = 0;
 
+	/* free boot splash memory on first /dev/fb0 open */
+	if (!mfbi->index && diu_ops.release_bootmem)
+		diu_ops.release_bootmem();
+
 	spin_lock(&diu_lock);
 	mfbi->count++;
 	if (mfbi->count == 1) {
@@ -1430,6 +1434,7 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
 	int ret, i, error = 0;
 	struct resource res;
 	struct fsl_diu_data *machine_data;
+	int diu_mode;
 
 	machine_data = kzalloc(sizeof(struct fsl_diu_data), GFP_KERNEL);
 	if (!machine_data)
@@ -1466,7 +1471,9 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
 		goto error2;
 	}
 
-	out_be32(&dr.diu_reg->diu_mode, 0);		/* disable DIU anyway*/
+	diu_mode = in_be32(&dr.diu_reg->diu_mode);
+	if (diu_mode != MFB_MODE1)
+		out_be32(&dr.diu_reg->diu_mode, 0);	/* disable DIU */
 
 	/* Get the IRQ of the DIU */
 	machine_data->irq = irq_of_parse_and_map(np, 0);
@@ -1514,7 +1521,13 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
 	machine_data->dummy_ad->offset_xyd = 0;
 	machine_data->dummy_ad->next_ad = 0;
 
-	out_be32(&dr.diu_reg->desc[0], machine_data->dummy_ad->paddr);
+	/*
+	 * Let DIU display splash screen if it was pre-initialized
+	 * by the bootloader, set dummy area descriptor otherwise.
+	 */
+	if (diu_mode != MFB_MODE1)
+		out_be32(&dr.diu_reg->desc[0], machine_data->dummy_ad->paddr);
+
 	out_be32(&dr.diu_reg->desc[1], machine_data->dummy_ad->paddr);
 	out_be32(&dr.diu_reg->desc[2], machine_data->dummy_ad->paddr);
 
-- 
1.6.3.3
