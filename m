Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTZ6c45ngzDqdt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 01:57:44 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 66so11321882pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 08:57:44 -0700 (PDT)
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] New MMU feature for new hpte format in ISA3
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f57f41e9-487d-0d64-0ef3-141a2aabac8f@gmail.com>
Date: Wed, 15 Jun 2016 01:57:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch has been lightly tested and needs testing
on additional platforms and different page sizes, largely
due to the mmu_features changes noted below

Commit 50de596de introduced support for the new PTE
format in the functions hpte_encode_r and hpte_encode_avpn.
This patch abstracts the change under
MMU_FTR_ISA3_HPTE_FORMAT. This bit is provided by the
ibm,pa-feature mechanism; hypervisor for guests
and via firmware for powernv.

The patch has a larger impact as the new feature bit
changes the definition of mmu_features from unsigned int
to unsigned long and also changes the print in setup_64.c
of the same feature.

This patch needs complementary changes to the
ibm,client-architecture in arch/powerpc/kernel/prom_init.c.
This is noted as a TODO

Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  5 ++---
 arch/powerpc/include/asm/cputable.h           |  2 +-
 arch/powerpc/include/asm/mmu.h                | 11 ++++++++++-
 arch/powerpc/kernel/prom.c                    |  1 +
 arch/powerpc/kernel/setup_64.c                |  2 +-
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 290157e..373f765 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -229,7 +229,7 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
 	 */
 	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
 	v <<= HPTE_V_AVPN_SHIFT;
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+	if (!mmu_has_feature(MMU_FTR_ISA3_HPTE_FORMAT))
 		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
 }
@@ -256,8 +256,7 @@ static inline unsigned long hpte_encode_v(unsigned long vpn, int base_psize,
 static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
 					  int actual_psize, int ssize)
 {
-
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (mmu_has_feature(MMU_FTR_ISA3_HPTE_FORMAT))
 		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
 
 	/* A 4K page needs no special encoding */
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index df4fb5f..469c9be 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -58,7 +58,7 @@ struct cpu_spec {
 	unsigned long	cpu_features;		/* Kernel features */
 	unsigned int	cpu_user_features;	/* Userland features */
 	unsigned int	cpu_user_features2;	/* Userland features v2 */
-	unsigned int	mmu_features;		/* MMU features */
+	unsigned long	mmu_features;		/* MMU features */
 
 	/* cache line sizes */
 	unsigned int	icache_bsize;
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e53ebeb..e121db1 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -92,6 +92,12 @@
  * Radix page table available
  */
 #define MMU_FTR_RADIX			ASM_CONST(0x80000000)
+/*
+ * Support of new PTE format as defined in ISA 3.0
+ */
+#ifdef CONFIG_PPC_STD_MMU_64
+#define MMU_FTR_ISA3_HPTE_FORMAT	ASM_CONST(0x100000000)
+#endif
 
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
@@ -128,10 +134,13 @@ enum {
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_RADIX |
 #endif
+#ifdef CONFIG_PPC_STD_MMU_64
+		MMU_FTR_ISA3_HPTE_FORMAT |
+#endif
 		0,
 };
 
-static inline int mmu_has_feature(unsigned long feature)
+static inline unsigned long mmu_has_feature(unsigned long feature)
 {
 	return (MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
 }
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 946e34f..f9cb4a9 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -169,6 +169,7 @@ static struct ibm_pa_feature {
 	{CPU_FTR_TM_COMP, 0, 0,
 	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
 	{0, MMU_FTR_RADIX, 0, 0,		40, 0, 0},
+	{0, MMU_FTR_ISA3_HPTE_FORMAT, 0, 0,	58, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 96d4a2b..2e15490 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -561,7 +561,7 @@ void __init setup_system(void)
 	pr_info("  always          = 0x%016lx\n", CPU_FTRS_ALWAYS);
 	pr_info("cpu_user_features = 0x%08x 0x%08x\n", cur_cpu_spec->cpu_user_features,
 		cur_cpu_spec->cpu_user_features2);
-	pr_info("mmu_features      = 0x%08x\n", cur_cpu_spec->mmu_features);
+	pr_info("mmu_features      = 0x%016lx\n", cur_cpu_spec->mmu_features);
 	pr_info("firmware_features = 0x%016lx\n", powerpc_firmware_features);
 
 #ifdef CONFIG_PPC_STD_MMU_64
-- 
2.5.5
