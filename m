Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vq5y81zF3FZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:51 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1JCKe028131
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:50 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2memwr8q4u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:50 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1NZVd55640280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBF3EA4053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:24 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32CB3A4055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:24 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:24 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id AADDBA037D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/14] powerpc/eeh: Cleanup EEH_POSTPONED_PROBE
Date: Wed, 12 Sep 2018 11:23:23 +1000
In-Reply-To: <cover.1536715396.git.sbobroff@linux.ibm.com>
References: <cover.1536715396.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <39697647a299d42d637adbf03900493e694922c0.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently a flag, EEH_POSTPONED_PROBE, is used to prevent an incorrect
message "EEH: No capable adapters found" from being displayed during
the boot of powernv systems.

It is necessary because, on powernv, the call to eeh_probe_devices()
made from eeh_init() is too early and EEH can't yet be enabled. A
second call is made later from eeh_pnv_post_init(), which succeeds.

(On pseries, the first call succeeds because PCI devices are set up
early enough and no second call is made.)

This can be simplified by moving the early call to eeh_probe_devices()
from eeh_init() (where it's seen by both platforms) to
pSeries_final_fixup(), so that each platform only calls
eeh_probe_devices() once, at a point where it can succeed.
This is slightly later in the boot sequence, but but still early
enough and it is now in the same place in the sequence for both
platforms (the pcibios_fixup hook).

The display of the message can be cleaned up as well, by moving it
into eeh_probe_devices().

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  1 -
 arch/powerpc/kernel/eeh.c                    | 18 ++++++------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 14 --------------
 arch/powerpc/platforms/pseries/pci.c         |  1 +
 4 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 219637ea69a1..147f0117e56f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -43,7 +43,6 @@ struct pci_dn;
 #define EEH_VALID_PE_ZERO	0x10	/* PE#0 is valid		     */
 #define EEH_ENABLE_IO_FOR_LOG	0x20	/* Enable IO for log		     */
 #define EEH_EARLY_DUMP_LOG	0x40	/* Dump log immediately		     */
-#define EEH_POSTPONED_PROBE	0x80    /* Powernv may postpone device probe */
 
 /*
  * Delay for PE reset, all in ms
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 69754af506dd..25e7384fdaba 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1041,6 +1041,11 @@ void eeh_probe_devices(void)
 		pdn = hose->pci_data;
 		traverse_pci_dn(pdn, eeh_ops->probe, NULL);
 	}
+	if (eeh_enabled())
+		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
+	else
+		pr_info("EEH: No capable adapters found\n");
+
 }
 
 /**
@@ -1084,18 +1089,7 @@ static int eeh_init(void)
 		eeh_dev_phb_init_dynamic(hose);
 
 	/* Initialize EEH event */
-	ret = eeh_event_init();
-	if (ret)
-		return ret;
-
-	eeh_probe_devices();
-
-	if (eeh_enabled())
-		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
-	else if (!eeh_has_flag(EEH_POSTPONED_PROBE))
-		pr_info("EEH: No capable adapters found\n");
-
-	return ret;
+	return eeh_event_init();
 }
 
 core_initcall_sync(eeh_init);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3c1beae29f2d..d0764f2c0733 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -223,14 +223,6 @@ int pnv_eeh_post_init(void)
 	eeh_probe_devices();
 	eeh_addr_cache_build();
 
-	if (eeh_has_flag(EEH_POSTPONED_PROBE)) {
-		eeh_clear_flag(EEH_POSTPONED_PROBE);
-		if (eeh_enabled())
-			pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
-		else
-			pr_info("EEH: No capable adapters found\n");
-	}
-
 	/* Register OPAL event notifier */
 	eeh_event_irq = opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
 	if (eeh_event_irq < 0) {
@@ -391,12 +383,6 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	if ((pdn->class_code >> 8) == PCI_CLASS_BRIDGE_ISA)
 		return NULL;
 
-	/* Skip if we haven't probed yet */
-	if (phb->ioda.pe_rmap[config_addr] == IODA_INVALID_PE) {
-		eeh_add_flag(EEH_POSTPONED_PROBE);
-		return NULL;
-	}
-
 	/* Initialize eeh device */
 	edev->class_code = pdn->class_code;
 	edev->mode	&= 0xFFFFFF00;
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index eab96637d6cf..41d8a4d1d02e 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -239,6 +239,7 @@ void __init pSeries_final_fixup(void)
 {
 	pSeries_request_regions();
 
+	eeh_probe_devices();
 	eeh_addr_cache_build();
 
 #ifdef CONFIG_PCI_IOV
-- 
2.19.0.2.gcad72f5712
