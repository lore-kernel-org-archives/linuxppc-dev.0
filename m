Return-Path: <gmuruga@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id 8904467B92
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Nov 2006 14:37:08 +1100 (EST)
Date: Wed, 29 Nov 2006 19:10:58 -0800
Message-Id: <200611300310.kAU3Awg07084@sierra.gdatech.com>
From: "Muruga Ganapathy" <gmuruga@gdatech.com>
To: bwarren@qstreams.com, linuxppc-embedded@ozlabs.org
Subject: Re: Compact Flash - lost interrupt
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The error message might be due to the wrong/improper configuration of 
interrupt and its attributes like whether it is level/edge sensitive.

G.Muruganandam

> Hello,
> 
> I'm bringing up the Compact Flash interface on a custom board and am
> almost there, but not quite.  I've seen many messages in the past 
about
> the 'lost interrupt' message, but I couldn't find anything 
corresponding
> closely to my situation.  Can anyone shed some light?
> 
> Here's a snippet of Linux booting:
> 
> *******************************
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.17
>    Created:      2006-11-29  19:38:51 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1103335 Bytes =  1.1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Using MPC834x SYS machine description
> 
> <snip>
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 50MHz system bus speed for PIO modes; override with
> idebus=xx
> hda: TOSHIBA THNCF512MDG, ATA DISK drive
> ide0 at 0xd1064000-0xd1064007,0xd106600d on irq 20
> hda: max request size: 128KiB
> hda: 1000944 sectors (512 MB) w/2KiB Cache, CHS=993/16/63
>  hda:<4>hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
>  hda1
> 
> <snip>
> 
> prism login:
> 
> *******************************
> 
> As you can see, the device is found and eventually the IDE driver
> assigns it ID hda1, but something's amiss.
> 
> When I try to partition the drive I get the same thing:
> 
> ~ # fdisk /dev/hda
> hda: lost interrupt
> hda: lost interrupt
> 
> Command (m for help): p
> 
> Disk /dev/hda: 512 MB, 512483328 bytes
> 16 heads, 63 sectors/track, 993 cylinders
> Units = cylinders of 1008 * 512 = 516096 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hda1   *           1         992      499936+   6  FAT16
> 
> 
> The Compact Flash is configured in 'True IDE' mode on the local bus 
of a
> 400MHz MPC8349 processor.  I've set the UPM timing according to the
> Toshiba app note that's floating around, and the interrupt is tied to
> IRQ4 (Interrupt #20).  The fact that the driver probe can read
> information about the drive tells me that the memory bus is at least
> marginally functional.  Interrupts are firing:
> 
> ~ # cat /proc/interrupts
>            CPU0
>   9:        127   IPIC   Level     serial
>  14:          0   IPIC   Level     i2c-mpc
>  15:          0   IPIC   Level     i2c-mpc
>  16:          0   IPIC   Level     mpc83xx_spi
>  20:         12   IPIC   Edge      ide0
>  21:        547   IPIC   Edge      eth2
> BAD:          0
> 
> I'm using a driver supplied by Kumar Gala called 'cfide.c'.  I've 
tried
> a couple of quite different CF cards, with the same result on both.
> 
> Here's a portion of the kernel .config file:
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_BLK_DEV_IDECD is not set
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=y
> # CONFIG_IDE_ARM is not set
> CONFIG_BLK_DEV_CFIDE=y
> # CONFIG_BLK_DEV_IDEDMA is not set
> # CONFIG_IDEDMA_AUTO is not set
> # CONFIG_BLK_DEV_HD is not set
> 
> 
> thanks,
> Ben
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

*************************************************************
GDA Technologies, Inc.		
1010 Rincon Circle 
San Jose CA, 95131
Phone	(408) 432-3090
Fax	(408) 432-3091

Accelerate Your Innovation	
**************************************************************


=====
This message contains information from GDA Technologies Inc and 
affiliates, and is intended for the sole use of the individual and 
entity to whom it is addressed. It may contain information, including 
any attachments, that is privileged, confidential and exempt from 
disclosure under applicable law. If you are not the intended 
addressee, nor authorized to receive for the intended addressee, you 
are hereby notified that you may not use, copy, disclose or distribute 
to anyone the message or any information contained in the message. If 
you have received this electronic transmission in error, please notify 
the sender immediately by a "reply to sender only" message and destroy 
all electronic and hard copies of the communication, including 
attachments.
====
