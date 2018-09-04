Return-Path: <climbbb.kim@gmail.com>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424BmY6PYNzF38J
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 13:15:41 +1000 (AEST)
Received: by mail-pl1-f194.google.com with SMTP id g23-v6so908847plq.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 20:15:41 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
 devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 24/25] usb: cdc-acm: Change return type to void
Date: Tue,  4 Sep 2018 11:44:50 +0900
Message-Id: <1536029091-4426-25-git-send-email-climbbb.kim@gmail.com>
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
 drivers/usb/class/cdc-acm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 27346d6..de6a27e 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -572,23 +572,15 @@ static void acm_softint(struct work_struct *work)
 static int acm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct acm *acm;
-	int retval;
 
 	acm = acm_get_by_minor(tty->index);
 	if (!acm)
 		return -ENODEV;
 
-	retval = tty_standard_install(driver, tty);
-	if (retval)
-		goto error_init_termios;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = acm;
 
 	return 0;
-
-error_init_termios:
-	tty_port_put(&acm->port);
-	return retval;
 }
 
 static int acm_tty_open(struct tty_struct *tty, struct file *filp)
-- 
2.7.4
