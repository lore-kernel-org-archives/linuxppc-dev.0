Subject: Re: Caching in the MPC107, linux 2.6
From: Adrian Cox <adrian@humboldt.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040313170708.GA20738@smtp.west.cox.net>
References: <1079088369.691.43.camel@newt>
	 <20040313170708.GA20738@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1079380996.1677.2.camel@newt>
Mime-Version: 1.0
Date: Mon, 15 Mar 2004 20:03:16 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2004-03-13 at 17:07, Tom Rini wrote:

> Instead do:
> BEGIN_FTR_SECTION
> 	ori	r8,r8,_PAGE_COHERENT
> END_FTR_SECTION_IFSET(CPU_FTR_745X_MPC107)
>
> And have the code that sets SPEC7450 also check for an MPC107.

Something like this?


diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Mon Mar 15 19:59:58 2004
+++ b/arch/ppc/Kconfig	Mon Mar 15 19:59:58 2004
@@ -627,9 +627,13 @@
 	depends on 6xx && (LOPEC || SANDPOINT)
 	default y

+config MPC10X_BRIDGE
+        bool
+	depends on FORCE || SANDPOINT
+
 config MPC10X_STORE_GATHERING
 	bool "Enable MPC10x store gathering"
-	depends on FORCE || SANDPOINT
+	depends on MPC10X_BRIDGE

 config CPC710_DATA_GATHERING
 	bool "Enable CPC710 data gathering"
diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	Mon Mar 15 19:59:58 2004
+++ b/arch/ppc/kernel/cputable.c	Mon Mar 15 19:59:58 2004
@@ -53,6 +53,12 @@
 #define PPC_FEATURE_ALTIVEC_COMP       	0
 #endif

+#ifdef CONFIG_MPC10X_BRIDGE
+#define CPU_FTR_745X_MPC107_COMP        CPU_FTR_745X_MPC107
+#else
+#define CPU_FTR_745X_MPC107_COMP        0
+#endif
+
 struct cpu_spec	cpu_specs[] = {
 #if CLASSIC_PPC
     { 	/* 601 */
@@ -225,7 +231,8 @@
     	0xffffffff, 0x80000200, "7450",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+        CPU_FTR_745X_MPC107_COMP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -235,7 +242,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP,
+	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_745X_MPC107_COMP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -244,7 +251,8 @@
     	0xffff0000, 0x80000000, "7450",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+        CPU_FTR_745X_MPC107_COMP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -253,7 +261,8 @@
     	0xffffff00, 0x80010100, "7455",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
-	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS |
+        CPU_FTR_745X_MPC107_COMP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -263,7 +272,8 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_HAS_HIGH_BATS |
+        CPU_FTR_745X_MPC107_COMP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -273,7 +283,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_745X_MPC107_COMP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
@@ -283,7 +293,7 @@
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-	CPU_FTR_HAS_HIGH_BATS,
+	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_745X_MPC107_COMP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
 	__setup_cpu_745x
diff -Nru a/arch/ppc/mm/hashtable.S b/arch/ppc/mm/hashtable.S
--- a/arch/ppc/mm/hashtable.S	Mon Mar 15 19:59:58 2004
+++ b/arch/ppc/mm/hashtable.S	Mon Mar 15 19:59:58 2004
@@ -346,8 +346,12 @@
 	rlwimi	r5,r5,32-2,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r8,r8,0xe14		/* clear out reserved bits and M */
 	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
-#ifdef CONFIG_SMP
+#ifndef CONFIG_SMP
+BEGIN_FTR_SECTION
+#endif
 	ori	r8,r8,_PAGE_COHERENT	/* set M (coherence required) */
+#ifndef CONFIG_SMP
+END_FTR_SECTION_IFSET(CPU_FTR_745X_MPC107)
 #endif

 	/* Construct the high word of the PPC-style PTE (r5) */
diff -Nru a/arch/ppc/mm/ppc_mmu.c b/arch/ppc/mm/ppc_mmu.c
--- a/arch/ppc/mm/ppc_mmu.c	Mon Mar 15 19:59:58 2004
+++ b/arch/ppc/mm/ppc_mmu.c	Mon Mar 15 19:59:58 2004
@@ -137,10 +137,12 @@
 	int wimgxpp;
 	union ubat *bat = BATS[index];

-#ifdef CONFIG_SMP
 	if ((flags & _PAGE_NO_CACHE) == 0)
-		flags |= _PAGE_COHERENT;
+#ifndef CONFIG_SMP
+                if (cur_cpu_spec[0]->cpu_features & CPU_FTR_SPEC7450)
 #endif
+		        flags |= _PAGE_COHERENT;
+
 	bl = (size >> 17) - 1;
 	if (PVR_VER(mfspr(PVR)) != 1) {
 		/* 603, 604, etc. */
diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- a/include/asm-ppc/cputable.h	Mon Mar 15 19:59:58 2004
+++ b/include/asm-ppc/cputable.h	Mon Mar 15 19:59:58 2004
@@ -75,6 +75,7 @@
 #define CPU_FTR_DUAL_PLL_750FX		0x00004000
 #define CPU_FTR_NO_DPM			0x00008000
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
+#define CPU_FTR_745X_MPC107             0x00020000

 #ifdef __ASSEMBLY__


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
