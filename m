Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB3B467B2C
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 16:18:31 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 16:16:32 +1000
Message-Id: <1113113792.9517.476.camel@gaston>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] pmac: sound support for latest laptops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch hacks the current Alsa snd-powermac driver to add support for
recent machine models with the tas3004 chip, that is basically new
laptop models. The Mac Mini is _NOT_ yet supported by this patch (soon
soon ...). The G5s (iMac or Desktop) will need the rewritten sound
driver on which I'm working on (I _might_ get a hack for analog only on
some G5s on the current driver, but no promise).

diff -urN linux-2.6.12-rc2/sound/ppc/pmac.c linux-2.6.12-rc2+snd/sound/ppc/pmac.c
--- linux-2.6.12-rc2/sound/ppc/pmac.c	2005-04-10 15:21:33.000000000 +1000
+++ linux-2.6.12-rc2+snd/sound/ppc/pmac.c	2005-04-10 15:16:07.000000000 +1000
@@ -881,7 +881,8 @@
 {
 	struct device_node *sound;
 	unsigned int *prop, l;
-
+	u32 layout_id = 0;
+	
 	if (_machine != _MACH_Pmac)
 		return -ENODEV;
 
@@ -929,6 +930,9 @@
 	prop = (unsigned int *) get_property(sound, "sub-frame", NULL);
 	if (prop && *prop < 16)
 		chip->subframe = *prop;
+	prop = (unsigned int *) get_property(sound, "layout-id", NULL);
+	if (prop)
+		layout_id = *prop;
 	/* This should be verified on older screamers */
 	if (device_is_compatible(sound, "screamer")) {
 		chip->model = PMAC_SCREAMER;
@@ -961,12 +965,22 @@
 		chip->freq_table = tumbler_freqs;
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}
-	if (device_is_compatible(sound, "AOAKeylargo")) {
-		/* Seems to support the stock AWACS frequencies, but has
-		   a snapper mixer */
-		chip->model = PMAC_SNAPPER;
-		// chip->can_byte_swap = 0; /* FIXME: check this */
-		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
+	if (device_is_compatible(sound, "AOAKeylargo") ||
+	    device_is_compatible(sound, "AOAbase")) {
+		/* For now, only support very basic TAS3004 based machines with
+		 * single frequency until proper i2s control is implemented
+		 */
+		switch(layout_id) {
+		case 0x48:
+		case 0x46:
+		case 0x33:
+		case 0x29:
+			chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
+			chip->model = PMAC_SNAPPER;
+			chip->can_byte_swap = 0; /* FIXME: check this */
+			chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
+			break;
+		}
 	}
 	prop = (unsigned int *)get_property(sound, "device-id", NULL);
 	if (prop)
diff -urN linux-2.6.12-rc2/sound/ppc/tumbler.c linux-2.6.12-rc2+snd/sound/ppc/tumbler.c
--- linux-2.6.12-rc2/sound/ppc/tumbler.c	2005-03-05 10:20:29.000000000 +1100
+++ linux-2.6.12-rc2+snd/sound/ppc/tumbler.c	2005-04-10 15:08:00.000000000 +1000
@@ -37,6 +37,8 @@
 #include <asm/irq.h>
 #ifdef CONFIG_PPC_HAS_FEATURE_CALLS
 #include <asm/pmac_feature.h>
+#else
+#error old crap
 #endif
 #include "pmac.h"
 #include "tumbler_volume.h"
@@ -950,10 +952,10 @@
 }
 
 /* find an audio device and get its address */
-static unsigned long tumbler_find_device(const char *device, pmac_gpio_t *gp, int is_compatible)
+static long tumbler_find_device(const char *device, pmac_gpio_t *gp, int is_compatible)
 {
 	struct device_node *node;
-	u32 *base;
+	u32 *base, addr;
 
 	if (is_compatible)
 		node = find_compatible_audio_device(device);
@@ -966,21 +968,31 @@
 
 	base = (u32 *)get_property(node, "AAPL,address", NULL);
 	if (! base) {
-		snd_printd("cannot find address for device %s\n", device);
-		return -ENODEV;
-	}
+		base = (u32 *)get_property(node, "reg", NULL);
+		if (!base) {
+			snd_printd("cannot find address for device %s\n", device);
+			return -ENODEV;
+		}
+		/* this only work if PPC_HAS_FEATURE_CALLS is set as we
+		 * are only getting the low part of the address
+		 */
+		addr = *base;
+		if (addr < 0x50)
+			addr += 0x50;
+	} else
+		addr = *base;
 
 #ifdef CONFIG_PPC_HAS_FEATURE_CALLS
-	gp->addr = (*base) & 0x0000ffff;
+	gp->addr = addr & 0x0000ffff;
 #else
-	gp->addr = ioremap((unsigned long)(*base), 1);
+	gp->addr = ioremap((unsigned long)addr, 1);
 #endif
+	/* Try to find the active state, default to 0 ! */
 	base = (u32 *)get_property(node, "audio-gpio-active-state", NULL);
 	if (base)
 		gp->active_state = *base;
 	else
-		gp->active_state = 1;
-
+		gp->active_state = 0;
 
 	return (node->n_intrs > 0) ? node->intrs[0].line : 0;
 }
@@ -1039,11 +1051,16 @@
 	pmac_tumbler_t *mix = chip->mixer_data;
 	snd_assert(mix, return -EINVAL);
 
-	tumbler_find_device("audio-hw-reset", &mix->audio_reset, 0);
-	tumbler_find_device("amp-mute", &mix->amp_mute, 0);
-	tumbler_find_device("headphone-mute", &mix->hp_mute, 0);
+	if (tumbler_find_device("audio-hw-reset", &mix->audio_reset, 0) < 0)
+		tumbler_find_device("hw-reset", &mix->audio_reset, 1);
+	if (tumbler_find_device("amp-mute", &mix->amp_mute, 0) < 0)
+		tumbler_find_device("amp-mute", &mix->amp_mute, 1);
+	if (tumbler_find_device("headphone-mute", &mix->hp_mute, 0) < 0)
+		tumbler_find_device("headphone-mute", &mix->hp_mute, 1);
 	irq = tumbler_find_device("headphone-detect", &mix->hp_detect, 0);
 	if (irq < 0)
+		irq = tumbler_find_device("headphone-detect", &mix->hp_detect, 1);
+	if (irq < 0)
 		irq = tumbler_find_device("keywest-gpio15", &mix->hp_detect, 1);
 
 	tumbler_reset_audio(chip);
@@ -1109,9 +1126,13 @@
 	/* set up TAS */
 	tas_node = find_devices("deq");
 	if (tas_node == NULL)
+		tas_node = find_devices("codec");
+	if (tas_node == NULL)
 		return -ENODEV;
 
 	paddr = (u32 *)get_property(tas_node, "i2c-address", NULL);
+	if (paddr == NULL)
+		paddr = (u32 *)get_property(tas_node, "reg", NULL);
 	if (paddr)
 		mix->i2c.addr = (*paddr) >> 1;
 	else
@@ -1129,7 +1150,7 @@
 
 	if ((err = snd_pmac_keywest_init(&mix->i2c)) < 0)
 		return err;
-
+	
 	/*
 	 * build mixers
 	 */
@@ -1156,7 +1177,6 @@
 	if ((err = snd_ctl_add(chip->card, chip->drc_sw_ctl)) < 0)
 		return err;
 
-
 #ifdef CONFIG_PMAC_PBOOK
 	chip->resume = tumbler_resume;
 #endif
