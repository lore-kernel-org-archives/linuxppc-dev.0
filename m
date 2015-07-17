Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 120F41A078B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 23:20:42 +1000 (AEST)
From: Luis Henriques <luis.henriques@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh/ans-lcd: fix build failure after module_init/exit
 relocation
Date: Fri, 17 Jul 2015 14:20:31 +0100
Message-Id: <1437139231-11812-1-git-send-email-luis.henriques@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After commit 0fd972a7d91d ("module: relocate module_init from init.h to module.h")
ans-lcd module fails to build with:

drivers/macintosh/ans-lcd.c:201:1: warning: data definition has no type or storage class [enabled by default]
 module_init(anslcd_init);
 ^
drivers/macintosh/ans-lcd.c:201:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
drivers/macintosh/ans-lcd.c:201:1: warning: parameter names (without types) in function declaration [enabled by default]
drivers/macintosh/ans-lcd.c:202:1: warning: data definition has no type or storage class [enabled by default]
 module_exit(anslcd_exit);
 ^
drivers/macintosh/ans-lcd.c:202:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
drivers/macintosh/ans-lcd.c:202:1: warning: parameter names (without types) in function declaration [enabled by default]
drivers/macintosh/ans-lcd.c:155:1: warning: 'anslcd_init' defined but not used [-Wunused-function]
 anslcd_init(void)
 ^
drivers/macintosh/ans-lcd.c:195:1: warning: 'anslcd_exit' defined but not used [-Wunused-function]
 anslcd_exit(void)
 ^

This commit fixes it by replacing linux/init.h by linux/module.h.

Fixes: 0fd972a7d91d ("module: relocate module_init from init.h to module.h")
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/macintosh/ans-lcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index 1a57e88a38f7..cd35079c8c98 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -7,7 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/fcntl.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 
