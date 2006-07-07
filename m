Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8CAF679FD
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 17:47:25 +1000 (EST)
Subject: snd-aoa: g5 tas codec problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 17:47:05 +1000
Message-Id: <1152258426.9862.44.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, so now I have it working on the G5 :)

(Patch below)

There are several issues (I would say in addition to what I listed
earlier):

 - Maybe it's me or maybe it's just too complicated, but I haven't quite
grasped the whole interaction between the soundbus,i2sbus,fabric and
codecs... especially initialisation ordering. It would be nice if we
could spend some time going through that and simplifying :) It leads to
at least one of the problems

 - The patch fixes a couple of nits related to having the modules
built-in: soundbus must really be a subsys_initcall() so it's
initialized before anybody else, and I've put the soundbus/ dir before
the codecs in the link order because the TAS is unhappy if loaded before
i2s (see below)

 - The TAS is a nasty beast. It needs the i2s clocks enabled or it goes
bunk... That's the problem with the G5. I've added a clock notifier and
reset it completely when the clocks come back, that's what fixes the G5
sound (looks like it loses state somewhat when not clocked). It would be
nice to streamline/cleanup some of the TAS handling, maybe with register
shadows like darwin or just with proper state variables to re-consitute
the whole thing and have a "fast mode" load since we need to do it so
often

 - Because of the above, starting to play a sound 1- takes some time to
init things and 2- clacks (setting the mutes on TAS before losing clocks
isn't enough, I think the fact that it goes bonk makes it parasite the
analog outputs). We need to also mute the amps around that. I haven't
quite figured how to do that from i2sbus though :) Also, we should try
(if not already the case) to cache our clock/i2s state so that
subsequent prepare() don't try to change things that are already ok.
That way we avoid having to blast the codec each time. But right now,
the important thing is to add mutes. People with external amplifiers
will really not like those clacs...

Note that the patch applies on top of Andreas latest one fixing the irq
on latest git.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/sound/aoa/soundbus/core.c
===================================================================
--- linux-irq-work.orig/sound/aoa/soundbus/core.c	2006-06-23 13:22:14.000000000 +1000
+++ linux-irq-work/sound/aoa/soundbus/core.c	2006-07-07 15:58:25.000000000 +1000
@@ -246,5 +246,5 @@
 }
 EXPORT_SYMBOL_GPL(soundbus_unregister_driver);
 
-module_init(soundbus_init);
+subsys_initcall(soundbus_init);
 module_exit(soundbus_exit);
Index: linux-irq-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/powermac/feature.c	2006-07-01 13:51:11.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/powermac/feature.c	2006-07-07 16:13:20.000000000 +1000
@@ -2394,6 +2394,7 @@
 
 	return func(node, param, value);
 }
+EXPORT_SYMBOL_GPL(pmac_do_feature_call);
 
 static int __init probe_motherboard(void)
 {
Index: linux-irq-work/sound/aoa/Makefile
===================================================================
--- linux-irq-work.orig/sound/aoa/Makefile	2006-06-23 13:22:14.000000000 +1000
+++ linux-irq-work/sound/aoa/Makefile	2006-07-07 16:11:35.000000000 +1000
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SND_AOA) += core/
-obj-$(CONFIG_SND_AOA) += codecs/
-obj-$(CONFIG_SND_AOA) += fabrics/
 obj-$(CONFIG_SND_AOA_SOUNDBUS) += soundbus/
+obj-$(CONFIG_SND_AOA) += fabrics/
+obj-$(CONFIG_SND_AOA) += codecs/
Index: linux-irq-work/sound/aoa/codecs/snd-aoa-codec-tas.c
===================================================================
--- linux-irq-work.orig/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 15:46:30.000000000 +1000
+++ linux-irq-work/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 17:45:06.000000000 +1000
@@ -75,19 +75,25 @@
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
+				save_mute_l:1, save_mute_r:1,
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
@@ -101,6 +107,28 @@
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
@@ -113,8 +141,8 @@
 	if (left > 177) left = 177;
 	if (right > 177) right = 177;
 
-	if (tas->muted_l) left = 0;
-	if (tas->muted_r) right = 0;
+	if (tas->mute_l) left = 0;
+	if (tas->mute_r) right = 0;
 
 	/* analysing the volume and mixer tables shows
 	 * that they are similar enough when we shift
@@ -202,7 +230,8 @@
 
 	tas->cached_volume_l = ucontrol->value.integer.value[0];
 	tas->cached_volume_r = ucontrol->value.integer.value[1];
-	tas_set_volume(tas);
+	if (tas->hw_enabled)
+		tas_set_volume(tas);
 	return 1;
 }
 
@@ -230,8 +259,8 @@
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.integer.value[0] = !tas->muted_l;
-	ucontrol->value.integer.value[1] = !tas->muted_r;
+	ucontrol->value.integer.value[0] = !tas->mute_l;
+	ucontrol->value.integer.value[1] = !tas->mute_r;
 	return 0;
 }
 
@@ -240,13 +269,14 @@
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
 
@@ -294,7 +324,8 @@
 	tas->mixer_l[idx] = ucontrol->value.integer.value[0];
 	tas->mixer_r[idx] = ucontrol->value.integer.value[1];
 
-	tas_set_mixer(tas);
+	if (tas->hw_enabled)
+		tas_set_mixer(tas);
 	return 1;
 }
 
@@ -310,7 +341,6 @@
 }
 
 MIXER_CONTROL(pcm1, "PCM1", 0);
-MIXER_CONTROL(pcm2, "PCM2", 1);
 MIXER_CONTROL(monitor, "Monitor", 2);
 
 static int tas_snd_capture_source_info(struct snd_kcontrol *kcontrol,
@@ -347,7 +377,8 @@
 		tas->acr |= TAS_ACR_INPUT_B;
 	if (oldacr == tas->acr)
 		return 0;
-	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	if (tas->hw_enabled)
+		tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
 	return 1;
 }
 
@@ -400,26 +431,68 @@
 static int tas_reset_init(struct tas *tas)
 {
 	u8 tmp;
+
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
+		tas->save_mute_l = tas->mute_l;
+		tas->save_mute_r = tas->mute_r;
+		tas->mute_l = tas->mute_l = 1;
+		tas_set_volume(tas);
+		tas->hw_enabled = 0;
+		break;
+	case CLOCK_SWITCH_SLAVE:
+		/* Clocks are back, re-init the codec */
+		tas->mute_l = tas->save_mute_l;
+		tas->mute_r = tas->save_mute_r;
+		tas_reset_init(tas);
+		tas_set_volume(tas);
+		tas_set_mixer(tas);
+		tas->hw_enabled = 1;
+		break;
+	default:
+		/* Do we want to return an error here ? */
+		return 0;
+	}
 	return 0;
 }
 
@@ -428,6 +501,7 @@
  * our i2c device is suspended, and then take note of that! */
 static int tas_suspend(struct tas *tas)
 {
+	tas->hw_enabled = 0;
 	tas->acr |= TAS_ACR_ANALOG_PDOWN;
 	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
 	return 0;
@@ -439,6 +513,7 @@
 	tas_reset_init(tas);
 	tas_set_volume(tas);
 	tas_set_mixer(tas);
+	tas->hw_enabled = 1;
 	return 0;
 }
 
@@ -464,6 +539,7 @@
 	.bus_factor = 64,
 	.owner = THIS_MODULE,
 	.usable = tas_usable,
+	.switch_clock = tas_switch_clock,
 #ifdef CONFIG_PM
 	.suspend = _tas_suspend,
 	.resume = _tas_resume,
@@ -480,11 +556,6 @@
 		return -EINVAL;
 	}
 
-	if (tas_reset_init(tas)) {
-		printk(KERN_ERR PFX "tas failed to initialise\n");
-		return -ENXIO;
-	}
-
 	if (tas->codec.soundbus_dev->attach_codec(tas->codec.soundbus_dev,
 						   aoa_get_card(),
 						   &tas_codec_info, tas)) {
@@ -508,10 +579,6 @@
 	if (err)
 		goto error;
 
-	err = aoa_snd_ctl_add(snd_ctl_new1(&pcm2_control, tas));
-	if (err)
-		goto error;
-
 	err = aoa_snd_ctl_add(snd_ctl_new1(&monitor_control, tas));
 	if (err)
 		goto error;
@@ -553,6 +620,7 @@
 	tas->i2c.driver = &tas_driver;
 	tas->i2c.adapter = adapter;
 	tas->i2c.addr = addr;
+	tas->drc_range = TAS3004_DRC_MAX;
 	strlcpy(tas->i2c.name, "tas audio codec", I2C_NAME_SIZE-1);
 
 	if (i2c_attach_client(&tas->i2c)) {
@@ -569,7 +637,9 @@
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
@@ -657,3 +727,5 @@
 
 module_init(tas_init);
 module_exit(tas_exit);
+
+
Index: linux-irq-work/sound/aoa/codecs/snd-aoa-codec-tas.h
===================================================================
--- linux-irq-work.orig/sound/aoa/codecs/snd-aoa-codec-tas.h	2006-06-23 13:22:14.000000000 +1000
+++ linux-irq-work/sound/aoa/codecs/snd-aoa-codec-tas.h	2006-07-07 16:58:17.000000000 +1000
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
Index: linux-irq-work/sound/aoa/core/snd-aoa-gpio-pmf.c
===================================================================
--- linux-irq-work.orig/sound/aoa/core/snd-aoa-gpio-pmf.c	2006-06-23 13:22:14.000000000 +1000
+++ linux-irq-work/sound/aoa/core/snd-aoa-gpio-pmf.c	2006-07-07 16:10:25.000000000 +1000
@@ -14,9 +14,13 @@
 static void pmf_gpio_set_##name(struct gpio_runtime *rt, int on)\
 {								\
 	struct pmf_args args = { .count = 1, .u[0].v = !on };	\
-								\
+	int rc;							\
+							\
 	if (unlikely(!rt)) return;				\
-	pmf_call_function(rt->node, #name "-mute", &args);	\
+	rc = pmf_call_function(rt->node, #name "-mute", &args);	\
+	if (rc)							\
+		printk(KERN_WARNING "pmf_gpio_set_" #name	\
+		" failed, rc: %d\n", rc);			\
 	rt->implementation_private &= ~(1<<bit);		\
 	rt->implementation_private |= (!!on << bit);		\
 }								\
@@ -33,9 +37,13 @@
 static void pmf_gpio_set_hw_reset(struct gpio_runtime *rt, int on)
 {
 	struct pmf_args args = { .count = 1, .u[0].v = !!on };
+	int rc;
 
 	if (unlikely(!rt)) return;
-	pmf_call_function(rt->node, "hw-reset", &args);
+	rc = pmf_call_function(rt->node, "hw-reset", &args);
+	if (rc)
+		printk(KERN_WARNING "pmf_gpio_set_hw_reset"
+		       " failed, rc: %d\n", rc);
 }
 
 static void pmf_gpio_all_amps_off(struct gpio_runtime *rt)
Index: linux-irq-work/sound/aoa/fabrics/snd-aoa-fabric-layout.c
===================================================================
--- linux-irq-work.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-07-01 13:51:30.000000000 +1000
+++ linux-irq-work/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-07-07 16:17:43.000000000 +1000
@@ -950,11 +950,12 @@
 	layout_id = (unsigned int *) get_property(sound, "layout-id", NULL);
 	if (!layout_id)
 		goto outnodev;
-	printk(KERN_INFO "snd-aoa-fabric-layout: found bus with layout %d ", *layout_id);
+	printk(KERN_INFO "snd-aoa-fabric-layout: found bus with layout %d\n",
+	       *layout_id);
 
 	layout = find_layout_by_id(*layout_id);
 	if (!layout) {
-		printk("(no idea how to handle)\n");
+		printk(KERN_ERR "snd-aoa-fabric-layout: unknown layout\n");
 		goto outnodev;
 	}
 
@@ -972,15 +973,17 @@
 	case 51: /* PowerBook5,4 */
 	case 58: /* Mac Mini */
 		ldev->gpio.methods = ftr_gpio_methods;
+		printk(KERN_DEBUG
+		       "snd-aoa-fabric-layout: Using PMF GPIOs\n");
 		break;
 	default:
 		ldev->gpio.methods = pmf_gpio_methods;
+		printk(KERN_DEBUG
+		       "snd-aoa-fabric-layout: Using direct GPIOs\n");
 	}
 	ldev->selfptr_headphone.ptr = ldev;
 	ldev->selfptr_lineout.ptr = ldev;
 	sdev->ofdev.dev.driver_data = ldev;
-
-	printk("(using)\n");
 	list_add(&ldev->list, &layouts_list);
 	layouts_list_items++;
 
