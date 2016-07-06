Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlCsz6BBQzDr3V
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 07:04:07 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66Krq9U088337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 17:04:06 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xkr815-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 17:04:05 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 18:04:03 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 4D51B1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 17:03:53 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66L40Ys27459870
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:04:00 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66L3xDD017853
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:04:00 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/3] powerpc: implement DMA_ATTR_NO_WARN
Date: Wed,  6 Jul 2016 18:03:33 -0300
In-Reply-To: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1467839013-22481-4-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the DMA_ATTR_NO_WARN attribute on powerpc iommu code.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index a8e3490..69bb17f 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -479,7 +479,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 		/* Handle failure */
 		if (unlikely(entry == DMA_ERROR_CODE)) {
-			if (printk_ratelimit())
+			if (unlikely(!dma_get_attr(DMA_ATTR_NO_WARN, attrs)) && printk_ratelimit())
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %lx npages %lu\n", tbl, vaddr,
 					 npages);
@@ -776,7 +776,7 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 					 mask >> tbl->it_page_shift, align,
 					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
-			if (printk_ratelimit())  {
+			if (unlikely(!dma_get_attr(DMA_ATTR_NO_WARN, attrs)) && printk_ratelimit())  {
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %p npages %d\n", tbl, vaddr,
 					 npages);
-- 
1.8.3.1
