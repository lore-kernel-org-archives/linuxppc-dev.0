Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAA4F1A062A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 10:03:52 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, Paul Gortmaker
 <paul.gortmaker@windriver.com>,
 Jiri Slaby <jslaby@suse.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/5] drivers/tty: make ehv_bytechan.c explicitly non-modular
Date: Sun, 18 Oct 2015 18:21:15 -0400
Message-ID: <1445206878-12455-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Kconfig currently controlling compilation of this code is:

drivers/tty/Kconfig:config PPC_EPAPR_HV_BYTECHAN
drivers/tty/Kconfig:    bool "ePAPR hypervisor byte channel driver"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/ehv_bytechan.c | 40 +++-------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 342b36b9ad35..7ac9bcdf1e61 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -23,7 +23,6 @@
  * byte channel used for the console is designated as the default tty.
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -719,19 +718,6 @@ error:
 	return ret;
 }
 
-static int ehv_bc_tty_remove(struct platform_device *pdev)
-{
-	struct ehv_bc_data *bc = dev_get_drvdata(&pdev->dev);
-
-	tty_unregister_device(ehv_bc_driver, bc - bcs);
-
-	tty_port_destroy(&bc->port);
-	irq_dispose_mapping(bc->tx_irq);
-	irq_dispose_mapping(bc->rx_irq);
-
-	return 0;
-}
-
 static const struct of_device_id ehv_bc_tty_of_ids[] = {
 	{ .compatible = "epapr,hv-byte-channel" },
 	{}
@@ -741,15 +727,15 @@ static struct platform_driver ehv_bc_tty_driver = {
 	.driver = {
 		.name = "ehv-bc",
 		.of_match_table = ehv_bc_tty_of_ids,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= ehv_bc_tty_probe,
-	.remove		= ehv_bc_tty_remove,
 };
 
 /**
  * ehv_bc_init - ePAPR hypervisor byte channel driver initialization
  *
- * This function is called when this module is loaded.
+ * This function is called when this driver is loaded.
  */
 static int __init ehv_bc_init(void)
 {
@@ -814,24 +800,4 @@ error:
 
 	return ret;
 }
-
-
-/**
- * ehv_bc_exit - ePAPR hypervisor byte channel driver termination
- *
- * This function is called when this driver is unloaded.
- */
-static void __exit ehv_bc_exit(void)
-{
-	platform_driver_unregister(&ehv_bc_tty_driver);
-	tty_unregister_driver(ehv_bc_driver);
-	put_tty_driver(ehv_bc_driver);
-	kfree(bcs);
-}
-
-module_init(ehv_bc_init);
-module_exit(ehv_bc_exit);
-
-MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-MODULE_DESCRIPTION("ePAPR hypervisor byte channel driver");
-MODULE_LICENSE("GPL v2");
+device_initcall(ehv_bc_init);
-- 
2.6.1
