Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDdS05YCRzDr5n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:43:12 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sDdS00KsLz9t0m
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2016 15:43:11 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 10/10] powerpc/64: Hard code cache geometry on POWER8
Date: Wed, 17 Aug 2016 15:39:17 +1000
Message-Id: <1471412357-3477-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
References: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All shipping firmware versions have it wrong in the device-tree

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 52 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 78d28ca..1243062 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -255,7 +255,7 @@ static void cpu_ready_for_interrupts(void)
 
 void __init early_setup(unsigned long dt_ptr)
 {
-	static __initdata struct paca_struct boot_paca;
+	static struct paca_struct boot_paca __initdata ;
 
 	/* -------- printk is _NOT_ safe to use here ! ------- */
 
@@ -483,13 +483,59 @@ static bool __init parse_cache_info(struct device_node *np,
 	return success;
 }
 
+static void __init populate_p8_cache_info(void)
+{
+	static const struct ppc_cache_info p8_l1i __initconst  = {
+		.size = 0x8000,
+		.line_size = 128,
+		.block_size = 128,
+		.log_block_size = 7,
+		.blocks_per_page = PAGE_SIZE / 128,
+		.sets = 32
+	};
+	static const struct ppc_cache_info p8_l1d __initconst  = {
+		.size = 0x10000,
+		.line_size = 128,
+		.block_size = 128,
+		.log_block_size = 7,
+		.blocks_per_page = PAGE_SIZE / 128,
+		.sets = 64
+	};
+	static const struct ppc_cache_info p8_l2 __initconst  = {
+		.size = 0x80000,
+		.line_size = 128,
+		.sets = 512
+	};
+	static const struct ppc_cache_info p8_l3 __initconst  = {
+		.size = 0x800000,
+		.line_size = 128,
+		.sets = 8192
+	};
+	ppc64_caches.l1i = p8_l1i;
+	ppc64_caches.l1d = p8_l1d;
+	ppc64_caches.l2 = p8_l2;
+	ppc64_caches.l3 = p8_l3;
+}
+
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
+	    pvr == PVR_POWER8NVL)
+		populate_p8_cache_info();
+	else
+		cpu = of_find_node_by_type(NULL, "cpu");
 
 	/*
 	 * We're assuming *all* of the CPUs have the same
-- 
2.7.4
