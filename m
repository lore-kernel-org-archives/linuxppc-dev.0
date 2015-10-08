Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB21B1A021E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:00:23 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 92DBF140D87
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:00:23 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 14:00:23 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 85B1F2CE8054
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:00:21 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t98409QF25952446
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 15:00:17 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t983xnbo023227
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 14:59:49 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 6/8] powerpc/powernv: Cleanup on EEH comments
Date: Thu,  8 Oct 2015 14:58:57 +1100
Message-Id: <1444276739-20372-7-git-send-email-gwshan@linux.vnet.ibm.com>
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

This applies cleanup on eeh-powernv.c, no functional changes:

   * Remove unnecessary comments and empty line.
   * Correct inaccurate comments.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3bb6acb..2032936 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -43,17 +43,11 @@
 static bool pnv_eeh_nb_init = false;
 static int eeh_event_irq = -EINVAL;
 
-/**
- * pnv_eeh_init - EEH platform dependent initialization
- *
- * EEH platform dependent initialization on powernv
- */
 static int pnv_eeh_init(void)
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
 
-	/* We require OPALv3 */
 	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
 		pr_warn("%s: OPALv3 is required !\n",
 			__func__);
@@ -77,9 +71,9 @@ static int pnv_eeh_init(void)
 		/*
 		 * PE#0 should be regarded as valid by EEH core
 		 * if it's not the reserved one. Currently, we
-		 * have the reserved PE#0 and PE#127 for PHB3
+		 * have the reserved PE#255 and PE#127 for PHB3
 		 * and P7IOC separately. So we should regard
-		 * PE#0 as valid for P7IOC.
+		 * PE#0 as valid for PHB3 and P7IOC.
 		 */
 		if (phb->ioda.reserved_pe != 0)
 			eeh_add_flag(EEH_VALID_PE_ZERO);
@@ -284,7 +278,6 @@ static int pnv_eeh_post_init(void)
 #endif /* CONFIG_DEBUG_FS */
 	}
 
-
 	return ret;
 }
 
@@ -490,7 +483,6 @@ static int pnv_eeh_set_option(struct eeh_pe *pe, int option)
 	int opt, ret = 0;
 	s64 rc;
 
-	/* Sanity check on option */
 	switch (option) {
 	case EEH_OPT_DISABLE:
 		return -EPERM;
@@ -1065,7 +1057,6 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc;
 
-	/* Sanity check on error type */
 	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
 	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
 		pr_warn("%s: Invalid error type %d\n",
-- 
2.1.0
