Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypLFZ4J3HzDsM9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 04:03:30 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1Gt4Ou139686
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 12:03:28 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eka4mkb4s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 12:03:27 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 12:03:26 -0500
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB1H3OYg49807532
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 17:03:24 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4733EAC03F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:04:22 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id 1F66FAC03A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:04:22 -0500 (EST)
Subject: [PATCH V3 9/9] powerpc: Enable support of ibm,dynamic-memory-v2
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 01 Dec 2017 10:48:03 -0600
In-Reply-To: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151214687950.64022.15779582389677722807.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add required bits to the architecture vector to enable support
of the ibm,dynamic-memory-v2 device tree property.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h       |    3 ++-
 arch/powerpc/include/asm/prom.h           |    1 +
 arch/powerpc/kernel/prom_init.c           |    1 +
 arch/powerpc/platforms/pseries/firmware.c |    1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 8645897472b1..832df61f30ef 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -51,6 +51,7 @@
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
+#define FW_FEATURE_DRMEM_V2	ASM_CONST(0x0000000400000000)
 
 #ifndef __ASSEMBLY__
 
@@ -67,7 +68,7 @@ enum {
 		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
-		FW_FEATURE_HPT_RESIZE,
+		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRMEM_V2,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index f0a30a003bd8..9f27866e3126 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -143,6 +143,7 @@ extern int of_get_ibm_chip_id(struct device_node *np);
 #define OV5_PFO_HW_842		0x1140	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x1120	/* PFO Encryption Accelerator */
 #define OV5_SUB_PROCESSORS	0x1501	/* 1,2,or 4 Sub-Processors supported */
+#define OV5_DRMEM_V2		0x1680	/* ibm,dynamic-reconfiguration-v2 */
 #define OV5_XIVE_SUPPORT	0x17C0	/* XIVE Exploitation Support Mask */
 #define OV5_XIVE_LEGACY		0x1700	/* XIVE legacy mode Only */
 #define OV5_XIVE_EXPLOIT	0x1740	/* XIVE exploitation mode Only */
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 02190e90c7ae..acf4b2e0530c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -869,6 +869,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.reserved2 = 0,
 		.reserved3 = 0,
 		.subprocessors = 1,
+		.byte22 = OV5_FEAT(OV5_DRMEM_V2),
 		.intarch = 0,
 		.mmu = 0,
 		.hash_ext = 0,
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 63cc82ad58ac..aac3ea2911b2 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -114,6 +114,7 @@ static __initdata struct vec5_fw_feature
 vec5_fw_features_table[] = {
 	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
 	{FW_FEATURE_PRRN,		OV5_PRRN},
+	{FW_FEATURE_DRMEM_V2,		OV5_DRMEM_V2},
 };
 
 static void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
