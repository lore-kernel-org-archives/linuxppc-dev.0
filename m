Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 9B109DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 02:30:17 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070615120848.558678000@pademelon.sonytel.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <89ca7c200ed0f7c47387af99643df6a1@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 6/6] ps3: FLASH ROM Storage Driver
Date: Mon, 18 Jun 2007 11:30:06 -0500
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
>
> Add a FLASH ROM Storage Driver for the PS3:
>   - Implemented as a misc character device driver
>   - Uses a fixed 256 KiB buffer allocated from boot memory as the 
> hypervisor
>     requires the writing of aligned 256 KiB blocks
>
> CC: Geoff Levand <geoffrey.levand@am.sony.com>
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
> Changes since previous submission:
>       o Don't use `default y' in Kconfig
>       o #include <linux/uaccess.h> instead of <asm/uaccess.h>
>       o Set up sysfs links between misc character device and PS3 
> system device:
> 	  . /sys/class/misc/ps3flash/device -> 
> ../../../devices/ps3_system/sb_01
> 	  . /sys/devices/ps3_system/sb_01/misc:ps3flash -> 
> ../../../class/misc/ps3flash
>
>  arch/powerpc/platforms/ps3/Kconfig |   11 +
>  drivers/char/Makefile              |    2
>  drivers/char/ps3flash.c            |  404 
> +++++++++++++++++++++++++++++++++++++
>  3 files changed, 417 insertions(+)

You indicated that the primary reasons to use this driver were to boot 
back into GameOS, or reinstall the boot loader, yet your Kconfig entry 
says "In general, all users will say Y or M".  This could give a bit 
more guidance.

ps3flash_read_write_sectors chooses a string every call that is only 
used on the error path.

ps3flash_read gives priority to returning an encountered error.  If it 
made partial progress (eg partially mapped user buffer) it should 
return the count of bytes sent to the user.

ps3_write will call the hypervisor to write an aligned chunk of memory 
every call.  I'm guessing the hypervisor does no buffering of the 
flash.  If the file is written with a small block size, this will
cause unnecessary flash wear.  Have you considered requiring the 
application to write the full 256MiB, or alternatively delaying the 
actual write call until either close, the write reaches the boundary, 
or a read or write accesses another chunk?   Yes, the later would mean 
short writes would receive the error on close.

milton
