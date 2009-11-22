Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id B44331008D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:15 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 15/19] powerpc: broadway processor support
Date: Sun, 22 Nov 2009 23:01:46 +0100
Message-Id: <1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch extends the cputable entry of the 750CL to also match
the 750CL-based "Broadway" cpu found on the Nintendo Wii.

As of this patch, the following "Broadway" design revision levels have
been seen in the wild:
- DD1.2 (87102)
- DD2.0 (87200)

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/kernel/cputable.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 03c862b..85841e8 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -697,13 +697,13 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
-	{	/* 750CL */
-		.pvr_mask		= 0xfffff0f0,
-		.pvr_value		= 0x00087010,
-		.cpu_name		= "750CL",
-		.cpu_features		= CPU_FTRS_750CL,
+	{	/* 745/755 */
+		.pvr_mask		= 0xfffff000,
+		.pvr_value		= 0x00083000,
+		.cpu_name		= "745/755",
+		.cpu_features		= CPU_FTRS_750,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
-		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
+		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -711,16 +711,14 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
-		.oprofile_cpu_type      = "ppc/750",
-		.oprofile_type		= PPC_OPROFILE_G4,
 	},
-	{	/* 745/755 */
-		.pvr_mask		= 0xfffff000,
-		.pvr_value		= 0x00083000,
-		.cpu_name		= "745/755",
-		.cpu_features		= CPU_FTRS_750,
+	{	/* 750CL (and "Broadway") */
+		.pvr_mask		= 0xfffff0e0,
+		.pvr_value		= 0x00087000,
+		.cpu_name		= "750CL",
+		.cpu_features		= CPU_FTRS_750CL,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTR_HPTE_TABLE | MMU_FTR_USE_HIGH_BATS,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -728,6 +726,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/750",
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 750FX rev 1.x */
 		.pvr_mask		= 0xffffff00,
-- 
1.6.3.3
