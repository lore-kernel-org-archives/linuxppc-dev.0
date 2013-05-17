Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/hw_breakpoints: Add DABRX cpu feature
In-reply-to: <30348.1368764834@ale.ozlabs.ibm.com>
References: <3F431E22-B7A9-4FCF-B34F-DC171A643E05@jpl.nasa.gov>
 <30348.1368764834@ale.ozlabs.ibm.com>
Date: Fri, 17 May 2013 16:27:31 +1000
Message-ID: <9649.1368772051@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, "Gorelik,
 Jacob \(335F\)" <jacob.gorelik@jpl.nasa.gov>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some CPUs have a DABR but not DABRX.  Configuration are:
- No 32bit CPUs have DABRX but some have DABR.
- POWER4+ and below have the DABR but no DABRX.
- 970 and POWER5 and above have DABR and DABRX.
- POWER8 has DAWR, hence no DABRX.

This introduces CPU_FTR_DABRX and sets it on appropriate CPUs.  We use
the top 64 bits for CPU FTR bits since only 64 bit CPUs have this.

Processors that don't have the DABRX will still work as they will fall
back to software filtering these breakpoints via perf_exclude_event().

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reported-by: "Gorelik, Jacob (335F)" <jacob.gorelik@jpl.nasa.gov>
cc: stable@vger.kernel.org (v3.9 only)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 26807e5..6f3887d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -176,6 +176,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_CFAR			LONG_ASM_CONST(0x0100000000000000)
 #define	CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x0200000000000000)
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
+#define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -394,19 +395,20 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_201 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA | \
 	    CPU_FTR_CP_USE_DCBTZ | CPU_FTR_STCX_CHECKS_ADDRESS | \
-	    CPU_FTR_HVMODE)
+	    CPU_FTR_HVMODE | CPU_FTR_DABRX)
 #define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_PURR | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_DABRX)
 #define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_CFAR)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_CFAR | \
+	    CPU_FTR_DABRX)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -415,7 +417,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | \
-	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR)
+	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR | CPU_FTR_DABRX)
 #define CPU_FTRS_POWER8 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -430,14 +432,15 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_PAUSE_ZERO  | CPU_FTR_CELL_TB_BUG | CPU_FTR_CP_USE_DCBTZ | \
-	    CPU_FTR_UNALIGNED_LD_STD)
+	    CPU_FTR_UNALIGNED_LD_STD | CPU_FTR_DABRX)
 #define CPU_FTRS_PA6T (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_PURR | CPU_FTR_REAL_LE)
+	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_DABRX)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2)
 
 #define CPU_FTRS_A2 (CPU_FTR_USE_TB | CPU_FTR_SMT | CPU_FTR_DBELL | \
-		     CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN | CPU_FTR_ICSWX)
+		     CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN | \
+		     CPU_FTR_ICSWX | CPU_FTR_DABRX )
 
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_BOOK3E
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a902723..b0f3e3f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -399,7 +399,8 @@ static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
 static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
 {
 	mtspr(SPRN_DABR, dabr);
-	mtspr(SPRN_DABRX, dabrx);
+	if (cpu_has_feature(CPU_FTR_DABRX))
+		mtspr(SPRN_DABRX, dabrx);
 	return 0;
 }
 #else
