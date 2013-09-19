Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1EF9E2C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 21:47:52 +1000 (EST)
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
Subject: [PATCH 12/51] DMA-API: net: intel/e1000: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
Message-Id: <E1VMluG-0007gV-6y@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 19 Sep 2013 22:37:00 +0100
Cc: Alex Duyck <alexander.h.duyck@intel.com>,
 Don Skidmore <donald.c.skidmore@intel.com>,
 Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>,
 Bruce Allan <bruce.w.allan@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Greg Rose <gregory.v.rose@intel.com>, John Ronciak <john.ronciak@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Carolyn Wyborny <carolyn.wyborny@intel.com>,
 Tushar Dave <tushar.n.dave@intel.com>
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
 drivers/net/ethernet/intel/e1000/e1000_main.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 59ad007..34672f8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1018,19 +1018,14 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	pci_using_dac = 0;
 	if ((hw->bus_type == e1000_bus_type_pcix) &&
-	    !dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
-		/* according to DMA-API-HOWTO, coherent calls will always
-		 * succeed if the set call did
-		 */
-		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	    !dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
 		pci_using_dac = 1;
 	} else {
-		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
 			pr_err("No usable DMA config, aborting\n");
 			goto err_dma;
 		}
-		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	}
 
 	netdev->netdev_ops = &e1000_netdev_ops;
-- 
1.7.4.4
