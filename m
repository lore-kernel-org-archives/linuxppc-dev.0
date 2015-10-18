Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FAB81A0615
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 09:21:46 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, Paul Gortmaker
 <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.com>, Michael
 Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/5] drivers/tty: make hvc/hvc_vio.c explicitly non-modular
Date: Sun, 18 Oct 2015 18:21:14 -0400
Message-ID: <1445206878-12455-2-git-send-email-paul.gortmaker@windriver.com>
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

drivers/tty/hvc/Kconfig:config HVC_CONSOLE
drivers/tty/hvc/Kconfig:        bool "pSeries Hypervisor Virtual Console support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

We don't replace module.h with init.h since the file already has that.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/hvc/hvc_vio.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index f575a9b5ede7..b05dc5086627 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -41,7 +41,6 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/console.h>
-#include <linux/module.h>
 
 #include <asm/hvconsole.h>
 #include <asm/vio.h>
@@ -61,7 +60,6 @@ static struct vio_device_id hvc_driver_table[] = {
 #endif
 	{ "", "" }
 };
-MODULE_DEVICE_TABLE(vio, hvc_driver_table);
 
 typedef enum hv_protocol {
 	HV_PROTOCOL_RAW,
@@ -363,26 +361,13 @@ static int hvc_vio_probe(struct vio_dev *vdev,
 	return 0;
 }
 
-static int hvc_vio_remove(struct vio_dev *vdev)
-{
-	struct hvc_struct *hp = dev_get_drvdata(&vdev->dev);
-	int rc, termno;
-
-	termno = hp->vtermno;
-	rc = hvc_remove(hp);
-	if (rc == 0) {
-		if (hvterm_privs[termno] != &hvterm_priv0)
-			kfree(hvterm_privs[termno]);
-		hvterm_privs[termno] = NULL;
-	}
-	return rc;
-}
-
 static struct vio_driver hvc_vio_driver = {
 	.id_table	= hvc_driver_table,
 	.probe		= hvc_vio_probe,
-	.remove		= hvc_vio_remove,
 	.name		= hvc_driver_name,
+	.driver = {
+		.suppress_bind_attrs	= true,
+	},
 };
 
 static int __init hvc_vio_init(void)
@@ -394,13 +379,7 @@ static int __init hvc_vio_init(void)
 
 	return rc;
 }
-module_init(hvc_vio_init); /* after drivers/char/hvc_console.c */
-
-static void __exit hvc_vio_exit(void)
-{
-	vio_unregister_driver(&hvc_vio_driver);
-}
-module_exit(hvc_vio_exit);
+device_initcall(hvc_vio_init); /* after drivers/tty/hvc/hvc_console.c */
 
 void __init hvc_vio_init_early(void)
 {
-- 
2.6.1
