Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D27DA2C008F
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 16:16:24 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 22:16:22 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5361A19D8046
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 22:16:11 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0F5G6JM9306594
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 06:16:06 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0F5GJFE007996
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 22:16:20 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 3/3] powerpc/eeh: Escalate error on non-existing PE
Date: Wed, 15 Jan 2014 13:16:13 +0800
Message-Id: <1389762974-14176-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1389762974-14176-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1389762974-14176-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometimes, especially in sinario of loading another kernel with kdump,
we got EEH error on non-existing PE. That means the PEEV / PEST in
the corresponding PHB would be messy and we can't handle that case.
The patch escalates the error to fenced PHB so that the PHB could be
rested in order to revoer the errors on non-existing PEs.

Reported-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   31 +++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index e0b12d0..92aa1f9 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -862,11 +862,7 @@ static int ioda_eeh_get_pe(struct pci_controller *hose,
 	dev.phb = hose;
 	dev.pe_config_addr = pe_no;
 	dev_pe = eeh_pe_get(&dev);
-	if (!dev_pe) {
-		pr_warning("%s: Can't find PE for PHB#%x - PE#%x\n",
-			   __func__, hose->global_number, pe_no);
-		return -EEXIST;
-	}
+	if (!dev_pe) return -EEXIST;
 
 	*pe = dev_pe;
 	return 0;
@@ -980,12 +976,27 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 
 			break;
 		case OPAL_EEH_PE_ERROR:
-			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe))
-				break;
+			/*
+			 * If we can't find the corresponding PE, the
+			 * PEEV / PEST would be messy. So we force an
+			 * fenced PHB so that it can be recovered.
+			 */
+			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe)) {
+				if (!ioda_eeh_get_phb_pe(hose, pe)) {
+					pr_err("EEH: Escalated fenced PHB#%x "
+					       "detected for PE#%llx\n",
+						hose->global_number,
+						frozen_pe_no);
+					ret = EEH_NEXT_ERR_FENCED_PHB;
+				} else {
+					ret = EEH_NEXT_ERR_NONE;
+				}
+			} else {
+				pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
+					(*pe)->addr, (*pe)->phb->global_number);
+				ret = EEH_NEXT_ERR_FROZEN_PE;
+			}
 
-			pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
-				(*pe)->addr, (*pe)->phb->global_number);
-			ret = EEH_NEXT_ERR_FROZEN_PE;
 			break;
 		default:
 			pr_warn("%s: Unexpected error type %d\n",
-- 
1.7.10.4
