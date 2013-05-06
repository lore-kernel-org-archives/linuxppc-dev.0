Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8CDEB2C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 16:43:42 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r466hYlM017137
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 01:43:35 -0500
Message-ID: <1367822614.15842.14.camel@pasglop>
Subject: [PATCH] powerpc/cell/iommu: Improve error message for missing node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 06 May 2013 16:43:34 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some devices don't have a correct node ID and thus can't be
attached to an iommu.

The message displayed by the iommu code isn't very useful if
you don't have a device-tree node as it tries to print the
device-tree path but not the struct device name.

Improve this by printing the device name as well.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/cell/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index e56bb65..946306b 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -550,7 +550,7 @@ static struct iommu_table *cell_get_iommu_table(struct device *dev)
 	 */
 	iommu = cell_iommu_for_node(dev_to_node(dev));
 	if (iommu == NULL || list_empty(&iommu->windows)) {
-		printk(KERN_ERR "iommu: missing iommu for %s (node %d)\n",
+		dev_err(dev, "iommu: missing iommu for %s (node %d)\n",
 		       of_node_full_name(dev->of_node), dev_to_node(dev));
 		return NULL;
 	}
