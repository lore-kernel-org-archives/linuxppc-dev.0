Message-ID: <404DB15D.9050102@elitedvb.net>
Date: Tue, 09 Mar 2004 12:58:21 +0100
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: IBM OCP IDE fixes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

it seems that there's a bug in drivers/ide/ppc/ibm_ocp_ide.c, in
ocp_ide_build_dmatable in the current (linuxppc) 2.6.
Explanation: pvprv gets initialized to NULL, and for each bio segment
BIOVEC_PHYS_MERGEABLE will be called to see if it can be merged with the
previous one. In the first iteration, this will fail, giving a
null-pointer to BIOVEC_PHYS_MERGEABLE, which doesn't check for this
condition, leading to an Oops.

As the first segment can never be merged with something else, checking
for a null pvprv should be enough.


Speaking of the ibm_ocp_ide.c, it should be inserted into the Makefile
in drivers/ide ("ide-core-$(CONFIG_BLK_DEV_IDE_STB04xxx) +=
ppc/ibm_ocp_ide.o"), and the std_ide_cntl must be called. Not sure if my
patch is the correct way here.

Additionally, the ocp driver issues IDE commands on his own in dma mode,
which is wrong for 48bit addressing. I made simple workaround, but a
more generic function might be called instead.

Then there are some simple compile fixes (missing headerfile, which
isn't of any use anyway and replacement of hw_init_dma_channel against
ppc4xx_init_dma_channel). ide_dma_off seems to be not required anymore.

Finally, the udelay(1000*1000) have to be replaced by mdelay(1000) in
the spinup wait. Maybe this loop should be replaced by the more generic
IDE spinup loop.

Comments?


Felix

diff -Naur linuxppc-2.5-vanilla/drivers/ide/Makefile
linux-2.6/drivers/ide/Makefile
--- linuxppc-2.5-vanilla/drivers/ide/Makefile    2004-03-02
22:17:17.000000000 +0100
+++ linux-2.6/drivers/ide/Makefile    2004-03-04 18:33:12.000000000 +0100
@@ -37,6 +37,7 @@
 ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)    += ppc/mpc8xx.o
 ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)    += ppc/pmac.o
 ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)    += ppc/swarm.o
+ide-core-$(CONFIG_BLK_DEV_IDE_STB04xxx) += ppc/ibm_ocp_ide.o

 obj-$(CONFIG_BLK_DEV_IDE)        += ide-core.o
 obj-$(CONFIG_IDE_GENERIC)        += ide-generic.o
diff -Naur linuxppc-2.5-vanilla/drivers/ide/ide.c
linux-2.6/drivers/ide/ide.c
--- linuxppc-2.5-vanilla/drivers/ide/ide.c    2004-03-02
22:16:11.000000000 +0100
+++ linux-2.6/drivers/ide/ide.c    2004-03-04 18:33:12.000000000 +0100
@@ -2156,7 +2156,7 @@
         pnpide_init(1);
     }
 #endif /* CONFIG_BLK_DEV_IDEPNP */
-#ifdef CONFIG_BLK_DEV_STD
+#if defined(CONFIG_BLK_DEV_STD) || defined(CONFIG_BLK_DEV_IDE_STB04xxx)
     {
         extern void std_ide_cntl_scan(void);
         std_ide_cntl_scan();
--- linuxppc-2.5-vanilla/drivers/ide/ppc/ibm_ocp_ide.c    2004-03-02
22:16:52.000000000 +0100
+++ linux-2.6/drivers/ide/ppc/ibm_ocp_ide.c    2004-03-04
19:04:29.000000000 +0100
@@ -23,7 +23,7 @@
 #include <asm/scatterlist.h>
 #include <asm/ppc4xx_dma.h>

-#include "ide_modes.h"
+// #include "ide_modes.h"

 #define IDE_VER            "2.0"
 ppc_dma_ch_t dma_ch;
@@ -383,8 +383,8 @@
             else
                 consistent_sync((void *)vaddr,
                         size, PCI_DMA_FROMDEVICE);

-            if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec)) {
+            if (bvprv && !BIOVEC_PHYS_MERGEABLE(bvprv, bvec)) {
                 if (ocp_ide_build_prd_entry(&table,
                                 prd_paddr,
                                 prd_size,
@@ -581,12 +580,18 @@
 {
     if (!ocp_ide_build_dmatable(drive, writing))
         return 1;
+
+    int lba48bit;

     drive->waiting_for_dma = 1;
     if (drive->media != ide_disk)
         return 0;
+
+    lba48bit = ((drive->id->cfs_enable_2 & 0x0400) ? 1 : 0) &&
(drive->addressing);
+
     ide_set_handler(drive, &ocp_ide_dma_intr, WAIT_CMD, NULL);
-    HWIF(drive)->OUTB(writing ? WIN_WRITEDMA : WIN_READDMA,
+    HWIF(drive)->OUTB(writing ? (lba48bit ? WIN_WRITEDMA_EXT :
WIN_WRITEDMA)
+        : (lba48bit ? WIN_READDMA_EXT : WIN_READDMA),
          IDE_COMMAND_REG);
     return __ocp_ide_dma_begin(drive, writing);
 }
@@ -642,7 +647,7 @@
         if ((stat & 0x80) == 0) {
             break;
         }
-        udelay(1000 * 1000);    /* 1 second */
+        mdelay(1000);    /* 1 second */
     }

     printk(".");
@@ -657,7 +662,7 @@
         if ((stat & 0x80) == 0) {
             break;
         }
-        udelay(1000 * 1000);    /* 1 second */
+        mdelay(1000);    /* 1 second */
     }
     if( i < 30){
         outb_p(0xa0, io_ports[6]);
@@ -715,7 +720,7 @@
     dma_ch.ch_enable = 0;        /* No chaining */
     dma_ch.tcd_disable = 1;        /* No chaining */

-    if (hw_init_dma_channel(IDE_DMACH, &dma_ch) != DMA_STATUS_GOOD)
+    if (ppc4xx_init_dma_channel(IDE_DMACH, &dma_ch) != DMA_STATUS_GOOD)
         return -EBUSY;

     /* init CIC select2 reg to connect external DMA port 3 to internal
@@ -772,8 +777,10 @@

     if(!ocp_ide_spinup(hwif->index))
         return 0;
-
-    return 1;
+
+      probe_hwif_init(hwif);
+
+        return 1;
 }


@@ -821,7 +829,6 @@
     ide_hwifs[index].tuneproc = &ocp_ide_tune_drive;
     ide_hwifs[index].drives[0].autotune = 1;
     ide_hwifs[index].autodma = 1;
-    ide_hwifs[index].ide_dma_off = &ocp_ide_dma_off;
     ide_hwifs[index].ide_dma_off_quietly = &ocp_ide_dma_off_quietly;
     ide_hwifs[index].ide_dma_host_off = &ocp_ide_dma_off_quietly;
     ide_hwifs[index].ide_dma_on = &ocp_ide_dma_on;
@@ -839,7 +847,9 @@
     memcpy(ide_hwifs[index].io_ports, hw->io_ports, sizeof (hw->io_ports));
     ide_hwifs[index].irq = pdev->irq;

+    setup_ocp_ide(pdev);
     ocp_force_power_on(pdev);
+
     return 1;
 }

@@ -874,12 +884,15 @@
     printk("OCP ide ver:%s\n", IDE_VER);

     ocp_module_init(&ocp_ide_driver);
+#if 0
     max = ocp_get_num(OCP_FUNC_IDE);
     for(i = 0; i < max; i++){
         dev = ocp_get_dev(OCP_FUNC_IDE,i);
         if(!dev)
           setup_ocp_ide(dev);
     }
+#endif
+
 }
 #if 0
 #if defined (CONFIG_MODULE)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
