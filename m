Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D367ADE046
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 03:58:18 +1100 (EST)
Date: Mon, 5 Jan 2009 19:58:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: 2.6.28 does not boot on MPC8315E-RDB, or...?
Message-ID: <20090105165817.GA24565@oksana.dev.rtsoft.ru>
References: <c384c5ea0901031458j74d74ba3y359831fff9716d07@mail.gmail.com>
	<008601c96e04$18b74bc0$6b03a8c0@sdelaney2>
	<c384c5ea0901031645q6358f5deibca91cb065fbeb32@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <c384c5ea0901031645q6358f5deibca91cb065fbeb32@mail.gmail.com>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, onramp123@yahoo.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 04, 2009 at 01:45:15AM +0100, Leon Woestenberg wrote:
> Hello,
> 
> On Sun, Jan 4, 2009 at 1:33 AM, Steve DeLaney <onramp123@yahoo.com> wrote:
> >
> > we are booting 2.6.26 on MPC8349-MITXE
> > do you need a device tree?  this can be tftp loaded, or flashed in the board
> > and
> > cp.b from flash to ram before booting.
> >
> 
> Earlier release kernels booted for me, and I use the device tree
> compiled from the device tree source that comes with the tree.
> 
> I used the exact same build procedure for the kernel and device tree
> blob, it's just that 2.6.28 seems to reset on start for the
> MPC8315E-RDB for me.
> 
> Just wanted to hear if the problem is with me alone, or not.

2.6.28 works fine here... using
arch/powerpc/configs/83xx/mpc8315_rdb_defconfig and
arch/powerpc/boot/dts/mpc8315erdb.dts


U-Boot 1.3.2-02604-g00b73f9 (May  7 2008 - 19:51:17) MPC83XX

Reset Status: Software Hard, External/Internal Soft, External/Internal Hard

CPU:   e300c3, MPC8315E, Rev: 1.1 at 400 MHz, CSB: 133.333 MHz
Board: Freescale MPC8315ERDB Rev 0.0
[...]

=> printe
[...]
bootcmd=tftp a00000 uImage ; tftp 900000 dtb ; bootm a00000 - 900000
bootargs=console=ttyS0,115200 ip=on
[...]

=> boot
Waiting for PHY realtime link...... TIMEOUT !
 done
eTSEC0: No link.
Speed: 100, full duplex
Using eTSEC1 device
TFTP from server 10.0.0.2; our IP address is 10.0.0.99
Filename 'uImage'.
Load address: 0xa00000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##########################
done
Bytes transferred = 1794036 (1b5ff4 hex)
Speed: 100, full duplex
Using eTSEC1 device
TFTP from server 10.0.0.2; our IP address is 10.0.0.99
Filename 'dtb'.
Load address: 0x900000
Loading: ####
done
Bytes transferred = 20000 (4e20 hex)
## Booting kernel from Legacy Image at 00a00000 ...
   Image Name:   Linux-2.6.28
   Created:      2009-01-05  16:43:52 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1793972 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at 00000000
   Booting using the fdt blob at 0x900000
   Loading Device Tree to 007fb000, end 007ffe1f ... OK
Using MPC831x RDB machine description
Linux version 2.6.28 (cbou@oksana) (gcc version 4.2.0 (MontaVista 4.2.0-16.0.20.0800760 2008-04-05)) #1 Mon Jan 5 19:43:45 MSK 2009
console [udbg0] enabled
setup_arch: bootmem
mpc831x_rdb_setup_arch()
Found FSL PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
PCI host bridge /pci@e0008500 (primary) ranges:
[...]

Hope this helps,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
