Message-ID: <001101c3894c$38833ab0$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20031002121733.A2E32C59E4@atlas.denx.de>
Subject: Re: Queston about Walnut 
Date: Fri, 3 Oct 2003 09:18:12 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > > Who gave you such (obviously wrong) instructions?
> >
> >         I take the example of u-boot to create the "uImage" and download
it
> > to the board.
>
> Please show me which U-Boot document uses 0x00400000 as load or entry
> point address so I can fix this immediately. It is WRONG  and  CANNOT
> work.

    I take the "step" from u-boot's README file only. Because I got an
exception, I try to load it to other address. I use 0x00400000 because
zImage seems to be loaded at there....anyway, just a guess.

>
> Please start by giving a precise description of  what  you  did.  and
> which error messages you got.

    Here is the exact step that I have done so far:

    <Compile toolcahin by crosstools>
    <Patch 2.4.22 kernel with patch on
http://www.kernel.org/pub/linux/kernel/ports/ppc/2.4/linuxppc-2.4.22.patch.bz2>
    <Compile kernel with cross toolchain>
    powerpc-405-linux-gnu-objcopy -O binary -R .note -R .comment -S vmlinux
linux.bin
    gzip -9  linux.bin
    ./mkimage -A ppc -O linux -T kernel -C gzip -a 0x00000000 -e
0x00000000 -n "test" -d linux.bin.gz uImage
    <run ftpd on host>
    <boot up the board and enter command prompt of u-boot>

    Here is the u-boot log:

    U-Boot 0.4.0 (Sep 29 2003 - 11:44:31)

CPU:   IBM PowerPC 405GP Rev. D at 200 MHz (PLB=100, OPB=50, EBC=33 MHz)
           PCI sync clock at 33 MHz, external PCI arbiter enabled
           16 kB I-Cache 8 kB D-Cache
Board: ### No HW ID - assuming WALNUT405
I2C:   ready
DRAM:  64 MB
FLASH: 512 kB
In:    serial
Out:   serial
Err:   serial
KGDB:  kgdb ready
ready
BEDBUG:ready
Hit any key to stop autoboot:  0
=> tftpboot
ENET Speed is 100 Mbps - FULL duplex connection
TFTP from server 10.5.6.76; our IP address is 10.5.3.45
Filename 'uImage'.
Load address: 0x400000
Loading: #################################################################
         #######################################################
done
Bytes transferred = 612748 (9598c hex)
=> bootm
## Booting image at 00400000 ...
   Image Name:   test
   Created:      2003-10-03   1:08:06 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    612684 Bytes = 598.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin

<hang>


>
> You "get an exception" - when? When running "mkimage"?  When  booting
> the kernel? Which sort of exception? What is the exact error message?
> Please include a complete log of your actions and all output.

    Maybe I do something wrong before. Now, it just hangs. Thanks your
suggestion about the load address.



Best Regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
