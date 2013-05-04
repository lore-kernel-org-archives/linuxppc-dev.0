Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 965282C010E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 10:50:12 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 3 May 2013 18:50:10 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 22A313E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 18:49:52 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r440o6FH315556
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 18:50:06 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r440o4xY005946
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 18:50:06 -0600
Date: Fri, 3 May 2013 17:49:59 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 4/4] powerpc/cputable: advertise support for
 ISEL/HTM/DSCR/TAR on POWER8
Message-ID: <20130504004959.GD3532@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <2889.1367625894@ale.ozlabs.ibm.com>
 <20130504004756.GA3532@linux.vnet.ibm.com>
 <20130504004838.GB3532@linux.vnet.ibm.com>
 <20130504004912.GC3532@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130504004912.GC3532@linux.vnet.ibm.com>
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

---
Changes since v1:
 - Add TAR.
 - Use config dependent symbol for HTM.

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b224cd5..79cde71 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -103,6 +103,9 @@ extern void __restore_cpu_e6500(void);
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
+#define COMMON_USER2_POWER8	(PPC_FEATURE2_ARCH_2_07 | \
+				 PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_DSCR | \
+				 PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR)
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
@@ -445,6 +448,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER8 (architected)",
 		.cpu_features		= CPU_FTRS_POWER8,
 		.cpu_user_features	= COMMON_USER_POWER8,
+		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
@@ -496,6 +500,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER8 (raw)",
 		.cpu_features		= CPU_FTRS_POWER8,
 		.cpu_user_features	= COMMON_USER_POWER8,
+		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
