Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 754262C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 08:32:44 +1000 (EST)
Date: Tue, 23 Jul 2013 17:31:16 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20130607020020.GA4678@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Thu Jun  6 21:00:20 2013)
Message-ID: <1374618676.15592.40@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2013 09:00:20 PM, Kevin Hao wrote:
> On Mon, Jun 03, 2013 at 11:42:03AM -0500, Scott Wood wrote:
> > On 06/01/2013 07:07:20 PM, Kevin Hao wrote:
> > >On Sat, Jun 01, 2013 at 09:47:16PM +1000, Benjamin Herrenschmidt
> > >wrote:
> > >> On Sat, 2013-06-01 at 18:59 +0800, Kevin Hao wrote:
> > >>
> > >> > The effect of this change is that the isa_io_base will be 0
> > >and the IO
> > >> > resource are equal to the virtual address of the IO space. But
> > >the IO
> > >> > functions such as outx/inx should work as well. This is why I
> > >ask the
> > >> > above question. What do you think about this? Are there any
> > >subtle bugs
> > >> > that will be triggered by this?
> > >>
> > >> I don't see any obvious reason why that wouldn't work but like
> > >anything
> > >> in that area, it needs a bit of testing & hammering to be sure =20
> ;-)
> > >
> > >Agreed.
> >
> > Please include QEMU in your testing, as that was where breakage was
> > observed that caused us to add the default primary.
>=20
> I tested this on a qemu with the following command:
>   ./qemu-system-ppc -m 1024 -nographic -M ppce500 -kernel ./uImage \
>   -initrd /root/initrd.gz \
>   -append "root=3D/dev/ram rw console=3DttyS0,115200 =20
> ramdisk_size=3D0x60000"  \
>   -cpu e500mc -machine dt_compatible=3Dfsl,,P4080DS
>=20
> Before applying my patch:
>   PCI: Probing PCI hardware
>   fsl-pci e0008000.pci: PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>   pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff]
>   pci_bus 0000:00: root bus resource [bus 00-ff]
>   pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
>   pci 0000:00:00.0: [1957:0030] type 01 class 0x060400
>   pci 0000:00:00.0: reg 10: [mem 0xfff00000-0xffffffff]
>   pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
>   pci 0000:00:01.0: reg 10: [io  0x0000-0x001f]
>   pci 0000:00:01.0: reg 14: [mem 0x00000000-0x00000fff]
>   pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), =20
> reconfiguring
>   pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>   pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
>   pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
>   pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
>   pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>   pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
>   PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will =20
> remap
>   PCI 0000:00 Cannot reserve Legacy IO [io  0x0000-0x0fff]
>   pci 0000:00:00.0: BAR 0: assigned [mem 0xc0000000-0xc00fffff]
>   pci 0000:00:00.0: BAR 8: assigned [mem 0xc0100000-0xc01fffff]
>   pci 0000:00:01.0: BAR 1: assigned [mem 0xc0200000-0xc0200fff]
>   pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x101f]
>   pci 0000:00:00.0: PCI bridge to [bus 01]
>   pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
>   pci 0000:00:00.0:   bridge window [mem 0xc0100000-0xc01fffff]
>   pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
>   pci_bus 0000:00: resource 5 [mem 0xc0000000-0xdfffffff]
>   pci_bus 0000:01: resource 0 [io  0x0000-0x0fff]
>   pci_bus 0000:01: resource 1 [mem 0xc0100000-0xc01fffff]
>=20
>   # lspci -vvv
>   00:00.0 PCI bridge: Freescale Semiconductor Inc MPC8533E (prog-if =20
> 00 [Normal decode])
>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
> ParErr- Stepping- SERR+ FastB2B- DisINTx-
>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- =20
> DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>           Latency: 0
>           Region 0: Memory at c0000000 (32-bit, non-prefetchable) =20
> [size=3D1M]
>           Bus: primary=3D00, secondary=3D00, subordinate=3D00, sec-latenc=
y=3D0
>           I/O behind bridge: 00000000-00000fff
>           Memory behind bridge: 00000000-000fffff
>           Prefetchable memory behind bridge: 00000000-000fffff
>           Secondary status: 66MHz- FastB2B- ParErr- =20
> DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>           BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- =20
> FastB2B-
>                   PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>=20
>   00:01.0 Ethernet controller: Red Hat, Inc Virtio network device
>           Subsystem: Red Hat, Inc Device 0001
>           Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- =20
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- =20
> DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>           Interrupt: pin A routed to IRQ 17
>           Region 0: I/O ports at 1000 [disabled] [size=3D32]
>           Region 1: Memory at c0200000 (32-bit, non-prefetchable) =20
> [disabled] [size=3D4K]
>           Capabilities: [40] MSI-X: Enable- Count=3D3 Masked-
>                   Vector table: BAR=3D1 offset=3D00000000
>                   PBA: BAR=3D1 offset=3D00000800
>=20
> After applying my patch:
>   PCI: Probing PCI hardware
>   fsl-pci e0008000.pci: PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [io  0xf1020000-0xf102ffff] (bus =20
> address [0x0000-0xffff])
>   pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff]
>   pci_bus 0000:00: root bus resource [bus 00-ff]
>   pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
>   pci 0000:00:00.0: [1957:0030] type 01 class 0x060400
>   pci 0000:00:00.0: reg 10: [mem 0xfff00000-0xffffffff]
>   pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
>   pci 0000:00:01.0: reg 10: [io  0xf1020000-0xf102001f]
>   pci 0000:00:01.0: reg 14: [mem 0x00000000-0x00000fff]
>   pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), =20
> reconfiguring
>   pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>   pci 0000:00:00.0:   bridge window [io  0xf1020000-0xf1020fff]
>   pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
>   pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
>   pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>   pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
>   PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will =20
> remap
>   PCI: Cannot allocate resource region 0 of device 0000:00:01.0, will =20
> remap
>   PCI 0000:00 Cannot reserve Legacy IO [io  0xf1020000-0xf1020fff]
>   pci 0000:00:00.0: BAR 0: assigned [mem 0xc0000000-0xc00fffff]
>   pci 0000:00:00.0: BAR 8: assigned [mem 0xc0100000-0xc01fffff]
>   pci 0000:00:01.0: BAR 1: assigned [mem 0xc0200000-0xc0200fff]
>   pci 0000:00:01.0: BAR 0: assigned [io  0xf1021000-0xf102101f]
>   pci 0000:00:00.0: PCI bridge to [bus 01]
>   pci 0000:00:00.0:   bridge window [io  0xf1020000-0xf1020fff]
>   pci 0000:00:00.0:   bridge window [mem 0xc0100000-0xc01fffff]
>   pci_bus 0000:00: resource 4 [io  0xf1020000-0xf102ffff]
>   pci_bus 0000:00: resource 5 [mem 0xc0000000-0xdfffffff]
>   pci_bus 0000:01: resource 0 [io  0xf1020000-0xf1020fff]
>   pci_bus 0000:01: resource 1 [mem 0xc0100000-0xc01fffff]
>=20
>   # lspci -vvv
>   00:00.0 PCI bridge: Freescale Semiconductor Inc MPC8533E (prog-if =20
> 00 [Normal decode])
>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =20
> ParErr- Stepping- SERR+ FastB2B- DisINTx-
>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- =20
> DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>           Latency: 0
>           Region 0: Memory at c0000000 (32-bit, non-prefetchable) =20
> [size=3D1M]
>           Bus: primary=3D00, secondary=3D00, subordinate=3D00, sec-latenc=
y=3D0
>           I/O behind bridge: 00000000-00000fff
>           Memory behind bridge: 00000000-000fffff
>           Prefetchable memory behind bridge: 00000000-000fffff
>           Secondary status: 66MHz- FastB2B- ParErr- =20
> DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>           BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- =20
> FastB2B-
>                   PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>=20
>   00:01.0 Ethernet controller: Red Hat, Inc Virtio network device
>           Subsystem: Red Hat, Inc Device 0001
>           Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- =20
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- =20
> DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>           Interrupt: pin A routed to IRQ 17
>           Region 0: I/O ports at 1000 [disabled] [size=3D32]
>           Region 1: Memory at c0200000 (32-bit, non-prefetchable) =20
> [disabled] [size=3D4K]
>           Capabilities: [40] MSI-X: Enable- Count=3D3 Masked-
>                   Vector table: BAR=3D1 offset=3D00000000
>                   PBA: BAR=3D1 offset=3D00000800
>=20
>=20
> As you can see, the only difference between these two logs is the
> io resource address and all the mem and bus address are still the
> same.

I dug a bit deeper into this, and it's making by head hurt.  It seems =20
that we're now getting saved by the host bridge (that for some reason =20
has the class code of a PCI-to-PCI bridge rather than a host bridge) =20
having I/O space of 0x1000 bytes[1], which gets allocated at zero.  =20
There have been some changes in the QEMU PCI code since I saw the =20
problem, including changing the class code of the bridge, so that's =20
probably why it sort-of works now.

What QEMU is doing does not match what real hardware does, though.  At =20
least on mpc8536 which is similar to mpc8544 (I wasn't able to quickly =20
get access to a working mpc8544 to test on), the PCI bridge has class =20
code Processor, rather than bridge of any sort.  Thus, on real hardware =20
we would not get the 0x1000 reservation.  What hardware does seems =20
broken to me (when PCI is configured as a host rather than as an =20
endpoint), but so does calling a host bridge a PCI-to-PCI bridge, and =20
so does relying on this mess (not that the primary-bus hack is much =20
better...).

Note that in the case of PCIe -- but not PCI -- Linux has a quirk that =20
relabels the "Processor" on FSL chips as a PCI-to-PCI bridge.  Despite =20
the "Processor" labelling, Freescale PCIe (but not PCI) devices appear =20
to have a type 1 config space layout in host mode.   I guess this is =20
considered to be the virtual root port.

-Scott

[1] Really, it's the bridge not having any I/O, but this is how an I/O =20
base/limit of zero are interpreted.=
