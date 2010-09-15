Return-Path: <nacc@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 877CAB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:06:35 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FI6WEo003239
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:06:32 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FI6VWj122486
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:06:31 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8FI6V4f010425
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 15:06:31 -0300
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 02/15] ppc64: fix dma_iommu_dma_supported compare
Date: Wed, 15 Sep 2010 11:05:45 -0700
Message-Id: <1284573958-8397-3-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The table offset is in entries, each of which imply a dma address of
an IOMMU page.

Also, we should check the device can reach the whole IOMMU table.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/kernel/dma-iommu.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 37771a5..6e54a0f 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -74,16 +74,17 @@ static int dma_iommu_dma_supported(struct device *dev, u64 mask)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 
-	if (!tbl || tbl->it_offset > mask) {
-		printk(KERN_INFO
-		       "Warning: IOMMU offset too big for device mask\n");
-		if (tbl)
-			printk(KERN_INFO
-			       "mask: 0x%08llx, table offset: 0x%08lx\n",
-				mask, tbl->it_offset);
-		else
-			printk(KERN_INFO "mask: 0x%08llx, table unavailable\n",
-				mask);
+	if (!tbl) {
+		dev_info(dev, "Warning: IOMMU dma not supported: mask 0x%08llx"
+			", table unavailable\n", mask);
+		return 0;
+	}
+
+	if ((tbl->it_offset + tbl->it_size) > (mask >> IOMMU_PAGE_SHIFT)) {
+		dev_info(dev, "Warning: IOMMU window too big for device mask\n");
+		dev_info(dev, "mask: 0x%08llx, table end: 0x%08lx\n",
+				mask, (tbl->it_offset + tbl->it_size) <<
+				IOMMU_PAGE_SHIFT);
 		return 0;
 	} else
 		return 1;
-- 
1.7.0.4
