From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5.xx
Date: Sun, 6 Oct 2002 11:48:25 +0200
References: <200210052303.g95N3mD312030@saturn.cs.uml.edu>
In-Reply-To: <200210052303.g95N3mD312030@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_PK0KHDCHXBDCYXSO15I1"
Message-Id: <200210061148.25333@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_PK0KHDCHXBDCYXSO15I1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Sunday 06 October 2002 01:03, Albert D. Cahalan wrote:
> Anybody with 2.5.xx running? I need the very latest code
> to run on my Mac Cube.
>
> Linus's BitKeeper tree stops compiling when it hits the
> ppc signal code, with some complaint about a lock. With
> that fixed, the build stops in the Mac IDE code with a
> complaint about something missing from a struct.
>
> So I gave up on that and got the linuxppc-2.5 BitKeeper
> tree instead. Compiling fails for several things, all of
> which I reluctantly disable: ieee1394, Mac serial ports,
> the OpenFirmware framebuffer... and I even fixed an
> include for FASTCALL in include/linux/workqueue.h before
> getting stopped with a link error that appears to be
> video-related. Any fix? I need the aty128fb driver.
>
>         ld  -Ttext 0xc0000000 -Bstatic -T arch/ppc/vmlinux.lds.s
> arch/ppc/kernel/head.o  init/built-in.o --start-group
> arch/ppc/kernel/built-in.o  arch/ppc/platforms/built-in.o
> arch/ppc/mm/built-in.o  arch/ppc/lib/built-in.o kernel/built-in.o
> mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a
> drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group  -o
> vmlinux drivers/built-in.o(.data+0x2df68): undefined reference to
> `cfb_fillrect' drivers/built-in.o(.data+0x2df6c): undefined reference to
> `cfb_copyarea' drivers/built-in.o(.data+0x2df70): undefined reference to
> `cfb_imageblit' make: *** [vmlinux] Error 1

Try the attached patch, it works for me. It fixes aty128 linking, sound as
modules and AEC6280 IDE initialization. ieee1394 is a generic 2.5 problem, it
hasn't been fully ported to 2.5 yet. offb probably needs porting to the new
FB API. For macserial, I _think_ paulus/benh talked about that, expect a fix
soon.

Generally try to repull quite often as Paul and Tom do an extremely good job
keeping linuxppc-2.5 uptodate with Linus.

Franz.


--------------Boundary-00=_PK0KHDCHXBDCYXSO15I1
Content-Type: text/plain;
  charset="iso-8859-1";
  name="bk-all-32.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="bk-all-32.diff"

===== arch/ppc/kernel/ppc_ksyms.c 1.32 vs edited =====
--- 1.32/arch/ppc/kernel/ppc_ksyms.c	Mon Sep 16 08:16:37 2002
+++ edited/arch/ppc/kernel/ppc_ksyms.c	Mon Sep 16 18:26:38 2002
@@ -30,6 +30,8 @@
 #include <linux/pmu.h>
 #include <asm/prom.h>
 #include <asm/system.h>
+#define __KERNEL_SYSCALLS__
+#include <asm/unistd.h>
 #include <asm/pci-bridge.h>
 #include <asm/irq.h>
 #include <asm/pmac_feature.h>
@@ -180,6 +182,10 @@
 EXPORT_SYMBOL(consistent_sync);
 #endif

+EXPORT_SYMBOL(open);
+EXPORT_SYMBOL(read);
+EXPORT_SYMBOL(lseek);
+EXPORT_SYMBOL(close);
 EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(kernel_thread);

===== drivers/ide/ide-iops.c 1.2 vs edited =====
--- 1.2/drivers/ide/ide-iops.c	Tue Oct  1 12:40:28 2002
+++ edited/drivers/ide/ide-iops.c	Sat Oct  5 13:21:08 2002
@@ -358,90 +358,90 @@
 	int i;
 	u16 *stringcast;

-	id->config         = __le16_to_cpu(id->config);
-	id->cyls           = __le16_to_cpu(id->cyls);
-	id->reserved2      = __le16_to_cpu(id->reserved2);
-	id->heads          = __le16_to_cpu(id->heads);
-	id->track_bytes    = __le16_to_cpu(id->track_bytes);
-	id->sector_bytes   = __le16_to_cpu(id->sector_bytes);
-	id->sectors        = __le16_to_cpu(id->sectors);
-	id->vendor0        = __le16_to_cpu(id->vendor0);
-	id->vendor1        = __le16_to_cpu(id->vendor1);
-	id->vendor2        = __le16_to_cpu(id->vendor2);
+	__le16_to_cpus(&id->config);
+	__le16_to_cpus(&id->cyls);
+	__le16_to_cpus(&id->reserved2);
+	__le16_to_cpus(&id->heads);
+	__le16_to_cpus(&id->track_bytes);
+	__le16_to_cpus(&id->sector_bytes);
+	__le16_to_cpus(&id->sectors);
+	__le16_to_cpus(&id->vendor0);
+	__le16_to_cpus(&id->vendor1);
+	__le16_to_cpus(&id->vendor2);
 	stringcast = (u16 *)&id->serial_no[0];
 	for (i = 0; i < (20/2); i++)
-		stringcast[i] = __le16_to_cpu(stringcast[i]);
-	id->buf_type       = __le16_to_cpu(id->buf_type);
-	id->buf_size       = __le16_to_cpu(id->buf_size);
-	id->ecc_bytes      = __le16_to_cpu(id->ecc_bytes);
+		__le16_to_cpus(&stringcast[i]);
+	__le16_to_cpus(&id->buf_type);
+	__le16_to_cpus(&id->buf_size);
+	__le16_to_cpus(&id->ecc_bytes);
 	stringcast = (u16 *)&id->fw_rev[0];
 	for (i = 0; i < (8/2); i++)
-		stringcast[i] = __le16_to_cpu(stringcast[i]);
+		__le16_to_cpus(&stringcast[i]);
 	stringcast = (u16 *)&id->model[0];
 	for (i = 0; i < (40/2); i++)
-		stringcast[i] = __le16_to_cpu(stringcast[i]);
-	id->dword_io       = __le16_to_cpu(id->dword_io);
-	id->reserved50     = __le16_to_cpu(id->reserved50);
-	id->field_valid    = __le16_to_cpu(id->field_valid);
-	id->cur_cyls       = __le16_to_cpu(id->cur_cyls);
-	id->cur_heads      = __le16_to_cpu(id->cur_heads);
-	id->cur_sectors    = __le16_to_cpu(id->cur_sectors);
-	id->cur_capacity0  = __le16_to_cpu(id->cur_capacity0);
-	id->cur_capacity1  = __le16_to_cpu(id->cur_capacity1);
-	id->lba_capacity   = __le32_to_cpu(id->lba_capacity);
-	id->dma_1word      = __le16_to_cpu(id->dma_1word);
-	id->dma_mword      = __le16_to_cpu(id->dma_mword);
-	id->eide_pio_modes = __le16_to_cpu(id->eide_pio_modes);
-	id->eide_dma_min   = __le16_to_cpu(id->eide_dma_min);
-	id->eide_dma_time  = __le16_to_cpu(id->eide_dma_time);
-	id->eide_pio       = __le16_to_cpu(id->eide_pio);
-	id->eide_pio_iordy = __le16_to_cpu(id->eide_pio_iordy);
+		__le16_to_cpus(&stringcast[i]);
+	__le16_to_cpus(&id->dword_io);
+	__le16_to_cpus(&id->reserved50);
+	__le16_to_cpus(&id->field_valid);
+	__le16_to_cpus(&id->cur_cyls);
+	__le16_to_cpus(&id->cur_heads);
+	__le16_to_cpus(&id->cur_sectors);
+	__le16_to_cpus(&id->cur_capacity0);
+	__le16_to_cpus(&id->cur_capacity1);
+	__le32_to_cpus(&id->lba_capacity);
+	__le16_to_cpus(&id->dma_1word);
+	__le16_to_cpus(&id->dma_mword);
+	__le16_to_cpus(&id->eide_pio_modes);
+	__le16_to_cpus(&id->eide_dma_min);
+	__le16_to_cpus(&id->eide_dma_time);
+	__le16_to_cpus(&id->eide_pio);
+	__le16_to_cpus(&id->eide_pio_iordy);
 	for (i = 0; i < 2; ++i)
-		id->words69_70[i] = __le16_to_cpu(id->words69_70[i]);
+		__le16_to_cpus(&id->words69_70[i]);
 	for (i = 0; i < 4; ++i)
-		id->words71_74[i] = __le16_to_cpu(id->words71_74[i]);
-	id->queue_depth    = __le16_to_cpu(id->queue_depth);
+		__le16_to_cpus(&id->words71_74[i]);
+	__le16_to_cpus(&id->queue_depth);
 	for (i = 0; i < 4; ++i)
-		id->words76_79[i] = __le16_to_cpu(id->words76_79[i]);
-	id->major_rev_num  = __le16_to_cpu(id->major_rev_num);
-	id->minor_rev_num  = __le16_to_cpu(id->minor_rev_num);
-	id->command_set_1  = __le16_to_cpu(id->command_set_1);
-	id->command_set_2  = __le16_to_cpu(id->command_set_2);
-	id->cfsse          = __le16_to_cpu(id->cfsse);
-	id->cfs_enable_1   = __le16_to_cpu(id->cfs_enable_1);
-	id->cfs_enable_2   = __le16_to_cpu(id->cfs_enable_2);
-	id->csf_default    = __le16_to_cpu(id->csf_default);
-	id->dma_ultra      = __le16_to_cpu(id->dma_ultra);
-	id->trseuc         = __le16_to_cpu(id->trseuc);
-	id->trsEuc         = __le16_to_cpu(id->trsEuc);
-	id->CurAPMvalues   = __le16_to_cpu(id->CurAPMvalues);
-	id->mprc           = __le16_to_cpu(id->mprc);
-	id->hw_config      = __le16_to_cpu(id->hw_config);
-	id->acoustic       = __le16_to_cpu(id->acoustic);
-	id->msrqs          = __le16_to_cpu(id->msrqs);
-	id->sxfert         = __le16_to_cpu(id->sxfert);
-	id->sal            = __le16_to_cpu(id->sal);
-	id->spg            = __le32_to_cpu(id->spg);
-	id->lba_capacity_2 = __le64_to_cpu(id->lba_capacity_2);
+		__le16_to_cpus(&id->words76_79[i]);
+	__le16_to_cpus(&id->major_rev_num);
+	__le16_to_cpus(&id->minor_rev_num);
+	__le16_to_cpus(&id->command_set_1);
+	__le16_to_cpus(&id->command_set_2);
+	__le16_to_cpus(&id->cfsse);
+	__le16_to_cpus(&id->cfs_enable_1);
+	__le16_to_cpus(&id->cfs_enable_2);
+	__le16_to_cpus(&id->csf_default);
+	__le16_to_cpus(&id->dma_ultra);
+	__le16_to_cpus(&id->trseuc);
+	__le16_to_cpus(&id->trsEuc);
+	__le16_to_cpus(&id->CurAPMvalues);
+	__le16_to_cpus(&id->mprc);
+	__le16_to_cpus(&id->hw_config);
+	__le16_to_cpus(&id->acoustic);
+	__le16_to_cpus(&id->msrqs);
+	__le16_to_cpus(&id->sxfert);
+	__le16_to_cpus(&id->sal);
+	__le32_to_cpus(&id->spg);
+	__le64_to_cpus(&id->lba_capacity_2);
 	for (i = 0; i < 22; i++)
-		id->words104_125[i]   = __le16_to_cpu(id->words104_125[i]);
-	id->last_lun       = __le16_to_cpu(id->last_lun);
-	id->word127        = __le16_to_cpu(id->word127);
-	id->dlf            = __le16_to_cpu(id->dlf);
-	id->csfo           = __le16_to_cpu(id->csfo);
+		__le16_to_cpus(&id->words104_125[i]);
+	__le16_to_cpus(&id->last_lun);
+	__le16_to_cpus(&id->word127);
+	__le16_to_cpus(&id->dlf);
+	__le16_to_cpus(&id->csfo);
 	for (i = 0; i < 26; i++)
-		id->words130_155[i] = __le16_to_cpu(id->words130_155[i]);
-	id->word156        = __le16_to_cpu(id->word156);
+		__le16_to_cpus(&id->words130_155[i]);
+	__le16_to_cpus(&id->word156);
 	for (i = 0; i < 3; i++)
-		id->words157_159[i] = __le16_to_cpu(id->words157_159[i]);
-	id->cfa_power      = __le16_to_cpu(id->cfa_power);
+		__le16_to_cpus(&id->words157_159[i]);
+	__le16_to_cpus(&id->cfa_power);
 	for (i = 0; i < 14; i++)
-		id->words161_175[i] = __le16_to_cpu(id->words161_175[i]);
+		__le16_to_cpus(&id->words161_175[i]);
 	for (i = 0; i < 31; i++)
-		id->words176_205[i] = __le16_to_cpu(id->words176_205[i]);
+		__le16_to_cpus(&id->words176_205[i]);
 	for (i = 0; i < 48; i++)
-		id->words206_254[i] = __le16_to_cpu(id->words206_254[i]);
-	id->integrity_word  = __le16_to_cpu(id->integrity_word);
+		__le16_to_cpus(&id->words206_254[i]);
+	__le16_to_cpus(&id->integrity_word);
 # else
 #  error "Please fix <asm/byteorder.h>"
 # endif
===== drivers/ide/pci/aec62xx.c 1.6 vs edited =====
--- 1.6/drivers/ide/pci/aec62xx.c	Tue Oct  1 12:40:28 2002
+++ edited/drivers/ide/pci/aec62xx.c	Sat Oct  5 13:21:09 2002
@@ -410,6 +410,31 @@
 static unsigned int __init init_chipset_aec62xx (struct pci_dev *dev, const char *name)
 {
 	int bus_speed = system_bus_clock();
+  u8 reg49h = 0;
+  u8 reg4ah = 0;
+
+  switch(dev->device)
+    {
+    case PCI_DEVICE_ID_ARTOP_ATP865:
+    case PCI_DEVICE_ID_ARTOP_ATP865R:
+      /* Clear reset and test bits.  */
+      pci_read_config_byte(dev, 0x49, &reg49h);
+      pci_write_config_byte(dev, 0x49, reg49h & ~0x30);
+      /* Enable chip interrupt output.  */
+      pci_read_config_byte(dev, 0x4a, &reg4ah);
+      pci_write_config_byte(dev, 0x4a, reg4ah & ~0x01);
+#define CONFIG_AEC6280_BURST
+#ifdef CONFIG_AEC6280_BURST
+      /* Must be greater than 0x80 for burst mode.  */
+      pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x90);
+      /* Enable burst mode.  */
+      pci_read_config_byte(dev, 0x4a, &reg4ah);
+      pci_write_config_byte(dev, 0x4a, reg4ah | 0x80);
+#endif
+      break;
+    default:
+      break;
+    }

 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
===== drivers/video/Makefile 1.38 vs edited =====
--- 1.38/drivers/video/Makefile	Fri Sep  6 01:31:08 2002
+++ edited/drivers/video/Makefile	Tue Sep 10 19:54:57 2002
@@ -43,7 +43,7 @@
 obj-$(CONFIG_FB_APOLLO)           += dnfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_Q40)              += q40fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o
-obj-$(CONFIG_FB_ATY128)           += aty128fb.o
+obj-$(CONFIG_FB_ATY128)           += aty128fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_RADEON)		  += radeonfb.o
 obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_IGA)              += igafb.o
===== drivers/video/aty128fb.c 1.16 vs edited =====
--- 1.16/drivers/video/aty128fb.c	Mon Aug 19 14:45:44 2002
+++ edited/drivers/video/aty128fb.c	Tue Sep 10 19:54:58 2002
@@ -248,11 +248,6 @@

 static char *mode_option __initdata = NULL;

-#ifdef CONFIG_ALL_PPC
-static int default_vmode __initdata = VMODE_1024_768_60;
-static int default_cmode __initdata = CMODE_8;
-#endif
-
 #ifdef CONFIG_PMAC_PBOOK
 static int default_crt_on __initdata = 0;
 static int default_lcd_on __initdata = 1;
@@ -1442,30 +1437,6 @@
 			mtrr = 0;
 		}
 #endif
-#ifdef CONFIG_ALL_PPC
-		/* vmode and cmode depreciated */
-		else if (!strncmp(this_opt, "vmode:", 6)) {
-			unsigned int vmode = simple_strtoul(this_opt+6, NULL, 0);
-			if (vmode > 0 && vmode <= VMODE_MAX)
-				default_vmode = vmode;
-		} else if (!strncmp(this_opt, "cmode:", 6)) {
-			unsigned int cmode = simple_strtoul(this_opt+6, NULL, 0);
-			switch (cmode) {
-			case 0:
-			case 8:
-				default_cmode = CMODE_8;
-				break;
-			case 15:
-			case 16:
-				default_cmode = CMODE_16;
-				break;
-			case 24:
-			case 32:
-				default_cmode = CMODE_32;
-				break;
-			}
-		}
-#endif /* CONFIG_ALL_PPC */
 		else
 			mode_option = this_opt;
 	}
@@ -1524,13 +1495,7 @@
 	var = default_var;
 #ifdef CONFIG_ALL_PPC
 	if (_machine == _MACH_Pmac) {
-		if (mode_option) {
-			if (!mac_find_mode(&var, info, mode_option, 8))
-				var = default_var;
-		} else {
-			if (default_vmode <= 0 || default_vmode > VMODE_MAX)
-				default_vmode = VMODE_1024_768_60;
-
+		if (!mode_option) {
 			/* iMacs need that resolution
 			 * PowerMac2,1 first r128 iMacs
 			 * PowerMac2,2 summer 2000 iMacs
@@ -1539,27 +1504,22 @@
 			if (machine_is_compatible("PowerMac2,1") ||
 			    machine_is_compatible("PowerMac2,2") ||
 			    machine_is_compatible("PowerMac4,1"))
-				default_vmode = VMODE_1024_768_75;
+				mode_option = "mac1024x768-8@75";

 			/* iBook SE */
-			if (machine_is_compatible("PowerBook2,2"))
-				default_vmode = VMODE_800_600_60;
-
-			/* PowerBook Firewire (Pismo), iBook Dual USB */
-			if (machine_is_compatible("PowerBook3,1") ||
-			    machine_is_compatible("PowerBook4,1"))
-				default_vmode = VMODE_1024_768_60;
+			else if (machine_is_compatible("PowerBook2,2"))
+				mode_option = "mac800x600-8@60";

 			/* PowerBook Titanium */
-			if (machine_is_compatible("PowerBook3,2"))
-				default_vmode = VMODE_1152_768_60;
-
-			if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
-				default_cmode = CMODE_8;
+			else if (machine_is_compatible("PowerBook3,2"))
+				mode_option = "mac1152x768-8@60";

-			if (mac_vmode_to_var(default_vmode, default_cmode, &var))
-				var = default_var;
+			/* default */
+			else
+				mode_option = "mac1024x768-8@60";
 		}
+		if (mac_find_mode(&var, info, mode_option, 8) == 0)
+			var = default_var;
 	} else
 #endif /* CONFIG_ALL_PPC */
 	{
===== sound/sound_firmware.c 1.3 vs edited =====
--- 1.3/sound/sound_firmware.c	Sun Dec 30 10:47:19 2001
+++ edited/sound/sound_firmware.c	Mon Sep 30 22:54:40 2002
@@ -1,3 +1,4 @@
+#include <linux/mm.h>
 #include <linux/vmalloc.h>
 #define __KERNEL_SYSCALLS__
 #include <linux/module.h>
===== sound/core/info.c 1.9 vs edited =====
--- 1.9/sound/core/info.c	Tue Oct  1 19:06:28 2002
+++ edited/sound/core/info.c	Thu Oct  3 11:14:31 2002
@@ -21,6 +21,7 @@

 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
===== sound/ppc/pmac.c 1.9 vs edited =====
--- 1.9/sound/ppc/pmac.c	Tue Oct  1 19:08:34 2002
+++ edited/sound/ppc/pmac.c	Thu Oct  3 11:33:46 2002
@@ -883,7 +883,7 @@
 	pmac_t *chip = snd_magic_cast(pmac_t, _snd_kcontrol_chip(control),);
 	if (chip->beep) {
 		/* restore */
-		kd_mksound = chip->beep->orig_mksound;
+//		kd_mksound = chip->beep->orig_mksound;
 		kfree(chip->beep->buf);
 		kfree(chip->beep);
 		chip->beep = NULL;
@@ -909,7 +909,7 @@
 	init_timer(&beep->timer);
 	beep->timer.function = snd_pmac_beep_stop_callback;
 	beep->timer.data = (unsigned long) chip;
-	beep->orig_mksound = kd_mksound;
+//	beep->orig_mksound = kd_mksound;
 	beep->volume = BEEP_VOLUME;
 	beep->running = 0;
 	beep->control = snd_ctl_new1(&snd_pmac_beep_mixer, chip);
@@ -926,7 +926,7 @@
 	/* hook */
 	beeping_chip = chip;
 	chip->beep = beep;
-	kd_mksound = snd_pmac_mksound;
+//	kd_mksound = snd_pmac_mksound;

 	return 0;
 }

--------------Boundary-00=_PK0KHDCHXBDCYXSO15I1--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
