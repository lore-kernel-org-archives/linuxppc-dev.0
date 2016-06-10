Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rR2S01hpZzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 23:03:59 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5AD3TbA037698
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 09:03:57 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23fcmenvam-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 09:03:56 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 10 Jun 2016 10:03:54 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id D7975352006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 09:03:35 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5AD3pHQ15532434
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 10:03:51 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5AD3pj4031761
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 10:03:51 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: convert 'iommu_alloc failed' messages to dynamic
 debug
Date: Fri, 10 Jun 2016 10:03:51 -0300
Message-Id: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This prevents flooding the logs with 'iommu_alloc failed' messages
while I/O is performed (normally) to very fast devices (e.g. NVMe).

That error is not necessarily a problem; device drivers can retry
later / reschedule the requests for which the allocation failed,
and handle things gracefully for the caller stack on top of them.

This helps at least with NVMe devices without "64-bit"/direct DMA
window scenarios (e.g., systems with more than a few terabytes of
memory, on which DDW cannot be enabled, currently), where just an
'dd' command can trigger errors.

  # dd if=/dev/zero of=/dev/nvme0n1p1 bs=64k count=512k
  <...>
  # echo $?
  0

  # dmesg
  nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr c000000151c90000 npages 16
  nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr c000000151c90000 npages 16
  nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr c000000151c90000 npages 16
  <...>
  ppc_iommu_map_sg: 8186 callbacks suppressed
  nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr c0000000fa5c0000 npages 16
  nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr c000000100440000 npages 16
  nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr c000000100440000 npages 16
  <...>
  ppc_iommu_map_sg: 5707 callbacks suppressed
  nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr c0000000b5f50000 npages 16
  nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr c0000000b5c60000 npages 16
  nvme 0000:00:06.0: iommu_alloc failed, tbl c0000001fa67c520 vaddr c0000000b4b30000 npages 16
  <...>

Tested on next-20160609.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iommu.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index a8e3490..b585bdc 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -479,10 +479,9 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 		/* Handle failure */
 		if (unlikely(entry == DMA_ERROR_CODE)) {
-			if (printk_ratelimit())
-				dev_info(dev, "iommu_alloc failed, tbl %p "
-					 "vaddr %lx npages %lu\n", tbl, vaddr,
-					 npages);
+			dev_dbg_ratelimited(dev, "iommu_alloc failed, tbl %p "
+				 "vaddr %lx npages %lu\n", tbl, vaddr,
+				 npages);
 			goto failure;
 		}
 
@@ -776,11 +775,9 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 					 mask >> tbl->it_page_shift, align,
 					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
-			if (printk_ratelimit())  {
-				dev_info(dev, "iommu_alloc failed, tbl %p "
-					 "vaddr %p npages %d\n", tbl, vaddr,
-					 npages);
-			}
+			dev_dbg_ratelimited(dev, "iommu_alloc failed, tbl %p "
+				 "vaddr %p npages %d\n", tbl, vaddr,
+				 npages);
 		} else
 			dma_handle |= (uaddr & ~IOMMU_PAGE_MASK(tbl));
 	}
-- 
1.8.3.1
