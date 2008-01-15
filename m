Return-Path: <SRS0=XpNt=SF=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 6B6CDDDE48
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 18:14:35 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] [POWERPC] 4xx: Add 405EXr to cputable
Date: Tue, 15 Jan 2008 08:09:15 +0100
Message-Id: <1200380955-10217-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the 405EXr to the powerpc cuptable. Basically the 405EXr
is a 405EX with only one EMAC and only one PCIe interface.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/kernel/cputable.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index f1928af..dfb84c8 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1178,8 +1178,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "ppc405",
 	},
 	{	/* 405EX */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x12910000,
+		.pvr_mask		= 0xffff0004,
+		.pvr_value		= 0x12910004,
 		.cpu_name		= "405EX",
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
@@ -1189,6 +1189,18 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
+	{	/* 405EXr */
+		.pvr_mask		= 0xffff0004,
+		.pvr_value		= 0x12910000,
+		.cpu_name		= "405EXr",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
 
 #endif /* CONFIG_40x */
 #ifdef CONFIG_44x
-- 
1.5.4.rc3
