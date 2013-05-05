Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A8E02C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 May 2013 12:01:30 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Sat, 4 May 2013 22:01:25 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id CFC3AC9001A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 22:01:22 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4521Nrd43778090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 22:01:23 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4521Mxd009936
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 23:01:22 -0300
Date: Sat, 4 May 2013 19:01:17 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: [PATCH v3 3/4] powerpc/cputable: advertise ISEL support on
 appropriate embedded processors
Message-ID: <20130505020117.GE3532@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <2889.1367625894@ale.ozlabs.ibm.com>
 <20130504004756.GA3532@linux.vnet.ibm.com>
 <20130504004838.GB3532@linux.vnet.ibm.com>
 <20130504004912.GC3532@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130504004912.GC3532@linux.vnet.ibm.com>
Cc: Peter Bergner <bergner@us.ibm.com>, Ryan Arnold <ryanarn@us.ibm.com>,
 Michael R Meissner <mrmeissn@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Steve Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---
Changes since v2:
 - Added e5500 per Segher.

I've not added POWER7 yet, as I'm waiting to confirm with others on
that. I will send it as a follow-up patch if needed.

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index a792157..f724bca 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1999,6 +1999,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_SPE_COMP |
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP,
+		.cpu_user_features2	= PPC_FEATURE2_ISEL,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -2018,6 +2019,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 			PPC_FEATURE_HAS_SPE_COMP |
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP |
 			PPC_FEATURE_HAS_EFP_DOUBLE_COMP,
+		.cpu_user_features2	= PPC_FEATURE2_ISEL,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -2034,6 +2036,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "e500mc",
 		.cpu_features		= CPU_FTRS_E500MC,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.cpu_user_features2	= PPC_FEATURE2_ISEL,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
 			MMU_FTR_USE_TLBILX,
 		.icache_bsize		= 64,
@@ -2052,6 +2055,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "e5500",
 		.cpu_features		= CPU_FTRS_E5500,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.cpu_user_features2	= PPC_FEATURE2_ISEL,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
 			MMU_FTR_USE_TLBILX,
 		.icache_bsize		= 64,
@@ -2073,6 +2077,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_E6500,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features2	= PPC_FEATURE2_ISEL,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
 			MMU_FTR_USE_TLBILX,
 		.icache_bsize		= 64,
