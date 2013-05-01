Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc: Replace CPU_FTR_BCTAR with CPU_FTR_ARCH_207S
Date: Wed,  1 May 2013 16:17:02 +1000
Message-Id: <1367389024-20391-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1367389024-20391-1-git-send-email-mikey@neuling.org>
References: <1367389024-20391-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

We are getting low on cpu feature bits. So rather than add a separate bit for
every new Power8 feature, add a bit for arch 2.07 server catagory and use that
instead.

Hijack the value we had for BCTAR, but swap the value with CFAR so that all the
ARCH defines are together.

Note we don't touch CPU_FTR_TM, because it is conditionally enabled if
the kernel is built with TM support.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h |    8 ++++----
 arch/powerpc/kernel/entry_64.S      |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 284e50b..fcc54ad 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -152,7 +152,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_HVMODE			LONG_ASM_CONST(0x0000000100000000)
 #define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000200000000)
 #define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000400000000)
-#define CPU_FTR_CFAR			LONG_ASM_CONST(0x0000000800000000)
+#define CPU_FTR_ARCH_207S		LONG_ASM_CONST(0x0000000800000000)
 #define CPU_FTR_IABR			LONG_ASM_CONST(0x0000001000000000)
 #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000002000000000)
 #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000004000000000)
@@ -173,7 +173,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x0020000000000000)
 #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x0040000000000000)
 #define CPU_FTR_TM			LONG_ASM_CONST(0x0080000000000000)
-#define CPU_FTR_BCTAR			LONG_ASM_CONST(0x0100000000000000)
+#define CPU_FTR_CFAR			LONG_ASM_CONST(0x0100000000000000)
 #define	CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x0200000000000000)
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 
@@ -422,8 +422,8 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
-	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | CPU_FTR_BCTAR | \
-	    CPU_FTR_TM_COMP)
+	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 04d69c4..7a6801f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -458,7 +458,7 @@ BEGIN_FTR_SECTION
 	 */
 	mfspr	r0,SPRN_TAR
 	std	r0,THREAD_TAR(r3)
-END_FTR_SECTION_IFSET(CPU_FTR_BCTAR)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 #endif
 
 #ifdef CONFIG_SMP
@@ -547,7 +547,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 BEGIN_FTR_SECTION
 	ld	r0,THREAD_TAR(r4)
 	mtspr	SPRN_TAR,r0
-END_FTR_SECTION_IFSET(CPU_FTR_BCTAR)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 #endif
 
 #ifdef CONFIG_ALTIVEC
-- 
1.7.10.4
