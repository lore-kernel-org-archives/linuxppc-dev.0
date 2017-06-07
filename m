Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjFWG2QJMzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 14:12:10 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org,
	paulus@samba.org,
	sam.bobroff@au1.ibm.com
Subject: [PATCH] powernv: Properly mask POWER9 DD1 PVR for different chip types
Date: Wed,  7 Jun 2017 14:11:45 +1000
Message-Id: <20170607041145.3581-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bits 48:51 in the PVR for POWER9 represent different chip types (scale
up vs out and 12 vs 24 core). Current chips have 0 here, but could be
non-zero in the future.

This changes the POWER9 DD1 mask to correctly ignore these bits 48:51.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/cputable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9b3e88b1a9..89dcd94237 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -526,8 +526,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
-	{	/* Power9 DD1*/
-		.pvr_mask		= 0xffffff00,
+	{	/* Power9 DD1. Bits 48:51 represent chip type so mask these */
+		.pvr_mask		= 0xffff0f00,
 		.pvr_value		= 0x004e0100,
 		.cpu_name		= "POWER9 (raw)",
 		.cpu_features		= CPU_FTRS_POWER9_DD1,
-- 
2.11.0
