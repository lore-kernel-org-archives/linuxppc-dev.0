Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AE991A09FA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Nov 2014 21:58:19 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D29C4140179
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2014 21:58:18 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 22 Nov 2014 16:28:16 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7F8ED3940024
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2014 16:28:13 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAMAwmo85570986
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2014 16:28:48 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAMAwCDG022783
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2014 16:28:12 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/eeh: Dump PHB diag-data early
Date: Sat, 22 Nov 2014 21:58:09 +1100
Message-Id: <1416653889-5093-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, PHB diag-data is dumped after stopping device
drivers. In case of recursive EEH errors, the kernel is usually
crashed before dumping PHB diag-data for the second EEH error. It's
hard to locate the root cause of the second EEH error without PHB
diag-data.

The patch adds one more EEH option "eeh=early_log", which helps
dumping PHB diag-data immediately once frozen PE is detected, in
order to get the PHB diag-data for the second EEH error.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            |  1 +
 arch/powerpc/kernel/eeh.c                 |  2 ++
 arch/powerpc/platforms/powernv/eeh-ioda.c | 13 ++++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 2e633b4..0652ebe 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -39,6 +39,7 @@ struct device_node;
 #define EEH_PROBE_MODE_DEV	0x04	/* From PCI device	*/
 #define EEH_PROBE_MODE_DEVTREE	0x08	/* From device tree	*/
 #define EEH_ENABLE_IO_FOR_LOG	0x10	/* Enable IO for log	*/
+#define EEH_EARLY_DUMP_LOG	0x20	/* Dump log immediately	*/
 
 /*
  * Delay for PE reset, all in ms
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index f1c6b11..05be77d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -143,6 +143,8 @@ static int __init eeh_setup(char *str)
 {
 	if (!strcmp(str, "off"))
 		eeh_add_flag(EEH_FORCE_DISABLED);
+	else if (!strcmp(str, "early_log"))
+		eeh_add_flag(EEH_EARLY_DUMP_LOG);
 
 	return 1;
 }
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 426814a..43aba2d 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -354,6 +354,9 @@ static int ioda_eeh_get_phb_state(struct eeh_pe *pe)
 	} else if (!(pe->state & EEH_PE_ISOLATED)) {
 		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 		ioda_eeh_phb_diag(pe);
+
+		if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
+			pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
 	}
 
 	return result;
@@ -452,6 +455,9 @@ static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
 
 		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 		ioda_eeh_phb_diag(pe);
+
+		if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
+			pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
 	}
 
 	return result;
@@ -731,7 +737,8 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 static int ioda_eeh_get_log(struct eeh_pe *pe, int severity,
 			    char *drv_log, unsigned long len)
 {
-	pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
+	if (!eeh_has_flag(EEH_EARLY_DUMP_LOG))
+		pnv_pci_dump_phb_diag_data(pe->phb, pe->data);
 
 	return 0;
 }
@@ -1087,6 +1094,10 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		    !((*pe)->state & EEH_PE_ISOLATED)) {
 			eeh_pe_state_mark(*pe, EEH_PE_ISOLATED);
 			ioda_eeh_phb_diag(*pe);
+
+			if (eeh_has_flag(EEH_EARLY_DUMP_LOG))
+				pnv_pci_dump_phb_diag_data((*pe)->phb,
+							   (*pe)->data);
 		}
 
 		/*
-- 
1.8.3.2
