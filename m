Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA3E7B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 11:28:24 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9T07MLh022429
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2010 20:07:22 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9T0SLUg345932
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2010 20:28:21 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9T0SKRX003127
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2010 22:28:21 -0200
Date: Thu, 28 Oct 2010 22:28:19 -0200
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20101029002729.17835.44326.sendpatchset@manic8ball.ltc.austin.ibm.com>
In-Reply-To: <20101029002628.17835.37125.sendpatchset@manic8ball.ltc.austin.ibm.com>
References: <20101029002628.17835.37125.sendpatchset@manic8ball.ltc.austin.ibm.com>
Subject: [PATCH 1/3] powerpc: Add VPHN firmware feature
Cc: markn@au1.ibm.com, pmac@au1.ibm.com, tbreeds@au1.ibm.com,
	lkessler@us.ibm.com, Jesse Larrew <jlarrew@linux.vnet.ibm.com>,
	mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

This simple patch adds the firmware feature for VPHN to the firmware 
features bitmask.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h       |    3 ++-
 arch/powerpc/include/asm/hvcall.h         |    3 ++-
 arch/powerpc/platforms/pseries/firmware.c |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 20778a4..4ef662e 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -46,6 +46,7 @@
 #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
 #define FW_FEATURE_BEAT		ASM_CONST(0x0000000001000000)
 #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
+#define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
 
 #ifndef __ASSEMBLY__
 
@@ -59,7 +60,7 @@ enum {
 		FW_FEATURE_VIO | FW_FEATURE_RDMA | FW_FEATURE_LLAN |
 		FW_FEATURE_BULK_REMOVE | FW_FEATURE_XDABR |
 		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
-		FW_FEATURE_CMO,
+		FW_FEATURE_CMO | FW_FEATURE_VPHN,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index de03ca5..6de1e5f 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -232,7 +232,8 @@
 #define H_GET_EM_PARMS		0x2B8
 #define H_SET_MPP		0x2D0
 #define H_GET_MPP		0x2D4
-#define MAX_HCALL_OPCODE	H_GET_MPP
+#define H_HOME_NODE_ASSOCIATIVITY 0x2EC
+#define MAX_HCALL_OPCODE	H_HOME_NODE_ASSOCIATIVITY
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 0a14d8c..0b0eff0 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -55,6 +55,7 @@ firmware_features_table[FIRMWARE_MAX_FEATURES] = {
 	{FW_FEATURE_XDABR,		"hcall-xdabr"},
 	{FW_FEATURE_MULTITCE,		"hcall-multi-tce"},
 	{FW_FEATURE_SPLPAR,		"hcall-splpar"},
+	{FW_FEATURE_VPHN,		"hcall-vphn"},
 };
 
 /* Build up the firmware features bitmask using the contents of
-- 
1.7.2.3
