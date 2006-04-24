Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 756AC679F3
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 13:01:13 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.6/8.13.5) with ESMTP id k3O3B2lS226154
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 13:11:03 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3O34NPY212834
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 13:04:23 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11/8.13.3) with ESMTP id k3O30xgE027297
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 13:00:59 +1000
Subject: sns-aoa more PM
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 13:00:55 +1000
Message-Id: <1145847655.4928.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(resending including the list in case somebody else is interested :)

Hi Johannes. The patch below adds mute of amps along with other changes.
In random order:

 - Removed the sound_bus list that seemed useless to me and use the
normal "remove" mecanism to unregister the soundbus_dev from i2sbus. I
don't know if I ended up breaking something here, we'll have to check :)
We might need to test...

 - Set proper parent so i2sbus created soundbus_dev hangs off macio-dev,
thus makes it get suspend/resume with proper ordering (that is suspend
before i2sbus and resume after).

 - Renamed bits & pieces in layout fabric

 - Add suspend/resume hooks to layout fabric to mure/restore amps

 - Add code in onyx to restore all codec registers on wakeup

With that, I now get nicely working suspend/resume without "clacs" on my
onyx based laptop. I tried Amarok and it properly stops playing on
suspend and resumes on wakeup without a glitch.  

my own little todo list:
 - Cleanup printk junk, use dev_* for debug * info stuff etc... 
 - Look into i2s probing issues (resources on some macs etc...)
 - i2s has a weird address in macio node in the device-tree, look at
this
 - Get TAS working on dual g5
 - Do some basic topaz for dual g5
 - do a pre-layout fabric for snapper/tumbler/daca
 - whatever ...

diff -urN snd-aoa/aoa/codecs/onyx/snd-aoa-codec-onyx.c snd-aoa.ben/aoa/codecs/onyx/snd-aoa-codec-onyx.c
--- snd-aoa/aoa/codecs/onyx/snd-aoa-codec-onyx.c	2006-04-07 21:22:59.000000000 +1000
+++ snd-aoa.ben/aoa/codecs/onyx/snd-aoa-codec-onyx.c	2006-04-24 12:08:00.000000000 +1000
@@ -616,10 +616,32 @@
 	case CLOCK_SWITCH_SLAVE:
 		onyx->codec.gpio->methods->all_amps_restore(onyx->codec.gpio);
 		break;
+	default: /* silence warning */
+		break;
 	}
 	return 0;
 }
 
+#ifdef CONFIG_PM
+
+static int onyx_suspend(struct codec_info_item *cii, pm_message_t state)
+{
+	/* TODO */
+
+	return 0;
+}
+
+static int onyx_resume(struct codec_info_item *cii)
+{
+	struct onyx *onyx = cii->codec_data;
+
+	onyx_register_init(onyx);
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 static struct codec_info onyx_codec_info = {
 	.transfers = onyx_transfers,
 	.sysclock_factor = 256,
@@ -630,6 +652,10 @@
 	.open = onyx_open,
 	.close = onyx_close,
 	.switch_clock = onyx_switch_clock,
+#ifdef CONFIG_PM
+	.suspend = onyx_suspend,
+	.resume = onyx_resume,
+#endif
 };
 
 static int onyx_init_codec(struct aoa_codec *codec)
diff -urN snd-aoa/aoa/fabrics/snd-aoa-fabric-layout.c snd-aoa.ben/aoa/fabrics/snd-aoa-fabric-layout.c
--- snd-aoa/aoa/fabrics/snd-aoa-fabric-layout.c	2006-04-07 21:22:59.000000000 +1000
+++ snd-aoa.ben/aoa/fabrics/snd-aoa-fabric-layout.c	2006-04-24 11:51:15.000000000 +1000
@@ -225,14 +225,18 @@
 			   struct snd_ctl_elem_value *ucontrol)		\
 {									\
 	struct gpio_runtime *gpio = snd_kcontrol_chip(kcontrol);	\
-	ucontrol->value.integer.value[0] = gpio->methods->get_##n(gpio);\
+	if (gpio->methods && gpio->methods->get_##n)			\
+		ucontrol->value.integer.value[0] =			\
+			gpio->methods->get_##n(gpio);			\
 	return 0;							\
 }									\
 static int n##_control_put(struct snd_kcontrol *kcontrol,		\
 			   struct snd_ctl_elem_value *ucontrol)		\
 {									\
 	struct gpio_runtime *gpio = snd_kcontrol_chip(kcontrol);	\
-	gpio->methods->set_##n(gpio, ucontrol->value.integer.value[0]);	\
+	if (gpio->methods && gpio->methods->get_##n)			\
+		gpio->methods->set_##n(gpio,				\
+			ucontrol->value.integer.value[0]);		\
 	return 1;							\
 }									\
 static struct snd_kcontrol_new n##_ctl = {				\
@@ -328,7 +332,7 @@
 	.remove_codec = layout_remove_codec,
 };
 
-static int soundbus_probe(struct soundbus_dev *sdev)
+static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 {
 	struct device_node *sound = NULL;
 	unsigned int *layout_id;
@@ -401,7 +405,7 @@
 	return -ENODEV;
 }
 
-static int soundbus_remove(struct soundbus_dev *sdev)
+static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
 {
 	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
 	int i;
@@ -423,11 +427,39 @@
 	return 0;
 }
 
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
+
 static struct soundbus_driver aoa_soundbus_driver = {
 	.name = "snd_aoa_soundbus_drv",
 	.owner = THIS_MODULE,
-	.probe = soundbus_probe,
-	.remove = soundbus_remove,
+	.probe = aoa_fabric_layout_probe,
+	.remove = aoa_fabric_layout_remove,
+#ifdef CONFIG_PM
+	.suspend = aoa_fabric_layout_suspend,
+	.resume = aoa_fabric_layout_resume,
+#endif
 };
 
 int __init aoa_fabric_layout_init(void)
diff -urN snd-aoa/soundbus/core.c snd-aoa.ben/soundbus/core.c
--- snd-aoa/soundbus/core.c	2006-03-31 07:56:03.000000000 +1100
+++ snd-aoa.ben/soundbus/core.c	2006-04-24 11:45:59.000000000 +1000
@@ -173,6 +173,8 @@
 		drv->shutdown(soundbus_dev);
 }
 
+#ifdef CONFIG_PM
+
 static int soundbus_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct soundbus_dev * soundbus_dev = to_soundbus_device(dev);
@@ -193,6 +195,8 @@
 	return 0;
 }
 
+#endif /* CONFIG_PM */
+
 extern struct device_attribute soundbus_dev_attrs[];
 
 static struct bus_type soundbus_bus_type = {
@@ -201,8 +205,10 @@
 	.uevent		= soundbus_uevent,
 	.remove		= soundbus_device_remove,
 	.shutdown	= soundbus_device_shutdown,
+#ifdef CONFIG_PM
 	.suspend	= soundbus_device_suspend,
 	.resume		= soundbus_device_resume,
+#endif
 	.dev_attrs	= soundbus_dev_attrs,
 };
 
@@ -216,37 +222,30 @@
 	bus_unregister(&soundbus_bus_type);
 }
 
-int soundbus_device_add(struct soundbus_dev *dev)
+int soundbus_add_one(struct soundbus_dev *dev)
 {
 	static int devcount;
 
 	/* sanity checks */
 	if (!dev->attach_codec ||
 	    !dev->ofdev.node ||
-	    !dev->bus ||
 	    dev->pcmname ||
 	    dev->pcmid != -1) {
 		printk(KERN_ERR "soundbus: adding device failed sanity check!\n");
 		return -EINVAL;
 	}
 
-	list_add(&dev->onbuslist, &dev->bus->devices);
-
 	snprintf(dev->ofdev.dev.bus_id, BUS_ID_SIZE, "soundbus:%x", ++devcount);
 	dev->ofdev.dev.bus = &soundbus_bus_type;
 	return of_device_register(&dev->ofdev);
 }
-EXPORT_SYMBOL_GPL(soundbus_device_add);
+EXPORT_SYMBOL_GPL(soundbus_add_one);
 
-void soundbus_unregister_soundbus(struct sound_bus *soundbus)
+void soundbus_remove_one(struct soundbus_dev *dev)
 {
-	struct soundbus_dev *dev, *tmp;
-
-	list_for_each_entry_safe(dev, tmp, &soundbus->devices, onbuslist) {
-		of_device_unregister(&dev->ofdev);
-	}
+	of_device_unregister(&dev->ofdev);
 }
-EXPORT_SYMBOL_GPL(soundbus_unregister_soundbus);
+EXPORT_SYMBOL_GPL(soundbus_remove_one);
 
 int soundbus_register_driver(struct soundbus_driver *drv)
 {
diff -urN snd-aoa/soundbus/i2sbus/i2sbus-core.c snd-aoa.ben/soundbus/i2sbus/i2sbus-core.c
--- snd-aoa/soundbus/i2sbus/i2sbus-core.c	2006-04-24 11:01:30.000000000 +1000
+++ snd-aoa.ben/soundbus/i2sbus/i2sbus-core.c	2006-04-24 12:01:30.000000000 +1000
@@ -33,9 +33,6 @@
 	{ }
 };
 
-static struct sound_bus i2s_soundbus = {
-};
-
 static int alloc_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
 				       struct dbdma_command_mem *r, int numcmds)
 {
@@ -137,11 +134,10 @@
 		}
 	}
 
-	dev->sound.bus = &i2s_soundbus;
 	dev->sound.ofdev.node = np;
 	dev->sound.ofdev.dma_mask = macio->ofdev.dma_mask;
 	dev->sound.ofdev.dev.dma_mask = &dev->sound.ofdev.dma_mask;
-	dev->sound.ofdev.dev.parent = NULL;
+	dev->sound.ofdev.dev.parent = &macio->ofdev.dev;
 	dev->sound.ofdev.dev.release = i2sbus_release_dev;
 	dev->sound.attach_codec = i2sbus_attach_codec;
 	dev->sound.detach_codec = i2sbus_detach_codec;
@@ -190,7 +186,7 @@
 	if (alloc_dbdma_descriptor_ring(dev, &dev->in.dbdma_ring, MAX_DBDMA_COMMANDS))
 		goto err;
 
-	if (soundbus_device_add(&dev->sound)) {
+	if (soundbus_add_one(&dev->sound)) {
 		printk(KERN_DEBUG "i2sbus: device registration error!\n");
 		goto err;
 	}
@@ -254,6 +250,9 @@
 
 static int i2sbus_remove(struct macio_dev* dev)
 {
+	struct i2sbus_dev* i2sdev = (struct i2sbus_dev*)dev->ofdev.dev.driver_data;
+	soundbus_remove_one(&i2sdev->sound);
+
 	return 0;
 }
 
@@ -267,6 +266,8 @@
 
 	/* TODO: Notify fabric so that it can mute all amps */
 
+	printk("i2sbus_suspend()\n");
+
 	/* Notify Alsa */
 	if (i2sdev->sound.pcm) {
 		/* Suspend PCM streams */
@@ -289,6 +290,8 @@
 	struct i2sbus_dev* i2sdev = (struct i2sbus_dev*)dev->ofdev.dev.driver_data;
 	int err, ret = 0;
 
+	printk("i2sbus_resume()\n");
+
 	/* Notify codecs so they can re-initialize */
 	list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
 		err = 0;
@@ -332,13 +335,11 @@
 
 static int __init soundbus_i2sbus_init(void)
 {
-	INIT_LIST_HEAD(&i2s_soundbus.devices);
 	return macio_register_driver(&i2sbus_drv);
 }
 
 static void __exit soundbus_i2sbus_exit(void)
 {
-	soundbus_unregister_soundbus(&i2s_soundbus);
 	macio_unregister_driver(&i2sbus_drv);
 }
 
diff -urN snd-aoa/soundbus/soundbus.h snd-aoa.ben/soundbus/soundbus.h
--- snd-aoa/soundbus/soundbus.h	2006-04-16 10:44:24.000000000 +1000
+++ snd-aoa.ben/soundbus/soundbus.h	2006-04-24 11:46:06.000000000 +1000
@@ -12,12 +12,6 @@
 #include <sound/pcm.h>
 #include <linux/list.h>
 
-/*
- * the sound_bus structure is used to describe the virtual sound bus.
- */
-struct sound_bus {
-	struct list_head devices;
-};
 
 /* When switching from master to slave or the other way around,
  * you don't want to have the codec chip acting as clock source
@@ -142,7 +136,6 @@
 /* information on a soundbus device */
 struct soundbus_dev {
 	/* the bus it belongs to */
-	struct sound_bus *bus;
 	struct list_head onbuslist;
 
 	/* the of device it represents */
@@ -178,8 +171,8 @@
 #define to_soundbus_device(d) container_of(d, struct soundbus_dev, ofdev.dev)
 #define of_to_soundbus_device(d) container_of(d, struct soundbus_dev, ofdev)
 
-extern int soundbus_device_add(struct soundbus_dev *dev);
-extern void soundbus_unregister_soundbus(struct sound_bus *soundbus);
+extern int soundbus_add_one(struct soundbus_dev *dev);
+extern void soundbus_remove_one(struct soundbus_dev *dev);
 
 extern struct soundbus_dev *soundbus_dev_get(struct soundbus_dev *dev);
 extern void soundbus_dev_put(struct soundbus_dev *dev);
