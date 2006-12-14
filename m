Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC43467C0A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 01:31:56 +1100 (EST)
Subject: [PATCH] snd-aoa: fix onyx resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 15:27:48 +0100
Message-Id: <1166106468.3161.6.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ALSA development <alsa-devel@alsa-project.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When the machine resumes the onyx codec might be in a weird state. Hence,
simply fully reset it once (and keep the code to take it out of suspend in
case the suspend of the codec chip survives a reset).

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
There's another problem with i2sbus suspend, namely that the i2sbus code
doesn't really handle a suspend well at all, it needs to re-init the
hardware during resume. I noticed because firmware on the quad powermac
doesn't set the i2sbus to 44.1kHz but 42kHz or something like that so
when I was playing a song across suspend/resume it ended up slower...

I don't want to fix this until that i2sbus control rewrite/fix though
because it'll most likely collide.

Takashi, please apply this fix. 

--- linux-2.6-git.orig/sound/aoa/codecs/snd-aoa-codec-onyx.c	2006-12-13 19:32:38.520763489 +0100
+++ linux-2.6-git/sound/aoa/codecs/snd-aoa-codec-onyx.c	2006-12-13 19:34:58.597763489 +0100
@@ -825,7 +825,16 @@ static int onyx_resume(struct codec_info
 	int err = -ENXIO;
 
 	mutex_lock(&onyx->mutex);
-	/* take codec out of suspend */
+
+	/* reset codec */
+	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 0);
+	msleep(1);
+	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 1);
+	msleep(1);
+	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 0);
+	msleep(1);
+
+	/* take codec out of suspend (if it still is after reset) */
 	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
 		goto out_unlock;
 	onyx_write_register(onyx, ONYX_REG_CONTROL, v & ~(ONYX_ADPSV | ONYX_DAPSV));
