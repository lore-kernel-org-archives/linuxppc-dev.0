Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQFX15nZXzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 16:19:45 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u596IskW000737
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 02:19:43 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9me9xrq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 02:19:43 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 9 Jun 2016 00:19:42 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 08/10] powerpc/mm: Clear top 16 bits of va only on
 older cpus
In-Reply-To: <1465395958-21349-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1465395958-21349-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 09 Jun 2016 11:49:15 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y46e995o.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> As per ISA, we need to do this only for architecture version 2.02 and
> earlier. This continued to work even for 2.07. But let's not do this for
> anything after 2.02
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu.h   | 12 +++++++++---
>  arch/powerpc/mm/hash_native_64.c |  6 ++++--
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index e53ebebff474..616575fcbcc7 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -24,6 +24,11 @@
>  /*
>   * This is individual features
>   */
> +/*
> + * We need to clear top 16bits of va (from the remaining 64 bits )in
> + * tlbie* instructions
> + */
> +#define MMU_FTR_TLBIE_CROP_VA		ASM_CONST(0x00008000)
>
>  /* Enable use of high BAT registers */
>  #define MMU_FTR_USE_HIGH_BATS		ASM_CONST(0x00010000)
> @@ -96,8 +101,9 @@
>  /* MMU feature bit sets for various CPUs */
>  #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
>  	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
> -#define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
> -#define MMU_FTRS_PPC970		MMU_FTRS_POWER4
> +#define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
> +				MMU_FTR_TLBIE_CROP_VA
> +#define MMU_FTRS_PPC970		MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA
>  #define MMU_FTRS_POWER5		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
>  #define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
>  #define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE


Updated patch below. MMU_FTRS_POWER4 is inherited by others, hence don't
update that.

>From 4ed66fd24dc4f976969cc34aca8df2ddbc69fe61 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sat, 4 Jun 2016 19:58:26 +0530
Subject: [PATCH] powerpc/mm: Clear top 16 bits of va only on older cpus

As per ISA, we need to do this only for architecture version 2.02 and
earlier. This continued to work even for 2.07. But let's not do this for
anything after 2.02

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu.h   |  7 ++++++-
 arch/powerpc/kernel/cputable.c   | 14 +++++++-------
 arch/powerpc/mm/hash_native_64.c |  6 ++++--
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e53ebebff474..fa314b1d667e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -24,6 +24,11 @@
 /*
  * This is individual features
  */
+/*
+ * We need to clear top 16bits of va (from the remaining 64 bits )in
+ * tlbie* instructions
+ */
+#define MMU_FTR_TLBIE_CROP_VA		ASM_CONST(0x00008000)
 
 /* Enable use of high BAT registers */
 #define MMU_FTR_USE_HIGH_BATS		ASM_CONST(0x00010000)
@@ -124,7 +129,7 @@ enum {
 		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
 		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
 		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
-		MMU_FTR_1T_SEGMENT |
+		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_RADIX |
 #endif
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index eeeacf6235a3..d8a0f7ca74e1 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -137,7 +137,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER4 (gp)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
-		.mmu_features		= MMU_FTRS_POWER4,
+		.mmu_features		= MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -152,7 +152,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER4+ (gq)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
-		.mmu_features		= MMU_FTRS_POWER4,
+		.mmu_features		= MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -168,7 +168,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTRS_PPC970,
+		.mmu_features		= MMU_FTRS_PPC970 | MMU_FTR_TLBIE_CROP_VA,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -186,7 +186,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTRS_PPC970,
+		.mmu_features		= MMU_FTRS_PPC970 | MMU_FTR_TLBIE_CROP_VA,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -204,7 +204,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTRS_PPC970,
+		.mmu_features		= MMU_FTRS_PPC970 | MMU_FTR_TLBIE_CROP_VA,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -222,7 +222,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTRS_PPC970,
+		.mmu_features		= MMU_FTRS_PPC970 | MMU_FTR_TLBIE_CROP_VA,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -240,7 +240,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTRS_PPC970,
+		.mmu_features		= MMU_FTRS_PPC970 | MMU_FTR_TLBIE_CROP_VA,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 80dd344726f3..4c6d4c736ba4 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -64,7 +64,8 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 	 * Older versions of the architecture (2.02 and earler) require the
 	 * masking of the top 16 bits.
 	 */
-	va &= ~(0xffffULL << 48);
+	if (mmu_has_feature(MMU_FTR_TLBIE_CROP_VA))
+		va &= ~(0xffffULL << 48);
 
 	switch (psize) {
 	case MMU_PAGE_4K:
@@ -113,7 +114,8 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 	 * Older versions of the architecture (2.02 and earler) require the
 	 * masking of the top 16 bits.
 	 */
-	va &= ~(0xffffULL << 48);
+	if (mmu_has_feature(MMU_FTR_TLBIE_CROP_VA))
+		va &= ~(0xffffULL << 48);
 
 	switch (psize) {
 	case MMU_PAGE_4K:
-- 
2.7.4
