Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9E3C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:19:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C484208E7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C484208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43996t5JLtzDqWB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:19:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398W51R5YzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:51:29 +1100 (AEDT)
Received: by mail-oi1-f194.google.com with SMTP id t204so18617009oie.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QICrhOBU8T2PisormMUNd01epFjj+h80GHQhRmRoAOU=;
 b=TkTWEBnW2rky4bEbtVOMT/5ssIOS/HRTeFVJ6pofoqDN2CQRJTyBv0o5gvY7oJc5GE
 7/W7KsXrVgZ3cz1367oiXXMRuy6JskLvL8pEvOqor2gRgwaWCcTDImJ0m2V+Vmjg+hLN
 t4iFoAPNEGBGof8+rks7LHB8T74FTZsiMSG4l/xXVLCKTdTuc/zk4gKYGuQ31kkiafmJ
 I570mQd2MkOc/ZjJktBXOYZbaPalMGngn3kt3OZA0k+ntXb15fy7ttr4Fg9VU5/CAhEH
 bFkx8w5B9TV+72FLvrlXrbGj7sr5ISzv0MuHAy+Kr43nJMjNp6NxaHt4mdMLnRLK+zc9
 MYIw==
X-Gm-Message-State: AA+aEWbmEp3XKajekw8sq7u9YmpqI0mUQZz5fCku0laa+U/L4CuR3zIe
 p1xao8NALgfyGfEuHB1dvg==
X-Google-Smtp-Source: AFSGD/VvPbw6yCp5lGcRidYRNt3VMLROhi3MK5kDSyoSQ5nVB1au0UQ5ntp9WmNVOn4bqxa2AnqauQ==
X-Received: by 2002:aca:4282:: with SMTP id
 p124mr15080611oia.327.1544039487106; 
 Wed, 05 Dec 2018 11:51:27 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:26 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: soundbus: Remove direct OF name and type accesses
Date: Wed,  5 Dec 2018 13:50:48 -0600
Message-Id: <20181205195050.4759-32-robh@kernel.org>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert soundbus uevent and sysfs OF node name and device type usage to
use printf specifier and helper functions instead of directly accessing
the name and type pointers. This will allow the eventual removal of the
pointers.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/aoa/soundbus/core.c  |  2 +-
 sound/aoa/soundbus/sysfs.c | 34 +++++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index f3076a3f7f2f..065d3a55725e 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -74,7 +74,7 @@ static int soundbus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	of = &soundbus_dev->ofdev;
 
 	/* stuff we want to pass to /sbin/hotplug */
-	retval = add_uevent_var(env, "OF_NAME=%s", of->dev.of_node->name);
+	retval = add_uevent_var(env, "OF_NAME=%pOFn", of->dev.of_node);
 	if (retval)
 		return retval;
 
diff --git a/sound/aoa/soundbus/sysfs.c b/sound/aoa/soundbus/sysfs.c
index 81da020bddef..a2d55e15afbb 100644
--- a/sound/aoa/soundbus/sysfs.c
+++ b/sound/aoa/soundbus/sysfs.c
@@ -1,18 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/stat.h>
 /* FIX UP */
 #include "soundbus.h"
 
-#define soundbus_config_of_attr(field, format_string)			\
-static ssize_t								\
-field##_show (struct device *dev, struct device_attribute *attr,	\
-              char *buf)						\
-{									\
-	struct soundbus_dev *mdev = to_soundbus_device (dev);		\
-	return sprintf (buf, format_string, mdev->ofdev.dev.of_node->field); \
-}
-
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -25,17 +17,33 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 		strcat(buf, "\n");
 		length = strlen(buf);
 	} else {
-		length = sprintf(buf, "of:N%sT%s\n",
-				 of->dev.of_node->name, of->dev.of_node->type);
+		length = sprintf(buf, "of:N%pOFn%c%s\n",
+				 of->dev.of_node, 'T',
+                                 of_node_get_device_type(of->dev.of_node));
 	}
 
 	return length;
 }
 static DEVICE_ATTR_RO(modalias);
 
-soundbus_config_of_attr (name, "%s\n");
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct soundbus_dev *sdev = to_soundbus_device(dev);
+	struct platform_device *of = &sdev->ofdev;
+
+	return sprintf(buf, "%pOFn\n", of->dev.of_node);
+}
 static DEVICE_ATTR_RO(name);
-soundbus_config_of_attr (type, "%s\n");
+
+static ssize_t type_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct soundbus_dev *sdev = to_soundbus_device(dev);
+	struct platform_device *of = &sdev->ofdev;
+
+	return sprintf(buf, "%s\n", of_node_get_device_type(of->dev.of_node));
+}
 static DEVICE_ATTR_RO(type);
 
 struct attribute *soundbus_dev_attrs[] = {
-- 
2.19.1

