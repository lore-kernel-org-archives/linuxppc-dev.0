Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4d601PNjzDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 23:59:36 +1000 (AEST)
Message-ID: <1462975169.12821.2.camel@ellerman.id.au>
Subject: Rebase of powerpc#next
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Scott Wood
 <oss@buserror.net>, Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 11 May 2016 23:59:29 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks,

I introduced a fairly nasty bug into the recently merged Radix series.

It means a kernel built with RADIX=n crashes on boot on Hash MMU machines.

So I'm going to rebase powerpc#next to squash in a fix.

Hope that doesn't screw up anyone's work.

For reference the diff from old to new is below.

cheers



diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index d91dc886c90f..e53ebebff474 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -91,11 +91,7 @@
 /*
  * Radix page table available
  */
-#ifdef CONFIG_PPC_RADIX_MMU
-#define MMU_FTR_RADIX                  ASM_CONST(0x80000000)
-#else
-#define MMU_FTR_RADIX                  ASM_CONST(0)
-#endif
+#define MMU_FTR_RADIX			ASM_CONST(0x80000000)
 
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
@@ -119,9 +115,25 @@
 DECLARE_PER_CPU(int, next_tlbcam_idx);
 #endif
 
+enum {
+	MMU_FTRS_POSSIBLE = MMU_FTR_HPTE_TABLE | MMU_FTR_TYPE_8xx |
+		MMU_FTR_TYPE_40x | MMU_FTR_TYPE_44x | MMU_FTR_TYPE_FSL_E |
+		MMU_FTR_TYPE_47x | MMU_FTR_USE_HIGH_BATS | MMU_FTR_BIG_PHYS |
+		MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_USE_TLBILX |
+		MMU_FTR_LOCK_BCAST_INVAL | MMU_FTR_NEED_DTLB_SW_LRU |
+		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
+		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
+		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
+		MMU_FTR_1T_SEGMENT |
+#ifdef CONFIG_PPC_RADIX_MMU
+		MMU_FTR_RADIX |
+#endif
+		0,
+};
+
 static inline int mmu_has_feature(unsigned long feature)
 {
-	return (cur_cpu_spec->mmu_features & feature);
+	return (MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
 }
 
 static inline void mmu_clear_feature(unsigned long feature)
