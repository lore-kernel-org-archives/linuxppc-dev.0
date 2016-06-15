Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTvWT4hPjzDqh9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 15:01:57 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c74so889758pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 22:01:57 -0700 (PDT)
Subject: [V2][PATCH] New MMU feature for new hpte format in ISA3
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <f57f41e9-487d-0d64-0ef3-141a2aabac8f@gmail.com>
 <87shwfaf3i.fsf@skywalker.in.ibm.com>
 <CAKTCnz=q5ubKytJ=_hObzQ58taVdCCKYSp6mFU7mcB4Ty-ttJg@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <20a3b6f5-ba76-81e0-ef94-e6d10798679b@gmail.com>
Date: Wed, 15 Jun 2016 15:01:47 +1000
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=q5ubKytJ=_hObzQ58taVdCCKYSp6mFU7mcB4Ty-ttJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/06/16 10:38, Balbir Singh wrote:
> 
> Thanks for a review, I'll do a V2 with some changes
> 
> Balbir
>

Michael, please review and check if you like the #ifdef,
since we are crossing the 32 bit boundary, I've used a
conditional define to select the feature.
 
Changelog v2:
	The new feature name is MMU_FTR_ISA3_HASH_SUPPORT
	Fix build breakage

Commit 50de596de introduced support for the new PTE
format in the functions hpte_encode_r and hpte_encode_avpn.
This patch abstracts the change under
MMU_FTR_ISA3_HASH_SUPPORT. This bit is provided by the
ibm,pa-feature mechanism with the hypervisor for guests
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
 arch/powerpc/include/asm/mmu.h                | 13 ++++++++++++-
 arch/powerpc/kernel/prom.c                    |  1 +
 arch/powerpc/kernel/setup_64.c                |  2 +-
 5 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 290157e..70e5c8f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -229,7 +229,7 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
 	 */
 	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
 	v <<= HPTE_V_AVPN_SHIFT;
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+	if (!mmu_has_feature(MMU_FTR_ISA3_HASH_SUPPORT))
 		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
 }
@@ -256,8 +256,7 @@ static inline unsigned long hpte_encode_v(unsigned long vpn, int base_psize,
 static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
 					  int actual_psize, int ssize)
 {
-
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (mmu_has_feature(MMU_FTR_ISA3_HASH_SUPPORT))
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
index e53ebeb..bd177f8 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -92,6 +92,14 @@
  * Radix page table available
  */
 #define MMU_FTR_RADIX			ASM_CONST(0x80000000)
+/*
+ * Support of new PTE format as defined in ISA 3.0
+ */
+#ifdef CONFIG_PPC_STD_MMU_64
+#define MMU_FTR_ISA3_HASH_SUPPORT	ASM_CONST(0x100000000)
+#else
+#define MMU_FTR_ISA3_HASH_SUPPORT	ASM_CONST(0x0)
+#endif
 
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
@@ -128,10 +136,13 @@ enum {
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_RADIX |
 #endif
+#ifdef CONFIG_PPC_STD_MMU_64
+		MMU_FTR_ISA3_HASH_SUPPORT |
+#endif
 		0,
 };
 
-static inline int mmu_has_feature(unsigned long feature)
+static inline unsigned long mmu_has_feature(unsigned long feature)
 {
 	return (MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
 }
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 946e34f..b6cc23f 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -169,6 +169,7 @@ static struct ibm_pa_feature {
 	{CPU_FTR_TM_COMP, 0, 0,
 	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
 	{0, MMU_FTR_RADIX, 0, 0,		40, 0, 0},
+	{0, MMU_FTR_ISA3_HASH_SUPPORT, 0, 0,	58, 0, 0},
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
