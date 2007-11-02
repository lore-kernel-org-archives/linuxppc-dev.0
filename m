Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C5160DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Nov 2007 04:52:25 +1100 (EST)
Subject: [PATCH] [ML403-AC97CR] Fix capture/periodic overrun bug.
From: Joachim Foerster <mls.JOFT@gmx.de>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	alsa-devel <alsa-devel@alsa-project.org>
Content-Type: text/plain
Date: Fri, 02 Nov 2007 18:52:19 +0100
Message-Id: <1194025939.29723.22.camel@localhost>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

this is a bug fix for my ALSA driver I posted in August. Since then I
hadn't the time to look at it, but some days ago I took some time and
found the reason why there are so many overruns while capturing.
Furthermore, this patch removes the one "heavy" printk for capture
debugging.

From: Joachim Foerster <JOFT@gmx.de>

We have to do fairly accurate counting of the minimal periods, instead
of being lazy and just setting the number to zero as soon as one period
elapses.

Signed-off-by: Joachim Foerster <JOFT@gmx.de>
---
 sound/drivers/ml403-ac97cr.c  |    6 ++----
 sound/drivers/pcm-indirect2.c |   20 ++------------------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 2636249..1b16a21 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -28,11 +28,9 @@
  * accesses to a minimum, because after a variable amount of accesses, the AC97
  * controller doesn't raise the register access finished bit anymore ...
  *
- * - Capture support works - basically, but after ~30s (with rates > ~20kHz)
- * ALSA stops reading captured samples from the intermediate buffer and
- * therefore a overrun happens - ATM I don't know what's wrong.
- *
  * - Playback support seems to be pretty stable - no issues here.
+ * - Capture support "works" now, too. Overruns don't happen any longer so often.
+ *   But there might still be some ...
  */
 
 #include <sound/driver.h>
diff --git a/sound/drivers/pcm-indirect2.c b/sound/drivers/pcm-indirect2.c
index a36215a..ef74a38 100644
--- a/sound/drivers/pcm-indirect2.c
+++ b/sound/drivers/pcm-indirect2.c
@@ -403,7 +403,7 @@ snd_pcm_indirect2_playback_interrupt(struct snd_pcm_substream *substream,
 					  rec->min_multiple);
 		rec->mul_elapsed++;
 #endif
-		rec->min_periods = 0;
+		rec->min_periods = (rec->min_periods % rec->min_multiple);
 		snd_pcm_period_elapsed(substream);
 	}
 }
@@ -568,24 +568,8 @@ snd_pcm_indirect2_capture_interrupt(struct snd_pcm_substream *substream,
 		rec->mul_elapsed_real += (rec->min_periods /
 					  rec->min_multiple);
 		rec->mul_elapsed++;
-
-		if (!(rec->mul_elapsed % 4)) {
-			struct snd_pcm_runtime *runtime = substream->runtime;
-			unsigned int appl_ptr =
-			    frames_to_bytes(runtime,
-					    (unsigned int)runtime->control->
-					    appl_ptr) % rec->sw_buffer_size;
-			int diff = rec->sw_data - appl_ptr;
-			if (diff < 0)
-				diff += rec->sw_buffer_size;
-			snd_printk(KERN_DEBUG
-				   "STAT: mul_elapsed: %d, sw_data: %u, "
-				   "appl_ptr (bytes): %u, diff: %d\n",
-				   rec->mul_elapsed, rec->sw_data, appl_ptr,
-				   diff);
-		}
 #endif
-		rec->min_periods = 0;
+		rec->min_periods = (rec->min_periods % rec->min_multiple);
 		snd_pcm_period_elapsed(substream);
 	}
 }
-- 
1.5.2.5
