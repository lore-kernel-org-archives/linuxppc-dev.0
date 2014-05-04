Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B6C1914018A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 09:28:51 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 09:28:50 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B5DB22BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 09:28:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s44N7dx566584694
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 09:07:39 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s44NSjLr012230
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 09:28:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 3/3] powerpc/powernv: Don't escalate non-existing frozen PE
Date: Mon,  5 May 2014 09:29:04 +1000
Message-Id: <1399246144-20247-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399246144-20247-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399246144-20247-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit cb5b242c ("powerpc/eeh: Escalate error on non-existing PE")
escalates the frozen state on non-existing PE to fenced PHB. It
was to improve kdump reliability. After that, commit 361f2a2a
("powrpc/powernv: Reset PHB in kdump kernel") was introduced to
issue complete reset on all PHBs to increase the reliability of
kdump kernel.

Commit cb5b242c becomes unuseful and it would be reverted.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 65feec6..1b5982f 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -884,13 +884,12 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 			 * it again.
 			 */
 			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe)) {
-				*pe = phb_pe;
-				pr_err("EEH: Escalated frozen PHB#%x-"
-				       "PE#%llx (%s) detected\n",
-					hose->global_number,
-					frozen_pe_no,
-					eeh_pe_loc_get(phb_pe));
-				ret = EEH_NEXT_ERR_FENCED_PHB;
+				/* Try best to clear it */
+				pr_info("EEH: Clear non-existing PHB#%x-PE#%llx\n",
+					hose->global_number, frozen_pe_no);
+				opal_pci_eeh_freeze_clear(phb->opal_id, frozen_pe_no,
+					OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+				ret = EEH_NEXT_ERR_NONE;
 			} else if ((*pe)->state & EEH_PE_ISOLATED) {
 				ret = EEH_NEXT_ERR_NONE;
 			} else {
-- 
1.8.3.2
