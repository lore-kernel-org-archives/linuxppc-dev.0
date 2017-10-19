Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHb515x7NzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:08:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/64: Free up CPU_FTR_ICSWX
Date: Thu, 19 Oct 2017 15:08:19 +1100
Message-Id: <1508386099-2126-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The last user of CPU_FTR_ICSWX was removed in commit
6ff4d3e96652 ("powerpc: Remove old unused icswx based coprocessor
support"), so free the bit up for future use.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h | 6 +++---
 arch/powerpc/kernel/dt_cpu_ftrs.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a9bf921f4efc..e188dd57bf51 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -206,7 +206,7 @@ enum {
 #define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0004000000000000)
 #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0008000000000000)
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0010000000000000)
-#define CPU_FTR_ICSWX			LONG_ASM_CONST(0x0020000000000000)
+/* Free					LONG_ASM_CONST(0x0020000000000000) */
 #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x0040000000000000)
 #define CPU_FTR_TM			LONG_ASM_CONST(0x0080000000000000)
 #define CPU_FTR_CFAR			LONG_ASM_CONST(0x0100000000000000)
@@ -451,7 +451,7 @@ enum {
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | \
+	    CPU_FTR_CFAR | CPU_FTR_HVMODE | \
 	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR | CPU_FTR_DABRX)
 #define CPU_FTRS_POWER8 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
@@ -460,7 +460,7 @@ enum {
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
+	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
 #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 7275fed271af..36afefa68720 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -634,7 +634,7 @@ static struct dt_cpu_feature_match __initdata
 	{"no-execute", feat_enable, 0},
 	{"strong-access-ordering", feat_enable, CPU_FTR_SAO},
 	{"cache-inhibited-large-page", feat_enable_large_ci, 0},
-	{"coprocessor-icswx", feat_enable, CPU_FTR_ICSWX},
+	{"coprocessor-icswx", feat_enable, 0},
 	{"hypervisor-virtualization-interrupt", feat_enable_hvi, 0},
 	{"program-priority-register", feat_enable, CPU_FTR_HAS_PPR},
 	{"wait", feat_enable, 0},
-- 
2.7.4
