Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 161852C02FF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 22:48:10 +1000 (EST)
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
Subject: [PATCH 33/51] DMA-API: net: nxp/lpc_eth: use
 dma_coerce_mask_and_coherent()
Message-Id: <E1VMmEd-0007jF-19@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 19 Sep 2013 22:58:03 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code sequence:
	pldat->pdev->dev.coherent_dma_mask = 0xFFFFFFFF;
	pldat->pdev->dev.dma_mask = &pldat->pdev->dev.coherent_dma_mask;
bypasses the architectures check on the DMA mask.  It can be replaced
with dma_coerce_mask_and_coherent(), avoiding the direct initialization
of this mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/nxp/lpc_eth.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index a061b93..ba3ca18 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1399,8 +1399,10 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 	}
 
 	if (pldat->dma_buff_base_v == 0) {
-		pldat->pdev->dev.coherent_dma_mask = 0xFFFFFFFF;
-		pldat->pdev->dev.dma_mask = &pldat->pdev->dev.coherent_dma_mask;
+		ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret)
+			goto err_out_free_irq;
+
 		pldat->dma_buff_size = PAGE_ALIGN(pldat->dma_buff_size);
 
 		/* Allocate a chunk of memory for the DMA ethernet buffers
-- 
1.7.4.4
