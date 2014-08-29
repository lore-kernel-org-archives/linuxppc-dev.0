Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE80C1A0189
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 17:59:25 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 Aug 2014 17:59:25 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/13] powerpc/iommu: Check that TCE page size is equal to
 it_page_size
Date: Fri, 29 Aug 2014 17:59:04 +1000
Message-Id: <1409299156-618-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1409299156-618-1-git-send-email-aik@ozlabs.ru>
References: <1409299156-618-1-git-send-email-aik@ozlabs.ru>
Cc: cbe-oss-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-api@vger.kernel.org
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index a10642a..b378f78 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -38,6 +38,7 @@
 #include <linux/pci.h>
 #include <linux/iommu.h>
 #include <linux/sched.h>
+#include <linux/hugetlb.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
@@ -1059,16 +1060,37 @@ int iommu_put_tce_user_mode(struct iommu_table *tbl, unsigned long entry,
 				tce, entry << tbl->it_page_shift, ret); */
 		return -EFAULT;
 	}
+
+	/*
+	 * Check that the TCE table granularity is not bigger than the size of
+	 * a page we just found. Otherwise the hardware can get access to
+	 * a bigger memory chunk that it should.
+	 */
+	if (PageHuge(page)) {
+		struct page *head = compound_head(page);
+		long shift = PAGE_SHIFT + compound_order(head);
+
+		if (shift < tbl->it_page_shift) {
+			ret = -EINVAL;
+			goto put_page_exit;
+		}
+
+	}
+
 	hwaddr = (unsigned long) page_address(page) + offset;
 
 	ret = iommu_tce_build(tbl, entry, hwaddr, direction);
 	if (ret)
-		put_page(page);
+		goto put_page_exit;
 
-	if (ret < 0)
-		pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%d\n",
+	return 0;
+
+put_page_exit:
+	pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%d\n",
 			__func__, entry << tbl->it_page_shift, tce, ret);
 
+	put_page(page);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_put_tce_user_mode);
-- 
2.0.0
