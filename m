Return-Path: <climbbb.kim@gmail.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424BtL2XRczF38J
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 13:20:41 +1000 (AEST)
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so920995pgv.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 20:20:41 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
 devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 19/25] staging: fwserial: Change return type to void
Date: Tue,  4 Sep 2018 11:44:45 +0900
Message-Id: <1536029091-4426-20-git-send-email-climbbb.kim@gmail.com>
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

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/staging/fwserial/fwserial.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index fa0dd42..5134019 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1064,27 +1064,21 @@ static void fwtty_cleanup(struct tty_struct *tty)
 static int fwtty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct fwtty_port *port = fwtty_port_get(tty->index);
-	int err;
 
-	err = tty_standard_install(driver, tty);
-	if (!err)
-		tty->driver_data = port;
-	else
-		fwtty_port_put(port);
-	return err;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 static int fwloop_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct fwtty_port *port = fwtty_port_get(table_idx(tty->index));
-	int err;
 
-	err = tty_standard_install(driver, tty);
-	if (!err)
-		tty->driver_data = port;
-	else
-		fwtty_port_put(port);
-	return err;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 static int fwtty_write(struct tty_struct *tty, const unsigned char *buf, int c)
-- 
2.7.4
