Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26AD31A0654
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 17:56:37 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 26 Aug 2014 13:26:34 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7CB19E005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:28:42 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7Q7wrCL38994132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:28:53 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7Q7uTL2030281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 13:26:30 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/powernv: Clear PAPR error injection registers
Date: Tue, 26 Aug 2014 17:56:19 +1000
Message-Id: <1409039779-392-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1409039779-392-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1409039779-392-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: qiudayu@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
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
index 4d40093..729e445 100644
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
