Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31181679E1
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 18:05:40 +1000 (EST)
Subject: [PATCH] aoa: add locking to tas codec
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 10:06:16 +0200
Message-Id: <1158221176.2936.21.camel@ux156>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	alsa-devel <alsa-devel@alsa-project.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks like I completely forgot to do this. This patch adds locking to
the tas codec so two userspace programs can't hit the controls at the
same time. Tested on my powerbook, but I obviously can't find any
problems even without it since it doesn't do SMP.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- a/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-09-13 22:05:49.849647141 +0200
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-09-13 22:06:16.859647141 +0200
@@ -66,6 +66,8 @@
 #include <asm/prom.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("tas codec driver for snd-aoa");
@@ -91,6 +93,10 @@ struct tas {
 	u8			bass, treble;
 	u8			acr;
 	int			drc_range;
+	/* protects hardware access against concurrency from
+	 * userspace when hitting controls and during
+	 * codec init/suspend/resume */
+	struct mutex		mtx;
 };
 
 static int tas_reset_init(struct tas *tas);
@@ -231,8 +237,10 @@ static int tas_snd_vol_get(struct snd_kc
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->cached_volume_l;
 	ucontrol->value.integer.value[1] = tas->cached_volume_r;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -241,14 +249,18 @@ static int tas_snd_vol_put(struct snd_kc
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas->mtx);
 	if (tas->cached_volume_l == ucontrol->value.integer.value[0]
-	 && tas->cached_volume_r == ucontrol->value.integer.value[1])
+	 && tas->cached_volume_r == ucontrol->value.integer.value[1]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->cached_volume_l = ucontrol->value.integer.value[0];
 	tas->cached_volume_r = ucontrol->value.integer.value[1];
 	if (tas->hw_enabled)
 		tas_set_volume(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -276,8 +288,10 @@ static int tas_snd_mute_get(struct snd_k
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = !tas->mute_l;
 	ucontrol->value.integer.value[1] = !tas->mute_r;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -286,14 +300,18 @@ static int tas_snd_mute_put(struct snd_k
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas->mtx);
 	if (tas->mute_l == !ucontrol->value.integer.value[0]
-	 && tas->mute_r == !ucontrol->value.integer.value[1])
+	 && tas->mute_r == !ucontrol->value.integer.value[1]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->mute_l = !ucontrol->value.integer.value[0];
 	tas->mute_r = !ucontrol->value.integer.value[1];
 	if (tas->hw_enabled)
 		tas_set_volume(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -322,8 +340,10 @@ static int tas_snd_mixer_get(struct snd_
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
 
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->mixer_l[idx];
 	ucontrol->value.integer.value[1] = tas->mixer_r[idx];
+	mutex_unlock(&tas->mtx);
 
 	return 0;
 }
@@ -334,15 +354,19 @@ static int tas_snd_mixer_put(struct snd_
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
 
+	mutex_lock(&tas->mtx);
 	if (tas->mixer_l[idx] == ucontrol->value.integer.value[0]
-	 && tas->mixer_r[idx] == ucontrol->value.integer.value[1])
+	 && tas->mixer_r[idx] == ucontrol->value.integer.value[1]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->mixer_l[idx] = ucontrol->value.integer.value[0];
 	tas->mixer_r[idx] = ucontrol->value.integer.value[1];
 
 	if (tas->hw_enabled)
 		tas_set_mixer(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -375,7 +399,9 @@ static int tas_snd_drc_range_get(struct 
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->drc_range;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -384,12 +410,16 @@ static int tas_snd_drc_range_put(struct 
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	if (tas->drc_range == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->drc_range == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->drc_range = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas3004_set_drc(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -417,7 +447,9 @@ static int tas_snd_drc_switch_get(struct
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->drc_enabled;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -426,12 +458,16 @@ static int tas_snd_drc_switch_put(struct
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	if (tas->drc_enabled == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->drc_enabled == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->drc_enabled = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas3004_set_drc(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -463,7 +499,9 @@ static int tas_snd_capture_source_get(st
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas->mtx);
 	ucontrol->value.enumerated.item[0] = !!(tas->acr & TAS_ACR_INPUT_B);
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -471,15 +509,21 @@ static int tas_snd_capture_source_put(st
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
-	int oldacr = tas->acr;
+	int oldacr;
+
+	mutex_lock(&tas->mtx);
+	oldacr = tas->acr;
 
 	tas->acr &= ~TAS_ACR_INPUT_B;
 	if (ucontrol->value.enumerated.item[0])
 		tas->acr |= TAS_ACR_INPUT_B;
-	if (oldacr == tas->acr)
+	if (oldacr == tas->acr) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 	if (tas->hw_enabled)
 		tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -518,7 +562,9 @@ static int tas_snd_treble_get(struct snd
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->treble;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -527,12 +573,16 @@ static int tas_snd_treble_put(struct snd
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	if (tas->treble == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->treble == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->treble = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas_set_treble(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -560,7 +610,9 @@ static int tas_snd_bass_get(struct snd_k
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->bass;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -569,12 +621,16 @@ static int tas_snd_bass_put(struct snd_k
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	if (tas->bass == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->bass == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->bass = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas_set_bass(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -628,16 +684,16 @@ static int tas_reset_init(struct tas *ta
 
 	tmp = TAS_MCS_SCLK64 | TAS_MCS_SPORT_MODE_I2S | TAS_MCS_SPORT_WL_24BIT;
 	if (tas_write_reg(tas, TAS_REG_MCS, 1, &tmp))
-		return -ENODEV;
+		goto outerr;
 
 	tas->acr |= TAS_ACR_ANALOG_PDOWN | TAS_ACR_B_MONAUREAL |
 		TAS_ACR_B_MON_SEL_RIGHT;
 	if (tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr))
-		return -ENODEV;
+		goto outerr;
 
 	tmp = 0;
 	if (tas_write_reg(tas, TAS_REG_MCS2, 1, &tmp))
-		return -ENODEV;
+		goto outerr;
 
 	tas3004_set_drc(tas);
 
@@ -649,9 +705,11 @@ static int tas_reset_init(struct tas *ta
 
 	tas->acr &= ~TAS_ACR_ANALOG_PDOWN;
 	if (tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr))
-		return -ENODEV;
+		goto outerr;
 
 	return 0;
+ outerr:
+	return -ENODEV;
 }
 
 static int tas_switch_clock(struct codec_info_item *cii, enum clock_switch clock)
@@ -666,11 +724,13 @@ static int tas_switch_clock(struct codec
 		break;
 	case CLOCK_SWITCH_SLAVE:
 		/* Clocks are back, re-init the codec */
+		mutex_lock(&tas->mtx);
 		tas_reset_init(tas);
 		tas_set_volume(tas);
 		tas_set_mixer(tas);
 		tas->hw_enabled = 1;
 		tas->codec.gpio->methods->all_amps_restore(tas->codec.gpio);
+		mutex_unlock(&tas->mtx);
 		break;
 	default:
 		/* doesn't happen as of now */
@@ -684,19 +744,23 @@ static int tas_switch_clock(struct codec
  * our i2c device is suspended, and then take note of that! */
 static int tas_suspend(struct tas *tas)
 {
+	mutex_lock(&tas->mtx);
 	tas->hw_enabled = 0;
 	tas->acr |= TAS_ACR_ANALOG_PDOWN;
 	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
 static int tas_resume(struct tas *tas)
 {
 	/* reset codec */
+	mutex_lock(&tas->mtx);
 	tas_reset_init(tas);
 	tas_set_volume(tas);
 	tas_set_mixer(tas);
 	tas->hw_enabled = 1;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -739,11 +803,14 @@ static int tas_init_codec(struct aoa_cod
 		return -EINVAL;
 	}
 
+	mutex_lock(&tas->mtx);
 	if (tas_reset_init(tas)) {
 		printk(KERN_ERR PFX "tas failed to initialise\n");
+		mutex_unlock(&tas->mtx);
 		return -ENXIO;
 	}
 	tas->hw_enabled = 1;
+	mutex_unlock(&tas->mtx);
 
 	if (tas->codec.soundbus_dev->attach_codec(tas->codec.soundbus_dev,
 						   aoa_get_card(),
@@ -822,6 +889,7 @@ static int tas_create(struct i2c_adapter
 	if (!tas)
 		return -ENOMEM;
 
+	mutex_init(&tas->mtx);
 	tas->i2c.driver = &tas_driver;
 	tas->i2c.adapter = adapter;
 	tas->i2c.addr = addr;
@@ -850,6 +918,7 @@ static int tas_create(struct i2c_adapter
  detach:
 	i2c_detach_client(&tas->i2c);
  fail:
+	mutex_destroy(&tas->mtx);
 	kfree(tas);
 	return -EINVAL;
 }
@@ -908,6 +977,7 @@ static int tas_i2c_detach(struct i2c_cli
 	/* power down codec chip */
 	tas_write_reg(tas, TAS_REG_ACR, 1, &tmp);
 
+	mutex_destroy(&tas->mtx);
 	kfree(tas);
 	return 0;
 }
