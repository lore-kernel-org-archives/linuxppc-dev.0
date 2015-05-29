Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EF281A08D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:25 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1B17E2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:22 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8kCj57340122
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:20 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jnRS027362
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 07/34] vfio: powerpc/spapr: Check that IOMMU page
 is fully contained by system page
Date: Fri, 29 May 2015 18:44:31 +1000
Message-Id: <1432889098-22924-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This checks that the TCE table page size is not bigger that the size of
a page we just pinned and going to put its physical address to the table.

Otherwise the hardware gets unwanted access to physical memory between
the end of the actual page and the end of the aligned up TCE page.

Since compound_order() and compound_head() work correctly on non-huge
pages, there is no need for additional check whether the page is huge.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
Changes:
v8: changed subject

v6:
* the helper is simplified to one line

v4:
* s/tce_check_page_size/tce_page_is_contained/
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index b95fa2b..735b308 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -47,6 +47,16 @@ struct tce_container {
 	bool enabled;
 };
 
+static bool tce_page_is_contained(struct page *page, unsigned page_shift)
+{
+	/*
+	 * Check that the TCE table granularity is not bigger than the size of
+	 * a page we just found. Otherwise the hardware can get access to
+	 * a bigger memory chunk that it should.
+	 */
+	return (PAGE_SHIFT + compound_order(compound_head(page))) >= page_shift;
+}
+
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
@@ -189,6 +199,12 @@ static long tce_iommu_build(struct tce_container *container,
 			ret = -EFAULT;
 			break;
 		}
+
+		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
+			ret = -EPERM;
+			break;
+		}
+
 		hva = (unsigned long) page_address(page) + offset;
 
 		ret = iommu_tce_build(tbl, entry + i, hva, direction);
-- 
2.4.0.rc3.8.gfb3e7d5
