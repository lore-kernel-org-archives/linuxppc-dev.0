Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzy0H5KHczDrbJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:23:43 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6RENguQ134889
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:42 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24dvp8p3vr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:41 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 27 Jul 2016 10:23:35 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 03C486E8053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:10 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6RENSsX61276262
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 14:23:28 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E218AE054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:28 -0400 (EDT)
Received: from oc1376853207.ibm.com (unknown [9.77.146.137])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id D7B6EAE056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:27 -0400 (EDT)
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Resend: [PATCH 7/8] powerpc: Check arch.vec earlier during boot for
 memory features
Date: Wed, 27 Jul 2016 09:23:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <8d983ba2-4768-fd90-e41e-7eb1f6e3e0ab@linux.vnet.ibm.com>
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

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9d86c66..e4c5076 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -215,6 +215,8 @@ extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
 extern int early_init_dt_scan_recoverable_ranges(unsigned long node,
 				 const char *uname, int depth, void *data);
+extern int pseries_probe_fw_features(unsigned long node,
+				 const char *uname, int depth, void *data);
 
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 946e34f..2034edc 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -777,6 +777,7 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
 
 	/* Scan memory nodes and rebuild MEMBLOCKs */
+	of_scan_flat_dt(pseries_probe_fw_features, NULL);
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9883bc7..f554205 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -736,7 +736,7 @@ static void pseries_power_off(void)
  * Called very early, MMU is off, device-tree isn't unflattened
  */
 
-static int __init pseries_probe_fw_features(unsigned long node,
+int __init pseries_probe_fw_features(unsigned long node,
 					    const char *uname, int depth,
 					    void *data)
 {
@@ -770,6 +770,7 @@ static int __init pseries_probe_fw_features(unsigned long node,
 
 	return hypertas_found && vec5_found;
 }
+EXPORT_SYMBOL(pseries_probe_fw_features);
 
 static int __init pSeries_probe(void)
 {
