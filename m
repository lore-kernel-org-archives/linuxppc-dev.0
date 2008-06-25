Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 25 Jun 2008 14:07:18 +1000
Subject: [PATCH 6/9] powerpc: Add VSX CPU feature
In-Reply-To: <1214366837.623950.515350956858.qpush@coopers>
Message-Id: <20080625040718.21E4B7029B@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a VSX CPU feature.  Also add code to detect if VSX is available
from the device tree.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

---

 arch/powerpc/kernel/prom.c     |    4 ++++
 include/asm-powerpc/cputable.h |   15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/prom.c
@@ -609,6 +609,10 @@ static struct feature_property {
 	{"altivec", 0, CPU_FTR_ALTIVEC, PPC_FEATURE_HAS_ALTIVEC},
 	{"ibm,vmx", 1, CPU_FTR_ALTIVEC, PPC_FEATURE_HAS_ALTIVEC},
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_VSX
+	/* Yes, this _really_ is ibm,vmx == 2 to enable VSX */
+	{"ibm,vmx", 2, CPU_FTR_VSX, PPC_FEATURE_HAS_VSX},
+#endif /* CONFIG_VSX */
 #ifdef CONFIG_PPC64
 	{"ibm,dfp", 1, 0, PPC_FEATURE_HAS_DFP},
 	{"ibm,purr", 1, CPU_FTR_PURR, 0},
Index: linux-2.6-ozlabs/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/cputable.h
+++ linux-2.6-ozlabs/include/asm-powerpc/cputable.h
@@ -27,6 +27,7 @@
 #define PPC_FEATURE_HAS_DFP		0x00000400
 #define PPC_FEATURE_POWER6_EXT		0x00000200
 #define PPC_FEATURE_ARCH_2_06		0x00000100
+#define PPC_FEATURE_HAS_VSX		0x00000080
 
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
@@ -181,6 +182,7 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
 #define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
 #define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
+#define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -199,6 +201,17 @@ extern void do_feature_fixups(unsigned l
 #define PPC_FEATURE_HAS_ALTIVEC_COMP    0
 #endif
 
+/* We only set the VSX features if the kernel was compiled with VSX
+ * support
+ */
+#ifdef CONFIG_VSX
+#define CPU_FTR_VSX_COMP	CPU_FTR_VSX
+#define PPC_FEATURE_HAS_VSX_COMP PPC_FEATURE_HAS_VSX
+#else
+#define CPU_FTR_VSX_COMP	0
+#define PPC_FEATURE_HAS_VSX_COMP    0
+#endif
+
 /* We only set the spe features if the kernel was compiled with spe
  * support
  */
@@ -399,7 +412,7 @@ extern void do_feature_fixups(unsigned l
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
 	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
-	    CPU_FTR_1T_SEGMENT)
+	    CPU_FTR_1T_SEGMENT | CPU_FTR_VSX)
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
