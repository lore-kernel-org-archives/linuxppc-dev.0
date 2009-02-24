Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr15.xs4all.nl (smtp-vbr15.xs4all.nl [194.109.24.35])
	by ozlabs.org (Postfix) with ESMTP id 8DCC0DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 23:45:55 +1100 (EST)
Message-ID: <49A3EBFF.4030906@aimvalley.nl>
Date: Tue, 24 Feb 2009 13:45:51 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Eric Cottrell <wb1hbu@runbox.com>
Subject: Re: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image
References: <E1LbNft-0007z6-Pf@garm.runbox.com>
In-Reply-To: <E1LbNft-0007z6-Pf@garm.runbox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Eric,

I have the same board and same problem. It's just an incompatibility between the
DTB and u-boot.
Recent u-boots (and without a doubt also your u-boot 1.3.3) expect aliases
in the DTB, these ones I guess:

.
.
         aliases {
                 ethernet0 = &enet0;
                 ethernet1 = &enet1;
                 serial0 = &serial0;
                 serial1 = &serial1;
                 pci0 = &pci0;
         };
.
.

Not being able to find alias "serial0" (in the DTB) causes this problem.
see u-boot/common/fdt_support.c:fdt_fixup_stdout

Older u-boots don't expect them. My REV A4 board was shipped with
"U-Boot 1.1.6 (Aug 24 2007 - 13:10:12) MPC83XX" (which obviously not expects the aliases).

If I flash a new/custom u-boot (U-Boot 2008.10) the problem occurs.

I assume Freescale ships their REV A4 boards with a u-boot not expecting the
aliases.
I assume your u-boot 1.3.3 is not the one the board was shipped with,
are are you saying it is ?

---
N. van Bolhuis.








Eric Cottrell wrote:
> Hello,
> 
> This is getting frustrating and I am beginning to think someone messed this board up and returned it.  I would think it would boot up the default flash image out of the box with very little trouble.
> 
> Board is a MPC8313e-RDB Rev A4.  I set the dip switches per the instructions, S4 all off and S3 all on.
> Uboot comes up but I can not boot either the default images in the flash or images I built with ltib and tftped.  I did not touch the flash.  I get WARNING: could not set linux,stdout-path FDT_ERR_NOTFOUND and ERROR: /chosen node create failed - must RESET the board to recover.  The board resets.
> 
> A friend has the same board but his U-Boot is Version 1.3.0 (Jun 19 2008 - 13:41:53) MPC83XX and some environment variables are different.  I do not have the BOOTCMD variable but entered it manually.
> 
> I tried searching for on a solution but it is confusing because if aliases are needed why does the default dtb in the flash omit them?
> 
> This is what happens:
> 
> U-Boot 1.3.3 (Dec  8 2008 - 09:51:15) MPC83XX
> 
> Reset Status:
> 
> CPU:   e300c3, MPC8313E, Rev: 1.0 at 333.333 MHz, CSB: 166.666 MHz
> Board: Freescale MPC8313ERDB
> I2C:   ready
> DRAM:  128 MB
> FLASH:  8 MB
> In:    serial
> Out:   serial
> Err:   serial
> Net:   TSEC0, TSEC1 [PRIME]
> => bootm fe100000 fe300000 fe700000
> ## Booting kernel from Legacy Image at fe100000 ...
>    Image Name:   Linux-2.6.20
>    Created:      2007-08-24  14:59:01 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1722821 Bytes =  1.6 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Flattened Device Tree blob at fe700000
>    Booting using the fdt blob at 0xfe700000
> ## Loading init Ramdisk from Legacy Image at fe300000 ...
>    Image Name:   uboot ext2 ramdisk rootfs
>    Created:      2007-08-24  15:01:41 UTC
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    2831355 Bytes =  2.7 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Loading Device Tree to 007fd000, end 007fffff ... OK
> WARNING: could not set linux,stdout-path FDT_ERR_NOTFOUND.
> ERROR: /chosen node create failed - must RESET the board to recover.
> Resetting the board.
> 
> 
> U-Boot 1.3.3 (Dec  8 2008 - 09:51:15) MPC83XX
> 
> Reset Status: Software Hard, External/Internal Soft, External/Internal Hard
> 
> CPU:   e300c3, MPC8313E, Rev: 1.0 at 333.333 MHz, CSB: 166.666 MHz
> Board: Freescale MPC8313ERDB
> I2C:   ready
> DRAM:  128 MB
> FLASH:  8 MB
> In:    serial
> Out:   serial
> Err:   serial
> Net:   TSEC0, TSEC1 [PRIME]
> => 
> 
> 73 Eric
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
