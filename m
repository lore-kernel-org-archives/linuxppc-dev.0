Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E63367B90
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 06:19:40 +1000 (EST)
Message-ID: <55230.84.135.251.38.1153081157.squirrel@secure.sipsolutions.net>
In-Reply-To: <1153065707.5905.8.camel@localhost.localdomain>
References: <200607161441.19930.perchrh@pvv.org>
	<1153065707.5905.8.camel@localhost.localdomain>
Date: Sun, 16 Jul 2006 22:19:17 +0200 (CEST)
Subject: [PATCH] aoa: fix feature-call GPIO layer
From: "Johannes Berg" <johannes@sipsolutions.net>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Cc: Per Christian Henden <perchrh@pvv.org>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I hope this isn't too badly mangled... I'm without a proper mail client
right now because my ~ is corrupted enough to be put offline once I access
it a lot :/ I intend to repair this tomorrow, so if it is mangled I can
resend Tuesday.
---
This fixes the feature-call GPIO layer in snd-aoa which is used on
machines without platform functions so that it doesn't try to look up an
interrupt property for detect device nodes that don't exist.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Index: linux-2.6-fetch/sound/aoa/core/snd-aoa-gpio-feature.c
===================================================================
--- linux-2.6-fetch.orig/sound/aoa/core/snd-aoa-gpio-feature.c	2006-07-16
22:10:02.467630929 +0200
+++ linux-2.6-fetch/sound/aoa/core/snd-aoa-gpio-feature.c	2006-07-16
22:13:41.891630929 +0200
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
