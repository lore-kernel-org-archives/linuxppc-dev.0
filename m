Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420Ck23rHxzF0Vv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 01:44:42 +1000 (AEST)
Received: by mail-oi0-f43.google.com with SMTP id l202-v6so3645336oig.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 08:44:42 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: [PATCH v2] sound: Convert to using %pOFn instead of device_node.name
Date: Tue, 28 Aug 2018 10:44:31 -0500
Message-Id: <20180828154433.5693-5-robh@kernel.org>
In-Reply-To: <20180828154433.5693-1-robh@kernel.org>
References: <20180828154433.5693-1-robh@kernel.org>
In-Reply-To: <20180828015252.28511-50-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Fix error in strncmp

 sound/aoa/soundbus/i2sbus/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 000b58522106..bd7c5029fc59 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -157,18 +157,19 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	struct device_node *child = NULL, *sound = NULL;
 	struct resource *r;
 	int i, layout = 0, rlen, ok = force;
-	static const char *rnames[] = { "i2sbus: %s (control)",
-					"i2sbus: %s (tx)",
-					"i2sbus: %s (rx)" };
+	char node_name[6];
+	static const char *rnames[] = { "i2sbus: %pOFn (control)",
+					"i2sbus: %pOFn (tx)",
+					"i2sbus: %pOFn (rx)" };
 	static irq_handler_t ints[] = {
 		i2sbus_bus_intr,
 		i2sbus_tx_intr,
 		i2sbus_rx_intr
 	};

-	if (strlen(np->name) != 5)
+	if (snprintf(node_name, sizeof(node_name), "%pOFn", np) != 5)
 		return 0;
-	if (strncmp(np->name, "i2s-", 4))
+	if (strncmp(node_name, "i2s-", 4))
 		return 0;

 	dev = kzalloc(sizeof(struct i2sbus_dev), GFP_KERNEL);
@@ -228,13 +229,13 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	dev->sound.pcmid = -1;
 	dev->macio = macio;
 	dev->control = control;
-	dev->bus_number = np->name[4] - 'a';
+	dev->bus_number = node_name[4] - 'a';
 	INIT_LIST_HEAD(&dev->sound.codec_list);

 	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
 		dev->interrupts[i] = -1;
 		snprintf(dev->rnames[i], sizeof(dev->rnames[i]),
-			 rnames[i], np->name);
+			 rnames[i], np);
 	}
 	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
 		int irq = irq_of_parse_and_map(np, i);
--
2.17.1
