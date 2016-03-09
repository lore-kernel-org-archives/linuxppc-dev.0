Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C0AC1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:18 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:30:17 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7F1322BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:09 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296TvOe2228728
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:09 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296TWFw009796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:29:33 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 01/10] vfio/spapr: Relax the IOMMU compatibility check
Date: Wed,  9 Mar 2016 17:28:57 +1100
Message-Id: <1457504946-40649-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are going to have multiple different types of PHB on the same system
with POWER8 + NVLink and PHBs will have different IOMMU ops. However
we only really care about one callback - create_table - so we can
relax the compatibility check here.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 0582b72..3054e3f 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1188,7 +1188,8 @@ static int tce_iommu_attach_group(void *iommu_data,
 			goto unlock_exit;
 		}
 		table_group_tmp = iommu_group_get_iommudata(tcegrp->grp);
-		if (table_group_tmp->ops != table_group->ops) {
+		if (table_group_tmp->ops->create_table !=
+				table_group->ops->create_table) {
 			pr_warn("tce_vfio: Group %d is incompatible with group %d\n",
 					iommu_group_id(iommu_group),
 					iommu_group_id(tcegrp->grp));
-- 
2.5.0.rc3
