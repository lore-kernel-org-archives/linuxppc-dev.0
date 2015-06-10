Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1A851A08A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 13:11:12 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 10 Jun 2015 13:11:10 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DE8DE357804C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 13:11:08 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A39ibx60227732
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 13:09:53 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A39KBq022893
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 13:09:20 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel] powerpc/powernv: Fix crash when CONFIG_IOMMU_API is off
Date: Wed, 10 Jun 2015 13:08:54 +1000
Message-Id: <1433905734-988-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1433852588.18194.1.camel@ellerman.id.au>
References: <1433852588.18194.1.camel@ellerman.id.au>
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
checks that an IOMMU group was registered for the specific
table group which is not true when CONFIG_IOMMU_API is off as
iommu_register_group() is a stub in this case.

This makes BUG_ON conditional.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4b4c583..a57554a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -624,8 +624,9 @@ long pnv_pci_link_table_and_group(int node, int num,
 
 	BUG_ON(!tbl);
 	BUG_ON(!table_group);
+#ifdef CONFIG_IOMMU_API
 	BUG_ON(!table_group->group);
-
+#endif
 	tgl = kzalloc_node(sizeof(struct iommu_table_group_link), GFP_KERNEL,
 			node);
 	if (!tgl)
-- 
2.4.0.rc3.8.gfb3e7d5
