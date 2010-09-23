Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BCA82B6EF0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 13:21:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8641D PEX: programming OWBAR in Endpoint mode?
Date: Thu, 23 Sep 2010 05:21:10 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>
References: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: <david.hagood@gmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.o
zlabs.org] On Behalf Of david.hagood@gmail.com
> Sent: Wednesday, September 22, 2010 11:56 PM
> To: linuxppc-dev@ozlabs.org
> Subject: MPC8641D PEX: programming OWBAR in Endpoint mode?
>=20
> I am trying to get the PCIe interfaces of a Freescale=20
> MPC8641D working in endpoint mode (i.e. as a PCI device=20
> rather than a PCI root complex host).
>=20

As far as I recalled on 4xx the u-boot support for dynamic configuration
of PCIe ports for the targets equipped with PCIe interfaces. Often this
is done via the "pcie_mode" environement variable on the u-boot prompt.
On there you can set to "EP" or "RP" for endpoint or rootpoint mode.

But for Freescale MPC86xx this should be set accordin to the external
configure pin.

> I can get the device to show up on the host's PCI bus, I can=20

This only ensure you can access the PCIe configure space.

> program the inbound ATMUs such that the BARS are updated when=20
> the host (re-)scans them, but I cannot for the life of me get

What value are configured to IntBound REGs?
=20
> the PPC's Outbound ATMUS to work.
>=20
> When I attempt to program them, I can program ALL the=20
> registers EXCEPT the OWBAR - which steadfastly remains 0 no=20
> matter what I write to it.
>=20

How do you configure OWS of PEXOWAR?

I means you still access that if OWS is match the whole target memory
size even when '0' is as the internal platform address.

> As a result, when I attempt to bus master out from the PPC to=20
> the PCIe address spaces via the outbound ATMUs, I get a bus=20
> fault on the PPC as there is no device at the address I am accessing.
>=20
> I've double-checked the LAWs to make sure the PEX is mapped=20
> into local space, I've put the OWBAR in that address space,=20
> I've tried different outbound ATMUs, and NOTHING works. Not=20
> ATMU0, not ATMU1, etc.
>=20
> I've been trying to work with our Freescale rep, but I am=20
> getting nowhere on that front.
>=20
> Does anybody have any suggestions on what I might be doing=20
> wrong? I mean, it looks like it should be a simple=20
> out_be32(addr_of_OWBAR,value), just like all the other=20
> accesses to the ATMU registers that seem to be working (as=20
> in, I read back what I wrote).

Out_be32 should be fine for atmu REGs. And also you can refe to the
function, setup_pci_atmu & setup_one_atmu, on the file,
arch/powerpc/sysdev/fsl_pci.c, to know how to access atmu REGs. Often
you should disable them, configure then enable/invoke atmu antry as
normal configuring sequent.

Additionally I'm a bit afraid your initial phase :) As you know PCIe
would be used as RC mode on Freescale PowerPC kernel. So I don't know if
you also drop this path on your kernel to conflict each other :)=20

Cheers
Tiejun

>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
