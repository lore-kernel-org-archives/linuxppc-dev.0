Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04DCC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:16:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779AF208E7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779AF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43994H0mk4zDqdS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:16:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398W26ZtdzDqyh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:51:26 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id v6so18645608oif.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qMVKbQQ2IkPQlwBHD7jq1zN5axWgXmiq34kQVyq7TYw=;
 b=ceiAtuPq/U0QvyJpYaIKxorGzS6lSnbHsskmupF4T7+1ROU2cNXT07NwGeCkgop/kj
 /HlDCLMSmtpBW+GWJuOCqR3ys9AQP9xvNefN5NpubjQCu88rI1Iukuk/sX5szcPc1oWF
 9l20RndF2hX7gQWINV1Ewe7l2mAY2RjZNdKrL11RfgzBc8KKkPLleEbSGJJEW5SuzsUi
 ixVfqtz96lYxADUhTqw/hFPzDWiCJK7R+Q9WTxFHghjjRG+rJVWGVfDnul1l2KQMsJ5Z
 gL2B3T2phXE7FVSlNi3qEiJXaBMm0hr/6O9eTNqXvPieKqNqV/5TKDh5K2a6wxwmmB4l
 9gnA==
X-Gm-Message-State: AA+aEWato7M1ynIRYjy120jrvr8jWwMCgoQjE8KBYlhyu6JVQ8ZsWbA5
 Mvb6z1fkeWiZWZ7vI5h5Wg==
X-Google-Smtp-Source: AFSGD/WdroYapRHGtB0zgN2RHLmwEfNnpn29lkyPbXz+aqb5/YoJqwR5izMRaf1JxojWo4ircDNR9g==
X-Received: by 2002:aca:b642:: with SMTP id g63mr14811654oif.195.1544039485103; 
 Wed, 05 Dec 2018 11:51:25 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:24 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:46 -0600
Message-Id: <20181205195050.4759-30-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Paul Mackerras <paulus@samba.org>,
 Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

A couple of open coded iterating thru the child node names are converted
to use for_each_child_of_node() instead.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/aoa/fabrics/layout.c       | 2 +-
 sound/aoa/soundbus/i2sbus/core.c | 6 +++---
 sound/ppc/pmac.c                 | 4 ++--
 sound/ppc/tumbler.c              | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 3a23fd032611..8797d42e2b76 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -776,7 +776,7 @@ static int check_codec(struct aoa_codec *codec,
 	struct codec_connection *cc;
 
 	/* if the codec has a 'codec' node, we require a reference */
-	if (codec->node && (strcmp(codec->node->name, "codec") == 0)) {
+	if (of_node_name_eq(codec->node, "codec")) {
 		snprintf(propname, sizeof(propname),
 			 "platform-%s-codec-ref", codec->name);
 		ref = of_get_property(ldev->sound, propname, NULL);
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index bd7c5029fc59..c3f57a3fb1a5 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -154,7 +154,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 			  struct device_node *np)
 {
 	struct i2sbus_dev *dev;
-	struct device_node *child = NULL, *sound = NULL;
+	struct device_node *child, *sound = NULL;
 	struct resource *r;
 	int i, layout = 0, rlen, ok = force;
 	char node_name[6];
@@ -177,8 +177,8 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 		return 0;
 
 	i = 0;
-	while ((child = of_get_next_child(np, child))) {
-		if (strcmp(child->name, "sound") == 0) {
+	for_each_child_of_node(np, child) {
+		if (of_node_name_eq(child, "sound")) {
 			i++;
 			sound = child;
 		}
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 48dd44f8e914..d692e4070167 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -908,7 +908,7 @@ static void detect_byte_swap(struct snd_pmac *chip)
 
 	/* if seems that Keylargo can't byte-swap  */
 	for (mio = chip->node->parent; mio; mio = mio->parent) {
-		if (strcmp(mio->name, "mac-io") == 0) {
+		if (of_node_name_eq(mio, "mac-io")) {
 			if (of_device_is_compatible(mio, "Keylargo"))
 				chip->can_byte_swap = 0;
 			break;
@@ -1313,7 +1313,7 @@ int snd_pmac_new(struct snd_card *card, struct snd_pmac **chip_return)
 	} else if (chip->is_pbook_G3) {
 		struct device_node* mio;
 		for (mio = chip->node->parent; mio; mio = mio->parent) {
-			if (strcmp(mio->name, "mac-io") == 0) {
+			if (of_node_name_eq(mio, "mac-io")) {
 				struct resource r;
 				if (of_address_to_resource(mio, 0, &r) == 0)
 					chip->macio_base =
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 0779a2912237..6d7ffffcce95 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1365,8 +1365,8 @@ int snd_pmac_tumbler_init(struct snd_pmac *chip)
 	mix->anded_reset = 0;
 	mix->reset_on_sleep = 1;
 
-	for (np = chip->node->child; np; np = np->sibling) {
-		if (!strcmp(np->name, "sound")) {
+	for_each_child_of_node(chip->node, np) {
+		if (of_node_name_eq(np, "sound")) {
 			if (of_get_property(np, "has-anded-reset", NULL))
 				mix->anded_reset = 1;
 			if (of_get_property(np, "layout-id", NULL))
-- 
2.19.1

