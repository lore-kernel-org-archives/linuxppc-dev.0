Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A84AC67CEF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 23:11:50 +1000 (EST)
Message-Id: <20060607130911.997152000@sipsolutions.net>
References: <20060607130909.584205000@sipsolutions.net>
Date: Wed, 07 Jun 2006 15:09:12 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 03/12] snd-aoa: add aoa core
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

This patch adds the core of aoa, in itself pretty useless, but providing
useful functions to other modules.

--- /dev/null
+++ b/sound/aoa/core/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_SND_AOA) += snd-aoa.o
+snd-aoa-objs := snd-aoa-core.o \
+		snd-aoa-alsa.o \
+		snd-aoa-gpio-pmf.o \
+		snd-aoa-gpio-feature.o
--- /dev/null
+++ b/sound/aoa/core/snd-aoa-core.c
@@ -0,0 +1,156 @@
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
+static int attach_codec_to_fabric(struct aoa_codec *c)
+{
+	int err;
+
+	if (!try_module_get(c->owner))
+		return -EBUSY;
+	/* found_codec has to be assigned */
+	err = -ENOENT;
+	if (fabric->found_codec)
+		err = fabric->found_codec(c);
+	if (err) {
+		module_put(c->owner);
+		printk(KERN_ERR "snd-aoa: fabric didn't like codec %s\n",
+				c->name);
+		return err;
+	}
+	c->fabric = fabric;
+
+	err = 0;
+	if (c->init)
+		err = c->init(c);
+	if (err) {
+		printk(KERN_ERR "snd-aoa: codec %s didn't init\n", c->name);
+		c->fabric = NULL;
+		if (fabric->remove_codec)
+			fabric->remove_codec(c);
+		module_put(c->owner);
+		return err;
+	}
+	if (fabric->attached_codec)
+		fabric->attached_codec(c);
+	return 0;
+}
+
+int aoa_codec_register(struct aoa_codec *codec)
+{
+	list_add(&codec->list, &codec_list);
+	if (fabric)
+		return attach_codec_to_fabric(codec);
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
+	if (err)
+		return err;
+
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
+		printk(KERN_ERR "snd-aoa: fabric unassigned "
+				"in aoa_fabric_unlink_codec\n");
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
@@ -0,0 +1,246 @@
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
+static void pmf_handle_notify(void *data)
+{
+	struct gpio_notification *notif = data;
+
+	mutex_lock(&notif->mutex);
+	if (notif->notify)
+		notif->notify(notif->data);
+	mutex_unlock(&notif->mutex);
+}
+
+static void pmf_gpio_init(struct gpio_runtime *rt)
+{
+	pmf_gpio_all_amps_off(rt);
+	rt->implementation_private = 0;
+	INIT_WORK(&rt->headphone_notify.work, pmf_handle_notify,
+		  &rt->headphone_notify);
+	INIT_WORK(&rt->line_in_notify.work, pmf_handle_notify,
+		  &rt->line_in_notify);
+	INIT_WORK(&rt->line_out_notify.work, pmf_handle_notify,
+		  &rt->line_out_notify);
+	mutex_init(&rt->headphone_notify.mutex);
+	mutex_init(&rt->line_in_notify.mutex);
+	mutex_init(&rt->line_out_notify.mutex);
+}
+
+static void pmf_gpio_exit(struct gpio_runtime *rt)
+{
+	pmf_gpio_all_amps_off(rt);
+	rt->implementation_private = 0;
+
+	if (rt->headphone_notify.gpio_private)
+		pmf_unregister_irq_client(rt->headphone_notify.gpio_private);
+	if (rt->line_in_notify.gpio_private)
+		pmf_unregister_irq_client(rt->line_in_notify.gpio_private);
+	if (rt->line_out_notify.gpio_private)
+		pmf_unregister_irq_client(rt->line_out_notify.gpio_private);
+
+	/* make sure no work is pending before freeing
+	 * all things */
+	cancel_delayed_work(&rt->headphone_notify.work);
+	cancel_delayed_work(&rt->line_in_notify.work);
+	cancel_delayed_work(&rt->line_out_notify.work);
+	flush_scheduled_work();
+
+	mutex_destroy(&rt->headphone_notify.mutex);
+	mutex_destroy(&rt->line_in_notify.mutex);
+	mutex_destroy(&rt->line_out_notify.mutex);
+
+	if (rt->headphone_notify.gpio_private)
+		kfree(rt->headphone_notify.gpio_private);
+	if (rt->line_in_notify.gpio_private)
+		kfree(rt->line_in_notify.gpio_private);
+	if (rt->line_out_notify.gpio_private)
+		kfree(rt->line_out_notify.gpio_private);
+}
+
+void pmf_handle_notify_irq(void *data)
+{
+	struct gpio_notification *notif = data;
+
+	schedule_work(&notif->work);
+}
+
+static int pmf_set_notify(struct gpio_runtime *rt,
+			  enum notify_type type,
+			  notify_func_t notify,
+			  void *data)
+{
+	struct gpio_notification *notif;
+	notify_func_t old;
+	struct pmf_irq_client *irq_client;
+	char *name;
+	int err = -EBUSY;
+
+	switch (type) {
+	case AOA_NOTIFY_HEADPHONE:
+		notif = &rt->headphone_notify;
+		name = "headphone-detect";
+		break;
+	case AOA_NOTIFY_LINE_IN:
+		notif = &rt->line_in_notify;
+		name = "linein-detect";
+		break;
+	case AOA_NOTIFY_LINE_OUT:
+		notif = &rt->line_out_notify;
+		name = "lineout-detect";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&notif->mutex);
+
+	old = notif->notify;
+
+	if (!old && !notify) {
+		err = 0;
+		goto out_unlock;
+	}
+
+	if (old && notify) {
+		if (old == notify && notif->data == data)
+			err = 0;
+		goto out_unlock;
+	}
+
+	if (old && !notify) {
+		irq_client = notif->gpio_private;
+		pmf_unregister_irq_client(irq_client);
+		kfree(irq_client);
+		notif->gpio_private = NULL;
+	}
+	if (!old && notify) {
+		irq_client = kzalloc(sizeof(struct pmf_irq_client),
+				     GFP_KERNEL);
+		irq_client->data = notif;
+		irq_client->handler = pmf_handle_notify_irq;
+		irq_client->owner = THIS_MODULE;
+		err = pmf_register_irq_client(rt->node,
+					      name,
+					      irq_client);
+		if (err) {
+			printk(KERN_ERR "snd-aoa: gpio layer failed to"
+					" register %s irq (%d)\n", name, err);
+			kfree(irq_client);
+			goto out_unlock;
+		}
+		notif->gpio_private = irq_client;
+	}
+	notif->notify = notify;
+	notif->data = data;
+
+	err = 0;
+ out_unlock:
+	mutex_unlock(&notif->mutex);
+	return err;
+}
+
+static int pmf_get_detect(struct gpio_runtime *rt,
+			  enum notify_type type)
+{
+	char *name;
+	int err = -EBUSY, ret;
+	struct pmf_args args = { .count = 1, .u[0].p = &ret };
+
+	switch (type) {
+	case AOA_NOTIFY_HEADPHONE:
+		name = "headphone-detect";
+		break;
+	case AOA_NOTIFY_LINE_IN:
+		name = "linein-detect";
+		break;
+	case AOA_NOTIFY_LINE_OUT:
+		name = "lineout-detect";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = pmf_call_function(rt->node, name, &args);
+	if (err)
+		return err;
+	return ret;
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
+	.set_notify		= pmf_set_notify,
+	.get_detect		= pmf_get_detect,
+};
+
+struct gpio_methods *pmf_gpio_methods = &methods;
+EXPORT_SYMBOL_GPL(pmf_gpio_methods);
--- /dev/null
+++ b/sound/aoa/core/snd-aoa-gpio-feature.c
@@ -0,0 +1,392 @@
+/*
+ * Apple Onboard Audio feature call GPIO control
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ *
+ * This file contains the GPIO control routines for 
+ * direct (through feature calls) access to the GPIO
+ * registers.
+ */
+
+#include <asm/pmac_feature.h>
+#include <linux/interrupt.h>
+#include "../aoa.h"
+
+/* TODO: these are 20 global variables
+ * that aren't used on most machines...
+ * Move them into a dynamically allocated
+ * structure and use that.
+ */
+
+/* these are the GPIO numbers (register addresses as offsets into
+ * the GPIO space) */
+static int headphone_mute_gpio;
+static int amp_mute_gpio;
+static int lineout_mute_gpio;
+static int hw_reset_gpio;
+static int lineout_detect_gpio;
+static int headphone_detect_gpio;
+static int linein_detect_gpio;
+
+/* see the SWITCH_GPIO macro */
+static int headphone_mute_gpio_activestate;
+static int amp_mute_gpio_activestate;
+static int lineout_mute_gpio_activestate;
+static int hw_reset_gpio_activestate;
+static int lineout_detect_gpio_activestate;
+static int headphone_detect_gpio_activestate;
+static int linein_detect_gpio_activestate;
+
+/* node pointers that we save when getting the GPIO number
+ * to get the interrupt later */
+static struct device_node *lineout_detect_node;
+static struct device_node *linein_detect_node;
+static struct device_node *headphone_detect_node;
+
+static int lineout_detect_irq;
+static int linein_detect_irq;
+static int headphone_detect_irq;
+
+static struct device_node *get_gpio(
+	char *name, char *altname, int *gpioptr, int *gpioactiveptr)
+{
+	struct device_node *np, *gpio;
+	u32 *reg;
+	char *audio_gpio;
+
+	*gpioptr = -1;
+
+	/* check if we can get it the easy way ... */
+	np = of_find_node_by_name(NULL, name);
+	if (!np) {
+		/* some machines have only gpioX/extint-gpioX nodes,
+		 * and an audio-gpio property saying what it is ...
+		 * So what we have to do is enumerate all children
+		 * of the gpio node and check them all. */
+		gpio = of_find_node_by_name(NULL, "gpio");
+		if (!gpio)
+			return NULL;
+		while ((np = of_get_next_child(gpio, np))) {
+			audio_gpio = get_property(np, "audio-gpio", NULL);
+			if (!audio_gpio)
+				continue;
+			if (strcmp(audio_gpio, name) == 0)
+				break;
+			if (altname && (strcmp(audio_gpio, altname) == 0))
+				break;
+		}
+		/* still not found, assume not there */
+		if (!np)
+			return NULL;
+	}
+
+	reg = (u32 *)get_property(np, "reg", NULL);
+	if (!reg)
+		return NULL;
+
+	*gpioptr = *reg;
+
+	/* this is a hack, usually the GPIOs 'reg' property
+	 * should have the offset based from the GPIO space
+	 * which is at 0x50, but apparently not always... */
+	if (*gpioptr < 0x50)
+		*gpioptr += 0x50;
+
+	reg = (u32 *)get_property(np, "audio-gpio-active-state", NULL);
+	if (!reg)
+		/* Apple seems to default to 1, but
+		 * that doesn't seem right at least on most
+		 * machines. So until proven that the opposite
+		 * is necessary, we default to 0
+		 * (which, incidentally, snd-powermac also does...) */
+		*gpioactiveptr = 0;
+	else
+		*gpioactiveptr = *reg;
+
+	return np;
+}
+
+static void get_irq(struct device_node * np, int *irqptr)
+{
+	*irqptr = -1;
+	if (!np)
+		return;
+	if (np->n_intrs != 1)
+		return;
+	*irqptr = np->intrs[0].line;
+}
+
+/* 0x4 is outenable, 0x1 is out, thus 4 or 5 */
+#define SWITCH_GPIO(name, v, on)				\
+	(((v)&~1) | ((on)?					\
+			(name##_gpio_activestate==0?4:5):	\
+			(name##_gpio_activestate==0?5:4)))
+
+#define FTR_GPIO(name, bit)					\
+static void ftr_gpio_set_##name(struct gpio_runtime *rt, int on)\
+{								\
+	int v;							\
+								\
+	if (unlikely(!rt)) return;				\
+								\
+	if (name##_mute_gpio < 0)				\
+		return;						\
+								\
+	v = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL,		\
+			      name##_mute_gpio,			\
+			      0);				\
+								\
+	/* muted = !on... */					\
+	v = SWITCH_GPIO(name##_mute, v, !on);			\
+								\
+	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,		\
+			  name##_mute_gpio, v);			\
+								\
+	rt->implementation_private &= ~(1<<bit);		\
+	rt->implementation_private |= (!!on << bit);		\
+}								\
+static int ftr_gpio_get_##name(struct gpio_runtime *rt)		\
+{								\
+	if (unlikely(!rt)) return 0;				\
+	return (rt->implementation_private>>bit)&1;		\
+}
+
+FTR_GPIO(headphone, 0);
+FTR_GPIO(amp, 1);
+FTR_GPIO(lineout, 2);
+
+static void ftr_gpio_set_hw_reset(struct gpio_runtime *rt, int on)
+{
+	int v;
+
+	if (unlikely(!rt)) return;
+	if (hw_reset_gpio < 0)
+		return;
+
+	v = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL,
+			      hw_reset_gpio, 0);
+	v = SWITCH_GPIO(hw_reset, v, on);
+	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL,
+			  hw_reset_gpio, v);
+}
+
+static void ftr_gpio_all_amps_off(struct gpio_runtime *rt)
+{
+	int saved;
+
+	if (unlikely(!rt)) return;
+	saved = rt->implementation_private;
+	ftr_gpio_set_headphone(rt, 0);
+	ftr_gpio_set_amp(rt, 0);
+	ftr_gpio_set_lineout(rt, 0);
+	rt->implementation_private = saved;
+}
+
+static void ftr_gpio_all_amps_restore(struct gpio_runtime *rt)
+{
+	int s;
+
+	if (unlikely(!rt)) return;
+	s = rt->implementation_private;
+	ftr_gpio_set_headphone(rt, (s>>0)&1);
+	ftr_gpio_set_amp(rt, (s>>1)&1);
+	ftr_gpio_set_lineout(rt, (s>>2)&1);
+}
+
+static void ftr_handle_notify(void *data)
+{
+	struct gpio_notification *notif = data;
+
+	mutex_lock(&notif->mutex);
+	if (notif->notify)
+		notif->notify(notif->data);
+	mutex_unlock(&notif->mutex);
+}
+
+static void ftr_gpio_init(struct gpio_runtime *rt)
+{
+	get_gpio("headphone-mute", NULL,
+		 &headphone_mute_gpio,
+		 &headphone_mute_gpio_activestate);
+	get_gpio("amp-mute", NULL,
+		 &amp_mute_gpio,
+		 &amp_mute_gpio_activestate);
+	get_gpio("lineout-mute", NULL,
+		 &lineout_mute_gpio,
+		 &lineout_mute_gpio_activestate);
+	get_gpio("hw-reset", "audio-hw-reset",
+		 &hw_reset_gpio,
+		 &hw_reset_gpio_activestate);
+
+	headphone_detect_node = get_gpio("headphone-detect", NULL,
+					 &headphone_detect_gpio,
+					 &headphone_detect_gpio_activestate);
+	/* go Apple, and thanks for giving these different names
+	 * across the board... */
+	lineout_detect_node = get_gpio("lineout-detect", "line-output-detect",
+				       &lineout_detect_gpio,
+				       &lineout_detect_gpio_activestate);
+	linein_detect_node = get_gpio("linein-detect", "line-input-detect",
+				      &linein_detect_gpio,
+				      &linein_detect_gpio_activestate);
+
+	get_irq(headphone_detect_node, &headphone_detect_irq);
+	get_irq(lineout_detect_node, &lineout_detect_irq);
+	get_irq(linein_detect_node, &linein_detect_irq);
+
+	ftr_gpio_all_amps_off(rt);
+	rt->implementation_private = 0;
+	INIT_WORK(&rt->headphone_notify.work, ftr_handle_notify,
+		  &rt->headphone_notify);
+	INIT_WORK(&rt->line_in_notify.work, ftr_handle_notify,
+		  &rt->line_in_notify);
+	INIT_WORK(&rt->line_out_notify.work, ftr_handle_notify,
+		  &rt->line_out_notify);
+	mutex_init(&rt->headphone_notify.mutex);
+	mutex_init(&rt->line_in_notify.mutex);
+	mutex_init(&rt->line_out_notify.mutex);
+}
+
+static void ftr_gpio_exit(struct gpio_runtime *rt)
+{
+	ftr_gpio_all_amps_off(rt);
+	rt->implementation_private = 0;
+	if (rt->headphone_notify.notify)
+		free_irq(headphone_detect_irq, &rt->headphone_notify);
+	if (rt->line_in_notify.gpio_private)
+		free_irq(linein_detect_irq, &rt->line_in_notify);
+	if (rt->line_out_notify.gpio_private)
+		free_irq(lineout_detect_irq, &rt->line_out_notify);
+	cancel_delayed_work(&rt->headphone_notify.work);
+	cancel_delayed_work(&rt->line_in_notify.work);
+	cancel_delayed_work(&rt->line_out_notify.work);
+	flush_scheduled_work();
+	mutex_destroy(&rt->headphone_notify.mutex);
+	mutex_destroy(&rt->line_in_notify.mutex);
+	mutex_destroy(&rt->line_out_notify.mutex);
+}
+
+irqreturn_t ftr_handle_notify_irq(int xx, void *data, struct pt_regs *regs)
+{
+	struct gpio_notification *notif = data;
+
+	schedule_work(&notif->work);
+
+	return IRQ_HANDLED;
+}
+
+static int ftr_set_notify(struct gpio_runtime *rt,
+			  enum notify_type type,
+			  notify_func_t notify,
+			  void *data)
+{
+	struct gpio_notification *notif;
+	notify_func_t old;
+	int irq;
+	char *name;
+	int err = -EBUSY;
+
+	switch (type) {
+	case AOA_NOTIFY_HEADPHONE:
+		notif = &rt->headphone_notify;
+		name = "headphone-detect";
+		irq = headphone_detect_irq;
+		break;
+	case AOA_NOTIFY_LINE_IN:
+		notif = &rt->line_in_notify;
+		name = "linein-detect";
+		irq = linein_detect_irq;
+		break;
+	case AOA_NOTIFY_LINE_OUT:
+		notif = &rt->line_out_notify;
+		name = "lineout-detect";
+		irq = lineout_detect_irq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (irq == -1)
+		return -ENODEV;
+
+	mutex_lock(&notif->mutex);
+
+	old = notif->notify;
+
+	if (!old && !notify) {
+		err = 0;
+		goto out_unlock;
+	}
+
+	if (old && notify) {
+		if (old == notify && notif->data == data)
+			err = 0;
+		goto out_unlock;
+	}
+
+	if (old && !notify) {
+		free_irq(irq, notif);
+	}
+	if (!old && notify) {
+		request_irq(irq, ftr_handle_notify_irq, 0, name, notif);
+	}
+	notif->notify = notify;
+	notif->data = data;
+
+	err = 0;
+ out_unlock:
+	mutex_unlock(&notif->mutex);
+	return err;
+}
+
+static int ftr_get_detect(struct gpio_runtime *rt,
+			  enum notify_type type)
+{
+	int gpio, ret, active;
+
+	switch (type) {
+	case AOA_NOTIFY_HEADPHONE:
+		gpio = headphone_detect_gpio;
+		active = headphone_detect_gpio_activestate;
+		break;
+	case AOA_NOTIFY_LINE_IN:
+		gpio = linein_detect_gpio;
+		active = linein_detect_gpio_activestate;
+		break;
+	case AOA_NOTIFY_LINE_OUT:
+		gpio = lineout_detect_gpio;
+		active = lineout_detect_gpio_activestate;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (gpio == -1)
+		return -ENODEV;
+
+	ret = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, gpio, 0);
+	if (ret < 0)
+		return ret;
+	return ((ret >> 1) & 1) == active;
+}
+
+static struct gpio_methods methods = {
+	.init			= ftr_gpio_init,
+	.exit			= ftr_gpio_exit,
+	.all_amps_off		= ftr_gpio_all_amps_off,
+	.all_amps_restore	= ftr_gpio_all_amps_restore,
+	.set_headphone		= ftr_gpio_set_headphone,
+	.set_speakers		= ftr_gpio_set_amp,
+	.set_lineout		= ftr_gpio_set_lineout,
+	.set_hw_reset		= ftr_gpio_set_hw_reset,
+	.get_headphone		= ftr_gpio_get_headphone,
+	.get_speakers		= ftr_gpio_get_amp,
+	.get_lineout		= ftr_gpio_get_lineout,
+	.set_notify		= ftr_set_notify,
+	.get_detect		= ftr_get_detect,
+};
+
+struct gpio_methods *ftr_gpio_methods = &methods;
+EXPORT_SYMBOL_GPL(ftr_gpio_methods);
--- /dev/null
+++ b/sound/aoa/core/snd-aoa-alsa.h
@@ -0,0 +1,16 @@
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
+#include "../aoa.h"
+
+extern int aoa_alsa_init(char *name, struct module *mod);
+extern void aoa_alsa_cleanup(void);
+
+#endif /* __SND_AOA_ALSA_H */
--- /dev/null
+++ b/sound/aoa/core/snd-aoa-alsa.c
@@ -0,0 +1,98 @@
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
+static int index = -1;
+module_param(index, int, 0444);
+MODULE_PARM_DESC(index, "index for AOA sound card.");
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
+	alsa_card = snd_card_new(index, name, mod, sizeof(struct aoa_card));
+	if (!alsa_card)
+		return -ENOMEM;
+	aoa_card = alsa_card->private_data;
+	aoa_card->alsa_card = alsa_card;
+	strlcpy(alsa_card->driver, "AppleOnbdAudio", sizeof(alsa_card->driver));
+	strlcpy(alsa_card->shortname, name, sizeof(alsa_card->shortname));
+	strlcpy(alsa_card->longname, name, sizeof(alsa_card->longname));
+	strlcpy(alsa_card->mixername, name, sizeof(alsa_card->mixername));
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
+		printk(KERN_ERR "snd-aoa: failed to register "
+				"snd device (%d)\n", err);
+		printk(KERN_ERR "snd-aoa: have you forgotten the "
+				"dev_register callback?\n");
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
+		printk(KERN_ERR "snd-aoa: failed to add alsa control (%d)\n",
+		       err);
+	return err;
+}
+EXPORT_SYMBOL_GPL(aoa_snd_ctl_add);

--
