Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FCC11A0514
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 07:48:27 +1000 (AEST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/5] drivers/tty: make hvc_console.c explicitly non-modular
Date: Wed, 19 Aug 2015 17:48:07 -0400
Message-ID: <1440020889-12120-4-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
References: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
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

drivers/tty/hvc/Kconfig:config HVC_DRIVER
drivers/tty/hvc/Kconfig:        bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only, even
though someone bothered to comment that the code was not used.

Unlike other changes, this driver binds in w/o using module_init,
so we dont have init ordering concerns with this commit.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/hvc/hvc_console.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 4e9c4cc9e1b5..9c30f67c802a 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -29,7 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/major.h>
 #include <linux/atomic.h>
 #include <linux/sysrq.h>
@@ -1005,19 +1005,3 @@ put_tty:
 out:
 	return err;
 }
-
-/* This isn't particularly necessary due to this being a console driver
- * but it is nice to be thorough.
- */
-static void __exit hvc_exit(void)
-{
-	if (hvc_driver) {
-		kthread_stop(hvc_task);
-
-		tty_unregister_driver(hvc_driver);
-		/* return tty_struct instances allocated in hvc_init(). */
-		put_tty_driver(hvc_driver);
-		unregister_console(&hvc_console);
-	}
-}
-module_exit(hvc_exit);
-- 
2.5.0
