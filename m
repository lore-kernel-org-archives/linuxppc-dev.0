Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAAF11A01D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:00:24 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 84D07140D8C
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:00:24 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 14:00:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 272F33578053
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:00:22 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9840EdJ000438
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 15:00:22 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t983xn8l007048
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 14:59:49 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 8/8] powerpc/powernv: Simplify pnv_eeh_set_option()
Date: Thu,  8 Oct 2015 14:58:59 +1100
Message-Id: <1444276739-20372-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This simplifies pnv_eeh_set_option() to avoid unnecessary nested
if statements, to improve readability. No functional changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 51 ++++++++++++++--------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 2b5c70b..d62007f 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -471,7 +471,7 @@ static int pnv_eeh_set_option(struct eeh_pe *pe, int option)
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
 	bool freeze_pe = false;
-	int opt, ret = 0;
+	int opt;
 	s64 rc;
 
 	switch (option) {
@@ -494,38 +494,37 @@ static int pnv_eeh_set_option(struct eeh_pe *pe, int option)
 		return -EINVAL;
 	}
 
-	/* If PHB supports compound PE, to handle it */
+	/* Freeze master and slave PEs if PHB supports compound PEs */
 	if (freeze_pe) {
 		if (phb->freeze_pe) {
 			phb->freeze_pe(phb, pe->addr);
-		} else {
-			rc = opal_pci_eeh_freeze_set(phb->opal_id,
-						     pe->addr, opt);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Failure %lld freezing "
-					"PHB#%x-PE#%x\n",
-					__func__, rc,
-					phb->hose->global_number, pe->addr);
-				ret = -EIO;
-			}
+			return 0;
 		}
-	} else {
-		if (phb->unfreeze_pe) {
-			ret = phb->unfreeze_pe(phb, pe->addr, opt);
-		} else {
-			rc = opal_pci_eeh_freeze_clear(phb->opal_id,
-						       pe->addr, opt);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Failure %lld enable %d "
-					"for PHB#%x-PE#%x\n",
-					__func__, rc, option,
-					phb->hose->global_number, pe->addr);
-				ret = -EIO;
-			}
+
+		rc = opal_pci_eeh_freeze_set(phb->opal_id, pe->addr, opt);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Failure %lld freezing PHB#%x-PE#%x\n",
+				__func__, rc, phb->hose->global_number,
+				pe->addr);
+			return -EIO;
 		}
+
+		return 0;
 	}
 
-	return ret;
+	/* Unfreeze master and slave PEs if PHB supports */
+	if (phb->unfreeze_pe)
+		return phb->unfreeze_pe(phb, pe->addr, opt);
+
+	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe->addr, opt);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld enable %d for PHB#%x-PE#%x\n",
+			__func__, rc, option, phb->hose->global_number,
+			pe->addr);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 /**
-- 
2.1.0
