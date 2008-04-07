Return-Path: <risto.suominen@gmail.com>
Message-ID: <46e1c7760804070628h77102b9ds629d36bb6c88e63a@mail.gmail.com>
Date: Mon, 7 Apr 2008 16:28:51 +0300
From: "Risto Suominen" <risto.suominen@gmail.com>
To: perex@perex.cz
Subject: [PATCH 002/003] snd-powermac: AWACS and Screamer mixers for PM7500,
	Beige, and iMac SL
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: LinuxPPC-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Risto Suominen <Risto.Suominen@gmail.com>

Add mixer controls and correct headphone detection bits for PowerMacs
7300/7500 (AWACS) and G3 Beige (Screamer), and iMac G3 Slot-loading
(Screamer).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.25-rc8 (probably any 2.6)

--- sound/ppc/awacs.c.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/awacs.c	2008-04-07 11:24:08.108621048 +0300
@@ -141,7 +141,7 @@ static int snd_pmac_awacs_info_volume(st
 	uinfo->value.integer.max = 15;
 	return 0;
 }
-
+
 static int snd_pmac_awacs_get_volume(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
@@ -267,7 +267,8 @@ static int snd_pmac_awacs_put_switch(str
 static void awacs_set_cuda(int reg, int val)
 {
 	struct adb_request req;
-	cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_GET_SET_IIC, 0x8a, reg, val);
+	cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_GET_SET_IIC, 0x8a,
+			reg, val);
 	while (! req.complete)
 		cuda_poll();
 }
@@ -289,11 +290,11 @@ static void awacs_amp_set_tone(struct aw
 /*
  * vol = 0 - 31 (attenuation), 32 = mute bit, stereo
  */
-static int awacs_amp_set_vol(struct awacs_amp *amp, int index, int
lvol, int rvol,
-			     int do_check)
+static int awacs_amp_set_vol(struct awacs_amp *amp, int index,
+			     int lvol, int rvol, int do_check)
 {
 	if (do_check && amp->amp_vol[index][0] == lvol &&
-	    amp->amp_vol[index][1] == rvol)
+			amp->amp_vol[index][1] == rvol)
 		return 0;
 	awacs_set_cuda(3 + index, lvol);
 	awacs_set_cuda(5 + index, rvol);
@@ -337,7 +338,7 @@ static int snd_pmac_awacs_info_volume_am
 	uinfo->value.integer.max = 31;
 	return 0;
 }
-
+
 static int snd_pmac_awacs_get_volume_amp(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
@@ -361,8 +362,10 @@ static int snd_pmac_awacs_put_volume_amp
 	snd_assert(amp, return -EINVAL);
 	snd_assert(index >= 0 && index <= 1, return -EINVAL);

-	vol[0] = (31 - (ucontrol->value.integer.value[0] & 31)) |
(amp->amp_vol[index][0] & 32);
-	vol[1] = (31 - (ucontrol->value.integer.value[1] & 31)) |
(amp->amp_vol[index][1] & 32);
+	vol[0] = (31 - (ucontrol->value.integer.value[0] & 31))
+		| (amp->amp_vol[index][0] & 32);
+	vol[1] = (31 - (ucontrol->value.integer.value[1] & 31))
+		| (amp->amp_vol[index][1] & 32);
 	return awacs_amp_set_vol(amp, index, vol[0], vol[1], 1);
 }

@@ -374,8 +377,10 @@ static int snd_pmac_awacs_get_switch_amp
 	struct awacs_amp *amp = chip->mixer_data;
 	snd_assert(amp, return -EINVAL);
 	snd_assert(index >= 0 && index <= 1, return -EINVAL);
-	ucontrol->value.integer.value[0] = (amp->amp_vol[index][0] & 32) ? 0 : 1;
-	ucontrol->value.integer.value[1] = (amp->amp_vol[index][1] & 32) ? 0 : 1;
+	ucontrol->value.integer.value[0] = (amp->amp_vol[index][0] & 32)
+					? 0 : 1;
+	ucontrol->value.integer.value[1] = (amp->amp_vol[index][1] & 32)
+					? 0 : 1;
 	return 0;
 }

@@ -389,8 +394,10 @@ static int snd_pmac_awacs_put_switch_amp
 	snd_assert(amp, return -EINVAL);
 	snd_assert(index >= 0 && index <= 1, return -EINVAL);

-	vol[0] = (ucontrol->value.integer.value[0] ? 0 : 32) |
(amp->amp_vol[index][0] & 31);
-	vol[1] = (ucontrol->value.integer.value[1] ? 0 : 32) |
(amp->amp_vol[index][1] & 31);
+	vol[0] = (ucontrol->value.integer.value[0] ? 0 : 32)
+		| (amp->amp_vol[index][0] & 31);
+	vol[1] = (ucontrol->value.integer.value[1] ? 0 : 32)
+		| (amp->amp_vol[index][1] & 31);
 	return awacs_amp_set_vol(amp, index, vol[0], vol[1], 1);
 }

@@ -403,7 +410,7 @@ static int snd_pmac_awacs_info_tone_amp(
 	uinfo->value.integer.max = 14;
 	return 0;
 }
-
+
 static int snd_pmac_awacs_get_tone_amp(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_value *ucontrol)
 {
@@ -445,7 +452,7 @@ static int snd_pmac_awacs_info_master_am
 	uinfo->value.integer.max = 99;
 	return 0;
 }
-
+
 static int snd_pmac_awacs_get_master_amp(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
@@ -493,14 +500,14 @@ static struct snd_kcontrol_new snd_pmac_
 	  .private_value = AMP_CH_HD,
 	},
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	  .name = "Tone Control - Bass",
+	  .name = "Tone Control - Bass Playback Volume",
 	  .info = snd_pmac_awacs_info_tone_amp,
 	  .get = snd_pmac_awacs_get_tone_amp,
 	  .put = snd_pmac_awacs_put_tone_amp,
 	  .private_value = 0,
 	},
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	  .name = "Tone Control - Treble",
+	  .name = "Tone Control - Treble Playback Volume",
 	  .info = snd_pmac_awacs_info_tone_amp,
 	  .get = snd_pmac_awacs_get_tone_amp,
 	  .put = snd_pmac_awacs_put_tone_amp,
@@ -544,7 +551,7 @@ static int snd_pmac_screamer_mic_boost_i
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 2;
+	uinfo->value.integer.max = 3;
 	return 0;
 }

@@ -552,16 +559,14 @@ static int snd_pmac_screamer_mic_boost_g
 					   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
-	int val;
+	int val = 0;
 	unsigned long flags;

 	spin_lock_irqsave(&chip->reg_lock, flags);
 	if (chip->awacs_reg[6] & MASK_MIC_BOOST)
-		val = 2;
-	else if (chip->awacs_reg[0] & MASK_GAINLINE)
-		val = 1;
-	else
-		val = 0;
+		val |= 2;
+	if (chip->awacs_reg[0] & MASK_GAINLINE)
+		val |= 1;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	ucontrol->value.integer.value[0] = val;
 	return 0;
@@ -578,11 +583,10 @@ static int snd_pmac_screamer_mic_boost_p
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	val0 = chip->awacs_reg[0] & ~MASK_GAINLINE;
 	val6 = chip->awacs_reg[6] & ~MASK_MIC_BOOST;
-	if (ucontrol->value.integer.value[0] > 0) {
+	if (ucontrol->value.integer.value[0] & 1)
 		val0 |= MASK_GAINLINE;
-		if (ucontrol->value.integer.value[0] > 1)
-			val6 |= MASK_MIC_BOOST;
-	}
+	if (ucontrol->value.integer.value[0] & 2)
+		val6 |= MASK_MIC_BOOST;
 	if (val0 != chip->awacs_reg[0]) {
 		snd_pmac_awacs_write_reg(chip, 0, val0);
 		changed = 1;
@@ -599,9 +603,32 @@ static int snd_pmac_screamer_mic_boost_p
  * lists of mixer elements
  */
 static struct snd_kcontrol_new snd_pmac_awacs_mixers[] __initdata = {
-	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
 	AWACS_SWITCH("Master Capture Switch", 1, SHIFT_LOOPTHRU, 0),
-	AWACS_VOLUME("Capture Volume", 0, 4, 0),
+	AWACS_VOLUME("Master Capture Volume", 0, 4, 0),
+/*	AWACS_SWITCH("Unknown Playback Switch", 6, SHIFT_PAROUT0, 0), */
+};
+
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_beige[] __initdata = {
+	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
+	AWACS_VOLUME("Play-through Playback Volume", 5, 6, 1),
+	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_MIC, 0),
+	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_LINE, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_imac[] __initdata = {
+	AWACS_VOLUME("Line out Playback Volume", 2, 6, 1),
+	AWACS_VOLUME("Master Playback Volume", 5, 6, 1),
+	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac7500[] __initdata = {
+	AWACS_VOLUME("Line out Playback Volume", 2, 6, 1),
+	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
+	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_MIC, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac[] __initdata = {
+	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
 };

@@ -621,35 +648,61 @@ static struct snd_kcontrol_new snd_pmac_
 static struct snd_kcontrol_new snd_pmac_awacs_master_sw __initdata =
 AWACS_SWITCH("Master Playback Switch", 1, SHIFT_HDMUTE, 1);

+static struct snd_kcontrol_new snd_pmac_awacs_master_sw_imac __initdata =
+AWACS_SWITCH("Line out Playback Switch", 1, SHIFT_HDMUTE, 1);
+
 static struct snd_kcontrol_new snd_pmac_awacs_mic_boost[] __initdata = {
-	AWACS_SWITCH("Mic Boost", 0, SHIFT_GAINLINE, 0),
+	AWACS_SWITCH("Mic Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
 };

 static struct snd_kcontrol_new snd_pmac_screamer_mic_boost[] __initdata = {
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	  .name = "Mic Boost",
+	  .name = "Mic Boost Capture Volume",
 	  .info = snd_pmac_screamer_mic_boost_info,
 	  .get = snd_pmac_screamer_mic_boost_get,
 	  .put = snd_pmac_screamer_mic_boost_put,
 	},
 };

+static struct snd_kcontrol_new snd_pmac_awacs_mic_boost_pmac7500[] __initdata =
+{
+	AWACS_SWITCH("Line Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_screamer_mic_boost_beige[] __initdata =
+{
+	AWACS_SWITCH("Line Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
+	AWACS_SWITCH("CD Boost Capture Switch", 6, SHIFT_MIC_BOOST, 0),
+};
+
+static struct snd_kcontrol_new snd_pmac_screamer_mic_boost_imac[] __initdata =
+{
+	AWACS_SWITCH("Line Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
+	AWACS_SWITCH("Mic Boost Capture Switch", 6, SHIFT_MIC_BOOST, 0),
+};
+
 static struct snd_kcontrol_new snd_pmac_awacs_speaker_vol[] __initdata = {
 	AWACS_VOLUME("PC Speaker Playback Volume", 4, 6, 1),
 };
+
 static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw __initdata =
 AWACS_SWITCH("PC Speaker Playback Switch", 1, SHIFT_SPKMUTE, 1);

+static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw_imac __initdata =
+AWACS_SWITCH("PC Speaker Playback Switch", 1, SHIFT_PAROUT1, 0);
+

 /*
  * add new mixer elements to the card
  */
-static int build_mixers(struct snd_pmac *chip, int nums, struct
snd_kcontrol_new *mixers)
+static int build_mixers(struct snd_pmac *chip, int nums,
+			struct snd_kcontrol_new *mixers)
 {
 	int i, err;

 	for (i = 0; i < nums; i++) {
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&mixers[i], chip))) < 0)
+		if ((err = snd_ctl_add(chip->card,
+				       snd_ctl_new1(&mixers[i], chip))) < 0)
 			return err;
 	}
 	return 0;
@@ -699,8 +752,10 @@ static void snd_pmac_awacs_resume(struct
 #ifdef PMAC_AMP_AVAIL
 	if (chip->mixer_data) {
 		struct awacs_amp *amp = chip->mixer_data;
-		awacs_amp_set_vol(amp, 0, amp->amp_vol[0][0], amp->amp_vol[0][1], 0);
-		awacs_amp_set_vol(amp, 1, amp->amp_vol[1][0], amp->amp_vol[1][1], 0);
+		awacs_amp_set_vol(amp, 0,
+				  amp->amp_vol[0][0], amp->amp_vol[0][1], 0);
+		awacs_amp_set_vol(amp, 1,
+				  amp->amp_vol[1][0], amp->amp_vol[1][1], 0);
 		awacs_amp_set_tone(amp, amp->amp_tone[0], amp->amp_tone[1]);
 		awacs_amp_set_master(amp, amp->amp_master);
 	}
@@ -708,6 +763,14 @@ static void snd_pmac_awacs_resume(struct
 }
 #endif /* CONFIG_PM */

+#define IS_PM7500 (machine_is_compatible("AAPL,7500"))
+#define IS_BEIGE (machine_is_compatible("AAPL,Gossamer"))
+#define IS_IMAC (machine_is_compatible("PowerMac2,1") \
+		|| machine_is_compatible("PowerMac2,2") \
+		|| machine_is_compatible("PowerMac4,1"))
+
+static int imac;
+
 #ifdef PMAC_SUPPORT_AUTOMUTE
 /*
  * auto-mute stuffs
@@ -750,9 +813,16 @@ static void snd_pmac_awacs_update_automu
 		} else
 #endif
 		{
-			int reg = chip->awacs_reg[1] | (MASK_HDMUTE|MASK_SPKMUTE);
+			int reg = chip->awacs_reg[1]
+				| (MASK_HDMUTE | MASK_SPKMUTE);
+			if (imac) {
+				reg &= ~MASK_SPKMUTE;
+				reg &= ~MASK_PAROUT1;
+			}
 			if (snd_pmac_awacs_detect_headphone(chip))
 				reg &= ~MASK_HDMUTE;
+			else if (imac)
+				reg |= MASK_PAROUT1;
 			else
 				reg &= ~MASK_SPKMUTE;
 			if (do_notify && reg == chip->awacs_reg[1])
@@ -778,8 +848,11 @@ static void snd_pmac_awacs_update_automu
 int __init
 snd_pmac_awacs_init(struct snd_pmac *chip)
 {
+	int pm7500 = IS_PM7500;
+	int beige = IS_BEIGE;
 	int err, vol;

+	imac = IS_IMAC;
 	/* looks like MASK_GAINLINE triggers something, so we set here
 	 * as start-up
 	 */
@@ -787,7 +860,7 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 	chip->awacs_reg[1] = MASK_CMUTE | MASK_AMUTE;
 	/* FIXME: Only machines with external SRS module need MASK_PAROUT */
 	if (chip->has_iic || chip->device_id == 0x5 ||
-	    /*chip->_device_id == 0x8 || */
+	    /* chip->_device_id == 0x8 || */
 	    chip->device_id == 0xb)
 		chip->awacs_reg[1] |= MASK_PAROUT;
 	/* get default volume from nvram */
@@ -798,8 +871,10 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 	chip->awacs_reg[2] = vol;
 	chip->awacs_reg[4] = vol;
 	if (chip->model == PMAC_SCREAMER) {
-		chip->awacs_reg[5] = vol; /* FIXME: screamer has loopthru vol control */
-		chip->awacs_reg[6] = MASK_MIC_BOOST; /* FIXME: maybe should be vol
<< 3 for PCMCIA speaker */
+		/* FIXME: screamer has loopthru vol control */
+		chip->awacs_reg[5] = vol;
+		/* FIXME: maybe should be vol << 3 for PCMCIA speaker */
+		chip->awacs_reg[6] = MASK_MIC_BOOST;
 		chip->awacs_reg[7] = 0;
 	}

@@ -815,7 +890,8 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 			return -ENOMEM;
 		chip->mixer_data = amp;
 		chip->mixer_free = awacs_amp_free;
-		awacs_amp_set_vol(amp, 0, 63, 63, 0); /* mute and zero vol */
+		/* mute and zero vol */
+		awacs_amp_set_vol(amp, 0, 63, 63, 0);
 		awacs_amp_set_vol(amp, 1, 63, 63, 0);
 		awacs_amp_set_tone(amp, 7, 7); /* 0 dB */
 		awacs_amp_set_master(amp, 79); /* 0 dB */
@@ -826,20 +902,25 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 		/* set headphone-jack detection bit */
 		switch (chip->model) {
 		case PMAC_AWACS:
-			chip->hp_stat_mask = 0x04;
+			chip->hp_stat_mask = pm7500 ? MASK_HDPCONN
+				: MASK_LOCONN;
 			break;
 		case PMAC_SCREAMER:
 			switch (chip->device_id) {
 			case 0x08:
-				/* 1 = side jack, 2 = front jack */
-				chip->hp_stat_mask = 0x03;
+			case 0x0B:
+				chip->hp_stat_mask = imac
+					? MASK_LOCONN_IMAC |
+					MASK_HDPLCONN_IMAC |
+					MASK_HDPRCONN_IMAC
+					: MASK_HDPCONN;
 				break;
 			case 0x00:
 			case 0x05:
-				chip->hp_stat_mask = 0x04;
+				chip->hp_stat_mask = MASK_LOCONN;
 				break;
 			default:
-				chip->hp_stat_mask = 0x08;
+				chip->hp_stat_mask = MASK_HDPCONN;
 				break;
 			}
 			break;
@@ -857,15 +938,37 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 	if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_mixers),
 				snd_pmac_awacs_mixers)) < 0)
 		return err;
-	if (chip->model == PMAC_SCREAMER)
+	if (beige)
+		;
+	else if (chip->model == PMAC_SCREAMER)
 		err = build_mixers(chip, ARRAY_SIZE(snd_pmac_screamer_mixers2),
 				   snd_pmac_screamer_mixers2);
-	else
+	else if (!pm7500)
 		err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_mixers2),
 				   snd_pmac_awacs_mixers2);
 	if (err < 0)
 		return err;
-	chip->master_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_master_sw, chip);
+	if (pm7500)
+		err = build_mixers(chip,
+				   ARRAY_SIZE(snd_pmac_awacs_mixers_pmac7500),
+				   snd_pmac_awacs_mixers_pmac7500);
+	else if (beige)
+		err = build_mixers(chip,
+				   ARRAY_SIZE(snd_pmac_screamer_mixers_beige),
+				   snd_pmac_screamer_mixers_beige);
+	else if (imac)
+		err = build_mixers(chip,
+				   ARRAY_SIZE(snd_pmac_screamer_mixers_imac),
+				   snd_pmac_screamer_mixers_imac);
+	else
+		err = build_mixers(chip,
+				   ARRAY_SIZE(snd_pmac_awacs_mixers_pmac),
+				   snd_pmac_awacs_mixers_pmac);
+	if (err < 0)
+		return err;
+	chip->master_sw_ctl = snd_ctl_new1((pm7500 || imac)
+			? &snd_pmac_awacs_master_sw_imac
+			: &snd_pmac_awacs_master_sw, chip);
 	if ((err = snd_ctl_add(chip->card, chip->master_sw_ctl)) < 0)
 		return err;
 #ifdef PMAC_AMP_AVAIL
@@ -876,35 +979,58 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 		 * screamer registers.
 		 * in this case, it seems the route C is not used.
 		 */
-		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_amp_vol),
+		if ((err = build_mixers(chip,
+					ARRAY_SIZE(snd_pmac_awacs_amp_vol),
 					snd_pmac_awacs_amp_vol)) < 0)
 			return err;
 		/* overwrite */
-		chip->master_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_amp_hp_sw, chip);
+		chip->master_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_amp_hp_sw,
+						   chip);
 		if ((err = snd_ctl_add(chip->card, chip->master_sw_ctl)) < 0)
 			return err;
-		chip->speaker_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_amp_spk_sw, chip);
+		chip->speaker_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_amp_spk_sw,
+						    chip);
 		if ((err = snd_ctl_add(chip->card, chip->speaker_sw_ctl)) < 0)
 			return err;
 	} else
 #endif /* PMAC_AMP_AVAIL */
 	{
 		/* route A = headphone, route C = speaker */
-		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_speaker_vol),
+		if ((err = build_mixers(chip,
+					ARRAY_SIZE(snd_pmac_awacs_speaker_vol),
 					snd_pmac_awacs_speaker_vol)) < 0)
 			return err;
-		chip->speaker_sw_ctl = snd_ctl_new1(&snd_pmac_awacs_speaker_sw, chip);
+		chip->speaker_sw_ctl = snd_ctl_new1(imac
+				? &snd_pmac_awacs_speaker_sw_imac
+				: &snd_pmac_awacs_speaker_sw, chip);
 		if ((err = snd_ctl_add(chip->card, chip->speaker_sw_ctl)) < 0)
 			return err;
 	}

-	if (chip->model == PMAC_SCREAMER) {
-		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_screamer_mic_boost),
-					snd_pmac_screamer_mic_boost)) < 0)
+	if (beige) {
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_screamer_mic_boost_beige),
+				snd_pmac_screamer_mic_boost_beige)) < 0)
+			return err;
+	} else if (imac) {
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_screamer_mic_boost_imac),
+				snd_pmac_screamer_mic_boost_imac)) < 0)
+			return err;
+	} else if (chip->model == PMAC_SCREAMER) {
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_screamer_mic_boost),
+				snd_pmac_screamer_mic_boost)) < 0)
+			return err;
+	} else if (pm7500) {
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_awacs_mic_boost_pmac7500),
+				snd_pmac_awacs_mic_boost_pmac7500)) < 0)
 			return err;
 	} else {
-		if ((err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_mic_boost),
-					snd_pmac_awacs_mic_boost)) < 0)
+		if ((err = build_mixers(chip,
+				ARRAY_SIZE(snd_pmac_awacs_mic_boost),
+				snd_pmac_awacs_mic_boost)) < 0)
 			return err;
 	}

--- sound/ppc/awacs.h.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/awacs.h	2008-04-07 11:26:58.198763416 +0300
@@ -116,6 +116,11 @@ struct awacs_regs {
 #define MASK_HDMUTE	MASK_AMUTE
 #define SHIFT_HDMUTE	9
 #define MASK_PAROUT	(0x3 << 10)	/* Parallel Out (???) */
+#define MASK_PAROUT0	(0x1 << 10)	/* Parallel Out (???) */
+#define MASK_PAROUT1	(0x1 << 11)	/* Parallel Out (enable speaker) */
+#define SHIFT_PAROUT	10
+#define SHIFT_PAROUT0	10
+#define SHIFT_PAROUT1	11

 #define SAMPLERATE_48000	(0x0 << 3)	/* 48 or 44.1 kHz */
 #define SAMPLERATE_32000	(0x1 << 3)	/* 32 or 29.4 kHz */
@@ -152,8 +157,15 @@ struct awacs_regs {
 #define MASK_REVISION	(0xf << 12)	/* Revision Number */
 #define MASK_MFGID	(0xf << 8)	/* Mfg. ID */
 #define MASK_CODSTATRES	(0xf << 4)	/* bits 4 - 7 reserved */
-#define MASK_INPPORT	(0xf)		/* Input Port */
-#define MASK_HDPCONN	8		/* headphone plugged in */
+#define MASK_INSENSE	(0xf)		/* port sense bits: */
+#define MASK_HDPCONN		8	/* headphone plugged in */
+#define MASK_LOCONN		4	/* line-out plugged in */
+#define MASK_LICONN		2	/* line-in plugged in */
+#define MASK_MICCONN		1	/* microphone plugged in */
+#define MASK_LICONN_IMAC	8	/* line-in plugged in */
+#define MASK_HDPRCONN_IMAC	4	/* headphone right plugged in */
+#define MASK_HDPLCONN_IMAC	2	/* headphone left plugged in */
+#define MASK_LOCONN_IMAC	1	/* line-out plugged in */

 /* Clipping Count Reg Bit Masks */
 /* -------- ----- --- --- ----- */
@@ -163,7 +175,8 @@ struct awacs_regs {
 /* DBDMA ChannelStatus Bit Masks */
 /* ----- ------------- --- ----- */
 #define MASK_CSERR	(0x1 << 7)	/* Error */
-#define MASK_EOI	(0x1 << 6)	/* End of Input -- only for Input Channel */
+#define MASK_EOI	(0x1 << 6)	/* End of Input --
+					   only for Input Channel */
 #define MASK_CSUNUSED	(0x1f << 1)	/* bits 1-5 not used */
 #define MASK_WAIT	(0x1)		/* Wait */
