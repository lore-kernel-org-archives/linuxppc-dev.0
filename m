Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFDZL6FkmzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:06:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 8/9] powerpc/64: Hard code cache geometry on POWER8
Date: Fri,  3 Feb 2017 22:05:58 +1100
Message-Id: <1486119959-21662-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1486119959-21662-1-git-send-email-mpe@ellerman.id.au>
References: <1486119959-21662-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

All shipping firmware versions have it wrong in the device-tree

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

v3: Rather than defining ppc_cache_info structs with the p8 values, just call
    init_cache_info() directly with the p8 values. This is less code, and means
    in the next patch info->assoc will be correctly populated for p8 which it
    wasn't in v2 of this patch. (mpe)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index db18f7b68a1d..364fbffd7e83 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -472,11 +472,27 @@ static bool __init parse_cache_info(struct device_node *np,
 
 void __init initialize_cache_info(void)
 {
-	struct device_node *cpu, *l2, *l3 = NULL;
+	struct device_node *cpu = NULL, *l2, *l3 = NULL;
+	u32 pvr;
 
 	DBG(" -> initialize_cache_info()\n");
 
-	cpu = of_find_node_by_type(NULL, "cpu");
+	/*
+	 * All shipping POWER8 machines have a firmware bug that
+	 * puts incorrect information in the device-tree. This will
+	 * be (hopefully) fixed for future chips but for now hard
+	 * code the values if we are running on one of these
+	 */
+	pvr = PVR_VER(mfspr(SPRN_PVR));
+	if (pvr == PVR_POWER8 || pvr == PVR_POWER8E ||
+	    pvr == PVR_POWER8NVL) {
+						/* size    lsize   blk  sets */
+		init_cache_info(&ppc64_caches.l1i, 0x8000,   128,  128, 32);
+		init_cache_info(&ppc64_caches.l1d, 0x10000,  128,  128, 64);
+		init_cache_info(&ppc64_caches.l2,  0x80000,  128,  0,   512);
+		init_cache_info(&ppc64_caches.l3,  0x800000, 128,  0,   8192);
+	} else
+		cpu = of_find_node_by_type(NULL, "cpu");
 
 	/*
 	 * We're assuming *all* of the CPUs have the same
-- 
2.7.4
