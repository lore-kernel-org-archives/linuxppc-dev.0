Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkCFH55vYzDrVq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:32:19 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkCFH0CZ5z9ryQ
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:32:18 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 27/41] powerpc/85xx/mpc85xx_ds: Don't use the flat device-tree
 after boot
Date: Tue,  5 Jul 2016 15:04:03 +1000
Message-Id: <1467695057-12431-28-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index f858306..64a7e8c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -66,9 +66,7 @@ void __init mpc85xx_ds_pic_init(void)
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
 #endif
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP")) {
+	if (of_machine_is_compatible("fsl,MPC8572DS-CAMP")) {
 		mpic = mpic_alloc(NULL, 0,
 			MPIC_NO_RESET |
 			MPIC_BIG_ENDIAN |
-- 
2.7.4
