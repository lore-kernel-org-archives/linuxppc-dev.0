Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B12872C0302
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 18:01:35 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q6D81T8U002034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 03:01:31 -0500
Message-ID: <1342166487.15597.15.camel@pasglop>
Subject: [PATCH] powerpc/iommu: Fix iommu pool initialization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 13 Jul 2012 18:01:27 +1000
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

The iommu pool patch has a bug where it would cause a crash when using
only one pool (based on the size of the DMA window).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index fbefe72..ff5a6ce 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -676,9 +676,9 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 		tbl->nr_pools = 1;
 
 	/* We reserve the top 1/4 of the table for large allocations */
-	tbl->poolsize = (tbl->it_size * 3 / 4) / IOMMU_NR_POOLS;
+	tbl->poolsize = (tbl->it_size * 3 / 4) / tbl->nr_pools;
 
-	for (i = 0; i < IOMMU_NR_POOLS; i++) {
+	for (i = 0; i < tbl->nr_pools; i++) {
 		p = &tbl->pools[i];
 		spin_lock_init(&(p->lock));
 		p->start = tbl->poolsize * i;
