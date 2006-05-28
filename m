Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EC1C67A63
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 05:02:46 +1000 (EST)
Message-Id: <20060528190124.579130000@johannes.berg>
References: <20060528190026.754474000@johannes.berg>
Date: Sun, 28 May 2006 21:00:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 2/7] snd-aoa: add aoa core
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

This patch adds the core of aoa, in itself pretty useless, but providing
useful functions to other modules.

--- /dev/null
+++ b/sound/aoa/core/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_SND_AOA) += snd-aoa.o
+snd-aoa-objs := snd-aoa-core.o \
+		snd-aoa-alsa.o \
+		snd-aoa-gpio-pmf.o
--- /dev/null
+++ b/sound/aoa/core/snd-aoa-alsa.c
@@ -0,0 +1,91 @@
+/*
+ * Apple Onboard Audio Alsa helpers
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+#include <linux/module.h>
+#include "snd-aoa-alsa.h"
+
+static struct aoa_card *aoa_card;
+
+int aoa_alsa_init(char *name, struct module *mod)
+{
+	struct snd_card *alsa_card;
+	int err;
+
+	if (aoa_card)
+		/* cannot be EEXIST due to usage in aoa_fabric_register */
+		return -EBUSY;
+
+	alsa_card = snd_card_new(-1, name, mod, sizeof(struct aoa_card));
+	if (!alsa_card)
+		return -ENOMEM;
+	aoa_card = alsa_card->private_data;
+	aoa_card->alsa_card = alsa_card;
+	strncpy(alsa_card->driver, "AppleOnbdAudio", sizeof(alsa_card->driver));
+	strncpy(alsa_card->shortname, name, sizeof(alsa_card->shortname));
+	strncpy(alsa_card->longname, name, sizeof(alsa_card->longname));
+	strncpy(alsa_card->mixername, name, sizeof(alsa_card->mixername));
+	err = snd_card_register(aoa_card->alsa_card);
+	if (err < 0) {
+		printk(KERN_ERR "snd-aoa: couldn't register alsa card\n");
+		snd_card_free(aoa_card->alsa_card);
+		aoa_card = NULL;
+		return err;
+	}
+	return 0;
+}
+
+struct snd_card *aoa_get_card(void)
+{
+	if (aoa_card)
+		return aoa_card->alsa_card;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(aoa_get_card);
+
+void aoa_alsa_cleanup(void)
+{
+	if (aoa_card) {
+		snd_card_free(aoa_card->alsa_card);
+		aoa_card = NULL;
+	}
+}
+
+int aoa_snd_device_new(snd_device_type_t type,
+        void * device_data, struct snd_device_ops * ops)
+{
+	struct snd_card *card = aoa_get_card();
+	int err;
+	
+	if (!card) return -ENOMEM;
+
+	err = snd_device_new(card, type, device_data, ops);
+	if (err) {
+		printk(KERN_ERR "snd-aoa: failed to create snd device (%d)\n", err);
+		return err;
+	}
+	err = snd_device_register(card, device_data);
+	if (err) {
+		printk(KERN_ERR "snd-aoa: failed to register snd device (%d)\n", err);
+		printk(KERN_ERR "snd-aoa: have you forgotten the dev_register callback?\n");
+		snd_device_free(card, device_data);
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(aoa_snd_device_new);
+
+int aoa_snd_ctl_add(struct snd_kcontrol* control)
+{
+	int err;
+
+	if (!aoa_card) return -ENODEV;
+
+	err = snd_ctl_add(aoa_card->alsa_card, control);
+	if (err)
+		printk(KERN_ERR "snd-aoa: failed to add alsa control (%d)\n", err);
+	return err;
+}
+EXPORT_SYMBOL_GPL(aoa_snd_ctl_add);
--- /dev/null
+++ b/sound/aoa/core/snd-aoa-alsa.h
@@ -0,0 +1,17 @@
+/*
+ * Apple Onboard Audio Alsa private helpers
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+
+#ifndef __SND_AOA_ALSA_H
+#define __SND_AOA_ALSA_H
+/* FIXME */
+#include "../aoa.h"
+
+extern int aoa_alsa_init(char *name, struct module *mod);
+extern void aoa_alsa_cleanup(void);
+
+#endif /* __SND_AOA_ALSA_H */
--- /dev/null
+++ b/sound/aoa/core/snd-aoa-core.c
@@ -0,0 +1,153 @@
+/*
+ * Apple Onboard Audio driver core
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include "../aoa.h"
+#include "snd-aoa-alsa.h"
+
+MODULE_DESCRIPTION("Apple Onboard Audio Sound Driver");
+MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_LICENSE("GPL");
+
+/* We allow only one fabric. This simplifies things,
+ * and more don't really make that much sense */
+static struct aoa_fabric *fabric;
+static LIST_HEAD(codec_list);
+
+static void attach_codec_to_fabric(struct aoa_codec *c)
+{
+	int err;
+
+	if (!try_module_get(c->owner))
+		return;
+	/* found_codec has to be assigned */
+	err = -ENOENT;
+	if (fabric->found_codec)
+		err = fabric->found_codec(c);
+	if (err) {
+		module_put(c->owner);
+		printk("snd-aoa: fabric didn't like codec %s\n", c->name);
+		return;
+	}
+	c->fabric = fabric;
+
+	err = 0;
+	if (c->init)
+		err = c->init(c);
+	if (err) {
+		printk("snd-aoa: codec %s didn't init\n", c->name);
+		c->fabric = NULL;
+		if (fabric->remove_codec)
+			fabric->remove_codec(c);
+		module_put(c->owner);
+		return;
+	}
+	if (fabric->attached_codec)
+		fabric->attached_codec(c);
+}
+
+int aoa_codec_register(struct aoa_codec *codec)
+{
+	list_add(&codec->list, &codec_list);
+	if (fabric)
+		attach_codec_to_fabric(codec);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aoa_codec_register);
+
+void aoa_codec_unregister(struct aoa_codec *codec)
+{
+	list_del(&codec->list);
+	if (codec->fabric && codec->exit)
+		codec->exit(codec);
+	if (fabric && fabric->remove_codec)
+		fabric->remove_codec(codec);
+	codec->fabric = NULL;
+	module_put(codec->owner);
+}
+EXPORT_SYMBOL_GPL(aoa_codec_unregister);
+
+int aoa_fabric_register(struct aoa_fabric *new_fabric)
+{
+	struct aoa_codec *c;
+	int err;
+
+	/* allow querying for presence of fabric
+	 * (i.e. do this test first!) */
+	if (new_fabric == fabric) {
+		err = -EALREADY;
+		goto attach;
+	}
+	if (fabric)
+		return -EEXIST;
+	if (!new_fabric)
+		return -EINVAL;
+
+	err = aoa_alsa_init(new_fabric->name, new_fabric->owner);
+	if (err) {
+		return err;
+	}
+	fabric = new_fabric;
+
+ attach:
+	list_for_each_entry(c, &codec_list, list) {
+		if (c->fabric != fabric)
+			attach_codec_to_fabric(c);
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(aoa_fabric_register);
+
+void aoa_fabric_unregister(struct aoa_fabric *old_fabric)
+{
+	struct aoa_codec *c;
+
+	if (fabric != old_fabric)
+		return;
+
+	list_for_each_entry(c, &codec_list, list) {
+		if (c->fabric)
+			aoa_fabric_unlink_codec(c);
+	}
+
+	aoa_alsa_cleanup();
+
+	fabric = NULL;
+}
+EXPORT_SYMBOL_GPL(aoa_fabric_unregister);
+
+void aoa_fabric_unlink_codec(struct aoa_codec *codec)
+{
+	if (!codec->fabric) {
+		printk(KERN_ERR "snd-aoa: fabric unassigned in aoa_fabric_unlink_codec\n");
+		dump_stack();
+		return;
+	}
+	if (codec->exit)
+		codec->exit(codec);
+	if (codec->fabric->remove_codec)
+		codec->fabric->remove_codec(codec);
+	codec->fabric = NULL;
+	module_put(codec->owner);
+}
+EXPORT_SYMBOL_GPL(aoa_fabric_unlink_codec);
+
+static int __init aoa_init(void)
+{
+	return 0;
+}
+
+static void __exit aoa_exit(void)
+{
+	aoa_alsa_cleanup();
+}
+
+module_init(aoa_init);
+module_exit(aoa_exit);
--- /dev/null
+++ b/sound/aoa/core/snd-aoa-gpio-pmf.c
@@ -0,0 +1,91 @@
+/*
+ * Apple Onboard Audio pmf GPIOs
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+
+#include <asm/pmac_feature.h>
+#include <asm/pmac_pfunc.h>
+#include "../aoa.h"
+
+#define PMF_GPIO(name, bit)					\
+static void pmf_gpio_set_##name(struct gpio_runtime *rt, int on)\
+{								\
+	struct pmf_args args = { .count = 1, .u[0].v = !on };	\
+								\
+	if (unlikely(!rt)) return;				\
+	pmf_call_function(rt->node, #name "-mute", &args);	\
+	rt->implementation_private &= ~(1<<bit);		\
+	rt->implementation_private |= (!!on << bit);		\
+}								\
+static int pmf_gpio_get_##name(struct gpio_runtime *rt)		\
+{								\
+	if (unlikely(!rt)) return 0;				\
+	return (rt->implementation_private>>bit)&1;		\
+}
+
+PMF_GPIO(headphone, 0);
+PMF_GPIO(amp, 1);
+PMF_GPIO(lineout, 2);
+
+static void pmf_gpio_set_hw_reset(struct gpio_runtime *rt, int on)
+{
+	struct pmf_args args = { .count = 1, .u[0].v = !!on };
+
+	if (unlikely(!rt)) return;
+	pmf_call_function(rt->node, "hw-reset", &args);
+}
+
+static void pmf_gpio_all_amps_off(struct gpio_runtime *rt)
+{
+	int saved;
+
+	if (unlikely(!rt)) return;
+	saved = rt->implementation_private;
+	pmf_gpio_set_headphone(rt, 0);
+	pmf_gpio_set_amp(rt, 0);
+	pmf_gpio_set_lineout(rt, 0);
+	rt->implementation_private = saved;
+}
+
+static void pmf_gpio_all_amps_restore(struct gpio_runtime *rt)
+{
+	int s;
+
+	if (unlikely(!rt)) return;
+	s = rt->implementation_private;
+	pmf_gpio_set_headphone(rt, (s>>0)&1);
+	pmf_gpio_set_amp(rt, (s>>1)&1);
+	pmf_gpio_set_lineout(rt, (s>>2)&1);
+}
+
+static void pmf_gpio_init(struct gpio_runtime *rt)
+{
+	pmf_gpio_all_amps_off(rt);
+	rt->implementation_private = 0;
+}
+
+static void pmf_gpio_exit(struct gpio_runtime *rt)
+{
+	pmf_gpio_all_amps_off(rt);
+	rt->implementation_private = 0;
+}
+
+static struct gpio_methods methods = {
+	.init			= pmf_gpio_init,
+	.exit			= pmf_gpio_exit,
+	.all_amps_off		= pmf_gpio_all_amps_off,
+	.all_amps_restore	= pmf_gpio_all_amps_restore,
+	.set_headphone		= pmf_gpio_set_headphone,
+	.set_speakers		= pmf_gpio_set_amp,
+	.set_lineout		= pmf_gpio_set_lineout,
+	.set_hw_reset		= pmf_gpio_set_hw_reset,
+	.get_headphone		= pmf_gpio_get_headphone,
+	.get_speakers		= pmf_gpio_get_amp,
+	.get_lineout		= pmf_gpio_get_lineout,
+};
+
+struct gpio_methods *pmf_gpio_methods = &methods;
+EXPORT_SYMBOL_GPL(pmf_gpio_methods);

--
