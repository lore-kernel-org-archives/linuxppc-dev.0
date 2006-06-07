Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E6A567DFF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 23:11:42 +1000 (EST)
Message-Id: <20060607130910.156412000@sipsolutions.net>
References: <20060607130909.584205000@sipsolutions.net>
Date: Wed, 07 Jun 2006 15:09:10 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 01/12] snd-powermac: no longer handle anything with a
	layout-id property
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

This patch removes from snd-powermac the code that check for the layout-id
and instead adds code that makes it refuse loading when a layout-id property
is present, nothing that snd-aoa should be used.
It also removes the 'toonie' codec from snd-powermac which was only ever
used on the mac mini which has a layout-id property.

--- a/sound/ppc/Makefile
+++ b/sound/ppc/Makefile
@@ -3,7 +3,7 @@ # Makefile for ALSA
 # Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
-snd-powermac-objs := powermac.o pmac.o awacs.o burgundy.o daca.o tumbler.o toonie.o keywest.o beep.o
+snd-powermac-objs := powermac.o pmac.o awacs.o burgundy.o daca.o tumbler.o keywest.o beep.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_POWERMAC) += snd-powermac.o
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -867,8 +867,6 @@ static int __init snd_pmac_detect(struct
 	unsigned int *prop, l;
 	struct macio_chip* macio;
 
-	u32 layout_id = 0;
-
 	if (!machine_is(powermac))
 		return -ENODEV;
 
@@ -929,8 +927,14 @@ static int __init snd_pmac_detect(struct
 	if (prop && *prop < 16)
 		chip->subframe = *prop;
 	prop = (unsigned int *) get_property(sound, "layout-id", NULL);
-	if (prop)
-		layout_id = *prop;
+	if (prop) {
+		/* partly deprecate snd-powermac, for those machines
+		 * that have a layout-id property for now */
+		printk(KERN_INFO "snd-powermac no longer handles any "
+				 "machines with a layout-id property "
+				 "in the device-tree, use snd-aoa.\n");
+		return -ENODEV;
+	}
 	/* This should be verified on older screamers */
 	if (device_is_compatible(sound, "screamer")) {
 		chip->model = PMAC_SCREAMER;
@@ -963,38 +967,6 @@ static int __init snd_pmac_detect(struct
 		chip->freq_table = tumbler_freqs;
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}
-	if (device_is_compatible(sound, "AOAKeylargo") ||
-	    device_is_compatible(sound, "AOAbase") ||
-	    device_is_compatible(sound, "AOAK2")) {
-		/* For now, only support very basic TAS3004 based machines with
-		 * single frequency until proper i2s control is implemented
-		 */
-		switch(layout_id) {
-		case 0x24:
-		case 0x29:
-		case 0x33:
-		case 0x46:
-		case 0x48:
-		case 0x50:
-		case 0x5c:
-			chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
-			chip->model = PMAC_SNAPPER;
-			chip->can_byte_swap = 0; /* FIXME: check this */
-			chip->control_mask = MASK_IEPC | 0x11;/* disable IEE */
-			break;
-		case 0x3a:
-			chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
-			chip->model = PMAC_TOONIE;
-			chip->can_byte_swap = 0; /* FIXME: check this */
-			chip->control_mask = MASK_IEPC | 0x11;/* disable IEE */
-			break;
-		default:
-			printk(KERN_ERR "snd: Unknown layout ID 0x%x\n",
-			       layout_id);
-			return -ENODEV;
-
-		}
-	}
 	prop = (unsigned int *)get_property(sound, "device-id", NULL);
 	if (prop)
 		chip->device_id = *prop;
--- a/sound/ppc/pmac.h
+++ b/sound/ppc/pmac.h
@@ -85,7 +85,7 @@ struct pmac_stream {
 
 enum snd_pmac_model {
 	PMAC_AWACS, PMAC_SCREAMER, PMAC_BURGUNDY, PMAC_DACA, PMAC_TUMBLER,
-	PMAC_SNAPPER, PMAC_TOONIE
+	PMAC_SNAPPER
 };
 
 struct snd_pmac {
@@ -188,7 +188,6 @@ int snd_pmac_burgundy_init(struct snd_pm
 int snd_pmac_daca_init(struct snd_pmac *chip);
 int snd_pmac_tumbler_init(struct snd_pmac *chip);
 int snd_pmac_tumbler_post_init(void);
-int snd_pmac_toonie_init(struct snd_pmac *chip);
 
 /* i2c functions */
 struct pmac_keywest {
--- a/sound/ppc/powermac.c
+++ b/sound/ppc/powermac.c
@@ -94,13 +94,6 @@ static int __init snd_pmac_probe(struct 
 		if ( snd_pmac_tumbler_init(chip) < 0 || snd_pmac_tumbler_post_init() < 0)
 			goto __error;
 		break;
-	case PMAC_TOONIE:
-		strcpy(card->driver, "PMac Toonie");
-		strcpy(card->shortname, "PowerMac Toonie");
-		strcpy(card->longname, card->shortname);
-		if ((err = snd_pmac_toonie_init(chip)) < 0)
-			goto __error;
-		break;
 	case PMAC_AWACS:
 	case PMAC_SCREAMER:
 		name_ext = chip->model == PMAC_SCREAMER ? "Screamer" : "AWACS";
--- a/sound/ppc/toonie.c
+++ /dev/null
@@ -1,378 +0,0 @@
-/*
- * Mac Mini "toonie" mixer control
- *
- * Copyright (c) 2005 by Benjamin Herrenschmidt <benh@kernel.crashing.org>
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#include <sound/driver.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/kmod.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <sound/core.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/machdep.h>
-#include <asm/pmac_feature.h>
-#include "pmac.h"
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
-struct pmac_gpio {
-	unsigned int addr;
-	u8 active_val;
-	u8 inactive_val;
-	u8 active_state;
-};
-
-struct pmac_toonie
-{
-	struct pmac_gpio	hp_detect_gpio;
-	struct pmac_gpio	hp_mute_gpio;
-	struct pmac_gpio	amp_mute_gpio;
-	int			hp_detect_irq;
-	int			auto_mute_notify;
-	struct work_struct	detect_work;
-};
-
-
-/*
- * gpio access
- */
-#define do_gpio_write(gp, val) \
-	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, (gp)->addr, val)
-#define do_gpio_read(gp) \
-	pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, (gp)->addr, 0)
-#define tumbler_gpio_free(gp) /* NOP */
-
-static void write_audio_gpio(struct pmac_gpio *gp, int active)
-{
-	if (! gp->addr)
-		return;
-	active = active ? gp->active_val : gp->inactive_val;
-	do_gpio_write(gp, active);
-	DBG("(I) gpio %x write %d\n", gp->addr, active);
-}
-
-static int check_audio_gpio(struct pmac_gpio *gp)
-{
-	int ret;
-
-	if (! gp->addr)
-		return 0;
-
-	ret = do_gpio_read(gp);
-
-	return (ret & 0xd) == (gp->active_val & 0xd);
-}
-
-static int read_audio_gpio(struct pmac_gpio *gp)
-{
-	int ret;
-	if (! gp->addr)
-		return 0;
-	ret = ((do_gpio_read(gp) & 0x02) !=0);
-	return ret == gp->active_state;
-}
-
-
-enum { TOONIE_MUTE_HP, TOONIE_MUTE_AMP };
-
-static int toonie_get_mute_switch(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
-	struct pmac_toonie *mix = chip->mixer_data;
-	struct pmac_gpio *gp;
-
-	if (mix == NULL)
-		return -ENODEV;
-	switch(kcontrol->private_value) {
-	case TOONIE_MUTE_HP:
-		gp = &mix->hp_mute_gpio;
-		break;
-	case TOONIE_MUTE_AMP:
-		gp = &mix->amp_mute_gpio;
-		break;
-	default:
-		return -EINVAL;
-	}
-	ucontrol->value.integer.value[0] = !check_audio_gpio(gp);
-	return 0;
-}
-
-static int toonie_put_mute_switch(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_pmac *chip = snd_kcontrol_chip(kcontrol);
-	struct pmac_toonie *mix = chip->mixer_data;
-	struct pmac_gpio *gp;
-	int val;
-
-	if (chip->update_automute && chip->auto_mute)
-		return 0; /* don't touch in the auto-mute mode */
-
-	if (mix == NULL)
-		return -ENODEV;
-
-	switch(kcontrol->private_value) {
-	case TOONIE_MUTE_HP:
-		gp = &mix->hp_mute_gpio;
-		break;
-	case TOONIE_MUTE_AMP:
-		gp = &mix->amp_mute_gpio;
-		break;
-	default:
-		return -EINVAL;
-	}
-	val = ! check_audio_gpio(gp);
-	if (val != ucontrol->value.integer.value[0]) {
-		write_audio_gpio(gp, ! ucontrol->value.integer.value[0]);
-		return 1;
-	}
-	return 0;
-}
-
-static struct snd_kcontrol_new toonie_hp_sw __initdata = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "Headphone Playback Switch",
-	.info = snd_pmac_boolean_mono_info,
-	.get = toonie_get_mute_switch,
-	.put = toonie_put_mute_switch,
-	.private_value = TOONIE_MUTE_HP,
-};
-static struct snd_kcontrol_new toonie_speaker_sw __initdata = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "PC Speaker Playback Switch",
-	.info = snd_pmac_boolean_mono_info,
-	.get = toonie_get_mute_switch,
-	.put = toonie_put_mute_switch,
-	.private_value = TOONIE_MUTE_AMP,
-};
-
-/*
- * auto-mute stuffs
- */
-static int toonie_detect_headphone(struct snd_pmac *chip)
-{
-	struct pmac_toonie *mix = chip->mixer_data;
-	int detect = 0;
-
-	if (mix->hp_detect_gpio.addr)
-		detect |= read_audio_gpio(&mix->hp_detect_gpio);
-	return detect;
-}
-
-static void toonie_check_mute(struct snd_pmac *chip, struct pmac_gpio *gp, int val,
-			      int do_notify, struct snd_kcontrol *sw)
-{
-	if (check_audio_gpio(gp) != val) {
-		write_audio_gpio(gp, val);
-		if (do_notify)
-			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
-				       &sw->id);
-	}
-}
-
-static void toonie_detect_handler(void *self)
-{
-	struct snd_pmac *chip = (struct snd_pmac *) self;
-	struct pmac_toonie *mix;
-	int headphone;
-
-	if (!chip)
-		return;
-
-	mix = chip->mixer_data;
-	snd_assert(mix, return);
-
-	headphone = toonie_detect_headphone(chip);
-
-	DBG("headphone: %d, lineout: %d\n", headphone, lineout);
-
-	if (headphone) {
-		/* unmute headphone/lineout & mute speaker */
-		toonie_check_mute(chip, &mix->hp_mute_gpio, 0,
-				  mix->auto_mute_notify, chip->master_sw_ctl);
-		toonie_check_mute(chip, &mix->amp_mute_gpio, 1,
-				  mix->auto_mute_notify, chip->speaker_sw_ctl);
-	} else {
-		/* unmute speaker, mute others */
-		toonie_check_mute(chip, &mix->amp_mute_gpio, 0,
-				  mix->auto_mute_notify, chip->speaker_sw_ctl);
-		toonie_check_mute(chip, &mix->hp_mute_gpio, 1,
-				  mix->auto_mute_notify, chip->master_sw_ctl);
-	}
-	if (mix->auto_mute_notify) {
-		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
-				       &chip->hp_detect_ctl->id);
-	}
-}
-
-static void toonie_update_automute(struct snd_pmac *chip, int do_notify)
-{
-	if (chip->auto_mute) {
-		struct pmac_toonie *mix;
-		mix = chip->mixer_data;
-		snd_assert(mix, return);
-		mix->auto_mute_notify = do_notify;
-		schedule_work(&mix->detect_work);
-	}
-}
-
-/* interrupt - headphone plug changed */
-static irqreturn_t toonie_hp_intr(int irq, void *devid, struct pt_regs *regs)
-{
-	struct snd_pmac *chip = devid;
-
-	if (chip->update_automute && chip->initialized) {
-		chip->update_automute(chip, 1);
-		return IRQ_HANDLED;
-	}
-	return IRQ_NONE;
-}
-
-/* look for audio gpio device */
-static int find_audio_gpio(const char *name, const char *platform,
-			   struct pmac_gpio *gp)
-{
-	struct device_node *np;
-  	u32 *base, addr;
-
-	if (! (np = find_devices("gpio")))
-		return -ENODEV;
-
-	for (np = np->child; np; np = np->sibling) {
-		char *property = get_property(np, "audio-gpio", NULL);
-		if (property && strcmp(property, name) == 0)
-			break;
-		if (device_is_compatible(np, name))
-			break;
-	}
-	if (np == NULL)
-		return -ENODEV;
-
-	base = (u32 *)get_property(np, "AAPL,address", NULL);
-	if (! base) {
-		base = (u32 *)get_property(np, "reg", NULL);
-		if (!base) {
-			DBG("(E) cannot find address for device %s !\n", name);
-			return -ENODEV;
-		}
-		addr = *base;
-		if (addr < 0x50)
-			addr += 0x50;
-	} else
-		addr = *base;
-
-	gp->addr = addr & 0x0000ffff;
-
-	/* Try to find the active state, default to 0 ! */
-	base = (u32 *)get_property(np, "audio-gpio-active-state", NULL);
-	if (base) {
-		gp->active_state = *base;
-		gp->active_val = (*base) ? 0x5 : 0x4;
-		gp->inactive_val = (*base) ? 0x4 : 0x5;
-	} else {
-		u32 *prop = NULL;
-		gp->active_state = 0;
-		gp->active_val = 0x4;
-		gp->inactive_val = 0x5;
-		/* Here are some crude hacks to extract the GPIO polarity and
-		 * open collector informations out of the do-platform script
-		 * as we don't yet have an interpreter for these things
-		 */
-		if (platform)
-			prop = (u32 *)get_property(np, platform, NULL);
-		if (prop) {
-			if (prop[3] == 0x9 && prop[4] == 0x9) {
-				gp->active_val = 0xd;
-				gp->inactive_val = 0xc;
-			}
-			if (prop[3] == 0x1 && prop[4] == 0x1) {
-				gp->active_val = 0x5;
-				gp->inactive_val = 0x4;
-			}
-		}
-	}
-
-	DBG("(I) GPIO device %s found, offset: %x, active state: %d !\n",
-	    name, gp->addr, gp->active_state);
-
-	return (np->n_intrs > 0) ? np->intrs[0].line : 0;
-}
-
-static void toonie_cleanup(struct snd_pmac *chip)
-{
-	struct pmac_toonie *mix = chip->mixer_data;
-	if (! mix)
-		return;
-	if (mix->hp_detect_irq >= 0)
-		free_irq(mix->hp_detect_irq, chip);
-	kfree(mix);
-	chip->mixer_data = NULL;
-}
-
-int __init snd_pmac_toonie_init(struct snd_pmac *chip)
-{
-	struct pmac_toonie *mix;
-
-	mix = kmalloc(sizeof(*mix), GFP_KERNEL);
-	if (! mix)
-		return -ENOMEM;
-
-	chip->mixer_data = mix;
-	chip->mixer_free = toonie_cleanup;
-
-	find_audio_gpio("headphone-mute", NULL, &mix->hp_mute_gpio);
-	find_audio_gpio("amp-mute", NULL, &mix->amp_mute_gpio);
-	mix->hp_detect_irq = find_audio_gpio("headphone-detect",
-					     NULL, &mix->hp_detect_gpio);
-
-	strcpy(chip->card->mixername, "PowerMac Toonie");
-
-	chip->master_sw_ctl = snd_ctl_new1(&toonie_hp_sw, chip);
-	snd_ctl_add(chip->card, chip->master_sw_ctl);
-
-	chip->speaker_sw_ctl = snd_ctl_new1(&toonie_speaker_sw, chip);
-	snd_ctl_add(chip->card, chip->speaker_sw_ctl);
-
-	INIT_WORK(&mix->detect_work, toonie_detect_handler, (void *)chip);
-
-	if (mix->hp_detect_irq >= 0) {
-		snd_pmac_add_automute(chip);
-
-		chip->detect_headphone = toonie_detect_headphone;
-		chip->update_automute = toonie_update_automute;
-		toonie_update_automute(chip, 0);
-
-		if (request_irq(mix->hp_detect_irq, toonie_hp_intr, 0,
-				"Sound Headphone Detection", chip) < 0)
-			mix->hp_detect_irq = -1;
-	}
-
-	return 0;
-}
-

--
