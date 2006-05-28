Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C3E167A60
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 05:02:46 +1000 (EST)
Message-Id: <20060528190129.503400000@johannes.berg>
References: <20060528190026.754474000@johannes.berg>
Date: Sun, 28 May 2006 21:00:31 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 5/7] snd-aoa: add layout-id fabric
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

The 'fabric' is the thing that pulls all of snd-aoa together, this patch
adds the 'layout' or 'layout-id' fabric that keys off the 'layout-id'
property in the device-tree to pull in the proper modules. It itself loads
if an i2sbus is present with a layout-id (exported in modalias) that it can
use.

--- /dev/null
+++ b/sound/aoa/fabrics/Kconfig
@@ -0,0 +1,12 @@
+config SND_AOA_FABRIC_LAYOUT
+	tristate "layout-id fabric"
+	depends SND_AOA
+	select SND_AOA_SOUNDBUS
+	select SND_AOA_SOUNDBUS_I2S
+	---help---
+	This enables the layout-id fabric for the Apple Onboard
+	Audio driver, the module holding it all together
+	based on the device-tree's layout-id property.
+	
+	If you are unsure and have a later Apple machine,
+	compile it as a module.
--- /dev/null
+++ b/sound/aoa/fabrics/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SND_AOA_FABRIC_LAYOUT) += snd-aoa-fabric-layout.o
--- /dev/null
+++ b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
@@ -0,0 +1,605 @@
+/*
+ * Apple Onboard Audio driver -- layout fabric
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ *
+ *
+ * This fabric module looks for sound codecs
+ * based on the layout-id property in the device tree.
+ *
+ */
+
+#include <asm/prom.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include "../aoa.h"
+#include "../soundbus/soundbus.h"
+
+MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Layout-ID fabric for snd-aoa");
+
+#define MAX_CODECS_PER_BUS	2
+
+/* These are the connections the layout fabric
+ * knows about. It doesn't really care about the
+ * input ones, but I thought I'd separate them
+ * to give them proper names. The thing is that
+ * Apple usually will distinguish the active output
+ * by GPIOs, while the active input is set directly
+ * on the codec. Hence we here tell the codec what
+ * we think is connected. This information is hard-
+ * coded below ... */
+#define CC_SPEAKERS	(1<<0)
+#define CC_HEADPHONE	(1<<1)
+#define CC_LINEOUT	(1<<2)
+#define CC_DIGITALOUT	(1<<3)
+#define CC_LINEIN	(1<<4)
+#define CC_MICROPHONE	(1<<5)
+#define CC_DIGITALIN	(1<<6)
+/* pretty bogus but users complain...
+ * This is a flag saying that the LINEOUT
+ * should be renamed to HEADPHONE.
+ * be careful with input detection! */
+#define CC_LINEOUT_LABELLED_HEADPHONE	(1<<7)
+
+struct codec_connection {
+	/* CC_ flags from above */
+	int connected;
+	/* codec dependent bit to be set in the aoa_codec.connected field.
+	 * This intentionally doesn't have any generic flags because the
+	 * fabric has to know the codec anyway and all codecs might have
+	 * different connectors */
+	int codec_bit;
+};
+
+struct codec_connect_info {
+	char *name;
+	struct codec_connection *connections;
+};
+
+#define LAYOUT_FLAG_COMBO_LINEOUT_SPDIF	(1<<0)
+
+struct layout {
+	unsigned int layout_id;
+	struct codec_connect_info codecs[MAX_CODECS_PER_BUS];
+	int flags;
+	
+	/* if busname is not assigned, we use 'Master' below,
+	 * so that our layout table doesn't need to be filled
+	 * too much.
+	 * We only assign these two if we expect to find more
+	 * than one soundbus, i.e. on those machines with
+	 * multiple layout-ids */
+	char *busname;
+	int pcmid;
+};
+
+MODULE_ALIAS("sound-layout-82");
+MODULE_ALIAS("sound-layout-45");
+MODULE_ALIAS("sound-layout-64");
+MODULE_ALIAS("sound-layout-65");
+MODULE_ALIAS("sound-layout-68");
+MODULE_ALIAS("sound-layout-69");
+MODULE_ALIAS("sound-layout-70");
+MODULE_ALIAS("sound-layout-72");
+MODULE_ALIAS("sound-layout-80");
+MODULE_ALIAS("sound-layout-86");
+MODULE_ALIAS("sound-layout-84");
+MODULE_ALIAS("sound-layout-92");
+
+/* onyx with all but microphone connected */
+static struct codec_connection onyx_connections_nomic[] = {
+	{
+		.connected = CC_SPEAKERS | CC_HEADPHONE | CC_LINEOUT,
+		.codec_bit = 0,
+	},
+	{
+		.connected = CC_DIGITALOUT,
+		.codec_bit = 1,
+	},
+	{
+		.connected = CC_LINEIN,
+		.codec_bit = 2,
+	},
+	{} /* terminate array by .connected == 0 */
+};
+
+/* onyx on machines without headphone */
+static struct codec_connection onyx_connections_noheadphones[] = {
+	{
+		.connected = CC_SPEAKERS | CC_LINEOUT |
+			     CC_LINEOUT_LABELLED_HEADPHONE,
+		.codec_bit = 0,
+	},
+	{
+		.connected = CC_DIGITALOUT,
+		.codec_bit = 1,
+	},
+	/* FIXME: are these correct? probably not for all the machines
+	 * below ... If not this will need separating. */
+	{
+		.connected = CC_LINEIN,
+		.codec_bit = 2,
+	},
+	{
+		.connected = CC_MICROPHONE,
+		.codec_bit = 3,
+	},
+	{} /* terminate array by .connected == 0 */
+};
+
+/* tas on machines without line out */
+static struct codec_connection tas_connections_nolineout[] = {
+	{
+		.connected = CC_SPEAKERS | CC_HEADPHONE,
+		.codec_bit = 0,
+	},
+	{
+		.connected = CC_LINEIN,
+		.codec_bit = 2,
+	},
+	{
+		.connected = CC_MICROPHONE,
+		.codec_bit = 3,
+	},
+	{} /* terminate array by .connected == 0 */
+};
+
+/* tas on machines with neither line out nor line in */
+static struct codec_connection tas_connections_noline[] = {
+	{
+		.connected = CC_SPEAKERS | CC_HEADPHONE,
+		.codec_bit = 0,
+	},
+	{
+		.connected = CC_MICROPHONE,
+		.codec_bit = 3,
+	},
+	{} /* terminate array by .connected == 0 */
+};
+
+static struct layout layouts[] = {
+	/* last PowerBooks (15" Oct 2005) */
+	{ .layout_id = 82,
+	  .flags = LAYOUT_FLAG_COMBO_LINEOUT_SPDIF,
+	  .codecs[0] = {
+		.name = "onyx",
+		.connections = onyx_connections_noheadphones,
+	  },
+	  .codecs[1] = {
+		.name = "topaz",
+		.connections = NULL /* TBD */,
+	  },
+	},
+	/* PowerBook5,7 */
+	{ .layout_id = 64,
+	  .flags = LAYOUT_FLAG_COMBO_LINEOUT_SPDIF,
+	  .codecs[0] = {
+		.name = "onyx",
+		.connections = onyx_connections_noheadphones,
+	  },
+	},
+	/* PowerBook5,7 */
+	{ .layout_id = 65,
+	  .codecs[0] = {
+		.name = "topaz",
+		.connections = NULL, /* TBD */
+	  },
+	},
+	/* PowerBook5,9 [17" Oct 2005] */
+	{ .layout_id = 84,
+	  .flags = LAYOUT_FLAG_COMBO_LINEOUT_SPDIF,
+	  .codecs[0] = {
+		.name = "onyx",
+		.connections = onyx_connections_noheadphones,
+	  },
+	  .codecs[1] = {
+		.name = "topaz",
+		.connections = NULL /* TBD */,
+	  },
+	},
+	/* PowerMac8,1 */
+	{ .layout_id = 45,
+	  .codecs[0] = {
+		.name = "onyx",
+		.connections = onyx_connections_noheadphones,
+	  },
+	  .codecs[1] = {
+		.name = "topaz",
+		.connections = NULL /* TBD */,
+	  },
+	},
+	/* Quad PowerMac (analog in, analog/digital out) */
+	{ .layout_id = 68,
+	  .codecs[0] = {
+		.name = "onyx",
+		.connections = onyx_connections_nomic,
+	  },
+	},
+	/* Quad PowerMac (digital in) */
+	{ .layout_id = 69,
+	  .codecs[0] = {
+		.name = "topaz",
+		.connections = NULL /* TBD */,
+	  },
+	  .busname = "digital in", .pcmid = 1 },
+	/* Early 2005 PowerBook */
+	{ .layout_id = 70,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_nolineout,
+	  },
+	},
+	/* PowerBook6,7 */
+	{ .layout_id = 80,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_noline,
+	  },
+	},
+	/* PowerBook6,8 */
+	{ .layout_id = 72,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_nolineout,
+	  },
+	},
+	/* PowerMac8,2 */
+	{ .layout_id = 86,
+	  .codecs[0] = {
+		.name = "onyx",
+		.connections = onyx_connections_nomic, /* ??? */
+	  },
+	  .codecs[1] = {
+		.name = "topaz",
+		.connections = NULL /* TBD */,
+	  },
+	},
+	/* PowerBook6,7 */
+	{ .layout_id = 92,
+	  .codecs[0] = {
+		.name = "tas",
+		.connections = tas_connections_nolineout,
+	  },
+	},
+	{}
+};
+
+static struct layout *find_layout_by_id(unsigned int id)
+{
+	struct layout *l;
+
+	l = layouts;
+	while (l->layout_id) {
+		if (l->layout_id == id)
+			return l;
+		l++;
+	}
+	return NULL;
+}
+
+static void use_layout(struct layout *l)
+{
+	int i;
+
+	for (i=0; i<MAX_CODECS_PER_BUS; i++) {
+		if (l->codecs[i].name) {
+			request_module("snd-aoa-codec-%s", l->codecs[i].name);
+		}
+	}
+	/* now we wait for the codecs to call us back */
+}
+
+struct layout_dev {
+	struct list_head list;
+	struct soundbus_dev *sdev;
+	struct device_node *sound;
+	struct aoa_codec *codecs[MAX_CODECS_PER_BUS];
+	struct layout *layout;
+	struct gpio_runtime gpio;
+};
+
+static LIST_HEAD(layouts_list);
+static int layouts_list_items;
+
+static int control_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+#define AMP_CONTROL(n, description)					\
+static int n##_control_get(struct snd_kcontrol *kcontrol,		\
+			   struct snd_ctl_elem_value *ucontrol)		\
+{									\
+	struct gpio_runtime *gpio = snd_kcontrol_chip(kcontrol);	\
+	if (gpio->methods && gpio->methods->get_##n)			\
+		ucontrol->value.integer.value[0] =			\
+			gpio->methods->get_##n(gpio);			\
+	return 0;							\
+}									\
+static int n##_control_put(struct snd_kcontrol *kcontrol,		\
+			   struct snd_ctl_elem_value *ucontrol)		\
+{									\
+	struct gpio_runtime *gpio = snd_kcontrol_chip(kcontrol);	\
+	if (gpio->methods && gpio->methods->get_##n)			\
+		gpio->methods->set_##n(gpio,				\
+			ucontrol->value.integer.value[0]);		\
+	return 1;							\
+}									\
+static struct snd_kcontrol_new n##_ctl = {				\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,				\
+	.name = description,						\
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,                      \
+	.info = control_info,						\
+	.get = n##_control_get,						\
+	.put = n##_control_put,						\
+}
+
+AMP_CONTROL(headphone, "Headphone Switch");
+AMP_CONTROL(speakers, "Speakers Switch");
+AMP_CONTROL(lineout, "Line-out Switch");
+
+static int check_codec(struct aoa_codec *codec, struct layout_dev *ldev, struct codec_connect_info *cci)
+{
+	u32 *ref;
+	char propname[32];
+	struct codec_connection *cc;
+
+	if (codec->node) {
+		snprintf(propname, sizeof(propname), "platform-%s-codec-ref", codec->name);
+		ref = (u32*)get_property(ldev->sound, propname, NULL);
+		/* if the codec has a node, we require a reference */
+		if (!ref) {
+			printk(KERN_INFO "snd-aoa-fabric-layout: required property %s not present\n", propname);
+			return -ENODEV;
+		}
+		if (*ref != codec->node->linux_phandle) {
+			printk(KERN_INFO "snd-aoa-fabric-layout: %s doesn't match!\n", propname);
+			return -ENODEV;
+		}
+	} else {
+		if (layouts_list_items != 1) {
+			printk(KERN_INFO "snd-aoa-fabric-layout: more than one soundbus, but no references. eek!\n");
+			return -ENODEV;
+		}
+	}
+	codec->soundbus_dev = ldev->sdev;
+	codec->gpio = &ldev->gpio;
+
+	cc = cci->connections;
+	if (!cc)
+		return -EINVAL;
+
+	printk(KERN_INFO "snd-aoa-fabric-layout: can use this codec\n");
+
+	codec->connected = 0;
+	codec->fabric_data = cc;
+
+	while (cc->connected) {
+		codec->connected |= 1<<cc->codec_bit;
+		cc++;
+	}
+
+	return 0;
+}
+
+static int layout_found_codec(struct aoa_codec *codec)
+{
+	struct layout_dev *ldev;
+	int i;
+
+	list_for_each_entry(ldev, &layouts_list, list) {
+		for (i=0; i<MAX_CODECS_PER_BUS; i++) {
+			if (!ldev->layout->codecs[i].name)
+				continue;
+			if (strcmp(ldev->layout->codecs[i].name, codec->name) == 0) {
+				if (check_codec(codec, ldev, &ldev->layout->codecs[i]) == 0)
+					return 0;
+			}
+		}
+	}
+	return -ENODEV;
+}
+
+static void layout_remove_codec(struct aoa_codec *codec)
+{
+	int i;
+	/* here remove the codec from the layout dev's
+	 * codec reference */
+
+	codec->soundbus_dev = NULL;
+	codec->gpio = NULL;
+	for (i=0; i<MAX_CODECS_PER_BUS; i++) {
+	}
+}
+
+static void layout_attached_codec(struct aoa_codec *codec)
+{
+	struct codec_connection *cc;
+	struct snd_kcontrol *ctl;
+
+	/* need to add this codec to our codec array! */
+
+	cc = codec->fabric_data;
+
+	while (cc->connected) {
+		if (cc->connected & CC_SPEAKERS)
+			aoa_snd_ctl_add(snd_ctl_new1(&speakers_ctl, codec->gpio));
+		if (cc->connected & CC_HEADPHONE)
+			aoa_snd_ctl_add(snd_ctl_new1(&headphone_ctl, codec->gpio));
+		if (cc->connected & CC_LINEOUT) {
+			ctl = snd_ctl_new1(&lineout_ctl, codec->gpio);
+			if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
+				strlcpy(ctl->id.name,
+					"Headphone Switch", sizeof(ctl->id.name));
+			aoa_snd_ctl_add(ctl);
+		}
+		cc++;
+	}
+}
+static struct aoa_fabric layout_fabric = {
+	.name = "SoundByLayout",
+	.owner = THIS_MODULE,
+	.found_codec = layout_found_codec,
+	.remove_codec = layout_remove_codec,
+	.attached_codec = layout_attached_codec,
+};
+
+static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
+{
+	struct device_node *sound = NULL;
+	unsigned int *layout_id;
+	struct layout *layout;
+	struct layout_dev *ldev = NULL;
+	int err;
+
+	/* by breaking out we keep a reference */
+	while ((sound = of_get_next_child(sdev->ofdev.node, sound))) {
+		if (sound->type && strcasecmp(sound->type, "soundchip") == 0)
+			break;
+	}
+	if (!sound) return -ENODEV;
+
+	layout_id = (unsigned int *) get_property(sound, "layout-id", NULL);
+	if (!layout_id)
+		goto outnodev;
+	printk(KERN_INFO "snd-aoa-fabric-layout: found bus with layout %d ", *layout_id);
+
+	layout = find_layout_by_id(*layout_id);
+	if (!layout) {
+		printk("(no idea how to handle)\n");
+		goto outnodev;
+	}
+
+	ldev = kzalloc(sizeof(struct layout_dev), GFP_KERNEL);
+	if (!ldev)
+		goto outnodev;
+
+	ldev->sdev = sdev;
+	ldev->sound = sound;
+	ldev->layout = layout;
+	ldev->gpio.node = sound->parent;
+	ldev->gpio.methods = pmf_gpio_methods;
+	sdev->ofdev.dev.driver_data = ldev;
+
+	printk("(using)\n");
+	list_add(&ldev->list, &layouts_list);
+	layouts_list_items++;
+
+	/* assign these before registering ourselves, so
+	 * callbacks that are done during registration
+	 * already have the values */
+	sdev->pcmid = ldev->layout->pcmid;
+	if (ldev->layout->busname) {
+		sdev->pcmname = ldev->layout->busname;
+	} else {
+		sdev->pcmname = "Master";
+	}
+
+	err = aoa_fabric_register(&layout_fabric);
+	if (err && err != -EALREADY) {
+		printk(KERN_INFO "snd-aoa-fabric-layout: can't use,"
+				 " another fabric is active!\n");
+		goto outlistdel;
+	}
+
+	ldev->gpio.methods->init(&ldev->gpio);
+	use_layout(layout);
+	return 0;
+ outlistdel:
+	/* reset if we didn't use it */
+	sdev->pcmname = NULL;
+	sdev->pcmid = -1;
+	list_del(&ldev->list);
+	layouts_list_items--;
+ outnodev:
+ 	if (sound) of_node_put(sound);
+ 	if (ldev) kfree(ldev);
+	return -ENODEV;
+}
+
+static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
+{
+	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
+	int i;
+
+	for (i=0; i<MAX_CODECS_PER_BUS; i++) {
+		if (ldev->codecs[i]) {
+			aoa_fabric_unlink_codec(ldev->codecs[i]);
+		}
+		ldev->codecs[i] = NULL;
+	}
+	list_del(&ldev->list);
+	layouts_list_items--;
+	of_node_put(ldev->sound);
+
+	ldev->gpio.methods->exit(&ldev->gpio);
+	kfree(ldev);
+	sdev->pcmid = -1;
+	sdev->pcmname = NULL;
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int aoa_fabric_layout_suspend(struct soundbus_dev *sdev, pm_message_t state)
+{
+	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
+
+	printk("aoa_fabric_layout_suspend()\n");
+
+	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_off)
+		ldev->gpio.methods->all_amps_off(&ldev->gpio);
+
+	return 0;
+}
+
+static int aoa_fabric_layout_resume(struct soundbus_dev *sdev)
+{
+	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
+
+	printk("aoa_fabric_layout_resume()\n");
+
+	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_off)
+		ldev->gpio.methods->all_amps_restore(&ldev->gpio);
+
+	return 0;
+}
+#endif
+
+static struct soundbus_driver aoa_soundbus_driver = {
+	.name = "snd_aoa_soundbus_drv",
+	.owner = THIS_MODULE,
+	.probe = aoa_fabric_layout_probe,
+	.remove = aoa_fabric_layout_remove,
+#ifdef CONFIG_PM
+	.suspend = aoa_fabric_layout_suspend,
+	.resume = aoa_fabric_layout_resume,
+#endif
+};
+
+static int __init aoa_fabric_layout_init(void)
+{
+	int err;
+
+	err = soundbus_register_driver(&aoa_soundbus_driver);
+	if (err)
+		return err;
+	return 0;
+}
+
+static void __exit aoa_fabric_layout_exit(void)
+{
+	soundbus_unregister_driver(&aoa_soundbus_driver);
+	aoa_fabric_unregister(&layout_fabric);
+}
+
+module_init(aoa_fabric_layout_init);
+module_exit(aoa_fabric_layout_exit);

--
