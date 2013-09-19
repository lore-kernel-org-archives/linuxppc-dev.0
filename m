Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B35D22C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 21:37:12 +1000 (EST)
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
Subject: [PATCH 13/51] DMA-API: net: sfc/efx.c: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
Message-Id: <E1VMlvE-0007gc-B5@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 19 Sep 2013 22:38:00 +0100
Cc: Ben Hutchings <bhutchings@solarflare.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace the following sequence:

	dma_set_mask(dev, mask);
	dma_set_coherent_mask(dev, mask);

with a call to the new helper dma_set_mask_and_coherent().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/sfc/efx.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 07c9bc4..2e27837 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -1121,7 +1121,7 @@ static int efx_init_io(struct efx_nic *efx)
 	 */
 	while (dma_mask > 0x7fffffffUL) {
 		if (dma_supported(&pci_dev->dev, dma_mask)) {
-			rc = dma_set_mask(&pci_dev->dev, dma_mask);
+			rc = dma_set_mask_and_coherent(&pci_dev->dev, dma_mask);
 			if (rc == 0)
 				break;
 		}
@@ -1134,16 +1134,6 @@ static int efx_init_io(struct efx_nic *efx)
 	}
 	netif_dbg(efx, probe, efx->net_dev,
 		  "using DMA mask %llx\n", (unsigned long long) dma_mask);
-	rc = dma_set_coherent_mask(&pci_dev->dev, dma_mask);
-	if (rc) {
-		/* dma_set_coherent_mask() is not *allowed* to
-		 * fail with a mask that dma_set_mask() accepted,
-		 * but just in case...
-		 */
-		netif_err(efx, probe, efx->net_dev,
-			  "failed to set consistent DMA mask\n");
-		goto fail2;
-	}
 
 	efx->membase_phys = pci_resource_start(efx->pci_dev, EFX_MEM_BAR);
 	rc = pci_request_region(pci_dev, EFX_MEM_BAR, "sfc");
-- 
1.7.4.4
