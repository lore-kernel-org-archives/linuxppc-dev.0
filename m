Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A1561A02E2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:47:14 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1F61B14021A
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:14 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:47:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2A3C12CE8040
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:11 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3l2lj42008770
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:11 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3kbbo021161
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:37 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/10] powerpc/powernv: Drop PHB operation configure_bridge()
Date: Mon, 16 Feb 2015 14:45:43 +1100
Message-Id: <1424058348-28951-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424058348-28951-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch drops PHB EEH operation configure_bridge() and merges
its logic to eeh_ops::configure_bridge().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 15 ---------------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  9 +--------
 arch/powerpc/platforms/powernv/pci.h         |  1 -
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 7eb6e72..6459516 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -530,20 +530,6 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	return ret;
 }
 
-/**
- * ioda_eeh_configure_bridge - Configure the PCI bridges for the indicated PE
- * @pe: EEH PE
- *
- * For particular PE, it might have included PCI bridges. In order
- * to make the PE work properly, those PCI bridges should be configured
- * correctly. However, we need do nothing on P7IOC since the reset
- * function will do everything that should be covered by the function.
- */
-static int ioda_eeh_configure_bridge(struct eeh_pe *pe)
-{
-	return 0;
-}
-
 static void ioda_eeh_hub_diag_common(struct OpalIoP7IOCErrorData *data)
 {
 	/* GEM */
@@ -886,6 +872,5 @@ struct pnv_eeh_ops ioda_eeh_ops = {
 	.set_option		= ioda_eeh_set_option,
 	.get_state		= ioda_eeh_get_state,
 	.reset			= ioda_eeh_reset,
-	.configure_bridge	= ioda_eeh_configure_bridge,
 	.next_error		= ioda_eeh_next_error
 };
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 465deb5..a7087f4 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -549,14 +549,7 @@ static int pnv_eeh_get_log(struct eeh_pe *pe, int severity,
  */
 static int pnv_eeh_configure_bridge(struct eeh_pe *pe)
 {
-	struct pci_controller *hose = pe->phb;
-	struct pnv_phb *phb = hose->private_data;
-	int ret = 0;
-
-	if (phb->eeh_ops && phb->eeh_ops->configure_bridge)
-		ret = phb->eeh_ops->configure_bridge(pe);
-
-	return ret;
+	return 0;
 }
 
 /**
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 1e7a623..d8808ca 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -81,7 +81,6 @@ struct pnv_eeh_ops {
 	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_state)(struct eeh_pe *pe);
 	int (*reset)(struct eeh_pe *pe, int option);
-	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*next_error)(struct eeh_pe **pe);
 };
 #endif /* CONFIG_EEH */
-- 
1.8.3.2
