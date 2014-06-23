Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41E261A0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:48 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Jun 2014 12:14:46 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 898733578055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:43 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5N2ERRt11600374
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5N2EhDV000961
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:43 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/3] powerpc/powernv: Clear PAPR error injection registers
Date: Mon, 23 Jun 2014 12:14:42 +1000
Message-Id: <1403489682-14841-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com, agraf@suse.de,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/eeh-ioda.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 79193eb..cbc7c98 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -657,6 +657,30 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
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
+				pr_warn("%s: Can't clear errinjct reg (%lld)\n",
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
