Return-Path: <nipun.gupta@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30060.outbound.protection.outlook.com [40.107.3.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4288ZV19BDzF3B3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 23:50:41 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
 robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org,
 laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc: m.szyprowski@samsung.com, shawnguo@kernel.org, frowand.list@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
 Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 6/7 v7] bus/fsl-mc: set coherent dma mask for devices on
 fsl-mc bus
Date: Mon, 10 Sep 2018 19:19:20 +0530
Message-Id: <1536587361-11047-7-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
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

of_dma_configure() API expects coherent_dma_mask to be correctly
set in the devices. This patch does the needful.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index fa43c7d..624828b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -627,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		mc_dev->icid = parent_mc_dev->icid;
 		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 		dev_set_msi_domain(&mc_dev->dev,
 				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
-- 
1.9.1
