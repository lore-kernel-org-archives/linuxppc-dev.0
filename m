Return-Path: <posco.grubb@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 72E17DDDA9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 00:30:07 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so307221waf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 06:30:06 -0700 (PDT)
Date: Thu, 19 Mar 2009 22:30:01 +0900
From: TOMARI Hisanobu <posco.grubb@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: IDE cable detection on Apple PowerBook
Message-Id: <20090319223001.c2674366.posco.grubb@gmail.com>
In-Reply-To: <1237442917.25062.467.camel@pasglop>
References: <20090318140638.e6b61eaa.posco.grubb@gmail.com>
	<1237363097.25062.345.camel@pasglop>
	<20090318224726.5cf83e23.posco.grubb@gmail.com>
	<1237442846.25062.466.camel@pasglop>
	<1237442917.25062.467.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__19_Mar_2009_22_30_01_+0900_9SJ72hV3kt0vbvk/"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Multipart=_Thu__19_Mar_2009_22_30_01_+0900_9SJ72hV3kt0vbvk/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks for helpful advices.
This patch adds an option to drivers/ide/Kconfig and adds 
some lines to drivers/ide/pmac.c . Now the driver checks
if the model is prefixed with "PowerBook" and the entire hack
can be toggled in the Kconfig.

Again, the patch is against linux 2.6.28.8.

Best regards,
TOMARI Hisanobu

p.s. oddly, the drive works in ATA/100 mode under untouched
MacOS X 10.5.

On Thu, 19 Mar 2009 17:08:37 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2009-03-19 at 17:07 +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2009-03-18 at 22:47 +0900, TOMARI Hisanobu wrote:
> > > I thought the short-40pin assumption would cause no problem
> > > considering all models beginning with "PowerBook5" are laptops.
> > > Do you mean an option to toggle this hack on/off should be present 
> > > in Kconfig?
> > 
> > Actually, it makes -some- amount of sense to do it by testing
> > specifically for the prefix "PowerBook" and "iBook" without a specific
> > number I suppose.
> 
> Actually "PowerBook" is enough, there's no iBook prefix in the
> device-tree, I was confusing with old busted iMac firmwares that used
> iMac instead of PowerMac in there.
> 
> Cheers,
> Ben.
> 
> > Ben.
> > 
> > > Thanks,
> > > TOMARI Hisanobu
> > > 
> > > On Wed, 18 Mar 2009 18:58:17 +1100
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > 
> > > > On Wed, 2009-03-18 at 14:06 +0900, TOMARI Hisanobu wrote:
> > > > > Hello,
> > > > > 
> > > > > I'm using an OCZ PATA SSD on Apple PowerBook5,4 computer.
> > > > > The IDE drive fails to recognize 80-conductor cable that
> > > > > connects the drive to motherboard to fall back to UDMA33.
> > > > > 
> > > > > This patch fixes this behavior by assuming that the cable is
> > > > > short-40pin when the model string matches "PowerBook5" and 
> > > > > the motherboard detects 80c cable.
> > > > > 
> > > > > This patch is against drivers/ide/pmac.c in linux 2.6.28.8.
> > > > 
> > > > The patch is too much of an ad-hoc hack... _maybe_ an option is to make
> > > > the core fallback to 40 "short" when 80 pin detection fails on
> > > > powerbooks instead ?
> > > > 
> > > > Ben.
> > > > 
> > > > > (before applying the patch) hdparm -i /dev/hda
> > > > > /dev/hda:
> > > > >  Timing buffered disk reads:   90 MB in  3.03 seconds =  29.73 MB/sec
> > > > > (dmesg 2.6.26)
> > > > > ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
> > > > > Probing IDE interface ide0...
> > > > > hda: CORE_PATA, ATA DISK drive
> > > > > hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > > > > hda: drive side 80-wire cable detection failed, limiting max speed to UDMA33
> > > > > hda: UDMA/33 mode selected
> > > > > 
> > > > > (after applying the patch) hdparm -i /dev/hda
> > > > > /dev/hda:
> > > > >  Timing buffered disk reads:  240 MB in  3.02 seconds =  79.42 MB/sec
> > > > > (dmesg 2.6.28.8)
> > > > > ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
> > > > > Probing IDE interface ide0...
> > > > > hda: CORE_PATA, ATA DISK drive
> > > > > hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > > > > hda: UDMA/100 mode selected
> > > > > ide0 at 0xf102a000-0xf102a070,0xf102a160 on irq 39
> > > > > 
> > > > > 
> > > > > _______________________________________________
> > > > > Linuxppc-dev mailing list
> > > > > Linuxppc-dev@ozlabs.org
> > > > > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> > > > 
> 

--Multipart=_Thu__19_Mar_2009_22_30_01_+0900_9SJ72hV3kt0vbvk/
Content-Type: text/x-diff;
 name="ide-pmac-shortcable.patch"
Content-Disposition: attachment;
 filename="ide-pmac-shortcable.patch"
Content-Transfer-Encoding: 7bit

*** linux-2.6.28.8/drivers/ide/Kconfig.old	2009-03-19 21:30:24.594129124 +0900
--- linux-2.6.28.8/drivers/ide/Kconfig	2009-03-19 21:49:41.776996312 +0900
***************
*** 691,696 ****
--- 691,706 ----
  	  CD-ROM on hda. This option changes this to more natural hda for
  	  hard disk and hdc for CD-ROM.
  
+ config BLK_DEV_IDE_PMAC_SHORTCABLE
+        bool "Assume short IDE cable on PowerBook/iBook"
+        depends on BLK_DEV_IDE_PMAC
+        help
+          Some IDE drives fail to recognize 80-conductor IDE cable used in
+ 	 PowerBooks and the driver limits the transfer speed to ATA/33.
+ 	 With this option, the driver reports the 80-conductor cable to be 
+ 	 of "40 conductor short" type on PowerBook/iBook, and enables to use
+ 	 ATA/100 on drives that support the transfer mode.
+ 
  config BLK_DEV_IDE_AU1XXX
         bool "IDE for AMD Alchemy Au1200"
         depends on SOC_AU1200
*** linux-2.6.28.8/drivers/ide/pmac.c.orig	2009-03-19 22:21:14.137849502 +0900
--- linux-2.6.28.8/drivers/ide/pmac.c	2009-03-19 22:16:44.612877441 +0900
***************
*** 917,926 ****
  		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
  	struct device_node *np = pmif->node;
  	const char *cable = of_get_property(np, "cable-type", NULL);
  
  	/* Get cable type from device-tree. */
  	if (cable && !strncmp(cable, "80-", 3))
! 		return ATA_CBL_PATA80;
  
  	/*
  	 * G5's seem to have incorrect cable type in device-tree.
--- 917,938 ----
  		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
  	struct device_node *np = pmif->node;
  	const char *cable = of_get_property(np, "cable-type", NULL);
+ #ifdef CONFIG_BLK_DEV_IDE_PMAC_SHORTCABLE
+ 	struct device_node *root = of_find_node_by_path("/");
+ 	const char *model = of_get_property(root, "model", NULL);
+ #endif
  
  	/* Get cable type from device-tree. */
  	if (cable && !strncmp(cable, "80-", 3))
! 	  {
! #ifdef CONFIG_BLK_DEV_IDE_PMAC_SHORTCABLE
! 	    if(strncmp(model,"PowerBook",9)==0)
! 	      /* Some drives fail to detect 80c cable in PowerBook */
! 	      return ATA_CBL_PATA40_SHORT;
! 	    else
! #endif
! 	      return ATA_CBL_PATA80;
! 	  }
  
  	/*
  	 * G5's seem to have incorrect cable type in device-tree.

--Multipart=_Thu__19_Mar_2009_22_30_01_+0900_9SJ72hV3kt0vbvk/--
