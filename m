Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71C0E67B54
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:15 +1000 (EST)
Message-Id: <20060707165532.806033000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/12] aoa: tas: surface DRC control again
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the DRC control visible again for TAS chips.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 15:23:20.146178326 +0200
+++ linux-2.6-fetch/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 15:25:15.316178326 +0200
@@ -342,6 +342,90 @@ static struct snd_kcontrol_new n##_contr
 MIXER_CONTROL(pcm1, "PCM", 0);
 MIXER_CONTROL(monitor, "Monitor", 2);
 
+static int tas_snd_drc_range_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = TAS3004_DRC_MAX;
+	return 0;
+}
+
+static int tas_snd_drc_range_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas->drc_range;
+	return 0;
+}
+
+static int tas_snd_drc_range_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	if (tas->drc_range == ucontrol->value.integer.value[0])
+		return 0;
+
+	tas->drc_range = ucontrol->value.integer.value[0];
+	if (tas->hw_enabled)
+		tas3004_set_drc(tas);
+	return 1;
+}
+
+static struct snd_kcontrol_new drc_range_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "DRC Range",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = tas_snd_drc_range_info,
+	.get = tas_snd_drc_range_get,
+	.put = tas_snd_drc_range_put,
+};
+
+static int tas_snd_drc_switch_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int tas_snd_drc_switch_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas->drc_enabled;
+	return 0;
+}
+
+static int tas_snd_drc_switch_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	if (tas->drc_enabled == ucontrol->value.integer.value[0])
+		return 0;
+
+	tas->drc_enabled = ucontrol->value.integer.value[0];
+	if (tas->hw_enabled)
+		tas3004_set_drc(tas);
+	return 1;
+}
+
+static struct snd_kcontrol_new drc_switch_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "DRC Range Switch",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = tas_snd_drc_switch_info,
+	.get = tas_snd_drc_switch_get,
+	.put = tas_snd_drc_switch_put,
+};
+
 static int tas_snd_capture_source_info(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo)
 {
@@ -590,6 +674,14 @@ static int tas_init_codec(struct aoa_cod
 	if (err)
 		goto error;
 
+	err = aoa_snd_ctl_add(snd_ctl_new1(&drc_range_control, tas));
+	if (err)
+		goto error;
+
+	err = aoa_snd_ctl_add(snd_ctl_new1(&drc_switch_control, tas));
+	if (err)
+		goto error;
+
 	return 0;
  error:
 	tas->codec.soundbus_dev->detach_codec(tas->codec.soundbus_dev, tas);
@@ -623,7 +715,8 @@ static int tas_create(struct i2c_adapter
 	tas->i2c.driver = &tas_driver;
 	tas->i2c.adapter = adapter;
 	tas->i2c.addr = addr;
-	tas->drc_range = TAS3004_DRC_MAX;
+	/* seems that half is a saner default */
+	tas->drc_range = TAS3004_DRC_MAX / 2;
 	strlcpy(tas->i2c.name, "tas audio codec", I2C_NAME_SIZE-1);
 
 	if (i2c_attach_client(&tas->i2c)) {

--
