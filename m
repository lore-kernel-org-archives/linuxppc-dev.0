Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6864D67B20
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 05:02:54 +1000 (EST)
Message-Id: <20060528190125.927852000@johannes.berg>
References: <20060528190026.754474000@johannes.berg>
Date: Sun, 28 May 2006 21:00:30 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 4/7] snd-aoa: add codecs
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds two of the most important codecs Apple uses in newer
machines, namely the Onyx and the tas3004.

--- /dev/null
+++ b/sound/aoa/codecs/Kconfig
@@ -0,0 +1,24 @@
+config SND_AOA_ONYX
+	tristate "support Onyx chip"
+	depends on SND_AOA
+	---help---
+	This option enables support for the Onyx (pcm3052)
+	codec chip found in the latest Apple machines
+	(most of those with digital audio output).
+
+#config SND_AOA_TOPAZ
+#	tristate "support Topaz chips"
+#	depends on SND_AOA
+#	---help---
+#	This option enables support for the Topaz (CS84xx)
+#	codec chips found in the latest Apple machines,
+#	these chips do the digital input and output on
+#	some PowerMacs.
+
+config SND_AOA_TAS
+	tristate "support TAS chips"
+	depends on SND_AOA
+	---help---
+	This option enables support for the tas chips
+	found in a lot of Apple Machines, especially
+	iBooks and PowerBooks without digital.
--- /dev/null
+++ b/sound/aoa/codecs/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SND_AOA_ONYX) += snd-aoa-codec-onyx.o
+obj-$(CONFIG_SND_AOA_TAS) += snd-aoa-codec-tas.o
--- /dev/null
+++ b/sound/aoa/codecs/snd-aoa-codec-onyx.c
@@ -0,0 +1,1069 @@
+/*
+ * Apple Onboard Audio driver for Onyx codec
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ *
+ *
+ * This is a driver for the pcm3052 codec chip (codenamed Onyx)
+ * that is present in newer Apple hardware (with digital output).
+ *
+ * The Onyx codec has the following connections (listed by the bit
+ * to be used in aoa_codec.connected):
+ *  0: analog output
+ *  1: digital output
+ *  2: line input
+ *  3: microphone input
+ * Note that even though I know of no machine that has for example
+ * the digital output connected but not the analog, I have handled
+ * all the different cases in the code so that this driver may serve
+ * as a good example of what to do.
+ *
+ * NOTE: This driver assumes that there's at most one chip to be
+ * 	 used with one alsa card, in form of creating all kinds
+ *	 of mixer elements without regard for their existence.
+ *	 But snd-aoa assumes that there's at most one card, so
+ *	 this means you can only have one onyx on a system. This
+ *	 should probably be fixed by changing the assumption of
+ *	 having just a single card on a system, and making the
+ *	 'card' pointer accessible to anyone who needs it instead
+ *	 of hiding it in the aoa_snd_* functions...
+ *
+ */
+#include <linux/delay.h>
+#include <linux/module.h>
+MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("pcm3052 (onyx) codec driver for snd-aoa");
+
+#include "snd-aoa-codec-onyx.h"
+/* FIXME */
+#include "../aoa.h"
+#include "../soundbus/soundbus.h"
+
+
+#define PFX "snd-aoa-codec-onyx: "
+
+struct onyx {
+	/* cache registers 65 to 80, they are write-only! */
+	u8			cache[16];
+	struct i2c_client	i2c;
+	struct aoa_codec	codec;
+	u32			initialised:1,
+				spdif_locked:1,
+				analog_locked:1,
+				original_mute:2;
+	int			open_count;
+	struct codec_info	*codec_info;
+
+	/* mutex serializes concurrent access to the device
+	 * and this structure.
+	 */
+	struct mutex mutex;
+};
+#define codec_to_onyx(c) container_of(c, struct onyx, codec)
+
+/* both return 0 if all ok, else on error */
+static int onyx_read_register(struct onyx *onyx, u8 reg, u8 *value)
+{
+	s32 v;
+
+	if (reg != ONYX_REG_CONTROL) {
+		*value = onyx->cache[reg-FIRSTREGISTER];
+		return 0;
+	}
+	v = i2c_smbus_read_byte_data(&onyx->i2c, reg);
+	if (v < 0)
+		return -1;
+	*value = (u8)v;
+	onyx->cache[ONYX_REG_CONTROL-FIRSTREGISTER] = *value;
+	return 0;
+}
+
+static int onyx_write_register(struct onyx *onyx, u8 reg, u8 value)
+{
+	int result;
+
+	result = i2c_smbus_write_byte_data(&onyx->i2c, reg, value);
+	if (!result)
+		onyx->cache[reg-FIRSTREGISTER] = value;
+	return result;
+}
+
+/* alsa stuff */
+
+static int onyx_dev_register(struct snd_device *dev)
+{
+	return 0;
+}
+
+static struct snd_device_ops ops = {
+	.dev_register = onyx_dev_register,
+};
+
+static int onyx_snd_vol_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = -128+128;
+	uinfo->value.integer.max = -1+128;
+	return 0;
+}
+
+static int onyx_snd_vol_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	s8 l,r;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, &l);
+	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, &r);
+	mutex_unlock(&onyx->mutex);
+
+	ucontrol->value.integer.value[0] = l+128;
+	ucontrol->value.integer.value[1] = r+128;
+
+	return 0;
+}
+
+static int onyx_snd_vol_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+
+	mutex_lock(&onyx->mutex);
+	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, ucontrol->value.integer.value[0]-128);
+	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, ucontrol->value.integer.value[1]-128);
+	/* FIXME: we could be checking if anything changed */
+	mutex_unlock(&onyx->mutex);
+
+	return 1;
+}
+
+static struct snd_kcontrol_new volume_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Master Playback Volume",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = onyx_snd_vol_info,
+	.get = onyx_snd_vol_get,
+	.put = onyx_snd_vol_put,
+};
+
+static int onyx_snd_inputgain_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 3-3;
+	uinfo->value.integer.max = 28-3;
+	return 0;
+}
+
+static int onyx_snd_inputgain_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	u8 ig;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &ig);
+	mutex_unlock(&onyx->mutex);
+
+	ucontrol->value.integer.value[0] = (ig & ONYX_ADC_PGA_GAIN_MASK)-3;
+
+	return 0;
+}
+
+static int onyx_snd_inputgain_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	u8 val;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &val);
+	val &= ~ONYX_ADC_PGA_GAIN_MASK;
+	val |= (ucontrol->value.integer.value[0]+3) & ONYX_ADC_PGA_GAIN_MASK;
+	onyx_write_register(onyx, ONYX_REG_ADC_CONTROL, val);
+	mutex_unlock(&onyx->mutex);
+
+	return 1;
+}
+
+static struct snd_kcontrol_new inputgain_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Master Capture Volume",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = onyx_snd_inputgain_info,
+	.get = onyx_snd_inputgain_get,
+	.put = onyx_snd_inputgain_put,
+};
+
+static int onyx_snd_capture_source_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	static char* texts[] = { "Line-In", "Microphone" };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item > 1)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int onyx_snd_capture_source_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	s8 v;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
+	mutex_unlock(&onyx->mutex);
+
+	ucontrol->value.enumerated.item[0] = !!(v&ONYX_ADC_INPUT_MIC);
+
+	return 0;
+}
+
+static void onyx_set_capture_source(struct onyx *onyx, int mic)
+{
+	s8 v;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
+	v &= ~ONYX_ADC_INPUT_MIC;
+	if (mic)
+		v |= ONYX_ADC_INPUT_MIC;
+	onyx_write_register(onyx, ONYX_REG_ADC_CONTROL, v);
+	mutex_unlock(&onyx->mutex);
+}
+
+static int onyx_snd_capture_source_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	onyx_set_capture_source(snd_kcontrol_chip(kcontrol),
+				ucontrol->value.enumerated.item[0]);
+	return 1;
+}
+
+static struct snd_kcontrol_new capture_source_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	/* If we name this 'Input Source', it properly shows up in
+	 * alsamixer as a selection, * but it's shown under the 
+	 * 'Playback' category.
+	 * If I name it 'Capture Source', it shows up in strange
+	 * ways (two bools of which one can be selected at a
+	 * time) but at least it's shown in the 'Capture'
+	 * category.
+	 * I was told that this was due to backward compatibility,
+	 * but I don't understand then why the mangling is *not*
+	 * done when I name it "Input Source".....
+	 */
+	.name = "Capture Source",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = onyx_snd_capture_source_info,
+	.get = onyx_snd_capture_source_get,
+	.put = onyx_snd_capture_source_put,
+};
+
+static int onyx_snd_mute_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int onyx_snd_mute_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	u8 c;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &c);
+	mutex_unlock(&onyx->mutex);
+
+	ucontrol->value.integer.value[0] = !(c & ONYX_MUTE_LEFT);
+	ucontrol->value.integer.value[1] = !(c & ONYX_MUTE_RIGHT);
+
+	return 0;
+}
+
+static int onyx_snd_mute_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	u8 c;
+	int err = -EBUSY;
+
+	mutex_lock(&onyx->mutex);
+	if (onyx->analog_locked)
+		goto out_unlock;
+
+	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &c);
+	c &= ~(ONYX_MUTE_RIGHT | ONYX_MUTE_LEFT);
+	if (!ucontrol->value.integer.value[0])
+		c |= ONYX_MUTE_LEFT;
+	if (!ucontrol->value.integer.value[1])
+		c |= ONYX_MUTE_RIGHT;
+	err = onyx_write_register(onyx, ONYX_REG_DAC_CONTROL, c);
+	if (err)
+		goto out_unlock;
+	/* FIXME: we could be checking if anything changed */
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return !err ? 1 : err;
+}
+
+static struct snd_kcontrol_new mute_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Master Playback Switch",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = onyx_snd_mute_info,
+	.get = onyx_snd_mute_get,
+	.put = onyx_snd_mute_put,
+};
+
+
+static int onyx_snd_single_bit_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+#define FLAG_POLARITY_INVERT	1
+#define FLAG_SPDIFLOCK		2
+
+static int onyx_snd_single_bit_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	u8 c;
+	long int pv = kcontrol->private_value;
+	u8 polarity = (pv >> 16) & FLAG_POLARITY_INVERT;
+	u8 address = (pv >> 8) & 0xff;
+	u8 mask = pv & 0xff;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, address, &c);
+	mutex_unlock(&onyx->mutex);
+
+	ucontrol->value.integer.value[0] = !!(c & mask) ^ polarity;
+
+	return 0;
+}
+
+static int onyx_snd_single_bit_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	u8 c;
+	int err;
+	long int pv = kcontrol->private_value;
+	u8 polarity = (pv >> 16) & FLAG_POLARITY_INVERT;
+	u8 spdiflock = (pv >> 16) & FLAG_SPDIFLOCK;
+	u8 address = (pv >> 8) & 0xff;
+	u8 mask = pv & 0xff;
+
+	mutex_lock(&onyx->mutex);
+	if (spdiflock && onyx->spdif_locked) {
+		/* even if alsamixer doesn't care.. */
+		err = -EBUSY;
+		goto out_unlock;
+	}
+	onyx_read_register(onyx, address, &c);
+	c &= ~(mask);
+	if (!!ucontrol->value.integer.value[0] ^ polarity)
+		c |= mask;
+	err = onyx_write_register(onyx, address, c);
+	if (err)
+		goto out_unlock;
+	/* FIXME: we could be checking if anything changed */
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return !err ? 1 : err;
+}
+
+#define SINGLE_BIT(n, type, description, address, mask, flags)	 	\
+static struct snd_kcontrol_new n##_control = {				\
+	.iface = SNDRV_CTL_ELEM_IFACE_##type,				\
+	.name = description,						\
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,			\
+	.info = onyx_snd_single_bit_info,				\
+	.get = onyx_snd_single_bit_get,					\
+	.put = onyx_snd_single_bit_put,					\
+	.private_value = (flags << 16) | (address << 8) | mask		\
+}
+
+SINGLE_BIT(spdif,
+	   MIXER,
+	   SNDRV_CTL_NAME_IEC958("", PLAYBACK, SWITCH),
+	   ONYX_REG_DIG_INFO4,
+	   ONYX_SPDIF_ENABLE,
+	   FLAG_SPDIFLOCK);
+SINGLE_BIT(ovr1,
+	   MIXER,
+	   "Oversampling Rate",
+	   ONYX_REG_DAC_CONTROL,
+	   ONYX_OVR1,
+	   0);
+SINGLE_BIT(flt0,
+	   MIXER,
+	   "Fast Digital Filter Rolloff",
+	   ONYX_REG_DAC_FILTER,
+	   ONYX_ROLLOFF_FAST,
+	   FLAG_POLARITY_INVERT);
+SINGLE_BIT(hpf,
+	   MIXER,
+	   "Highpass Filter",
+	   ONYX_REG_ADC_HPF_BYPASS,
+	   ONYX_HPF_DISABLE,
+	   FLAG_POLARITY_INVERT);
+SINGLE_BIT(dm12,
+	   MIXER,
+	   "Digital De-Emphasis",
+	   ONYX_REG_DAC_DEEMPH,
+	   ONYX_DIGDEEMPH_CTRL,
+	   0);
+
+static int onyx_spdif_info(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+static int onyx_spdif_mask_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	/* datasheet page 30, all others are 0 */
+	ucontrol->value.iec958.status[0] = 0x3e;
+	ucontrol->value.iec958.status[1] = 0xff;
+
+	ucontrol->value.iec958.status[3] = 0x3f;
+	ucontrol->value.iec958.status[4] = 0x0f;
+	
+	return 0;
+}
+
+static struct snd_kcontrol_new onyx_spdif_mask = {
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,CON_MASK),
+	.info =		onyx_spdif_info,
+	.get =		onyx_spdif_mask_get,
+};
+
+static int onyx_spdif_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	u8 v;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, ONYX_REG_DIG_INFO1, &v);
+	ucontrol->value.iec958.status[0] = v & 0x3e;
+
+	onyx_read_register(onyx, ONYX_REG_DIG_INFO2, &v);
+	ucontrol->value.iec958.status[1] = v;
+
+	onyx_read_register(onyx, ONYX_REG_DIG_INFO3, &v);
+	ucontrol->value.iec958.status[3] = v & 0x3f;
+
+	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
+	ucontrol->value.iec958.status[4] = v & 0x0f;
+	mutex_unlock(&onyx->mutex);
+
+	return 0;
+}
+
+static int onyx_spdif_put(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
+	u8 v;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, ONYX_REG_DIG_INFO1, &v);
+	v = (v & ~0x3e) | (ucontrol->value.iec958.status[0] & 0x3e);
+	onyx_write_register(onyx, ONYX_REG_DIG_INFO1, v);
+
+	v = ucontrol->value.iec958.status[1];
+	onyx_write_register(onyx, ONYX_REG_DIG_INFO2, v);
+
+	onyx_read_register(onyx, ONYX_REG_DIG_INFO3, &v);
+	v = (v & ~0x3f) | (ucontrol->value.iec958.status[3] & 0x3f);
+	onyx_write_register(onyx, ONYX_REG_DIG_INFO3, v);
+
+	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
+	v = (v & ~0x0f) | (ucontrol->value.iec958.status[4] & 0x0f);
+	onyx_write_register(onyx, ONYX_REG_DIG_INFO4, v);
+	mutex_unlock(&onyx->mutex);
+
+	return 1;
+}
+
+static struct snd_kcontrol_new onyx_spdif_ctrl = {
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+	.info =		onyx_spdif_info,
+	.get =		onyx_spdif_get,
+	.put =		onyx_spdif_put,
+};
+
+/* our registers */
+
+static u8 register_map[] = {
+	ONYX_REG_DAC_ATTEN_LEFT,
+	ONYX_REG_DAC_ATTEN_RIGHT,
+	ONYX_REG_CONTROL,
+	ONYX_REG_DAC_CONTROL,
+	ONYX_REG_DAC_DEEMPH,
+	ONYX_REG_DAC_FILTER,
+	ONYX_REG_DAC_OUTPHASE,
+	ONYX_REG_ADC_CONTROL,
+	ONYX_REG_ADC_HPF_BYPASS,
+	ONYX_REG_DIG_INFO1,
+	ONYX_REG_DIG_INFO2,
+	ONYX_REG_DIG_INFO3,
+	ONYX_REG_DIG_INFO4
+};
+
+static u8 initial_values[] = {
+	0x80, 0x80, /* muted */
+	ONYX_MRST | ONYX_SRST, /* but handled specially! */
+	ONYX_MUTE_LEFT | ONYX_MUTE_RIGHT,
+	0, /* no deemphasis */
+	ONYX_DAC_FILTER_ALWAYS,
+	ONYX_OUTPHASE_INVERTED,
+	(-1 /*dB*/ + 8) & 0xF, /* line in selected, -1 dB gain*/
+	ONYX_ADC_HPF_ALWAYS,
+	(1<<2),	/* pcm audio */
+	2,	/* category: pcm coder */
+	0,	/* sampling frequency 44.1 kHz, clock accuracy level II */
+	1	/* 24 bit depth */
+};
+
+/* reset registers of chip, either to initial or to previous values */
+static int onyx_register_init(struct onyx *onyx)
+{
+	int i;
+	u8 val;
+	u8 regs[sizeof(initial_values)];
+
+	if (!onyx->initialised) {
+		memcpy(regs, initial_values, sizeof(initial_values));
+		if (onyx_read_register(onyx, ONYX_REG_CONTROL, &val))
+			return -1;
+		val &= ~ONYX_SILICONVERSION;
+		val |= initial_values[3];
+		regs[3] = val;
+	} else {
+		for (i=0; i<sizeof(register_map); i++)
+			regs[i] = onyx->cache[register_map[i]-FIRSTREGISTER];
+	}
+
+	for (i=0; i<sizeof(register_map); i++) {
+		if (onyx_write_register(onyx, register_map[i], regs[i]))
+			return -1;
+	}
+	onyx->initialised = 1;
+	return 0;
+}
+
+static struct transfer_info onyx_transfers[] = {
+	/* this is first so we can skip it if no input is present...
+	 * No hardware exists with that, but it's here as an example
+	 * of what to do :) */
+	{
+		/* analog input */
+		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S24_BE,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.transfer_in = 1,
+		.must_be_clock_source = 0,
+		.tag = 0,
+	},
+	{
+		/* if analog and digital are currently off, anything should go,
+		 * so this entry describes everything we can do... */
+		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S24_BE
+#ifdef SNDRV_PCM_FMTBIT_COMPRESSED_16BE
+			   | SNDRV_PCM_FMTBIT_COMPRESSED_16BE
+#endif
+		,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.tag = 0,
+	},
+	{
+		/* analog output */
+		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S24_BE,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.transfer_in = 0,
+		.must_be_clock_source = 0,
+		.tag = 1,
+	},
+	{
+		/* digital pcm output, also possible for analog out */
+		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S24_BE,
+		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+		.transfer_in = 0,
+		.must_be_clock_source = 0,
+		.tag = 2,
+	},
+#ifdef SNDRV_PCM_FMTBIT_COMPRESSED_16BE
+Once alsa gets supports for this kind of thing we can add it...
+	{
+		/* digital compressed output */
+		.formats =  SNDRV_PCM_FMTBIT_COMPRESSED_16BE,
+		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+		.tag = 2,
+	},
+#endif
+	{}
+};
+
+static int onyx_usable(struct codec_info_item *cii,
+		       struct transfer_info *ti,
+		       struct transfer_info *out)
+{
+	u8 v;
+	struct onyx *onyx = cii->codec_data;
+	int spdif_enabled, analog_enabled;
+
+	mutex_lock(&onyx->mutex);
+	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
+	spdif_enabled = !!(v & ONYX_SPDIF_ENABLE);
+	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &v);
+	analog_enabled =  ((v & (ONYX_MUTE_RIGHT|ONYX_MUTE_LEFT)) != (ONYX_MUTE_RIGHT|ONYX_MUTE_LEFT));
+	mutex_unlock(&onyx->mutex);
+
+	switch (ti->tag) {
+	case 0: return 1;
+	case 1:	return analog_enabled;
+	case 2: return spdif_enabled;
+	}
+	return 1;
+}
+
+static int onyx_prepare(struct codec_info_item *cii,
+			struct bus_info *bi,
+			struct snd_pcm_substream *substream)
+{
+	u8 v;
+	struct onyx *onyx = cii->codec_data;
+	int err = -EBUSY;
+
+	mutex_lock(&onyx->mutex);
+
+#ifdef SNDRV_PCM_FMTBIT_COMPRESSED_16BE
+	if (substream->runtime->format == SNDRV_PCM_FMTBIT_COMPRESSED_16BE) {
+		/* mute and lock analog output */
+		onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &v);
+		if (onyx_write_register(onyx
+					ONYX_REG_DAC_CONTROL,
+					v | ONYX_MUTE_RIGHT | ONYX_MUTE_LEFT))
+			goto out_unlock;
+		onyx->analog_locked = 1;
+		err = 0;
+		goto out_unlock;
+	}
+#endif
+	switch (substream->runtime->rate) {
+	case 32000:
+	case 44100:
+	case 48000:
+		/* these rates are ok for all outputs */
+		/* FIXME: program spdif channel control bits here so that
+		 *	  userspace doesn't have to if it only plays pcm! */
+		err = 0;
+		goto out_unlock;
+	default:
+		/* got some rate that the digital output can't do,
+		 * so disable and lock it */
+		onyx_read_register(cii->codec_data, ONYX_REG_DIG_INFO4, &v);
+		if (onyx_write_register(onyx,
+					ONYX_REG_DIG_INFO4,
+					v & ~ONYX_SPDIF_ENABLE))
+			goto out_unlock;
+		onyx->spdif_locked = 1;
+		err = 0;
+		goto out_unlock;
+	}
+
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return err;
+}
+
+static int onyx_open(struct codec_info_item *cii,
+		     struct snd_pcm_substream *substream)
+{
+	struct onyx *onyx = cii->codec_data;
+
+	mutex_lock(&onyx->mutex);
+	onyx->open_count++;
+	mutex_unlock(&onyx->mutex);
+
+	return 0;
+}
+
+static int onyx_close(struct codec_info_item *cii,
+		      struct snd_pcm_substream *substream)
+{
+	struct onyx *onyx = cii->codec_data;
+
+	mutex_lock(&onyx->mutex);
+	onyx->open_count--;
+	if (!onyx->open_count)
+		onyx->spdif_locked = onyx->analog_locked = 0;
+	mutex_unlock(&onyx->mutex);
+
+	return 0;
+}
+
+static int onyx_switch_clock(struct codec_info_item *cii,
+			     enum clock_switch what)
+{
+	struct onyx *onyx = cii->codec_data;
+
+	mutex_lock(&onyx->mutex);
+	/* this *MUST* be more elaborate later... */
+	switch (what) {
+	case CLOCK_SWITCH_PREPARE_SLAVE:
+		onyx->codec.gpio->methods->all_amps_off(onyx->codec.gpio);
+		break;
+	case CLOCK_SWITCH_SLAVE:
+		onyx->codec.gpio->methods->all_amps_restore(onyx->codec.gpio);
+		break;
+	default: /* silence warning */
+		break;
+	}
+	mutex_unlock(&onyx->mutex);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int onyx_suspend(struct codec_info_item *cii, pm_message_t state)
+{
+	struct onyx *onyx = cii->codec_data;
+	u8 v;
+	int err = -ENXIO;
+
+	mutex_lock(&onyx->mutex);
+	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
+		goto out_unlock;
+	onyx_write_register(onyx, ONYX_REG_CONTROL, v | ONYX_ADPSV | ONYX_DAPSV);
+	/* Apple does a sleep here but the datasheet says to do it on resume */
+	err = 0;
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return err;
+}
+
+static int onyx_resume(struct codec_info_item *cii)
+{
+	struct onyx *onyx = cii->codec_data;
+	u8 v;
+	int err = -ENXIO;
+
+	mutex_lock(&onyx->mutex);
+	/* take codec out of suspend */
+	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
+		goto out_unlock;
+	onyx_write_register(onyx, ONYX_REG_CONTROL, v & ~(ONYX_ADPSV | ONYX_DAPSV));
+	/* FIXME: should divide by sample rate, but 8k is the lowest we go */
+	msleep(2205000/8000);
+	/* reset all values */
+	onyx_register_init(onyx);
+	err = 0;
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return err;
+}
+
+#endif /* CONFIG_PM */
+
+static struct codec_info onyx_codec_info = {
+	.transfers = onyx_transfers,
+	.sysclock_factor = 256,
+	.bus_factor = 64,
+	.owner = THIS_MODULE,
+	.usable = onyx_usable,
+	.prepare = onyx_prepare,
+	.open = onyx_open,
+	.close = onyx_close,
+	.switch_clock = onyx_switch_clock,
+#ifdef CONFIG_PM
+	.suspend = onyx_suspend,
+	.resume = onyx_resume,
+#endif
+};
+
+static int onyx_init_codec(struct aoa_codec *codec)
+{
+	struct onyx *onyx = codec_to_onyx(codec);
+	struct snd_kcontrol *ctl;
+	struct codec_info *ci = &onyx_codec_info;
+	u8 v;
+
+	if (!onyx->codec.gpio || !onyx->codec.gpio->methods) {
+		printk(KERN_ERR PFX "gpios not assigned!!\n");
+		return -EINVAL;
+	}
+
+	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 0);
+	msleep(1);
+	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 1);
+	msleep(1);
+	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 0);
+	msleep(1);
+	
+	if (onyx_register_init(onyx)) {
+		printk(KERN_ERR PFX "failed to initialise onyx registers\n");
+		return -ENODEV;
+	}
+
+	if (aoa_snd_device_new(SNDRV_DEV_LOWLEVEL, onyx, &ops)) {
+		printk(KERN_ERR PFX "failed to create onyx snd device!\n");
+		return -ENODEV;
+	}
+
+	/* nothing connected? what a joke! */
+	if ((onyx->codec.connected & 0xF) == 0)
+		return -ENOTCONN;
+
+	/* if no inputs are present... */
+	if ((onyx->codec.connected & 0xC) == 0) {
+		if (!onyx->codec_info)
+			onyx->codec_info = kmalloc(sizeof(struct codec_info), GFP_KERNEL);
+		if (!onyx->codec_info)
+			return -ENOMEM;
+		ci = onyx->codec_info;
+		*ci = onyx_codec_info;
+		ci->transfers++;
+	}
+
+	/* if no outputs are present... */
+	if ((onyx->codec.connected & 3) == 0) {
+		if (!onyx->codec_info)
+			onyx->codec_info = kmalloc(sizeof(struct codec_info), GFP_KERNEL);
+		if (!onyx->codec_info)
+			return -ENOMEM;
+		ci = onyx->codec_info;
+		/* this is fine as there have to be inputs
+		 * if we end up in this part of the code */
+		*ci = onyx_codec_info;
+		ci->transfers[1].formats = 0;
+	}
+
+	if (onyx->codec.soundbus_dev->attach_codec(onyx->codec.soundbus_dev,
+						   aoa_get_card(),
+						   ci, onyx)) {
+		printk(KERN_ERR PFX "error creating onyx pcm\n");
+		return -ENODEV;
+	}
+#define ADDCTL(n)							\
+	do {								\
+		ctl = snd_ctl_new1(&n, onyx);				\
+		if (ctl) {						\
+			ctl->id.device =				\
+				onyx->codec.soundbus_dev->pcm->device;	\
+			aoa_snd_ctl_add(ctl);				\
+		}							\
+	} while (0)
+
+	if (onyx->codec.soundbus_dev->pcm) {
+		/* give the user appropriate controls
+		 * depending on what inputs are connected */
+		if ((onyx->codec.connected & 0xC) == 0xC)
+			ADDCTL(capture_source_control);
+		else if (onyx->codec.connected & 4)
+			onyx_set_capture_source(onyx, 0);
+		else
+			onyx_set_capture_source(onyx, 1);
+		if (onyx->codec.connected & 0xC)
+			ADDCTL(inputgain_control);
+
+		/* depending on what output is connected,
+		 * give the user appropriate controls */
+		if (onyx->codec.connected & 1) {
+			ADDCTL(volume_control);
+			ADDCTL(mute_control);
+			ADDCTL(ovr1_control);
+			ADDCTL(flt0_control);
+			ADDCTL(hpf_control);
+			ADDCTL(dm12_control);
+			/* spdif control defaults to off */
+		}
+		if (onyx->codec.connected & 2) {
+			ADDCTL(onyx_spdif_mask);
+			ADDCTL(onyx_spdif_ctrl);
+		}
+		if ((onyx->codec.connected & 3) == 3)
+			ADDCTL(spdif_control);
+		/* if only S/PDIF is connected, enable it unconditionally */
+		if ((onyx->codec.connected & 3) == 2) {
+			onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
+			v |= ONYX_SPDIF_ENABLE;
+			onyx_write_register(onyx, ONYX_REG_DIG_INFO4, v);
+		}
+	}
+#undef ADDCTL
+	printk(KERN_INFO PFX "attached to onyx codec via i2c\n");
+
+	return 0;
+}
+
+static void onyx_exit_codec(struct aoa_codec *codec)
+{
+	struct onyx *onyx = codec_to_onyx(codec);
+
+	if (!onyx->codec.soundbus_dev) {
+		printk(KERN_ERR PFX "onyx_exit_codec called without soundbus_dev!\n");
+		return;
+	}
+	onyx->codec.soundbus_dev->detach_codec(onyx->codec.soundbus_dev, onyx);
+}
+
+static struct i2c_driver onyx_driver;
+
+static int onyx_create(struct i2c_adapter *adapter,
+		       struct device_node *node,
+		       int addr)
+{
+	struct onyx *onyx;
+	u8 dummy;
+
+	onyx = kzalloc(sizeof(struct onyx), GFP_KERNEL);
+
+	if (!onyx)
+		return -ENOMEM;
+
+	mutex_init(&onyx->mutex);
+	onyx->i2c.driver = &onyx_driver;
+	onyx->i2c.adapter = adapter;
+	onyx->i2c.addr = addr & 0x7f;
+	strncpy(onyx->i2c.name, "onyx audio codec", I2C_NAME_SIZE-1);
+
+	if (i2c_attach_client(&onyx->i2c)) {
+		printk(KERN_ERR PFX "failed to attach to i2c\n");
+		goto fail;
+	}
+
+	/* we try to read from register ONYX_REG_CONTROL
+	 * to check if the codec is present */
+	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &dummy) != 0) {
+		i2c_detach_client(&onyx->i2c);
+		printk(KERN_ERR PFX "failed to read control register\n");
+		goto fail;
+	}
+
+	strncpy(onyx->codec.name, "onyx", MAX_CODEC_NAME_LEN);
+	onyx->codec.owner = THIS_MODULE;
+	onyx->codec.init = onyx_init_codec;
+	onyx->codec.exit = onyx_exit_codec;
+	onyx->codec.node = of_node_get(node);
+
+	if (aoa_codec_register(&onyx->codec)) {
+		i2c_detach_client(&onyx->i2c);
+		goto fail;
+	}
+	printk(KERN_DEBUG PFX "created and attached onyx instance\n");
+	return 0;
+ fail:
+	kfree(onyx);
+	return -EINVAL;
+}
+
+static int onyx_i2c_attach(struct i2c_adapter *adapter)
+{
+	struct device_node *busnode, *dev = NULL;
+	struct pmac_i2c_bus *bus;
+
+	bus = pmac_i2c_adapter_to_bus(adapter);
+	if (bus == NULL)
+		return -ENODEV;
+	busnode = pmac_i2c_get_bus_node(bus);
+
+	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
+		if (device_is_compatible(dev, "pcm3052")) {
+			u32 *addr;
+			printk(KERN_DEBUG PFX "found pcm3052\n");
+			addr = (u32 *) get_property(dev, "reg", NULL);
+			if (!addr)
+				return -ENODEV;
+			return onyx_create(adapter, dev, (*addr)>>1);
+		}
+	}
+
+	/* if that didn't work, try desperate mode for older
+	 * machines that have stuff missing from the device tree */
+	
+	if (!device_is_compatible(busnode, "k2-i2c"))
+		return -ENODEV;
+
+	printk(KERN_DEBUG PFX "found k2-i2c, checking if onyx chip is on it\n");
+	/* probe both possible addresses for the onyx chip */
+	if (onyx_create(adapter, NULL, 0x46) == 0)
+		return 0;
+	return onyx_create(adapter, NULL, 0x47);
+}
+
+static int onyx_i2c_detach(struct i2c_client *client)
+{
+	struct onyx *onyx = container_of(client, struct onyx, i2c);
+	int err;
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+	aoa_codec_unregister(&onyx->codec);
+	of_node_put(onyx->codec.node);
+	if (onyx->codec_info)
+		kfree(onyx->codec_info);
+	kfree(onyx);
+	return 0;
+}
+
+static struct i2c_driver onyx_driver = {
+	.driver = {
+		.name = "aoa_codec_onyx",
+		.owner = THIS_MODULE,
+	},
+	.attach_adapter = onyx_i2c_attach,
+	.detach_client = onyx_i2c_detach,
+};
+
+static int __init onyx_init(void)
+{
+	return i2c_add_driver(&onyx_driver);
+}
+
+static void __exit onyx_exit(void)
+{
+	i2c_del_driver(&onyx_driver);
+}
+
+module_init(onyx_init);
+module_exit(onyx_exit);
--- /dev/null
+++ b/sound/aoa/codecs/snd-aoa-codec-onyx.h
@@ -0,0 +1,76 @@
+/*
+ * Apple Onboard Audio driver for Onyx codec (header)
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+#ifndef __SND_AOA_CODEC_ONYX_H
+#define __SND_AOA_CODEC_ONYX_H
+#include <stddef.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <asm/pmac_low_i2c.h>
+#include <asm/prom.h>
+
+/* PCM3052 register definitions */
+
+/* the attenuation registers take values from
+ * -1 (0dB) to -127 (-63.0 dB) or others (muted) */
+#define ONYX_REG_DAC_ATTEN_LEFT		65
+#define FIRSTREGISTER			ONYX_REG_DAC_ATTEN_LEFT
+#define ONYX_REG_DAC_ATTEN_RIGHT	66
+
+#define ONYX_REG_CONTROL		67
+#	define ONYX_MRST		(1<<7)
+#	define ONYX_SRST		(1<<6)
+#	define ONYX_ADPSV		(1<<5)
+#	define ONYX_DAPSV		(1<<4)
+#	define ONYX_SILICONVERSION	(1<<0)
+/* all others reserved */
+
+#define ONYX_REG_DAC_CONTROL		68
+#	define ONYX_OVR1		(1<<6)
+#	define ONYX_MUTE_RIGHT		(1<<1)
+#	define ONYX_MUTE_LEFT		(1<<0)
+
+#define ONYX_REG_DAC_DEEMPH		69
+#	define ONYX_DIGDEEMPH_SHIFT	5
+#	define ONYX_DIGDEEMPH_MASK	(3<<ONYX_DIGDEEMPH_SHIFT)
+#	define ONYX_DIGDEEMPH_CTRL	(1<<4)
+
+#define ONYX_REG_DAC_FILTER		70
+#	define ONYX_ROLLOFF_FAST	(1<<5)
+#	define ONYX_DAC_FILTER_ALWAYS	(1<<2)
+
+#define	ONYX_REG_DAC_OUTPHASE		71
+#	define ONYX_OUTPHASE_INVERTED	(1<<0)
+
+#define ONYX_REG_ADC_CONTROL		72
+#	define ONYX_ADC_INPUT_MIC	(1<<5)
+/* 8 + input gain in dB, valid range for input gain is -4 .. 20 dB */
+#	define ONYX_ADC_PGA_GAIN_MASK	0x1f
+
+#define ONYX_REG_ADC_HPF_BYPASS		75
+#	define ONYX_HPF_DISABLE		(1<<3)
+#	define ONYX_ADC_HPF_ALWAYS	(1<<2)
+
+#define ONYX_REG_DIG_INFO1		77
+#	define ONYX_MASK_DIN_TO_BPZ	(1<<7)
+/* bits 1-5 control channel bits 1-5 */
+#	define ONYX_DIGOUT_DISABLE	(1<<0)
+
+#define ONYX_REG_DIG_INFO2		78
+/* controls channel bits 8-15 */
+
+#define ONYX_REG_DIG_INFO3		79
+/* control channel bits 24-29, high 2 bits reserved */
+
+#define ONYX_REG_DIG_INFO4		80
+#	define ONYX_VALIDL		(1<<7)
+#	define ONYX_VALIDR		(1<<6)
+#	define ONYX_SPDIF_ENABLE	(1<<5)
+/* lower 4 bits control bits 32-35 of channel control and word length */
+#	define ONYX_WORDLEN_MASK	(0xF)
+
+#endif /* __SND_AOA_CODEC_ONYX_H */
--- /dev/null
+++ b/sound/aoa/codecs/snd-aoa-codec-tas-gain-table.h
@@ -0,0 +1,209 @@
+/*
+ This is the program used to generate below table.
+
+#include <stdio.h>
+#include <math.h>
+int main() {
+  int dB2;
+  printf("/" "* This file is only included exactly once!\n");
+  printf(" *\n");
+  printf(" * If they'd only tell us that generating this table was\n");
+  printf(" * as easy as calculating\n");
+  printf(" *      hwvalue = 1048576.0*exp(0.057564628*dB*2)\n");
+  printf(" * :) *" "/\n");
+  printf("static int tas_gaintable[] = {\n");
+  printf("	0x000000, /" "* -infinity dB *" "/\n");
+  for (dB2=-140;dB2<=36;dB2++)
+    printf("	0x%.6x, /" "* %-02.1f dB *" "/\n", (int)(1048576.0*exp(0.057564628*dB2)), dB2/2.0);
+  printf("};\n\n");
+}
+
+*/
+
+/* This file is only included exactly once!
+ *
+ * If they'd only tell us that generating this table was
+ * as easy as calculating
+ *      hwvalue = 1048576.0*exp(0.057564628*dB*2)
+ * :) */
+static int tas_gaintable[] = {
+	0x000000, /* -infinity dB */
+	0x00014b, /* -70.0 dB */
+	0x00015f, /* -69.5 dB */
+	0x000174, /* -69.0 dB */
+	0x00018a, /* -68.5 dB */
+	0x0001a1, /* -68.0 dB */
+	0x0001ba, /* -67.5 dB */
+	0x0001d4, /* -67.0 dB */
+	0x0001f0, /* -66.5 dB */
+	0x00020d, /* -66.0 dB */
+	0x00022c, /* -65.5 dB */
+	0x00024d, /* -65.0 dB */
+	0x000270, /* -64.5 dB */
+	0x000295, /* -64.0 dB */
+	0x0002bc, /* -63.5 dB */
+	0x0002e6, /* -63.0 dB */
+	0x000312, /* -62.5 dB */
+	0x000340, /* -62.0 dB */
+	0x000372, /* -61.5 dB */
+	0x0003a6, /* -61.0 dB */
+	0x0003dd, /* -60.5 dB */
+	0x000418, /* -60.0 dB */
+	0x000456, /* -59.5 dB */
+	0x000498, /* -59.0 dB */
+	0x0004de, /* -58.5 dB */
+	0x000528, /* -58.0 dB */
+	0x000576, /* -57.5 dB */
+	0x0005c9, /* -57.0 dB */
+	0x000620, /* -56.5 dB */
+	0x00067d, /* -56.0 dB */
+	0x0006e0, /* -55.5 dB */
+	0x000748, /* -55.0 dB */
+	0x0007b7, /* -54.5 dB */
+	0x00082c, /* -54.0 dB */
+	0x0008a8, /* -53.5 dB */
+	0x00092b, /* -53.0 dB */
+	0x0009b6, /* -52.5 dB */
+	0x000a49, /* -52.0 dB */
+	0x000ae5, /* -51.5 dB */
+	0x000b8b, /* -51.0 dB */
+	0x000c3a, /* -50.5 dB */
+	0x000cf3, /* -50.0 dB */
+	0x000db8, /* -49.5 dB */
+	0x000e88, /* -49.0 dB */
+	0x000f64, /* -48.5 dB */
+	0x00104e, /* -48.0 dB */
+	0x001145, /* -47.5 dB */
+	0x00124b, /* -47.0 dB */
+	0x001361, /* -46.5 dB */
+	0x001487, /* -46.0 dB */
+	0x0015be, /* -45.5 dB */
+	0x001708, /* -45.0 dB */
+	0x001865, /* -44.5 dB */
+	0x0019d8, /* -44.0 dB */
+	0x001b60, /* -43.5 dB */
+	0x001cff, /* -43.0 dB */
+	0x001eb7, /* -42.5 dB */
+	0x002089, /* -42.0 dB */
+	0x002276, /* -41.5 dB */
+	0x002481, /* -41.0 dB */
+	0x0026ab, /* -40.5 dB */
+	0x0028f5, /* -40.0 dB */
+	0x002b63, /* -39.5 dB */
+	0x002df5, /* -39.0 dB */
+	0x0030ae, /* -38.5 dB */
+	0x003390, /* -38.0 dB */
+	0x00369e, /* -37.5 dB */
+	0x0039db, /* -37.0 dB */
+	0x003d49, /* -36.5 dB */
+	0x0040ea, /* -36.0 dB */
+	0x0044c3, /* -35.5 dB */
+	0x0048d6, /* -35.0 dB */
+	0x004d27, /* -34.5 dB */
+	0x0051b9, /* -34.0 dB */
+	0x005691, /* -33.5 dB */
+	0x005bb2, /* -33.0 dB */
+	0x006121, /* -32.5 dB */
+	0x0066e3, /* -32.0 dB */
+	0x006cfb, /* -31.5 dB */
+	0x007370, /* -31.0 dB */
+	0x007a48, /* -30.5 dB */
+	0x008186, /* -30.0 dB */
+	0x008933, /* -29.5 dB */
+	0x009154, /* -29.0 dB */
+	0x0099f1, /* -28.5 dB */
+	0x00a310, /* -28.0 dB */
+	0x00acba, /* -27.5 dB */
+	0x00b6f6, /* -27.0 dB */
+	0x00c1cd, /* -26.5 dB */
+	0x00cd49, /* -26.0 dB */
+	0x00d973, /* -25.5 dB */
+	0x00e655, /* -25.0 dB */
+	0x00f3fb, /* -24.5 dB */
+	0x010270, /* -24.0 dB */
+	0x0111c0, /* -23.5 dB */
+	0x0121f9, /* -23.0 dB */
+	0x013328, /* -22.5 dB */
+	0x01455b, /* -22.0 dB */
+	0x0158a2, /* -21.5 dB */
+	0x016d0e, /* -21.0 dB */
+	0x0182af, /* -20.5 dB */
+	0x019999, /* -20.0 dB */
+	0x01b1de, /* -19.5 dB */
+	0x01cb94, /* -19.0 dB */
+	0x01e6cf, /* -18.5 dB */
+	0x0203a7, /* -18.0 dB */
+	0x022235, /* -17.5 dB */
+	0x024293, /* -17.0 dB */
+	0x0264db, /* -16.5 dB */
+	0x02892c, /* -16.0 dB */
+	0x02afa3, /* -15.5 dB */
+	0x02d862, /* -15.0 dB */
+	0x03038a, /* -14.5 dB */
+	0x033142, /* -14.0 dB */
+	0x0361af, /* -13.5 dB */
+	0x0394fa, /* -13.0 dB */
+	0x03cb50, /* -12.5 dB */
+	0x0404de, /* -12.0 dB */
+	0x0441d5, /* -11.5 dB */
+	0x048268, /* -11.0 dB */
+	0x04c6d0, /* -10.5 dB */
+	0x050f44, /* -10.0 dB */
+	0x055c04, /* -9.5 dB */
+	0x05ad50, /* -9.0 dB */
+	0x06036e, /* -8.5 dB */
+	0x065ea5, /* -8.0 dB */
+	0x06bf44, /* -7.5 dB */
+	0x07259d, /* -7.0 dB */
+	0x079207, /* -6.5 dB */
+	0x0804dc, /* -6.0 dB */
+	0x087e80, /* -5.5 dB */
+	0x08ff59, /* -5.0 dB */
+	0x0987d5, /* -4.5 dB */
+	0x0a1866, /* -4.0 dB */
+	0x0ab189, /* -3.5 dB */
+	0x0b53be, /* -3.0 dB */
+	0x0bff91, /* -2.5 dB */
+	0x0cb591, /* -2.0 dB */
+	0x0d765a, /* -1.5 dB */
+	0x0e4290, /* -1.0 dB */
+	0x0f1adf, /* -0.5 dB */
+	0x100000, /* 0.0 dB */
+	0x10f2b4, /* 0.5 dB */
+	0x11f3c9, /* 1.0 dB */
+	0x13041a, /* 1.5 dB */
+	0x14248e, /* 2.0 dB */
+	0x15561a, /* 2.5 dB */
+	0x1699c0, /* 3.0 dB */
+	0x17f094, /* 3.5 dB */
+	0x195bb8, /* 4.0 dB */
+	0x1adc61, /* 4.5 dB */
+	0x1c73d5, /* 5.0 dB */
+	0x1e236d, /* 5.5 dB */
+	0x1fec98, /* 6.0 dB */
+	0x21d0d9, /* 6.5 dB */
+	0x23d1cd, /* 7.0 dB */
+	0x25f125, /* 7.5 dB */
+	0x2830af, /* 8.0 dB */
+	0x2a9254, /* 8.5 dB */
+	0x2d1818, /* 9.0 dB */
+	0x2fc420, /* 9.5 dB */
+	0x3298b0, /* 10.0 dB */
+	0x35982f, /* 10.5 dB */
+	0x38c528, /* 11.0 dB */
+	0x3c224c, /* 11.5 dB */
+	0x3fb278, /* 12.0 dB */
+	0x4378b0, /* 12.5 dB */
+	0x477829, /* 13.0 dB */
+	0x4bb446, /* 13.5 dB */
+	0x5030a1, /* 14.0 dB */
+	0x54f106, /* 14.5 dB */
+	0x59f980, /* 15.0 dB */
+	0x5f4e52, /* 15.5 dB */
+	0x64f403, /* 16.0 dB */
+	0x6aef5e, /* 16.5 dB */
+	0x714575, /* 17.0 dB */
+	0x77fbaa, /* 17.5 dB */
+	0x7f17af, /* 18.0 dB */
+};
+
--- /dev/null
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -0,0 +1,669 @@
+/*
+ * Apple Onboard Audio driver for tas codec
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ *
+ * Open questions:
+ *  - How to distinguish between 3004 and versions?
+ *
+ * FIXMEs:
+ *  - This codec driver doesn't honour the 'connected'
+ *    property of the aoa_codec struct, hence if
+ *    it is used in machines where not everything is
+ *    connected it will display wrong mixer elements.
+ *  - Driver assumes that the microphone is always
+ *    monaureal and connected to the right channel of
+ *    the input. This should also be a codec-dependent
+ *    flag, maybe the codec should have 3 different
+ *    bits for the three different possibilities how
+ *    it can be hooked up...
+ *    But as long as I don't see any hardware hooked
+ *    up that way...
+ *  - As Apple notes in their code, the tas3004 seems
+ *    to delay the right channel by one sample. You can
+ *    see this when for example recording stereo in
+ *    audacity, or recording the tas output via cable
+ *    on another machine (use a sinus generator or so).
+ *    I tried programming the BiQuads but couldn't
+ *    make the delay work, maybe someone can read the
+ *    datasheet and fix it. The relevant Apple comment
+ *    is in AppleTAS3004Audio.cpp lines 1637 ff. Note
+ *    that their comment describing how they program
+ *    the filters sucks...
+ *
+ * Other things:
+ *  - this should actually register *two* aoa_codec
+ *    structs since it has two inputs. Then it must
+ *    use the prepare callback to forbid running the
+ *    secondary output on a different clock.
+ *    Also, whatever bus knows how to do this must
+ *    provide two soundbus_dev devices and the fabric
+ *    must be able to link them correctly.
+ *
+ *    I don't even know if Apple ever uses the second
+ *    port on the tas3004 though, I don't think their
+ *    i2s controllers can even do it. OTOH, they all
+ *    derive the clocks from common clocks, so it
+ *    might just be possible. The framework allows the
+ *    codec to refine the transfer_info items in the
+ *    usable callback, so we can simply remove the
+ *    rates the second instance is not using when it
+ *    actually is in use.
+ *    Maybe we'll need to make the sound busses have
+ *    a 'clock group id' value so the codec can
+ *    determine if the two outputs can be driven at
+ *    the same time. But that is likely overkill, up
+ *    to the fabric to not link them up incorrectly,
+ *    and up to the hardware designer to not wire
+ *    them up in some weird unusable way.
+ */
+#include <stddef.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <asm/pmac_low_i2c.h>
+#include <asm/prom.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("tas codec driver for snd-aoa");
+
+#include "snd-aoa-codec-tas.h"
+#include "snd-aoa-codec-tas-gain-table.h"
+/* FIXME */
+#include "../aoa.h"
+#include "../soundbus/soundbus.h"
+
+
+#define PFX "snd-aoa-codec-tas: "
+
+/* we use these to determine which codec we got */
+#define TAS_PRIMARY_MAGIC	0x74617331 /* tas1 */
+#define TAS_SECONDARY_MAGIC	0x32746173 /* 2tas */
+#define TAS_TERTIARY_MAGIC	0x74336173 /* t3as */
+
+struct tas {
+	u32			primary_magic;
+	struct aoa_codec	codec;
+	/* see comment at top of file */
+	u32			secondary_magic;
+	struct aoa_codec	secondary;
+	struct i2c_client	i2c;
+	u32			muted_l:1, muted_r:1,
+				controls_created:1;
+	u8			cached_volume_l, cached_volume_r;
+	u8			mixer_l[3], mixer_r[3];
+	u8			acr;
+};
+
+static struct tas *codec_to_tas(struct aoa_codec *codec)
+{
+	u32 *tmp = (u32*)codec;
+	switch (*(tmp-1)) {
+	case TAS_PRIMARY_MAGIC:
+		return container_of(codec, struct tas, codec);
+	case TAS_SECONDARY_MAGIC:
+		return container_of(codec, struct tas, secondary);
+	default:
+		return NULL;
+	}
+}
+
+static inline int tas_write_reg(struct tas *tas, u8 reg, u8 len, u8 *data)
+{
+	if (len == 1)
+		return i2c_smbus_write_byte_data(&tas->i2c, reg, *data);
+	else
+		return i2c_smbus_write_i2c_block_data(&tas->i2c, reg, len, data);
+}
+
+static void tas_set_volume(struct tas *tas)
+{
+	u8 block[6];
+	int tmp;
+	u8 left, right;
+
+	left = tas->cached_volume_l;
+	right = tas->cached_volume_r;
+
+	if (left > 177) left = 177;
+	if (right > 177) right = 177;
+
+	if (tas->muted_l) left = 0;
+	if (tas->muted_r) right = 0;
+
+	/* analysing the volume and mixer tables shows
+	 * that they are similar enough when we shift
+	 * the mixer table down by 4 bits. The error
+	 * is miniscule, in just one item the error
+	 * is 1, at a value of 0x07f17b (mixer table
+	 * value is 0x07f17a) */
+	tmp = tas_gaintable[left];
+	block[0] = tmp>>20;
+	block[1] = tmp>>12;
+	block[2] = tmp>>4;
+	tmp = tas_gaintable[right];
+	block[3] = tmp>>20;
+	block[4] = tmp>>12;
+	block[5] = tmp>>4;
+	tas_write_reg(tas, TAS_REG_VOL, 6, block);
+}
+
+static void tas_set_mixer(struct tas *tas)
+{
+	u8 block[9];
+	int tmp, i;
+	u8 val;
+
+	for (i=0;i<3;i++) {
+		val = tas->mixer_l[i];
+		if (val > 177) val = 177;
+		tmp = tas_gaintable[val];
+		block[3*i+0] = tmp>>16;
+		block[3*i+1] = tmp>>8;
+		block[3*i+2] = tmp;
+	}
+	tas_write_reg(tas, TAS_REG_LMIX, 9, block);
+
+	for (i=0;i<3;i++) {
+		val = tas->mixer_r[i];
+		if (val > 177) val = 177;
+		tmp = tas_gaintable[val];
+		block[3*i+0] = tmp>>16;
+		block[3*i+1] = tmp>>8;
+		block[3*i+2] = tmp;
+	}
+	tas_write_reg(tas, TAS_REG_RMIX, 9, block);
+}
+
+/* alsa stuff */
+
+static int tas_dev_register(struct snd_device *dev)
+{
+	return 0;
+}
+
+static struct snd_device_ops ops = {
+	.dev_register = tas_dev_register,
+};
+
+static int tas_snd_vol_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 177;
+	return 0;
+}
+
+static int tas_snd_vol_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas->cached_volume_l;
+	ucontrol->value.integer.value[1] = tas->cached_volume_r;
+	return 0;
+}
+
+static int tas_snd_vol_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	tas->cached_volume_l = ucontrol->value.integer.value[0];
+	tas->cached_volume_r = ucontrol->value.integer.value[1];
+	tas_set_volume(tas);
+	return 1;
+}
+
+static struct snd_kcontrol_new volume_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Master Playback Volume",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = tas_snd_vol_info,
+	.get = tas_snd_vol_get,
+	.put = tas_snd_vol_put,
+};
+
+static int tas_snd_mute_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int tas_snd_mute_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = !tas->muted_l;
+	ucontrol->value.integer.value[1] = !tas->muted_r;
+	return 0;
+}
+
+static int tas_snd_mute_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	tas->muted_l = !ucontrol->value.integer.value[0];
+	tas->muted_r = !ucontrol->value.integer.value[1];
+	tas_set_volume(tas);
+	return 1;
+}
+
+static struct snd_kcontrol_new mute_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Master Playback Switch",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = tas_snd_mute_info,
+	.get = tas_snd_mute_get,
+	.put = tas_snd_mute_put,
+};
+
+static int tas_snd_mixer_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 177;
+	return 0;
+}
+
+static int tas_snd_mixer_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+	int idx = kcontrol->private_value;
+
+	ucontrol->value.integer.value[0] = tas->mixer_l[idx];
+	ucontrol->value.integer.value[1] = tas->mixer_r[idx];
+
+	return 0;
+}
+
+static int tas_snd_mixer_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+	int idx = kcontrol->private_value;
+
+	tas->mixer_l[idx] = ucontrol->value.integer.value[0];
+	tas->mixer_r[idx] = ucontrol->value.integer.value[1];
+
+	tas_set_mixer(tas);
+	return 1;
+}
+
+#define MIXER_CONTROL(n,descr,idx)			\
+static struct snd_kcontrol_new n##_control = {		\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,		\
+	.name = descr " Playback Volume",		\
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,	\
+	.info = tas_snd_mixer_info,			\
+	.get = tas_snd_mixer_get,			\
+	.put = tas_snd_mixer_put,			\
+	.private_value = idx,				\
+}
+
+MIXER_CONTROL(pcm1, "PCM1", 0);
+MIXER_CONTROL(pcm2, "PCM2", 1);
+MIXER_CONTROL(monitor, "Monitor", 2);
+
+static int tas_snd_capture_source_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	static char* texts[] = { "Line-In", "Microphone" };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item > 1)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int tas_snd_capture_source_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = !!(tas->acr & TAS_ACR_INPUT_B);
+	return 0;
+}
+
+static int tas_snd_capture_source_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tas *tas = snd_kcontrol_chip(kcontrol);
+
+	tas->acr &= ~TAS_ACR_INPUT_B;
+	if (ucontrol->value.enumerated.item[0])
+		tas->acr |= TAS_ACR_INPUT_B;
+	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	return 1;
+}
+
+static struct snd_kcontrol_new capture_source_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	/* If we name this 'Input Source', it properly shows up in
+	 * alsamixer as a selection, * but it's shown under the
+	 * 'Playback' category.
+	 * If I name it 'Capture Source', it shows up in strange
+	 * ways (two bools of which one can be selected at a
+	 * time) but at least it's shown in the 'Capture'
+	 * category.
+	 * I was told that this was due to backward compatibility,
+	 * but I don't understand then why the mangling is *not*
+	 * done when I name it "Input Source".....
+	 */
+	.name = "Capture Source",
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = tas_snd_capture_source_info,
+	.get = tas_snd_capture_source_get,
+	.put = tas_snd_capture_source_put,
+};
+
+
+static struct transfer_info tas_transfers[] = {
+	{
+		/* input */
+		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
+			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
+		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+		.transfer_in = 1,
+	},
+	{
+		/* output */
+		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
+			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
+		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+		.transfer_in = 0,
+	},
+	{}
+};
+
+static int tas_usable(struct codec_info_item *cii,
+		      struct transfer_info *ti,
+		      struct transfer_info *out)
+{
+	return 1;
+}
+
+static int tas_reset_init(struct tas *tas)
+{
+	u8 tmp;
+/*
+	char write[8];
+	union i2c_smbus_data read = { 0 };
+	int r1, r2;
+*/
+	tas->codec.gpio->methods->set_hw_reset(tas->codec.gpio, 0);
+	msleep(1);
+	tas->codec.gpio->methods->set_hw_reset(tas->codec.gpio, 1);
+	msleep(1);
+	tas->codec.gpio->methods->set_hw_reset(tas->codec.gpio, 0);
+	msleep(1);
+
+	tas->acr &= ~TAS_ACR_ANALOG_PDOWN;
+	tas->acr |= TAS_ACR_B_MONAUREAL | TAS_ACR_B_MON_SEL_RIGHT;
+	if (tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr))
+		return -ENODEV;
+
+	tmp = TAS_MCS_SCLK64 | TAS_MCS_SPORT_MODE_I2S | TAS_MCS_SPORT_WL_24BIT;
+	if (tas_write_reg(tas, TAS_REG_MCS, 1, &tmp))
+		return -ENODEV;
+
+	tmp = 0;
+	if (tas_write_reg(tas, TAS_REG_MCS2, 1, &tmp))
+		return -ENODEV;
+/* I need help here!
+	/* This is a bit tricky, but serves to detect if there really
+	 * is a tas codec present.
+	 * First, we set the volume register to 00,00,01 (on both channels).
+	 * This is almost muted. Then, we read back the last 6 bytes we
+	 * wrote to the chip, and check if they are the same.
+	 *
+	write[0] = 7;
+	write[1] = TAS_REG_VOL;
+	write[2] = write[3] = 0;
+	write[4] = 1;
+	write[5] = write[6] = 0;
+	write[7] = 1;
+	r1 = tas_write_reg(tas, TAS_REG_VOL, 6, &write[1]);
+	/* Hmm, how am I supposed to do the i2c sequence that
+	 * is mentioned on page 45 of the tas3004 datasheet?
+	 * This doesn't cut it: *
+	read.block[0] = 7;
+	r2 = i2c_smbus_xfer(tas->i2c.adapter, tas->i2c.addr, tas->i2c.flags,
+			    I2C_SMBUS_READ, TAS_REG_VOL,
+			    I2C_SMBUS_BLOCK_DATA, &read);
+
+	printk(KERN_DEBUG "r1 = %d, r2 = %d, read=%x %x %x %x %x %x %x %x\n", r1, r2, read.block[0], read.block[1], read.block[2], read.block[3], read.block[4], read.block[5], read.block[6], read.block[7]);
+
+	if (r1 || r2 ||  memcmp(write, read.block, 8))
+		return -ENODEV;
+*/
+
+	return 0;
+}
+
+/* we are controlled via i2c and assume that is always up
+ * If that wasn't the case, we'd have to suspend once
+ * our i2c device is suspended, and then take note of that! */
+static int tas_suspend(struct tas *tas)
+{
+	tas->acr |= TAS_ACR_ANALOG_PDOWN;
+	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	return 0;
+}
+
+static int tas_resume(struct tas *tas)
+{
+	/* reset codec */
+	tas_reset_init(tas);
+	tas_set_volume(tas);
+	tas_set_mixer(tas);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int _tas_suspend(struct codec_info_item *cii, pm_message_t state)
+{
+	return tas_suspend(cii->codec_data);
+}
+
+static int _tas_resume(struct codec_info_item *cii)
+{
+	return tas_resume(cii->codec_data);
+}
+#endif
+
+static struct codec_info tas_codec_info = {
+	.transfers = tas_transfers,
+	/* in theory, we can drive it at 512 too...
+	 * but so far the framework doesn't allow
+	 * for that and I don't see much point in it. */
+	.sysclock_factor = 256,
+	/* same here, could be 32 for just one 16 bit format */
+	.bus_factor = 64,
+	.owner = THIS_MODULE,
+	.usable = tas_usable,
+#ifdef CONFIG_PM
+	.suspend = _tas_suspend,
+	.resume = _tas_resume,
+#endif
+};
+
+static int tas_init_codec(struct aoa_codec *codec)
+{
+	struct tas *tas = codec_to_tas(codec);
+	int primary = codec == &tas->codec;
+
+	if (!tas->codec.gpio || !tas->codec.gpio->methods) {
+		printk(KERN_ERR PFX "gpios not assigned!!\n");
+		return -EINVAL;
+	}
+
+	if (tas_reset_init(tas)) {
+		printk(KERN_ERR PFX "tas failed to initialise\n");
+		return -ENXIO;
+	}
+
+	if (tas->codec.soundbus_dev->attach_codec(tas->codec.soundbus_dev,
+						   aoa_get_card(),
+						   &tas_codec_info, tas)) {
+		printk(KERN_ERR PFX "error attaching tas to soundbus\n");
+		return -ENODEV;
+	}
+
+	if (aoa_snd_device_new(SNDRV_DEV_LOWLEVEL, tas, &ops)) {
+		printk(KERN_ERR PFX "failed to create tas snd device!\n");
+		return -ENODEV;
+	}
+	aoa_snd_ctl_add(snd_ctl_new1(&volume_control, tas));
+	aoa_snd_ctl_add(snd_ctl_new1(&mute_control, tas));
+	if (primary) {
+		aoa_snd_ctl_add(snd_ctl_new1(&pcm1_control, tas));
+	} else {
+		aoa_snd_ctl_add(snd_ctl_new1(&pcm2_control, tas));
+	}
+	aoa_snd_ctl_add(snd_ctl_new1(&monitor_control, tas));
+	aoa_snd_ctl_add(snd_ctl_new1(&capture_source_control, tas));
+	return 0;
+}
+
+static void tas_exit_codec(struct aoa_codec *codec)
+{
+	struct tas *tas = codec_to_tas(codec);
+
+	if (!tas->codec.soundbus_dev)
+		return;
+	tas->codec.soundbus_dev->detach_codec(tas->codec.soundbus_dev, tas);
+}
+	
+
+static struct i2c_driver tas_driver;
+
+static int tas_create(struct i2c_adapter *adapter,
+		       struct device_node *node,
+		       int addr)
+{
+	struct tas *tas;
+
+	tas = kzalloc(sizeof(struct tas), GFP_KERNEL);
+
+	if (!tas)
+		return -ENOMEM;
+
+	tas->primary_magic = TAS_PRIMARY_MAGIC;
+	tas->secondary_magic = TAS_SECONDARY_MAGIC;
+	tas->i2c.driver = &tas_driver;
+	tas->i2c.adapter = adapter;
+	tas->i2c.addr = (addr >> 1) & 0x7f;
+	strncpy(tas->i2c.name, "tas audio codec", I2C_NAME_SIZE-1);
+
+	if (i2c_attach_client(&tas->i2c)) {
+		printk(KERN_ERR PFX "failed to attach to i2c\n");
+		goto fail;
+	}
+
+	strncpy(tas->codec.name, "tas", MAX_CODEC_NAME_LEN);
+	tas->codec.owner = THIS_MODULE;
+	tas->codec.init = tas_init_codec;
+	tas->codec.exit = tas_exit_codec;
+	tas->codec.node = of_node_get(node);
+
+	if (aoa_codec_register(&tas->codec)) {
+		goto detach;
+	}
+	printk(KERN_DEBUG "snd-aoa-codec-tas: created and attached tas instance\n");
+	return 0;
+ detach:
+	i2c_detach_client(&tas->i2c);
+ fail:
+	kfree(tas);
+	return -EINVAL;
+}
+
+static int tas_i2c_attach(struct i2c_adapter *adapter)
+{
+	struct device_node *busnode, *dev = NULL;
+	struct pmac_i2c_bus *bus;
+
+	bus = pmac_i2c_adapter_to_bus(adapter);
+	if (bus == NULL)
+		return -ENODEV;
+	busnode = pmac_i2c_get_bus_node(bus);
+
+	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
+		if (device_is_compatible(dev, "tas3004")) {
+			u32 *addr;
+			printk(KERN_DEBUG PFX "found tas3004\n");
+			addr = (u32 *) get_property(dev, "reg", NULL);
+			if (!addr)
+				return -ENODEV;
+			return tas_create(adapter, dev, *addr);
+		}
+	}
+
+	/* if that didn't work, try desperate mode for older
+	 * machines that have stuff missing from the device tree */
+
+	if (!device_is_compatible(busnode, "keywest-i2c-bus"))
+		return -ENODEV;
+
+	printk(KERN_DEBUG PFX "found keywest-i2c-bus, checking if tas chip is on it\n");
+	/* can actually have address 0x34 as well... */
+	return tas_create(adapter, NULL, 0x35);
+}
+
+static int tas_i2c_detach(struct i2c_client *client)
+{
+	struct tas *tas = container_of(client, struct tas, i2c);
+	int err;
+	u8 tmp = TAS_ACR_ANALOG_PDOWN;
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+	aoa_codec_unregister(&tas->codec);
+	of_node_put(tas->codec.node);
+
+	/* power down codec chip */
+	tas_write_reg(tas, TAS_REG_ACR, 1, &tmp);
+
+	kfree(tas);
+	return 0;
+}
+
+static struct i2c_driver tas_driver = {
+	.driver = {
+		.name = "aoa_codec_tas",
+		.owner = THIS_MODULE,
+	},
+	.attach_adapter = tas_i2c_attach,
+	.detach_client = tas_i2c_detach,
+};
+
+static int __init tas_init(void)
+{
+	return i2c_add_driver(&tas_driver);
+}
+
+static void __exit tas_exit(void)
+{
+	i2c_del_driver(&tas_driver);
+}
+
+module_init(tas_init);
+module_exit(tas_exit);
--- /dev/null
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.h
@@ -0,0 +1,47 @@
+/*
+ * Apple Onboard Audio driver for tas codec (header)
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+#ifndef __SND_AOA_CODECTASH
+#define __SND_AOA_CODECTASH
+
+#define TAS_REG_MCS	0x01	/* main control */
+#	define TAS_MCS_FASTLOAD		(1<<7)
+#	define TAS_MCS_SCLK64		(1<<6)
+#	define TAS_MCS_SPORT_MODE_MASK	(3<<4)
+#	define TAS_MCS_SPORT_MODE_I2S	(2<<4)
+#	define TAS_MCS_SPORT_MODE_RJ	(1<<4)
+#	define TAS_MCS_SPORT_MODE_LJ	(0<<4)
+#	define TAS_MCS_SPORT_WL_MASK	(3<<0)
+#	define TAS_MCS_SPORT_WL_16BIT	(0<<0)
+#	define TAS_MCS_SPORT_WL_18BIT	(1<<0)
+#	define TAS_MCS_SPORT_WL_20BIT	(2<<0)
+#	define TAS_MCS_SPORT_WL_24BIT	(3<<0)
+
+#define TAS_REG_DRC	0x02
+#define TAS_REG_VOL	0x04
+#define TAS_REG_TREBLE	0x05
+#define TAS_REG_BASS	0x06
+#define TAS_REG_LMIX	0x07
+#define TAS_REG_RMIX	0x08
+
+#define TAS_REG_ACR	0x40	/* analog control */
+#	define TAS_ACR_B_MONAUREAL	(1<<7)
+#	define TAS_ACR_B_MON_SEL_RIGHT	(1<<6)
+#	define TAS_ACR_DEEMPH_MASK	(3<<2)
+#	define TAS_ACR_DEEMPH_OFF	(0<<2)
+#	define TAS_ACR_DEEMPH_48KHz	(1<<2)
+#	define TAS_ACR_DEEMPH_44KHz	(2<<2)
+#	define TAS_ACR_INPUT_B		(1<<1)
+#	define TAS_ACR_ANALOG_PDOWN	(1<<0)
+
+#define TAS_REG_MCS2	0x43	/* main control 2 */
+#	define TAS_MCS2_ALLPASS		(1<<1)
+
+#define TAS_REG_LEFT_BIQUAD6	0x10
+#define TAS_REG_RIGHT_BIQUAD6	0x19
+
+#endif /* __SND_AOA_CODECTASH */

--
