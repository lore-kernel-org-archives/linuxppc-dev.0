Return-Path: <computersforpeace@gmail.com>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com
 [IPv6:2607:f8b0:4001:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 064DA2C0373
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 04:33:47 +1100 (EST)
Received: by mail-ie0-f182.google.com with SMTP id as1so6950973iec.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 10:33:41 -0700 (PDT)
From: Brian Norris <computersforpeace@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] powerpc/mpc512x: remove unnecessary #if
Date: Fri, 11 Oct 2013 10:32:57 -0700
Message-Id: <1381512777-13966-1-git-send-email-computersforpeace@gmail.com>
Cc: Gerhard Sittig <gsi@denx.de>, Brian Norris <computersforpeace@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several functions are only ever referenced locally, so make them static.
Of those functions, many of them are protected by an #if. However, the
code which can compile fine in either case.

Now that (1) the unneeded code is marked 'static' and (2) the code is
only used under a C 'if (IS_ENABLED(CONFIG_FB_FSL_DIU))', the compiler
can automatically remove the unneeded code, and we don't need the #if or
the empty stub functions.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
Based off of Gerhard Sittig's patch:
  powerpc/mpc512x: silence build warning upon disabled DIU

Compile-tested with CONFIG_FB_FSL_DIU=n

 arch/powerpc/platforms/512x/mpc512x_shared.c | 19 ++++++-------------
 arch/powerpc/sysdev/fsl_soc.h                |  3 +--
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 1a7b1d0..48e0718 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -60,8 +60,6 @@ void mpc512x_restart(char *cmd)
 		;
 }
 
-#if IS_ENABLED(CONFIG_FB_FSL_DIU)
-
 struct fsl_diu_shared_fb {
 	u8		gamma[0x300];	/* 32-bit aligned! */
 	struct diu_ad	ad0;		/* 32-bit aligned! */
@@ -71,7 +69,7 @@ struct fsl_diu_shared_fb {
 };
 
 #define DIU_DIV_MASK	0x000000ff
-void mpc512x_set_pixel_clock(unsigned int pixclock)
+static void mpc512x_set_pixel_clock(unsigned int pixclock)
 {
 	unsigned long bestval, bestfreq, speed, busfreq;
 	unsigned long minpixclock, maxpixclock, pixval;
@@ -164,7 +162,7 @@ void mpc512x_set_pixel_clock(unsigned int pixclock)
 	iounmap(ccm);
 }
 
-enum fsl_diu_monitor_port
+static enum fsl_diu_monitor_port
 mpc512x_valid_monitor_port(enum fsl_diu_monitor_port port)
 {
 	return FSL_DIU_PORT_DVI;
@@ -179,7 +177,7 @@ static inline void mpc512x_free_bootmem(struct page *page)
 	free_reserved_page(page);
 }
 
-void mpc512x_release_bootmem(void)
+static void mpc512x_release_bootmem(void)
 {
 	unsigned long addr = diu_shared_fb.fb_phys & PAGE_MASK;
 	unsigned long size = diu_shared_fb.fb_len;
@@ -205,7 +203,7 @@ void mpc512x_release_bootmem(void)
  * address range will be reserved in setup_arch() after bootmem
  * allocator is up.
  */
-void __init mpc512x_init_diu(void)
+static void __init mpc512x_init_diu(void)
 {
 	struct device_node *np;
 	struct diu __iomem *diu_reg;
@@ -274,7 +272,7 @@ out:
 	iounmap(diu_reg);
 }
 
-void __init mpc512x_setup_diu(void)
+static void __init mpc512x_setup_diu(void)
 {
 	int ret;
 
@@ -303,11 +301,6 @@ void __init mpc512x_setup_diu(void)
 	diu_ops.release_bootmem		= mpc512x_release_bootmem;
 }
 
-#else
-void __init mpc512x_setup_diu(void) { /* EMPTY */ }
-void __init mpc512x_init_diu(void) { /* EMPTY */ }
-#endif
-
 void __init mpc512x_init_IRQ(void)
 {
 	struct device_node *np;
@@ -340,7 +333,7 @@ static struct of_device_id __initdata of_bus_ids[] = {
 	{},
 };
 
-void __init mpc512x_declare_of_platform_devices(void)
+static void __init mpc512x_declare_of_platform_devices(void)
 {
 	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
 		printk(KERN_ERR __FILE__ ": "
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index c6d0073..f845ffd 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -21,8 +21,6 @@ struct device_node;
 
 extern void fsl_rstcr_restart(char *cmd);
 
-#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-
 /* The different ports that the DIU can be connected to */
 enum fsl_diu_monitor_port {
 	FSL_DIU_PORT_DVI,	/* DVI */
@@ -42,6 +40,7 @@ struct platform_diu_data_ops {
 	void (*release_bootmem)(void);
 };
 
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 extern struct platform_diu_data_ops diu_ops;
 #endif
 
-- 
1.8.4
