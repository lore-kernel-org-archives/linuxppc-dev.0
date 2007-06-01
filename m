Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4A69DDFAC
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 12:01:29 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l5121Nad028952
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 19:01:24 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5121Mms012307
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 21:01:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
Date: Fri, 1 Jun 2007 10:01:20 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net>
In-Reply-To: <F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<1179856792.27985.22.camel@rhino>
	<46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
	<F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Kumar,=20

>=20
> Can this be fixed by just setting hose->bus_offset in add_bridge?
>=20
> Doing this in exclude is very bad.

That's my original doing. If there a PCI bridge card be pluged into PCI
slot of hose0, I can not ensue the bus_offset number of hose1.

Wei.

>=20
> - k
>=20
> >> -----Original Message-----
> >> From: Wade Farnsworth [mailto:wfarnsworth@mvista.com]
> >> Subject: Re: [PATCH 3/5] Float the pci bus number on
> >> MPC8641HPCN board.
> >>
> >> On Tue, 2007-05-22 at 11:38 +0800, Zhang Wei wrote:
> >>>  int mpc86xx_exclude_device(u_char bus, u_char devfn)
> >>>  {
> >>> +	struct pci_controller *hose;
> >>> +
> >>> +	hose =3D pci_bus_to_hose(bus);
> >>> +	if (unlikely(!hose))
> >>> +		return PCIBIOS_DEVICE_NOT_FOUND;
> >>> +
> >>> +	/* Correcting the hose->bus_offset value. */
> >>> +	out_be32(hose->cfg_addr, 0x80000000 | ((hose->first_busno
> >>> +					- hose->bus_offset) << 16));
> >>> +	if (unlikely(in_le32(hose->cfg_data) =3D=3D 0xffffffff))
> >>> +		hose->bus_offset =3D hose->bus_offset ? 0 :
> >> hose->first_busno;
> >>> +
> >>>  	return PCIBIOS_SUCCESSFUL;
> >>>  }
> >>
> >> What is the purpose of this code and why put it in
> >> mpc86xx_exclude_device?
> >>
> >> --Wade
> >>
> >>
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
