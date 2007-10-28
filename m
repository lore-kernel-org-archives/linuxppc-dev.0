Return-Path: <josejx@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3BC81DDFC5
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 10:53:22 +1100 (EST)
Date: Sun, 28 Oct 2007 23:53:19 +0000
From: Joseph Jezak <josejx@woodpecker.gentoo.org>
To: dtor@mail.ru
Subject: [PATCH] Prevent appletouch message log spam on 17" PB
Message-ID: <20071028235319.GB16301@woodpecker.gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, valderman@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Perhaps this was a debugging message?  In any case, this printk
causes lots of message log spam on my PB G4 1.67" (PowerBook5,9).

This removes the printk.

Signed-off by: Joseph Jezak <josejx@gentoo.org>
---

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index f132702..6c47641 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -433,7 +433,6 @@ static void atp_complete(struct urb* urb)
 		for (i = (atp_is_geyser_2(dev)?15:16); i < ATP_XSENSORS; i++) {
 			if (!dev->xy_cur[i]) continue;
 
-			printk("appletouch: 17\" model detected.\n");
 			if(atp_is_geyser_2(dev))
 				input_set_abs_params(dev->input, ABS_X, 0,
 						     (20 - 1) *
