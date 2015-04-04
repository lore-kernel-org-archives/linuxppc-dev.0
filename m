Return-Path: <rbrito@ime.usp.br>
Received: from nm23-vm1.bullet.mail.bf1.yahoo.com
 (nm23-vm1.bullet.mail.bf1.yahoo.com [98.139.213.141])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A0201A0ABD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 16:40:27 +1100 (AEDT)
Date: Sat, 4 Apr 2015 02:40:22 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: linuxppc-dev@lists.ozlabs.org
Subject: Old regression with MTD devices disappearing from a Kurobox HD/HG
Message-ID: <20150404054022.GA15572@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi.

I just revived a Kurobox HG to use as a NAS (I also have a simpler Kurobox
HD here, not being used at this moment) and I am having problems that didn't
happen before.  I will describe the first problem here and further problems
in later e-mails.

During the 2.6.27 to 2.6.29 era (I may be mistaken in the range, as this is
not new) the kernel had a regression where the MTD device of the Kurobox
used to show about 5 partitions and, with kernels later than that, only one
partition is shown, namely, /dev/mtd0.

Here is what I used to see (just booted the kernel from flash), with a
2.4.33.3 kernel (if desired, I can, of course, send the full dmesg log, but
I don't have the corresponding config):

,----
| LinkStation flash device: 400000 at ffc00000
| NO QRY response
|  Amd/Fujitsu Extended Query Table v1.3 at 0x0040
| LinkStation Flash: Swapping erase regions for broken CFI table.
| number of CFI chips: 1
| cfi_cmdset_0002: Disabling fast programming due to code brokenness.
| Creating 5 MTD partitions on "LinkStation Flash":
| 0x00000000-0x00300000 : "mtd0: kernel+ramdisk"
| 0x00300000-0x00370000 : "mtd1: bootloader"
| 0x00370000-0x00380000 : "mtd2: configuration"
| 0x00380000-0x00400000 : "mtd3: user space"
| 0x00000000-0x00400000 : "mtd4: all flash"
| LinkStation flash device initialized
`----

As I have trouble booting kernels older than 3.x due to my userspace having
udev and libc requirements, I found a dmesg log that is similar to what I
used to get with early 2.6 kernels---this is from a kernel 2.6.15 (this part
is copied from: http://genbako.vodapone.com/old/dmesg-20060117-kuro-NG.txt):

,----
| physmap flash device: 400000 at ffc00000
| phys_mapped_flash: Found 1 x16 devices at 0x0 in 8-bit bank
|  Amd/Fujitsu Extended Query Table at 0x0040
| phys_mapped_flash: Swapping erase regions for broken CFI table.
| number of CFI chips: 1
| cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
| cmdlinepart partition parsing not available
| RedBoot partition parsing not available
| Using physmap partition definition
| Creating 5 MTD partitions on "phys_mapped_flash":
| 0x00000000-0x00400000 : "mtd_allflash"
| 0x00000000-0x00300000 : "mtd_firmimg"
| 0x00300000-0x00370000 : "mtd_bootcode"
| 0x00370000-0x00380000 : "mtd_status"
| 0x00380000-0x00400000 : "mtd_conf"
| usbmon: debugfs is not available
`----

Note that, in particular, the boundary addresses of the MTD device are
exactly the same as the ones on my device.

Unfortunately, right now, what I see with Linus's tree
(4.0.0-rc6-00009-g6c310bc) is the following:

,----
| physmap platform flash device: 00400000 at ffc00000
| physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x000004 Chip ID 0x00007e
| Amd/Fujitsu Extended Query Table at 0x0040
|   Amd/Fujitsu Extended Query version 1.3.
| physmap-flash.0: Swapping erase regions for top-boot CFI table.
| number of CFI chips: 1
`----

I note that arch/powerpc/boot/dts/kuroboxH{D,G}.dts have, as one of their
first lines, the following comment: [0][1]

    XXXX add flash parts, rtc, ??

[0]: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/dts/kuroboxHD.dts?id=1cced5015b171415169d938fb179c44fe060dc15#n17
[1]: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/dts/kuroboxHG.dts?id=1cced5015b171415169d938fb179c44fe060dc15#n17

Is this a problem that can be fixed via additions to the DTS files?  Or
would the problem be solved in a different way?


Thanks in advance,

Rogério Brito.

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
