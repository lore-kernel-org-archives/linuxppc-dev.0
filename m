Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73B711A0892
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:44 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:41 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7209A2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:09 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N2hGcp11468878
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 12:43:17 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N3675m004532
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:08 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 01/18] powerpc/iommu: Fix comments with it_page_shift
Date: Wed, 23 Jul 2014 13:05:47 +1000
Message-Id: <1406084764-24685-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a couple of commented debug prints which still use
IOMMU_PAGE_SHIFT() which is not defined for POWERPC anymore, replace
them with it_page_shift.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 88e3ec6..f84f799 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1037,7 +1037,7 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
-			__func__, hwaddr, entry << IOMMU_PAGE_SHIFT(tbl),
+			__func__, hwaddr, entry << tbl->it_page_shift,
 				hwaddr, ret); */
 
 	return ret;
@@ -1056,7 +1056,7 @@ int iommu_put_tce_user_mode(struct iommu_table *tbl, unsigned long entry,
 			direction != DMA_TO_DEVICE, &page);
 	if (unlikely(ret != 1)) {
 		/* pr_err("iommu_tce: get_user_pages_fast failed tce=%lx ioba=%lx ret=%d\n",
-				tce, entry << IOMMU_PAGE_SHIFT(tbl), ret); */
+				tce, entry << tbl->it_page_shift, ret); */
 		return -EFAULT;
 	}
 	hwaddr = (unsigned long) page_address(page) + offset;
-- 
2.0.0
