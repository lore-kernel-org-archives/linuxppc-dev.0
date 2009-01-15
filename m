Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F6B4DE313
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 04:23:04 +1100 (EST)
Subject: [PATCH] snd-aoa: handle master-amp if present
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 15 Jan 2009 18:22:31 +0100
Message-Id: <1232040151.5839.43.camel@johannes>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>,
	ALSA development <alsa-devel@alsa-project.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some machines have a master amp GPIO that needs to be toggled to
get sound output, in addition to speaker/headphone/line-out amps.
This makes snd-aoa handle it, if present in the device tree, thus
making snd-aoa be able to output sound on PowerMac3,6, which was
previously handled by snd-powermac which also doesn't use the
master amp GPIO.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 sound/aoa/aoa-gpio.h          |    2 ++
 sound/aoa/core/gpio-feature.c |   17 ++++++++++++++++-
 sound/aoa/fabrics/layout.c    |    7 +++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

--- wireless-testing.orig/sound/aoa/aoa-gpio.h	2009-01-15 18:09:48.000000000 +0100
+++ wireless-testing/sound/aoa/aoa-gpio.h	2009-01-15 18:15:47.000000000 +0100
@@ -34,10 +34,12 @@ struct gpio_methods {
 	void (*set_headphone)(struct gpio_runtime *rt, int on);
 	void (*set_speakers)(struct gpio_runtime *rt, int on);
 	void (*set_lineout)(struct gpio_runtime *rt, int on);
+	void (*set_master)(struct gpio_runtime *rt, int on);
 
 	int (*get_headphone)(struct gpio_runtime *rt);
 	int (*get_speakers)(struct gpio_runtime *rt);
 	int (*get_lineout)(struct gpio_runtime *rt);
+	int (*get_master)(struct gpio_runtime *rt);
 
 	void (*set_hw_reset)(struct gpio_runtime *rt, int on);
 
--- wireless-testing.orig/sound/aoa/core/gpio-feature.c	2009-01-15 18:09:48.000000000 +0100
+++ wireless-testing/sound/aoa/core/gpio-feature.c	2009-01-15 18:18:09.000000000 +0100
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include "../aoa.h"
 
-/* TODO: these are 20 global variables
+/* TODO: these are lots of global variables
  * that aren't used on most machines...
  * Move them into a dynamically allocated
  * structure and use that.
@@ -23,6 +23,7 @@
 /* these are the GPIO numbers (register addresses as offsets into
  * the GPIO space) */
 static int headphone_mute_gpio;
+static int master_mute_gpio;
 static int amp_mute_gpio;
 static int lineout_mute_gpio;
 static int hw_reset_gpio;
@@ -32,6 +33,7 @@ static int linein_detect_gpio;
 
 /* see the SWITCH_GPIO macro */
 static int headphone_mute_gpio_activestate;
+static int master_mute_gpio_activestate;
 static int amp_mute_gpio_activestate;
 static int lineout_mute_gpio_activestate;
 static int hw_reset_gpio_activestate;
@@ -156,6 +158,7 @@ static int ftr_gpio_get_##name(struct gp
 FTR_GPIO(headphone, 0);
 FTR_GPIO(amp, 1);
 FTR_GPIO(lineout, 2);
+FTR_GPIO(master, 3);
 
 static void ftr_gpio_set_hw_reset(struct gpio_runtime *rt, int on)
 {
@@ -172,6 +175,8 @@ static void ftr_gpio_set_hw_reset(struct
 			  hw_reset_gpio, v);
 }
 
+static struct gpio_methods methods;
+
 static void ftr_gpio_all_amps_off(struct gpio_runtime *rt)
 {
 	int saved;
@@ -181,6 +186,8 @@ static void ftr_gpio_all_amps_off(struct
 	ftr_gpio_set_headphone(rt, 0);
 	ftr_gpio_set_amp(rt, 0);
 	ftr_gpio_set_lineout(rt, 0);
+	if (methods.set_master)
+		ftr_gpio_set_master(rt, 0);
 	rt->implementation_private = saved;
 }
 
@@ -193,6 +200,8 @@ static void ftr_gpio_all_amps_restore(st
 	ftr_gpio_set_headphone(rt, (s>>0)&1);
 	ftr_gpio_set_amp(rt, (s>>1)&1);
 	ftr_gpio_set_lineout(rt, (s>>2)&1);
+	if (methods.set_master)
+		ftr_gpio_set_master(rt, (s>>3)&1);
 }
 
 static void ftr_handle_notify(struct work_struct *work)
@@ -231,6 +240,12 @@ static void ftr_gpio_init(struct gpio_ru
 	get_gpio("hw-reset", "audio-hw-reset",
 		 &hw_reset_gpio,
 		 &hw_reset_gpio_activestate);
+	if (get_gpio("master-mute", NULL,
+		     &master_mute_gpio,
+		     &master_mute_gpio_activestate)) {
+		methods.set_master = ftr_gpio_set_master;
+		methods.get_master = ftr_gpio_get_master;
+	}
 
 	headphone_detect_node = get_gpio("headphone-detect", NULL,
 					 &headphone_detect_gpio,
--- wireless-testing.orig/sound/aoa/fabrics/layout.c	2009-01-15 18:15:28.000000000 +0100
+++ wireless-testing/sound/aoa/fabrics/layout.c	2009-01-15 18:15:47.000000000 +0100
@@ -600,6 +600,7 @@ struct layout_dev {
 	struct snd_kcontrol *headphone_ctrl;
 	struct snd_kcontrol *lineout_ctrl;
 	struct snd_kcontrol *speaker_ctrl;
+	struct snd_kcontrol *master_ctrl;
 	struct snd_kcontrol *headphone_detected_ctrl;
 	struct snd_kcontrol *lineout_detected_ctrl;
 
@@ -651,6 +652,7 @@ static struct snd_kcontrol_new n##_ctl =
 AMP_CONTROL(headphone, "Headphone Switch");
 AMP_CONTROL(speakers, "Speakers Switch");
 AMP_CONTROL(lineout, "Line-Out Switch");
+AMP_CONTROL(master, "Master Switch");
 
 static int detect_choice_get(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
@@ -891,6 +893,11 @@ static void layout_attached_codec(struct
  	lineout = codec->gpio->methods->get_detect(codec->gpio,
 						   AOA_NOTIFY_LINE_OUT);
 
+	if (codec->gpio->methods->set_master) {
+		ctl = snd_ctl_new1(&master_ctl, codec->gpio);
+		ldev->master_ctrl = ctl;
+		aoa_snd_ctl_add(ctl);
+	}
 	while (cc->connected) {
 		if (cc->connected & CC_SPEAKERS) {
 			if (headphones <= 0 && lineout <= 0)
