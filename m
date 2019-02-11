Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FFBC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 07:52:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED3120811
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 07:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED3120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ydKb0VWDzDqNX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 18:52:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43ydGV3mx8zDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 18:49:22 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 59F58AE80013;
 Mon, 11 Feb 2019 02:49:19 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] vfio/spapr_tce: Skip unsetting already unset table
Date: Mon, 11 Feb 2019 18:49:17 +1100
Message-Id: <20190211074917.125723-1-aik@ozlabs.ru>
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
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

VFIO TCE IOMMU v2 owns IOMMU tables so when detach a IOMMU group from
a container, we need to unset those from a group so we call unset_window()
so do we unconditionally. We also unset tables when removing a DMA window
via the VFIO_IOMMU_SPAPR_TCE_REMOVE ioctl.

The window removal checks if the table actually exists (hidden inside
tce_iommu_find_table()) but the group detaching does not so the user
may see duplicating messages:
pci 0009:03     : [PE# fd] Removing DMA window #0
pci 0009:03     : [PE# fd] Removing DMA window #1
pci 0009:03     : [PE# fd] Removing DMA window #0
pci 0009:03     : [PE# fd] Removing DMA window #1

At the moment this is not a problem as the second invocation
of unset_window() writes zeroes to the HW registers again and exits early
as there is no table.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

When doing VFIO PCI hot unplug, first we remove the DMA window and
set container->tables[num] - this is a first couple of messages.
Then we detach the group and then we see another couple of the same
messages which confused myself.
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index c424913..8dbb270 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1235,7 +1235,8 @@ static void tce_iommu_release_ownership_ddw(struct tce_container *container,
 	}
 
 	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
-		table_group->ops->unset_window(table_group, i);
+		if (container->tables[i])
+			table_group->ops->unset_window(table_group, i);
 
 	table_group->ops->release_ownership(table_group);
 }
-- 
2.17.1

