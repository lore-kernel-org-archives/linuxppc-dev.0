Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B130B1A15FD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:13:17 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 25 Sep 2014 14:13:14 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 973882CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:13:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P3suv737814460
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 13:54:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P4D9eH002601
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:13:09 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/powernv: Fetch frozen PE on top level
Date: Thu, 25 Sep 2014 14:13:07 +1000
Message-Id: <1411618387-7920-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1411618387-7920-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1411618387-7920-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It should have been part of commit 1ad7a72c5 ("powerpc/eeh: Report
frozen parent PE prior to child PE"). There are 2 ways to report
EEH errors: proactively polling triggered by PCI config or IO
accesses, or interrupt driven event. We missed to report and handle
parent frozen PE prior to child frozen PE for the later case on
PowerNV platform.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 48 ++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index f248586..57de63c 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -880,14 +880,12 @@ static int ioda_eeh_get_pe(struct pci_controller *hose,
 	 * the master PE because slave PE is invisible
 	 * to EEH core.
 	 */
-	if (phb->get_pe_state) {
-		pnv_pe = &phb->ioda.pe_array[pe_no];
-		if (pnv_pe->flags & PNV_IODA_PE_SLAVE) {
-			pnv_pe = pnv_pe->master;
-			WARN_ON(!pnv_pe ||
-				!(pnv_pe->flags & PNV_IODA_PE_MASTER));
-			pe_no = pnv_pe->pe_number;
-		}
+	pnv_pe = &phb->ioda.pe_array[pe_no];
+	if (pnv_pe->flags & PNV_IODA_PE_SLAVE) {
+		pnv_pe = pnv_pe->master;
+		WARN_ON(!pnv_pe ||
+			!(pnv_pe->flags & PNV_IODA_PE_MASTER));
+		pe_no = pnv_pe->pe_number;
 	}
 
 	/* Find the PE according to PE# */
@@ -898,15 +896,37 @@ static int ioda_eeh_get_pe(struct pci_controller *hose,
 	if (!dev_pe)
 		return -EEXIST;
 
-	/*
-	 * At this point, we're sure the compound PE should
-	 * be put into frozen state.
-	 */
+	/* Freeze the (compound) PE */
 	*pe = dev_pe;
-	if (phb->freeze_pe &&
-	    !(dev_pe->state & EEH_PE_ISOLATED))
+	if (!(dev_pe->state & EEH_PE_ISOLATED))
 		phb->freeze_pe(phb, pe_no);
 
+	/*
+	 * At this point, we're sure the (compound) PE should
+	 * have been frozen. However, we still need poke until
+	 * hitting the frozen PE on top level.
+	 */
+	dev_pe = dev_pe->parent;
+	while (dev_pe && !(dev_pe->type & EEH_PE_PHB)) {
+		int ret;
+		int active_flags = (EEH_STATE_MMIO_ACTIVE |
+				    EEH_STATE_DMA_ACTIVE);
+
+		ret = eeh_ops->get_state(dev_pe, NULL);
+		if (ret <= 0 || (ret & active_flags) == active_flags) {
+			dev_pe = dev_pe->parent;
+			continue;
+		}
+
+		/* Frozen parent PE */
+		*pe = dev_pe;
+		if (!(dev_pe->state & EEH_PE_ISOLATED))
+			phb->freeze_pe(phb, dev_pe->addr);
+
+		/* Next one */
+		dev_pe = dev_pe->parent;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.2
