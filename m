Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCsrw5cQNzDrFM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 21:59:44 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id t8so2603065pgs.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 04:59:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/pseries: energy driver only print message when LPAR
 guest
Date: Thu, 20 Jul 2017 21:59:00 +1000
Message-Id: <20170720115900.455-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This driver currently reports the H_BEST_ENERGY is unsupported even
when booting in a non-LPAR environment (e.g., powernv). Prevent it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/pseries/pseries_energy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 164a13d3998a..832b3d7898a3 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -229,6 +229,9 @@ static int __init pseries_energy_init(void)
 	int cpu, err;
 	struct device *cpu_dev;
 
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		return 0;
+
 	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY)) {
 		printk(KERN_INFO "Hypercall H_BEST_ENERGY not supported\n");
 		return 0;
-- 
2.11.0
