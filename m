Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 93798DE12A
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 03:55:14 +1000 (EST)
Date: Sat, 12 Apr 2008 13:48:31 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: <linuxppc-dev@ozlabs.org>
Subject: Warp patches for 2.6.26
Message-ID: <20080412134831.424480cf@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was going to hold off until the warp was officially released, but we
might miss the merge window. So here they are. A lot of work has been
done since 2.6.25 and I haven't been submitting patches to keep down on
the churn.

We standardized on a 4M NOR flash and a 256M NAND flash. But there is
still support for the original Rev A boards which where 64M NOR and 64M
NAND. You will see fixups for the Rev A. The Rev A is considered
obsolete and the fixups are only there for me to use good ol' Tigger.

ftp://ftp.seanm.ca/stuff/tigger.jpg

Here is the full list of files that need to be patched for a warp,
basically git diff --name-only origin/for-2.6.26:

arch/powerpc/boot/cuboot-warp.c
arch/powerpc/boot/dts/warp.dts
arch/powerpc/configs/warp_defconfig
arch/powerpc/platforms/44x/warp-nand.c
arch/powerpc/platforms/44x/warp.c

drivers/hwmon/Kconfig
drivers/hwmon/Makefile
drivers/hwmon/ad7414.c

drivers/i2c/busses/Kconfig
drivers/i2c/busses/i2c-ibm_iic.c

drivers/leds/Kconfig
drivers/leds/Makefile
drivers/leds/leds-warp.c

drivers/mmc/core/sd.c
drivers/mmc/host/Kconfig
drivers/mmc/host/Makefile
drivers/mmc/host/pikasd.c

drivers/mtd/nand/Kconfig
drivers/mtd/nand/ndfc.c

drivers/net/ibm_newemac/mal.c
drivers/net/ibm_newemac/zmii.c

drivers/scsi/Kconfig

drivers/watchdog/Kconfig
drivers/watchdog/Makefile
drivers/watchdog/pika_wdt.c

include/linux/mmc/host.h
include/linux/pika.h

I will not include patches for all of them since many haven't changed
and/or are waiting for submission to the kernel. So I have broken it up
into five patches.

I will submit any other patches people are interested in.

Cheers,
   Sean
