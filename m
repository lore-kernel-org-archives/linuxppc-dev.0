Return-Path: <dan.carpenter@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "userp1050.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B700E2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 19:19:15 +1100 (EST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id
 rAD7jw8Q008050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 07:45:59 GMT
Date: Wed, 13 Nov 2013 10:45:20 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: [patch] ALSA: snd-aoa: two copy and paste bugs
Message-ID: <20131113074520.GD25541@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These functions were cut and paste and the tests for NULL weren't
updated properly.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 61ab640..9dc5806 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -644,7 +644,7 @@ static int n##_control_put(struct snd_kcontrol *kcontrol,		\
 			   struct snd_ctl_elem_value *ucontrol)		\
 {									\
 	struct gpio_runtime *gpio = snd_kcontrol_chip(kcontrol);	\
-	if (gpio->methods && gpio->methods->get_##n)			\
+	if (gpio->methods && gpio->methods->set_##n)			\
 		gpio->methods->set_##n(gpio,				\
 			!!ucontrol->value.integer.value[0]);		\
 	return 1;							\
@@ -1135,7 +1135,7 @@ static int aoa_fabric_layout_resume(struct soundbus_dev *sdev)
 {
 	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
 
-	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_off)
+	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_restore)
 		ldev->gpio.methods->all_amps_restore(&ldev->gpio);
 
 	return 0;
