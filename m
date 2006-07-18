Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DC0767B88
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 04:43:28 +1000 (EST)
Message-Id: <20060718173012.532719000@sipsolutions.net>>
References: <20060718172841.046446000@sipsolutions.net>>
Date: Tue, 18 Jul 2006 19:28:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] aoa: feature gpio layer: fix IRQ access
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The IRQ rework caused some hiccups here, in some cases we call
get_irq without a device node. This patch makes it catch that
case and return NO_IRQ when it happens, along with changing the
place where the irq is checked to check for NO_IRQ instead of -1.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/core/snd-aoa-gpio-feature.c	2006-07-16 22:10:02.467630929 +0200
+++ linux-2.6-fetch/sound/aoa/core/snd-aoa-gpio-feature.c	2006-07-16 22:13:41.891630929 +0200
@@ -112,7 +112,10 @@ static struct device_node *get_gpio(char
 
 static void get_irq(struct device_node * np, int *irqptr)
 {
-	*irqptr = irq_of_parse_and_map(np, 0);
+	if (np)
+		*irqptr = irq_of_parse_and_map(np, 0);
+	else
+		*irqptr = NO_IRQ;
 }
 
 /* 0x4 is outenable, 0x1 is out, thus 4 or 5 */
@@ -322,7 +325,7 @@ static int ftr_set_notify(struct gpio_ru
 		return -EINVAL;
 	}
 
-	if (irq == -1)
+	if (irq == NO_IRQ)
 		return -ENODEV;
 
 	mutex_lock(&notif->mutex);

--
