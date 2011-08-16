Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 223B5B6FAF
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 08:36:14 +1000 (EST)
Received: from mail65-am1 (localhost.localdomain [127.0.0.1])	by
	mail65-am1-R.bigfish.com (Postfix) with ESMTP id 3BF1473841F	for
	<linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 22:36:10 +0000 (UTC)
Received: from AM1EHSMHS004.bigfish.com (unknown [10.3.201.252])	by
	mail65-am1.bigfish.com (Postfix) with ESMTP id ED0D0440059	for
	<linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 22:36:09 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: enable the audio drivers in the defconfigs
Date: Tue, 16 Aug 2011 18:36:07 -0400
Message-ID: <1313534167-6698-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the audio drivers in the non-corenet 85xx defconfigs so that audio
is enabled on the Freescale P1022DS reference board.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c |   61 ++++++++++++++++++++++++++++------------------
 1 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index d48afea..06ac2b9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -289,16 +289,6 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	 */
 	if (!ssi_private->playback && !ssi_private->capture) {
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-		int ret;
-
-		/* The 'name' should not have any slashes in it. */
-		ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0,
-				  ssi_private->name, ssi_private);
-		if (ret < 0) {
-			dev_err(substream->pcm->card->dev,
-				"could not claim irq %u\n", ssi_private->irq);
-			return ret;
-		}
 
 		/*
 		 * Section 16.5 of the MPC8610 reference manual says that the
@@ -522,15 +512,12 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	ssi_private->second_stream = NULL;
 
 	/*
-	 * If this is the last active substream, disable the SSI and release
-	 * the IRQ.
+	 * If this is the last active substream, disable the SSI.
 	 */
 	if (!ssi_private->playback && !ssi_private->capture) {
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
 		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
-
-		free_irq(ssi_private->irq, ssi_private);
 	}
 }
 
@@ -675,17 +662,30 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
 		dev_err(&pdev->dev, "could not determine device resources\n");
-		kfree(ssi_private);
-		return ret;
+		goto error_kmalloc;
 	}
 	ssi_private->ssi = of_iomap(np, 0);
 	if (!ssi_private->ssi) {
 		dev_err(&pdev->dev, "could not map device resources\n");
-		kfree(ssi_private);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto error_kmalloc;
 	}
 	ssi_private->ssi_phys = res.start;
+
 	ssi_private->irq = irq_of_parse_and_map(np, 0);
+	if (ssi_private->irq == NO_IRQ) {
+		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
+		ret = -ENXIO;
+		goto error_iomap;
+	}
+
+	/* The 'name' should not have any slashes in it. */
+	ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0, ssi_private->name,
+			  ssi_private);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not claim irq %u\n", ssi_private->irq);
+		goto error_irqmap;
+	}
 
 	/* Are the RX and the TX clocks locked? */
 	if (of_find_property(np, "fsl,ssi-asynchronous", NULL))
@@ -711,7 +711,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "could not create sysfs %s file\n",
 			ssi_private->dev_attr.attr.name);
-		goto error;
+		goto error_irq;
 	}
 
 	/* Register with ASoC */
@@ -720,7 +720,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	ret = snd_soc_register_dai(&pdev->dev, &ssi_private->cpu_dai_drv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
-		goto error;
+		goto error_dev;
 	}
 
 	/* Trigger the machine driver's probe function.  The platform driver
@@ -741,18 +741,28 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	if (IS_ERR(ssi_private->pdev)) {
 		ret = PTR_ERR(ssi_private->pdev);
 		dev_err(&pdev->dev, "failed to register platform: %d\n", ret);
-		goto error;
+		goto error_dai;
 	}
 
 	return 0;
 
-error:
+error_dai:
 	snd_soc_unregister_dai(&pdev->dev);
+
+error_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
-	if (dev_attr)
-		device_remove_file(&pdev->dev, dev_attr);
+	device_remove_file(&pdev->dev, dev_attr);
+
+error_irq:
+	free_irq(ssi_private->irq, ssi_private);
+
+error_irqmap:
 	irq_dispose_mapping(ssi_private->irq);
+
+error_iomap:
 	iounmap(ssi_private->ssi);
+
+error_kmalloc:
 	kfree(ssi_private);
 
 	return ret;
@@ -766,6 +776,9 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	snd_soc_unregister_dai(&pdev->dev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
 
+	free_irq(ssi_private->irq, ssi_private);
+	irq_dispose_mapping(ssi_private->irq);
+
 	kfree(ssi_private);
 	dev_set_drvdata(&pdev->dev, NULL);
 
-- 
1.7.4.4
