Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B1CE2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 23:02:24 +1000 (EST)
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: alsa-devel@alsa-project.org, b43-dev@lists.infradead.org,
 devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, e1000-devel@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 uclinux-dist-devel@blackfin.uclinux.org
Subject: [PATCH 38/51] DMA-API: staging: use dma_set_coherent_mask()
Message-Id: <E1VMmJT-0007kZ-Kw@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 19 Sep 2013 23:03:03 +0100
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Zimmerman <paulz@synopsys.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The correct way for a driver to specify the coherent DMA mask is
not to directly access the field in the struct device, but to use
dma_set_coherent_mask().  Only arch and bus code should access this
member directly.

Convert all direct write accesses to using the correct API.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/dwc2/platform.c        |    5 +++--
 drivers/staging/imx-drm/imx-drm-core.c |    8 ++++++--
 drivers/staging/imx-drm/ipuv3-crtc.c   |    4 +++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/dwc2/platform.c b/drivers/staging/dwc2/platform.c
index 44cce2f..1d68c49 100644
--- a/drivers/staging/dwc2/platform.c
+++ b/drivers/staging/dwc2/platform.c
@@ -100,8 +100,9 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	 */
 	if (!dev->dev.dma_mask)
 		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
-	if (!dev->dev.coherent_dma_mask)
-		dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	retval = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
+	if (retval)
+		return retval;
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 47c5888..847f430 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -805,6 +805,12 @@ static struct drm_driver imx_drm_driver = {
 
 static int imx_drm_platform_probe(struct platform_device *pdev)
 {
+	int ret;
+
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
 	imx_drm_device->dev = &pdev->dev;
 
 	return drm_platform_init(&imx_drm_driver, pdev);
@@ -847,8 +853,6 @@ static int __init imx_drm_init(void)
 		goto err_pdev;
 	}
 
-	imx_drm_pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32),
-
 	ret = platform_driver_register(&imx_drm_pdrv);
 	if (ret)
 		goto err_pdrv;
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 6fd37a7..9e73e8d 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -523,7 +523,9 @@ static int ipu_drm_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -EINVAL;
 
-	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
 
 	ipu_crtc = devm_kzalloc(&pdev->dev, sizeof(*ipu_crtc), GFP_KERNEL);
 	if (!ipu_crtc)
-- 
1.7.4.4
