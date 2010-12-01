Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8205B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 09:31:21 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB1MQYY7012237
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 15:26:34 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	oB1MV6Lk256896
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 15:31:06 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB1MV5cV008054
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Dec 2010 15:31:06 -0700
Date: Wed, 1 Dec 2010 15:31:03 -0700
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20101201223103.15119.9878.sendpatchset@manic8ball.ltc.austin.ibm.com>
In-Reply-To: <20101201223052.15119.61473.sendpatchset@manic8ball.ltc.austin.ibm.com>
References: <20101201223052.15119.61473.sendpatchset@manic8ball.ltc.austin.ibm.com>
Subject: [PATCH V3 1/3] powerpc: Add VPHN firmware feature
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
