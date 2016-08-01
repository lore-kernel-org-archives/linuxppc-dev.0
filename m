Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3FKl15H7zDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 09:05:14 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71N49sM145426
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 19:05:12 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gn5xqrt6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 19:05:12 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 20:05:10 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id A96E43520072
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 19:04:47 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u71N572l23265536
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:05:07 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u71N56rh023867
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:05:07 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: implement the DMA_ATTR_NO_WARN attribute
Date: Mon,  1 Aug 2016 20:05:05 -0300
In-Reply-To: <1470092706-28075-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1470092706-28075-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1470092706-28075-3-git-send-email-mauricfo@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 37d6e74..5f202a5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -479,7 +479,8 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 		/* Handle failure */
 		if (unlikely(entry == DMA_ERROR_CODE)) {
-			if (printk_ratelimit())
+			if (!(attrs & DMA_ATTR_NO_WARN) &&
+			    printk_ratelimit())
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %lx npages %lu\n", tbl, vaddr,
 					 npages);
@@ -776,7 +777,8 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 					 mask >> tbl->it_page_shift, align,
 					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
-			if (printk_ratelimit())  {
+			if (!(attrs & DMA_ATTR_NO_WARN) &&
+			    printk_ratelimit())  {
 				dev_info(dev, "iommu_alloc failed, tbl %p "
 					 "vaddr %p npages %d\n", tbl, vaddr,
 					 npages);
-- 
1.8.3.1
