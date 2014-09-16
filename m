Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri2.pp.htv.fi (filtteri2.pp.htv.fi [213.243.153.185])
 by lists.ozlabs.org (Postfix) with ESMTP id 7C1571A0171
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 08:07:30 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Phil Carmody <pc+lkml@asdf.org>
Subject: [PATCH 2/2] powerpc/via-pmu: fix OF node leak in Keylargo init
Date: Wed, 17 Sep 2014 01:00:54 +0300
Message-Id: <1410904854-26128-2-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1410904854-26128-1-git-send-email-aaro.koskinen@iki.fi>
References: <1410904854-26128-1-git-send-email-aaro.koskinen@iki.fi>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Phil Carmody <pc+lkml@asdf.org>

If we of_find_node_by_name() then we must of_node_put() too.

Signed-off-by: Phil Carmody <pc+lkml@asdf.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/macintosh/via-pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 6221235..aed3cb0 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -329,6 +329,7 @@ int __init find_via_pmu(void)
 				gaddr = of_translate_address(gpiop, reg);
 			if (gaddr != OF_BAD_ADDR)
 				gpio_reg = ioremap(gaddr, 0x10);
+			of_node_put(gpiop);
 		}
 		if (gpio_reg == NULL) {
 			printk(KERN_ERR "via-pmu: Can't find GPIO reg !\n");
-- 
2.1.0
