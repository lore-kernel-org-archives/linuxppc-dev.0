Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 808932C0206
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 10:49:24 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 3 May 2013 20:49:21 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CF2E738C8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 20:49:17 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r440nH8l277216
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 20:49:17 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r440nG5S013256
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 18:49:17 -0600
Date: Fri, 3 May 2013 17:49:12 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 3/4] powerpc/cputable: advertise ISEL support on
 appropriate embedded processors
Message-ID: <20130504004912.GC3532@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <2889.1367625894@ale.ozlabs.ibm.com>
 <20130504004756.GA3532@linux.vnet.ibm.com>
 <20130504004838.GB3532@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130504004838.GB3532@linux.vnet.ibm.com>
Cc: Michael R Meissner <mrmeissn@us.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Ryan Arnold <ryanarn@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index a792157..b224cd5 100644
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
@@ -2073,6 +2076,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_E6500,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.cpu_user_features2	= PPC_FEATURE2_ISEL,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
 			MMU_FTR_USE_TLBILX,
 		.icache_bsize		= 64,
