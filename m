Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 1499067C21
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 11:11:27 +1000 (EST)
Date: Mon, 2 Oct 2006 20:10:24 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/7] Add initial support for the e300c2 core
Message-Id: <20061002201024.02567403.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add support for the Freescale e300c2 core found in the MPC832x processor line.

As far as initial kernel support is concerned, the e300c2 core is identical to the e300c1 found in the mpc834x, except that it's had its floating point unit chopped off.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/kernel/cputable.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 190a57e..47a613c 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -763,10 +763,10 @@ #if CLASSIC_PPC
 		.cpu_setup		= __setup_cpu_603,
 		.platform		= "ppc603",
 	},
-	{	/* e300 (a 603e core, plus some) on 83xx */
+	{	/* e300c1 (a 603e core, plus some) on 83xx */
 		.pvr_mask		= 0x7fff0000,
 		.pvr_value		= 0x00830000,
-		.cpu_name		= "e300",
+		.cpu_name		= "e300c1",
 		.cpu_features		= CPU_FTRS_E300,
 		.cpu_user_features	= COMMON_USER,
 		.icache_bsize		= 32,
@@ -774,6 +774,17 @@ #if CLASSIC_PPC
 		.cpu_setup		= __setup_cpu_603,
 		.platform		= "ppc603",
 	},
+	{	/* e300c2 (an e300c1 core, plus some, minus FPU) on 83xx */
+		.pvr_mask		= 0x7fff0000,
+		.pvr_value		= 0x00840000,
+		.cpu_name		= "e300c2",
+		.cpu_features		= CPU_FTRS_E300,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_603,
+		.platform		= "ppc603",
+	},
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
-- 
1.4.2.3
