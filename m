Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 321F92C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 12:00:33 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id kl13so2179677pab.20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jun 2013 19:00:30 -0700 (PDT)
Date: Fri, 7 Jun 2013 10:00:20 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
Message-ID: <20130607020020.GA4678@pek-khao-d1.corp.ad.wrs.com>
References: <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
 <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
 <1369940099.14679.14@snotra>
 <20130531064102.GB16514@pek-khao-d1.corp.ad.wrs.com>
 <1369995080.3928.140.camel@pasglop>
 <20130601105936.GA1850@pek-khao-d1.corp.ad.wrs.com>
 <1370087236.3766.43.camel@pasglop>
 <20130602000720.GA22546@pek-khao-d1.corp.ad.wrs.com>
 <1370277723.21388.1@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <1370277723.21388.1@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2013 at 11:42:03AM -0500, Scott Wood wrote:
> On 06/01/2013 07:07:20 PM, Kevin Hao wrote:
> >On Sat, Jun 01, 2013 at 09:47:16PM +1000, Benjamin Herrenschmidt
> >wrote:
> >> On Sat, 2013-06-01 at 18:59 +0800, Kevin Hao wrote:
> >>
> >> > The effect of this change is that the isa_io_base will be 0
> >and the IO
> >> > resource are equal to the virtual address of the IO space. But
> >the IO
> >> > functions such as outx/inx should work as well. This is why I
> >ask the
> >> > above question. What do you think about this? Are there any
> >subtle bugs
> >> > that will be triggered by this?
> >>
> >> I don't see any obvious reason why that wouldn't work but like
> >anything
> >> in that area, it needs a bit of testing & hammering to be sure ;-)
> >
> >Agreed.
>=20
> Please include QEMU in your testing, as that was where breakage was
> observed that caused us to add the default primary.

I tested this on a qemu with the following command:
  ./qemu-system-ppc -m 1024 -nographic -M ppce500 -kernel ./uImage \
  -initrd /root/initrd.gz \
  -append "root=3D/dev/ram rw console=3DttyS0,115200 ramdisk_size=3D0x60000=
"  \
  -cpu e500mc -machine dt_compatible=3Dfsl,,P4080DS

Before applying my patch:
  PCI: Probing PCI hardware
  fsl-pci e0008000.pci: PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
  pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff]
  pci_bus 0000:00: root bus resource [bus 00-ff]
  pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
  pci 0000:00:00.0: [1957:0030] type 01 class 0x060400
  pci 0000:00:00.0: reg 10: [mem 0xfff00000-0xffffffff]
  pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
  pci 0000:00:01.0: reg 10: [io  0x0000-0x001f]
  pci 0000:00:01.0: reg 14: [mem 0x00000000-0x00000fff]
  pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
  pci 0000:00:00.0: PCI bridge to [bus 01-ff]
  pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
  pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
  pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
  pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
  pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
  PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will remap
  PCI 0000:00 Cannot reserve Legacy IO [io  0x0000-0x0fff]
  pci 0000:00:00.0: BAR 0: assigned [mem 0xc0000000-0xc00fffff]
  pci 0000:00:00.0: BAR 8: assigned [mem 0xc0100000-0xc01fffff]
  pci 0000:00:01.0: BAR 1: assigned [mem 0xc0200000-0xc0200fff]
  pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x101f]
  pci 0000:00:00.0: PCI bridge to [bus 01]
  pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
  pci 0000:00:00.0:   bridge window [mem 0xc0100000-0xc01fffff]
  pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
  pci_bus 0000:00: resource 5 [mem 0xc0000000-0xdfffffff]
  pci_bus 0000:01: resource 0 [io  0x0000-0x0fff]
  pci_bus 0000:01: resource 1 [mem 0xc0100000-0xc01fffff]
 =20
  # lspci -vvv
  00:00.0 PCI bridge: Freescale Semiconductor Inc MPC8533E (prog-if 00 [Nor=
mal decode])
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B- DisINTx-
          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
          Latency: 0
          Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=3D1=
M]
          Bus: primary=3D00, secondary=3D00, subordinate=3D00, sec-latency=
=3D0
          I/O behind bridge: 00000000-00000fff
          Memory behind bridge: 00000000-000fffff
          Prefetchable memory behind bridge: 00000000-000fffff
          Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-
          BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                  PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 =20
  00:01.0 Ethernet controller: Red Hat, Inc Virtio network device
          Subsystem: Red Hat, Inc Device 0001
          Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-                                       =
                        =20
          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
          Interrupt: pin A routed to IRQ 17
          Region 0: I/O ports at 1000 [disabled] [size=3D32]
          Region 1: Memory at c0200000 (32-bit, non-prefetchable) [disabled=
] [size=3D4K]
          Capabilities: [40] MSI-X: Enable- Count=3D3 Masked-
                  Vector table: BAR=3D1 offset=3D00000000
                  PBA: BAR=3D1 offset=3D00000800
 =20
After applying my patch:
  PCI: Probing PCI hardware
  fsl-pci e0008000.pci: PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [io  0xf1020000-0xf102ffff] (bus addre=
ss [0x0000-0xffff])
  pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff]
  pci_bus 0000:00: root bus resource [bus 00-ff]
  pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
  pci 0000:00:00.0: [1957:0030] type 01 class 0x060400
  pci 0000:00:00.0: reg 10: [mem 0xfff00000-0xffffffff]
  pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
  pci 0000:00:01.0: reg 10: [io  0xf1020000-0xf102001f]
  pci 0000:00:01.0: reg 14: [mem 0x00000000-0x00000fff]
  pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
  pci 0000:00:00.0: PCI bridge to [bus 01-ff]
  pci 0000:00:00.0:   bridge window [io  0xf1020000-0xf1020fff]
  pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
  pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
  pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
  pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
  PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will remap
  PCI: Cannot allocate resource region 0 of device 0000:00:01.0, will remap
  PCI 0000:00 Cannot reserve Legacy IO [io  0xf1020000-0xf1020fff]
  pci 0000:00:00.0: BAR 0: assigned [mem 0xc0000000-0xc00fffff]
  pci 0000:00:00.0: BAR 8: assigned [mem 0xc0100000-0xc01fffff]
  pci 0000:00:01.0: BAR 1: assigned [mem 0xc0200000-0xc0200fff]
  pci 0000:00:01.0: BAR 0: assigned [io  0xf1021000-0xf102101f]
  pci 0000:00:00.0: PCI bridge to [bus 01]
  pci 0000:00:00.0:   bridge window [io  0xf1020000-0xf1020fff]
  pci 0000:00:00.0:   bridge window [mem 0xc0100000-0xc01fffff]
  pci_bus 0000:00: resource 4 [io  0xf1020000-0xf102ffff]
  pci_bus 0000:00: resource 5 [mem 0xc0000000-0xdfffffff]
  pci_bus 0000:01: resource 0 [io  0xf1020000-0xf1020fff]
  pci_bus 0000:01: resource 1 [mem 0xc0100000-0xc01fffff]
 =20
  # lspci -vvv
  00:00.0 PCI bridge: Freescale Semiconductor Inc MPC8533E (prog-if 00 [Nor=
mal decode])
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B- DisINTx-
          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
          Latency: 0
          Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=3D1=
M]
          Bus: primary=3D00, secondary=3D00, subordinate=3D00, sec-latency=
=3D0
          I/O behind bridge: 00000000-00000fff
          Memory behind bridge: 00000000-000fffff
          Prefetchable memory behind bridge: 00000000-000fffff
          Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-
          BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                  PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 =20
  00:01.0 Ethernet controller: Red Hat, Inc Virtio network device
          Subsystem: Red Hat, Inc Device 0001
          Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-
          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
          Interrupt: pin A routed to IRQ 17
          Region 0: I/O ports at 1000 [disabled] [size=3D32]               =
                                                                           =
                          =20
          Region 1: Memory at c0200000 (32-bit, non-prefetchable) [disabled=
] [size=3D4K]
          Capabilities: [40] MSI-X: Enable- Count=3D3 Masked-
                  Vector table: BAR=3D1 offset=3D00000000
                  PBA: BAR=3D1 offset=3D00000800


As you can see, the only difference between these two logs is the
io resource address and all the mem and bus address are still the
same.

>=20
> >> In fact it would work on pmac32 as well since those generally
> >don't have
> >> legacy crap either.
> >>
> >> So I have no fundamental objection, it just needs testing. My
> >worry is
> >> that we need to make sure we don't break old chrp and I don't
> >have any
> >> to test with.
> >
> >Don't worry, my patch just drop the picking of primary bus for several
> >fsl boards. All these changes are in board specific file, so it should
> >have no affect to other boards at all.
>=20
> Is anything actually fixed by this?

No. As you know the reason we need a primary bus is that we need to support
some ISA legacy devices. So it seems a little weird that we have to pick
one primary bus even on a board which doesn't has ISA at all. Even though
we can't drop the support of the primary bus due to these legacy devices,
we had better narrow the scope of using it instead of propagating it to
the boards which definitely don't care the primary bus at all.

Thanks,
Kevin

>=20
> -Scott

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRsT60AAoJEJNY7TDerrFxczoIAICXLqGmIf3gdub3TN3ilvER
Z6gp3zhIOl2Dk3rhldY4fXHvwmCCXpcBPTLM7rhNT7qB0tn4m20uhlPwQQdFwUXc
NkSsdYsh/E5Z/FZ/DOL1aRgWaRJ3uuZtNeHnvPrrVj13EeaepCA8Vz3kpAc7qMvF
VxkwnUqFGhV+mpL8M8w1Rx0DYJoNVN+rRO4GitnnWrt8aGHwHUfQTR03T+dPfQFi
9+V6SJl/WmdZb8A8A+rR66U2uC0H5XnJJCy88dnjYubaNwCownJhYWu1rQJty4M/
g9/yj62APpe17IpknCEnuyC/h3yA1lseBb/N5Nt62RkX3ucxPL4eA/kS7xE9JY8=
=Q+gF
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
