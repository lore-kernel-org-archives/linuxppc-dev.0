Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A03281A1E90
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:36:33 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DA90C14018B
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:32 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 08:06:31 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B7FEB125804B
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:30 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC2cd7T3735838
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:08:39 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC2aRep005954
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:27 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/8] powerpc/powernv: Simplify pnv_ioda_configure_pe()
Date: Wed, 12 Nov 2014 13:36:09 +1100
Message-Id: <1415759771-11359-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nested if statements are always bad and the patch avoids one by
checking PHB type and bail in advance if necessary.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 32 ++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b96ba48..762ca14 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -684,26 +684,28 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		phb->ioda.pe_rmap[rid] = pe->pe_number;
 
 	/* Setup one MVTs on IODA1 */
-	if (phb->type == PNV_PHB_IODA1) {
-		pe->mve_number = pe->pe_number;
-		rc = opal_pci_set_mve(phb->opal_id, pe->mve_number,
-				      pe->pe_number);
+	if (phb->type != PNV_PHB_IODA1) {
+		pe->mve_number = 0;
+		goto out;
+	}
+
+	pe->mve_number = pe->pe_number;
+	rc = opal_pci_set_mve(phb->opal_id, pe->mve_number, pe->pe_number);
+	if (rc != OPAL_SUCCESS) {
+		pe_err(pe, "OPAL error %ld setting up MVE %d\n",
+		       rc, pe->mve_number);
+		pe->mve_number = -1;
+	} else {
+		rc = opal_pci_set_mve_enable(phb->opal_id,
+					     pe->mve_number, OPAL_ENABLE_MVE);
 		if (rc) {
-			pe_err(pe, "OPAL error %ld setting up MVE %d\n",
+			pe_err(pe, "OPAL error %ld enabling MVE %d\n",
 			       rc, pe->mve_number);
 			pe->mve_number = -1;
-		} else {
-			rc = opal_pci_set_mve_enable(phb->opal_id,
-						     pe->mve_number, OPAL_ENABLE_MVE);
-			if (rc) {
-				pe_err(pe, "OPAL error %ld enabling MVE %d\n",
-				       rc, pe->mve_number);
-				pe->mve_number = -1;
-			}
 		}
-	} else if (phb->type == PNV_PHB_IODA2)
-		pe->mve_number = 0;
+	}
 
+out:
 	return 0;
 }
 
-- 
1.8.3.2
