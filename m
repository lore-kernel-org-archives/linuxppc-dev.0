Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbfs66h3NzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 11:53:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org,
	paulus@samba.org,
	npiggin@gmail.com
Subject: [PATCH] powerpc/64: Reclaim CPU_FTR_SUBCORE
Date: Mon, 29 May 2017 11:53:10 +1000
Message-Id: <1496022790-2017-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are running low on CPU feature bits, so we only want to use them when
it's really necessary.

CPU_FTR_SUBCORE is only used in one place, and only in C, so we don't
need it in order to make asm patching work. It can only be set on
"Power8" CPUs, which in practice means POWER8, POWER8E and POWER8NVL.
There are no plans to implement it on future CPUs, but if there ever
were we could retrofit it then.

Although KVM uses subcores, it never looks at the CPU feature, it either
looks at the ISA level or the threads_per_subcore value.

So drop the CPU feature and do a PVR check instead. Drop the device tree
"subcore" feature as we no longer support doing anything with it, and we
will drop it from skiboot too.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h      | 3 +--
 arch/powerpc/kernel/dt_cpu_ftrs.c        | 1 -
 arch/powerpc/platforms/powernv/subcore.c | 8 +++++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index c2d509584a98..d02ad93bf708 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -214,7 +214,6 @@ enum {
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
-#define CPU_FTR_SUBCORE			LONG_ASM_CONST(0x2000000000000000)
 #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
 
 #ifndef __ASSEMBLY__
@@ -463,7 +462,7 @@ enum {
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
-	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_SUBCORE)
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
 #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
 #define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
 #define CPU_FTRS_POWER9 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 050925b5b451..d6f05e4dc328 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -642,7 +642,6 @@ static struct dt_cpu_feature_match __initdata
 	{"processor-control-facility", feat_enable_dbell, CPU_FTR_DBELL},
 	{"processor-control-facility-v3", feat_enable_dbell, CPU_FTR_DBELL},
 	{"processor-utilization-of-resources-register", feat_enable_purr, 0},
-	{"subcore", feat_enable, CPU_FTR_SUBCORE},
 	{"no-execute", feat_enable, 0},
 	{"strong-access-ordering", feat_enable, CPU_FTR_SAO},
 	{"cache-inhibited-large-page", feat_enable_large_ci, 0},
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 0babef11136f..8c6119280c13 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -407,7 +407,13 @@ static DEVICE_ATTR(subcores_per_core, 0644,
 
 static int subcore_init(void)
 {
-	if (!cpu_has_feature(CPU_FTR_SUBCORE))
+	unsigned pvr_ver;
+
+	pvr_ver = PVR_VER(mfspr(SPRN_PVR));
+
+	if (pvr_ver != PVR_POWER8 &&
+	    pvr_ver != PVR_POWER8E &&
+	    pvr_ver != PVR_POWER8NVL)
 		return 0;
 
 	/*
-- 
2.7.4
