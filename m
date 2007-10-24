Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4B03DDEFA
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 23:10:34 +1000 (EST)
Subject: [PATCH v2] appletouch: fix fountain touchpad breakage
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dtor@mail.ru>
In-Reply-To: <1193222676.4510.5.camel@johannes.berg>
References: <1193222676.4510.5.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 24 Oct 2007 13:29:02 +0200
Message-Id: <1193225342.4510.16.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Ekblad <valderman@gmail.com>, Sven Anders <anders@anduras.de>,
	Soeren Sonnenburg <debianppc-ml@nn7.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch 46249ea60fbb61a72ee6929b831b1f3e6865f024 was obviously done
without testing on a fountain touchpad. It causes appletouch to
continuously printk:

drivers/input/mouse/appletouch.c: Could not do mode read request from device (Geyser 3 mode)

because the fountain touchpad doesn't respond to that. The patch description
also states:

> if we see 10 empty packets the touchpad needs to be reset; good
> touchpads should not send empty packets anyway.

which is *TOTALLY* bogus since fountain touchpads have no notion of
empty packets, the simply continuously send measurements. One look at
the specification would have confirmed that.

This reverts the clueless commit, a better solution for geyser 1
touchpads must be found.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
What I'd advocate for 2.6.25 is to split appletouch into two drivers:
"appletouch" for fountain touchpads and maybe "appletouch2" for geyser
touchpads, this will get rid of many of the huge if statements in the
packet processing path and make sure that the macbook crowd will no
longer have to workaround the powerbook touchpads seeing that we seem to
hardly talk to each other.

Or maybe Soeren Sonnenburg's rewrite could be used for Geyser touchpads.

 drivers/input/mouse/appletouch.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- linux-2.6.orig/drivers/input/mouse/appletouch.c	2007-10-24 12:37:39.140210069 +0200
+++ linux-2.6/drivers/input/mouse/appletouch.c	2007-10-24 12:37:50.000215820 +0200
@@ -504,22 +504,25 @@ static void atp_complete(struct urb* urb
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
-	input_report_key(dev->input, BTN_LEFT, key);
-	input_sync(dev->input);
-
-	/* Many Geysers will continue to send packets continually after
+	/* Geyser 3 will continue to send packets continually after
 	   the first touch unless reinitialised. Do so if it's been
 	   idle for a while in order to avoid waking the kernel up
 	   several hundred times a second */
 
-	if (!x && !y && !key) {
-		dev->idlecount++;
-		if (dev->idlecount == 10) {
-			dev->valid = 0;
-			schedule_work(&dev->work);
+	if (atp_is_geyser_3(dev)) {
+		if (!x && !y && !key) {
+			dev->idlecount++;
+			if (dev->idlecount == 10) {
+				dev->valid = 0;
+				schedule_work(&dev->work);
+			}
 		}
-	} else
-		dev->idlecount = 0;
+		else
+			dev->idlecount = 0;
+	}
+
+	input_report_key(dev->input, BTN_LEFT, key);
+	input_sync(dev->input);
 
 exit:
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
