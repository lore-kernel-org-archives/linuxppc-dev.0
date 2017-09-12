Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsJLJ2KfszDrJg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 07:47:36 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8CLj2kr074566
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 17:47:33 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cxpge3883-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 17:47:33 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 12 Sep 2017 15:47:32 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V3 1/4] powerpc/firmware: Add definitions for new drc-info
 firmware feature
In-Reply-To: <531bfd59-97ed-0ea9-0a93-dea7eb415b77@linux.vnet.ibm.com>
Date: Tue, 12 Sep 2017 16:47:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <5e71ff87-13c4-7a7e-aa0b-29c299d480b3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Firmware Features: Define new bit flag representing the presence of
new device tree property "ibm,drc-info".  The flag is used to tell
the front end processor when the Linux kernel supports the new properties,
and by the front end processor to tell the Linux kernel that the new
property is present in the device tree.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h       |    3 ++-
 arch/powerpc/include/asm/prom.h           |    1 +
 arch/powerpc/platforms/pseries/firmware.c |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 8645897..329d537 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -51,6 +51,7 @@
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
+#define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000400000000)
 
 #ifndef __ASSEMBLY__
 
@@ -67,7 +68,7 @@ enum {
 		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
-		FW_FEATURE_HPT_RESIZE,
+		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRC_INFO,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 35c00d7..4fb02cc 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -172,6 +172,7 @@ struct of_drconf_cell {
 #define OV5_HASH_GTSE		0x1940	/* Guest Translation Shoot Down Avail */
 /* Radix Table Extensions */
 #define OV5_RADIX_GTSE		0x1A40	/* Guest Translation Shoot Down Avail */
+#define OV5_DRC_INFO		0x1640	/* Redef Prop Structures: drc-info   */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 63cc82a..757d757 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -114,6 +114,7 @@ struct vec5_fw_feature {
 vec5_fw_features_table[] = {
 	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
 	{FW_FEATURE_PRRN,		OV5_PRRN},
+	{FW_FEATURE_DRC_INFO,		OV5_DRC_INFO},
 };
 
 static void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
