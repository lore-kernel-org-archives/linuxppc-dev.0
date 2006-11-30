Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 96F6B67B9B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2006 11:46:26 +1100 (EST)
Date: Thu, 30 Nov 2006 11:46:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] fix cputable.h for combined build
Message-Id: <20061130114622.b05d9b30.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove CPU_FTR_16M_PAGE from the cupfeatures mask at runtime on iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/hash_utils_64.c        |    2 +-
 arch/powerpc/platforms/iseries/setup.c |    2 ++
 include/asm-powerpc/cputable.h         |   13 +++----------
 3 files changed, 6 insertions(+), 11 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 1915661..c0d2a69 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -277,7 +277,7 @@ static void __init htab_init_page_sizes(void)
 	 * Not in the device-tree, let's fallback on known size
 	 * list for 16M capable GP & GR
 	 */
-	if (cpu_has_feature(CPU_FTR_16M_PAGE) && !machine_is(iseries))
+	if (cpu_has_feature(CPU_FTR_16M_PAGE))
 		memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
 		       sizeof(mmu_psize_defaults_gp));
  found:
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 1796644..bdf2afb 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -643,6 +643,8 @@ static int __init iseries_probe(void)
 		return 0;
 
 	hpte_init_iSeries();
+	/* iSeries does not support 16M pages */
+	cur_cpu_spec->cpu_features &= ~CPU_FTR_16M_PAGE;
 
 	return 1;
 }
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 354f66d..6fe5c9d 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -155,16 +155,9 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 
 #ifndef __ASSEMBLY__
 
-#define CPU_FTR_PPCAS_ARCH_V2_BASE (CPU_FTR_SLB | \
-					CPU_FTR_TLBIEL | CPU_FTR_NOEXECUTE | \
-					CPU_FTR_NODSISRALIGN)
-
-/* iSeries doesn't support large pages */
-#ifdef CONFIG_PPC_ISERIES
-#define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_PPCAS_ARCH_V2_BASE)
-#else
-#define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_PPCAS_ARCH_V2_BASE | CPU_FTR_16M_PAGE)
-#endif /* CONFIG_PPC_ISERIES */
+#define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_SLB | \
+				 CPU_FTR_TLBIEL | CPU_FTR_NOEXECUTE | \
+				 CPU_FTR_NODSISRALIGN | CPU_FTR_16M_PAGE)
 
 /* We only set the altivec features if the kernel was compiled with altivec
  * support
-- 
1.4.4.1
