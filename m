Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 028601A0633
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 11:16:28 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 1/3] powerpc/powernv: Create separate subcores CPU feature
 bit
Date: Fri, 19 Feb 2016 11:16:22 +1100
Message-Id: <1455840984-24068-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1455840984-24068-1-git-send-email-mikey@neuling.org>
References: <1455840984-24068-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subcores isn't really part of the 2.07 architecture but currently we
turn it on using the 2.07 feature bit.  Subcores is really a POWER8
specific feature.

This adds a new CPU_FTR bit just for subcores and moves the subcore
init code over to use this.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h      | 3 ++-
 arch/powerpc/platforms/powernv/subcore.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index b118072..a47e175 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -196,6 +196,7 @@ enum {
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
+#define CPU_FTR_SUBCORE			LONG_ASM_CONST(0x2000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -443,7 +444,7 @@ enum {
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
-	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_SUBCORE)
 #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
 #define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 503a73f..0babef1 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -407,7 +407,7 @@ static DEVICE_ATTR(subcores_per_core, 0644,
 
 static int subcore_init(void)
 {
-	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+	if (!cpu_has_feature(CPU_FTR_SUBCORE))
 		return 0;
 
 	/*
-- 
2.5.0
