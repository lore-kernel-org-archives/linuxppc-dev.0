Return-Path: <Sudeep.KarkadaNagesha@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 201352C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 20:52:55 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: remove big endianness assumption in
 of_find_next_cache_node
Date: Wed, 18 Sep 2013 11:53:04 +0100
Message-Id: <1379501585-12532-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Cc: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Currently big endianness of the device tree data is assumed in
of_find_next_cache_node for 'handle' when calling of_find_node_by_phandle.

In preparation to move this function to common code, this patch fixes
the endianness using 'be32_to_cpup'

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/powerpc/kernel/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b7634ce..09be275 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -778,7 +778,7 @@ struct device_node *of_find_next_cache_node(struct device_node *np)
 		handle = of_get_property(np, "next-level-cache", NULL);
 
 	if (handle)
-		return of_find_node_by_phandle(*handle);
+		return of_find_node_by_phandle(be32_to_cpup(handle));
 
 	/* OF on pmac has nodes instead of properties named "l2-cache"
 	 * beneath CPU nodes.
-- 
1.8.1.2
