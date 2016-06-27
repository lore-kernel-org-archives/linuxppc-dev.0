Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSxP1b1CzDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:32:08 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 25/38] powerpc/cell: Don't use flat device-tree after boot
Date: Mon, 27 Jun 2016 21:29:23 +1000
Message-Id: <1467026976-7974-26-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some bit of SPU code was using the FDT rather than the expanded
device-tree. Fix it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/cell/spu_manage.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index c3327f3..21b4bfb 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -535,8 +535,7 @@ static int __init init_affinity(void)
 	if (of_has_vicinity()) {
 		init_affinity_fw();
 	} else {
-		long root = of_get_flat_dt_root();
-		if (of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
+		if (of_machine_is_compatible("IBM,CPBW-1.0"))
 			init_affinity_qs20_harcoded();
 		else
 			printk("No affinity configuration found\n");
-- 
2.7.4
