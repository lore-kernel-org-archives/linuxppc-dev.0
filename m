Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B10B21A020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:30 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 10 Mar 2015 00:08:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 58DFE2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:26 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29E8Hjb46858484
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:26 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29E7qD7021656
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:07:52 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 03/29] vfio: powerpc/spapr: Check that TCE page size is
 equal to it_page_size
Date: Tue, 10 Mar 2015 01:06:59 +1100
Message-Id: <1425910045-26167-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
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
v4:
* s/tce_check_page_size/tce_page_is_contained/
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 756831f..91e7599 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -49,6 +49,22 @@ struct tce_container {
 	bool enabled;
 };
 
+static bool tce_page_is_contained(struct page *page, unsigned page_shift)
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
@@ -197,6 +213,12 @@ static long tce_iommu_build(struct tce_container *container,
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
