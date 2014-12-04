Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D6C21A0588
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 03:42:20 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4F10C1400E9
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 03:42:18 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 2/2] sound: ppc: keywest: drop using attach adapter
Date: Thu,  4 Dec 2014 17:41:53 +0100
Message-Id: <1417711313-7257-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1417711313-7257-1-git-send-email-wsa@the-dreams.de>
References: <1417711313-7257-1-git-send-email-wsa@the-dreams.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we now have deferred probing, we can use a custom mechanism and
finally get rid of the legacy interface from the i2c core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 sound/ppc/keywest.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 0d1c27e911b8..a957f32368fa 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -52,7 +52,7 @@ static int keywest_attach_adapter(struct i2c_adapter *adapter)
 		return -EINVAL;
 
 	if (strncmp(adapter->name, "mac-io", 6))
-		return 0; /* ignored */
+		return -EINVAL; /* ignored */
 
 	memset(&info, 0, sizeof(struct i2c_board_info));
 	strlcpy(info.type, "keywest", I2C_NAME_SIZE);
@@ -100,7 +100,6 @@ static struct i2c_driver keywest_driver = {
 	.driver = {
 		.name = "PMac Keywest Audio",
 	},
-	.attach_adapter = keywest_attach_adapter,
 	.probe = keywest_probe,
 	.remove = keywest_remove,
 	.id_table = keywest_i2c_id,
@@ -132,16 +131,32 @@ int snd_pmac_tumbler_post_init(void)
 /* exported */
 int snd_pmac_keywest_init(struct pmac_keywest *i2c)
 {
-	int err;
+	struct i2c_adapter *adap;
+	int err, i = 0;
 
 	if (keywest_ctx)
 		return -EBUSY;
 
+	adap = i2c_get_adapter(0);
+	if (!adap)
+		return -EPROBE_DEFER;
+
 	keywest_ctx = i2c;
 
 	if ((err = i2c_add_driver(&keywest_driver))) {
 		snd_printk(KERN_ERR "cannot register keywest i2c driver\n");
+		i2c_put_adapter(adap);
 		return err;
 	}
+
+	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
+	while (adap) {
+		err = keywest_attach_adapter(adap);
+		if (!err)
+			break;
+		i2c_put_adapter(adap);
+		adap = i2c_get_adapter(++i);
+	}
+
 	return 0;
 }
-- 
2.1.3
