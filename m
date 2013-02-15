Return-Path: <dianders@google.com>
Received: from mail-vb0-f74.google.com (mail-vb0-f74.google.com
 [209.85.212.74])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 137512C0080
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 10:19:35 +1100 (EST)
Received: by mail-vb0-f74.google.com with SMTP id r6so404138vbi.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2013 15:19:33 -0800 (PST)
From: Doug Anderson <dianders@chromium.org>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: Remove unneeded xxx_set_drvdata(..., NULL) calls
Date: Fri, 15 Feb 2013 15:18:35 -0800
Message-Id: <1360970315-32116-1-git-send-email-dianders@chromium.org>
In-Reply-To: <1360953682-25066-1-git-send-email-dianders@chromium.org>
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Kevin Hilman <khilman@ti.com>, Sonic Zhang <sonic.zhang@analog.com>,
 linux-arm-kernel@lists.infradead.org, Deepak Sikri <deepak.sikri@st.com>,
 Havard Skinnemoen <hskinnemoen@gmail.com>, Marek Vasut <marex@denx.de>,
 Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <rob.herring@calxeda.com>, uclinux-dist-devel@blackfin.uclinux.org,
 Jean Delvare <khali@linux-fr.org>, Lars-Peter Clausen <lars@metafoo.de>,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 Barry Song <baohua.song@csr.com>, linux-omap@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Oskar Schirmer <oskar@scara.com>, Fabio Estevam <fabio.estevam@freescale.com>,
 davinci-linux-open-source@linux.davincidsp.com,
 Shawn Guo <shawn.guo@linaro.org>, Jim Cromie <jim.cromie@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomoya MORINAGA <tomoya.rohm@gmail.com>, Doug Anderson <dianders@chromium.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Viresh Kumar <viresh.linux@gmail.com>,
 Karol Lewandowski <k.lewandowsk@samsung.com>, Jiri Kosina <jkosina@suse.cz>,
 STEricsson <STEricsson_nomadik_linux@list.st.com>,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 Alessandro Rubini <rubini@unipv.it>, linuxppc-dev@lists.ozlabs.org,
 Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is simply no reason to be manually setting the private driver
data to NULL in the remove/fail to probe cases.  This is just extra
cruft code that can be removed.

A few notes:
* Nothing relies on drvdata being set to NULL.
* The __device_release_driver() function eventually calls
  dev_set_drvdata(dev, NULL) anyway, so there's no need to do it
  twice.
* I verified that there were no cases where xxx_get_drvdata() was
  being called in these drivers and checking for / relying on the NULL
  return value.

This could be cleaned up kernel-wide but for now just take the baby
step and remove from the i2c subsystem.

Reported-by: Wolfram Sang <wsa@the-dreams.de>
Reported-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/i2c/busses/i2c-au1550.c             | 1 -
 drivers/i2c/busses/i2c-bfin-twi.c           | 2 --
 drivers/i2c/busses/i2c-cpm.c                | 2 --
 drivers/i2c/busses/i2c-davinci.c            | 2 --
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 2 --
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 --
 drivers/i2c/busses/i2c-eg20t.c              | 2 --
 drivers/i2c/busses/i2c-highlander.c         | 4 ----
 drivers/i2c/busses/i2c-i801.c               | 1 -
 drivers/i2c/busses/i2c-ibm_iic.c            | 3 ---
 drivers/i2c/busses/i2c-imx.c                | 1 -
 drivers/i2c/busses/i2c-intel-mid.c          | 2 --
 drivers/i2c/busses/i2c-iop3xx.c             | 2 --
 drivers/i2c/busses/i2c-mpc.c                | 2 --
 drivers/i2c/busses/i2c-mxs.c                | 2 --
 drivers/i2c/busses/i2c-nomadik.c            | 2 --
 drivers/i2c/busses/i2c-ocores.c             | 1 -
 drivers/i2c/busses/i2c-octeon.c             | 5 +----
 drivers/i2c/busses/i2c-omap.c               | 3 ---
 drivers/i2c/busses/i2c-pca-platform.c       | 1 -
 drivers/i2c/busses/i2c-pmcmsp.c             | 2 --
 drivers/i2c/busses/i2c-pnx.c                | 2 --
 drivers/i2c/busses/i2c-powermac.c           | 1 -
 drivers/i2c/busses/i2c-puv3.c               | 2 --
 drivers/i2c/busses/i2c-pxa-pci.c            | 2 --
 drivers/i2c/busses/i2c-pxa.c                | 2 --
 drivers/i2c/busses/i2c-s6000.c              | 1 -
 drivers/i2c/busses/i2c-sh7760.c             | 1 -
 drivers/i2c/busses/i2c-stu300.c             | 1 -
 drivers/i2c/busses/i2c-taos-evm.c           | 2 --
 drivers/i2c/busses/i2c-versatile.c          | 2 --
 drivers/i2c/busses/i2c-xiic.c               | 2 --
 drivers/i2c/busses/i2c-xlr.c                | 1 -
 drivers/i2c/busses/scx200_acb.c             | 1 -
 drivers/i2c/muxes/i2c-mux-gpio.c            | 1 -
 35 files changed, 1 insertion(+), 64 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index b278298..b5b8923 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -376,7 +376,6 @@ static int i2c_au1550_remove(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&priv->adap);
 	i2c_au1550_disable(priv);
 	iounmap(priv->psc_base);
diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 0cf780f..05080c4 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -724,8 +724,6 @@ static int i2c_bfin_twi_remove(struct platform_device *pdev)
 {
 	struct bfin_twi_iface *iface = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	i2c_del_adapter(&(iface->adap));
 	free_irq(iface->irq, iface);
 	peripheral_free_list((unsigned short *)pdev->dev.platform_data);
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2e79c10..3823623 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -682,7 +682,6 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
 out_shut:
 	cpm_i2c_shutdown(cpm);
 out_free:
-	dev_set_drvdata(&ofdev->dev, NULL);
 	kfree(cpm);
 
 	return result;
@@ -696,7 +695,6 @@ static int cpm_i2c_remove(struct platform_device *ofdev)
 
 	cpm_i2c_shutdown(cpm);
 
-	dev_set_drvdata(&ofdev->dev, NULL);
 	kfree(cpm);
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 6a0a553..7d1e590 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -755,7 +755,6 @@ err_mem_ioremap:
 	clk_put(dev->clk);
 	dev->clk = NULL;
 err_free_mem:
-	platform_set_drvdata(pdev, NULL);
 	put_device(&pdev->dev);
 	kfree(dev);
 err_release_region:
@@ -771,7 +770,6 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 
 	i2c_davinci_cpufreq_deregister(dev);
 
-	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
 
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 6add851..7c5e383 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -319,7 +319,6 @@ err_free_irq:
 	free_irq(pdev->irq, dev);
 err_iounmap:
 	iounmap(dev->base);
-	pci_set_drvdata(pdev, NULL);
 	put_device(&pdev->dev);
 	kfree(dev);
 err_release_region:
@@ -336,7 +335,6 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
 	pm_runtime_forbid(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 
-	pci_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d2a33e9..0ceb6e1 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -207,7 +207,6 @@ err_unuse_clocks:
 	clk_put(dev->clk);
 	dev->clk = NULL;
 err_free_mem:
-	platform_set_drvdata(pdev, NULL);
 	put_device(&pdev->dev);
 	kfree(dev);
 err_release_region:
@@ -221,7 +220,6 @@ static int dw_i2c_remove(struct platform_device *pdev)
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 	struct resource *mem;
 
-	platform_set_drvdata(pdev, NULL);
 	pm_runtime_get_sync(&pdev->dev);
 
 	i2c_del_adapter(&dev->adapter);
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 5e7886e..0f37529 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -869,8 +869,6 @@ static void pch_i2c_remove(struct pci_dev *pdev)
 	for (i = 0; i < adap_info->ch_num; i++)
 		adap_info->pch_data[i].pch_base_address = NULL;
 
-	pci_set_drvdata(pdev, NULL);
-
 	pci_release_regions(pdev);
 
 	pci_disable_device(pdev);
diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index 3351cc7..436b0f2 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -436,8 +436,6 @@ err_unmap:
 err:
 	kfree(dev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return ret;
 }
 
@@ -453,8 +451,6 @@ static int highlander_i2c_remove(struct platform_device *pdev)
 	iounmap(dev->base);
 	kfree(dev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b00c29d..38e13cd 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1239,7 +1239,6 @@ static void i801_remove(struct pci_dev *dev)
 		free_irq(dev->irq, priv);
 	pci_release_region(dev, SMBBAR);
 
-	pci_set_drvdata(dev, NULL);
 	kfree(priv);
 	/*
 	 * do not call pci_disable_device(dev) since it can cause hard hangs on
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 33a2abb..405a2e2 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -773,7 +773,6 @@ error_cleanup:
 	if (dev->vaddr)
 		iounmap(dev->vaddr);
 
-	dev_set_drvdata(&ofdev->dev, NULL);
 	kfree(dev);
 	return ret;
 }
@@ -785,8 +784,6 @@ static int iic_remove(struct platform_device *ofdev)
 {
 	struct ibm_iic_private *dev = dev_get_drvdata(&ofdev->dev);
 
-	dev_set_drvdata(&ofdev->dev, NULL);
-
 	i2c_del_adapter(&dev->adap);
 
 	if (dev->irq) {
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a71ece6..82f20c6 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -605,7 +605,6 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
 	/* remove adapter */
 	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
 	i2c_del_adapter(&i2c_imx->adapter);
-	platform_set_drvdata(pdev, NULL);
 
 	/* setup chip registers to defaults */
 	writeb(0, i2c_imx->base + IMX_I2C_IADR);
diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
index de3736b..323fa01 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -1069,7 +1069,6 @@ static int intel_mid_i2c_probe(struct pci_dev *dev,
 fail3:
 	free_irq(dev->irq, mrst);
 fail2:
-	pci_set_drvdata(dev, NULL);
 	kfree(mrst);
 fail1:
 	iounmap(base);
@@ -1087,7 +1086,6 @@ static void intel_mid_i2c_remove(struct pci_dev *dev)
 		dev_err(&dev->dev, "Failed to delete i2c adapter");
 
 	free_irq(dev->irq, mrst);
-	pci_set_drvdata(dev, NULL);
 	iounmap(mrst->base);
 	kfree(mrst);
 	pci_release_region(dev, 0);
diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 2f99613..bc99333 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -415,8 +415,6 @@ iop3xx_i2c_remove(struct platform_device *pdev)
 	kfree(adapter_data);
 	kfree(padapter);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index a69459e..5e705ee 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -696,7 +696,6 @@ static int fsl_i2c_probe(struct platform_device *op)
 	return result;
 
  fail_add:
-	dev_set_drvdata(&op->dev, NULL);
 	free_irq(i2c->irq, i2c);
  fail_request:
 	irq_dispose_mapping(i2c->irq);
@@ -711,7 +710,6 @@ static int fsl_i2c_remove(struct platform_device *op)
 	struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);
 
 	i2c_del_adapter(&i2c->adap);
-	dev_set_drvdata(&op->dev, NULL);
 
 	if (i2c->irq)
 		free_irq(i2c->irq, i2c);
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 22d8ad3..120f246 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -697,8 +697,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
 
 	writel(MXS_I2C_CTRL0_SFTRST, i2c->regs + MXS_I2C_CTRL0_SET);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 5b1b194..650293f 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1105,7 +1105,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
  err_irq:
 	iounmap(dev->virtbase);
  err_no_ioremap:
-	amba_set_drvdata(adev, NULL);
 	kfree(dev);
  err_pinctrl:
  err_no_mem:
@@ -1130,7 +1129,6 @@ static int nmk_i2c_remove(struct amba_device *adev)
 		release_mem_region(res->start, resource_size(res));
 	clk_put(dev->clk);
 	pm_runtime_disable(&adev->dev);
-	amba_set_drvdata(adev, NULL);
 	kfree(dev);
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index a337d08..45150e3 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -452,7 +452,6 @@ static int ocores_i2c_remove(struct platform_device *pdev)
 
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 484ca77..935585e 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -595,7 +595,7 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	result = i2c_add_adapter(&i2c->adap);
 	if (result < 0) {
 		dev_err(i2c->dev, "failed to add adapter\n");
-		goto fail_add;
+		goto out;
 	}
 	dev_info(i2c->dev, "version %s\n", DRV_VERSION);
 
@@ -603,8 +603,6 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail_add:
-	platform_set_drvdata(pdev, NULL);
 out:
 	return result;
 };
@@ -614,7 +612,6 @@ static int octeon_i2c_remove(struct platform_device *pdev)
 	struct octeon_i2c *i2c = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&i2c->adap);
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 };
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 3ee1886..e02f9e3 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1260,7 +1260,6 @@ err_unuse_clocks:
 	pm_runtime_put(dev->dev);
 	pm_runtime_disable(&pdev->dev);
 err_free_mem:
-	platform_set_drvdata(pdev, NULL);
 
 	return r;
 }
@@ -1270,8 +1269,6 @@ static int omap_i2c_remove(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
 	int ret;
 
-	platform_set_drvdata(pdev, NULL);
-
 	i2c_del_adapter(&dev->adapter);
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (IS_ERR_VALUE(ret))
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index a30d2f6..aa00df1 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -260,7 +260,6 @@ e_print:
 static int i2c_pca_pf_remove(struct platform_device *pdev)
 {
 	struct i2c_pca_pf_data *i2c = platform_get_drvdata(pdev);
-	platform_set_drvdata(pdev, NULL);
 
 	i2c_del_adapter(&i2c->adap);
 
diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 083d68c..f6389e2 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -349,7 +349,6 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 	return 0;
 
 ret_unmap:
-	platform_set_drvdata(pldev, NULL);
 	if (pmcmsptwi_data.irq) {
 		pmcmsptwi_writel(0,
 			pmcmsptwi_data.iobase + MSP_TWI_INT_MSK_REG_OFFSET);
@@ -374,7 +373,6 @@ static int pmcmsptwi_remove(struct platform_device *pldev)
 
 	i2c_del_adapter(&pmcmsptwi_adapter);
 
-	platform_set_drvdata(pldev, NULL);
 	if (pmcmsptwi_data.irq) {
 		pmcmsptwi_writel(0,
 			pmcmsptwi_data.iobase + MSP_TWI_INT_MSK_REG_OFFSET);
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index ce40970..5f39c6d 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -761,7 +761,6 @@ out_clkget:
 out_drvdata:
 	kfree(alg_data);
 err_kzalloc:
-	platform_set_drvdata(pdev, NULL);
 	return ret;
 }
 
@@ -776,7 +775,6 @@ static int i2c_pnx_remove(struct platform_device *pdev)
 	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
 	clk_put(alg_data->clk);
 	kfree(alg_data);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 0dd5b33..da54e67 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -221,7 +221,6 @@ static int i2c_powermac_remove(struct platform_device *dev)
 		printk(KERN_WARNING
 		       "i2c-powermac.c: Failed to remove bus %s !\n",
 		       adapter->name);
-	platform_set_drvdata(dev, NULL);
 	memset(adapter, 0, sizeof(*adapter));
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index d7c512d..261d7db 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -223,7 +223,6 @@ static int puv3_i2c_probe(struct platform_device *pdev)
 	return 0;
 
 fail_add_adapter:
-	platform_set_drvdata(pdev, NULL);
 	kfree(adapter);
 fail_nomem:
 	release_mem_region(mem->start, resource_size(mem));
@@ -245,7 +244,6 @@ static int puv3_i2c_remove(struct platform_device *pdev)
 	}
 
 	put_device(&pdev->dev);
-	platform_set_drvdata(pdev, NULL);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 3d49856..9639be8 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -128,7 +128,6 @@ static int ce4100_i2c_probe(struct pci_dev *dev,
 	return 0;
 
 err_dev_add:
-	pci_set_drvdata(dev, NULL);
 	kfree(sds);
 err_mem:
 	pci_disable_device(dev);
@@ -141,7 +140,6 @@ static void ce4100_i2c_remove(struct pci_dev *dev)
 	unsigned int i;
 
 	sds = pci_get_drvdata(dev);
-	pci_set_drvdata(dev, NULL);
 
 	for (i = 0; i < ARRAY_SIZE(sds->pdev); i++)
 		platform_device_unregister(sds->pdev[i]);
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 1034d93..fec18a4 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1219,8 +1219,6 @@ static int __exit i2c_pxa_remove(struct platform_device *dev)
 {
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
-	platform_set_drvdata(dev, NULL);
-
 	i2c_del_adapter(&i2c->adap);
 	if (!i2c->use_pio)
 		free_irq(i2c->irq, i2c);
diff --git a/drivers/i2c/busses/i2c-s6000.c b/drivers/i2c/busses/i2c-s6000.c
index 0088364..7c1ca5a 100644
--- a/drivers/i2c/busses/i2c-s6000.c
+++ b/drivers/i2c/busses/i2c-s6000.c
@@ -365,7 +365,6 @@ static int s6i2c_remove(struct platform_device *pdev)
 {
 	struct s6i2c_if *iface = platform_get_drvdata(pdev);
 	i2c_wr16(iface, S6_I2C_ENABLE, 0);
-	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&iface->adap);
 	free_irq(iface->irq, iface);
 	clk_disable(iface->clk);
diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 3a2253e..5351a2f 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -546,7 +546,6 @@ static int sh7760_i2c_remove(struct platform_device *pdev)
 	release_resource(id->ioarea);
 	kfree(id->ioarea);
 	kfree(id);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 60195b5..0a6f941 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -975,7 +975,6 @@ stu300_remove(struct platform_device *pdev)
 	i2c_del_adapter(&dev->adapter);
 	/* Turn off everything */
 	stu300_wr8(0x00, dev->virtbase + I2C_CR);
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
index 26c352a..6ffa56e0 100644
--- a/drivers/i2c/busses/i2c-taos-evm.c
+++ b/drivers/i2c/busses/i2c-taos-evm.c
@@ -271,7 +271,6 @@ static int taos_connect(struct serio *serio, struct serio_driver *drv)
  exit_close:
 	serio_close(serio);
  exit_kfree:
-	serio_set_drvdata(serio, NULL);
 	kfree(taos);
  exit:
 	return err;
@@ -285,7 +284,6 @@ static void taos_disconnect(struct serio *serio)
 		i2c_unregister_device(taos->client);
 	i2c_del_adapter(&taos->adapter);
 	serio_close(serio);
-	serio_set_drvdata(serio, NULL);
 	kfree(taos);
 
 	dev_info(&serio->dev, "Disconnected from TAOS EVM\n");
diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
index eec20db..f3a8790 100644
--- a/drivers/i2c/busses/i2c-versatile.c
+++ b/drivers/i2c/busses/i2c-versatile.c
@@ -125,8 +125,6 @@ static int i2c_versatile_remove(struct platform_device *dev)
 {
 	struct i2c_versatile *i2c = platform_get_drvdata(dev);
 
-	platform_set_drvdata(dev, NULL);
-
 	i2c_del_adapter(&i2c->adap);
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index f042f6d..332c720 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -784,8 +784,6 @@ static int xiic_i2c_remove(struct platform_device *pdev)
 
 	xiic_deinit(i2c);
 
-	platform_set_drvdata(pdev, NULL);
-
 	free_irq(platform_get_irq(pdev, 0), i2c);
 
 	iounmap(i2c->base);
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 93f029e..7945b05 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -256,7 +256,6 @@ static int xlr_i2c_remove(struct platform_device *pdev)
 
 	priv = platform_get_drvdata(pdev);
 	i2c_del_adapter(&priv->adap);
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 3862a95..2d1d2c5 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -542,7 +542,6 @@ static int scx200_remove(struct platform_device *pdev)
 	struct scx200_acb_iface *iface;
 
 	iface = platform_get_drvdata(pdev);
-	platform_set_drvdata(pdev, NULL);
 	scx200_cleanup_iface(iface);
 
 	return 0;
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 9f50ef0..abc2e55a 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -250,7 +250,6 @@ static int i2c_mux_gpio_remove(struct platform_device *pdev)
 	for (i = 0; i < mux->data.n_gpios; i++)
 		gpio_free(mux->gpio_base + mux->data.gpios[i]);
 
-	platform_set_drvdata(pdev, NULL);
 	i2c_put_adapter(mux->parent);
 
 	return 0;
-- 
1.8.1.3
