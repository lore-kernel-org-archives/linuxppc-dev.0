Return-Path: <Dongsheng.Wang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8684514008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 18:52:08 +1000 (EST)
Received: from mail105-ch1 (localhost [127.0.0.1])	by
 mail105-ch1-R.bigfish.com (Postfix) with ESMTP id 684B5220717	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 08:51:17 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <yorksun@freescale.com>
Subject: [PATCH] powerpc/diu: adjust DIU initialization entry
Date: Fri, 18 Apr 2014 16:49:21 +0800
Message-ID: <1397810961-3831-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>, jason.jin@freescale.com
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

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index e8758b9..75ab20e 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1680,6 +1680,99 @@ static ssize_t show_monitor(struct device *device,
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
+		} else
+			fb_mode = opt;
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
+	int ret;
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
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	np = of_find_node_by_type(NULL, "cpu");
+	if (!np) {
+		pr_err("fsl-diu-fb: can't find 'cpu' device node\n");
+		return -ENODEV;
+	}
+
+	prop = of_get_property(np, "d-cache-size", NULL);
+	if (prop == NULL) {
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
+	if (prop == NULL) {
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
+	return ret;
+}
+
 static int fsl_diu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1690,10 +1783,14 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	unsigned int i;
 	int ret;
 
+	fsl_diu_perpare();
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
@@ -1819,6 +1916,11 @@ error:
 
 	iounmap(data->diu_reg);
 
+out_perpare:
+#if defined(CONFIG_NOT_COHERENT_CACHE)
+	if (coherence_data)
+		vfree(coherence_data);
+#endif
 	return ret;
 }
 
@@ -1837,34 +1939,12 @@ static int fsl_diu_remove(struct platform_device *pdev)
 
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
@@ -1892,88 +1972,12 @@ static struct platform_driver fsl_diu_driver = {
 
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
1.8.5
