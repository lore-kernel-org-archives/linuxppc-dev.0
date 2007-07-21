Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CDAA9DDE17
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 00:29:28 +1000 (EST)
Date: Sun, 22 Jul 2007 00:29:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: johannes@sipsolutions.net
Subject: [PATCH] Fix tas_suspend/resume build warning
Message-Id: <20070722002937.11e234f8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


sound/aoa/codecs/snd-aoa-codec-tas.c:750: warning: 'tas_suspend' defined but not used
sound/aoa/codecs/snd-aoa-codec-tas.c:760: warning: 'tas_resume' defined but not used

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/aoa/codecs/snd-aoa-codec-tas.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c b/sound/aoa/codecs/snd-aoa-codec-tas.c
index 2f771f5..3cbfe46 100644
--- a/sound/aoa/codecs/snd-aoa-codec-tas.c
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -743,6 +743,7 @@ static int tas_switch_clock(struct codec_info_item *cii, enum clock_switch clock
 	return 0;
 }
 
+#ifdef CONFIG_PM
 /* we are controlled via i2c and assume that is always up
  * If that wasn't the case, we'd have to suspend once
  * our i2c device is suspended, and then take note of that! */
@@ -768,7 +769,6 @@ static int tas_resume(struct tas *tas)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int _tas_suspend(struct codec_info_item *cii, pm_message_t state)
 {
 	return tas_suspend(cii->codec_data);
@@ -778,7 +778,10 @@ static int _tas_resume(struct codec_info_item *cii)
 {
 	return tas_resume(cii->codec_data);
 }
-#endif
+#else /* CONFIG_PM */
+#define _tas_suspend	NULL
+#define _tas_resume	NULL
+#endif /* CONFIG_PM */
 
 static struct codec_info tas_codec_info = {
 	.transfers = tas_transfers,
@@ -791,10 +794,8 @@ static struct codec_info tas_codec_info = {
 	.owner = THIS_MODULE,
 	.usable = tas_usable,
 	.switch_clock = tas_switch_clock,
-#ifdef CONFIG_PM
 	.suspend = _tas_suspend,
 	.resume = _tas_resume,
-#endif
 };
 
 static int tas_init_codec(struct aoa_codec *codec)
-- 
1.5.2.3
