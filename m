Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYFRN0WjfzDsQd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 16:40:15 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8D6bmNc113941
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:40:13 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25dwtxbwv7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:40:12 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 13 Sep 2016 16:40:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 12E432BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 16:40:07 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8D6e6gP2359732
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 16:40:06 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8D6e6ee019782
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 16:40:06 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, fbarrat@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Fix the state of root PE
Date: Tue, 13 Sep 2016 16:40:24 +1000
Message-Id: <1473748824-21550-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PE for root bus (root PE) can be removed because of PCI hot
remove in EEH recovery path for fenced PHB error. We need update
@phb->root_pe_populated accordingly so that the root PE can be
populated again in forthcoming PCI hot add path. Also, the PE
shouldn't be destroyed as it's global and reserved resource.

Fixes: c5f7700bbd2e ("powerpc/powernv: Dynamically release PE")
Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index e98f4a8..c38a6a1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3426,7 +3426,16 @@ static void pnv_ioda_release_pe(struct pnv_ioda_pe *pe)
 		}
 	}
 
-	pnv_ioda_free_pe(pe);
+	/* The PE for root bus can be removed because of hotplug in EEH
+	 * recovery for fenced PHB error. We need mark the PE dead so
+	 * that it can be populated again in PCI hot add path. The PE
+	 * shouldn't be destroyed as it's the global reserved resource.
+	 */
+	if (phb->ioda.root_pe_populated &&
+	    phb->ioda.root_pe_idx == pe->pe_number)
+		phb->ioda.root_pe_populated = false;
+	else
+		pnv_ioda_free_pe(pe);
 }
 
 static void pnv_pci_release_device(struct pci_dev *pdev)
-- 
2.1.0
