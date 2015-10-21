Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AE3E1A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 18:18:03 +1100 (AEDT)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 712AA1409F8
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 18:18:02 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 12:48:00 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9C1B3E0054
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 12:48:02 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9L7Hrs15243276
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 12:47:53 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9L7Hq8N009285
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 12:47:53 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: retrieve m64_bar_idx from device node
Date: Wed, 21 Oct 2015 15:17:34 +0800
Message-Id: <1445411854-6951-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Count of M64 BAR would differ with the evolution of hardware.

This patch retieves this count from device node instead of a hard coded
value.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5c65d8f..4635d25 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -368,6 +368,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	struct resource *res;
 	const u32 *r;
 	u64 pci_addr;
+	const __be32 *prop32;
 
 	/* FIXME: Support M64 for P7IOC */
 	if (phb->type != PNV_PHB_IODA2) {
@@ -402,7 +403,11 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 			res->start, res->end, pci_addr);
 
 	/* Use last M64 BAR to cover M64 window */
-	phb->ioda.m64_bar_idx = 15;
+	prop32 = of_get_property(dn, "ibm,opal-m64-count", NULL);
+	if (prop32)
+		phb->ioda.m64_bar_idx = be32_to_cpup(prop32) - 1;
+	else
+		phb->ioda.m64_bar_idx = 15;
 	phb->init_m64 = pnv_ioda2_init_m64;
 	phb->reserve_m64_pe = pnv_ioda2_reserve_m64_pe;
 	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
-- 
2.5.0
