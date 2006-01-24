Return-Path: <cedric.pradalier@inrialpes.fr>
Date: Tue, 24 Jan 2006 22:25:13 +1000
From: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 001/001 Updated again] PMAC HD runtime blinking control
Message-Id: <20060124222513.48ef0276.cedric.pradalier@inrialpes.fr>
In-Reply-To: <1138057827.4907.30.camel@localhost.localdomain>
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
	<1137898193.12998.83.camel@localhost.localdomain>
	<20060123233823.3f0dbad5.cedric.pradalier@inrialpes.fr>
	<1138024037.4907.24.camel@localhost.localdomain>
	<20060124073133.5cab0e93.cedric.pradalier@inrialpes.fr>
	<1138057827.4907.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to Benjamin Herrenschmidt, on Tue, 24 Jan 2006
10:10:26 +1100, 
>On Tue, 2006-01-24 at 07:31 +1000, Cedric Pradalier wrote:
>> >
>> >Yes. In fact, by enabled default for ATA disks and by disabled for ATAPI
>> >would make sense...
>> 
>> How do I tell the difference?. There is a 'kind' in pmif,
>> and also a atapi_dma flag in hwif. Which is more sensible?
>
>You need to check drive->media ... Which is a bit annoying since it mans
>it's per drive, not per-HWIF... you may want to move your sysfs entry
>down one more level :) (Each HWIF has an array of 2 drives, though check
>drive->present before expecting a useful struct device there)
>

Well in this case, I'll let this part waiting for now. 
I don't think there will be enough real users of this minor
thing to justify putting any more efforts for now.

I think the practical solution is to disable the led by
default. The few user who will want it will be able to add
either ide_core.blink to their boot parameter or make a
small init.d script to put 1 into the sysfs entry.

That's the way I've implemented it, and  I've changed the
name into activity_led.

pradalier@localhost:~$ find /sys/ -name activity_led
/sys/devices/pci0001:10/0001:10:17.0/0.80000000:mac-io/0.0001f000:ata-4/ide0/activity_led

This is the updated version of the patch. I, for one, will
consider it stable now.

signed-off-by: Cedric Pradalier <cedric.pradalier@free.fr>
---
--- drivers/ide/ppc/pmac.c.orig	2006-01-03 13:21:10.000000000 +1000
+++ drivers/ide/ppc/pmac.c	2006-01-24 21:18:36.000000000 +1000
@@ -36,6 +36,11 @@
 #include <linux/pmu.h>
 #include <linux/scatterlist.h>
 
+#ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
+#include <linux/device.h>
+#include <asm/of_device.h>
+#endif
+
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
@@ -427,6 +432,15 @@ static void pmac_ide_kauai_selectproc(id
 
 #ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
 
+MODULE_AUTHOR("Paul Mackerras & Ben. Herrenschmidt");
+MODULE_DESCRIPTION("Support for IDE interfaces on PowerMacs");
+MODULE_LICENSE("GPL");
+
+static int activity_led = 0;
+module_param_named(blink,activity_led, bool, 0666);
+MODULE_PARM_DESC(blink,"Enable/Disable activity led [Default: disabled]");
+
+
 /* Set to 50ms minimum led-on time (also used to limit frequency
  * of requests sent to the PMU
  */
@@ -437,8 +451,7 @@ static spinlock_t pmu_blink_lock;
 static unsigned long pmu_blink_stoptime;
 static int pmu_blink_ledstate;
 static struct timer_list pmu_blink_timer;
-static int pmu_ide_blink_enabled;
-
+static int pmu_ide_blink_enabled = 0;
 
 static void
 pmu_hd_blink_timeout(unsigned long data)
@@ -468,6 +481,8 @@ static void
 pmu_hd_kick_blink(void *data, int rw)
 {
 	unsigned long flags;
+	if (!activity_led)
+		return;
 	
 	pmu_blink_stoptime = jiffies + PMU_HD_BLINK_TIME;
 	wmb();
@@ -483,6 +498,26 @@ pmu_hd_kick_blink(void *data, int rw)
 	spin_unlock_irqrestore(&pmu_blink_lock, flags);
 }
 
+static ssize_t show_activity_led_enable(struct device *dev, struct device_attribute *attr, char *buf)\
+{  
+	return sprintf(buf, "%c\n", activity_led?'1':'0'); 
+}
+
+static ssize_t set_activity_led_enable(struct device *dev, struct device_attribute *attr, 
+		const char *buf, size_t count)
+{
+	int blink=0;
+	if (sscanf (buf, "%d", &blink) != 1)
+		return -EINVAL;
+	activity_led = (blink != 0);
+	printk(KERN_INFO "pmac blinking led initialized (blink %s)\n",
+			activity_led?"enabled":"disabled");
+	return count;
+}
+
+static DEVICE_ATTR (activity_led, S_IRUGO | S_IWUSR, 
+		show_activity_led_enable, set_activity_led_enable);
+
 static int
 pmu_hd_blink_init(void)
 {
@@ -516,6 +551,9 @@ pmu_hd_blink_init(void)
 	init_timer(&pmu_blink_timer);
 	pmu_blink_timer.function = pmu_hd_blink_timeout;
 
+	printk(KERN_INFO "pmac blinking led initialized (blink %s)\n",
+			activity_led?"enabled":"disabled");
+
 	return 1;
 }
 
@@ -1271,7 +1309,7 @@ static int
 pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
 {
 	struct device_node *np = pmif->node;
-	int *bidp, i;
+	int *bidp;
 
 	pmif->cable_80 = 0;
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
@@ -1401,6 +1439,12 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	/* We probe the hwif now */
 	probe_hwif_init(hwif);
 
+#ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
+	/* We wait till here to have the gendev initialized in hwif */
+	device_create_file (&hwif->gendev, &dev_attr_activity_led);
+#endif
+
+
 	return 0;
 }
 
