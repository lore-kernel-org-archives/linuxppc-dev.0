Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6896C67BC5
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:31 +1000 (EST)
Message-Id: <20060707165534.533644000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/12] aoa: tas: add missing bass/treble controls
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the bass/treble controls to snd-aoa that snd-powermac always
had for tas3004 based machines.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-fetch/sound/aoa/codecs/snd-aoa-codec-tas-basstreble.h	2006-07-07 18:15:40.800223603 +0200
@@ -0,0 +1,134 @@
+/*
+ * This file is only included exactly once!
+ *
+ * The tables here are derived from the tas3004 datasheet,
+ * modulo typo corrections and some smoothing...
+ */
+
+#define TAS3004_TREBLE_MIN	0
+#define TAS3004_TREBLE_MAX	72
+#define TAS3004_BASS_MIN	0
+#define TAS3004_BASS_MAX	72
+#define TAS3004_TREBLE_ZERO	36
+#define TAS3004_BASS_ZERO	36
+
+static u8 tas3004_treble_table[] = {
+	150, /* -18 dB */
+	149,
+	148,
+	147,
+	146,
+	145,
+	144,
+	143,
+	142,
+	141,
+	140,
+	139,
+	138,
+	137,
+	136,
+	135,
+	134,
+	133,
+	132,
+	131,
+	130,
+	129,
+	128,
+	127,
+	126,
+	125,
+	124,
+	123,
+	122,
+	121,
+	120,
+	119,
+	118,
+	117,
+	116,
+	115,
+	114, /* 0 dB */
+	113,
+	112,
+	111,
+	109,
+	108,
+	107,
+	105,
+	104,
+	103,
+	101,
+	99,
+	98,
+	96,
+	93,
+	91,
+	89,
+	86,
+	83,
+	81,
+	77,
+	74,
+	71,
+	67,
+	63,
+	59,
+	54,
+	49,
+	44,
+	38,
+	32,
+	26,
+	19,
+	10,
+	4,
+	2,
+	1, /* +18 dB */
+};
+
+static inline u8 tas3004_treble(int idx)
+{
+	return tas3004_treble_table[idx];
+}
+
+/* I only save the difference here to the treble table
+ * so that the binary is smaller...
+ * I have also ignored completely differences of
+ * +/- 1
+ */
+static s8 tas3004_bass_diff_to_treble[] = {
+	2, /* 7 dB, offset 50 */
+	2,
+	2,
+	2,
+	2,
+	1,
+	2,
+	2,
+	2,
+	3,
+	4,
+	4,
+	5,
+	6,
+	7,
+	8,
+	9,
+	10,
+	11,
+	14,
+	13,
+	8,
+	1, /* 18 dB */
+};
+
+static inline u8 tas3004_bass(int idx)
+{
+	u8 result = tas3004_treble_table[idx];
+
+	if (idx >= 50)
+		result += tas3004_bass_diff_to_treble[idx-50];
+	return result;
+}
--- linux-2.6-fetch.orig/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 18:10:09.470223603 +0200
+++ linux-2.6-fetch/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 18:25:07.330223603 +0200
@@ -72,6 +72,7 @@ MODULE_DESCRIPTION("tas codec driver for
 
 #include "snd-aoa-codec-tas.h"
 #include "snd-aoa-codec-tas-gain-table.h"
+#include "snd-aoa-codec-tas-basstreble.h"
 #include "../aoa.h"
 #include "../soundbus/soundbus.h"
 
@@ -87,6 +88,7 @@ struct tas {
 				hw_enabled:1;
 	u8			cached_volume_l, cached_volume_r;
 	u8			mixer_l[3], mixer_r[3];
+	u8			bass, treble;
 	u8			acr;
 	int			drc_range;
 };
@@ -128,6 +130,22 @@ static void tas3004_set_drc(struct tas *
 	tas_write_reg(tas, TAS_REG_DRC, 6, val);
 }
 
+static void tas_set_treble(struct tas *tas)
+{
+	u8 tmp;
+
+	tmp = tas3004_treble(tas->treble);
+	tas_write_reg(tas, TAS_REG_TREBLE, 1, &tmp);
+}
+
+static void tas_set_bass(struct tas *tas)
+{
+	u8 tmp;
+
+	tmp = tas3004_bass(tas->bass);
+	tas_write_reg(tas, TAS_REG_BASS, 1, &tmp);
+}
+
 static void tas_set_volume(struct tas *tas)
 {
 	u8 block[6];
@@ -485,6 +503,89 @@ static struct snd_kcontrol_new capture_s
 	.put = tas_snd_capture_source_put,
 };
 
+static int tas_snd_treble_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = TAS3004_TREBLE_MIN;
+	uinfo->value.integer.max = TAS3004_TREBLE_MAX;
+	return 0;
+}
+
+static int tas_snd_treble_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas->treble;
+	return 0;
+}
+
+static int tas_snd_treble_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	if (tas->treble == ucontrol->value.integer.value[0])
+		return 0;
+
+	tas->treble = ucontrol->value.integer.value[0];
+	if (tas->hw_enabled)
+		tas_set_treble(tas);
+	return 1;
+}
+
+static struct snd_kcontrol_new treble_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Treble",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = tas_snd_treble_info,
+	.get = tas_snd_treble_get,
+	.put = tas_snd_treble_put,
+};
+
+static int tas_snd_bass_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = TAS3004_BASS_MIN;
+	uinfo->value.integer.max = TAS3004_BASS_MAX;
+	return 0;
+}
+
+static int tas_snd_bass_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas->bass;
+	return 0;
+}
+
+static int tas_snd_bass_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	if (tas->bass == ucontrol->value.integer.value[0])
+		return 0;
+
+	tas->bass = ucontrol->value.integer.value[0];
+	if (tas->hw_enabled)
+		tas_set_bass(tas);
+	return 1;
+}
+
+static struct snd_kcontrol_new bass_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Bass",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = tas_snd_bass_info,
+	.get = tas_snd_bass_get,
+	.put = tas_snd_bass_put,
+};
 
 static struct transfer_info tas_transfers[] = {
 	{
@@ -541,9 +642,10 @@ static int tas_reset_init(struct tas *ta
 	tas3004_set_drc(tas);
 
 	/* Set treble & bass to 0dB */
-	tmp = 114;
-	tas_write_reg(tas, TAS_REG_TREBLE, 1, &tmp);
-	tas_write_reg(tas, TAS_REG_BASS, 1, &tmp);
+	tas->treble = TAS3004_TREBLE_ZERO;
+	tas->bass = TAS3004_BASS_ZERO;
+	tas_set_treble(tas);
+	tas_set_bass(tas);
 
 	tas->acr &= ~TAS_ACR_ANALOG_PDOWN;
 	if (tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr))
@@ -682,6 +784,14 @@ static int tas_init_codec(struct aoa_cod
 	if (err)
 		goto error;
 
+	err = aoa_snd_ctl_add(snd_ctl_new1(&treble_control, tas));
+	if (err)
+		goto error;
+
+	err = aoa_snd_ctl_add(snd_ctl_new1(&bass_control, tas));
+	if (err)
+		goto error;
+
 	return 0;
  error:
 	tas->codec.soundbus_dev->detach_codec(tas->codec.soundbus_dev, tas);

--
