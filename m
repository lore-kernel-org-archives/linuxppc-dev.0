Return-Path: <climbbb.kim@gmail.com>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424BnX2HcszF38J
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 13:16:32 +1000 (AEST)
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so953365pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 20:16:32 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
 devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 15/25] um: Change return type to void
Date: Tue,  4 Sep 2018 11:44:41 +0900
Message-Id: <1536029091-4426-16-git-send-email-climbbb.kim@gmail.com>
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
 arch/um/drivers/line.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 8d80b27..47058cf 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -338,12 +338,7 @@ int line_open(struct tty_struct *tty, struct file *filp)
 int line_install(struct tty_driver *driver, struct tty_struct *tty,
 		 struct line *line)
 {
-	int ret;
-
-	ret = tty_standard_install(driver, tty);
-	if (ret)
-		return ret;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = line;
 
 	return 0;
-- 
2.7.4
