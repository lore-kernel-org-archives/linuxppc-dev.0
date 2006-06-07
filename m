Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC51467F00
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 23:12:06 +1000 (EST)
Message-Id: <20060607130915.761442000@sipsolutions.net>
References: <20060607130909.584205000@sipsolutions.net>
Date: Wed, 07 Jun 2006 15:09:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 08/12] snd-aoa: add toonie codec
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for the 'toonie' codec which is just a codec
without any mixer/volume control functionality and is used on
the mac mini.

--- /dev/null
+++ b/sound/aoa/codecs/snd-aoa-codec-toonie.c
@@ -0,0 +1,140 @@
+/*
+ * Apple Onboard Audio driver for Toonie codec
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ *
+ *
+ * This is a driver for the toonie codec chip. This chip is present
+ * on the Mac Mini and is nothing but a DAC.
+ */
+#include <linux/delay.h>
+#include <linux/module.h>
+MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("toonie codec driver for snd-aoa");
+
+#include "../aoa.h"
+#include "../soundbus/soundbus.h"
+
+
+#define PFX "snd-aoa-codec-toonie: "
+
+struct toonie {
+	struct aoa_codec	codec;
+};
+#define codec_to_toonie(c) container_of(c, struct toonie, codec)
+
+static int toonie_dev_register(struct snd_device *dev)
+{
+	return 0;
+}
+
+static struct snd_device_ops ops = {
+	.dev_register = toonie_dev_register,
+};
+
+static struct transfer_info toonie_transfers[] = {
+	/* This thing *only* has analog output,
+	 * the rates are taken from Info.plist
+	 * from Darwin. */
+	{
+		.formats = SNDRV_PCM_FMTBIT_S16_BE |
+			   SNDRV_PCM_FMTBIT_S24_BE,
+		.rates = SNDRV_PCM_RATE_32000 |
+			 SNDRV_PCM_RATE_44100 |
+			 SNDRV_PCM_RATE_48000 |
+			 SNDRV_PCM_RATE_88200 |
+			 SNDRV_PCM_RATE_96000,
+	},
+	{}
+};
+
+#ifdef CONFIG_PM
+static int toonie_suspend(struct codec_info_item *cii, pm_message_t state)
+{
+	/* can we turn it off somehow? */
+	return 0;
+}
+
+static int toonie_resume(struct codec_info_item *cii)
+{
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static struct codec_info toonie_codec_info = {
+	.transfers = toonie_transfers,
+	.sysclock_factor = 256,
+	.bus_factor = 64,
+	.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+	.suspend = toonie_suspend,
+	.resume = toonie_resume,
+#endif
+};
+
+static int toonie_init_codec(struct aoa_codec *codec)
+{
+	struct toonie *toonie = codec_to_toonie(codec);
+
+	if (aoa_snd_device_new(SNDRV_DEV_LOWLEVEL, toonie, &ops)) {
+		printk(KERN_ERR PFX "failed to create toonie snd device!\n");
+		return -ENODEV;
+	}
+
+	/* nothing connected? what a joke! */
+	if (toonie->codec.connected != 1)
+		return -ENOTCONN;
+
+	if (toonie->codec.soundbus_dev->attach_codec(toonie->codec.soundbus_dev,
+						     aoa_get_card(),
+						     &toonie_codec_info, toonie)) {
+		printk(KERN_ERR PFX "error creating toonie pcm\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void toonie_exit_codec(struct aoa_codec *codec)
+{
+	struct toonie *toonie = codec_to_toonie(codec);
+
+	if (!toonie->codec.soundbus_dev) {
+		printk(KERN_ERR PFX "toonie_exit_codec called without soundbus_dev!\n");
+		return;
+	}
+	toonie->codec.soundbus_dev->detach_codec(toonie->codec.soundbus_dev, toonie);
+}
+
+static struct toonie *toonie;
+
+static int __init toonie_init(void)
+{
+	toonie = kzalloc(sizeof(struct toonie), GFP_KERNEL);
+
+	if (!toonie)
+		return -ENOMEM;
+
+	strlcpy(toonie->codec.name, "toonie", sizeof(toonie->codec.name));
+	toonie->codec.owner = THIS_MODULE;
+	toonie->codec.init = toonie_init_codec;
+	toonie->codec.exit = toonie_exit_codec;
+                                        
+	if (aoa_codec_register(&toonie->codec)) {
+		kfree(toonie);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void __exit toonie_exit(void)
+{
+	kfree(toonie);
+}
+
+module_init(toonie_init);
+module_exit(toonie_exit);

--
