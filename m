Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 71AACB70DA
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 00:10:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8641D PEX: programming OWBAR in Endpoint mode?
Date: Thu, 23 Sep 2010 16:10:26 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8C14B@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <1285240268.2454.8.camel@chumley>
References: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>
	<52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>
	<1285240268.2454.8.camel@chumley>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "David Hagood" <david.hagood@gmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Hagood [mailto:david.hagood@gmail.com]=20
> Sent: Thursday, September 23, 2010 7:11 PM
> To: Chen, Tiejun; linuxppc-dev@ozlabs.org
> Subject: RE: MPC8641D PEX: programming OWBAR in Endpoint mode?
>=20
> On Thu, 2010-09-23 at 05:21 +0200, Chen, Tiejun wrote:
> > > I can get the device to show up on the host's PCI bus, I can
> >=20
> > This only ensure you can access the PCIe configure space.
> Not quite: I can also read the BARs that I program, and the=20
> memory behind them on the PPC.

Absolutely.=20

> >=20
> > > program the inbound ATMUs such that the BARS are updated when the=20
> > > host (re-)scans them, but I cannot for the life of me get
> >=20
> > What value are configured to IntBound REGs?
> I can program them at run time via sysfs on the PPC's side,=20
> so there is no single set of values. However, I am pointing=20
> them at the PPC's RAM space, and as I stated above, I can=20
> read the PPC's RAM from the host side via the BARs.

I read your email again and something hint me. I notice you clarify you
already condigure InBound successfully. Right? If so I'm a bit confused.
For PCIe EP mode PEXIWBARs are not implemented in the memory-mapped
space. If you read any PEXIWBAR these registers always return zero
regardless of writing any value at first.=20

You only can program 4 inbound BARs by type 0 configure action like
normal PCIe device.

>=20
> > How do you configure OWS of PEXOWAR?
> >=20
> > I means you still access that if OWS is match the whole=20
> target memory=20
> > size even when '0' is as the internal platform address.
> As I understand it, not if the OWS is not correctly mapped on=20
> the PPC side - the PEX outbound ATMU's OWBAR must be mapped=20
> to a region of the PPCs address space that is also mapped to=20
> PEX in the LAW. The LAW does NOT indicate that PPC address 0=20
> is mapped to the PEX.

If there is no any law entry for PCIe the kernel should trap machine
check when you access PCIe space. And as my above comment I'm afraid you
mix up InBound and OutBound on EP mode? So you always read zero from
your so-called OutBound? I means that should be PEXIWBAR in fact. I'm
not sure but you can check this.

>=20
> >=20
> > Out_be32 should be fine for atmu REGs. And also you can refe to the=20
> > function, setup_pci_atmu & setup_one_atmu, on the file,=20
> > arch/powerpc/sysdev/fsl_pci.c, to know how to access atmu=20
> REGs. Often=20
> > you should disable them, configure then enable/invoke atmu antry as=20
> > normal configuring sequent.
> I have tried disabling the outbound ATMU when I program it,=20
> with no change.
> I have looked at the functions you mention, and that is a=20
> part of my confusion, as they aren't doing anything different=20
> than I am.

I only means you can refer how to access these registers.

> >=20
> > Additionally I'm a bit afraid your initial phase :) As you=20
> know PCIe=20
> > would be used as RC mode on Freescale PowerPC kernel. So I=20
> don't know=20
> > if you also drop this path on your kernel to conflict each other :)
> I have tried doing this under a kernel built without PCI=20
> support with no change.

Good.

Tiejun

>=20
>=20
>=20
