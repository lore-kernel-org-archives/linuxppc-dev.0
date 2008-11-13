Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 725B8DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 00:48:21 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/85xx: Don't reset the MPIC for CAMP mode on
	MPC8572DS
Date: Thu, 13 Nov 2008 07:46:12 -0600
Message-Id: <1226583973-12581-1-git-send-email-galak@kernel.crashing.org>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Haiying Wang <Haiying.Wang@freescale.com>

The flag MPIC_WANTS_RESET shouldn't be set if reading the new cpu compatible
"fsl,MPC8572DS-CAMP" returns 1.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index a03c839..7326d90 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -63,6 +63,7 @@ void __init mpc85xx_ds_pic_init(void)
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
 #endif
+	unsigned long root = of_get_flat_dt_root();
 
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np == NULL) {
@@ -76,11 +77,19 @@ void __init mpc85xx_ds_pic_init(void)
 		return;
 	}
 
-	mpic = mpic_alloc(np, r.start,
+	if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP")) {
+		mpic = mpic_alloc(np, r.start,
+			MPIC_PRIMARY |
+			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
+			0, 256, " OpenPIC  ");
+	} else {
+		mpic = mpic_alloc(np, r.start,
 			  MPIC_PRIMARY | MPIC_WANTS_RESET |
 			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
 			  MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
+	}
+
 	BUG_ON(mpic == NULL);
 	of_node_put(np);
 
-- 
1.5.6.5
