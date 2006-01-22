Return-Path: <cedric.pradalier@free.fr>
Date: Sun, 22 Jan 2006 12:19:07 +1000
From: Cedric Pradalier <cedric.pradalier@free.fr>
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH 001/001] PMAC HD runtime blinking control
Message-Id: <20060122121907.792abc72.cedric.pradalier@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I've finally spend the time to mend the patch for control of
the HD led blinking at runtime. This is a patch against
2.6.15

The sysfs entry is attached to the PCI device and to the
MACIO device if available. I think that was what Ben was
asking for:

lauren-ph:/sys# find . | grep blink
./module/ide_core/parameters/noblink
./devices/pci0001:10/0001:10:17.0/blinking_led
./devices/pci0001:10/0001:10:17.0/0.80000000:mac-io/0.0001f000:ata-4/blinking_led


To activate blinking:
echo 1 > ./devices/pci0001:10/0001:10:17.0/blinking_led

To deactivate it:
echo 0 > ./devices/pci0001:10/0001:10:17.0/blinking_led

There is also a boot time parameter idecore:noblink to
deactivate the blinking at this stage.


signed-off-by: Cedric Pradalier <cedric.pradalier@free.fr>
---

--- drivers/ide/ppc/pmac.c.orig	2006-01-03
13:21:10.000000000 +1000 +++ drivers/ide/ppc/pmac.c
2006-01-22 11:51:11.000000000 +1000 @@ -36,6 +36,11 @@
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
@@ -427,6 +432,15 @@ static void pmac_ide_kauai_selectproc
(id 
 #ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
 
+MODULE_AUTHOR("Paul Mackerras & Ben. Herrenschmidt");
+MODULE_DESCRIPTION("Support for IDE interfaces on
PowerMacs"); +MODULE_LICENSE("GPL");
+
+static int blinking_led = 1;
+module_param_named(noblink,blinking_led, invbool, 0666);
+MODULE_PARM_DESC(noblink,"Enable/Disable blinking led
[Default: enabled]"); +
+
 /* Set to 50ms minimum led-on time (also used to limit
frequency
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
+	if (!blinking_led)
+		return;
 	
 	pmu_blink_stoptime = jiffies + PMU_HD_BLINK_TIME;
 	wmb();
@@ -483,8 +498,28 @@ pmu_hd_kick_blink(void *data, int rw)
 	spin_unlock_irqrestore(&pmu_blink_lock, flags);
 }
 
+static ssize_t show_blinkingled_activity(struct device
*dev, struct device_attribute *attr, char *buf)\ +{  
+	return sprintf(buf, "%c\n", blinking_led?'1':'0'); 
+}
+
+static ssize_t set_blinkingled_activity(struct device
*dev, struct device_attribute *attr, 
+		const char *buf, size_t count)
+{
+	int blink;
+	if (sscanf (buf, "%d", &blink) != 1)
+		return -EINVAL;
+	blinking_led = (blink != 0);
+	printk(KERN_INFO "pmac blinking led initialized
(blink %s)\n",
+			blinking_led?"enabled":"disabled");
+	return count;
+}
+
+static DEVICE_ATTR (blinking_led, S_IRUGO | S_IWUSR, 
+		show_blinkingled_activity,
set_blinkingled_activity); +
 static int
-pmu_hd_blink_init(void)
+pmu_hd_blink_init(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
 {
 	struct device_node *dt;
 	const char *model;
@@ -516,6 +551,13 @@ pmu_hd_blink_init(void)
 	init_timer(&pmu_blink_timer);
 	pmu_blink_timer.function = pmu_hd_blink_timeout;
 
+	device_create_file (&hwif->pci_dev->dev,
&dev_attr_blinking_led);
+	if (pmif->mdev != NULL)
+		device_create_file
(&pmif->mdev->ofdev.dev, &dev_attr_blinking_led);
+	
+	printk(KERN_INFO "pmac blinking led initialized
(blink %s)\n",
+			blinking_led?"enabled":"disabled");
+
 	return 1;
 }
 
@@ -1271,7 +1313,7 @@ static int
 pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t
*hwif) {
 	struct device_node *np = pmif->node;
-	int *bidp, i;
+	int *bidp;
 
 	pmif->cable_80 = 0;
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
@@ -1375,7 +1417,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t
*p hwif->speedproc = pmac_ide_tune_chipset;
 
 #ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
-	pmu_ide_blink_enabled = pmu_hd_blink_init();
+	pmu_ide_blink_enabled = pmu_hd_blink_init
(pmif,hwif); 
 	if (pmu_ide_blink_enabled)
 		hwif->led_act = pmu_hd_kick_blink;
@@ -1476,6 +1518,7 @@ pmac_ide_macio_attach(struct
macio_dev * #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 	dev_set_drvdata(&mdev->ofdev.dev, hwif);
 
+	printk(KERN_INFO "pmac: using macio interface");
 	rc = pmac_ide_setup_device(pmif, hwif);
 	if (rc != 0) {
 		/* The inteface is released to the common
IDE layer */ @@ -1584,6 +1627,7 @@ pmac_ide_pci_attach
(struct pci_dev *pdev 
 	pci_set_drvdata(pdev, hwif);
 
+	printk(KERN_INFO "pmac: using PCI interface");
 	rc = pmac_ide_setup_device(pmif, hwif);
 	if (rc != 0) {
 		/* The inteface is released to the common
IDE layer */
