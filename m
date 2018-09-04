Return-Path: <climbbb.kim@gmail.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424BmN1cG0zF38J
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 13:15:32 +1000 (AEST)
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so928609pgo.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 20:15:31 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
 devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 17/25] misc: pti: Change return type to void
Date: Tue,  4 Sep 2018 11:44:43 +0900
Message-Id: <1536029091-4426-18-git-send-email-climbbb.kim@gmail.com>
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
 drivers/misc/pti.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 41f2a9f..5c885a1 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -462,26 +462,24 @@ static int pti_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
 	struct pti_tty *pti_tty_data;
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0) {
-		pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
-		if (pti_tty_data == NULL)
-			return -ENOMEM;
+	tty_standard_install(driver, tty);
+	pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
+	if (pti_tty_data == NULL)
+		return -ENOMEM;
 
-		if (idx == PTITTY_MINOR_START)
-			pti_tty_data->mc = pti_request_masterchannel(0, NULL);
-		else
-			pti_tty_data->mc = pti_request_masterchannel(2, NULL);
+	if (idx == PTITTY_MINOR_START)
+		pti_tty_data->mc = pti_request_masterchannel(0, NULL);
+	else
+		pti_tty_data->mc = pti_request_masterchannel(2, NULL);
 
-		if (pti_tty_data->mc == NULL) {
-			kfree(pti_tty_data);
-			return -ENXIO;
-		}
-		tty->driver_data = pti_tty_data;
+	if (pti_tty_data->mc == NULL) {
+		kfree(pti_tty_data);
+		return -ENXIO;
 	}
+	tty->driver_data = pti_tty_data;
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.7.4
