Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 259512C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2012 23:44:59 +1000 (EST)
Subject: Re: PCI device not working
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAKpAL0m2Df6JZ=vYvhfEY5jYH9qOdMmrdmw2u2tcWAAFGv04+Q@mail.gmail.com>
Date: Wed, 26 Sep 2012 08:44:55 -0500
Message-Id: <609C9A31-395A-4CB9-98BB-354E57E6658E@kernel.crashing.org>
References: <CAKpAL0m2XqzuYsG4-yj3WfZN88PjQXMUxFtXpx-sjsWA_Q4EUQ@mail.gmail.com>
 <89227A80-31E1-4E18-9257-6B60126E5A62@kernel.crashing.org>
 <CAKpAL0nTu9XXFgz7i5-1LmetrV05qfQcdf1zGxqHzODgQ7xjKA@mail.gmail.com>
 <CAKpAL0nk-5zz2zht6suNx+BVCQtkxPFPL33uZFSuGpxT8YFFqg@mail.gmail.com>
 <CAKpAL0m2Df6JZ=vYvhfEY5jYH9qOdMmrdmw2u2tcWAAFGv04+Q@mail.gmail.com>
To: Davide Viti <zinosat@tiscali.it>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> 2012/9/24 Davide Viti <zinosat@tiscali.it>
> Hi,
> does the output I've included show anything wrong or should I post =
something else to help identifying the cause of the problem?
>=20
> thank you in advance,
> Davide
>=20
> 2012/9/21 Davide Viti <zinosat@tiscali.it>
> I mean there are two controllers and both of them have a device =
"subtended" (both 0x1b65:0xabba).
> u-boot can see both devices, linux detects only the device attached to =
the first controller.
>=20
> Here's the output of lspci and /proc/iomem :
>=20
> root@(none):/# lspci -v
>=20
> 0000:00:00.0 Class 0604: Device 1957:0100 (rev 11)
>=20
>         Flags: bus master, fast devsel, latency 0
>=20
>         Memory at <ignored> (32-bit, non-prefetchable)
>=20
>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, =
sec-latency=3D0
>=20
>         I/O behind bridge: 00000000-00000fff
>=20
>         Memory behind bridge: a0000000-afffffff
>=20
>         Capabilities: [44] Power Management version 2
>=20
>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>=20
>         Capabilities: [100] Advanced Error Reporting
>=20
> =20
> 0000:01:00.0 Class 0280: Device 1b65:abba (rev 01)
>=20
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>=20
>         Memory at a0000000 (32-bit, non-prefetchable) [size=3D1K]
>=20
>         Memory at a0010000 (32-bit, non-prefetchable) [size=3D64K]
>=20
>         Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>=20
>         Capabilities: [78] Power Management version 3
>=20
>         Capabilities: [80] Express Endpoint, MSI 00
>=20
>         Capabilities: [100] Virtual Channel <?>
>=20
>         Capabilities: [800] Advanced Error Reporting
>=20
> =20
> 0001:02:00.0 Class 0604: Device 1957:0100 (rev 11)
>=20
>         Flags: bus master, fast devsel, latency 0
>=20
>         Memory at <ignored> (32-bit, non-prefetchable)
>=20
>         Bus: primary=3D00, secondary=3D03, subordinate=3D03, =
sec-latency=3D0
>=20
>         I/O behind bridge: 00000000-00000fff
>=20
>         Memory behind bridge: b0000000-bfffffff
>=20
>         Capabilities: [44] Power Management version 2
>=20
>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>=20
>         Capabilities: [100] Advanced Error Reporting

Its possible that in linux the 2nd controller does not believe it has =
link status.  Can you see if there is a function like =
fsl_pcie_check_link() in your kernel.  If so maybe add a printk debug =
message there and see what gets return.

Also helpful to post a full boot log.

>=20
>=20
>=20
>=20
> root@(none):/# cat /proc/iomem
>=20
> a0000000-afffffff : /pcie@ffe09000
>=20
>   a0000000-afffffff : PCI Bus 0000:01
>=20
>     a0000000-a00003ff : 0000:01:00.0
>=20
>     a0010000-a001ffff : 0000:01:00.0
>=20
> b0000000-bfffffff : /pcie@ffe0a000
>=20
>   b0000000-bfffffff : PCI Bus 0001:03
>=20
> ef000000-efffffff : ef000000.nor
>=20
> ffe04500-ffe04507 : serial
>=20
> ffe04600-ffe04607 : serial
>=20
>=20
>=20
> thanx for your help,
>=20
> Davide
>=20
>=20
>=20
>=20
> I mean that the kernel detects the first controller and the device =
attached to it, plus the second controller: the device on the second =
controller is not detected (same device as the one detected on the first =
controller)
>=20
> 2012/9/21 Kumar Gala <galak@kernel.crashing.org>
>=20
> On Sep 21, 2012, at 6:33 AM, Davide Viti wrote:
>=20
> > Hi,
> > I'm working on a custom board based on P1020 with two (identical) =
PCI devices attached;
> > The work is derived from another board with a single instance of =
that device.
> > The system is based on u-boot-2009.11 and Linux 2.6.34.6
> >
> > The "pci" command on u-boot, shows me both the PCI controllers and
> > the attached devices:
> >
> > Scanning PCI devices on bus 0
> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > _____________________________________________________________
> > 00.00.00   0x1957     0x0100     Processor               0x20
> >
> > Scanning PCI devices on bus 1
> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > _____________________________________________________________
> > 01.00.00   0x1b65     0xabba     Network controller      0x80
> >
> > Scanning PCI devices on bus 2
> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > _____________________________________________________________
> > 02.00.00   0x1957     0x0100     Processor               0x20
> >
> > Scanning PCI devices on bus 3
> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > _____________________________________________________________
> > 03.00.00   0x1b65     0xabba     Network controller      0x80
> >
> > The kernel detects only the first instance of the device.
>=20
> What do you mean by first instance of the device ?
>=20
> > Didn't get very far while looking at dts file and kernel logs, so =
I'm
> > asking for some help on narrowing down the problem.
> >
> > I'm wondering if I can assume that the problem is restricted to
> > kernel/dts and avoid concentrating on uboot.
> > I can provide any log (didn't want to post tons of details on the =
first
> > message)
>=20
> Probably a dts issue.
>=20
> What does lspci in linux say?
>=20
> - k
>=20
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
