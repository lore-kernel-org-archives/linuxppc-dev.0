Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 83E4867B6D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 06:28:57 +1000 (EST)
Date: Tue, 26 Sep 2006 22:28:36 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] avoid NULL pointer in gpio1_interrupt
Message-ID: <20060926202836.GA1051@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


gpio1_interrupt() may dereference a NULL pointer if ioremap() fails.
But, maybe no gpio interrupt happens in the first place?

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/macintosh/via-pmu.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.18/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6.18/drivers/macintosh/via-pmu.c
@@ -336,8 +336,10 @@ int __init find_via_pmu(void)
 			if (gaddr != OF_BAD_ADDR)
 				gpio_reg = ioremap(gaddr, 0x10);
 		}
-		if (gpio_reg == NULL)
+		if (gpio_reg == NULL) {
 			printk(KERN_ERR "via-pmu: Can't find GPIO reg !\n");
+			goto fail_gpio;
+		}
 	} else
 		pmu_kind = PMU_UNKNOWN;
 
@@ -366,6 +368,9 @@ int __init find_via_pmu(void)
 	return 1;
  fail:
 	of_node_put(vias);
+	iounmap(gpio_reg);
+	gpio_reg = NULL;
+ fail_gpio:
 	vias = NULL;
 	return 0;
 }
