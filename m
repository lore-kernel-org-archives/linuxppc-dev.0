Return-Path: <climbbb.kim@gmail.com>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424BkZ5C7DzF38s
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 13:13:58 +1000 (AEST)
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so925752pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 20:13:58 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
 devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 03/25] s390: char: con3215: Change return type to void
Date: Tue,  4 Sep 2018 11:44:29 +0900
Message-Id: <1536029091-4426-4-git-send-email-climbbb.kim@gmail.com>
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
 drivers/s390/char/con3215.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 8c9d412..6a9f6d9 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -965,8 +965,9 @@ static int tty3215_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	tty->driver_data = raw;
+	tty_port_install(&raw->port, driver, tty);
 
-	return tty_port_install(&raw->port, driver, tty);
+	return 0;
 }
 
 /*
-- 
2.7.4
