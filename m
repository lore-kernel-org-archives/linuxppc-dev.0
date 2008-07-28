Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 546C0DDFD9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 12:06:34 +1000 (EST)
From: Trent Piepho <tpiepho@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] leds: make the default trigger name const
Date: Sun, 27 Jul 2008 19:02:21 -0700
Message-Id: <1217210541-7641-1-git-send-email-tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0807271304350.26456@t2.domain.actdsltmp>
References: <Pine.LNX.4.64.0807271304350.26456@t2.domain.actdsltmp>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The default_trigger fields of struct gpio_led and thus struct led_classdev
are pretty much always assigned from a string literal, which means the
string can't be modified.  Which is fine, since there is no reason to
modify the string and in fact it never is.

But they should be marked const to prevent such code from being added, to
prevent warnings if -Wwrite-strings is used and when assigned from a
constant string other than a string literal (which produces a warning under
current kernel compiler flags), and for general good coding practices.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 include/linux/leds.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index 519df72..defe693 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -48,7 +48,7 @@ struct led_classdev {
 
 	struct device		*dev;
 	struct list_head	 node;			/* LED Device list */
-	char			*default_trigger;	/* Trigger to use */
+	const char		*default_trigger;	/* Trigger to use */
 
 #ifdef CONFIG_LEDS_TRIGGERS
 	/* Protects the trigger data below */
@@ -121,7 +121,7 @@ extern void ledtrig_ide_activity(void);
 /* For the leds-gpio driver */
 struct gpio_led {
 	const char *name;
-	char *default_trigger;
+	const char *default_trigger;
 	unsigned 	gpio;
 	u8 		active_low;
 };
-- 
1.5.4.3
