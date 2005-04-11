Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83FAC67B45
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2005 12:03:17 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 12:00:54 +1000
Message-Id: <1113184854.9567.522.camel@gaston>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: [PATCH] pmac: Improve sleep code of tumbler driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch (applies on top of my previous one adding support for newer
machines) improves the behaviour of the "tumbler/snapper" driver used on
newer PowerMacs during sleep. It properly set the HW mutes to shut down
amplifiers and does an analog shutdown of the codec. That might improve
power consumption during sleep on a number of machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/sound/ppc/tumbler.c
===================================================================
--- linux-work.orig/sound/ppc/tumbler.c	2005-04-11 10:50:18.000000000 +1000
+++ linux-work/sound/ppc/tumbler.c	2005-04-11 11:57:07.000000000 +1000
@@ -94,12 +94,17 @@
 	pmac_gpio_t hp_detect;
 	int headphone_irq;
 	unsigned int master_vol[2];
+	unsigned int save_master_switch[2];
 	unsigned int master_switch[2];
 	unsigned int mono_vol[VOL_IDX_LAST_MONO];
 	unsigned int mix_vol[VOL_IDX_LAST_MIX][2]; /* stereo volumes for tas3004 */
 	int drc_range;
 	int drc_enable;
 	int capture_source;
+	int anded_reset;
+	int auto_mute_notify;
+	int reset_on_sleep;
+	u8  acs;
 } pmac_tumbler_t;
 
 
@@ -654,7 +659,8 @@
 
 
 /*
- * mute switches
+ * mute switches. FIXME: Turn that into software mute when both outputs are muted
+ * to avoid codec reset on ibook M7
  */
 
 enum { TUMBLER_MUTE_HP, TUMBLER_MUTE_AMP };
@@ -696,8 +702,11 @@
 {
 	if (! mix->i2c.client)
 		return -ENODEV;
-	return i2c_smbus_write_byte_data(mix->i2c.client, TAS_REG_ACS,
-					 mix->capture_source ? 2 : 0);
+	if (mix->capture_source)
+		mix->acs = mix->acs |= 2;
+	else
+		mix->acs &= ~2;
+	return i2c_smbus_write_byte_data(mix->i2c.client, TAS_REG_ACS, mix->acs);
 }
 
 static int snapper_info_capture_source(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
@@ -855,8 +864,7 @@
 
 static struct work_struct device_change;
 
-static void
-device_change_handler(void *self)
+static void device_change_handler(void *self)
 {
 	pmac_t *chip = (pmac_t*) self;
 	pmac_tumbler_t *mix;
@@ -865,6 +873,33 @@
 		return;
 
 	mix = chip->mixer_data;
+	snd_assert(mix, return);
+
+	if (tumbler_detect_headphone(chip)) {
+		/* mute speaker */
+		check_mute(chip, &mix->hp_mute, 0, mix->auto_mute_notify,
+			   chip->master_sw_ctl);
+		if (mix->anded_reset)
+			big_mdelay(10);
+		check_mute(chip, &mix->amp_mute, 1, mix->auto_mute_notify,
+			   chip->speaker_sw_ctl);
+		mix->drc_enable = 0;
+	} else {
+		/* unmute speaker */
+		check_mute(chip, &mix->amp_mute, 0, mix->auto_mute_notify,
+			   chip->speaker_sw_ctl);
+		if (mix->anded_reset)
+			big_mdelay(10);
+		check_mute(chip, &mix->hp_mute, 1, mix->auto_mute_notify,
+			   chip->master_sw_ctl);
+		mix->drc_enable = 1;
+	}
+	if (mix->auto_mute_notify) {
+		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &chip->hp_detect_ctl->id);
+		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &chip->drc_sw_ctl->id);
+	}
 
 	/* first set the DRC so the speaker do not explode -ReneR */
 	if (chip->model == PMAC_TUMBLER)
@@ -879,31 +914,11 @@
 static void tumbler_update_automute(pmac_t *chip, int do_notify)
 {
 	if (chip->auto_mute) {
-		pmac_tumbler_t *mix = chip->mixer_data;
+		pmac_tumbler_t *mix;
+		mix = chip->mixer_data;
 		snd_assert(mix, return);
-		if (tumbler_detect_headphone(chip)) {
-			/* mute speaker */
-			check_mute(chip, &mix->amp_mute, 1, do_notify, chip->speaker_sw_ctl);
-			check_mute(chip, &mix->hp_mute, 0, do_notify, chip->master_sw_ctl);
-			mix->drc_enable = 0;
-
-		} else {
-			/* unmute speaker */
-			check_mute(chip, &mix->amp_mute, 0, do_notify, chip->speaker_sw_ctl);
-			check_mute(chip, &mix->hp_mute, 1, do_notify, chip->master_sw_ctl);
-			mix->drc_enable = 1;
-		}
-		if (do_notify) {
-			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
-				       &chip->hp_detect_ctl->id);
-			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
-			               &chip->drc_sw_ctl->id);
-		}
-
-		/* finally we need to schedule an update of the mixer values
-		   (master and DRC are enough for now) -ReneR */
+		mix->auto_mute_notify = do_notify;
 		schedule_work(&device_change);
-
 	}
 }
 #endif /* PMAC_SUPPORT_AUTOMUTE */
@@ -1002,15 +1017,53 @@
 {
 	pmac_tumbler_t *mix = chip->mixer_data;
 
-	write_audio_gpio(&mix->audio_reset, 0);
-	big_mdelay(200);
-	write_audio_gpio(&mix->audio_reset, 1);
-	big_mdelay(100);
-	write_audio_gpio(&mix->audio_reset, 0);
-	big_mdelay(100);
+	if (mix->anded_reset) {
+		write_audio_gpio(&mix->hp_mute, 0);
+		write_audio_gpio(&mix->amp_mute, 0);
+		big_mdelay(200);
+		write_audio_gpio(&mix->hp_mute, 1);
+		write_audio_gpio(&mix->amp_mute, 1);
+		big_mdelay(100);
+		write_audio_gpio(&mix->hp_mute, 0);
+		write_audio_gpio(&mix->amp_mute, 0);
+		big_mdelay(100);
+	} else {
+		write_audio_gpio(&mix->audio_reset, 0);
+		big_mdelay(200);
+		write_audio_gpio(&mix->audio_reset, 1);
+		big_mdelay(100);
+		write_audio_gpio(&mix->audio_reset, 0);
+		big_mdelay(100);
+	}
 }
 
 #ifdef CONFIG_PMAC_PBOOK
+/* suspend mixer */
+static void tumbler_suspend(pmac_t *chip)
+{
+	pmac_tumbler_t *mix = chip->mixer_data;
+
+	if (mix->headphone_irq >= 0)
+		disable_irq(mix->headphone_irq);
+	mix->save_master_switch[0] = mix->master_switch[0];
+	mix->save_master_switch[1] = mix->master_switch[1];
+	mix->master_switch[0] = mix->master_switch[1] = 0;
+	tumbler_set_master_volume(mix);
+	if (!mix->anded_reset) {
+		write_audio_gpio(&mix->amp_mute, 1);
+		write_audio_gpio(&mix->hp_mute, 1);
+	}
+	if (chip->model == PMAC_SNAPPER) {
+		mix->acs |= 1;
+		i2c_smbus_write_byte_data(mix->i2c.client, TAS_REG_ACS, mix->acs);
+	}
+	if (mix->anded_reset) {
+		write_audio_gpio(&mix->amp_mute, 1);
+		write_audio_gpio(&mix->hp_mute, 1);
+	} else
+		write_audio_gpio(&mix->audio_reset, 1);
+}
+
 /* resume mixer */
 static void tumbler_resume(pmac_t *chip)
 {
@@ -1018,6 +1071,9 @@
 
 	snd_assert(mix, return);
 
+	mix->acs &= ~1;
+	mix->master_switch[0] = mix->save_master_switch[0];
+	mix->master_switch[1] = mix->save_master_switch[1];
 	tumbler_reset_audio(chip);
 	if (mix->i2c.client && mix->i2c.init_client) {
 		if (mix->i2c.init_client(&mix->i2c) < 0)
@@ -1041,6 +1097,8 @@
 	tumbler_set_master_volume(mix);
 	if (chip->update_automute)
 		chip->update_automute(chip, 0);
+	if (mix->headphone_irq >= 0)
+		enable_irq(mix->headphone_irq);
 }
 #endif
 
@@ -1103,9 +1161,9 @@
 	int i, err;
 	pmac_tumbler_t *mix;
 	u32 *paddr;
-	struct device_node *tas_node;
+	struct device_node *tas_node, *np;
 	char *chipname;
-
+	
 #ifdef CONFIG_KMOD
 	if (current->fs->root)
 		request_module("i2c-keywest");
@@ -1119,7 +1177,18 @@
 
 	chip->mixer_data = mix;
 	chip->mixer_free = tumbler_cleanup;
+	mix->anded_reset = 0;
+	mix->reset_on_sleep = 1;
 
+	for (np = chip->node->child; np; np = np->sibling) {
+		if (!strcmp(np->name, "sound")) {
+			if (get_property(np, "has-anded-reset", NULL))
+				mix->anded_reset = 1;
+			if (get_property(np, "layout-id", NULL))
+				mix->reset_on_sleep = 0;
+			break;
+		}
+	}  
 	if ((err = tumbler_init(chip)) < 0)
 		return err;
 
@@ -1178,6 +1247,7 @@
 		return err;
 
 #ifdef CONFIG_PMAC_PBOOK
+	chip->suspend = tumbler_suspend;
 	chip->resume = tumbler_resume;
 #endif
 
