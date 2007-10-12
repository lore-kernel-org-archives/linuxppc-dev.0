Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 054E3DE062
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 16:44:15 +1000 (EST)
Date: Fri, 12 Oct 2007 01:49:42 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: Add 1TB workaround for PA6T
Message-ID: <20071012064942.GB30829@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 09da90b..c78dc91 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -212,6 +212,7 @@ static int __init htab_dt_scan_seg_sizes(unsigned long node,
 			return 1;
 		}
 	}
+	cur_cpu_spec->cpu_features &= ~CPU_FTR_NO_SLBIE_B;
 	return 0;
 }
 
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 6c164ce..bbd2c51 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -157,7 +157,8 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	unsigned long stack = KSTK_ESP(tsk);
 	unsigned long unmapped_base;
 
-	if (offset <= SLB_CACHE_ENTRIES) {
+	if (!cpu_has_feature(CPU_FTR_NO_SLBIE_B) &&
+	    offset <= SLB_CACHE_ENTRIES) {
 		int i;
 		asm volatile("isync" : : : "memory");
 		for (i = 0; i < offset; i++) {
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index ae093ef..2ca0633 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -165,6 +165,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTR_SPURR			LONG_ASM_CONST(0x0001000000000000)
 #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
 #define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
+#define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -367,7 +368,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTRS_PA6T (CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
-	    CPU_FTR_PURR | CPU_FTR_REAL_LE)
+	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_NO_SLBIE_B)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 
@@ -375,7 +376,8 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
-	    CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_1T_SEGMENT)
+	    CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_1T_SEGMENT |	\
+	    CPU_FTR_NO_SLBIE_B)
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
