Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfMCD0GV7zDshF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 00:17:27 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LEE6CS025726
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:17:26 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25k6cm3s96-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:17:25 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 10:17:24 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4EDC96E803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 10:16:57 -0400 (EDT)
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V6 1/8] powerpc/firmware: Add definitions for new firmware
 features.
Date: Wed, 21 Sep 2016 09:17:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <15f0d37f-6f72-c4c3-0628-891c2bc9732b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Firmware Features: Define new bit flags representing the presence of
new device tree properties "ibm,drc-info", and "ibm,dynamic-memory-v2".
These flags are used to tell the front end processor when the Linux
kernel supports the new properties, and by the front end processor to
tell the Linux kernel that the new properties are present in the devie
tree.

[V2: Revise constant names for improved clarity.]
[V3: Fix comments]
[V4: Fix some spacing]
[V5: Resynchronize/resubmit]
[V6: No change]

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index b062924..a9d66d5 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -51,6 +51,8 @@
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
+#define FW_FEATURE_DYN_MEM_V2	ASM_CONST(0x0000000400000000)
+#define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
 
 #ifndef __ASSEMBLY__
 
@@ -66,7 +68,8 @@ enum {
 		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
 		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
-		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
+		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
+		FW_FEATURE_DYN_MEM_V2 | FW_FEATURE_DRC_INFO,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 7f436ba..b9a1534 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -155,6 +203,8 @@ struct of_drconf_cell {
 #define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
 #define OV5_SUB_PROCESSORS	0x0F01	/* 1,2,or 4 Sub-Processors supported */
+#define OV5_DYN_MEM_V2		0x1680	/* Redef Prop Structures: dyn-mem-v2 */
+#define OV5_DRC_INFO		0x1640	/* Redef Prop Structures: drc-info   */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 8c80588..00243ee 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -113,6 +113,8 @@ static __initdata struct vec5_fw_feature
 vec5_fw_features_table[] = {
 	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
 	{FW_FEATURE_PRRN,		OV5_PRRN},
+	{FW_FEATURE_DYN_MEM_V2,		OV5_DYN_MEM_V2},
+	{FW_FEATURE_DRC_INFO,		OV5_DRC_INFO},
 };
 
 void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
