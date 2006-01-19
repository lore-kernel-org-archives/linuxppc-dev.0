Return-Path: <bcollins@ubuntu.com>
Date: Wed, 18 Jan 2006 19:28:04 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: RFC: [PATCH Upated]: snd-pmac-gpio interfaces for snd-powermac
To: Linuxppc-dev@ozlabs.org
Message-id: <1137630485.4425.2.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This corrects a problem in the tumbler and toonie conversion. Also fixes
a small naming change requested by BenH in snd-pmac-gpio.c

diff -urN linux-2.6/sound/ppc/Makefile linux-source-2.6.15-2.6.15/sound/ppc/Makefile
--- linux-2.6/sound/ppc/Makefile	2006-01-17 20:19:28.000000000 -0500
+++ linux-source-2.6.15-2.6.15/sound/ppc/Makefile	2006-01-17 20:30:40.000000000 -0500
@@ -3,7 +3,8 @@
 # Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
-snd-powermac-objs := powermac.o pmac.o awacs.o burgundy.o daca.o tumbler.o toonie.o keywest.o beep.o
+snd-powermac-objs := powermac.o pmac.o awacs.o burgundy.o daca.o tumbler.o \
+	toonie.o keywest.o beep.o snd-pmac-gpio.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_POWERMAC) += snd-powermac.o
diff -urN linux-2.6/sound/ppc/snd-pmac-gpio.c linux-source-2.6.15-2.6.15/sound/ppc/snd-pmac-gpio.c
--- linux-2.6/sound/ppc/snd-pmac-gpio.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-source-2.6.15-2.6.15/sound/ppc/snd-pmac-gpio.c	2006-01-18 19:08:17.000000000 -0500
@@ -0,0 +1,248 @@
+/*
+ * Copyright (c) 2005 by Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * Copyright (c) 2006 by Ben Collins <bcollins@ubuntu.com>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <asm/pmac_feature.h>
+#include "snd-pmac-gpio.h"
+#include "pmac.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) printk(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+
+static struct pmf_function *get_audio_pfunc(const char *name, const char *altname)
+{
+	struct device_node *np;
+	struct pmf_function *pfunc = NULL;
+
+	if (! (np = find_devices("i2s-a")))
+		return NULL;
+
+	pfunc = pmf_find_function(np, name);
+	if (pfunc == NULL && altname != NULL)
+		pfunc = pmf_find_function(np, altname);
+
+	return pfunc;
+}
+
+static struct device_node *find_audio_gpio(const char *name,
+					   const char *altname)
+{
+	struct device_node *np;
+
+	if (! (np = find_devices("gpio")))
+		return NULL;
+
+	for (np = np->child; np; np = np->sibling) {
+		char *property = get_property(np, "audio-gpio", NULL);
+		if (property && (strcmp(property, name) == 0 ||
+		    strcmp(property, altname) == 0))
+			break;
+		if (device_is_compatible(np, name) ||
+		    device_is_compatible(np, altname))
+			break;
+        }
+
+	return np;
+}
+
+static int get_audio_gpio(const char *name, const char *altname,
+			  snd_pmac_gpio_t *gp)
+{
+	struct device_node *np;
+	u32 *base, addr;
+
+	if (!(np = find_audio_gpio(name, altname)))
+		return -ENODEV;
+
+	base = (u32 *)get_property(np, "AAPL,address", NULL);
+	if (! base) {
+		base = (u32 *)get_property(np, "reg", NULL);
+		if (!base) {
+			DBG("(E) cannot find address for device %s !\n", name);
+			return -ENODEV;
+		}
+		addr = *base;
+		if (addr < 0x50)
+			addr += 0x50;
+	} else
+		addr = *base;
+
+	gp->addr = addr & 0x0000ffff;
+
+	/* Try to find the active state, default to 0 ! */
+	base = (u32 *)get_property(np, "audio-gpio-active-state", NULL);
+	if (base) {
+		gp->active_state = *base;
+		gp->active_val = (*base) ? 0x5 : 0x4;
+		gp->inactive_val = (*base) ? 0x4 : 0x5;
+	} else {
+		/* Don't expect this to work. If platform-do isn't
+		 * available (pmac_pfunc), and the above didn't work, then
+		 * these are probably wrong.
+		 */
+		gp->active_state = 0;
+		gp->active_val = 0x4;
+		gp->inactive_val = 0x5;
+	}
+
+	DBG("(I) GPIO device %s found, offset: %x, active state: %d !\n",
+	    name, gp->addr, gp->active_state);
+
+	gp->irq = (np->n_intrs > 0) ? np->intrs[0].line : 0;
+
+	return 0;
+}
+
+int snd_pmac_get_gpio(const char *name, const char *altname,
+                            snd_pmac_gpio_t *gp)
+{
+        memset(gp, 0, sizeof(*gp));
+
+	gp->name = name;
+	gp->altname = altname;
+
+        /* Platform functions are prefered */
+        if ((gp->pfunc = get_audio_pfunc(name, altname)))
+                return 0;
+
+	/* Else, fallback to direct gpio */
+	return get_audio_gpio(name, altname, gp);
+}
+
+void snd_pmac_free_gpio(snd_pmac_gpio_t *gp)
+{
+	if (gp->pfunc != NULL) {
+		if (gp->irq_client.owner == THIS_MODULE) {
+			/* XXX: pmf_unregister_irq_client doesn't use its
+			 * first two arguments. We only need to send it
+			 * the irq_client. WATCH FOR THIS CHANGING!
+			 */
+			pmf_unregister_irq_client(NULL, NULL, &gp->irq_client);
+			gp->irq_client.owner = NULL;
+		}
+
+		pmf_put_function(gp->pfunc);
+		gp->pfunc = NULL;
+	} else if (gp->addr) {
+		if (gp->irq > 0) {
+			free_irq(gp->irq, gp);
+			gp->irq = 0;
+		}
+		gp->addr = 0;
+	}
+}
+
+int snd_pmac_write_gpio(snd_pmac_gpio_t *gp, u32 val)
+{
+	int ret = -ENODEV;
+
+	if (gp->pfunc) {
+		struct pmf_args args;
+
+		args.count = 1;
+		args.u[0].v = val;
+
+		ret = pmf_call_one(gp->pfunc, &args);
+	} else if (gp->addr) {
+		val = val ? gp->active_val : gp->inactive_val;
+
+		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, gp->addr, val);
+
+		ret = 0;
+	}
+
+	if (!ret)
+		gp->state = val;
+
+	return -EINVAL;
+}
+
+int snd_pmac_read_gpio(snd_pmac_gpio_t *gp, u32 *val)
+{
+	int ret = -EINVAL;
+
+	if (gp->pfunc) {
+		struct pmf_args args;
+
+		args.count = 1;
+		args.u[0].p = val;
+
+		ret = pmf_call_one(gp->pfunc, &args);
+	} else if (gp->addr) {
+		int ret = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL,
+					    gp->addr, 0);
+
+		ret = ((ret & 0x02) != 0);
+		*val = ret == gp->active_state;
+
+		ret = 0;
+	}
+
+	return -EINVAL;
+}
+
+u32 snd_pmac_gpio_internal_state(snd_pmac_gpio_t *gp)
+{
+	return gp->state;
+}
+
+static irqreturn_t snd_pmac_intr(int irq, void *data, struct pt_regs *regs)
+{
+	snd_pmac_gpio_t *gp = data;
+
+	gp->irq_client.handler(gp->irq_client.data);
+
+	return IRQ_HANDLED;
+}
+
+int snd_pmac_request_irq(snd_pmac_gpio_t *gp, void (*handler)(void *),
+			 void *data)
+{
+	int ret = -ENODEV;
+	struct device_node *np;
+
+	gp->irq_client.handler = handler;
+	gp->irq_client.data = data;
+	gp->irq_client.owner = NULL;
+
+	if (gp->pfunc) {
+		gp->irq_client.owner = THIS_MODULE;
+
+		if ((np = find_devices("i2s-a"))) {
+			ret = pmf_register_irq_client(np, gp->name, &gp->irq_client);
+			if (ret < 0)
+				ret = pmf_register_irq_client(np, gp->altname, &gp->irq_client);
+		}
+		if (ret < 0)
+			gp->irq_client.owner = NULL;
+	} else if (gp->irq > 0) {
+		ret = request_irq(gp->irq, snd_pmac_intr, 0, gp->name, gp);
+		if (ret < 0)
+			gp->irq = 0;
+	}
+
+	return ret;
+}
diff -urN linux-2.6/sound/ppc/snd-pmac-gpio.h linux-source-2.6.15-2.6.15/sound/ppc/snd-pmac-gpio.h
--- linux-2.6/sound/ppc/snd-pmac-gpio.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-source-2.6.15-2.6.15/sound/ppc/snd-pmac-gpio.h	2006-01-18 17:56:07.000000000 -0500
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2005 by Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * Copyright (c) 2006 by Ben Collins <bcollins@ubuntu.com>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef SND_PMAC_GPIO_H
+#define SND_PMAC_GPIO_H 1
+
+#include <asm/pmac_pfunc.h>
+
+typedef struct snd_pmac_gpio {
+	struct pmf_function *pfunc;
+        unsigned int addr;
+        u8 active_val;
+        u8 inactive_val;
+        u8 active_state;
+	u32 state;
+
+	/* Used by irq functions */
+	int irq;
+	struct pmf_irq_client irq_client;
+	const char *name;
+	const char *altname;
+} snd_pmac_gpio_t;
+
+/* Return a handle for access to the named gpio */
+int snd_pmac_get_gpio(const char *name, const char *altname,
+		      snd_pmac_gpio_t *gp);
+
+/* Frees resources related to the gpio handle */
+void snd_pmac_free_gpio(snd_pmac_gpio_t *gp);
+
+/* GPIO Operations */
+int snd_pmac_write_gpio(snd_pmac_gpio_t *gp, u32 val);
+int snd_pmac_read_gpio(snd_pmac_gpio_t *gp, u32 *val);
+
+/* Used to get the internal state of a write only gpio */
+u32 snd_pmac_gpio_internal_state(snd_pmac_gpio_t *gp);
+
+/* Register an irq for a previously allocated gpio. This is automaticlly
+ * freed in snd_pmac_free_cpio. */
+int snd_pmac_request_irq(snd_pmac_gpio_t *gp, void (*handler)(void *),
+			 void *data);
+
+static inline int snd_pmac_gpio_valid(snd_pmac_gpio_t *gp)
+{
+	return (gp->pfunc || gp->addr) ? 1 : 0;
+}
+#endif /* SND_PMAC_GPIO_H */


diff -urN linux-2.6/sound/ppc/toonie.c linux-source-2.6.15-2.6.15/sound/ppc/toonie.c
--- linux-2.6/sound/ppc/toonie.c	2006-01-17 20:19:28.000000000 -0500
+++ linux-source-2.6.15-2.6.15/sound/ppc/toonie.c	2006-01-18 19:18:33.000000000 -0500
@@ -31,7 +31,9 @@
 #include <asm/irq.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
+
 #include "pmac.h"
+#include "snd-pmac-gpio.h"
 
 #undef DEBUG
 
@@ -41,61 +43,34 @@
 #define DBG(fmt...)
 #endif
 
-struct pmac_gpio {
-	unsigned int addr;
-	u8 active_val;
-	u8 inactive_val;
-	u8 active_state;
-};
-
 struct pmac_toonie
 {
-	struct pmac_gpio	hp_detect_gpio;
-	struct pmac_gpio	hp_mute_gpio;
-	struct pmac_gpio	amp_mute_gpio;
-	int			hp_detect_irq;
+	snd_pmac_gpio_t		hp_detect_gpio;
+	snd_pmac_gpio_t		hp_mute_gpio;
+	snd_pmac_gpio_t		amp_mute_gpio;
+
 	int			auto_mute_notify;
 	struct work_struct	detect_work;
 };
 
 
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
+static void toonie_reset_audio(pmac_t *chip)
 {
-	int ret;
+	snd_pmac_gpio_t gpio;
 
-	if (! gp->addr)
-		return 0;
+	if (snd_pmac_get_gpio("audio-hw-reset", "hw-reset", &gpio))
+		return;
 
-	ret = do_gpio_read(gp);
+	DBG("(I) codec normal reset !\n");
 
-	return (ret & 0xd) == (gp->active_val & 0xd);
-}
+	snd_pmac_write_gpio(&gpio, 0);
+	msleep(200);
+	snd_pmac_write_gpio(&gpio, 1);
+	msleep(100);
+	snd_pmac_write_gpio(&gpio, 0);
+	msleep(100);
 
-static int read_audio_gpio(struct pmac_gpio *gp)
-{
-	int ret;
-	if (! gp->addr)
-		return 0;
-	ret = ((do_gpio_read(gp) & 0x02) !=0);
-	return ret == gp->active_state;
+	snd_pmac_free_gpio(&gpio);
 }
 
 
@@ -106,10 +81,11 @@
 {
 	pmac_t *chip = snd_kcontrol_chip(kcontrol);
 	struct pmac_toonie *mix = chip->mixer_data;
-	struct pmac_gpio *gp;
+	snd_pmac_gpio_t *gp;
 
 	if (mix == NULL)
 		return -ENODEV;
+
 	switch(kcontrol->private_value) {
 	case TOONIE_MUTE_HP:
 		gp = &mix->hp_mute_gpio;
@@ -120,7 +96,7 @@
 	default:
 		return -EINVAL;;
 	}
-	ucontrol->value.integer.value[0] = !check_audio_gpio(gp);
+	ucontrol->value.integer.value[0] = !snd_pmac_gpio_internal_state(gp);
 	return 0;
 }
 
@@ -129,8 +105,7 @@
 {
 	pmac_t *chip = snd_kcontrol_chip(kcontrol);
 	struct pmac_toonie *mix = chip->mixer_data;
-	struct pmac_gpio *gp;
-	int val;
+	snd_pmac_gpio_t *gp;
 
 	if (chip->update_automute && chip->auto_mute)
 		return 0; /* don't touch in the auto-mute mode */
@@ -148,9 +123,8 @@
 	default:
 		return -EINVAL;;
 	}
-	val = ! check_audio_gpio(gp);
-	if (val != ucontrol->value.integer.value[0]) {
-		write_audio_gpio(gp, ! ucontrol->value.integer.value[0]);
+	if (!snd_pmac_gpio_internal_state(gp) != ucontrol->value.integer.value[0]) {
+		snd_pmac_write_gpio(gp, ! ucontrol->value.integer.value[0]);
 		return 1;
 	}
 	return 0;
@@ -181,20 +155,21 @@
 	struct pmac_toonie *mix = chip->mixer_data;
 	int detect = 0;
 
-	if (mix->hp_detect_gpio.addr)
-		detect |= read_audio_gpio(&mix->hp_detect_gpio);
+	snd_pmac_read_gpio(&mix->hp_detect_gpio, &detect);
+
 	return detect;
 }
 
-static void toonie_check_mute(pmac_t *chip, struct pmac_gpio *gp, int val,
-			      int do_notify, snd_kcontrol_t *sw)
+static int toonie_do_mute(pmac_t *chip, snd_pmac_gpio_t *gp, int val,
+			   int do_notify, snd_kcontrol_t *sw)
 {
-	if (check_audio_gpio(gp) != val) {
-		write_audio_gpio(gp, val);
-		if (do_notify)
-			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
-				       &sw->id);
-	}
+	snd_pmac_write_gpio(gp, val);
+
+	if (do_notify)
+		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &sw->id);
+
+	return val;
 }
 
 static void toonie_detect_handler(void *self)
@@ -211,20 +186,20 @@
 
 	headphone = toonie_detect_headphone(chip);
 
-	DBG("headphone: %d, lineout: %d\n", headphone, lineout);
+	DBG("headphone: %d\n", headphone);
 
 	if (headphone) {
 		/* unmute headphone/lineout & mute speaker */
-		toonie_check_mute(chip, &mix->hp_mute_gpio, 0,
-				  mix->auto_mute_notify, chip->master_sw_ctl);
-		toonie_check_mute(chip, &mix->amp_mute_gpio, 1,
-				  mix->auto_mute_notify, chip->speaker_sw_ctl);
+		toonie_do_mute(chip, &mix->hp_mute_gpio, 0,
+			       mix->auto_mute_notify, chip->master_sw_ctl);
+		toonie_do_mute(chip, &mix->amp_mute_gpio, 1,
+			       mix->auto_mute_notify, chip->speaker_sw_ctl);
 	} else {
 		/* unmute speaker, mute others */
-		toonie_check_mute(chip, &mix->amp_mute_gpio, 0,
-				  mix->auto_mute_notify, chip->speaker_sw_ctl);
-		toonie_check_mute(chip, &mix->hp_mute_gpio, 1,
-				  mix->auto_mute_notify, chip->master_sw_ctl);
+		toonie_do_mute(chip, &mix->amp_mute_gpio, 0,
+			       mix->auto_mute_notify, chip->speaker_sw_ctl);
+		toonie_do_mute(chip, &mix->hp_mute_gpio, 1,
+			       mix->auto_mute_notify, chip->master_sw_ctl);
 	}
 	if (mix->auto_mute_notify) {
 		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
@@ -244,85 +219,12 @@
 }
 
 /* interrupt - headphone plug changed */
-static irqreturn_t toonie_hp_intr(int irq, void *devid, struct pt_regs *regs)
+static void toonie_hp_intr(void *devid)
 {
 	pmac_t *chip = devid;
 
-	if (chip->update_automute && chip->initialized) {
+	if (chip->update_automute && chip->initialized)
 		chip->update_automute(chip, 1);
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
 }
 
 static void toonie_cleanup(pmac_t *chip)
@@ -330,8 +232,11 @@
 	struct pmac_toonie *mix = chip->mixer_data;
 	if (! mix)
 		return;
-	if (mix->hp_detect_irq >= 0)
-		free_irq(mix->hp_detect_irq, chip);
+
+	snd_pmac_free_gpio(&mix->hp_mute_gpio);
+	snd_pmac_free_gpio(&mix->amp_mute_gpio);
+	snd_pmac_free_gpio(&mix->hp_detect_gpio);
+
 	kfree(mix);
 	chip->mixer_data = NULL;
 }
@@ -340,17 +245,20 @@
 {
 	struct pmac_toonie *mix;
 
-	mix = kmalloc(sizeof(*mix), GFP_KERNEL);
+	mix = kzalloc(sizeof(*mix), GFP_KERNEL);
 	if (! mix)
 		return -ENOMEM;
 
 	chip->mixer_data = mix;
 	chip->mixer_free = toonie_cleanup;
 
-	find_audio_gpio("headphone-mute", NULL, &mix->hp_mute_gpio);
-	find_audio_gpio("amp-mute", NULL, &mix->amp_mute_gpio);
-	mix->hp_detect_irq = find_audio_gpio("headphone-detect",
-					     NULL, &mix->hp_detect_gpio);
+	/* Atleast have to have these two */
+	if (snd_pmac_get_gpio("headphone-mute", "lineout-mute",
+			      &mix->hp_mute_gpio) ||
+	    snd_pmac_get_gpio("amp-mute", NULL,
+			      &mix->amp_mute_gpio)) {
+		return -ENODEV;
+	}
 
 	strcpy(chip->card->mixername, "PowerMac Toonie");
 
@@ -362,18 +270,18 @@
 
 	INIT_WORK(&mix->detect_work, toonie_detect_handler, (void *)chip);
 
-	if (mix->hp_detect_irq >= 0) {
+	if (!snd_pmac_get_gpio("headphone-detect", "lineout-detect",
+			       &mix->hp_detect_gpio)) {
 		snd_pmac_add_automute(chip);
 
 		chip->detect_headphone = toonie_detect_headphone;
 		chip->update_automute = toonie_update_automute;
 		toonie_update_automute(chip, 0);
 
-		if (request_irq(mix->hp_detect_irq, toonie_hp_intr, 0,
-				"Sound Headphone Detection", chip) < 0)
-			mix->hp_detect_irq = -1;
+		snd_pmac_request_irq(&mix->hp_detect_gpio, toonie_hp_intr, chip);
 	}
 
+	toonie_reset_audio(chip);
+
 	return 0;
 }
-


diff -urN linux-2.6/sound/ppc/tumbler.c linux-source-2.6.15-2.6.15/sound/ppc/tumbler.c
--- linux-2.6/sound/ppc/tumbler.c	2006-01-17 20:19:28.000000000 -0500
+++ linux-source-2.6.15-2.6.15/sound/ppc/tumbler.c	2006-01-18 19:19:00.000000000 -0500
@@ -37,7 +37,9 @@
 #include <asm/irq.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
+
 #include "pmac.h"
+#include "snd-pmac-gpio.h"
 #include "tumbler_volume.h"
 
 #undef DEBUG
@@ -82,23 +84,15 @@
 	VOL_IDX_LAST_MIX
 };
 
-typedef struct pmac_gpio {
-	unsigned int addr;
-	u8 active_val;
-	u8 inactive_val;
-	u8 active_state;
-} pmac_gpio_t;
-
 typedef struct pmac_tumbler_t {
 	pmac_keywest_t i2c;
-	pmac_gpio_t audio_reset;
-	pmac_gpio_t amp_mute;
-	pmac_gpio_t line_mute;
-	pmac_gpio_t line_detect;
-	pmac_gpio_t hp_mute;
-	pmac_gpio_t hp_detect;
-	int headphone_irq;
-	int lineout_irq;
+	snd_pmac_gpio_t audio_reset;
+	snd_pmac_gpio_t amp_mute;
+	snd_pmac_gpio_t line_mute;
+	snd_pmac_gpio_t line_detect;
+	snd_pmac_gpio_t hp_mute;
+	snd_pmac_gpio_t hp_detect;
+
 	unsigned int save_master_vol[2];
 	unsigned int master_vol[2];
 	unsigned int save_master_switch[2];
@@ -163,45 +157,6 @@
 	DBG("(I) snapper init client\n");
 	return send_init_client(i2c, regs);
 }
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
-static void write_audio_gpio(pmac_gpio_t *gp, int active)
-{
-	if (! gp->addr)
-		return;
-	active = active ? gp->active_val : gp->inactive_val;
-	do_gpio_write(gp, active);
-	DBG("(I) gpio %x write %d\n", gp->addr, active);
-}
-
-static int check_audio_gpio(pmac_gpio_t *gp)
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
-static int read_audio_gpio(pmac_gpio_t *gp)
-{
-	int ret;
-	if (! gp->addr)
-		return 0;
-	ret = ((do_gpio_read(gp) & 0x02) !=0);
-	return ret == gp->active_state;
-}
 
 /*
  * update master volume
@@ -680,7 +635,8 @@
 {
 	pmac_t *chip = snd_kcontrol_chip(kcontrol);
 	pmac_tumbler_t *mix;
-	pmac_gpio_t *gp;
+	snd_pmac_gpio_t *gp;
+
 	if (! (mix = chip->mixer_data))
 		return -ENODEV;
 	switch(kcontrol->private_value) {
@@ -695,7 +651,8 @@
 	}
 	if (gp == NULL)
 		return -EINVAL;
-	ucontrol->value.integer.value[0] = !check_audio_gpio(gp);
+
+	ucontrol->value.integer.value[0] = !snd_pmac_gpio_internal_state(gp);
 	return 0;
 }
 
@@ -703,8 +660,7 @@
 {
 	pmac_t *chip = snd_kcontrol_chip(kcontrol);
 	pmac_tumbler_t *mix;
-	pmac_gpio_t *gp;
-	int val;
+	snd_pmac_gpio_t *gp;
 #ifdef PMAC_SUPPORT_AUTOMUTE
 	if (chip->update_automute && chip->auto_mute)
 		return 0; /* don't touch in the auto-mute mode */
@@ -723,9 +679,9 @@
 	}
 	if (gp == NULL)
 		return -EINVAL;
-	val = ! check_audio_gpio(gp);
-	if (val != ucontrol->value.integer.value[0]) {
-		write_audio_gpio(gp, ! ucontrol->value.integer.value[0]);
+
+	if (!snd_pmac_gpio_internal_state(gp) != ucontrol->value.integer.value[0]) {
+		snd_pmac_write_gpio(gp, ! ucontrol->value.integer.value[0]);
 		return 1;
 	}
 	return 0;
@@ -893,7 +849,7 @@
 	int detect = 0;
 
 	if (mix->hp_detect.addr)
-		detect |= read_audio_gpio(&mix->hp_detect);
+		snd_pmac_read_gpio(&mix->hp_detect, &detect);
 	return detect;
 }
 
@@ -903,14 +859,14 @@
 	int detect = 0;
 
 	if (mix->line_detect.addr)
-		detect |= read_audio_gpio(&mix->line_detect);
+		snd_pmac_read_gpio(&mix->line_detect, &detect);
 	return detect;
 }
 
-static void check_mute(pmac_t *chip, pmac_gpio_t *gp, int val, int do_notify, snd_kcontrol_t *sw)
+static void check_mute(pmac_t *chip, snd_pmac_gpio_t *gp, int val, int do_notify, snd_kcontrol_t *sw)
 {
-	if (check_audio_gpio(gp) != val) {
-		write_audio_gpio(gp, val);
+	if (snd_pmac_gpio_internal_state(gp) != val) {
+		snd_pmac_write_gpio(gp, val);
 		if (do_notify)
 			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 				       &sw->id);
@@ -941,7 +897,7 @@
 		if (headphone)
 			check_mute(chip, &mix->hp_mute, 0, mix->auto_mute_notify,
 				   chip->master_sw_ctl);
-		if (lineout && mix->line_mute.addr != 0)
+		if (lineout && snd_pmac_gpio_valid(&mix->line_mute))
 			check_mute(chip, &mix->line_mute, 0, mix->auto_mute_notify,
 				   chip->lineout_sw_ctl);
 		if (mix->anded_reset)
@@ -956,7 +912,7 @@
 			msleep(10);
 		check_mute(chip, &mix->hp_mute, 1, mix->auto_mute_notify,
 			   chip->master_sw_ctl);
-		if (mix->line_mute.addr != 0)
+		if (snd_pmac_gpio_valid(&mix->line_mute))
 			check_mute(chip, &mix->line_mute, 1, mix->auto_mute_notify,
 				   chip->lineout_sw_ctl);
 	}
@@ -993,111 +949,11 @@
 
 
 /* interrupt - headphone plug changed */
-static irqreturn_t headphone_intr(int irq, void *devid, struct pt_regs *regs)
+static void headphone_intr(void *devid)
 {
 	pmac_t *chip = devid;
-	if (chip->update_automute && chip->initialized) {
+	if (chip->update_automute && chip->initialized)
 		chip->update_automute(chip, 1);
-		return IRQ_HANDLED;
-	}
-	return IRQ_NONE;
-}
-
-/* look for audio-gpio device */
-static struct device_node *find_audio_device(const char *name)
-{
-	struct device_node *np;
-  
-	if (! (np = find_devices("gpio")))
-		return NULL;
-  
-	for (np = np->child; np; np = np->sibling) {
-		char *property = get_property(np, "audio-gpio", NULL);
-		if (property && strcmp(property, name) == 0)
-			return np;
-	}  
-	return NULL;
-}
-
-/* look for audio-gpio device */
-static struct device_node *find_compatible_audio_device(const char *name)
-{
-	struct device_node *np;
-  
-	if (! (np = find_devices("gpio")))
-		return NULL;
-  
-	for (np = np->child; np; np = np->sibling) {
-		if (device_is_compatible(np, name))
-			return np;
-	}  
-	return NULL;
-}
-
-/* find an audio device and get its address */
-static long tumbler_find_device(const char *device, const char *platform, pmac_gpio_t *gp, int is_compatible)
-{
-	struct device_node *node;
-	u32 *base, addr;
-
-	if (is_compatible)
-		node = find_compatible_audio_device(device);
-	else
-		node = find_audio_device(device);
-	if (! node) {
-		DBG("(W) cannot find audio device %s !\n", device);
-		snd_printdd("cannot find device %s\n", device);
-		return -ENODEV;
-	}
-
-	base = (u32 *)get_property(node, "AAPL,address", NULL);
-	if (! base) {
-		base = (u32 *)get_property(node, "reg", NULL);
-		if (!base) {
-			DBG("(E) cannot find address for device %s !\n", device);
-			snd_printd("cannot find address for device %s\n", device);
-			return -ENODEV;
-		}
-		addr = *base;
-		if (addr < 0x50)
-			addr += 0x50;
-	} else
-		addr = *base;
-
-	gp->addr = addr & 0x0000ffff;
-	/* Try to find the active state, default to 0 ! */
-	base = (u32 *)get_property(node, "audio-gpio-active-state", NULL);
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
-			prop = (u32 *)get_property(node, platform, NULL);
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
-	    device, gp->addr, gp->active_state);
-
-	return (node->n_intrs > 0) ? node->intrs[0].line : 0;
 }
 
 /* reset audio */
@@ -1107,23 +963,23 @@
 
 	if (mix->anded_reset) {
 		DBG("(I) codec anded reset !\n");
-		write_audio_gpio(&mix->hp_mute, 0);
-		write_audio_gpio(&mix->amp_mute, 0);
+		snd_pmac_write_gpio(&mix->hp_mute, 0);
+		snd_pmac_write_gpio(&mix->amp_mute, 0);
 		msleep(200);
-		write_audio_gpio(&mix->hp_mute, 1);
-		write_audio_gpio(&mix->amp_mute, 1);
+		snd_pmac_write_gpio(&mix->hp_mute, 1);
+		snd_pmac_write_gpio(&mix->amp_mute, 1);
 		msleep(100);
-		write_audio_gpio(&mix->hp_mute, 0);
-		write_audio_gpio(&mix->amp_mute, 0);
+		snd_pmac_write_gpio(&mix->hp_mute, 0);
+		snd_pmac_write_gpio(&mix->amp_mute, 0);
 		msleep(100);
 	} else {
 		DBG("(I) codec normal reset !\n");
 
-		write_audio_gpio(&mix->audio_reset, 0);
+		snd_pmac_write_gpio(&mix->audio_reset, 0);
 		msleep(200);
-		write_audio_gpio(&mix->audio_reset, 1);
+		snd_pmac_write_gpio(&mix->audio_reset, 1);
 		msleep(100);
-		write_audio_gpio(&mix->audio_reset, 0);
+		snd_pmac_write_gpio(&mix->audio_reset, 0);
 		msleep(100);
 	}
 }
@@ -1134,10 +990,6 @@
 {
 	pmac_tumbler_t *mix = chip->mixer_data;
 
-	if (mix->headphone_irq >= 0)
-		disable_irq(mix->headphone_irq);
-	if (mix->lineout_irq >= 0)
-		disable_irq(mix->lineout_irq);
 	mix->save_master_switch[0] = mix->master_switch[0];
 	mix->save_master_switch[1] = mix->master_switch[1];
 	mix->save_master_vol[0] = mix->master_vol[0];
@@ -1145,18 +997,32 @@
 	mix->master_switch[0] = mix->master_switch[1] = 0;
 	tumbler_set_master_volume(mix);
 	if (!mix->anded_reset) {
-		write_audio_gpio(&mix->amp_mute, 1);
-		write_audio_gpio(&mix->hp_mute, 1);
+		snd_pmac_write_gpio(&mix->amp_mute, 1);
+		snd_pmac_write_gpio(&mix->hp_mute, 1);
 	}
 	if (chip->model == PMAC_SNAPPER) {
 		mix->acs |= 1;
 		i2c_smbus_write_byte_data(mix->i2c.client, TAS_REG_ACS, mix->acs);
 	}
 	if (mix->anded_reset) {
-		write_audio_gpio(&mix->amp_mute, 1);
-		write_audio_gpio(&mix->hp_mute, 1);
+		snd_pmac_write_gpio(&mix->amp_mute, 1);
+		snd_pmac_write_gpio(&mix->hp_mute, 1);
 	} else
-		write_audio_gpio(&mix->audio_reset, 1);
+		snd_pmac_write_gpio(&mix->audio_reset, 1);
+}
+
+static void activate_status_interrupts(snd_pmac_gpio_t *gp)
+{
+	int val;
+
+	/* XXX: This is broken with platform functions. We can't write a a
+	 * read function, and this will actuall fail (oops). */
+	return;
+
+	if (snd_pmac_gpio_valid(gp)) {
+		snd_pmac_read_gpio(gp, &val);
+		snd_pmac_write_gpio(gp, val | 0x80);
+	}
 }
 
 /* resume mixer */
@@ -1194,69 +1060,34 @@
 	tumbler_set_master_volume(mix);
 	if (chip->update_automute)
 		chip->update_automute(chip, 0);
-	if (mix->headphone_irq >= 0) {
-		unsigned char val;
 
-		enable_irq(mix->headphone_irq);
-		/* activate headphone status interrupts */
-		val = do_gpio_read(&mix->hp_detect);
-		do_gpio_write(&mix->hp_detect, val | 0x80);
-	}
-	if (mix->lineout_irq >= 0)
-		enable_irq(mix->lineout_irq);
+	activate_status_interrupts(&mix->hp_detect);
 }
 #endif
 
 /* initialize tumbler */
 static int __init tumbler_init(pmac_t *chip)
 {
-	int irq;
+	int ret = 0;
+
 	pmac_tumbler_t *mix = chip->mixer_data;
 	snd_assert(mix, return -EINVAL);
 
-	if (tumbler_find_device("audio-hw-reset",
-				"platform-do-hw-reset",
-				&mix->audio_reset, 0) < 0)
-		tumbler_find_device("hw-reset",
-				    "platform-do-hw-reset",
-				    &mix->audio_reset, 1);
-	if (tumbler_find_device("amp-mute",
-				"platform-do-amp-mute",
-				&mix->amp_mute, 0) < 0)
-		tumbler_find_device("amp-mute",
-				    "platform-do-amp-mute",
-				    &mix->amp_mute, 1);
-	if (tumbler_find_device("headphone-mute",
-				"platform-do-headphone-mute",
-				&mix->hp_mute, 0) < 0)
-		tumbler_find_device("headphone-mute",
-				    "platform-do-headphone-mute",
-				    &mix->hp_mute, 1);
-	if (tumbler_find_device("line-output-mute",
-				"platform-do-lineout-mute",
-				&mix->line_mute, 0) < 0)
-		tumbler_find_device("line-output-mute",
-				   "platform-do-lineout-mute",
-				    &mix->line_mute, 1);
-	irq = tumbler_find_device("headphone-detect",
-				  NULL, &mix->hp_detect, 0);
-	if (irq < 0)
-		irq = tumbler_find_device("headphone-detect",
-					  NULL, &mix->hp_detect, 1);
-	if (irq < 0)
-		irq = tumbler_find_device("keywest-gpio15",
-					  NULL, &mix->hp_detect, 1);
-	mix->headphone_irq = irq;
- 	irq = tumbler_find_device("line-output-detect",
-				  NULL, &mix->line_detect, 0);
- 	if (irq < 0)
-		irq = tumbler_find_device("line-output-detect",
-					  NULL, &mix->line_detect, 1);
-	mix->lineout_irq = irq;
+	ret |= snd_pmac_get_gpio("audio-hw-reset", "hw-reset",
+				 &mix->audio_reset);
+	ret |= snd_pmac_get_gpio("amp-mute", NULL, &mix->amp_mute);
+	ret |= snd_pmac_get_gpio("headphone-mute", NULL, &mix->hp_mute);
+	ret |= snd_pmac_get_gpio("line-output-mute", "lineout-mute",
+				 &mix->line_mute);
+
+	snd_pmac_get_gpio("headphone-detect", "keywest-gpio15",
+			  &mix->hp_detect);
+	snd_pmac_get_gpio("line-output-detect", "lineout-detect",
+			  &mix->line_detect);
 
 	tumbler_reset_audio(chip);
   
-	return 0;
+	return ret;
 }
 
 static void tumbler_cleanup(pmac_t *chip)
@@ -1265,15 +1096,14 @@
 	if (! mix)
 		return;
 
-	if (mix->headphone_irq >= 0)
-		free_irq(mix->headphone_irq, chip);
-	if (mix->lineout_irq >= 0)
-		free_irq(mix->lineout_irq, chip);
-	tumbler_gpio_free(&mix->audio_reset);
-	tumbler_gpio_free(&mix->amp_mute);
-	tumbler_gpio_free(&mix->hp_mute);
-	tumbler_gpio_free(&mix->hp_detect);
+	snd_pmac_free_gpio(&mix->audio_reset);
+	snd_pmac_free_gpio(&mix->amp_mute);
+	snd_pmac_free_gpio(&mix->hp_mute);
+	snd_pmac_free_gpio(&mix->hp_detect);
+	snd_pmac_free_gpio(&mix->line_detect);
+
 	snd_pmac_keywest_cleanup(&mix->i2c);
+
 	kfree(mix);
 	chip->mixer_data = NULL;
 }
@@ -1296,7 +1126,6 @@
 	if (! mix)
 		return -ENOMEM;
 	memset(mix, 0, sizeof(*mix));
-	mix->headphone_irq = -1;
 
 	chip->mixer_data = mix;
 	chip->mixer_free = tumbler_cleanup;
@@ -1367,7 +1196,7 @@
 	chip->speaker_sw_ctl = snd_ctl_new1(&tumbler_speaker_sw, chip);
 	if ((err = snd_ctl_add(chip->card, chip->speaker_sw_ctl)) < 0)
 		return err;
-	if (mix->line_mute.addr != 0) {
+	if (snd_pmac_gpio_valid(&mix->line_mute)) {
 		chip->lineout_sw_ctl = snd_ctl_new1(&tumbler_lineout_sw, chip);
 		if ((err = snd_ctl_add(chip->card, chip->lineout_sw_ctl)) < 0)
 			return err;
@@ -1395,7 +1224,7 @@
 	INIT_WORK(&device_change, device_change_handler, (void *)chip);
 
 #ifdef PMAC_SUPPORT_AUTOMUTE
-	if ((mix->headphone_irq >=0 || mix->lineout_irq >= 0)
+	if ((snd_pmac_gpio_valid(&mix->hp_detect) || snd_pmac_gpio_valid(&mix->line_detect))
 	    && (err = snd_pmac_add_automute(chip)) < 0)
 		return err;
 	chip->detect_headphone = tumbler_detect_headphone;
@@ -1403,23 +1232,15 @@
 	tumbler_update_automute(chip, 0); /* update the status only */
 
 	/* activate headphone status interrupts */
-  	if (mix->headphone_irq >= 0) {
-		unsigned char val;
-		if ((err = request_irq(mix->headphone_irq, headphone_intr, 0,
-				       "Sound Headphone Detection", chip)) < 0)
+  	if (snd_pmac_gpio_valid(&mix->hp_detect)) {
+		if (snd_pmac_request_irq(&mix->hp_detect, headphone_intr, chip) < 0)
 			return 0;
-		/* activate headphone status interrupts */
-		val = do_gpio_read(&mix->hp_detect);
-		do_gpio_write(&mix->hp_detect, val | 0x80);
-	}
-  	if (mix->lineout_irq >= 0) {
-		unsigned char val;
-		if ((err = request_irq(mix->lineout_irq, headphone_intr, 0,
-				       "Sound Lineout Detection", chip)) < 0)
+		activate_status_interrupts(&mix->hp_detect);
+	}
+  	if (snd_pmac_gpio_valid(&mix->line_detect)) {
+		if (snd_pmac_request_irq(&mix->line_detect, headphone_intr, chip) < 0)
 			return 0;
-		/* activate headphone status interrupts */
-		val = do_gpio_read(&mix->line_detect);
-		do_gpio_write(&mix->line_detect, val | 0x80);
+		activate_status_interrupts(&mix->line_detect);
 	}
 #endif
 
