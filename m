Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBfC41KTzDqxF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:05:23 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBf91Wr3z9sdn
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:05:20 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 19/41] powerpc: Don't test for machine type in
 smp_setup_cpu_maps()
Date: Tue,  5 Jul 2016 15:03:55 +1000
Message-Id: <1467695057-12431-20-git-send-email-benh@kernel.crashing.org>
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

The subsequent test for RTAS along with the LPAR test are sufficient

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 8ca79b7..2a3564c 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -494,7 +494,7 @@ void __init smp_setup_cpu_maps(void)
 	 * On pSeries LPAR, we need to know how many cpus
 	 * could possibly be added to this partition.
 	 */
-	if (machine_is(pseries) && firmware_has_feature(FW_FEATURE_LPAR) &&
+	if (firmware_has_feature(FW_FEATURE_LPAR) &&
 	    (dn = of_find_node_by_path("/rtas"))) {
 		int num_addr_cell, num_size_cell, maxcpus;
 		const __be32 *ireg;
-- 
2.7.4
