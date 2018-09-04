Return-Path: <climbbb.kim@gmail.com>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424Brk2tWXzF3C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 13:19:18 +1000 (AEST)
Received: by mail-pl1-f196.google.com with SMTP id d9-v6so933083plr.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 20:19:17 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
 devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 16/25] isdn: capi: Change return type to void
Date: Tue,  4 Sep 2018 11:44:42 +0900
Message-Id: <1536029091-4426-17-git-send-email-climbbb.kim@gmail.com>
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
 drivers/isdn/capi/capi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index ef5560b..08daf3a 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -999,13 +999,11 @@ static int
 capinc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct capiminor *mp = capiminor_get(tty->index);
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0)
-		tty->driver_data = mp;
-	else
-		capiminor_put(mp);
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = mp;
+
+	return 0;
 }
 
 static void capinc_tty_cleanup(struct tty_struct *tty)
-- 
2.7.4
