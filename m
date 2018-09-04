Return-Path: <climbbb.kim@gmail.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424Bfh13FJzF3HH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 13:10:35 +1000 (AEST)
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so926089pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 20:10:35 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
 devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 05/25] tty: hvc: hvc_console: Change return type to void
Date: Tue,  4 Sep 2018 11:44:31 +0900
Message-Id: <1536029091-4426-6-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5414c4a..13fad62 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -329,7 +329,6 @@ static void hvc_unthrottle(struct tty_struct *tty)
 static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct hvc_struct *hp;
-	int rc;
 
 	/* Auto increments kref reference if found. */
 	hp = hvc_get_by_index(tty->index);
@@ -337,11 +336,9 @@ static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	tty->driver_data = hp;
+	tty_port_install(&hp->port, driver, tty);
 
-	rc = tty_port_install(&hp->port, driver, tty);
-	if (rc)
-		tty_port_put(&hp->port);
-	return rc;
+	return 0;
 }
 
 /*
-- 
2.7.4
