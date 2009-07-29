Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 93B6EB70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 03:05:01 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E5E0DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 03:04:59 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add AMCC 460EX/460GT Rev. B support to cputable.c
Date: Wed, 29 Jul 2009 19:04:46 +0200
Message-Id: <1248887086-3428-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/kernel/cputable.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 4a24a2f..0197753 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1630,7 +1630,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "ppc440",
 	},
 	{ /* 460EX */
-		.pvr_mask		= 0xffff0002,
+		.pvr_mask		= 0xffff0006,
 		.pvr_value		= 0x13020002,
 		.cpu_name		= "460EX",
 		.cpu_features		= CPU_FTRS_440x6,
@@ -1642,8 +1642,21 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{ /* 460EX Rev B */
+		.pvr_mask		= 0xffff0007,
+		.pvr_value		= 0x13020004,
+		.cpu_name		= "460EX Rev. B",
+		.cpu_features		= CPU_FTRS_440x6,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_460ex,
+		.machine_check		= machine_check_440A,
+		.platform		= "ppc440",
+	},
 	{ /* 460GT */
-		.pvr_mask		= 0xffff0002,
+		.pvr_mask		= 0xffff0006,
 		.pvr_value		= 0x13020000,
 		.cpu_name		= "460GT",
 		.cpu_features		= CPU_FTRS_440x6,
@@ -1655,6 +1668,19 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{ /* 460GT Rev B */
+		.pvr_mask		= 0xffff0007,
+		.pvr_value		= 0x13020005,
+		.cpu_name		= "460GT Rev. B",
+		.cpu_features		= CPU_FTRS_440x6,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_460gt,
+		.machine_check		= machine_check_440A,
+		.platform		= "ppc440",
+	},
 	{ /* 460SX */
 		.pvr_mask		= 0xffffff00,
 		.pvr_value		= 0x13541800,
-- 
1.6.3.4
