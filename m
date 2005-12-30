Return-Path: <grant.likely@secretlab.ca>
Received: from localhost.localdomain (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89AF46898A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 21:51:23 +1100 (EST)
In-Reply-To: <11359385973413-git-send-email-grant.likely@secretlab.ca>
Date: Fri, 30 Dec 2005 03:29:58 -0700
Message-Id: <1135938598732-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org, linuxppc-embedded@ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 4/8] Add Virtex-4 FX to cpu table
Reply-To: Grant Likely <grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add Virtex-4 FX to cpu table

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/ppc/kernel/cputable.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

e42625e6e14442f0b315699d872ccc4cc3d4d49d
diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
index 6b76cf5..7f3faf1 100644
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -859,7 +859,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 32,
 	},
 	{	/* Xilinx Virtex-II Pro  */
-		.pvr_mask		= 0xffff0000,
+		.pvr_mask		= 0xfffff000,
 		.pvr_value		= 0x20010000,
 		.cpu_name		= "Virtex-II Pro",
 		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
@@ -869,6 +869,17 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 	},
+	{	/* Xilinx Virtex-4  */
+		.pvr_mask		= 0xfffff000,
+		.pvr_value		= 0x20011000,
+		.cpu_name		= "Virtex-4 FX",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
 	{	/* 405EP */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x51210000,
-- 
1.0.6-g58e3
