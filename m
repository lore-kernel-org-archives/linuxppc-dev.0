Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBfJ1DHkzDqvP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:05:28 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBfF30Pjz9sdn
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:05:24 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 25/41] powerpc/cell: Don't use flat device-tree after boot
Date: Tue,  5 Jul 2016 15:04:01 +1000
Message-Id: <1467695057-12431-26-git-send-email-benh@kernel.crashing.org>
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
