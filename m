Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 803F41A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:06:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 12 May 2015 17:06:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1A3122BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:06:34 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4C76Pqb16187522
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:06:33 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4C761Lv021804
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:06:01 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Dump PHB diag-data for non-existing PE
Date: Tue, 12 May 2015 17:05:32 +1000
Message-Id: <1431414332-29061-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When detecting EEH error on non-existing PE, including the reserved
one, the PE is simply unfrozen without dumping the PHB diag-data,
which is useful for locating the root cause of the EEH error. The
patch dumps the PHB diag-data when non-existing PE reports error.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 9e001e1..bbcf81f 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1394,11 +1394,19 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 			 */
 			if (pnv_eeh_get_pe(hose,
 				be64_to_cpu(frozen_pe_no), pe)) {
-				/* Try best to clear it */
 				pr_info("EEH: Clear non-existing PHB#%x-PE#%llx\n",
 					hose->global_number, be64_to_cpu(frozen_pe_no));
 				pr_info("EEH: PHB location: %s\n",
 					eeh_pe_loc_get(phb_pe));
+
+				/* Dump PHB diag-data */
+				rc = opal_pci_get_phb_diag_data2(phb->opal_id,
+					phb->diag.blob, PNV_PCI_DIAG_BUF_SIZE);
+				if (rc == OPAL_SUCCESS)
+					pnv_pci_dump_phb_diag_data(hose,
+							phb->diag.blob);
+
+				/* Try best to clear it */
 				opal_pci_eeh_freeze_clear(phb->opal_id,
 					frozen_pe_no,
 					OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
-- 
2.1.0
