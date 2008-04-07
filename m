Return-Path: <risto.suominen@gmail.com>
Message-ID: <46e1c7760804070629l3dc08d37vf5f2b120416bc2f7@mail.gmail.com>
Date: Mon, 7 Apr 2008 16:29:22 +0300
From: "Risto Suominen" <risto.suominen@gmail.com>
To: perex@perex.cz
Subject: [PATCH 003/003] snd-powermac: Burgundy mixers for B&W and iMac
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

Add mixer controls and correct headphone detection bits for PowerMac
G3 B&W and iMac G3 Tray-loading, both having Burgundy chipset.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.25-rc8 (probably any 2.6)

--- sound/ppc/burgundy.c.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/burgundy.c	2008-04-07 12:00:20.893307568 +0300
@@ -102,7 +102,8 @@ snd_pmac_burgundy_rcw(struct snd_pmac *c
 }

 static void
-snd_pmac_burgundy_wcb(struct snd_pmac *chip, unsigned int addr,
unsigned int val)
+snd_pmac_burgundy_wcb(struct snd_pmac *chip, unsigned int addr,
+		      unsigned int val)
 {
 	out_le32(&chip->awacs->codec_ctrl, addr + 0x300000 + (val & 0xff));
 	snd_pmac_burgundy_busy_wait(chip);
@@ -126,8 +127,11 @@ snd_pmac_burgundy_rcb(struct snd_pmac *c
 	return val;
 }

+#define BASE2ADDR(base)	((base) << 12)
+#define ADDR2BASE(addr)	((addr) >> 12)
+
 /*
- * Burgundy volume: 0 - 100, stereo
+ * Burgundy volume: 0 - 100, stereo, word reg
  */
 static void
 snd_pmac_burgundy_write_volume(struct snd_pmac *chip, unsigned int address,
@@ -168,13 +172,6 @@ snd_pmac_burgundy_read_volume(struct snd
 		volume[1] = 0;
 }

-
-/*
- */
-
-#define BASE2ADDR(base)	((base) << 12)
-#define ADDR2BASE(addr)	((addr) >> 12)
-
 static int snd_pmac_burgundy_info_volume(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_info *uinfo)
 {
@@ -191,8 +188,8 @@ static int snd_pmac_burgundy_get_volume(
 	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
 	unsigned int addr = BASE2ADDR(kcontrol->private_value & 0xff);
 	int shift = (kcontrol->private_value >> 8) & 0xff;
-	snd_pmac_burgundy_read_volume(chip, addr, ucontrol->value.integer.value,
-				      shift);
+	snd_pmac_burgundy_read_volume(chip, addr,
+				      ucontrol->value.integer.value, shift);
 	return 0;
 }

@@ -204,24 +201,163 @@ static int snd_pmac_burgundy_put_volume(
 	int shift = (kcontrol->private_value >> 8) & 0xff;
 	long nvoices[2];

-	snd_pmac_burgundy_write_volume(chip, addr, ucontrol->value.integer.value,
-				       shift);
+	snd_pmac_burgundy_write_volume(chip, addr,
+				       ucontrol->value.integer.value, shift);
 	snd_pmac_burgundy_read_volume(chip, addr, nvoices, shift);
 	return (nvoices[0] != ucontrol->value.integer.value[0] ||
 		nvoices[1] != ucontrol->value.integer.value[1]);
 }

-#define BURGUNDY_VOLUME(xname, xindex, addr, shift) \
+#define BURGUNDY_VOLUME_W(xname, xindex, addr, shift) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex,\
   .info = snd_pmac_burgundy_info_volume,\
   .get = snd_pmac_burgundy_get_volume,\
   .put = snd_pmac_burgundy_put_volume,\
   .private_value = ((ADDR2BASE(addr) & 0xff) | ((shift) << 8)) }

-/* lineout/speaker */
+/*
+ * Burgundy volume: 0 - 100, stereo, 2-byte reg
+ */
+static void
+snd_pmac_burgundy_write_volume_2b(struct snd_pmac *chip, unsigned int address,
+				  long *volume, int off)
+{
+	int lvolume, rvolume;
+
+	off |= off << 2;
+	lvolume = volume[0] ? volume[0] + BURGUNDY_VOLUME_OFFSET : 0;
+	rvolume = volume[1] ? volume[1] + BURGUNDY_VOLUME_OFFSET : 0;
+
+	snd_pmac_burgundy_wcb(chip, address + off, lvolume);
+	snd_pmac_burgundy_wcb(chip, address + off + 0x500, rvolume);
+}
+
+static void
+snd_pmac_burgundy_read_volume_2b(struct snd_pmac *chip, unsigned int address,
+				 long *volume, int off)
+{
+	volume[0] = snd_pmac_burgundy_rcb(chip, address + off);
+	if (volume[0] >= BURGUNDY_VOLUME_OFFSET)
+		volume[0] -= BURGUNDY_VOLUME_OFFSET;
+	else
+		volume[0] = 0;
+	volume[1] = snd_pmac_burgundy_rcb(chip, address + off + 0x100);
+	if (volume[1] >= BURGUNDY_VOLUME_OFFSET)
+		volume[1] -= BURGUNDY_VOLUME_OFFSET;
+	else
+		volume[1] = 0;
+}
+
+static int snd_pmac_burgundy_info_volume_2b(struct snd_kcontrol *kcontrol,
+					    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 100;
+	return 0;
+}
+
+static int snd_pmac_burgundy_get_volume_2b(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
+	unsigned int addr = BASE2ADDR(kcontrol->private_value & 0xff);
+	int off = kcontrol->private_value & 0x300;
+	snd_pmac_burgundy_read_volume_2b(chip, addr,
+			ucontrol->value.integer.value, off);
+	return 0;
+}
+
+static int snd_pmac_burgundy_put_volume_2b(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
+	unsigned int addr = BASE2ADDR(kcontrol->private_value & 0xff);
+	int off = kcontrol->private_value & 0x300;
+	long nvoices[2];
+
+	snd_pmac_burgundy_write_volume_2b(chip, addr,
+			ucontrol->value.integer.value, off);
+	snd_pmac_burgundy_read_volume_2b(chip, addr, nvoices, off);
+	return (nvoices[0] != ucontrol->value.integer.value[0] ||
+		nvoices[1] != ucontrol->value.integer.value[1]);
+}
+
+#define BURGUNDY_VOLUME_2B(xname, xindex, addr, off) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex,\
+  .info = snd_pmac_burgundy_info_volume_2b,\
+  .get = snd_pmac_burgundy_get_volume_2b,\
+  .put = snd_pmac_burgundy_put_volume_2b,\
+  .private_value = ((ADDR2BASE(addr) & 0xff) | ((off) << 8)) }
+
+/*
+ * Burgundy gain/attenuation: 0 - 15, mono/stereo, byte reg
+ */
+static int snd_pmac_burgundy_info_gain(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	int stereo = (kcontrol->private_value >> 24) & 1;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = stereo + 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 15;
+	return 0;
+}
+
+static int snd_pmac_burgundy_get_gain(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
+	unsigned int addr = BASE2ADDR(kcontrol->private_value & 0xff);
+	int stereo = (kcontrol->private_value >> 24) & 1;
+	int atten = (kcontrol->private_value >> 25) & 1;
+	int oval;
+
+	oval = snd_pmac_burgundy_rcb(chip, addr);
+	if (atten)
+		oval = ~oval & 0xff;
+	ucontrol->value.integer.value[0] = oval & 0xf;
+	if (stereo)
+		ucontrol->value.integer.value[1] = (oval >> 4) & 0xf;
+	return 0;
+}

-static int snd_pmac_burgundy_info_switch_out(struct snd_kcontrol *kcontrol,
-					     struct snd_ctl_elem_info *uinfo)
+static int snd_pmac_burgundy_put_gain(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
+	unsigned int addr = BASE2ADDR(kcontrol->private_value & 0xff);
+	int stereo = (kcontrol->private_value >> 24) & 1;
+	int atten = (kcontrol->private_value >> 25) & 1;
+	int oval, val;
+
+	oval = snd_pmac_burgundy_rcb(chip, addr);
+	if (atten)
+		oval = ~oval & 0xff;
+	val = ucontrol->value.integer.value[0];
+	if (stereo)
+		val |= ucontrol->value.integer.value[1] << 4;
+	else
+		val |= ucontrol->value.integer.value[0] << 4;
+	if (atten)
+		val = ~val & 0xff;
+	snd_pmac_burgundy_wcb(chip, addr, val);
+	return val != oval;
+}
+
+#define BURGUNDY_VOLUME_B(xname, xindex, addr, stereo, atten) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex,\
+  .info = snd_pmac_burgundy_info_gain,\
+  .get = snd_pmac_burgundy_get_gain,\
+  .put = snd_pmac_burgundy_put_gain,\
+  .private_value = (ADDR2BASE(addr) | ((stereo) << 24) | ((atten) << 25)) }
+
+/*
+ * Burgundy switch: 0/1, mono/stereo, word reg
+ */
+static int snd_pmac_burgundy_info_switch_w(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_info *uinfo)
 {
 	int stereo = (kcontrol->private_value >> 24) & 1;
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -231,111 +367,207 @@ static int snd_pmac_burgundy_info_switch
 	return 0;
 }

-static int snd_pmac_burgundy_get_switch_out(struct snd_kcontrol *kcontrol,
-					    struct snd_ctl_elem_value *ucontrol)
+static int snd_pmac_burgundy_get_switch_w(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
-	int lmask = kcontrol->private_value & 0xff;
-	int rmask = (kcontrol->private_value >> 8) & 0xff;
+	unsigned int addr = BASE2ADDR((kcontrol->private_value >> 16) & 0xff);
+	int lmask = 1 << (kcontrol->private_value & 0xff);
+	int rmask = 1 << ((kcontrol->private_value >> 8) & 0xff);
 	int stereo = (kcontrol->private_value >> 24) & 1;
-	int val = snd_pmac_burgundy_rcb(chip, MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES);
+	int val = snd_pmac_burgundy_rcw(chip, addr);
 	ucontrol->value.integer.value[0] = (val & lmask) ? 1 : 0;
 	if (stereo)
 		ucontrol->value.integer.value[1] = (val & rmask) ? 1 : 0;
 	return 0;
 }

-static int snd_pmac_burgundy_put_switch_out(struct snd_kcontrol *kcontrol,
-					    struct snd_ctl_elem_value *ucontrol)
+static int snd_pmac_burgundy_put_switch_w(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
-	int lmask = kcontrol->private_value & 0xff;
-	int rmask = (kcontrol->private_value >> 8) & 0xff;
+	unsigned int addr = BASE2ADDR((kcontrol->private_value >> 16) & 0xff);
+	int lmask = 1 << (kcontrol->private_value & 0xff);
+	int rmask = 1 << ((kcontrol->private_value >> 8) & 0xff);
 	int stereo = (kcontrol->private_value >> 24) & 1;
 	int val, oval;
-	oval = snd_pmac_burgundy_rcb(chip, MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES);
-	val = oval & ~(lmask | rmask);
+	oval = snd_pmac_burgundy_rcw(chip, addr);
+	val = oval & ~(lmask | (stereo ? rmask : 0));
 	if (ucontrol->value.integer.value[0])
 		val |= lmask;
 	if (stereo && ucontrol->value.integer.value[1])
 		val |= rmask;
-	snd_pmac_burgundy_wcb(chip, MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES, val);
+	snd_pmac_burgundy_wcw(chip, addr, val);
 	return val != oval;
 }

-#define BURGUNDY_OUTPUT_SWITCH(xname, xindex, lmask, rmask, stereo) \
+#define BURGUNDY_SWITCH_W(xname, xindex, addr, lbit, rbit, stereo) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex,\
-  .info = snd_pmac_burgundy_info_switch_out,\
-  .get = snd_pmac_burgundy_get_switch_out,\
-  .put = snd_pmac_burgundy_put_switch_out,\
-  .private_value = ((lmask) | ((rmask) << 8) | ((stereo) << 24)) }
-
-/* line/speaker output volume */
-static int snd_pmac_burgundy_info_volume_out(struct snd_kcontrol *kcontrol,
-					     struct snd_ctl_elem_info *uinfo)
+  .info = snd_pmac_burgundy_info_switch_w,\
+  .get = snd_pmac_burgundy_get_switch_w,\
+  .put = snd_pmac_burgundy_put_switch_w,\
+  .private_value = ((lbit) | ((rbit) << 8)\
+		| (ADDR2BASE(addr) << 16) | ((stereo) << 24)) }
+
+/*
+ * Burgundy switch: 0/1, mono/stereo, byte reg, bit mask
+ */
+static int snd_pmac_burgundy_info_switch_b(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_info *uinfo)
 {
 	int stereo = (kcontrol->private_value >> 24) & 1;
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = stereo + 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 15;
+	uinfo->value.integer.max = 1;
 	return 0;
 }

-static int snd_pmac_burgundy_get_volume_out(struct snd_kcontrol *kcontrol,
-					    struct snd_ctl_elem_value *ucontrol)
+static int snd_pmac_burgundy_get_switch_b(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
-	unsigned int addr = BASE2ADDR(kcontrol->private_value & 0xff);
+	unsigned int addr = BASE2ADDR((kcontrol->private_value >> 16) & 0xff);
+	int lmask = kcontrol->private_value & 0xff;
+	int rmask = (kcontrol->private_value >> 8) & 0xff;
 	int stereo = (kcontrol->private_value >> 24) & 1;
-	int oval;
-
-	oval = ~snd_pmac_burgundy_rcb(chip, addr) & 0xff;
-	ucontrol->value.integer.value[0] = oval & 0xf;
+	int val = snd_pmac_burgundy_rcb(chip, addr);
+	ucontrol->value.integer.value[0] = (val & lmask) ? 1 : 0;
 	if (stereo)
-		ucontrol->value.integer.value[1] = (oval >> 4) & 0xf;
+		ucontrol->value.integer.value[1] = (val & rmask) ? 1 : 0;
 	return 0;
 }

-static int snd_pmac_burgundy_put_volume_out(struct snd_kcontrol *kcontrol,
-					    struct snd_ctl_elem_value *ucontrol)
+static int snd_pmac_burgundy_put_switch_b(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
-	unsigned int addr = BASE2ADDR(kcontrol->private_value & 0xff);
+	unsigned int addr = BASE2ADDR((kcontrol->private_value >> 16) & 0xff);
+	int lmask = kcontrol->private_value & 0xff;
+	int rmask = (kcontrol->private_value >> 8) & 0xff;
 	int stereo = (kcontrol->private_value >> 24) & 1;
-	unsigned int oval, val;
-
-	oval = ~snd_pmac_burgundy_rcb(chip, addr) & 0xff;
-	val = ucontrol->value.integer.value[0] & 15;
-	if (stereo)
-		val |= (ucontrol->value.integer.value[1] & 15) << 4;
-	else
-		val |= val << 4;
-	val = ~val & 0xff;
+	int val, oval;
+	oval = snd_pmac_burgundy_rcb(chip, addr);
+	val = oval & ~(lmask | rmask);
+	if (ucontrol->value.integer.value[0])
+		val |= lmask;
+	if (stereo && ucontrol->value.integer.value[1])
+		val |= rmask;
 	snd_pmac_burgundy_wcb(chip, addr, val);
 	return val != oval;
 }

-#define BURGUNDY_OUTPUT_VOLUME(xname, xindex, addr, stereo) \
+#define BURGUNDY_SWITCH_B(xname, xindex, addr, lmask, rmask, stereo) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex,\
-  .info = snd_pmac_burgundy_info_volume_out,\
-  .get = snd_pmac_burgundy_get_volume_out,\
-  .put = snd_pmac_burgundy_put_volume_out,\
-  .private_value = (ADDR2BASE(addr) | ((stereo) << 24)) }
+  .info = snd_pmac_burgundy_info_switch_b,\
+  .get = snd_pmac_burgundy_get_switch_b,\
+  .put = snd_pmac_burgundy_put_switch_b,\
+  .private_value = ((lmask) | ((rmask) << 8)\
+		| (ADDR2BASE(addr) << 16) | ((stereo) << 24)) }

+/*
+ * Burgundy mixers
+ */
 static struct snd_kcontrol_new snd_pmac_burgundy_mixers[] __initdata = {
-	BURGUNDY_VOLUME("Master Playback Volume", 0,
MASK_ADDR_BURGUNDY_MASTER_VOLUME, 8),
-	BURGUNDY_VOLUME("Line Playback Volume", 0, MASK_ADDR_BURGUNDY_VOLLINE, 16),
-	BURGUNDY_VOLUME("CD Playback Volume", 0, MASK_ADDR_BURGUNDY_VOLCD, 16),
-	BURGUNDY_VOLUME("Mic Playback Volume", 0, MASK_ADDR_BURGUNDY_VOLMIC, 16),
-	BURGUNDY_OUTPUT_VOLUME("PC Speaker Playback Volume", 0,
MASK_ADDR_BURGUNDY_ATTENHP, 0),
-	/*BURGUNDY_OUTPUT_VOLUME("PCM Playback Volume", 0,
MASK_ADDR_BURGUNDY_ATTENLINEOUT, 1),*/
-	BURGUNDY_OUTPUT_VOLUME("Headphone Playback Volume", 0,
MASK_ADDR_BURGUNDY_ATTENSPEAKER, 1),
-};	
-static struct snd_kcontrol_new snd_pmac_burgundy_master_sw __initdata =
-BURGUNDY_OUTPUT_SWITCH("Headphone Playback Switch", 0,
BURGUNDY_OUTPUT_LEFT, BURGUNDY_OUTPUT_RIGHT, 1);
-static struct snd_kcontrol_new snd_pmac_burgundy_speaker_sw __initdata =
-BURGUNDY_OUTPUT_SWITCH("PC Speaker Playback Switch", 0,
BURGUNDY_OUTPUT_INTERN, 0, 0);
+	BURGUNDY_VOLUME_W("Master Playback Volume", 0,
+			MASK_ADDR_BURGUNDY_MASTER_VOLUME, 8),
+	BURGUNDY_VOLUME_W("CD Capture Volume", 0,
+			MASK_ADDR_BURGUNDY_VOLCD, 16),
+	BURGUNDY_VOLUME_2B("Input Capture Volume", 0,
+			MASK_ADDR_BURGUNDY_VOLMIX01, 2),
+	BURGUNDY_VOLUME_2B("Mixer Playback Volume", 0,
+			MASK_ADDR_BURGUNDY_VOLMIX23, 0),
+	BURGUNDY_VOLUME_B("CD Gain Capture Volume", 0,
+			MASK_ADDR_BURGUNDY_GAINCD, 1, 0),
+	BURGUNDY_SWITCH_W("Master Capture Switch", 0,
+			MASK_ADDR_BURGUNDY_OUTPUTENABLES, 24, 0, 0),
+	BURGUNDY_SWITCH_W("CD Capture Switch", 0,
+			MASK_ADDR_BURGUNDY_CAPTURESELECTS, 0, 16, 1),
+	BURGUNDY_SWITCH_W("CD Playback Switch", 0,
+			MASK_ADDR_BURGUNDY_OUTPUTSELECTS, 0, 16, 1),
+/*	BURGUNDY_SWITCH_W("Loop Capture Switch", 0,
+ *		MASK_ADDR_BURGUNDY_CAPTURESELECTS, 8, 24, 1),
+ *	BURGUNDY_SWITCH_B("Mixer out Capture Switch", 0,
+ *		MASK_ADDR_BURGUNDY_HOSTIFAD, 0x02, 0, 0),
+ *	BURGUNDY_SWITCH_B("Mixer Capture Switch", 0,
+ *		MASK_ADDR_BURGUNDY_HOSTIFAD, 0x01, 0, 0),
+ *	BURGUNDY_SWITCH_B("PCM out Capture Switch", 0,
+ *		MASK_ADDR_BURGUNDY_HOSTIFEH, 0x02, 0, 0),
+ */	BURGUNDY_SWITCH_B("PCM Capture Switch", 0,
+			MASK_ADDR_BURGUNDY_HOSTIFEH, 0x01, 0, 0)
+};
+static struct snd_kcontrol_new snd_pmac_burgundy_mixers_imac[] __initdata = {
+	BURGUNDY_VOLUME_W("Line in Capture Volume", 0,
+			MASK_ADDR_BURGUNDY_VOLLINE, 16),
+	BURGUNDY_VOLUME_W("Mic Capture Volume", 0,
+			MASK_ADDR_BURGUNDY_VOLMIC, 16),
+	BURGUNDY_VOLUME_B("Line in Gain Capture Volume", 0,
+			MASK_ADDR_BURGUNDY_GAINLINE, 1, 0),
+	BURGUNDY_VOLUME_B("Mic Gain Capture Volume", 0,
+			MASK_ADDR_BURGUNDY_GAINMIC, 1, 0),
+	BURGUNDY_VOLUME_B("PC Speaker Playback Volume", 0,
+			MASK_ADDR_BURGUNDY_ATTENSPEAKER, 1, 1),
+	BURGUNDY_VOLUME_B("Line out Playback Volume", 0,
+			MASK_ADDR_BURGUNDY_ATTENLINEOUT, 1, 1),
+	BURGUNDY_VOLUME_B("Headphone Playback Volume", 0,
+			MASK_ADDR_BURGUNDY_ATTENHP, 1, 1),
+	BURGUNDY_SWITCH_W("Line in Capture Switch", 0,
+			MASK_ADDR_BURGUNDY_CAPTURESELECTS, 1, 17, 1),
+	BURGUNDY_SWITCH_W("Mic Capture Switch", 0,
+			MASK_ADDR_BURGUNDY_CAPTURESELECTS, 2, 18, 1),
+	BURGUNDY_SWITCH_W("Line in Playback Switch", 0,
+			MASK_ADDR_BURGUNDY_OUTPUTSELECTS, 1, 17, 1),
+	BURGUNDY_SWITCH_W("Mic Playback Switch", 0,
+			MASK_ADDR_BURGUNDY_OUTPUTSELECTS, 2, 18, 1),
+	BURGUNDY_SWITCH_B("Mic Boost Capture Switch", 0,
+			MASK_ADDR_BURGUNDY_INPBOOST, 0x40, 0x80, 1)
+};
+static struct snd_kcontrol_new snd_pmac_burgundy_mixers_pmac[] __initdata = {
+	BURGUNDY_VOLUME_W("Line in Capture Volume", 0,
+			MASK_ADDR_BURGUNDY_VOLMIC, 16),
+	BURGUNDY_VOLUME_B("Line in Gain Capture Volume", 0,
+			MASK_ADDR_BURGUNDY_GAINMIC, 1, 0),
+	BURGUNDY_VOLUME_B("PC Speaker Playback Volume", 0,
+			MASK_ADDR_BURGUNDY_ATTENMONO, 0, 1),
+	BURGUNDY_VOLUME_B("Line out Playback Volume", 0,
+			MASK_ADDR_BURGUNDY_ATTENSPEAKER, 1, 1),
+	BURGUNDY_SWITCH_W("Line in Capture Switch", 0,
+			MASK_ADDR_BURGUNDY_CAPTURESELECTS, 2, 18, 1),
+	BURGUNDY_SWITCH_W("Line in Playback Switch", 0,
+			MASK_ADDR_BURGUNDY_OUTPUTSELECTS, 2, 18, 1),
+/*	BURGUNDY_SWITCH_B("Line in Boost Capture Switch", 0,
+ *		MASK_ADDR_BURGUNDY_INPBOOST, 0x40, 0x80, 1) */
+};
+static struct snd_kcontrol_new snd_pmac_burgundy_master_sw_imac __initdata =
+BURGUNDY_SWITCH_B("Master Playback Switch", 0,
+	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
+	BURGUNDY_OUTPUT_LEFT | BURGUNDY_LINEOUT_LEFT | BURGUNDY_HP_LEFT,
+	BURGUNDY_OUTPUT_RIGHT | BURGUNDY_LINEOUT_RIGHT | BURGUNDY_HP_RIGHT, 1);
+static struct snd_kcontrol_new snd_pmac_burgundy_master_sw_pmac __initdata =
+BURGUNDY_SWITCH_B("Master Playback Switch", 0,
+	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
+	BURGUNDY_OUTPUT_INTERN
+	| BURGUNDY_OUTPUT_LEFT, BURGUNDY_OUTPUT_RIGHT, 1);
+static struct snd_kcontrol_new snd_pmac_burgundy_speaker_sw_imac __initdata =
+BURGUNDY_SWITCH_B("PC Speaker Playback Switch", 0,
+	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
+	BURGUNDY_OUTPUT_LEFT, BURGUNDY_OUTPUT_RIGHT, 1);
+static struct snd_kcontrol_new snd_pmac_burgundy_speaker_sw_pmac __initdata =
+BURGUNDY_SWITCH_B("PC Speaker Playback Switch", 0,
+	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
+	BURGUNDY_OUTPUT_INTERN, 0, 0);
+static struct snd_kcontrol_new snd_pmac_burgundy_line_sw_imac __initdata =
+BURGUNDY_SWITCH_B("Line out Playback Switch", 0,
+	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
+	BURGUNDY_LINEOUT_LEFT, BURGUNDY_LINEOUT_RIGHT, 1);
+static struct snd_kcontrol_new snd_pmac_burgundy_line_sw_pmac __initdata =
+BURGUNDY_SWITCH_B("Line out Playback Switch", 0,
+	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
+	BURGUNDY_OUTPUT_LEFT, BURGUNDY_OUTPUT_RIGHT, 1);
+static struct snd_kcontrol_new snd_pmac_burgundy_hp_sw_imac __initdata =
+BURGUNDY_SWITCH_B("Headphone Playback Switch", 0,
+	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
+	BURGUNDY_HP_LEFT, BURGUNDY_HP_RIGHT, 1);


 #ifdef PMAC_SUPPORT_AUTOMUTE
@@ -347,19 +579,30 @@ static int snd_pmac_burgundy_detect_head
 	return (in_le32(&chip->awacs->codec_stat) & chip->hp_stat_mask) ? 1 : 0;
 }

-static void snd_pmac_burgundy_update_automute(struct snd_pmac *chip,
int do_notify)
+static void snd_pmac_burgundy_update_automute(struct snd_pmac *chip,
+					      int do_notify)
 {
 	if (chip->auto_mute) {
+		int imac = machine_is_compatible("iMac");
 		int reg, oreg;
-		reg = oreg = snd_pmac_burgundy_rcb(chip,
MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES);
-		reg &= ~(BURGUNDY_OUTPUT_LEFT | BURGUNDY_OUTPUT_RIGHT |
BURGUNDY_OUTPUT_INTERN);
+		reg = oreg = snd_pmac_burgundy_rcb(chip,
+				MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES);
+		reg &= imac ? ~(BURGUNDY_OUTPUT_LEFT | BURGUNDY_OUTPUT_RIGHT
+				| BURGUNDY_HP_LEFT | BURGUNDY_HP_RIGHT)
+			: ~(BURGUNDY_OUTPUT_LEFT | BURGUNDY_OUTPUT_RIGHT
+				| BURGUNDY_OUTPUT_INTERN);
 		if (snd_pmac_burgundy_detect_headphone(chip))
-			reg |= BURGUNDY_OUTPUT_LEFT | BURGUNDY_OUTPUT_RIGHT;
+			reg |= imac ? (BURGUNDY_HP_LEFT | BURGUNDY_HP_RIGHT)
+				: (BURGUNDY_OUTPUT_LEFT
+					| BURGUNDY_OUTPUT_RIGHT);
 		else
-			reg |= BURGUNDY_OUTPUT_INTERN;
+			reg |= imac ? (BURGUNDY_OUTPUT_LEFT
+					| BURGUNDY_OUTPUT_RIGHT)
+				: (BURGUNDY_OUTPUT_INTERN);
 		if (do_notify && reg == oreg)
 			return;
-		snd_pmac_burgundy_wcb(chip, MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES, reg);
+		snd_pmac_burgundy_wcb(chip,
+				MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES, reg);
 		if (do_notify) {
 			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 				       &chip->master_sw_ctl->id);
@@ -378,6 +621,7 @@ static void snd_pmac_burgundy_update_aut
  */
 int __init snd_pmac_burgundy_init(struct snd_pmac *chip)
 {
+	int imac = machine_is_compatible("iMac");
 	int i, err;

 	/* Checks to see the chip is alive and kicking */
@@ -386,7 +630,7 @@ int __init snd_pmac_burgundy_init(struct
 		return 1;
 	}

-	snd_pmac_burgundy_wcb(chip, MASK_ADDR_BURGUNDY_OUTPUTENABLES,
+	snd_pmac_burgundy_wcw(chip, MASK_ADDR_BURGUNDY_OUTPUTENABLES,
 			   DEF_BURGUNDY_OUTPUTENABLES);
 	snd_pmac_burgundy_wcb(chip, MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
 			   DEF_BURGUNDY_MORE_OUTPUTENABLES);
@@ -396,7 +640,8 @@ int __init snd_pmac_burgundy_init(struct
 	snd_pmac_burgundy_wcb(chip, MASK_ADDR_BURGUNDY_INPSEL21,
 			   DEF_BURGUNDY_INPSEL21);
 	snd_pmac_burgundy_wcb(chip, MASK_ADDR_BURGUNDY_INPSEL3,
-			   DEF_BURGUNDY_INPSEL3);
+			   imac ? DEF_BURGUNDY_INPSEL3_IMAC
+			   : DEF_BURGUNDY_INPSEL3_PMAC);
 	snd_pmac_burgundy_wcb(chip, MASK_ADDR_BURGUNDY_GAINCD,
 			   DEF_BURGUNDY_GAINCD);
 	snd_pmac_burgundy_wcb(chip, MASK_ADDR_BURGUNDY_GAINLINE,
@@ -422,23 +667,51 @@ int __init snd_pmac_burgundy_init(struct
 	snd_pmac_burgundy_wcw(chip, MASK_ADDR_BURGUNDY_VOLMIC,
 			   DEF_BURGUNDY_VOLMIC);

-	if (chip->hp_stat_mask == 0)
+	if (chip->hp_stat_mask == 0) {
 		/* set headphone-jack detection bit */
-		chip->hp_stat_mask = 0x04;
-
+		if (imac)
+			chip->hp_stat_mask = BURGUNDY_HPDETECT_IMAC_UPPER
+				| BURGUNDY_HPDETECT_IMAC_LOWER
+				| BURGUNDY_HPDETECT_IMAC_SIDE;
+		else
+			chip->hp_stat_mask = BURGUNDY_HPDETECT_PMAC_BACK;
+	}
 	/*
 	 * build burgundy mixers
 	 */
 	strcpy(chip->card->mixername, "PowerMac Burgundy");

 	for (i = 0; i < ARRAY_SIZE(snd_pmac_burgundy_mixers); i++) {
-		if ((err = snd_ctl_add(chip->card,
snd_ctl_new1(&snd_pmac_burgundy_mixers[i], chip))) < 0)
+		if ((err = snd_ctl_add(chip->card,
+		    snd_ctl_new1(&snd_pmac_burgundy_mixers[i], chip))) < 0)
+			return err;
+	}
+	for (i = 0; i < (imac ? ARRAY_SIZE(snd_pmac_burgundy_mixers_imac)
+			: ARRAY_SIZE(snd_pmac_burgundy_mixers_pmac)); i++) {
+		if ((err = snd_ctl_add(chip->card,
+		    snd_ctl_new1(imac ? &snd_pmac_burgundy_mixers_imac[i]
+		    : &snd_pmac_burgundy_mixers_pmac[i], chip))) < 0)
 			return err;
 	}
-	chip->master_sw_ctl = snd_ctl_new1(&snd_pmac_burgundy_master_sw, chip);
+	chip->master_sw_ctl = snd_ctl_new1(imac
+			? &snd_pmac_burgundy_master_sw_imac
+			: &snd_pmac_burgundy_master_sw_pmac, chip);
 	if ((err = snd_ctl_add(chip->card, chip->master_sw_ctl)) < 0)
 		return err;
-	chip->speaker_sw_ctl = snd_ctl_new1(&snd_pmac_burgundy_speaker_sw, chip);
+	chip->master_sw_ctl = snd_ctl_new1(imac
+			? &snd_pmac_burgundy_line_sw_imac
+			: &snd_pmac_burgundy_line_sw_pmac, chip);
+	if ((err = snd_ctl_add(chip->card, chip->master_sw_ctl)) < 0)
+		return err;
+	if (imac) {
+		chip->master_sw_ctl = snd_ctl_new1(
+				&snd_pmac_burgundy_hp_sw_imac, chip);
+		if ((err = snd_ctl_add(chip->card, chip->master_sw_ctl)) < 0)
+			return err;
+	}
+	chip->speaker_sw_ctl = snd_ctl_new1(imac
+			? &snd_pmac_burgundy_speaker_sw_imac
+			: &snd_pmac_burgundy_speaker_sw_pmac, chip);
 	if ((err = snd_ctl_add(chip->card, chip->speaker_sw_ctl)) < 0)
 		return err;
 #ifdef PMAC_SUPPORT_AUTOMUTE
--- sound/ppc/burgundy.h.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/burgundy.h	2008-04-05 22:02:44.000000000 +0300
@@ -22,6 +22,7 @@
 #ifndef __BURGUNDY_H
 #define __BURGUNDY_H

+#define MASK_ADDR_BURGUNDY_INPBOOST (0x10 << 12)
 #define MASK_ADDR_BURGUNDY_INPSEL21 (0x11 << 12)
 #define MASK_ADDR_BURGUNDY_INPSEL3 (0x12 << 12)

@@ -35,7 +36,10 @@
 #define MASK_ADDR_BURGUNDY_VOLCH3 (0x22 << 12)
 #define MASK_ADDR_BURGUNDY_VOLCH4 (0x23 << 12)

+#define MASK_ADDR_BURGUNDY_CAPTURESELECTS (0x2A << 12)
 #define MASK_ADDR_BURGUNDY_OUTPUTSELECTS (0x2B << 12)
+#define MASK_ADDR_BURGUNDY_VOLMIX01 (0x2D << 12)
+#define MASK_ADDR_BURGUNDY_VOLMIX23 (0x2E << 12)
 #define MASK_ADDR_BURGUNDY_OUTPUTENABLES (0x2F << 12)

 #define MASK_ADDR_BURGUNDY_MASTER_VOLUME (0x30 << 12)
@@ -45,6 +49,10 @@
 #define MASK_ADDR_BURGUNDY_ATTENSPEAKER (0x62 << 12)
 #define MASK_ADDR_BURGUNDY_ATTENLINEOUT (0x63 << 12)
 #define MASK_ADDR_BURGUNDY_ATTENHP (0x64 << 12)
+#define MASK_ADDR_BURGUNDY_ATTENMONO (0x65 << 12)
+
+#define MASK_ADDR_BURGUNDY_HOSTIFAD (0x78 << 12)
+#define MASK_ADDR_BURGUNDY_HOSTIFEH (0x79 << 12)

 #define MASK_ADDR_BURGUNDY_VOLCD (MASK_ADDR_BURGUNDY_VOLCH1)
 #define MASK_ADDR_BURGUNDY_VOLLINE (MASK_ADDR_BURGUNDY_VOLCH2)
@@ -59,21 +67,22 @@

 /* These are all default values for the burgundy */
 #define DEF_BURGUNDY_INPSEL21 (0xAA)
-#define DEF_BURGUNDY_INPSEL3 (0x0A)
+#define DEF_BURGUNDY_INPSEL3_IMAC (0x0A)
+#define DEF_BURGUNDY_INPSEL3_PMAC (0x05)

 #define DEF_BURGUNDY_GAINCD (0x33)
 #define DEF_BURGUNDY_GAINLINE (0x44)
 #define DEF_BURGUNDY_GAINMIC (0x44)
 #define DEF_BURGUNDY_GAINMODEM (0x06)

-/* Remember: lowest volume here is 0x9b */
+/* Remember: lowest volume here is 0x9B (155) */
 #define DEF_BURGUNDY_VOLCD (0xCCCCCCCC)
 #define DEF_BURGUNDY_VOLLINE (0x00000000)
 #define DEF_BURGUNDY_VOLMIC (0x00000000)
 #define DEF_BURGUNDY_VOLMODEM (0xCCCCCCCC)

-#define DEF_BURGUNDY_OUTPUTSELECTS (0x010f010f)
-#define DEF_BURGUNDY_OUTPUTENABLES (0x0A)
+#define DEF_BURGUNDY_OUTPUTSELECTS (0x010F010F)
+#define DEF_BURGUNDY_OUTPUTENABLES (0x0100000A)

 /* #define DEF_BURGUNDY_MASTER_VOLUME (0xFFFFFFFF) */ /* too loud */
 #define DEF_BURGUNDY_MASTER_VOLUME (0xDDDDDDDD)
@@ -84,12 +93,22 @@
 #define DEF_BURGUNDY_ATTENLINEOUT (0xCC)
 #define DEF_BURGUNDY_ATTENHP (0xCC)

-/* OUTPUTENABLES bits */
+/* MORE_OUTPUTENABLES bits */
 #define BURGUNDY_OUTPUT_LEFT	0x02
 #define BURGUNDY_OUTPUT_RIGHT	0x04
+#define BURGUNDY_LINEOUT_LEFT	0x08
+#define BURGUNDY_LINEOUT_RIGHT	0x10
+#define BURGUNDY_HP_LEFT	0x20
+#define BURGUNDY_HP_RIGHT	0x40
 #define BURGUNDY_OUTPUT_INTERN	0x80

-/* volume offset */
+/* Headphone detection bits */
+#define BURGUNDY_HPDETECT_PMAC_BACK	0x04
+#define BURGUNDY_HPDETECT_IMAC_SIDE	0x04
+#define BURGUNDY_HPDETECT_IMAC_UPPER	0x08
+#define BURGUNDY_HPDETECT_IMAC_LOWER	0x01
+
+/* Volume offset */
 #define BURGUNDY_VOLUME_OFFSET	155

 #endif /* __BURGUNDY_H */
