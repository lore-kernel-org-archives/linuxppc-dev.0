Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri1.pp.htv.fi (filtteri1.pp.htv.fi [213.243.153.184])
 by lists.ozlabs.org (Postfix) with ESMTP id F02901A08B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 13:04:02 +1100 (AEDT)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Phil Carmody <pc+lkml@asdf.org>
Subject: [PATCH RESEND 1/2] powerpc/via-pmu: fix error path in find_via_pmu()
Date: Mon,  8 Dec 2014 03:57:37 +0200
Message-Id: <1418003858-870-1-git-send-email-aaro.koskinen@iki.fi>
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

Cleanup was not in the reverse order from the set-up, so not all
the gotos made sense, and also it was being avoided completely upon
failure of init_pmu().

Signed-off-by: Phil Carmody <pc+lkml@asdf.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/macintosh/via-pmu.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index dee88e5..6221235 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -332,7 +332,7 @@ int __init find_via_pmu(void)
 		}
 		if (gpio_reg == NULL) {
 			printk(KERN_ERR "via-pmu: Can't find GPIO reg !\n");
-			goto fail_gpio;
+			goto fail;
 		}
 	} else
 		pmu_kind = PMU_UNKNOWN;
@@ -340,7 +340,7 @@ int __init find_via_pmu(void)
 	via = ioremap(taddr, 0x2000);
 	if (via == NULL) {
 		printk(KERN_ERR "via-pmu: Can't map address !\n");
-		goto fail;
+		goto fail_via_remap;
 	}
 	
 	out_8(&via[IER], IER_CLR | 0x7f);	/* disable all intrs */
@@ -348,10 +348,8 @@ int __init find_via_pmu(void)
 
 	pmu_state = idle;
 
-	if (!init_pmu()) {
-		via = NULL;
-		return 0;
-	}
+	if (!init_pmu())
+		goto fail_init;
 
 	printk(KERN_INFO "PMU driver v%d initialized for %s, firmware: %02x\n",
 	       PMU_DRIVER_VERSION, pbook_type[pmu_kind], pmu_version);
@@ -359,11 +357,15 @@ int __init find_via_pmu(void)
 	sys_ctrler = SYS_CTRLER_PMU;
 	
 	return 1;
- fail:
-	of_node_put(vias);
+
+ fail_init:
+	iounmap(via);
+	via = NULL;
+ fail_via_remap:
 	iounmap(gpio_reg);
 	gpio_reg = NULL;
- fail_gpio:
+ fail:
+	of_node_put(vias);
 	vias = NULL;
 	return 0;
 }
-- 
2.2.0
