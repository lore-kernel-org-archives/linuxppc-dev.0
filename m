Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D5C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:20:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58942087C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58942087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xXkG62rWzF3mv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 09:20:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xXWJ1GxZzF3gs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 09:11:23 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id z33so22704291otz.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 14:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LaouoqkD3ttluPI7bXedx27zbuxr7w/ViN2uhOKU2JI=;
 b=WvXcuWkXyYULrvAmPkih//ssH7bfn0vg9y/TIs+PnZoE4PupU0bvXxzB21UuBM6Nug
 bZsscwAcHrE2er13eyIN5Azu0DkhyQaS3vMDultGP1jl2T7rfBNUos1KzWK772muztlj
 cLMP7Yaa38/dbGHeDSh9x1kZ4szCIQuXz9vpXmIR74ucfxV8rjUB69sa2dALRzbx97yr
 xv7UvvLPikGVKvPi7l/eAnZiX95LZPMDKdmBvyiAhShxR9i57dnXJbW0Sfn7Sc5EroVc
 dN9WH5i2pmdAeuDhGv4CdJ4x8SQcOXvtvzAHYIrl7jnJ0GKXSCVS6f8KqNL6fEs9pKS8
 agUA==
X-Gm-Message-State: AGRZ1gLV6zgPMxMSeQe+EO6ne3aBsfOWFrv7Bu+uAh45OVIwO0b8bUT1
 5g5f1YTyCs8IfD8wiMz27w==
X-Google-Smtp-Source: AJdET5fPipeCIPit29eBQPrgdNSohEJJIo1/QR3fNnAra6GS7aOMTtVm5gZ08+xFYAVVwLgHU9kJ9A==
X-Received: by 2002:a9d:738a:: with SMTP id j10mr7731660otk.188.1542406281963; 
 Fri, 16 Nov 2018 14:11:21 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net.
 [166.173.57.127]) by smtp.googlemail.com with ESMTPSA id
 p204-v6sm12142631oib.25.2018.11.16.14.11.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Nov 2018 14:11:21 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: aoa: Use device_type helpers to access the node type
Date: Fri, 16 Nov 2018 16:11:04 -0600
Message-Id: <20181116221104.23024-8-robh@kernel.org>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Replace the open coded iterating over child nodes with
for_each_child_of_node() while we're here.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/aoa/fabrics/layout.c | 4 ++--
 sound/aoa/soundbus/core.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 1eddf8fa188f..3a23fd032611 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1008,8 +1008,8 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 		return -ENODEV;
 
 	/* by breaking out we keep a reference */
-	while ((sound = of_get_next_child(sdev->ofdev.dev.of_node, sound))) {
-		if (sound->type && strcasecmp(sound->type, "soundchip") == 0)
+	for_each_child_of_node(sdev->ofdev.dev.of_node, sound) {
+		if (of_node_is_type(sound, "soundchip"))
 			break;
 	}
 	if (!sound)
diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index 70bcaa7f93dd..f3076a3f7f2f 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -78,7 +78,7 @@ static int soundbus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (retval)
 		return retval;
 
-	retval = add_uevent_var(env, "OF_TYPE=%s", of->dev.of_node->type);
+	retval = add_uevent_var(env, "OF_TYPE=%s", of_node_get_device_type(of->dev.of_node));
 	if (retval)
 		return retval;
 
-- 
2.19.1

