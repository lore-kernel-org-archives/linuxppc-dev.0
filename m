Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420w5d1HwkzF315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 05:04:05 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so11089610oie.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 12:04:04 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Frank Rowand <frowand.list@gmail.com>,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] of: make PowerMac cache node search conditional on
 CONFIG_PPC_PMAC
Date: Wed, 29 Aug 2018 14:04:00 -0500
Message-Id: <20180829190400.23146-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cache nodes under the cpu node(s) is PowerMac specific according to the
comment above, so make the code enforce that.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 466e3c8582f0..cadcb470198a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1963,7 +1963,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 	/* OF on pmac has nodes instead of properties named "l2-cache"
 	 * beneath CPU nodes.
 	 */
-	if (!strcmp(np->type, "cpu"))
+	if (IS_ENABLED(CONFIG_PPC_PMAC) && !strcmp(np->type, "cpu"))
 		for_each_child_of_node(np, child)
 			if (!strcmp(child->type, "cache"))
 				return child;
-- 
2.17.1
