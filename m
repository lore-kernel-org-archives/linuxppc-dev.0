Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C78BC67B79
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 23:11:26 +1000 (EST)
Message-Id: <20060607130914.735290000@sipsolutions.net>
References: <20060607130909.584205000@sipsolutions.net>
Date: Wed, 07 Jun 2006 15:09:16 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 07/12] snd-aoa: add tas codec
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the tas3004 codec Apple uses in most
newer machines without digital audio, and in some with digital
audio (those are tas/topaz machines).

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
--- /dev/null
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -0,0 +1,653 @@
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
+#include "../aoa.h"
+#include "../soundbus/soundbus.h"
+
+
+#define PFX "snd-aoa-codec-tas: "
+
+struct tas {
+	struct aoa_codec	codec;
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
+	return container_of(codec, struct tas, codec);
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
+	if (tas->cached_volume_l == ucontrol->value.integer.value[0]
+	 && tas->cached_volume_r == ucontrol->value.integer.value[1])
+		return 0;
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
+	if (tas->muted_l == !ucontrol->value.integer.value[0]
+	 && tas->muted_r == !ucontrol->value.integer.value[1])
+		return 0;
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
+	if (tas->mixer_l[idx] == ucontrol->value.integer.value[0]
+	 && tas->mixer_r[idx] == ucontrol->value.integer.value[1])
+		return 0;
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
+MIXER_CONTROL(monitor, "Monitor", 2);
+
+static int tas_snd_capture_source_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = { "Line-In", "Microphone" };
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
+	int oldacr = tas->acr;
+
+	tas->acr &= ~TAS_ACR_INPUT_B;
+	if (ucontrol->value.enumerated.item[0])
+		tas->acr |= TAS_ACR_INPUT_B;
+	if (oldacr == tas->acr)
+		return 0;
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
+	int err;
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
+	err = aoa_snd_ctl_add(snd_ctl_new1(&volume_control, tas));
+	if (err)
+		goto error;
+
+	err = aoa_snd_ctl_add(snd_ctl_new1(&mute_control, tas));
+	if (err)
+		goto error;
+
+	err = aoa_snd_ctl_add(snd_ctl_new1(&pcm1_control, tas));
+	if (err)
+		goto error;
+
+	err = aoa_snd_ctl_add(snd_ctl_new1(&monitor_control, tas));
+	if (err)
+		goto error;
+
+	err = aoa_snd_ctl_add(snd_ctl_new1(&capture_source_control, tas));
+	if (err)
+		goto error;
+
+	return 0;
+ error:
+	tas->codec.soundbus_dev->detach_codec(tas->codec.soundbus_dev, tas);
+	snd_device_free(aoa_get_card(), tas);
+	return err;
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
+	tas->i2c.driver = &tas_driver;
+	tas->i2c.adapter = adapter;
+	tas->i2c.addr = addr;
+	strlcpy(tas->i2c.name, "tas audio codec", I2C_NAME_SIZE-1);
+
+	if (i2c_attach_client(&tas->i2c)) {
+		printk(KERN_ERR PFX "failed to attach to i2c\n");
+		goto fail;
+	}
+
+	strlcpy(tas->codec.name, "tas", MAX_CODEC_NAME_LEN-1);
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
+				continue;
+			return tas_create(adapter, dev, ((*addr) >> 1) & 0x7f);
+		}
+		/* older machines have no 'codec' node with a 'compatible'
+		 * property that says 'tas3004', they just have a 'deq'
+		 * node without any such property... */
+		if (strcmp(dev->name, "deq") == 0) {
+			u32 *addr;
+			printk(KERN_DEBUG PFX "found 'deq' node\n");
+			addr = (u32 *) get_property(dev, "i2c-address", NULL);
+			if (!addr)
+				continue;
+			/* now, if the address doesn't match any of the two
+			 * that a tas3004 can have, we cannot handle this.
+			 * I doubt it ever happens but hey. */
+			if (*addr != 0x34 && *addr != 0x35)
+				continue;
+			return tas_create(adapter, dev, ((*addr) >> 1) & 0x7f);
+		}
+	}
+	return -ENODEV;
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

--
