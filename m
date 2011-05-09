Return-Path: <nacc@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ADA9DB6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 May 2011 08:58:17 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p49MknkT000951
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 May 2011 16:46:49 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p49Mw6PD163300
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 May 2011 16:58:06 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p49Mw6aL004610
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 May 2011 16:58:06 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] pseries/iommu: restore iommu table pointer when restoring
	iommu ops
Date: Mon,  9 May 2011 15:58:03 -0700
Message-Id: <1304981883-18796-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we swtich to direct dma ops, we set the dma data union to have the
dma offset.  When we switch back to iommu table ops because of a later
dma_set_mask, we need to restore the iommu table pointer. Without this
change, crashes have been observed on kexec where (for reasons still
being investigated) we fall back to a 32-bit dma mask on a particular
device and then panic because the table pointer is not valid.

The easiset way to find this value is to call
pci_dma_dev_setup_pSeriesLP which will search up the pci tree until it
finds the node with the table.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org

---
 arch/powerpc/platforms/pseries/iommu.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index f66c6b6..a3ee4e7 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1036,10 +1036,10 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 
+	pdev = to_pci_dev(dev);
+
 	/* only attempt to use a new window if 64-bit DMA is requested */
 	if (!disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
-		pdev = to_pci_dev(dev);
-
 		dn = pci_device_to_OF_node(pdev);
 		dev_dbg(dev, "node is %s\n", dn->full_name);
 
@@ -1070,6 +1070,7 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 	if (!ddw_enabled) {
 		dev_info(dev, "Using 32-bit DMA via iommu\n");
 		set_dma_ops(dev, &dma_iommu_ops);
+		pci_dma_dev_setup_pSeriesLP(pdev);
 	}
 
 	*dev->dma_mask = dma_mask;
-- 
1.7.4.1
