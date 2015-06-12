Return-Path: <lambert.quentin@gmail.com>
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com
 [IPv6:2a00:1450:400c:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 257031A0554
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 18:39:25 +1000 (AEST)
Received: by wgme6 with SMTP id e6so19432806wgm.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 01:39:20 -0700 (PDT)
From: Quentin Lambert <lambert.quentin@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
 Quentin Lambert <lambert.quentin@gmail.com>
Subject: [PATCH v3] ALSA: aoa: convert bus code to use dev_groups
Date: Fri, 12 Jun 2015 10:38:41 +0200
Message-Id: <1434098322-12178-1-git-send-email-lambert.quentin@gmail.com>
In-Reply-To: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The dev_attrs field of struct bus_type is going away, sue dev_groups instead.
This converts the soundbus code to use the correct field.

These modifications were made using Coccinelle.

Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
---
 Changes since v2:
  - Revert to the version of the patch where the files weren't merge.
  - Add a comment line to explain where xxx_attrs is defined as suggested by
    Takashi. 
 sound/aoa/soundbus/core.c     |    4 +++-
 sound/aoa/soundbus/soundbus.h |    2 +-
 sound/aoa/soundbus/sysfs.c    |   13 ++++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -150,6 +150,8 @@ static int soundbus_device_resume(struct
 
 #endif /* CONFIG_PM */
 
+/* soundbus_dev_attrs is declared in sysfs.c */
+ATTRIBUTE_GROUPS(soundbus_dev);
 static struct bus_type soundbus_bus_type = {
 	.name		= "aoa-soundbus",
 	.probe		= soundbus_probe,
@@ -160,7 +162,7 @@ static struct bus_type soundbus_bus_type
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
