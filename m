Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3791D2C06FD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 01:06:20 +1000 (EST)
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
Subject: [PATCH 35/51] DMA-API: parport: parport_pc.c: use
 dma_coerce_mask_and_coherent()
Message-Id: <E1VMmGZ-0007jU-99@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 19 Sep 2013 23:00:03 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code sequence:
	dev->coherent_dma_mask = DMA_BIT_MASK(24);
	dev->dma_mask = &dev->coherent_dma_mask;
bypasses the architectures check on the DMA mask.  It can be replaced
with dma_coerce_mask_and_coherent(), avoiding the direct initialization
of this mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/parport/parport_pc.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 903e128..9637615 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2004,6 +2004,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 	struct resource	*ECR_res = NULL;
 	struct resource	*EPP_res = NULL;
 	struct platform_device *pdev = NULL;
+	int ret;
 
 	if (!dev) {
 		/* We need a physical device to attach to, but none was
@@ -2014,8 +2015,11 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 			return NULL;
 		dev = &pdev->dev;
 
-		dev->coherent_dma_mask = DMA_BIT_MASK(24);
-		dev->dma_mask = &dev->coherent_dma_mask;
+		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(24));
+		if (ret) {
+			dev_err(dev, "Unable to set coherent dma mask: disabling DMA\n");
+			dma = PARPORT_DMA_NONE;
+		}
 	}
 
 	ops = kmalloc(sizeof(struct parport_operations), GFP_KERNEL);
-- 
1.7.4.4
