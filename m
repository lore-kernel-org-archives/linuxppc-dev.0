Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A6CC282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 03:40:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C7221905
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 03:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C7221905
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zldm2cFkzDqP5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 14:39:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43zlc36phtzDqHr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 14:38:27 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 19F43AE8003F;
 Tue, 12 Feb 2019 22:38:21 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v2] powerpc/powernv/ioda: Fix locked_vm counting for
 memory used by IOMMU tables
Date: Wed, 13 Feb 2019 14:38:18 +1100
Message-Id: <20190213033818.51452-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We store 2 multilevel tables in iommu_table - one for the hardware and
one with the corresponding userspace addresses. Before allocating
the tables, the iommu_table_group_ops::get_table_size() hook returns
the combined size of the two and VFIO SPAPR TCE IOMMU driver adjusts
the locked_vm counter correctly. When the table is actually allocated,
the amount of allocated memory is stored in iommu_table::it_allocated_size
and used to decrement the locked_vm counter when we release the memory
used by the table; .get_table_size() and .create_table() calculate it
independently but the result is expected to be the same.

However the allocator does not add the userspace table size to
.it_allocated_size so when we destroy the table because of VFIO PCI
unplug (i.e. VFIO container is gone but the userspace keeps running),
we decrement locked_vm by just a half of size of memory we are releasing.

To make things worse, since we enabled on-demain allocation of
indirect levels, it_allocated_size contains only the amount of memory
actually allocated at the table creation time which can just be
a fraction. It is not a problem with incrementing locked_vm (as
get_table_size() value is used) but it is with decrementing.

As the result, we leak locked_vm and may not be able to allocate more
IOMMU tables after few iterations of hotplug/unplug.

This sets it_allocated_size in the pnv_pci_ioda2_ops::create_table()
hook to what pnv_pci_ioda2_get_table_size() returns so from now on
we have a single place which calculates the maximum memory a table can
occupy. The original meaning of it_allocated_size is somewhat lost now
though.

We do not ditch it_allocated_size whatsoever here and we do not call
get_table_size() from vfio_iommu_spapr_tce.c when decrementing locked_vm
as we may have multiple IOMMU groups per container and even though they
all are supposed to have the same get_table_size() implementation,
there is a small chance for failure or confusion.

Fixes: 090bad39b "powerpc/powernv: Add indirect levels to it_userspace"
Fixes: a68bd1267 "powerpc/powernv/ioda: Allocate indirect TCE levels on demand"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* this is reworked "[PATCH kernel] powerpc/powernv/ioda: Store correct amount of memory used for table"

---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 1 -
 arch/powerpc/platforms/powernv/pci-ioda.c     | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index 697449a..e28f03e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -313,7 +313,6 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 			page_shift);
 	tbl->it_level_size = 1ULL << (level_shift - 3);
 	tbl->it_indirect_levels = levels - 1;
-	tbl->it_allocated_size = total_allocated;
 	tbl->it_userspace = uas;
 	tbl->it_nid = nid;
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7db3119..d415739 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2592,8 +2592,13 @@ static long pnv_pci_ioda2_create_table_userspace(
 		int num, __u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table **ptbl)
 {
-	return pnv_pci_ioda2_create_table(table_group,
+	long ret = pnv_pci_ioda2_create_table(table_group,
 			num, page_shift, window_size, levels, true, ptbl);
+
+	if (!ret)
+		(*ptbl)->it_allocated_size = pnv_pci_ioda2_get_table_size(
+				page_shift, window_size, levels);
+	return ret;
 }
 
 static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
-- 
2.17.1

