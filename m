Return-Path: <roel.kluin@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id CE256DE491
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:54:00 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so13431nfd.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:53:58 -0700 (PDT)
Message-ID: <48AAEC92.8050108@gmail.com>
Date: Tue, 19 Aug 2008 11:53:54 -0400
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Subject: [alsa-devel] [PATCH v2] duplicate SNDRV_PCM_FMTBIT_S{16,24}_BE
References: <48AA407C.8090409@gmail.com>	<3ef3fed769e5aa57681bacea1230e82b.squirrel@secure.sipsolutions.net>
	<s5hbpzpxrfh.wl%tiwai@suse.de>
In-Reply-To: <s5hbpzpxrfh.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Takashi Iwai wrote:
> At Tue, 19 Aug 2008 08:15:05 +0200 (CEST),
> Johannes Berg wrote:
>> roel kluin wrote:
>>> untested, is it correct?
>> not a clue, do you know how long ago that was? :)
>> does the driver check endianness anywhere?
> 
> AFAIK snd-aoa supports only bit-endian formats (at least in
> sound/aoa/soundbus/i2sbus-pcm.c), so this addition makes little
> sense.
> 
> Better to drop the duplicated words there.

Thanks Johannes and Takashi,

FWIW this removes the duplicates.
---
Remove duplicate assignment of SNDRV_PCM_FMTBIT_S{16,24}_BE bits

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c b/sound/aoa/codecs/snd-aoa-codec-tas.c
index 7a16a33..6c515b2 100644
--- a/sound/aoa/codecs/snd-aoa-codec-tas.c
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -654,15 +654,13 @@ static struct snd_kcontrol_new bass_control = {
 static struct transfer_info tas_transfers[] = {
 	{
 		/* input */
-		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
-			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
+		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S24_BE,
 		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
 		.transfer_in = 1,
 	},
 	{
 		/* output */
-		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
-			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
+		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S24_BE,
 		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
 		.transfer_in = 0,
 	},
