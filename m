Return-Path: <posco.grubb@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id D6876DDEF3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 16:06:39 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so192455waf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 22:06:38 -0700 (PDT)
Date: Wed, 18 Mar 2009 14:06:38 +0900
From: TOMARI Hisanobu <posco.grubb@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: IDE cable detection on Apple PowerBook
Message-Id: <20090318140638.e6b61eaa.posco.grubb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Wed__18_Mar_2009_14_06_38_+0900_mT1hs+yYePm/_=uL"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Multipart=_Wed__18_Mar_2009_14_06_38_+0900_mT1hs+yYePm/_=uL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

I'm using an OCZ PATA SSD on Apple PowerBook5,4 computer.
The IDE drive fails to recognize 80-conductor cable that
connects the drive to motherboard to fall back to UDMA33.

This patch fixes this behavior by assuming that the cable is
short-40pin when the model string matches "PowerBook5" and 
the motherboard detects 80c cable.

This patch is against drivers/ide/pmac.c in linux 2.6.28.8.

(before applying the patch) hdparm -i /dev/hda
/dev/hda:
 Timing buffered disk reads:   90 MB in  3.03 seconds =  29.73 MB/sec
(dmesg 2.6.26)
ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
Probing IDE interface ide0...
hda: CORE_PATA, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: drive side 80-wire cable detection failed, limiting max speed to UDMA33
hda: UDMA/33 mode selected

(after applying the patch) hdparm -i /dev/hda
/dev/hda:
 Timing buffered disk reads:  240 MB in  3.02 seconds =  79.42 MB/sec
(dmesg 2.6.28.8)
ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
Probing IDE interface ide0...
hda: CORE_PATA, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
ide0 at 0xf102a000-0xf102a070,0xf102a160 on irq 39


-- 
TOMARI Hisanobu <posco.grubb@gmail.com>

--Multipart=_Wed__18_Mar_2009_14_06_38_+0900_mT1hs+yYePm/_=uL
Content-Type: text/x-diff;
 name="ide-pmac-pbookcable.patch"
Content-Disposition: attachment;
 filename="ide-pmac-pbookcable.patch"
Content-Transfer-Encoding: 7bit

*** linux-2.6.28.8/drivers/ide/pmac.c.orig	2009-03-18 13:59:39.645805773 +0900
--- linux-2.6.28.8/drivers/ide/pmac.c	2009-03-18 13:57:38.935818468 +0900
***************
*** 916,926 ****
  	pmac_ide_hwif_t *pmif =
  		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
  	struct device_node *np = pmif->node;
  	const char *cable = of_get_property(np, "cable-type", NULL);
  
  	/* Get cable type from device-tree. */
  	if (cable && !strncmp(cable, "80-", 3))
! 		return ATA_CBL_PATA80;
  
  	/*
  	 * G5's seem to have incorrect cable type in device-tree.
--- 916,934 ----
  	pmac_ide_hwif_t *pmif =
  		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
  	struct device_node *np = pmif->node;
+ 	struct device_node *root = of_find_node_by_path("/");
  	const char *cable = of_get_property(np, "cable-type", NULL);
+ 	const char *model = of_get_property(root, "model", NULL);
  
  	/* Get cable type from device-tree. */
  	if (cable && !strncmp(cable, "80-", 3))
! 	  {
! 	    if(strncmp(model,"PowerBook5",10)==0)
! 	      /* Some drives fail to detect 80c cable in PowerBook */
! 	      return ATA_CBL_PATA40_SHORT;
! 	    else
! 	      return ATA_CBL_PATA80;
! 	  }
  
  	/*
  	 * G5's seem to have incorrect cable type in device-tree.

--Multipart=_Wed__18_Mar_2009_14_06_38_+0900_mT1hs+yYePm/_=uL--
