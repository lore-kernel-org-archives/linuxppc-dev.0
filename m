Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D065A1A06DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:31:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 11 Jun 2015 14:31:01 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 267533578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:30:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B4TXD854853684
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:29:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B4T9Vh026582
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:29:09 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel v12.2] powerpc/powernv: Fix crash when CONFIG_IOMMU_API
 is off
Date: Thu, 11 Jun 2015 14:28:41 +1000
Message-Id: <1433996921-23021-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <20150610073307.948391402AE@ozlabs.org>
References: <20150610073307.948391402AE@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code introduced in
"[PATCH kernel v12 17/34]
powerpc/spapr: vfio: Switch from iommu_table to new iommu_table_group"
checks if an IOMMU group was registered for the specific
table group which is not true when CONFIG_IOMMU_API is off as
iommu_register_group() is a stub in this case.

This replaces BUG_ON with WARN_ON and removes the check as it is a wrong
place for it anyway.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4b4c583..429498e 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -622,9 +622,8 @@ long pnv_pci_link_table_and_group(int node, int num,
 {
 	struct iommu_table_group_link *tgl = NULL;
 
-	BUG_ON(!tbl);
-	BUG_ON(!table_group);
-	BUG_ON(!table_group->group);
+	if (WARN_ON(!tbl || !table_group))
+		return -EINVAL;
 
 	tgl = kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
 			node);
-- 
2.4.0.rc3.8.gfb3e7d5
