Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4611F679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 22:03:46 +1000 (EST)
Subject: [RFC] alsa integer control ranges
From: Johannes Berg <johannes@sipsolutions.net>
To: ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain
Date: Tue, 16 May 2006 14:02:20 +0200
Message-Id: <1147780945.29795.110.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Apparently all alsa userspace programs including alsamixer suck. Hence,
this patch is required to make them work properly. Why is it so hard to
do these additions/subtractions in the program or maybe even in the alsa
library? The alsa libraries already think they know better and mess up
all kinds of things.

What are your opinions on this? Should this be required? And if so, why
do we even have the value.integer.min when we can't use it anyway? 

The code this patch applies against is in
http://johannes.sipsolutions.net/snd-aoa.git/ but that isn't all too
relevant, the patch serves just as an illustration of what is wrong
here.

Thanks,
johannes

--- snd-aoa.orig/aoa/codecs/onyx/snd-aoa-codec-onyx.c	2006-05-16 12:13:39.663950213 +0200
+++ snd-aoa/aoa/codecs/onyx/snd-aoa-codec-onyx.c	2006-05-16 12:14:13.698643898 +0200
@@ -102,8 +102,8 @@ static int onyx_snd_vol_info(struct snd_
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
-	uinfo->value.integer.min = -128;
-	uinfo->value.integer.max = -1;
+	uinfo->value.integer.min = -128+128;
+	uinfo->value.integer.max = -1+128;
 	return 0;
 }
 
@@ -115,8 +115,8 @@ static int onyx_snd_vol_get(struct snd_k
 
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, &l);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, &r);
-	ucontrol->value.integer.value[0] = l;
-	ucontrol->value.integer.value[1] = r;
+	ucontrol->value.integer.value[0] = l+128;
+	ucontrol->value.integer.value[1] = r+128;
 	return 0;
 }
 
@@ -125,8 +125,8 @@ static int onyx_snd_vol_put(struct snd_k
 {
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 
-	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, ucontrol->value.integer.value[0]);
-	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, ucontrol->value.integer.value[1]);
+	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, ucontrol->value.integer.value[0]-128);
+	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, ucontrol->value.integer.value[1]-128);
 	/* FIXME: we could be checking if anything changed */
 	return 1;
 }
@@ -145,8 +145,8 @@ static int onyx_snd_inputgain_info(struc
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
-	uinfo->value.integer.min = 3;
-	uinfo->value.integer.max = 28;
+	uinfo->value.integer.min = 3-3;
+	uinfo->value.integer.max = 28-3;
 	return 0;
 }
 
@@ -157,7 +157,7 @@ static int onyx_snd_inputgain_get(struct
 	u8 ig;
 
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &ig);
-	ucontrol->value.integer.value[0] = ig & ONYX_ADC_PGA_GAIN_MASK;
+	ucontrol->value.integer.value[0] = (ig & ONYX_ADC_PGA_GAIN_MASK)-3;
 	return 0;
 }
 
@@ -169,7 +169,7 @@ static int onyx_snd_inputgain_put(struct
 
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &val);
 	val &= ~ONYX_ADC_PGA_GAIN_MASK;
-	val |= ucontrol->value.integer.value[0] & ONYX_ADC_PGA_GAIN_MASK;
+	val |= (ucontrol->value.integer.value[0]+3) & ONYX_ADC_PGA_GAIN_MASK;
 	onyx_write_register(onyx, ONYX_REG_ADC_CONTROL, val);
 	return 1;
 }
