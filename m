Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id BE173B7D7B
	for <linuxppc-dev@ozlabs.org>; Mon,  3 May 2010 20:50:10 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 3/5] powerpc/mpc5121: shared DIU framebuffer support
Date: Mon,  3 May 2010 12:49:59 +0200
Message-Id: <1272883799-12522-1-git-send-email-agust@denx.de>
In-Reply-To: <1272624015-4356-1-git-send-email-agust@denx.de>
References: <1272624015-4356-1-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	John Rigby <jrigby@gmail.com>,
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

Signed-off-by: John Rigby <jrigby@gmail.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
v2 -> v3:
 - remove generic wrappers for early_init() and
   setup_arch() and assign needed callbacks directly
   as requested by Timur
 - add comment explaning the reason for using
   reserve_bootmem()
 - use less confusing name for "speed" variable in
   mpc512x_set_pixel_clock() and add a comment. Also
   initialize "err" variable to LONG_MAX.

 arch/powerpc/include/asm/mpc5121.h            |   32 +++
 arch/powerpc/platforms/512x/mpc5121_ads.c     |    2 +
 arch/powerpc/platforms/512x/mpc5121_generic.c |    2 +
 arch/powerpc/platforms/512x/mpc512x.h         |    2 +
 arch/powerpc/platforms/512x/mpc512x_shared.c  |  284 +++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                 |    1 +
 drivers/video/fsl-diu-fb.c                    |   17 ++-
 7 files changed, 338 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc5121.h b/arch/powerpc/include/asm/mpc5121.h
index e6a30bb..8c0ab2c 100644
--- a/arch/powerpc/include/asm/mpc5121.h
+++ b/arch/powerpc/include/asm/mpc5121.h
@@ -21,4 +21,36 @@ struct mpc512x_reset_module {
 	u32	rcer;	/* Reset Control Enable Register */
 };
 
+/*
+ * Clock Control Module
+ */
+struct mpc512x_ccm {
+	u32	spmr;	/* System PLL Mode Register */
+	u32	sccr1;	/* System Clock Control Register 1 */
+	u32	sccr2;	/* System Clock Control Register 2 */
+	u32	scfr1;	/* System Clock Frequency Register 1 */
+	u32	scfr2;	/* System Clock Frequency Register 2 */
+	u32	scfr2s;	/* System Clock Frequency Shadow Register 2 */
+	u32	bcr;	/* Bread Crumb Register */
+	u32	p0ccr;	/* PSC0 Clock Control Register */
+	u32	p1ccr;	/* PSC1 CCR */
+	u32	p2ccr;	/* PSC2 CCR */
+	u32	p3ccr;	/* PSC3 CCR */
+	u32	p4ccr;	/* PSC4 CCR */
+	u32	p5ccr;	/* PSC5 CCR */
+	u32	p6ccr;	/* PSC6 CCR */
+	u32	p7ccr;	/* PSC7 CCR */
+	u32	p8ccr;	/* PSC8 CCR */
+	u32	p9ccr;	/* PSC9 CCR */
+	u32	p10ccr;	/* PSC10 CCR */
+	u32	p11ccr;	/* PSC11 CCR */
+	u32	spccr;	/* SPDIF Clock Control Register */
+	u32	cccr;	/* CFM Clock Control Register */
+	u32	dccr;	/* DIU Clock Control Register */
+	u32	m1ccr;	/* MSCAN1 CCR */
+	u32	m2ccr;	/* MSCAN2 CCR */
+	u32	m3ccr;	/* MSCAN3 CCR */
+	u32	m4ccr;	/* MSCAN4 CCR */
+	u8	res[0x98]; /* Reserved */
+};
 #endif /* __ASM_POWERPC_MPC5121_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index ee6ae12..dcef6ad 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -42,6 +42,7 @@ static void __init mpc5121_ads_setup_arch(void)
 	for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
 		mpc83xx_add_bridge(np);
 #endif
+	mpc512x_setup_diu();
 }
 
 static void __init mpc5121_ads_init_IRQ(void)
@@ -65,6 +66,7 @@ define_machine(mpc5121_ads) {
 	.probe			= mpc5121_ads_probe,
 	.setup_arch		= mpc5121_ads_setup_arch,
 	.init			= mpc512x_init,
+	.init_early		= mpc512x_init_diu,
 	.init_IRQ		= mpc5121_ads_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
index a6c0e3a..e487eb0 100644
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -52,6 +52,8 @@ define_machine(mpc5121_generic) {
 	.name			= "MPC5121 generic",
 	.probe			= mpc5121_generic_probe,
 	.init			= mpc512x_init,
+	.init_early		= mpc512x_init_diu,
+	.setup_arch		= mpc512x_setup_diu,
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
index b7f518a..6203a34 100644
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
+	u8		gamma[0x300];	/* 32-bit aligned! */
+	struct diu_ad	ad0;		/* 32-bit aligned! */
+	phys_addr_t	fb_phys;
+	size_t		fb_len;
+	bool		in_use;
+};
+
+unsigned int mpc512x_get_pixel_format(unsigned int bits_per_pixel,
+				      int monitor_port)
+{
+	switch (bits_per_pixel) {
+	case 32:
+		return 0x88883316;
+	case 24:
+		return 0x88082219;
+	case 16:
+		return 0x65053118;
+	}
+	return 0x00000400;
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
+#define DIU_DIV_MASK	0x000000ff
+void mpc512x_set_pixel_clock(unsigned int pixclock)
+{
+	unsigned long bestval, bestfreq, speed, busfreq;
+	unsigned long minpixclock, maxpixclock, pixval;
+	struct mpc512x_ccm __iomem *ccm;
+	struct device_node *np;
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
+	of_node_put(np);
+	if (!ccm) {
+		pr_err("Can't map clock control module reg.\n");
+		return;
+	}
+
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np) {
+		const unsigned int *prop =
+			of_get_property(np, "bus-frequency", NULL);
+
+		of_node_put(np);
+		if (prop) {
+			busfreq = *prop;
+		} else {
+			pr_err("Can't get bus-frequency property\n");
+			return;
+		}
+	} else {
+		pr_err("Can't find 'cpu' node.\n");
+		return;
+	}
+
+	/* Pixel Clock configuration */
+	pr_debug("DIU: Bus Frequency = %lu\n", busfreq);
+	speed = busfreq * 4; /* DIU_DIV ratio is 4 * CSB_CLK / DIU_CLK */
+
+	/* Calculate the pixel clock with the smallest error */
+	/* calculate the following in steps to avoid overflow */
+	pr_debug("DIU pixclock in ps - %d\n", pixclock);
+	temp = (1000000000 / pixclock) * 1000;
+	pixclock = temp;
+	pr_debug("DIU pixclock freq - %u\n", pixclock);
+
+	temp = temp / 20; /* pixclock * 0.05 */
+	pr_debug("deviation = %d\n", temp);
+	minpixclock = pixclock - temp;
+	maxpixclock = pixclock + temp;
+	pr_debug("DIU minpixclock - %lu\n", minpixclock);
+	pr_debug("DIU maxpixclock - %lu\n", maxpixclock);
+	pixval = speed/pixclock;
+	pr_debug("DIU pixval = %lu\n", pixval);
+
+	err = LONG_MAX;
+	bestval = pixval;
+	pr_debug("DIU bestval = %lu\n", bestval);
+
+	bestfreq = 0;
+	for (i = -1; i <= 1; i++) {
+		temp = speed / (pixval+i);
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
+	temp = in_be32(&ccm->scfr1);
+	pr_debug("DIU: Current value of SCFR1: 0x%08x\n", temp);
+	temp &= ~DIU_DIV_MASK;
+	temp |= (bestval & DIU_DIV_MASK);
+	out_be32(&ccm->scfr1, temp);
+	pr_debug("DIU: Modified value of SCFR1: 0x%08x\n", temp);
+	iounmap(ccm);
+}
+
+ssize_t mpc512x_show_monitor_port(int monitor_port, char *buf)
+{
+	return sprintf(buf, "0 - 5121 LCD\n");
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
+	struct diu __iomem *diu_reg;
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
+	mode = in_be32(&diu_reg->diu_mode);
+	if (mode != MFB_MODE1) {
+		pr_info("%s: DIU OFF\n", __func__);
+		goto out;
+	}
+
+	desc = in_be32(&diu_reg->desc[0]);
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
+	res = in_be32(&diu_reg->disp_size);
+	pix_fmt = in_le32(vaddr);
+	bpp = ((pix_fmt >> 16) & 0x3) + 1;
+	diu_shared_fb.fb_phys = in_le32(vaddr + 4);
+	diu_shared_fb.fb_len = ((res & 0xfff0000) >> 16) * (res & 0xfff) * bpp;
+	diu_shared_fb.in_use = true;
+	iounmap(vaddr);
+
+	desc = in_be32(&diu_reg->gamma);
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
+	out_be32(&diu_reg->gamma, virt_to_phys(&diu_shared_fb.gamma));
+	out_be32(&diu_reg->desc[1], 0);
+	out_be32(&diu_reg->desc[2], 0);
+	out_be32(&diu_reg->desc[0], virt_to_phys(&diu_shared_fb.ad0));
+
+out:
+	iounmap(diu_reg);
+}
+
+void __init mpc512x_setup_diu(void)
+{
+	int ret;
+
+	/*
+	 * We do not allocate and configure new area for bitmap buffer
+	 * because it would requere copying bitmap data (splash image)
+	 * and so negatively affect boot time. Instead we reserve the
+	 * already configured frame buffer area so that it won't be
+	 * destroyed. The starting address of the area to reserve and
+	 * also it's length is passed to reserve_bootmem(). It will be
+	 * freed later on first open of fbdev, when splash image is not
+	 * needed any more.
+	 */
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
