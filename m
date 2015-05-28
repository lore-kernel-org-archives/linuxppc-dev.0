Return-Path: <lambert.quentin@gmail.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com
 [IPv6:2a00:1450:400c:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BDE51A11C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 22:49:04 +1000 (AEST)
Received: by wizo1 with SMTP id o1so60755784wiz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 05:49:01 -0700 (PDT)
From: Quentin Lambert <lambert.quentin@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
 Quentin Lambert <lambert.quentin@gmail.com>
Subject: [PATCH] ALSA: aoa: convert bus code to use dev_groups
Date: Thu, 28 May 2015 14:48:27 +0200
Message-Id: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

You should use dev_groups instead of the dev_attrs field of struct
bus_type. This converts the MDIO bus code to use the correct field.

These modifications were made using Coccinelle.

Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
---
 sound/aoa/soundbus/core.c     |    3 ++-
 sound/aoa/soundbus/soundbus.h |    2 +-
 sound/aoa/soundbus/sysfs.c    |   13 ++++++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)

--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -150,6 +150,7 @@ static int soundbus_device_resume(struct
 
 #endif /* CONFIG_PM */
 
+ATTRIBUTE_GROUPS(soundbus_dev);
 static struct bus_type soundbus_bus_type = {
 	.name		= "aoa-soundbus",
 	.probe		= soundbus_probe,
@@ -160,7 +161,7 @@ static struct bus_type soundbus_bus_type
 	.suspend	= soundbus_device_suspend,
 	.resume		= soundbus_device_resume,
 #endif
-	.dev_attrs	= soundbus_dev_attrs,
+	.dev_groups	= soundbus_dev_groups,
 };
 
 int soundbus_add_one(struct soundbus_dev *dev)
--- a/sound/aoa/soundbus/soundbus.h
+++ b/sound/aoa/soundbus/soundbus.h
@@ -199,6 +199,6 @@ struct soundbus_driver {
 extern int soundbus_register_driver(struct soundbus_driver *drv);
 extern void soundbus_unregister_driver(struct soundbus_driver *drv);
 
-extern struct device_attribute soundbus_dev_attrs[];
+extern struct attribute *soundbus_dev_attrs[];
 
 #endif /* __SOUNDBUS_H */
--- a/sound/aoa/soundbus/sysfs.c
+++ b/sound/aoa/soundbus/sysfs.c
@@ -30,13 +30,16 @@ static ssize_t modalias_show(struct devi
 
 	return length;
 }
+static DEVICE_ATTR_RO(modalias);
 
 soundbus_config_of_attr (name, "%s\n");
+static DEVICE_ATTR_RO(name);
 soundbus_config_of_attr (type, "%s\n");
+static DEVICE_ATTR_RO(type);
 
-struct device_attribute soundbus_dev_attrs[] = {
-	__ATTR_RO(name),
-	__ATTR_RO(type),
-	__ATTR_RO(modalias),
-	__ATTR_NULL
+struct attribute *soundbus_dev_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_type.attr,
+	&dev_attr_modalias.attr,
+	NULL,
 };
