Message-ID: <3C5FFFB8.5000409@cambridgebroadband.com>
Date: Tue, 05 Feb 2002 15:52:24 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: "Walser, Martin" <mwalser@harris.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: unable to uncompess kernel image
References: <8D4C69676E66D511A1CB00508BBBB1921BCEF9@ranmx1.ran.harris.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm a little bit confused as to whether you are trying to build a ramdisk image or a kernel image.
If you are building a kernel image you do it like this

linux $ make pImage

Then you need to burn arch/ppc/mbxboot/pImage into FLASH

If you are trying to build a ramdisk image then use SELF from ftp.denx.de to build pRamdisk.  After
this is built burn it into FLASH.  Then set up PPCBoot like this:

=> setenv hostname thename
=> setenv ethaddr aa:bb:cc:dd:ee:ff
=> setenv gatewayip 10.0.0.1
=> setenv ipaddr 10.0.0.2
=> setenv serverip 10.0.0.3
=> setenv netmask 255.255.255.0
=> setenv clocks_in_mhz 1
=> setenv bootdelay 1
=> setenv rootpath /opt/hardhat/devkit/ppc/8xx/target
=> setenv ramargs setenv bootargs root=/dev/ram rw
=> setenv nfsargs setenv bootargs root=/dev/nfs rw nfsroot=\$(serverip):\$(rootpath)
=> setenv addip setenv bootargs \$(bootargs)
ip=\$(ipaddr):\$(serverip):\$(gatewayip):\$(netmask):\$(hostname)::off panic=1
=> setenv net_nfs tftp 200000 pImage\;run nfsargs\;run addip\;bootm
=> setenv net_self tftp 200000 pMulti\;run ramargs\;run addip\;bootm
=> setenv flash_nfs run nfsargs\;run addip\;bootm \$(kernel_addr)
=> setenv flash_self run ramargs\;run addip\;bootm \$(kernel_addr) \$(ramdisk_addr)
=> setenv kernel_addr 40000000
=> setenv ramdisk_addr 40100000
=> setenv load tftp 100000 ppcboot.bin
=> setenv update protect off all\;era 40F00000 40F7FFFF\;cp.b 100000 40F00000 \$(filesize)\;saveenv
=> setenv autostart no
=> setenv stdin serial
=> setenv stdout serial
=> setenv stderr serial
=> setenv bootcmd run flash_self
=> saveenv


If you loaded pImage to $(kernel_addr) and pRamdisk to $(ramdisk_addr) then when you reboot PPCBoot
will run pImage and the kernel will mount pRamdisk.

Alex

Walser, Martin wrote:

> Hi,
>
> I've successfully developed a kernel which mounts over nfs.
> Now I want to make a zImage.initrd. To do so, I've first made a ramdisk.image.gz
> and copied it to /arch/ppc/mbxboot.
> Then I made make zImage.initrd.
> After that, I've used mkimage to encapsulate /arch/ppc/mbxboot/zvmlinux.initrd
> to boot it with ppcboot.
>
> When ppcboot starts booting, the following message is shown:
>
> ## Booting image at 00100000 ...
>    Image Name:   2.4.4 for initrd on COM660
>    Created:      2002-02-05  14:37:47 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    888587 Bytes = 867 kB = 0 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... Error: Bad gzipped data
> GUNZIP ERROR - must RESET board to recover
>
> Any ideas?
>
> regards
> Martin
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
