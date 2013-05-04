Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F3B3B2C010E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 10:48:48 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 3 May 2013 20:48:46 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2162138C8045
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 20:48:44 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r440mhp3315230
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 20:48:44 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r440mhx7002748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 18:48:43 -0600
Date: Fri, 3 May 2013 17:48:38 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 2/4] powerpc/cputable: advertise DSCR support on P7/P7+
Message-ID: <20130504004838.GB3532@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <2889.1367625894@ale.ozlabs.ibm.com>
 <20130504004756.GA3532@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130504004756.GA3532@linux.vnet.ibm.com>
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
index ae9f433..a792157 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -98,6 +98,7 @@ extern void __restore_cpu_e6500(void);
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
+#define COMMON_USER2_POWER7	(PPC_FEATURE2_DSCR)
 #define COMMON_USER_POWER8	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
 				 PPC_FEATURE_TRUE_LE | \
@@ -428,6 +429,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER7 (architected)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
+		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
@@ -458,6 +460,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER7 (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
+		.cpu_user_features2	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
@@ -475,6 +478,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER7+ (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
+		.cpu_user_features	= COMMON_USER2_POWER7,
 		.mmu_features		= MMU_FTRS_POWER7,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
