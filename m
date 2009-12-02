Return-Path: <benh@ozlabs.org>
To: <linux-ide@vger.kernel.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 02 Dec 2009 11:36:28 +1100
Subject: [PATCH 3/5] powerpc/macio: Rework hotplug media bay support
Message-Id: <20091202003628.CF4321007E0@ozlabs.org>
Cc: tj@kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hotplug mediabay has tendrils deep into drivers/ide code
which makes a libata port reather difficult. In addition it's
ugly and could be done better.

This reworks the interface between the mediabay and the rest
of the world so that:

   - Any macio_driver can now have a mediabay_event callback
which will be called when that driver sits on a mediabay and
it's been either plugged or unplugged. The device type is
passed as an argument. We can now move all the IDE cruft
into the IDE driver itself

   - A check_media_bay() function can be used to take a peek
at the type of device currently in the bay if any, a cleaner
variant of the previous function with the same name.

   - A pair of lock/unlock functions are exposed to allow the
IDE driver to block the hotplug callbacks during the initial
setup and probing of the bay in order to avoid nasty race
conditions.

   - The mediabay code no longer needs to spin on the status
register of the IDE interface when it detects an IDE device,
this is done just fine by the IDE code itself

Overall, less code, simpler, and allows for another driver
than our old drivers/ide based one.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. Fix compile on 64-bit

 arch/powerpc/include/asm/macio.h    |    3 
 arch/powerpc/include/asm/mediabay.h |   29 +--
 drivers/block/swim3.c               |   39 +---
 drivers/ide/pmac.c                  |   90 ++++++---
 drivers/macintosh/mediabay.c        |  328 +++++++++++++-----------------------
 5 files changed, 213 insertions(+), 276 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/macio.h	2009-12-01 17:57:00.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/macio.h	2009-12-01 18:00:28.000000000 +1100
@@ -134,6 +134,9 @@ struct macio_driver
 	int	(*resume)(struct macio_dev* dev);
 	int	(*shutdown)(struct macio_dev* dev);
 
+#ifdef CONFIG_PMAC_MEDIABAY
+	void	(*mediabay_event)(struct macio_dev* dev, int mb_state);
+#endif
 	struct device_driver	driver;
 };
 #define	to_macio_driver(drv) container_of(drv,struct macio_driver, driver)
Index: linux-work/arch/powerpc/include/asm/mediabay.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mediabay.h	2009-12-01 17:57:00.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/mediabay.h	2009-12-01 18:00:28.000000000 +1100
@@ -17,26 +17,31 @@
 #define MB_POWER	6	/* media bay contains a Power device (???) */
 #define MB_NO		7	/* media bay contains nothing */
 
-/* Number of bays in the machine or 0 */
-extern int media_bay_count;
+struct macio_dev;
 
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-#include <linux/ide.h>
+#ifdef CONFIG_PMAC_MEDIABAY
 
-int check_media_bay_by_base(unsigned long base, int what);
-/* called by IDE PMAC host driver to register IDE controller for media bay */
-int media_bay_set_ide_infos(struct device_node *which_bay, unsigned long base,
-			    int irq, ide_hwif_t *hwif);
-
-int check_media_bay(struct device_node *which_bay, int what);
+/* Check the content type of the bay, returns MB_NO if the bay is still
+ * transitionning
+ */
+extern int check_media_bay(struct macio_dev *bay);
+
+/* The ATA driver uses the calls below to temporarily hold on the
+ * media bay callbacks while initializing the interface
+ */
+extern void lock_media_bay(struct macio_dev *bay);
+extern void unlock_media_bay(struct macio_dev *bay);
 
 #else
 
-static inline int check_media_bay(struct device_node *which_bay, int what)
+static inline int check_media_bay(struct macio_dev *bay)
 {
-	return -ENODEV;
+	return MB_NO;
 }
 
+static inline void lock_media_bay(struct macio_dev *bay) { }
+static inline void unlock_media_bay(struct macio_dev *bay) { }
+
 #endif
 
 #endif /* __KERNEL__ */
Index: linux-work/drivers/macintosh/mediabay.c
===================================================================
--- linux-work.orig/drivers/macintosh/mediabay.c	2009-12-01 17:57:00.000000000 +1100
+++ linux-work/drivers/macintosh/mediabay.c	2009-12-01 18:00:28.000000000 +1100
@@ -33,15 +33,6 @@
 #include <linux/adb.h>
 #include <linux/pmu.h>
 
-
-#define MB_DEBUG
-
-#ifdef MB_DEBUG
-#define MBDBG(fmt, arg...)	printk(KERN_INFO fmt , ## arg)
-#else
-#define MBDBG(fmt, arg...)	do { } while (0)
-#endif
-
 #define MB_FCR32(bay, r)	((bay)->base + ((r) >> 2))
 #define MB_FCR8(bay, r)		(((volatile u8 __iomem *)((bay)->base)) + (r))
 
@@ -76,28 +67,14 @@ struct media_bay_info {
 	int				index;
 	int				cached_gpio;
 	int				sleeping;
+	int				user_lock;
 	struct mutex			lock;
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-	ide_hwif_t			*cd_port;
-	void __iomem			*cd_base;
-	int				cd_irq;
-	int				cd_retry;
-#endif
-#if defined(CONFIG_BLK_DEV_IDE_PMAC)
-	int 				cd_index;
-#endif
 };
 
 #define MAX_BAYS	2
 
 static struct media_bay_info media_bays[MAX_BAYS];
-int media_bay_count = 0;
-
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-/* check the busy bit in the media-bay ide interface
-   (assumes the media-bay contains an ide device) */
-#define MB_IDE_READY(i)	((readb(media_bays[i].cd_base + 0x70) & 0x80) == 0)
-#endif
+static int media_bay_count = 0;
 
 /*
  * Wait that number of ms between each step in normal polling mode
@@ -130,21 +107,11 @@ int media_bay_count = 0;
 
 /*
  * Wait this many ticks after an IDE device (e.g. CD-ROM) is inserted
- * (or until the device is ready) before waiting for busy bit to disappear
+ * (or until the device is ready) before calling into the driver
  */
 #define MB_IDE_WAIT	1000
 
 /*
- * Timeout waiting for busy bit of an IDE device to go down
- */
-#define MB_IDE_TIMEOUT	5000
-
-/*
- * Max retries of the full power up/down sequence for an IDE device
- */
-#define MAX_CD_RETRIES	3
-
-/*
  * States of a media bay
  */
 enum {
@@ -153,7 +120,6 @@ enum {
 	mb_enabling_bay,	/* enable bits set, waiting MB_RESET_DELAY */
 	mb_resetting,		/* reset bit unset, waiting MB_SETUP_DELAY */
 	mb_ide_resetting,	/* IDE reset bit unser, waiting MB_IDE_WAIT */
-	mb_ide_waiting,		/* Waiting for BUSY bit to go away until MB_IDE_TIMEOUT */
 	mb_up,			/* Media bay full */
 	mb_powering_down	/* Powering down (avoid too fast down/up) */
 };
@@ -373,12 +339,12 @@ static inline void set_mb_power(struct m
 	if (onoff) {
 		bay->ops->power(bay, 1);
 		bay->state = mb_powering_up;
-		MBDBG("mediabay%d: powering up\n", bay->index);
+		pr_debug("mediabay%d: powering up\n", bay->index);
 	} else { 
 		/* Make sure everything is powered down & disabled */
 		bay->ops->power(bay, 0);
 		bay->state = mb_powering_down;
-		MBDBG("mediabay%d: powering down\n", bay->index);
+		pr_debug("mediabay%d: powering down\n", bay->index);
 	}
 	bay->timer = msecs_to_jiffies(MB_POWER_DELAY);
 }
@@ -387,107 +353,118 @@ static void poll_media_bay(struct media_
 {
 	int id = bay->ops->content(bay);
 
-	if (id == bay->last_value) {
-		if (id != bay->content_id) {
-			bay->value_count += msecs_to_jiffies(MB_POLL_DELAY);
-			if (bay->value_count >= msecs_to_jiffies(MB_STABLE_DELAY)) {
-				/* If the device type changes without going thru
-				 * "MB_NO", we force a pass by "MB_NO" to make sure
-				 * things are properly reset
-				 */
-				if ((id != MB_NO) && (bay->content_id != MB_NO)) {
-					id = MB_NO;
-					MBDBG("mediabay%d: forcing MB_NO\n", bay->index);
-				}
-				MBDBG("mediabay%d: switching to %d\n", bay->index, id);
-				set_mb_power(bay, id != MB_NO);
-				bay->content_id = id;
-				if (id == MB_NO) {
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-					bay->cd_retry = 0;
-#endif
-					printk(KERN_INFO "media bay %d is empty\n", bay->index);
-				}
-			}
-		}
-	} else {
+	static char *mb_content_types[] = {
+		"a floppy drive",
+		"a floppy drive",
+		"an unsuported audio device",
+		"an ATA device",
+		"an unsupported PCI device",
+		"an unknown device",
+	};
+
+	if (id != bay->last_value) {
 		bay->last_value = id;
 		bay->value_count = 0;
+		return;
 	}
-}
+	if (id == bay->content_id)
+		return;
 
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-int check_media_bay(struct device_node *which_bay, int what)
-{
-	int	i;
-
-	for (i=0; i<media_bay_count; i++)
-		if (media_bays[i].mdev && which_bay == media_bays[i].mdev->ofdev.node) {
-			if ((what == media_bays[i].content_id) && media_bays[i].state == mb_up)
-				return 0;
-			media_bays[i].cd_index = -1;
-			return -EINVAL;
+	bay->value_count += msecs_to_jiffies(MB_POLL_DELAY);
+	if (bay->value_count >= msecs_to_jiffies(MB_STABLE_DELAY)) {
+		/* If the device type changes without going thru
+		 * "MB_NO", we force a pass by "MB_NO" to make sure
+		 * things are properly reset
+		 */
+		if ((id != MB_NO) && (bay->content_id != MB_NO)) {
+			id = MB_NO;
+			pr_debug("mediabay%d: forcing MB_NO\n", bay->index);
 		}
-	return -ENODEV;
+		pr_debug("mediabay%d: switching to %d\n", bay->index, id);
+		set_mb_power(bay, id != MB_NO);
+		bay->content_id = id;
+		if (id >= MB_NO || id < 0)
+			printk(KERN_INFO "mediabay%d: Bay is now empty\n", bay->index);
+		else
+			printk(KERN_INFO "mediabay%d: Bay contains %s\n",
+			       bay->index, mb_content_types[id]);
+	}
 }
-EXPORT_SYMBOL(check_media_bay);
 
-int check_media_bay_by_base(unsigned long base, int what)
+int check_media_bay(struct macio_dev *baydev)
 {
-	int	i;
+	struct media_bay_info* bay;
+	int id;
 
-	for (i=0; i<media_bay_count; i++)
-		if (media_bays[i].mdev && base == (unsigned long) media_bays[i].cd_base) {
-			if ((what == media_bays[i].content_id) && media_bays[i].state == mb_up)
-				return 0;
-			media_bays[i].cd_index = -1;
-			return -EINVAL;
-		} 
+	if (baydev == NULL)
+		return MB_NO;
 
-	return -ENODEV;
+	/* This returns an instant snapshot, not locking, sine
+	 * we may be called with the bay lock held. The resulting
+	 * fuzzyness of the result if called at the wrong time is
+	 * not actually a huge deal
+	 */
+	bay = macio_get_drvdata(baydev);
+	if (bay == NULL)
+		return MB_NO;
+	id = bay->content_id;
+	if (bay->state != mb_up)
+		return MB_NO;
+	if (id == MB_FD1)
+		return MB_FD;
+	return id;
 }
-EXPORT_SYMBOL_GPL(check_media_bay_by_base);
+EXPORT_SYMBOL_GPL(check_media_bay);
 
-int media_bay_set_ide_infos(struct device_node* which_bay, unsigned long base,
-			    int irq, ide_hwif_t *hwif)
+void lock_media_bay(struct macio_dev *baydev)
 {
-	int	i;
+	struct media_bay_info* bay;
 
-	for (i=0; i<media_bay_count; i++) {
-		struct media_bay_info* bay = &media_bays[i];
+	if (baydev == NULL)
+		return;
+	bay = macio_get_drvdata(baydev);
+	if (bay == NULL)
+		return;
+	mutex_lock(&bay->lock);
+	bay->user_lock = 1;
+}
+EXPORT_SYMBOL_GPL(lock_media_bay);
 
-		if (bay->mdev && which_bay == bay->mdev->ofdev.node) {
-			int timeout = 5000, index = hwif->index;
-			
-			mutex_lock(&bay->lock);
-
-			bay->cd_port	= hwif;
- 			bay->cd_base	= (void __iomem *) base;
-			bay->cd_irq	= irq;
-
-			if ((MB_CD != bay->content_id) || bay->state != mb_up) {
-				mutex_unlock(&bay->lock);
-				return 0;
-			}
-			printk(KERN_DEBUG "Registered ide%d for media bay %d\n", index, i);
-			do {
-				if (MB_IDE_READY(i)) {
-					bay->cd_index	= index;
-					mutex_unlock(&bay->lock);
-					return 0;
-				}
-				mdelay(1);
-			} while(--timeout);
-			printk(KERN_DEBUG "Timeount waiting IDE in bay %d\n", i);
-			mutex_unlock(&bay->lock);
-			return -ENODEV;
-		}
+void unlock_media_bay(struct macio_dev *baydev)
+{
+	struct media_bay_info* bay;
+
+	if (baydev == NULL)
+		return;
+	bay = macio_get_drvdata(baydev);
+	if (bay == NULL)
+		return;
+	if (bay->user_lock) {
+		bay->user_lock = 0;
+		mutex_unlock(&bay->lock);
 	}
+}
+EXPORT_SYMBOL_GPL(unlock_media_bay);
 
-	return -ENODEV;
+static int mb_broadcast_hotplug(struct device *dev, void *data)
+{
+	struct media_bay_info* bay = data;
+	struct macio_dev *mdev;
+	struct macio_driver *drv;
+	int state;
+
+	if (dev->bus != &macio_bus_type)
+		return 0;
+
+	state = bay->state == mb_up ? bay->content_id : MB_NO;
+	if (state == MB_FD1)
+		state = MB_FD;
+	mdev = to_macio_device(dev);
+	drv = to_macio_driver(dev->driver);
+	if (dev->driver && drv->mediabay_event)
+		drv->mediabay_event(mdev, state);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(media_bay_set_ide_infos);
-#endif /* CONFIG_BLK_DEV_IDE_PMAC */
 
 static void media_bay_step(int i)
 {
@@ -497,8 +474,8 @@ static void media_bay_step(int i)
 	if (bay->state != mb_powering_down)
 	    poll_media_bay(bay);
 
-	/* If timer expired or polling IDE busy, run state machine */
-	if ((bay->state != mb_ide_waiting) && (bay->timer != 0)) {
+	/* If timer expired run state machine */
+	if (bay->timer != 0) {
 		bay->timer -= msecs_to_jiffies(MB_POLL_DELAY);
 		if (bay->timer > 0)
 			return;
@@ -508,100 +485,50 @@ static void media_bay_step(int i)
 	switch(bay->state) {
 	case mb_powering_up:
 	    	if (bay->ops->setup_bus(bay, bay->last_value) < 0) {
-			MBDBG("mediabay%d: device not supported (kind:%d)\n", i, bay->content_id);
+			pr_debug("mediabay%d: device not supported (kind:%d)\n",
+				 i, bay->content_id);
 	    		set_mb_power(bay, 0);
 	    		break;
 	    	}
 	    	bay->timer = msecs_to_jiffies(MB_RESET_DELAY);
 	    	bay->state = mb_enabling_bay;
-		MBDBG("mediabay%d: enabling (kind:%d)\n", i, bay->content_id);
+		pr_debug("mediabay%d: enabling (kind:%d)\n", i, bay->content_id);
 		break;
 	case mb_enabling_bay:
 		bay->ops->un_reset(bay);
 	    	bay->timer = msecs_to_jiffies(MB_SETUP_DELAY);
 	    	bay->state = mb_resetting;
-		MBDBG("mediabay%d: waiting reset (kind:%d)\n", i, bay->content_id);
+		pr_debug("mediabay%d: releasing bay reset (kind:%d)\n",
+			 i, bay->content_id);
 	    	break;
 	case mb_resetting:
 		if (bay->content_id != MB_CD) {
-			MBDBG("mediabay%d: bay is up (kind:%d)\n", i, bay->content_id);
+			pr_debug("mediabay%d: bay is up (kind:%d)\n", i,
+				 bay->content_id);
 			bay->state = mb_up;
+			device_for_each_child(&bay->mdev->ofdev.dev,
+					      bay, mb_broadcast_hotplug);
 			break;
 	    	}
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-		MBDBG("mediabay%d: waiting IDE reset (kind:%d)\n", i, bay->content_id);
+		pr_debug("mediabay%d: releasing ATA reset (kind:%d)\n",
+			 i, bay->content_id);
 		bay->ops->un_reset_ide(bay);
 	    	bay->timer = msecs_to_jiffies(MB_IDE_WAIT);
 	    	bay->state = mb_ide_resetting;
-#else
-		printk(KERN_DEBUG "media-bay %d is ide (not compiled in kernel)\n", i);
-		set_mb_power(bay, 0);
-#endif /* CONFIG_BLK_DEV_IDE_PMAC */
 	    	break;
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
+
 	case mb_ide_resetting:
-	    	bay->timer = msecs_to_jiffies(MB_IDE_TIMEOUT);
-	    	bay->state = mb_ide_waiting;
-		MBDBG("mediabay%d: waiting IDE ready (kind:%d)\n", i, bay->content_id);
+		pr_debug("mediabay%d: bay is up (kind:%d)\n", i, bay->content_id);
+		bay->state = mb_up;
+		device_for_each_child(&bay->mdev->ofdev.dev,
+				      bay, mb_broadcast_hotplug);
 	    	break;
-	case mb_ide_waiting:
-		if (bay->cd_base == NULL) {
-			bay->timer = 0;
-			bay->state = mb_up;
-			MBDBG("mediabay%d: up before IDE init\n", i);
-			break;
-		} else if (MB_IDE_READY(i)) {
-			bay->timer = 0;
-			bay->state = mb_up;
-			if (bay->cd_index < 0) {
-				printk("mediabay %d, registering IDE...\n", i);
-				pmu_suspend();
-				ide_port_scan(bay->cd_port);
-				if (bay->cd_port->present)
-					bay->cd_index = bay->cd_port->index;
-				pmu_resume();
-			}
-			if (bay->cd_index == -1) {
-				/* We eventually do a retry */
-				bay->cd_retry++;
-				printk("IDE register error\n");
-				set_mb_power(bay, 0);
-			} else {
-				printk(KERN_DEBUG "media-bay %d is ide%d\n", i, bay->cd_index);
-				MBDBG("mediabay %d IDE ready\n", i);
-			}
-			break;
-	    	} else if (bay->timer > 0)
-			bay->timer -= msecs_to_jiffies(MB_POLL_DELAY);
-	    	if (bay->timer <= 0) {
-			printk("\nIDE Timeout in bay %d !, IDE state is: 0x%02x\n",
-			       i, readb(bay->cd_base + 0x70));
-			MBDBG("mediabay%d: nIDE Timeout !\n", i);
-			set_mb_power(bay, 0);
-			bay->timer = 0;
-	    	}
-		break;
-#endif /* CONFIG_BLK_DEV_IDE_PMAC */
+
 	case mb_powering_down:
 	    	bay->state = mb_empty;
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-    	        if (bay->cd_index >= 0) {
-			printk(KERN_DEBUG "Unregistering mb %d ide, index:%d\n", i,
-			       bay->cd_index);
-			ide_port_unregister_devices(bay->cd_port);
-			bay->cd_index = -1;
-		}
-	    	if (bay->cd_retry) {
-			if (bay->cd_retry > MAX_CD_RETRIES) {
-				/* Should add an error sound (sort of beep in dmasound) */
-				printk("\nmedia-bay %d, IDE device badly inserted or unrecognised\n", i);
-			} else {
-				/* Force a new power down/up sequence */
-				bay->content_id = MB_NO;
-			}
-	    	}
-#endif /* CONFIG_BLK_DEV_IDE_PMAC */
-		MBDBG("mediabay%d: end of power down\n", i);
+		device_for_each_child(&bay->mdev->ofdev.dev,
+				      bay, mb_broadcast_hotplug);
+		pr_debug("mediabay%d: end of power down\n", i);
 	    	break;
 	}
 }
@@ -676,11 +603,6 @@ static int __devinit media_bay_attach(st
 	bay->last_value = bay->ops->content(bay);
 	bay->value_count = msecs_to_jiffies(MB_STABLE_DELAY);
 	bay->state = mb_empty;
-	do {
-		msleep(MB_POLL_DELAY);
-		media_bay_step(i);
-	} while((bay->state != mb_empty) &&
-		(bay->state != mb_up));
 
 	/* Mark us ready by filling our mdev data */
 	macio_set_drvdata(mdev, bay);
@@ -725,7 +647,7 @@ static int media_bay_resume(struct macio
 	       	set_mb_power(bay, 0);
 		msleep(MB_POWER_DELAY);
 	       	if (bay->ops->content(bay) != bay->content_id) {
-			printk("mediabay%d: content changed during sleep...\n", bay->index);
+			printk("mediabay%d: Content changed during sleep...\n", bay->index);
 			mutex_unlock(&bay->lock);
 	       		return 0;
 		}
@@ -733,9 +655,6 @@ static int media_bay_resume(struct macio
 	       	bay->last_value = bay->content_id;
 	       	bay->value_count = msecs_to_jiffies(MB_STABLE_DELAY);
 	       	bay->timer = msecs_to_jiffies(MB_POWER_DELAY);
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-	       	bay->cd_retry = 0;
-#endif
 	       	do {
 			msleep(MB_POLL_DELAY);
 	       		media_bay_step(bay->index);
@@ -823,9 +742,6 @@ static int __init media_bay_init(void)
 	for (i=0; i<MAX_BAYS; i++) {
 		memset((char *)&media_bays[i], 0, sizeof(struct media_bay_info));
 		media_bays[i].content_id	= -1;
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-		media_bays[i].cd_index		= -1;
-#endif
 	}
 	if (!machine_is(powermac))
 		return 0;
Index: linux-work/drivers/ide/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/pmac.c	2009-12-01 17:57:00.000000000 +1100
+++ linux-work/drivers/ide/pmac.c	2009-12-02 11:24:46.000000000 +1100
@@ -43,10 +43,7 @@
 #include <asm/pmac_feature.h>
 #include <asm/sections.h>
 #include <asm/irq.h>
-
-#ifndef CONFIG_PPC64
 #include <asm/mediabay.h>
-#endif
 
 #define DRV_NAME "ide-pmac"
 
@@ -59,13 +56,14 @@ typedef struct pmac_ide_hwif {
 	int				irq;
 	int				kind;
 	int				aapl_bus_id;
-	unsigned			mediabay : 1;
 	unsigned			broken_dma : 1;
 	unsigned			broken_dma_warn : 1;
 	struct device_node*		node;
 	struct macio_dev		*mdev;
 	u32				timings[4];
 	volatile u32 __iomem *		*kauai_fcr;
+	ide_hwif_t			*hwif;
+
 	/* Those fields are duplicating what is in hwif. We currently
 	 * can't use the hwif ones because of some assumptions that are
 	 * beeing done by the generic code about the kind of dma controller
@@ -854,6 +852,11 @@ sanitize_timings(pmac_ide_hwif_t *pmif)
 	pmif->timings[2] = pmif->timings[3] = value2;
 }
 
+static int on_media_bay(pmac_ide_hwif_t *pmif)
+{
+	return pmif->mdev && pmif->mdev->media_bay != NULL;
+}
+
 /* Suspend call back, should be called after the child devices
  * have actually been suspended
  */
@@ -866,7 +869,7 @@ static int pmac_ide_do_suspend(pmac_ide_
 	disable_irq(pmif->irq);
 
 	/* The media bay will handle itself just fine */
-	if (pmif->mediabay)
+	if (on_media_bay(pmif))
 		return 0;
 	
 	/* Kauai has bus control FCRs directly here */
@@ -889,7 +892,7 @@ static int pmac_ide_do_suspend(pmac_ide_
 static int pmac_ide_do_resume(pmac_ide_hwif_t *pmif)
 {
 	/* Hard reset & re-enable controller (do we really need to reset ? -BenH) */
-	if (!pmif->mediabay) {
+	if (!on_media_bay(pmif)) {
 		ppc_md.feature_call(PMAC_FTR_IDE_RESET, pmif->node, pmif->aapl_bus_id, 1);
 		ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, pmif->node, pmif->aapl_bus_id, 1);
 		msleep(10);
@@ -950,13 +953,11 @@ static void pmac_ide_init_dev(ide_drive_
 	pmac_ide_hwif_t *pmif =
 		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
 
-	if (pmif->mediabay) {
-#ifdef CONFIG_PMAC_MEDIABAY
-		if (check_media_bay_by_base(pmif->regbase, MB_CD) == 0) {
+	if (on_media_bay(pmif)) {
+		if (check_media_bay(pmif->mdev->media_bay) == MB_CD) {
 			drive->dev_flags &= ~IDE_DFLAG_NOPROBE;
 			return;
 		}
-#endif
 		drive->dev_flags |= IDE_DFLAG_NOPROBE;
 	}
 }
@@ -1072,26 +1073,22 @@ static int __devinit pmac_ide_setup_devi
 		writel(KAUAI_FCR_UATA_MAGIC |
 		       KAUAI_FCR_UATA_RESET_N |
 		       KAUAI_FCR_UATA_ENABLE, pmif->kauai_fcr);
-
-	pmif->mediabay = 0;
 	
 	/* Make sure we have sane timings */
 	sanitize_timings(pmif);
 
+	/* If we are on a media bay, wait for it to settle and lock it */
+	lock_media_bay(pmif->mdev->media_bay);
+
 	host = ide_host_alloc(&d, hws, 1);
-	if (host == NULL)
-		return -ENOMEM;
-	hwif = host->ports[0];
+	if (host == NULL) {
+		rc = -ENOMEM;
+		goto bail;
+	}
+	hwif = pmif->hwif = host->ports[0];
 
-#ifndef CONFIG_PPC64
-	/* XXX FIXME: Media bay stuff need re-organizing */
-	if (np->parent && np->parent->name
-	    && strcasecmp(np->parent->name, "media-bay") == 0) {
-#ifdef CONFIG_PMAC_MEDIABAY
-		media_bay_set_ide_infos(np->parent, pmif->regbase, pmif->irq,
-					hwif);
-#endif /* CONFIG_PMAC_MEDIABAY */
-		pmif->mediabay = 1;
+	if (on_media_bay(pmif)) {
+		/* Fixup bus ID for media bay */
 		if (!bidp)
 			pmif->aapl_bus_id = 1;
 	} else if (pmif->kind == controller_ohare) {
@@ -1100,9 +1097,7 @@ static int __devinit pmac_ide_setup_devi
 		 * units, I keep the old way
 		 */
 		ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, 0, 1);
-	} else
-#endif
-	{
+	} else {
  		/* This is necessary to enable IDE when net-booting */
 		ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmif->aapl_bus_id, 1);
 		ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, pmif->aapl_bus_id, 1);
@@ -1112,17 +1107,20 @@ static int __devinit pmac_ide_setup_devi
 	}
 
 	printk(KERN_INFO DRV_NAME ": Found Apple %s controller (%s), "
-			 "bus ID %d%s, irq %d\n", model_name[pmif->kind],
-			 pmif->mdev ? "macio" : "PCI", pmif->aapl_bus_id,
-			 pmif->mediabay ? " (mediabay)" : "", hw->irq);
+	       "bus ID %d%s, irq %d\n", model_name[pmif->kind],
+	       pmif->mdev ? "macio" : "PCI", pmif->aapl_bus_id,
+	       on_media_bay(pmif) ? " (mediabay)" : "", hw->irq);
 
 	rc = ide_host_register(host, &d, hws);
-	if (rc) {
-		ide_host_free(host);
-		return rc;
-	}
+	if (rc)
+		pmif->hwif = NULL;
 
-	return 0;
+	unlock_media_bay(pmif->mdev->media_bay);
+
+ bail:
+	if (rc && host)
+		ide_host_free(host);
+	return rc;
 }
 
 static void __devinit pmac_ide_init_ports(struct ide_hw *hw, unsigned long base)
@@ -1362,6 +1360,25 @@ pmac_ide_pci_resume(struct pci_dev *pdev
 	return rc;
 }
 
+#ifdef CONFIG_PMAC_MEDIABAY
+static void pmac_ide_macio_mb_event(struct macio_dev* mdev, int mb_state)
+{
+	pmac_ide_hwif_t *pmif =
+		(pmac_ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
+
+	switch(mb_state) {
+	case MB_CD:
+		if (!pmif->hwif->present)
+			ide_port_scan(pmif->hwif);
+		break;
+	default:
+		if (pmif->hwif->present)
+			ide_port_unregister_devices(pmif->hwif);
+	}
+}
+#endif /* CONFIG_PMAC_MEDIABAY */
+
+
 static struct of_device_id pmac_ide_macio_match[] = 
 {
 	{
@@ -1386,6 +1403,9 @@ static struct macio_driver pmac_ide_maci
 	.probe		= pmac_ide_macio_attach,
 	.suspend	= pmac_ide_macio_suspend,
 	.resume		= pmac_ide_macio_resume,
+#ifdef CONFIG_PMAC_MEDIABAY
+	.mediabay_event	= pmac_ide_macio_mb_event,
+#endif
 };
 
 static const struct pci_device_id pmac_ide_pci_match[] = {
Index: linux-work/drivers/block/swim3.c
===================================================================
--- linux-work.orig/drivers/block/swim3.c	2009-12-01 17:57:00.000000000 +1100
+++ linux-work/drivers/block/swim3.c	2009-12-01 18:00:28.000000000 +1100
@@ -200,7 +200,7 @@ struct floppy_state {
 	int	ejected;
 	wait_queue_head_t wait;
 	int	wanted;
-	struct device_node*	media_bay; /* NULL when not in bay */
+	struct macio_dev *mdev;
 	char	dbdma_cmd_space[5 * sizeof(struct dbdma_cmd)];
 };
 
@@ -303,14 +303,13 @@ static int swim3_readbit(struct floppy_s
 static void do_fd_request(struct request_queue * q)
 {
 	int i;
-	for(i=0;i<floppy_count;i++)
-	{
-#ifdef CONFIG_PMAC_MEDIABAY
-		if (floppy_states[i].media_bay &&
-			check_media_bay(floppy_states[i].media_bay, MB_FD))
+
+	for(i=0; i<floppy_count; i++) {
+		struct floppy_state *fs = &floppy_states[i];
+		if (fs->mdev->media_bay &&
+		    check_media_bay(fs->mdev->media_bay) != MB_FD)
 			continue;
-#endif /* CONFIG_PMAC_MEDIABAY */
-		start_request(&floppy_states[i]);
+		start_request(fs);
 	}
 }
 
@@ -849,10 +848,9 @@ static int floppy_ioctl(struct block_dev
 	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-#ifdef CONFIG_PMAC_MEDIABAY
-	if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
+	if (fs->mdev->media_bay &&
+	    check_media_bay(fs->mdev->media_bay) != MB_FD)
 		return -ENXIO;
-#endif
 
 	switch (cmd) {
 	case FDEJECT:
@@ -876,10 +874,9 @@ static int floppy_open(struct block_devi
 	int n, err = 0;
 
 	if (fs->ref_count == 0) {
-#ifdef CONFIG_PMAC_MEDIABAY
-		if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
+		if (fs->mdev->media_bay &&
+		    check_media_bay(fs->mdev->media_bay) != MB_FD)
 			return -ENXIO;
-#endif
 		out_8(&sw->setup, S_IBM_DRIVE | S_FCLK_DIV2);
 		out_8(&sw->control_bic, 0xff);
 		out_8(&sw->mode, 0x95);
@@ -963,10 +960,9 @@ static int floppy_revalidate(struct gend
 	struct swim3 __iomem *sw;
 	int ret, n;
 
-#ifdef CONFIG_PMAC_MEDIABAY
-	if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
+	if (fs->mdev->media_bay &&
+	    check_media_bay(fs->mdev->media_bay) != MB_FD)
 		return -ENXIO;
-#endif
 
 	sw = fs->swim3;
 	grab_drive(fs, revalidating, 0);
@@ -1009,7 +1005,6 @@ static const struct block_device_operati
 static int swim3_add_device(struct macio_dev *mdev, int index)
 {
 	struct device_node *swim = mdev->ofdev.node;
-	struct device_node *mediabay;
 	struct floppy_state *fs = &floppy_states[index];
 	int rc = -EBUSY;
 
@@ -1036,9 +1031,7 @@ static int swim3_add_device(struct macio
 	}
 	dev_set_drvdata(&mdev->ofdev.dev, fs);
 
-	mediabay = (strcasecmp(swim->parent->type, "media-bay") == 0) ?
-		swim->parent : NULL;
-	if (mediabay == NULL)
+	if (mdev->media_bay == NULL)
 		pmac_call_feature(PMAC_FTR_SWIM3_ENABLE, swim, 0, 1);
 	
 	memset(fs, 0, sizeof(*fs));
@@ -1068,7 +1061,7 @@ static int swim3_add_device(struct macio
 	fs->secpercyl = 36;
 	fs->secpertrack = 18;
 	fs->total_secs = 2880;
-	fs->media_bay = mediabay;
+	fs->mdev = mdev;
 	init_waitqueue_head(&fs->wait);
 
 	fs->dma_cmd = (struct dbdma_cmd *) DBDMA_ALIGN(fs->dbdma_cmd_space);
@@ -1093,7 +1086,7 @@ static int swim3_add_device(struct macio
 	init_timer(&fs->timeout);
 
 	printk(KERN_INFO "fd%d: SWIM3 floppy controller %s\n", floppy_count,
-		mediabay ? "in media bay" : "");
+		mdev->media_bay ? "in media bay" : "");
 
 	return 0;
 
