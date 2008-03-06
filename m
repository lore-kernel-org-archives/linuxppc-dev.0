Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id 16910DE02C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Mar 2008 04:30:37 +1100 (EST)
Date: Thu, 06 Mar 2008 09:30:04 -0800
Subject: Performance in Booting Linux w/ Device Tree via U-Boot out of
	JFFS2 on NAND
From: Grant Erickson <gerickson@nuovations.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Message-ID: <C3F56A1C.DD2F%gerickson@nuovations.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am continuing some experiments in booting Linux w/ a flattened device tree
via u-boot (1.3.2-rc3) from JFFS2 on NAND on an AMCC "Haleakala" board and
am curious if anyone has come up with some quantitative performance
characterizations of the various options (in all cases, u-boot lives on NOR
flash). The options I am evaluating are:

1) Put uImage and haleakala.dtb in their own "raw" NAND slices and boot with
   u-boot nand commands:

    static struct mtd_partition nand_parts[] = {
        {
            .name   = "kernel",
            .offset = 0,
            .size   = 0x0400000
        },
        {
            .name   = "fdt",
            .offset = 0x0400000,
            .size   = 0x0010000
        },
        {
            .name   = "root",
            .offset = 0x0410000,
            .size   = 0x3BF0000
        }
    };
    
    => nand read.i 200000 0 400000
    => nand read.i 400000 400000 10000
    => setenv bootargs ${bootargs} console=ttyS0,${baudrate}
    => setenv bootargs ${bootargs} root=/dev/mtdblock9 rootfstype=jffs2
    => bootm 200000 - 400000

Qualitative performance: Nearly instantaneous.

As expected, in this case the qualitative, subjective time to seeing "Linux
version 2.6.25-rc3-00951-g6514352-dirty ..." is nearly instantaneous.

2) Put uImage and haleakala.dtb as files in /boot in the ~12 MB JFFS2 root
   file system image in the ~60 MB "root" NAND slice and boot with u-boot
   fsload commands:

    => fsload 200000 boot/uImage
    => fsload 400000 boot/haleakala.dtb
    => setenv bootargs ${bootargs} console=ttyS0,${baudrate}
    => setenv bootargs ${bootargs} root=/dev/mtdblock9 rootfstype=jffs2
    => bootm 200000 - 400000

2a) With CFG_JFFS2_SORT_FRAGMENTS enabled.

Qualitative performance: Takes the better part of 30-35 minutes.

As expected with the in-documentation warnings about
CFG_JFFS2_SORT_FRAGMENTS and looking at the code in
u-boot/fs/jffs2/jffs2_nand_1pass.c, the qualitative, subjective time to
seeing the Linux version banner is slow, slow and slow.

2b) With CFG_JFFS2_SORT_FRAGMENTS disabled.

Qualitative performance: Takes about 30 seconds to two minutes.

3) This is a hybrid approach that I am setting up right now and is where I
am curious if anyone has done plots of fsload time on JFFS2 + NAND relative
to file system size.

Here, we use a separate 4 MB "/boot" JFFS2 file system for uImage and
haleakala.dtb files and a 60 MB "/" JFFS2 file system for the root file
system.

    static struct mtd_partition nand_parts[] = {
        {
            .name   = "boot",
            .offset = 0,
            .size   = 0x0400000
        },
        {
            .name   = "root",
            .offset = 0x0400000,
            .size   = 0x3C00000
        }
    };

    => fsload 200000 uImage
    => fsload 400000 haleakala.dtb
    => setenv bootargs ${bootargs} console=ttyS0,${baudrate}
    => setenv bootargs ${bootargs} root=/dev/mtdblock9 rootfstype=jffs2
    => bootm 200000 - 400000

3a) With CFG_JFFS2_SORT_FRAGMENTS enabled.

Shouldn't be necessary since the /boot file system would only ever be
accessed read-only and updated by nandwrite, not individual file updates.

3b) With CFG_JFFS2_SORT_FRAGMENTS disabled.

Qualitative performance: TBD <= 2b

Thanks,

Grant Erickson
