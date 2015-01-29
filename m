Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17B7D1A0C26
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:23 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 29 Jan 2015 19:22:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E77FD3578055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:10 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0T9MA8945088836
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:10 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0T9M89D022643
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:22:09 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 02/24] vfio: powerpc/iommu: Check that TCE page size is
 equal to it_page_size
Date: Thu, 29 Jan 2015 20:21:43 +1100
Message-Id: <1422523325-1389-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexander Gordeev <agordeev@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
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
v5:
* check is done for all page sizes now, not just for huge pages
* failed check returns EFAULT now (was EINVAL)
* moved the check to VFIO SPAPR IOMMU driver
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index dc4a886..99b98fa 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -47,6 +47,22 @@ struct tce_container {
 	bool enabled;
 };
 
+static bool tce_check_page_size(struct page *page, unsigned page_shift)
+{
+	unsigned shift;
+
+	/*
+	 * Check that the TCE table granularity is not bigger than the size of
+	 * a page we just found. Otherwise the hardware can get access to
+	 * a bigger memory chunk that it should.
+	 */
+	shift = PAGE_SHIFT + compound_order(compound_head(page));
+	if (shift >= page_shift)
+		return true;
+
+	return false;
+}
+
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
@@ -199,6 +215,12 @@ static long tce_iommu_build(struct tce_container *container,
 			ret = -EFAULT;
 			break;
 		}
+
+		if (!tce_check_page_size(page, tbl->it_page_shift)) {
+			ret = -EFAULT;
+			break;
+		}
+
 		hva = (unsigned long) page_address(page) +
 			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
 
-- 
2.0.0
