Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B410167BFD
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 23:11:21 +1000 (EST)
Message-Id: <20060607130912.595196000@sipsolutions.net>
References: <20060607130909.584205000@sipsolutions.net>
Date: Wed, 07 Jun 2006 15:09:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 04/12] snd-aoa: add soundbus
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

This patch adds the mostly generic soundbus that will be used for all the
sound busses Apple machines have and provides just the hooks for automatic
driver loading etc.

--- /dev/null
+++ b/sound/aoa/soundbus/Kconfig
@@ -0,0 +1,14 @@
+config SND_AOA_SOUNDBUS
+	tristate "Apple Soundbus support"
+	depends on SOUND && SND_PCM && EXPERIMENTAL
+	---help---
+	This option enables the generic driver for the soundbus
+	support on Apple machines.
+	
+	It is required for the sound bus implementations.
+
+config SND_AOA_SOUNDBUS_I2S
+	tristate "I2S bus support"
+	depends on SND_AOA_SOUNDBUS && PCI
+	---help---
+	This option enables support for Apple I2S busses.
--- /dev/null
+++ b/sound/aoa/soundbus/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SND_AOA_SOUNDBUS) += snd-aoa-soundbus.o
+snd-aoa-soundbus-objs := core.o sysfs.o
+obj-$(CONFIG_SND_AOA_SOUNDBUS_I2S) += i2sbus/
--- /dev/null
+++ b/sound/aoa/soundbus/soundbus.h
@@ -0,0 +1,202 @@
+/*
+ * soundbus generic definitions
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+#ifndef __SOUNDBUS_H
+#define __SOUNDBUS_H
+
+#include <asm/of_device.h>
+#include <sound/pcm.h>
+#include <linux/list.h>
+
+
+/* When switching from master to slave or the other way around,
+ * you don't want to have the codec chip acting as clock source
+ * while the bus still is.
+ * More importantly, while switch from slave to master, you need
+ * to turn off the chip's master function first, but then there's
+ * no clock for a while and other chips might reset, so we notify
+ * their drivers after having switched.
+ * The constants here are codec-point of view, so when we switch
+ * the soundbus to master we tell the codec we're going to switch
+ * and give it CLOCK_SWITCH_PREPARE_SLAVE!
+ */
+enum clock_switch {
+	CLOCK_SWITCH_PREPARE_SLAVE,
+	CLOCK_SWITCH_PREPARE_MASTER,
+	CLOCK_SWITCH_SLAVE,
+	CLOCK_SWITCH_MASTER,
+	CLOCK_SWITCH_NOTIFY,
+};
+
+/* information on a transfer the codec can take */
+struct transfer_info {
+	u64 formats;		/* SNDRV_PCM_FMTBIT_* */
+	unsigned int rates;	/* SNDRV_PCM_RATE_* */
+	/* flags */
+	u32 transfer_in:1, /* input = 1, output = 0 */
+	    must_be_clock_source:1;
+	/* for codecs to distinguish among their TIs */
+	int tag;
+};
+
+struct codec_info_item {
+	struct codec_info *codec;
+	void *codec_data;
+	struct soundbus_dev *sdev;
+	/* internal, to be used by the soundbus provider */
+	struct list_head list;
+};
+
+/* for prepare, where the codecs need to know
+ * what we're going to drive the bus with */
+struct bus_info {
+	/* see below */
+	int sysclock_factor;
+	int bus_factor;
+};
+
+/* information on the codec itself, plus function pointers */
+struct codec_info {
+	/* the module this lives in */
+	struct module *owner;
+
+	/* supported transfer possibilities, array terminated by
+	 * formats or rates being 0. */
+	struct transfer_info *transfers;
+
+	/* Master clock speed factor
+	 * to be used (master clock speed = sysclock_factor * sampling freq)
+	 * Unused if the soundbus provider has no such notion.
+	 */
+	int sysclock_factor;
+
+	/* Bus factor, bus clock speed = bus_factor * sampling freq)
+	 * Unused if the soundbus provider has no such notion.
+	 */
+	int bus_factor;
+
+	/* operations */
+	/* clock switching, see above */
+	int (*switch_clock)(struct codec_info_item *cii,
+			    enum clock_switch clock);
+
+	/* called for each transfer_info when the user
+	 * opens the pcm device to determine what the
+	 * hardware can support at this point in time.
+	 * That can depend on other user-switchable controls.
+	 * Return 1 if usable, 0 if not.
+	 * out points to another instance of a transfer_info
+	 * which is initialised to the values in *ti, and
+	 * it's format and rate values can be modified by
+	 * the callback if it is necessary to further restrict
+	 * the formats that can be used at the moment, for
+	 * example when one codec has multiple logical codec
+	 * info structs for multiple inputs.
+	 */
+	int (*usable)(struct codec_info_item *cii,
+		      struct transfer_info *ti,
+		      struct transfer_info *out);
+
+	/* called when pcm stream is opened, probably not implemented
+	 * most of the time since it isn't too useful */
+	int (*open)(struct codec_info_item *cii,
+		    struct snd_pcm_substream *substream);
+
+	/* called when the pcm stream is closed, at this point
+	 * the user choices can all be unlocked (see below) */
+	int (*close)(struct codec_info_item *cii,
+		     struct snd_pcm_substream *substream);
+
+	/* if the codec must forbid some user choices because
+	 * they are not valid with the substream/transfer info,
+	 * it must do so here. Example: no digital output for
+	 * incompatible framerate, say 8KHz, on Onyx.
+	 * If the selected stuff in the substream is NOT
+	 * compatible, you have to reject this call! */
+	int (*prepare)(struct codec_info_item *cii,
+		       struct bus_info *bi,
+		       struct snd_pcm_substream *substream);
+
+	/* start() is called before data is pushed to the codec.
+	 * Note that start() must be atomic! */
+	int (*start)(struct codec_info_item *cii,
+		     struct snd_pcm_substream *substream);
+
+	/* stop() is called after data is no longer pushed to the codec.
+	 * Note that stop() must be atomic! */
+	int (*stop)(struct codec_info_item *cii,
+		    struct snd_pcm_substream *substream);
+
+	int (*suspend)(struct codec_info_item *cii, pm_message_t state);
+	int (*resume)(struct codec_info_item *cii);
+};
+
+/* information on a soundbus device */
+struct soundbus_dev {
+	/* the bus it belongs to */
+	struct list_head onbuslist;
+
+	/* the of device it represents */
+	struct of_device ofdev;
+
+	/* what modules go by */
+	char modalias[32];
+
+	/* These fields must be before attach_codec can be called.
+	 * They should be set by the owner of the alsa card object
+	 * that is needed, and whoever sets them must make sure
+	 * that they are unique within that alsa card object. */
+	char *pcmname;
+	int pcmid;
+
+	/* this is assigned by the soundbus provider in attach_codec */
+	struct snd_pcm *pcm;
+
+	/* operations */
+	/* attach a codec to this soundbus, give the alsa
+	 * card object the PCMs for this soundbus should be in.
+	 * The 'data' pointer must be unique, it is used as the
+	 * key for detach_codec(). */
+	int (*attach_codec)(struct soundbus_dev *dev, struct snd_card *card,
+			    struct codec_info *ci, void *data);
+	void (*detach_codec)(struct soundbus_dev *dev, void *data);
+	/* TODO: suspend/resume */
+
+	/* private for the soundbus provider */
+	struct list_head codec_list;
+	u32 have_out:1, have_in:1;
+};
+#define to_soundbus_device(d) container_of(d, struct soundbus_dev, ofdev.dev)
+#define of_to_soundbus_device(d) container_of(d, struct soundbus_dev, ofdev)
+
+extern int soundbus_add_one(struct soundbus_dev *dev);
+extern void soundbus_remove_one(struct soundbus_dev *dev);
+
+extern struct soundbus_dev *soundbus_dev_get(struct soundbus_dev *dev);
+extern void soundbus_dev_put(struct soundbus_dev *dev);
+
+struct soundbus_driver {
+	char *name;
+	struct module *owner;
+
+	/* we don't implement any matching at all */
+
+	int	(*probe)(struct soundbus_dev* dev);
+	int	(*remove)(struct soundbus_dev* dev);
+
+	int	(*suspend)(struct soundbus_dev* dev, pm_message_t state);
+	int	(*resume)(struct soundbus_dev* dev);
+	int	(*shutdown)(struct soundbus_dev* dev);
+
+	struct device_driver driver;
+};
+#define to_soundbus_driver(drv) container_of(drv,struct soundbus_driver, driver)
+
+extern int soundbus_register_driver(struct soundbus_driver *drv);
+extern void soundbus_unregister_driver(struct soundbus_driver *drv);
+
+#endif /* __SOUNDBUS_H */
--- /dev/null
+++ b/sound/aoa/soundbus/sysfs.c
@@ -0,0 +1,43 @@
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/stat.h>
+/* FIX UP */
+#include "soundbus.h"
+
+#define soundbus_config_of_attr(field, format_string)			\
+static ssize_t								\
+field##_show (struct device *dev, struct device_attribute *attr,	\
+              char *buf)						\
+{									\
+	struct soundbus_dev *mdev = to_soundbus_device (dev);		\
+	return sprintf (buf, format_string, mdev->ofdev.node->field);	\
+}
+
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct soundbus_dev *sdev = to_soundbus_device(dev);
+	struct of_device *of = &sdev->ofdev;
+	int length;
+
+	if (*sdev->modalias) {
+		strlcpy(buf, sdev->modalias, sizeof(sdev->modalias) + 1);
+		strcat(buf, "\n");
+		length = strlen(buf);
+	} else {
+		length = sprintf(buf, "of:N%sT%s\n",
+				 of->node->name, of->node->type);
+	}
+
+	return length;
+}
+
+soundbus_config_of_attr (name, "%s\n");
+soundbus_config_of_attr (type, "%s\n");
+
+struct device_attribute soundbus_dev_attrs[] = {
+	__ATTR_RO(name),
+	__ATTR_RO(type),
+	__ATTR_RO(modalias),
+	__ATTR_NULL
+};
--- /dev/null
+++ b/sound/aoa/soundbus/core.c
@@ -0,0 +1,250 @@
+/*
+ * soundbus
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPL v2, can be found in COPYING.
+ */
+
+#include <linux/module.h>
+#include "soundbus.h"
+
+MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Apple Soundbus");
+
+struct soundbus_dev *soundbus_dev_get(struct soundbus_dev *dev)
+{
+	struct device *tmp;
+
+	if (!dev)
+		return NULL;
+	tmp = get_device(&dev->ofdev.dev);
+	if (tmp)
+		return to_soundbus_device(tmp);
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(soundbus_dev_get);
+
+void soundbus_dev_put(struct soundbus_dev *dev)
+{
+	if (dev)
+		put_device(&dev->ofdev.dev);
+}
+EXPORT_SYMBOL_GPL(soundbus_dev_put);
+
+static int soundbus_probe(struct device *dev)
+{
+	int error = -ENODEV;
+	struct soundbus_driver *drv;
+	struct soundbus_dev *soundbus_dev;
+
+	drv = to_soundbus_driver(dev->driver);
+	soundbus_dev = to_soundbus_device(dev);
+
+	if (!drv->probe)
+		return error;
+
+	soundbus_dev_get(soundbus_dev);
+
+	error = drv->probe(soundbus_dev);
+	if (error)
+		soundbus_dev_put(soundbus_dev);
+
+	return error;
+}
+
+
+static int soundbus_uevent(struct device *dev, char **envp, int num_envp,
+			   char *buffer, int buffer_size)
+{
+	struct soundbus_dev * soundbus_dev;
+	struct of_device * of;
+	char *scratch, *compat, *compat2;
+	int i = 0;
+	int length, cplen, cplen2, seen = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	soundbus_dev = to_soundbus_device(dev);
+	if (!soundbus_dev)
+		return -ENODEV;
+
+	of = &soundbus_dev->ofdev;
+
+	/* stuff we want to pass to /sbin/hotplug */
+	envp[i++] = scratch = buffer;
+	length = scnprintf (scratch, buffer_size, "OF_NAME=%s", of->node->name);
+	++length;
+	buffer_size -= length;
+	if ((buffer_size <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length = scnprintf (scratch, buffer_size, "OF_TYPE=%s", of->node->type);
+	++length;
+	buffer_size -= length;
+	if ((buffer_size <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	scratch += length;
+
+	/* Since the compatible field can contain pretty much anything
+	 * it's not really legal to split it out with commas. We split it
+	 * up using a number of environment variables instead. */
+
+	compat = (char *) get_property(of->node, "compatible", &cplen);
+	compat2 = compat;
+	cplen2= cplen;
+	while (compat && cplen > 0) {
+		envp[i++] = scratch;
+		length = scnprintf (scratch, buffer_size,
+				     "OF_COMPATIBLE_%d=%s", seen, compat);
+		++length;
+		buffer_size -= length;
+		if ((buffer_size <= 0) || (i >= num_envp))
+			return -ENOMEM;
+		scratch += length;
+		length = strlen (compat) + 1;
+		compat += length;
+		cplen -= length;
+		seen++;
+	}
+
+	envp[i++] = scratch;
+	length = scnprintf (scratch, buffer_size, "OF_COMPATIBLE_N=%d", seen);
+	++length;
+	buffer_size -= length;
+	if ((buffer_size <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length = scnprintf (scratch, buffer_size, "MODALIAS=%s",
+			soundbus_dev->modalias);
+
+	buffer_size -= length;
+	if ((buffer_size <= 0) || (i >= num_envp))
+		return -ENOMEM;
+
+	envp[i] = NULL;
+
+	return 0;
+}
+
+static int soundbus_device_remove(struct device *dev)
+{
+	struct soundbus_dev * soundbus_dev = to_soundbus_device(dev);
+	struct soundbus_driver * drv = to_soundbus_driver(dev->driver);
+
+	if (dev->driver && drv->remove)
+		drv->remove(soundbus_dev);
+	soundbus_dev_put(soundbus_dev);
+
+	return 0;
+}
+
+static void soundbus_device_shutdown(struct device *dev)
+{
+	struct soundbus_dev * soundbus_dev = to_soundbus_device(dev);
+	struct soundbus_driver * drv = to_soundbus_driver(dev->driver);
+
+	if (dev->driver && drv->shutdown)
+		drv->shutdown(soundbus_dev);
+}
+
+#ifdef CONFIG_PM
+
+static int soundbus_device_suspend(struct device *dev, pm_message_t state)
+{
+	struct soundbus_dev * soundbus_dev = to_soundbus_device(dev);
+	struct soundbus_driver * drv = to_soundbus_driver(dev->driver);
+
+	if (dev->driver && drv->suspend)
+		return drv->suspend(soundbus_dev, state);
+	return 0;
+}
+
+static int soundbus_device_resume(struct device * dev)
+{
+	struct soundbus_dev * soundbus_dev = to_soundbus_device(dev);
+	struct soundbus_driver * drv = to_soundbus_driver(dev->driver);
+
+	if (dev->driver && drv->resume)
+		return drv->resume(soundbus_dev);
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
+extern struct device_attribute soundbus_dev_attrs[];
+
+static struct bus_type soundbus_bus_type = {
+	.name		= "aoa-soundbus",
+	.probe		= soundbus_probe,
+	.uevent		= soundbus_uevent,
+	.remove		= soundbus_device_remove,
+	.shutdown	= soundbus_device_shutdown,
+#ifdef CONFIG_PM
+	.suspend	= soundbus_device_suspend,
+	.resume		= soundbus_device_resume,
+#endif
+	.dev_attrs	= soundbus_dev_attrs,
+};
+
+static int __init soundbus_init(void)
+{
+	return bus_register(&soundbus_bus_type);
+}
+
+static void __exit soundbus_exit(void)
+{
+	bus_unregister(&soundbus_bus_type);
+}
+
+int soundbus_add_one(struct soundbus_dev *dev)
+{
+	static int devcount;
+
+	/* sanity checks */
+	if (!dev->attach_codec ||
+	    !dev->ofdev.node ||
+	    dev->pcmname ||
+	    dev->pcmid != -1) {
+		printk(KERN_ERR "soundbus: adding device failed sanity check!\n");
+		return -EINVAL;
+	}
+
+	snprintf(dev->ofdev.dev.bus_id, BUS_ID_SIZE, "soundbus:%x", ++devcount);
+	dev->ofdev.dev.bus = &soundbus_bus_type;
+	return of_device_register(&dev->ofdev);
+}
+EXPORT_SYMBOL_GPL(soundbus_add_one);
+
+void soundbus_remove_one(struct soundbus_dev *dev)
+{
+	of_device_unregister(&dev->ofdev);
+}
+EXPORT_SYMBOL_GPL(soundbus_remove_one);
+
+int soundbus_register_driver(struct soundbus_driver *drv)
+{
+	/* initialize common driver fields */
+	drv->driver.name = drv->name;
+	drv->driver.bus = &soundbus_bus_type;
+
+	/* register with core */
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(soundbus_register_driver);
+
+void soundbus_unregister_driver(struct soundbus_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(soundbus_unregister_driver);
+
+module_init(soundbus_init);
+module_exit(soundbus_exit);

--
