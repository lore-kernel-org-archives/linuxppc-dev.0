Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9013E67B8E
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 04:43:28 +1000 (EST)
Message-Id: <20060718173018.070118000@sipsolutions.net>>
References: <20060718172841.046446000@sipsolutions.net>>
Date: Tue, 18 Jul 2006 19:28:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] aoa: platform function gpio: ignore errors from
	functions that dont exist
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

Sometimes we simply want to turn off or on everything, and when recently a
warning was added when a certain platform function can't be called, this
triggered all the time in those cases. This patch shows the warning only if
the error was different from the function not existing.

The alternative would be to not even try calling the function when it
doesn't exist by first checking which exist and then only calling those that
do, but that adds complexity that isn't necessary.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/core/snd-aoa-gpio-pmf.c	2006-07-18 19:24:30.273476868 +0200
+++ linux-2.6-fetch/sound/aoa/core/snd-aoa-gpio-pmf.c	2006-07-18 19:24:55.103476868 +0200
@@ -18,7 +18,7 @@ static void pmf_gpio_set_##name(struct g
 							\
 	if (unlikely(!rt)) return;				\
 	rc = pmf_call_function(rt->node, #name "-mute", &args);	\
-	if (rc)							\
+	if (rc && rc != -ENODEV)				\
 		printk(KERN_WARNING "pmf_gpio_set_" #name	\
 		" failed, rc: %d\n", rc);			\
 	rt->implementation_private &= ~(1<<bit);		\

--
