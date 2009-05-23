Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id CC03ADDFCF
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 09:12:59 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1216733yxb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 16:12:58 -0700 (PDT)
Subject: [PATCH V2 1/9] Register the wm9712 DAIs on module load
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk
From: Jon Smirl <jonsmirl@gmail.com>
Date: Sat, 23 May 2009 19:12:57 -0400
Message-ID: <20090523231257.17919.4483.stgit@terra>
In-Reply-To: <20090523231148.17919.46103.stgit@terra>
References: <20090523231148.17919.46103.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Register the wm9712 DAIs on module load

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 1fd4e88..49ad987 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -742,6 +742,18 @@ struct snd_soc_codec_device soc_codec_dev_wm9712 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9712);
 
+static int __init wm9712_modinit(void)
+{
+	return snd_soc_register_dais(wm9712_dai, ARRAY_SIZE(wm9712_dai));
+}
+module_init(wm9712_modinit);
+
+static void __exit wm9712_exit(void)
+{
+	snd_soc_unregister_dais(wm9712_dai, ARRAY_SIZE(wm9712_dai));
+}
+module_exit(wm9712_exit);
+
 MODULE_DESCRIPTION("ASoC WM9711/WM9712 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
