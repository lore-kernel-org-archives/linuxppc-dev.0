Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 21F1CDE85C
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:53:03 +1000 (EST)
Date: Mon, 15 Oct 2007 09:58:59 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH v2] powerpc: Add 1TB workaround for PA6T
Message-ID: <20071015145859.GA14297@lixom.net>
References: <20071012064942.GB30829@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071012064942.GB30829@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PA6T has a bug where the slbie instruction does not honor the large
segment bit. As a result, we have to always use slbia when switching
context.

We don't have to worry about changing the slbie's during fault processing,
since they should never be replacing one VSID with another using the
same ESID. I.e. there's no risk for inserting duplicate entries due to a
failed slbie of the old entry. So as long as we clear it out on context
switch we should be fine.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: k.org/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- k.org.orig/arch/powerpc/mm/hash_utils_64.c
+++ k.org/arch/powerpc/mm/hash_utils_64.c
@@ -212,6 +212,7 @@ static int __init htab_dt_scan_seg_sizes
 			return 1;
 		}
 	}
+	cur_cpu_spec->cpu_features &= ~CPU_FTR_NO_SLBIE_B;
 	return 0;
 }
 
Index: k.org/arch/powerpc/mm/slb.c
===================================================================
--- k.org.orig/arch/powerpc/mm/slb.c
+++ k.org/arch/powerpc/mm/slb.c
@@ -157,7 +157,8 @@ void switch_slb(struct task_struct *tsk,
 	unsigned long stack = KSTK_ESP(tsk);
 	unsigned long unmapped_base;
 
-	if (offset <= SLB_CACHE_ENTRIES) {
+	if (!cpu_has_feature(CPU_FTR_NO_SLBIE_B) &&
+	    offset <= SLB_CACHE_ENTRIES) {
 		int i;
 		asm volatile("isync" : : : "memory");
 		for (i = 0; i < offset; i++) {
Index: k.org/include/asm-powerpc/cputable.h
===================================================================
--- k.org.orig/include/asm-powerpc/cputable.h
+++ k.org/include/asm-powerpc/cputable.h
@@ -165,6 +165,7 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTR_SPURR			LONG_ASM_CONST(0x0001000000000000)
 #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
 #define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
+#define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -367,7 +368,7 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTRS_PA6T (CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
-	    CPU_FTR_PURR | CPU_FTR_REAL_LE)
+	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_NO_SLBIE_B)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 
Index: k.org/arch/powerpc/kernel/entry_64.S
===================================================================
--- k.org.orig/arch/powerpc/kernel/entry_64.S
+++ k.org/arch/powerpc/kernel/entry_64.S
@@ -408,6 +408,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT
 	std	r7,SLBSHADOW_STACKVSID(r9)  /* Save VSID */
 	std	r0,SLBSHADOW_STACKESID(r9)  /* Save ESID */
 
+	/* No need to check for CPU_FTR_NO_SLBIE_B here, since when
+	 * we have 1TB segments, the only CPUs known to have the errata
+	 * only support less than 1TB of system memory and we'll never
+	 * actually hit this code path.
+	 */
+
 	slbie	r6
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
 	slbmte	r7,r0
