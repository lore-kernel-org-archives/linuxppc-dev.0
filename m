Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id A8F86DDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 02:53:47 +1000 (EST)
Date: Thu, 15 May 2008 20:53:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 1/8] [WATCHDOG] mpc83xx_wdt: fix checkpatch issues
Message-ID: <20080515165345.GA3887@polina.dev.rtsoft.ru>
References: <20080515165250.GA30738@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080515165250.GA30738@polina.dev.rtsoft.ru>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Chen Gong <G.Chen@freescale.com>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quite tired of these warnings ;-), checkpatch spitting them when
seeing the rename patch.

WARNING: Use #include <linux/io.h> instead of <asm/io.h>
#25: FILE: watchdog/mpc83xx_wdt.c:25:
+#include <asm/io.h>

WARNING: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
#26: FILE: watchdog/mpc83xx_wdt.c:26:
+#include <asm/uaccess.h>

WARNING: line over 80 characters
#45: FILE: watchdog/mpc83xx_wdt.c:45:
+MODULE_PARM_DESC(timeout, "Watchdog timeout in ticks. (0<timeout<65536, default=65535");

WARNING: line over 80 characters
#49: FILE: watchdog/mpc83xx_wdt.c:49:
+MODULE_PARM_DESC(reset, "Watchdog Interrupt/Reset Mode. 0 = interrupt, 1 = reset");

WARNING: space prohibited between function name and open parenthesis '('
#164: FILE: watchdog/mpc83xx_wdt.c:164:
+       wd_base = ioremap(r->start, sizeof (struct mpc83xx_wdt));

total: 0 errors, 5 warnings, 230 lines checked

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/watchdog/mpc83xx_wdt.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/mpc83xx_wdt.c b/drivers/watchdog/mpc83xx_wdt.c
index b16c5cd..6905712 100644
--- a/drivers/watchdog/mpc83xx_wdt.c
+++ b/drivers/watchdog/mpc83xx_wdt.c
@@ -22,8 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
-#include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
 
 struct mpc83xx_wdt {
 	__be32 res0;
@@ -42,11 +42,13 @@ static struct mpc83xx_wdt __iomem *wd_base;
 
 static u16 timeout = 0xffff;
 module_param(timeout, ushort, 0);
-MODULE_PARM_DESC(timeout, "Watchdog timeout in ticks. (0<timeout<65536, default=65535");
+MODULE_PARM_DESC(timeout, "Watchdog timeout in ticks. "
+		 "(0<timeout<65536, default=65535");
 
 static int reset = 1;
 module_param(reset, bool, 0);
-MODULE_PARM_DESC(reset, "Watchdog Interrupt/Reset Mode. 0 = interrupt, 1 = reset");
+MODULE_PARM_DESC(reset, "Watchdog Interrupt/Reset Mode. "
+		 "0 = interrupt, 1 = reset");
 
 /*
  * We always prescale, but if someone really doesn't want to they can set this
@@ -161,7 +163,7 @@ static int __devinit mpc83xx_wdt_probe(struct platform_device *dev)
 		goto err_out;
 	}
 
-	wd_base = ioremap(r->start, sizeof (struct mpc83xx_wdt));
+	wd_base = ioremap(r->start, sizeof(struct mpc83xx_wdt));
 
 	if (wd_base == NULL) {
 		ret = -ENOMEM;
-- 
1.5.5.1
