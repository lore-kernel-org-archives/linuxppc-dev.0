Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBfG72RvzDqxS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:05:26 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBfC6rSvz9sRZ
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:05:22 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 28/41] powerpc/85xx/mpc85xx_rdb: Don't use the flat
 device-tree after boot
Date: Tue,  5 Jul 2016 15:04:04 +1000
Message-Id: <1467695057-12431-29-git-send-email-benh@kernel.crashing.org>
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
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 3f4dad1..761e504 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -47,13 +47,12 @@
 void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
-	unsigned long root = of_get_flat_dt_root();
 
 #ifdef CONFIG_QUICC_ENGINE
 	struct device_node *np;
 #endif
 
-	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
+	if (of_machine_is_compatible("fsl,MPC85XXRDB-CAMP")) {
 		mpic = mpic_alloc(NULL, 0, MPIC_NO_RESET |
 			MPIC_BIG_ENDIAN |
 			MPIC_SINGLE_DEST_CPU,
-- 
2.7.4
