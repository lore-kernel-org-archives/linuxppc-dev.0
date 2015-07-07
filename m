Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0137.outbound.protection.outlook.com [65.55.169.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B552E1A1071
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 19:31:15 +1000 (AEST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <yorksun@freescale.com>
CC: <jason.jin@freescale.com>, <linuxppc-dev@lists.ozlabs.org>, Wang Dongsheng
 <dongsheng.wang@freescale.com>
Subject: [RESEND] powerpc/diu: adjust DIU initialization entry
Date: Tue, 7 Jul 2015 15:51:37 +0800
Message-ID: <1436255497-41207-1-git-send-email-dongsheng.wang@freescale.com>
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

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Move fsl_diu_init into diu probe function, because it should be
initialized when system get diu device tree node, not always do
initialization.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
Changes:
Rebase original patch for upstream because fsl-diu-fb.c has moved to fbdev dir.

This patch is a long time ago, there is no feedback, and the Patchwork state
has been modified for the changes requested, I don't know why. So I resend
this patch to upstream.

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 7fa2e6f..164e22e 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1680,6 +1680,105 @@ static ssize_t show_monitor(struct device *device,
 	return 0;
 }
 
+#ifndef MODULE
+static int __init fsl_diu_setup(char *options)
+{
+	char *opt;
+	unsigned long val;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((opt = strsep(&options, ",")) != NULL) {
+		if (!*opt)
+			continue;
+		if (!strncmp(opt, "monitor=", 8)) {
+			monitor_port = fsl_diu_name_to_port(opt + 8);
+		} else if (!strncmp(opt, "bpp=", 4)) {
+			if (!kstrtoul(opt + 4, 10, &val))
+				default_bpp = val;
+		} else {
+			fb_mode = opt;
+		}
+	}
+
+	return 0;
+}
+#endif
+
+static int fsl_diu_perpare(void)
+{
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	struct device_node *np;
+	const u32 *prop;
+#endif
+#ifndef MODULE
+	char *option;
+
+	/*
+	 * For kernel boot options (in 'video=xxxfb:<options>' format)
+	 */
+	if (fb_get_options("fslfb", &option))
+		return -ENODEV;
+	fsl_diu_setup(option);
+#else
+	monitor_port = fsl_diu_name_to_port(monitor_string);
+#endif
+	pr_info("Freescale Display Interface Unit (DIU) framebuffer driver\n");
+
+	if (!diu_ops.set_pixel_clock) {
+		pr_info("%s: Board not support DIU. Can't dispaly video.\n",
+			__func__);
+		return -ENODEV;
+	}
+
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	np = of_find_node_by_type(NULL, "cpu");
+	if (!np) {
+		pr_err("fsl-diu-fb: can't find 'cpu' device node\n");
+		return -ENODEV;
+	}
+
+	prop = of_get_property(np, "d-cache-size", NULL);
+	if (!prop) {
+		pr_err("fsl-diu-fb: missing 'd-cache-size'\n");
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	/*
+	 * Freescale PLRU requires 13/8 times the cache size to do a proper
+	 * displacement flush
+	 */
+	coherence_data_size = be32_to_cpup(prop) * 13;
+	coherence_data_size /= 8;
+
+	pr_debug("fsl-diu-fb: coherence data size is %zu bytes\n",
+		 coherence_data_size);
+
+	prop = of_get_property(np, "d-cache-line-size", NULL);
+	if (!prop) {
+		pr_err("fsl-diu-fb: missing 'd-cache-line-size'\n");
+		of_node_put(np);
+		return -ENODEV;
+	}
+	d_cache_line_size = be32_to_cpup(prop);
+
+	pr_debug("fsl-diu-fb: cache lines size is %u bytes\n",
+		 d_cache_line_size);
+
+	of_node_put(np);
+	coherence_data = vmalloc(coherence_data_size);
+	if (!coherence_data) {
+		pr_err("fsl-diu-fb: could not allocate coherence data\n");
+		pr_err("coherence_data_size=%zu)\n", coherence_data_size);
+		return -ENOMEM;
+	}
+
+#endif
+	return 0;
+}
+
 static int fsl_diu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1690,10 +1789,16 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	unsigned int i;
 	int ret;
 
+	ret = fsl_diu_perpare();
+	if (ret)
+		goto out_perpare;
+
 	data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
 				   &dma_addr, GFP_DMA | __GFP_ZERO);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		ret = -ENOMEM;
+		goto out_perpare;
+	}
 	data->dma_addr = dma_addr;
 
 	/*
@@ -1819,6 +1924,11 @@ error:
 
 	iounmap(data->diu_reg);
 
+out_perpare:
+#if defined(CONFIG_NOT_COHERENT_CACHE)
+	if (coherence_data)
+		vfree(coherence_data);
+#endif
 	return ret;
 }
 
@@ -1837,34 +1947,12 @@ static int fsl_diu_remove(struct platform_device *pdev)
 
 	iounmap(data->diu_reg);
 
+#if defined(CONFIG_NOT_COHERENT_CACHE)
+	vfree(coherence_data);
+#endif
 	return 0;
 }
 
-#ifndef MODULE
-static int __init fsl_diu_setup(char *options)
-{
-	char *opt;
-	unsigned long val;
-
-	if (!options || !*options)
-		return 0;
-
-	while ((opt = strsep(&options, ",")) != NULL) {
-		if (!*opt)
-			continue;
-		if (!strncmp(opt, "monitor=", 8)) {
-			monitor_port = fsl_diu_name_to_port(opt + 8);
-		} else if (!strncmp(opt, "bpp=", 4)) {
-			if (!kstrtoul(opt + 4, 10, &val))
-				default_bpp = val;
-		} else
-			fb_mode = opt;
-	}
-
-	return 0;
-}
-#endif
-
 static struct of_device_id fsl_diu_match[] = {
 #ifdef CONFIG_PPC_MPC512x
 	{
@@ -1891,88 +1979,12 @@ static struct platform_driver fsl_diu_driver = {
 
 static int __init fsl_diu_init(void)
 {
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	struct device_node *np;
-	const u32 *prop;
-#endif
-	int ret;
-#ifndef MODULE
-	char *option;
-
-	/*
-	 * For kernel boot options (in 'video=xxxfb:<options>' format)
-	 */
-	if (fb_get_options("fslfb", &option))
-		return -ENODEV;
-	fsl_diu_setup(option);
-#else
-	monitor_port = fsl_diu_name_to_port(monitor_string);
-#endif
-	pr_info("Freescale Display Interface Unit (DIU) framebuffer driver\n");
-
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	np = of_find_node_by_type(NULL, "cpu");
-	if (!np) {
-		pr_err("fsl-diu-fb: can't find 'cpu' device node\n");
-		return -ENODEV;
-	}
-
-	prop = of_get_property(np, "d-cache-size", NULL);
-	if (prop == NULL) {
-		pr_err("fsl-diu-fb: missing 'd-cache-size' property' "
-		       "in 'cpu' node\n");
-		of_node_put(np);
-		return -ENODEV;
-	}
-
-	/*
-	 * Freescale PLRU requires 13/8 times the cache size to do a proper
-	 * displacement flush
-	 */
-	coherence_data_size = be32_to_cpup(prop) * 13;
-	coherence_data_size /= 8;
-
-	pr_debug("fsl-diu-fb: coherence data size is %zu bytes\n",
-		 coherence_data_size);
-
-	prop = of_get_property(np, "d-cache-line-size", NULL);
-	if (prop == NULL) {
-		pr_err("fsl-diu-fb: missing 'd-cache-line-size' property' "
-		       "in 'cpu' node\n");
-		of_node_put(np);
-		return -ENODEV;
-	}
-	d_cache_line_size = be32_to_cpup(prop);
-
-	pr_debug("fsl-diu-fb: cache lines size is %u bytes\n",
-		 d_cache_line_size);
-
-	of_node_put(np);
-	coherence_data = vmalloc(coherence_data_size);
-	if (!coherence_data) {
-		pr_err("fsl-diu-fb: could not allocate coherence data "
-		       "(size=%zu)\n", coherence_data_size);
-		return -ENOMEM;
-	}
-
-#endif
-
-	ret = platform_driver_register(&fsl_diu_driver);
-	if (ret) {
-		pr_err("fsl-diu-fb: failed to register platform driver\n");
-#if defined(CONFIG_NOT_COHERENT_CACHE)
-		vfree(coherence_data);
-#endif
-	}
-	return ret;
+	return platform_driver_register(&fsl_diu_driver);
 }
 
 static void __exit fsl_diu_exit(void)
 {
 	platform_driver_unregister(&fsl_diu_driver);
-#if defined(CONFIG_NOT_COHERENT_CACHE)
-	vfree(coherence_data);
-#endif
 }
 
 module_init(fsl_diu_init);
-- 
2.1.0.27.g96db324
