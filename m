Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id F090D67F73
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 08:17:57 +1000 (EST)
Date: Tue, 16 Aug 2005 15:17:56 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050816151756.D1053@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: add cputable entry for 440SP Rev. A
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Adds the appropriate cputable entry for PPC440SP so cache line
sizes are configured correctly.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -922,6 +922,16 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 	},
+	{ /* 440SP Rev. A */
+		.pvr_mask		= 0xff000fff,
+		.pvr_value		= 0x53000891,
+		.cpu_name		= "440SP Rev. A",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
 #endif /* CONFIG_44x */
 #ifdef CONFIG_FSL_BOOKE
 	{ 	/* e200z5 */
