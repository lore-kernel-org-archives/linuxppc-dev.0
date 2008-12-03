Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52983DDDEF
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 03:47:27 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mB3GlMw5025194
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2008 10:47:23 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/85xx: Fix compile warnings in mpc85xx_mds.c
Date: Wed,  3 Dec 2008 10:47:22 -0600
Message-Id: <1228322842-20906-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/85xx/mpc85xx_mds.c: In function 'board_fixups':
arch/powerpc/platforms/85xx/mpc85xx_mds.c:244: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'resource_size_t'
arch/powerpc/platforms/85xx/mpc85xx_mds.c:250: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'resource_size_t'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
Used unsigned long long instead of u64 as pointed out by Geert

- k

 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 2494c51..b915bf5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -241,13 +241,15 @@ static int __init board_fixups(void)
 		mdio = of_find_compatible_node(NULL, NULL, compstrs[i]);
 
 		of_address_to_resource(mdio, 0, &res);
-		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 1);
+		snprintf(phy_id, BUS_ID_SIZE, "%llx:%02x",
+			(unsigned long long)res.start, 1);
 
 		phy_register_fixup_for_id(phy_id, mpc8568_fixup_125_clock);
 		phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
 
 		/* Register a workaround for errata */
-		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 7);
+		snprintf(phy_id, BUS_ID_SIZE, "%llx:%02x",
+			(unsigned long long)res.start, 7);
 		phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
 
 		of_node_put(mdio);
-- 
1.5.6.5
