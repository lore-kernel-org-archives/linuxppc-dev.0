Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3HWF46jRzDrKh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 10:43:37 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u720YscI129706
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:43:34 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gr47py83-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 20:43:34 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 18:43:33 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3814019D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 18:43:05 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V3 7/8] powerpc: Check arch.vec earlier during boot for memory
 features
Date: Mon, 1 Aug 2016 19:43:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <4a86b1e6-05d3-3eda-a164-a4f9771d6f1a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

architecture.vec5 features: The boot-time memory management needs to
know the form of the "ibm,dynamic-memory-v2" property early during
scanning of the flattened device tree.  This patch moves execution of
the function pseries_probe_fw_features() early enough to be before
the scanning of the memory properties in the device tree to allow
recognition of the supported properties.

Updated after commit 3808a88985b4f5f5e947c364debce4441a380fb8.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 946e34f..2034edc 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -753,6 +753,9 @@ void __init early_init_devtree(void *params)
 	 */
 	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
 
+	/* Now try to figure out if we are running on LPAR and so on */
+	pseries_probe_fw_features();
+
 	/* Scan memory nodes and rebuild MEMBLOCKs */
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
@@ -823,9 +823,6 @@ void __init early_init_devtree(void *params)
 #endif
 	epapr_paravirt_early_init();
 
-	/* Now try to figure out if we are running on LPAR and so on */
-	pseries_probe_fw_features();
-
 #ifdef CONFIG_PPC_PS3
 	/* Identify PS3 firmware */
 	if (of_flat_dt_is_compatible(of_get_flat_dt_root(), "sony,ps3"))
 
