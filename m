Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sStbb3WfgzDsG1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 14:17:15 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sStbb03KYz9s5g
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2016 14:17:14 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u864DGHW078550
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Sep 2016 00:17:13 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259n682xcj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 06 Sep 2016 00:17:13 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 6 Sep 2016 14:17:10 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E3A7D3578053
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2016 14:17:07 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u864H7JR6160734
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Sep 2016 14:17:07 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u864H7nM012575
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Sep 2016 14:17:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Fix corrupted PE allocation bitmap on
 releasing PE
Date: Tue,  6 Sep 2016 14:17:18 +1000
Message-Id: <1473135438-32761-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In pnv_ioda_free_pe(), the PE object (including the associated PE
number) is cleared before resetting the corresponding bit in the
PE allocation bitmap. It means PE#0 is always released to the bitmap
wrongly.

This fixes above issue by caching the PE number before the PE object
is cleared.

Fixes: 1e9167726c41 ("powerpc/powernv: Use PE instead of number during setup and release"
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 18f6fd1..c16d790 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -162,11 +162,12 @@ static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
 {
 	struct pnv_phb *phb = pe->phb;
+	unsigned int pe_num = pe->pe_number;
 
 	WARN_ON(pe->pdev);
 
 	memset(pe, 0, sizeof(struct pnv_ioda_pe));
-	clear_bit(pe->pe_number, phb->ioda.pe_alloc);
+	clear_bit(pe_num, phb->ioda.pe_alloc);
 }
 
 /* The default M64 BAR is shared by all PEs */
-- 
2.1.0
