Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D88C81A0776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:17 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:17 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 86F27357804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2Exnq56623166
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:14:59 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dDGQ007797
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/21] powerpc/powernv: Clear PAPR error injection registers
Date: Tue, 30 Sep 2014 12:38:58 +1000
Message-Id: <1412044750-24460-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The frozen state on one specific PE is probably caused by error
injection, which is done with help of PAPR error injection registers.
According to the hardware spec, those registers should be cleared
automatically after one-shot frozen PE. However, that's not always
true, at least on P7IOC of Firebird-L. So we have to clear them
before doing PE reset to avoid recursive EEH errors at recovery
stage.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 3389cf0..e516b7f 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -682,6 +682,31 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	if (pe->type & EEH_PE_PHB) {
 		ret = ioda_eeh_phb_reset(hose, option);
 	} else {
+		struct pnv_phb *phb;
+		s64 rc;
+
+		/*
+		 * The frozen PE might be caused by PAPR error injection
+		 * registers, which are expected to be cleared after hitting
+		 * frozen PE as stated in the hardware spec. Unfortunately,
+		 * that's not true on P7IOC. So we have to clear it manually
+		 * to avoid recursive EEH errors during recovery.
+		 */
+		phb = hose->private_data;
+		if (phb->model == PNV_PHB_MODEL_P7IOC &&
+		    (option == EEH_RESET_HOT ||
+		    option == EEH_RESET_FUNDAMENTAL)) {
+			rc = opal_pci_reset(phb->opal_id,
+					    OPAL_PHB_ERROR,
+					    OPAL_ASSERT_RESET);
+			if (rc != OPAL_SUCCESS) {
+				pr_warn("%s: Failure %lld clearing "
+					"error injection registers\n",
+					__func__, rc);
+				return -EIO;
+			}
+		}
+
 		bus = eeh_pe_bus_get(pe);
 		if (pci_is_root_bus(bus) ||
 		    pci_is_root_bus(bus->parent))
-- 
1.8.3.2
