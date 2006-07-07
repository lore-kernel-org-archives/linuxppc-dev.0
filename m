Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68F5167B74
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:19 +1000 (EST)
Message-Id: <20060707165532.405550000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:16 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/12] aoa: tas: fix initialisation/reset
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the initialisation and reset of the tas codec.
The tas will often reset if the i2s clocks go away so it needs
to be completely re-initialised when clocks come back.

Also, this patch adds some code for DRC that will be exploited
later to add a DRC control again, fixing a regression over
snd-powermac.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 15:19:58.526178326 +0200
+++ linux-2.6-fetch/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 15:23:20.146178326 +0200
@@ -75,19 +75,24 @@ MODULE_DESCRIPTION("tas codec driver for
 #include "../aoa.h"
 #include "../soundbus/soundbus.h"
 
-
 #define PFX "snd-aoa-codec-tas: "
 
+
 struct tas {
 	struct aoa_codec	codec;
 	struct i2c_client	i2c;
-	u32			muted_l:1, muted_r:1,
-				controls_created:1;
+	u32			mute_l:1, mute_r:1 ,
+				controls_created:1 ,
+				drc_enabled:1,
+				hw_enabled:1;
 	u8			cached_volume_l, cached_volume_r;
 	u8			mixer_l[3], mixer_r[3];
 	u8			acr;
+	int			drc_range;
 };
 
+static int tas_reset_init(struct tas *tas);
+
 static struct tas *codec_to_tas(struct aoa_codec *codec)
 {
 	return container_of(codec, struct tas, codec);
@@ -101,6 +106,28 @@ static inline int tas_write_reg(struct t
 		return i2c_smbus_write_i2c_block_data(&tas->i2c, reg, len, data);
 }
 
+static void tas3004_set_drc(struct tas *tas)
+{
+	unsigned char val[6];
+
+	if (tas->drc_enabled)
+		val[0] = 0x50; /* 3:1 above threshold */
+	else
+		val[0] = 0x51; /* disabled */
+	val[1] = 0x02; /* 1:1 below threshold */
+	if (tas->drc_range > 0xef)
+		val[2] = 0xef;
+	else if (tas->drc_range < 0)
+		val[2] = 0x00;
+	else
+		val[2] = tas->drc_range;
+	val[3] = 0xb0;
+	val[4] = 0x60;
+	val[5] = 0xa0;
+
+	tas_write_reg(tas, TAS_REG_DRC, 6, val);
+}
+
 static void tas_set_volume(struct tas *tas)
 {
 	u8 block[6];
@@ -113,8 +140,8 @@ static void tas_set_volume(struct tas *t
 	if (left > 177) left = 177;
 	if (right > 177) right = 177;
 
-	if (tas->muted_l) left = 0;
-	if (tas->muted_r) right = 0;
+	if (tas->mute_l) left = 0;
+	if (tas->mute_r) right = 0;
 
 	/* analysing the volume and mixer tables shows
 	 * that they are similar enough when we shift
@@ -202,7 +229,8 @@ static int tas_snd_vol_put(struct snd_kc
 
 	tas->cached_volume_l = ucontrol->value.integer.value[0];
 	tas->cached_volume_r = ucontrol->value.integer.value[1];
-	tas_set_volume(tas);
+	if (tas->hw_enabled)
+		tas_set_volume(tas);
 	return 1;
 }
 
@@ -230,8 +258,8 @@ static int tas_snd_mute_get(struct snd_k
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.integer.value[0] = !tas->muted_l;
-	ucontrol->value.integer.value[1] = !tas->muted_r;
+	ucontrol->value.integer.value[0] = !tas->mute_l;
+	ucontrol->value.integer.value[1] = !tas->mute_r;
 	return 0;
 }
 
@@ -240,13 +268,14 @@ static int tas_snd_mute_put(struct snd_k
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	if (tas->muted_l == !ucontrol->value.integer.value[0]
-	 && tas->muted_r == !ucontrol->value.integer.value[1])
+	if (tas->mute_l == !ucontrol->value.integer.value[0]
+	 && tas->mute_r == !ucontrol->value.integer.value[1])
 		return 0;
 
-	tas->muted_l = !ucontrol->value.integer.value[0];
-	tas->muted_r = !ucontrol->value.integer.value[1];
-	tas_set_volume(tas);
+	tas->mute_l = !ucontrol->value.integer.value[0];
+	tas->mute_r = !ucontrol->value.integer.value[1];
+	if (tas->hw_enabled)
+		tas_set_volume(tas);
 	return 1;
 }
 
@@ -294,7 +323,8 @@ static int tas_snd_mixer_put(struct snd_
 	tas->mixer_l[idx] = ucontrol->value.integer.value[0];
 	tas->mixer_r[idx] = ucontrol->value.integer.value[1];
 
-	tas_set_mixer(tas);
+	if (tas->hw_enabled)
+		tas_set_mixer(tas);
 	return 1;
 }
 
@@ -346,7 +376,8 @@ static int tas_snd_capture_source_put(st
 		tas->acr |= TAS_ACR_INPUT_B;
 	if (oldacr == tas->acr)
 		return 0;
-	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	if (tas->hw_enabled)
+		tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
 	return 1;
 }
 
@@ -399,26 +430,66 @@ static int tas_usable(struct codec_info_
 static int tas_reset_init(struct tas *tas)
 {
 	u8 tmp;
+
+	tas->codec.gpio->methods->all_amps_off(tas->codec.gpio);
+	msleep(5);
 	tas->codec.gpio->methods->set_hw_reset(tas->codec.gpio, 0);
-	msleep(1);
+	msleep(5);
 	tas->codec.gpio->methods->set_hw_reset(tas->codec.gpio, 1);
-	msleep(1);
+	msleep(20);
 	tas->codec.gpio->methods->set_hw_reset(tas->codec.gpio, 0);
-	msleep(1);
-
-	tas->acr &= ~TAS_ACR_ANALOG_PDOWN;
-	tas->acr |= TAS_ACR_B_MONAUREAL | TAS_ACR_B_MON_SEL_RIGHT;
-	if (tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr))
-		return -ENODEV;
+	msleep(10);
+	tas->codec.gpio->methods->all_amps_restore(tas->codec.gpio);
 
 	tmp = TAS_MCS_SCLK64 | TAS_MCS_SPORT_MODE_I2S | TAS_MCS_SPORT_WL_24BIT;
 	if (tas_write_reg(tas, TAS_REG_MCS, 1, &tmp))
 		return -ENODEV;
 
+	tas->acr |= TAS_ACR_ANALOG_PDOWN | TAS_ACR_B_MONAUREAL |
+		TAS_ACR_B_MON_SEL_RIGHT;
+	if (tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr))
+		return -ENODEV;
+
 	tmp = 0;
 	if (tas_write_reg(tas, TAS_REG_MCS2, 1, &tmp))
 		return -ENODEV;
 
+	tas3004_set_drc(tas);
+
+	/* Set treble & bass to 0dB */
+	tmp = 114;
+	tas_write_reg(tas, TAS_REG_TREBLE, 1, &tmp);
+	tas_write_reg(tas, TAS_REG_BASS, 1, &tmp);
+
+	tas->acr &= ~TAS_ACR_ANALOG_PDOWN;
+	if (tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int tas_switch_clock(struct codec_info_item *cii, enum clock_switch clock)
+{
+	struct tas *tas = cii->codec_data;
+
+	switch(clock) {
+	case CLOCK_SWITCH_PREPARE_SLAVE:
+		/* Clocks are going away, mute mute mute */
+		tas->codec.gpio->methods->all_amps_off(tas->codec.gpio);
+		tas->hw_enabled = 0;
+		break;
+	case CLOCK_SWITCH_SLAVE:
+		/* Clocks are back, re-init the codec */
+		tas_reset_init(tas);
+		tas_set_volume(tas);
+		tas_set_mixer(tas);
+		tas->hw_enabled = 1;
+		tas->codec.gpio->methods->all_amps_restore(tas->codec.gpio);
+		break;
+	default:
+		/* doesn't happen as of now */
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -427,6 +498,7 @@ static int tas_reset_init(struct tas *ta
  * our i2c device is suspended, and then take note of that! */
 static int tas_suspend(struct tas *tas)
 {
+	tas->hw_enabled = 0;
 	tas->acr |= TAS_ACR_ANALOG_PDOWN;
 	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
 	return 0;
@@ -438,6 +510,7 @@ static int tas_resume(struct tas *tas)
 	tas_reset_init(tas);
 	tas_set_volume(tas);
 	tas_set_mixer(tas);
+	tas->hw_enabled = 1;
 	return 0;
 }
 
@@ -463,6 +536,7 @@ static struct codec_info tas_codec_info 
 	.bus_factor = 64,
 	.owner = THIS_MODULE,
 	.usable = tas_usable,
+	.switch_clock = tas_switch_clock,
 #ifdef CONFIG_PM
 	.suspend = _tas_suspend,
 	.resume = _tas_resume,
@@ -483,6 +557,7 @@ static int tas_init_codec(struct aoa_cod
 		printk(KERN_ERR PFX "tas failed to initialise\n");
 		return -ENXIO;
 	}
+	tas->hw_enabled = 1;
 
 	if (tas->codec.soundbus_dev->attach_codec(tas->codec.soundbus_dev,
 						   aoa_get_card(),
@@ -548,6 +623,7 @@ static int tas_create(struct i2c_adapter
 	tas->i2c.driver = &tas_driver;
 	tas->i2c.adapter = adapter;
 	tas->i2c.addr = addr;
+	tas->drc_range = TAS3004_DRC_MAX;
 	strlcpy(tas->i2c.name, "tas audio codec", I2C_NAME_SIZE-1);
 
 	if (i2c_attach_client(&tas->i2c)) {
@@ -564,7 +640,9 @@ static int tas_create(struct i2c_adapter
 	if (aoa_codec_register(&tas->codec)) {
 		goto detach;
 	}
-	printk(KERN_DEBUG "snd-aoa-codec-tas: created and attached tas instance\n");
+	printk(KERN_DEBUG
+	       "snd-aoa-codec-tas: tas found, addr 0x%02x on %s\n",
+	       addr, node->full_name);
 	return 0;
  detach:
 	i2c_detach_client(&tas->i2c);
--- linux-2.6-fetch.orig/sound/aoa/codecs/snd-aoa-codec-tas.h	2006-07-07 15:19:58.666178326 +0200
+++ linux-2.6-fetch/sound/aoa/codecs/snd-aoa-codec-tas.h	2006-07-07 15:20:03.546178326 +0200
@@ -44,4 +44,12 @@
 #define TAS_REG_LEFT_BIQUAD6	0x10
 #define TAS_REG_RIGHT_BIQUAD6	0x19
 
+#define TAS_REG_LEFT_LOUDNESS		0x21
+#define TAS_REG_RIGHT_LOUDNESS		0x22
+#define TAS_REG_LEFT_LOUDNESS_GAIN	0x23
+#define TAS_REG_RIGHT_LOUDNESS_GAIN	0x24
+
+#define TAS3001_DRC_MAX		0x5f
+#define TAS3004_DRC_MAX		0xef
+
 #endif /* __SND_AOA_CODECTASH */

--
