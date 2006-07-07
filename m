Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7171E67B53
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:15 +1000 (EST)
Message-Id: <20060707165531.206137000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/12] aoa: pmf gpio: report if function calling fails
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the pmf GPIO layer in aoa report if calling
a platform function failed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/core/snd-aoa-gpio-pmf.c	2006-07-07 12:15:39.657697157 +0200
+++ linux-2.6-fetch/sound/aoa/core/snd-aoa-gpio-pmf.c	2006-07-07 12:15:54.207697157 +0200
@@ -14,9 +14,13 @@
 static void pmf_gpio_set_##name(struct gpio_runtime *rt, int on)\
 {								\
 	struct pmf_args args = { .count = 1, .u[0].v = !on };	\
-								\
+	int rc;							\
+							\
 	if (unlikely(!rt)) return;				\
-	pmf_call_function(rt->node, #name "-mute", &args);	\
+	rc = pmf_call_function(rt->node, #name "-mute", &args);	\
+	if (rc)							\
+		printk(KERN_WARNING "pmf_gpio_set_" #name	\
+		" failed, rc: %d\n", rc);			\
 	rt->implementation_private &= ~(1<<bit);		\
 	rt->implementation_private |= (!!on << bit);		\
 }								\
@@ -33,9 +37,13 @@ PMF_GPIO(lineout, 2);
 static void pmf_gpio_set_hw_reset(struct gpio_runtime *rt, int on)
 {
 	struct pmf_args args = { .count = 1, .u[0].v = !!on };
+	int rc;
 
 	if (unlikely(!rt)) return;
-	pmf_call_function(rt->node, "hw-reset", &args);
+	rc = pmf_call_function(rt->node, "hw-reset", &args);
+	if (rc)
+		printk(KERN_WARNING "pmf_gpio_set_hw_reset"
+		       " failed, rc: %d\n", rc);
 }
 
 static void pmf_gpio_all_amps_off(struct gpio_runtime *rt)

--
