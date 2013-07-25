Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22f.google.com (mail-pb0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B0062C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 22:55:22 +1000 (EST)
Received: by mail-pb0-f47.google.com with SMTP id rr13so715436pbb.20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 05:55:20 -0700 (PDT)
Date: Thu, 25 Jul 2013 20:54:53 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
Message-ID: <20130725125453.GK5084@pek-khao-d1.corp.ad.wrs.com>
References: <20130607020020.GA4678@pek-khao-d1.corp.ad.wrs.com>
 <1374618676.15592.40@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wRokNccIwvMzawGl"
In-Reply-To: <1374618676.15592.40@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wRokNccIwvMzawGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2013 at 05:31:16PM -0500, Scott Wood wrote:
> On 06/06/2013 09:00:20 PM, Kevin Hao wrote:
> >                  Vector table: BAR=3D1 offset=3D00000000

<snip>

> >                  PBA: BAR=3D1 offset=3D00000800
> >
> >
> >As you can see, the only difference between these two logs is the
> >io resource address and all the mem and bus address are still the
> >same.
>=20
> I dug a bit deeper into this, and it's making by head hurt.  It
> seems that we're now getting saved by the host bridge (that for some
> reason has the class code of a PCI-to-PCI bridge rather than a host
> bridge) having I/O space of 0x1000 bytes[1], which gets allocated at
> zero.  There have been some changes in the QEMU PCI code since I saw
> the problem, including changing the class code of the bridge, so
> that's probably why it sort-of works now.

We are not just lucky here. Even without the change of the qemu pci
code we still can get the correct IO address in the current kernel.
The following is the log by running the latest kernel on the qemu which
doesn't have the PCI-to-PCI bridge change yet. As you can see we don't
pick a primary pci bus in this case and the Ethernet controller still get
the I/O ports at 1000.
    PCI: Probing PCI hardware
    fsl-pci e0008000.pci: PCI host bridge to bus 0000:00
    pci_bus 0000:00: root bus resource [io  0xf1020000-0xf102ffff] (bus add=
ress [0x0000-0xffff])
    pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff]
    pci_bus 0000:00: root bus resource [bus 00-ff]
    pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
    pci 0000:00:00.0: [1957:0030] type 00 class 0x0b2000
    pci 0000:00:11.0: [1af4:1000] type 00 class 0x020000
    pci 0000:00:11.0: reg 0x10: [io  0xf1020000-0xf102001f]
    pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
    pci 0000:00:11.0: BAR 0: assigned [io  0xf1021000-0xf102101f]
    pci_bus 0000:00: resource 4 [io  0xf1020000-0xf102ffff]
    pci_bus 0000:00: resource 5 [mem 0xc0000000-0xdfffffff]
   =20
    root@localhost:~# lspci -v
    00:00.0 Power PC: Freescale Semiconductor Inc MPC8533E
    	Subsystem: Red Hat, Inc Device 1100
    	Flags: bus master, fast devsel, latency 0
   =20
    00:11.0 Ethernet controller: Red Hat, Inc Virtio network device
    	Subsystem: Red Hat, Inc Device 0001
    	Flags: fast devsel, IRQ 16
    	I/O ports at 1000 [disabled] [size=3D32]

The reason is that the ppc kernel assume that the BARs starting
at 0 is unset and will reassign it later. There is a bug in the previous
kernel, so the kernel maybe not work well for qemu in this case. But I
think this has been fixed by the commit c5df457f (powerpc/pci: Check the
bus address instead of resource address in pcibios_fixup_resources).

>=20
> What QEMU is doing does not match what real hardware does, though.
> At least on mpc8536 which is similar to mpc8544 (I wasn't able to
> quickly get access to a working mpc8544 to test on), the PCI bridge
> has class code Processor, rather than bridge of any sort.  Thus, on
> real hardware we would not get the 0x1000 reservation.

This doesn't matter. We can always make sure to reassign these resources
starting at 0. I also done a test on the mpc8536ds board. Both the pci
and pcie devices work pretty well without picking a primary pci bus
on this board. The following is the log.

    Found FSL PCI host bridge at 0x00000000ffe08000. Firmware bus number: 0=
->0
    PCI host bridge /pci@ffe08000  ranges:
     MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000=20
      IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x0000000000000000
    /pci@ffe08000: PCICSRBAR @ 0xfff00000
    Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: 0=
->0
    PCI host bridge /pcie@ffe09000  ranges:
     MEM 0x0000000098000000..0x000000009fffffff -> 0x0000000098000000=20
      IO 0x00000000ffc20000..0x00000000ffc2ffff -> 0x0000000000000000
    /pcie@ffe09000: PCICSRBAR @ 0xfff00000
    Found FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: 0=
->1
    PCI host bridge /pcie@ffe0a000  ranges:
     MEM 0x0000000090000000..0x0000000097ffffff -> 0x0000000090000000=20
      IO 0x00000000ffc10000..0x00000000ffc1ffff -> 0x0000000000000000
    /pcie@ffe0a000: PCICSRBAR @ 0xfff00000
    Found FSL PCI host bridge at 0x00000000ffe0b000. Firmware bus number: 0=
->0
    PCI host bridge /pcie@ffe0b000  ranges:
     MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000a0000000=20
      IO 0x00000000ffc30000..0x00000000ffc3ffff -> 0x0000000000000000
    /pcie@ffe0b000: PCICSRBAR @ 0xfff00000
    PCI: Probing PCI hardware
    fsl-pci ffe08000.pci: PCI host bridge to bus 0000:00
    pci_bus 0000:00: root bus resource [io  0xe1020000-0xe102ffff] (bus add=
ress [0x0000-0xffff])
    pci_bus 0000:00: root bus resource [mem 0x80000000-0x8fffffff]
    pci_bus 0000:00: root bus resource [bus 00-ff]
    pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
    pci 0000:00:00.0: [1957:0050] type 00 class 0x0b2000
    pci 0000:00:00.0: reg 0x10: [mem 0xfff00000-0xffffffff]
    pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x1fffffff pref]
    pci 0000:00:11.0: [8086:107c] type 00 class 0x020000
    pci 0000:00:11.0: reg 0x10: [mem 0x80000000-0x8001ffff]
    pci 0000:00:11.0: reg 0x14: [mem 0x80020000-0x8003ffff]
    pci 0000:00:11.0: reg 0x18: [io  0xe1021000-0xe102103f]
    pci 0000:00:11.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
    pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
    pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
    fsl-pci ffe09000.pcie: PCI host bridge to bus 0001:01
    pci_bus 0001:01: root bus resource [io  0xe1040000-0xe104ffff] (bus add=
ress [0x0000-0xffff])
    pci_bus 0001:01: root bus resource [mem 0x98000000-0x9fffffff]
    pci_bus 0001:01: root bus resource [bus 01-ff]
    pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to ff
    pci 0001:01:00.0: [1957:0050] type 01 class 0x0b2000
    pci 0001:01:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
    pci 0001:01:00.0: supports D1 D2
    pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
    pci 0001:01:00.0: bridge configuration invalid ([bus 00-00]), reconfigu=
ring
    pci 0001:01:00.0: PCI bridge to [bus 02-ff]
    pci 0001:01:00.0:   bridge window [io  0xe1040000-0xe1040fff]
    pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
    pci 0001:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
    pci_bus 0001:02: busn_res: [bus 02-ff] end is updated to 02
    pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 02
    fsl-pci ffe0a000.pcie: PCI host bridge to bus 0002:03
    pci_bus 0002:03: root bus resource [io  0xe1060000-0xe106ffff] (bus add=
ress [0x0000-0xffff])
    pci_bus 0002:03: root bus resource [mem 0x90000000-0x97ffffff]
    pci_bus 0002:03: root bus resource [bus 03-ff]
    pci_bus 0002:03: busn_res: [bus 03-ff] end is updated to ff
    pci 0002:03:00.0: [1957:0050] type 01 class 0x0b2000
    pci 0002:03:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
    pci 0002:03:00.0: supports D1 D2
    pci 0002:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
    pci 0002:03:00.0: Primary bus is hard wired to 0
    pci 0002:03:00.0: bridge configuration invalid ([bus 01-01]), reconfigu=
ring
    pci 0002:04:00.0: [8086:107d] type 00 class 0x020000
    pci 0002:04:00.0: reg 0x10: [mem 0x90000000-0x9001ffff]
    pci 0002:04:00.0: reg 0x14: [mem 0x90020000-0x9003ffff]
    pci 0002:04:00.0: reg 0x18: [io  0xe1061000-0xe106101f]
    pci 0002:04:00.0: PME# supported from D0 D3hot D3cold
    pci 0002:03:00.0: PCI bridge to [bus 04-ff]
    pci 0002:03:00.0:   bridge window [io  0xe1060000-0xe1060fff]
    pci 0002:03:00.0:   bridge window [mem 0x90000000-0x900fffff]
    pci_bus 0002:04: busn_res: [bus 04-ff] end is updated to 04
    pci_bus 0002:03: busn_res: [bus 03-ff] end is updated to 04
    fsl-pci ffe0b000.pcie: PCI host bridge to bus 0003:05
    pci_bus 0003:05: root bus resource [io  0xe1080000-0xe108ffff] (bus add=
ress [0x0000-0xffff])
    pci_bus 0003:05: root bus resource [mem 0xa0000000-0xbfffffff]
    pci_bus 0003:05: root bus resource [bus 05-ff]
    pci_bus 0003:05: busn_res: [bus 05-ff] end is updated to ff
    pci 0003:05:00.0: [1957:0050] type 01 class 0x0b2000
    pci 0003:05:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
    pci 0003:05:00.0: supports D1 D2
    pci 0003:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
    pci 0003:05:00.0: bridge configuration invalid ([bus 00-00]), reconfigu=
ring
    pci 0003:05:00.0: PCI bridge to [bus 06-ff]
    pci 0003:05:00.0:   bridge window [io  0xe1080000-0xe1080fff]
    pci 0003:05:00.0:   bridge window [mem 0x00000000-0x000fffff]
    pci 0003:05:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
    pci_bus 0003:06: busn_res: [bus 06-ff] end is updated to 06
    pci_bus 0003:05: busn_res: [bus 05-ff] end is updated to 06
    PCI 0001:01 Cannot reserve Legacy IO [io  0xe1040000-0xe1040fff]
    PCI 0002:03 Cannot reserve Legacy IO [io  0xe1060000-0xe1060fff]
    PCI 0003:05 Cannot reserve Legacy IO [io  0xe1080000-0xe1080fff]
    pci 0000:00:11.0: BAR 6: assigned [mem 0x80040000-0x8005ffff pref]
    pci 0001:01:00.0: PCI bridge to [bus 02]
    pci 0001:01:00.0:   bridge window [io  0xe1040000-0xe104ffff]
    pci 0001:01:00.0:   bridge window [mem 0x98000000-0x9fffffff]
    pci 0002:03:00.0: PCI bridge to [bus 04]
    pci 0002:03:00.0:   bridge window [io  0xe1060000-0xe106ffff]
    pci 0002:03:00.0:   bridge window [mem 0x90000000-0x97ffffff]
    pci 0003:05:00.0: PCI bridge to [bus 06]
    pci 0003:05:00.0:   bridge window [io  0xe1080000-0xe108ffff]
    pci 0003:05:00.0:   bridge window [mem 0xa0000000-0xbfffffff]
    pci 0001:01:00.0: enabling device (0106 -> 0107)
    pci 0002:03:00.0: enabling device (0106 -> 0107)
    pci 0003:05:00.0: enabling device (0106 -> 0107)
    pci_bus 0000:00: resource 4 [io  0xe1020000-0xe102ffff]
    pci_bus 0000:00: resource 5 [mem 0x80000000-0x8fffffff]
    pci_bus 0001:01: resource 4 [io  0xe1040000-0xe104ffff]
    pci_bus 0001:01: resource 5 [mem 0x98000000-0x9fffffff]
    pci_bus 0001:02: resource 0 [io  0xe1040000-0xe104ffff]
    pci_bus 0001:02: resource 1 [mem 0x98000000-0x9fffffff]
    pci_bus 0002:03: resource 4 [io  0xe1060000-0xe106ffff]
    pci_bus 0002:03: resource 5 [mem 0x90000000-0x97ffffff]
    pci_bus 0002:04: resource 0 [io  0xe1060000-0xe106ffff]
    pci_bus 0002:04: resource 1 [mem 0x90000000-0x97ffffff]
    pci_bus 0003:05: resource 4 [io  0xe1080000-0xe108ffff]
    pci_bus 0003:05: resource 5 [mem 0xa0000000-0xbfffffff]
    pci_bus 0003:06: resource 0 [io  0xe1080000-0xe108ffff]
    pci_bus 0003:06: resource 1 [mem 0xa0000000-0xbfffffff]
   =20
   =20
    root@intel_tunnel_creek-2:/root> lspci -v
    0000:00:00.0 Power PC: Freescale Semiconductor Inc MPC8536E (rev 91)
    	Flags: bus master, 66MHz, fast devsel, latency 128
    	Memory at <ignored> (32-bit, non-prefetchable)
    	Memory at <unassigned> (32-bit, prefetchable)
    	Memory at <unassigned> (64-bit, non-prefetchable)
    	Memory at <unassigned> (64-bit, non-prefetchable)
   =20
    0000:00:11.0 Ethernet controller: Intel Corporation 82541PI Gigabit Eth=
ernet Controller (rev 05)
    	Subsystem: Intel Corporation PRO/1000 GT Desktop Adapter
    	Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 35
    	Memory at 80000000 (32-bit, non-prefetchable) [size=3D128K]
    	Memory at 80020000 (32-bit, non-prefetchable) [size=3D128K]
    	I/O ports at 1000 [size=3D64]
    	[virtual] Expansion ROM at 80040000 [disabled] [size=3D128K]
    	Capabilities: [dc] Power Management version 2
    	Capabilities: [e4] PCI-X non-bridge device
    	Kernel driver in use: e1000
   =20
    0001:01:00.0 PCI bridge: Freescale Semiconductor Inc MPC8536E (rev 91) =
(prog-if 00 [Normal decode])
    	Flags: bus master, fast devsel, latency 0
    	Memory at <ignored> (32-bit, non-prefetchable)
    	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
    	I/O behind bridge: 00000000-00000fff
    	Memory behind bridge: 98000000-9fffffff
    	Capabilities: [44] Power Management version 2
    	Capabilities: [4c] Express Root Port (Slot-), MSI 00
    	Capabilities: [100] Advanced Error Reporting
   =20
    0002:03:00.0 PCI bridge: Freescale Semiconductor Inc MPC8536E (rev 91) =
(prog-if 00 [Normal decode])
    	Flags: bus master, fast devsel, latency 0
    	Memory at <ignored> (32-bit, non-prefetchable)
    	Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D0
    	I/O behind bridge: 00000000-00000fff
    	Memory behind bridge: 90000000-97ffffff
    	Capabilities: [44] Power Management version 2
    	Capabilities: [4c] Express Root Port (Slot-), MSI 00
    	Capabilities: [100] Advanced Error Reporting
   =20
    0002:04:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Eth=
ernet Controller (Copper) (rev 06)
    	Subsystem: Intel Corporation PRO/1000 PT Server Adapter
    	Flags: bus master, fast devsel, latency 0, IRQ 38
    	Memory at 90000000 (32-bit, non-prefetchable) [size=3D128K]
    	Memory at 90020000 (32-bit, non-prefetchable) [size=3D128K]
    	I/O ports at 1000 [disabled] [size=3D32]
    	Capabilities: [c8] Power Management version 2
    	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
    	Capabilities: [e0] Express Endpoint, MSI 00
    	Capabilities: [100] Advanced Error Reporting
    	Capabilities: [140] Device Serial Number 00-15-17-ff-ff-f0-ad-1f
    	Kernel driver in use: e1000e
   =20
    0003:05:00.0 PCI bridge: Freescale Semiconductor Inc MPC8536E (rev 91) =
(prog-if 00 [Normal decode])
    	Flags: bus master, fast devsel, latency 0
    	Memory at <ignored> (32-bit, non-prefetchable)
    	Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-latency=3D0
    	I/O behind bridge: 00000000-00000fff
    	Memory behind bridge: a0000000-bfffffff
    	Capabilities: [44] Power Management version 2
    	Capabilities: [4c] Express Root Port (Slot-), MSI 00
    	Capabilities: [100] Advanced Error Reporting


>  What
> hardware does seems broken to me (when PCI is configured as a host
> rather than as an endpoint), but so does calling a host bridge a
> PCI-to-PCI bridge, and so does relying on this mess (not that the
> primary-bus hack is much better...).
>=20
> Note that in the case of PCIe -- but not PCI -- Linux has a quirk
> that relabels the "Processor" on FSL chips as a PCI-to-PCI bridge.
> Despite the "Processor" labelling, Freescale PCIe (but not PCI)
> devices appear to have a type 1 config space layout in host mode.
> I guess this is considered to be the virtual root port.

The resource reassign will occur no matter whether it is a pci or pcie.
All in all the resource starting at 0 is considered a invalid resource
by the ppc kernel and then the kernel will try to reassign it later.
So we really don't have a reason to pick up a pci primary bus on
a board which doesn't have ISA device at all in the current kernel.

Thanks,
Kevin


>=20
> -Scott
>=20
> [1] Really, it's the bridge not having any I/O, but this is how an
> I/O base/limit of zero are interpreted.

--wRokNccIwvMzawGl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR8SAdAAoJEJNY7TDerrFxpoQH/jaGXW3SSf3mSWhlDOwWBeDJ
f10BRlL3rLLZswjmtv5ptw6+AZqGgGnISLAXlzNajo/hYUTKXuVcUrKu5E+uuIQG
eROHwLFLZb70RcGCWyt7K9wafHQmhs7IFSSr3ft/t8tZQYhjV/LC7H7ama+uxFuF
xy5tNQW1x/MdJnyifDD14Ai1SYJr9HNYCFJ7KztbwguyHXa7LdTjCBYRhU6gf3K1
zm+OIEFpLp4vt+lEdzgF9jByTNBMK0KCP/VeS+EM2Evll6z4PvKrU2QIbc4lSEeV
FAUcFZ75eSa/443SMMvwvW91ltAXnVD5ays0TCGKDCk7e0bmvfvaL3WyYkjFOak=
=A1uL
-----END PGP SIGNATURE-----

--wRokNccIwvMzawGl--
