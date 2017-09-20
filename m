Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxwQh22hMzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 20:07:24 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h4so1023623pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 03:07:24 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 fabio.estevam@nxp.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-omap@vger.kernel.org
Subject: [PATCH 3/3] ASoC: omap-hdmi-audio: Handle return value of
 devm_kasprintf
Date: Wed, 20 Sep 2017 15:36:11 +0530
Message-Id: <1505901971-12004-4-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1505901971-12004-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1505901971-12004-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

devm_kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/omap/omap-hdmi-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 3e9cc48..8eeac7c 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -362,6 +362,9 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 
 	card->name = devm_kasprintf(dev, GFP_KERNEL,
 				    "HDMI %s", dev_name(ad->dssdev));
+	if (!card->name)
+		return -ENOMEM;
+
 	card->owner = THIS_MODULE;
 	card->dai_link =
 		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
-- 
1.9.1
