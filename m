Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 279951A0176
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 14:47:05 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C0914140272
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 13:47:04 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0CD86357804C
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:01 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G3kqgL48169132
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:47:01 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G3kRiD020891
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 14:46:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/10] powerpc/powernv: Drop PHB operation get_log()
Date: Mon, 16 Feb 2015 14:45:42 +1100
Message-Id: <1424058348-28951-5-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch drops PHB operation get_log() and merges its logic to
eeh_ops::get_log().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 20 --------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 10 +++-------
 arch/powerpc/platforms/powernv/pci.h         |  2 --
 3 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index bd509ad..7eb6e72 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -531,25 +531,6 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 }
 
 /**
- * ioda_eeh_get_log - Retrieve error log
- * @pe: frozen PE
- * @severity: permanent or temporary error
- * @drv_log: device driver log
- * @len: length of device driver log
- *
- * Retrieve error log, which contains log from device driver
- * and firmware.
- */
-static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
-			    char *drv_log, unsigned long len)
-{
-	if (!eeh_has_flag(EEH_EARLY_DUMP_LOG))
-		pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
-
-	return 0;
-}
-
-/**
  * ioda_eeh_configure_bridge - Configure the PCI bridges for the indicated PE
  * @pe: EEH PE
  *
@@ -905,7 +886,6 @@ struct pnv_eeh_ops ioda_eeh_ops = {
 	.set_option		= ioda_eeh_set_option,
 	.get_state		= ioda_eeh_get_state,
 	.reset			= ioda_eeh_reset,
-	.get_log		= ioda_eeh_get_log,
 	.configure_bridge	= ioda_eeh_configure_bridge,
 	.next_error		= ioda_eeh_next_error
 };
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 641ba33..465deb5 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -533,14 +533,10 @@ static int pnv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
 static int pnv_eeh_get_log(struct eeh_pe *pe, int severity,
 			   char *drv_log, unsigned long len)
 {
-	struct pci_controller *hose = pe->phb;
-	struct pnv_phb *phb = hose->private_data;
-	int ret = -EEXIST;
+	if (!eeh_has_flag(EEH_EARLY_DUMP_LOG))
+		pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
 
-	if (phb->eeh_ops && phb->eeh_ops->get_log)
-		ret = phb->eeh_ops->get_log(pe, severity, drv_log, len);
-
-	return ret;
+	return 0;
 }
 
 /**
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index c7e047f..1e7a623 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -81,8 +81,6 @@ struct pnv_eeh_ops {
 	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_state)(struct eeh_pe *pe);
 	int (*reset)(struct eeh_pe *pe, int option);
-	int (*get_log)(struct eeh_pe *pe, int severity,
-		       char *drv_log, unsigned long len);
 	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*next_error)(struct eeh_pe **pe);
 };
-- 
1.8.3.2
