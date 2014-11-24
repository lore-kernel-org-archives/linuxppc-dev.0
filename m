Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9186C1A028E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:27:08 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C79801400DE
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:27:07 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 03:57:05 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id DAD13E0059
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 03:57:24 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMRcLl60948618
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 03:57:38 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMR2MW009792
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 03:57:03 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/eeh: Fix missed PE#0 on P7IOC
Date: Tue, 25 Nov 2014 09:27:00 +1100
Message-Id: <1416868020-4129-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1416868020-4129-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416868020-4129-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PE#0 should be regarded as valid for P7IOC, while it's invalid for
PHB3. The patch adds flag EEH_VALID_PE_ZERO to differentiate those
two cases. Without the patch, we possibly see frozen PE#0 state is
cleared without EEH recovery taken on P7IOC as following kernel logs
indicate:

[root@ltcfbl8eb ~]# dmesg
       :
pci 0000:00     : [PE# 000] Secondary bus 0 associated with PE#0
pci 0000:01     : [PE# 001] Secondary bus 1 associated with PE#1
pci 0001:00     : [PE# 000] Secondary bus 0 associated with PE#0
pci 0001:01     : [PE# 001] Secondary bus 1 associated with PE#1
pci 0002:00     : [PE# 000] Secondary bus 0 associated with PE#0
pci 0002:01     : [PE# 001] Secondary bus 1 associated with PE#1
pci 0003:00     : [PE# 000] Secondary bus 0 associated with PE#0
pci 0003:01     : [PE# 001] Secondary bus 1 associated with PE#1
pci 0003:20     : [PE# 002] Secondary bus 32..63 associated with PE#2
       :
EEH: Clear non-existing PHB#3-PE#0
EEH: PHB location: U78AE.001.WZS00M9-P1-002

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  5 +++--
 arch/powerpc/kernel/eeh_pe.c                 | 14 +++++++++++---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 11 +++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 0652ebe..9c11d1e 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -38,8 +38,9 @@ struct device_node;
 #define EEH_FORCE_DISABLED	0x02	/* EEH disabled		*/
 #define EEH_PROBE_MODE_DEV	0x04	/* From PCI device	*/
 #define EEH_PROBE_MODE_DEVTREE	0x08	/* From device tree	*/
-#define EEH_ENABLE_IO_FOR_LOG	0x10	/* Enable IO for log	*/
-#define EEH_EARLY_DUMP_LOG	0x20	/* Dump log immediately	*/
+#define EEH_VALID_PE_ZERO	0x10	/* PE#0 is valid	*/
+#define EEH_ENABLE_IO_FOR_LOG	0x20	/* Enable IO for log	*/
+#define EEH_EARLY_DUMP_LOG	0x40	/* Dump log immediately	*/
 
 /*
  * Delay for PE reset, all in ms
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 5a63e2b..fa950fb 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -239,10 +239,18 @@ static void *__eeh_pe_get(void *data, void *flag)
 	if (pe->type & EEH_PE_PHB)
 		return NULL;
 
-	/* We prefer PE address */
-	if (edev->pe_config_addr &&
-	   (edev->pe_config_addr == pe->addr))
+	/*
+	 * We prefer PE address. For most cases, we should
+	 * have non-zero PE address
+	 */
+	if (eeh_has_flag(EEH_VALID_PE_ZERO)) {
+		if (edev->pe_config_addr == pe->addr)
+			return pe;
+	} else {
+		if (edev->pe_config_addr &&
+		    (edev->pe_config_addr == pe->addr))
 		return pe;
+	}
 
 	/* Try BDF address */
 	if (edev->config_addr &&
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 1d19e79..e261869 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -68,6 +68,17 @@ static int powernv_eeh_init(void)
 
 		if (phb->model == PNV_PHB_MODEL_P7IOC)
 			eeh_add_flag(EEH_ENABLE_IO_FOR_LOG);
+
+		/*
+		 * PE#0 should be regarded as valid by EEH core
+		 * if it's not the reserved one. Currently, we
+		 * have the reserved PE#0 and PE#127 for PHB3
+		 * and P7IOC separately. So we should regard
+		 * PE#0 as valid for P7IOC.
+		 */
+		if (phb->ioda.reserved_pe != 0)
+			eeh_add_flag(EEH_VALID_PE_ZERO);
+
 		break;
 	}
 
-- 
1.8.3.2
