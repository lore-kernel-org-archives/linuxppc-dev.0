Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6333DDE16
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:35:58 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4N3ZrUA002337
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 20:35:53 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4N3ZpBj026160
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 22:35:52 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
Date: Wed, 23 May 2007 11:35:50 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
In-Reply-To: <1179856792.27985.22.camel@rhino>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<1179856792.27985.22.camel@rhino>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Wade Farnsworth" <wfarnsworth@mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Wade,

That's a good question.

The ppc_md.exclude_device() function will be called before PCI config
access in indirect_read/write_config() of the file
arch/powerpc/sysdev/indirect_pci.c. If the hose->bus_offset value is 0,
the primary bus number register of the host must be hose->first_busno.
Otherwise, if the host primary bus number register is 0, the
hose->bus_offset must be the same value of hose->first_buseno.

When the pci scan bus, the bridge will be scaned twice. When the second
scan is finished, the host primary bus number register will be write to
hose->first_busno. The PCI bus(not the first PCI host) access will be
wrong in the later access. I'll check it and correct the
hose->bus_offset value in these codes.

Thanks!
Wei

> -----Original Message-----
> From: Wade Farnsworth [mailto:wfarnsworth@mvista.com]=20
> Subject: Re: [PATCH 3/5] Float the pci bus number on=20
> MPC8641HPCN board.
>=20
> On Tue, 2007-05-22 at 11:38 +0800, Zhang Wei wrote:
> >  int mpc86xx_exclude_device(u_char bus, u_char devfn)
> >  {
> > +	struct pci_controller *hose;
> > +
> > +	hose =3D pci_bus_to_hose(bus);
> > +	if (unlikely(!hose))
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	/* Correcting the hose->bus_offset value. */
> > +	out_be32(hose->cfg_addr, 0x80000000 | ((hose->first_busno
> > +					- hose->bus_offset) << 16));
> > +	if (unlikely(in_le32(hose->cfg_data) =3D=3D 0xffffffff))
> > +		hose->bus_offset =3D hose->bus_offset ? 0 :=20
> hose->first_busno;
> > +
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
>=20
> What is the purpose of this code and why put it in
> mpc86xx_exclude_device?
>=20
> --Wade
>=20
>=20
