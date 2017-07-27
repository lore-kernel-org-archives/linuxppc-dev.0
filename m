Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJH4X4SFBzDrL8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 02:10:04 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RG7cnG086759
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:10:02 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byjw2hmmx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:10:02 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 10:10:01 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, Michael Bringmann <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V2 1/4] powerpc/firmware: Add definitions for new drc-info
 firmware feature
In-Reply-To: <e884f428-c76d-112a-aa2f-f57a94de55fb@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 11:09:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <1df3e7e0-6f32-fa38-0a7d-2cf0ecb92e91@linux.vnet.ibm.com>
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
