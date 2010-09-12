Return-Path: <segooon@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) by ozlabs.org (Postfix) with ESMTP id 7F0ADB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 04:57:21 +1000 (EST)
Received: by eye27 with SMTP id 27so1447412eye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Sep 2010 11:57:18 -0700 (PDT)
From: Vasiliy Kulikov <segooon@gmail.com>
To: kernel-janitors@vger.kernel.org
Subject: [PATCH] char: hvc: check for error case
Date: Sun, 12 Sep 2010 22:57:14 +0400
Message-Id: <1284317835-5086-1-git-send-email-segooon@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hvc_alloc() may fail, if so exit from init() with error.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 I cannot compile this driver at all, so it is not tested.

 drivers/char/hvc_tile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hvc_tile.c b/drivers/char/hvc_tile.c
index c4efb55..7a84a05 100644
--- a/drivers/char/hvc_tile.c
+++ b/drivers/char/hvc_tile.c
@@ -61,7 +61,8 @@ console_initcall(hvc_tile_console_init);
 
 static int __init hvc_tile_init(void)
 {
-	hvc_alloc(0, 0, &hvc_tile_get_put_ops, 128);
-	return 0;
+	struct hvc_struct *s;
+	s = hvc_alloc(0, 0, &hvc_tile_get_put_ops, 128);
+	return IS_ERR(s) ? PTR_ERR(s) : 0;
 }
 device_initcall(hvc_tile_init);
-- 
1.7.0.4
