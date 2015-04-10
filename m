Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 875061A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:32:23 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 56ECA2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6WBRb40763478
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6Vj7Z022390
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:31:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 03/31] vfio: powerpc/spapr: Check that IOMMU page is
 fully contained by system page
Date: Fri, 10 Apr 2015 16:30:45 +1000
Message-Id: <1428647473-11738-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
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
index e9b4d7d..f835e63 100644
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
@@ -195,6 +205,12 @@ static long tce_iommu_build(struct tce_container *container,
 			ret = -EFAULT;
 			break;
 		}
+
+		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
+			ret = -EPERM;
+			break;
+		}
+
 		hva = (unsigned long) page_address(page) +
 			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
 
-- 
2.0.0
