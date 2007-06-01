Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 468F3DDF22
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 16:45:17 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l516jBoH010158
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 23:45:12 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l516jAGG019271
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 01:45:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
Date: Fri, 1 Jun 2007 14:45:03 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C30780F@zch01exm26.fsl.freescale.net>
In-Reply-To: <18015.48278.312517.781244@cargo.ozlabs.ibm.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com><11798051101543-git-send-email-wei.zhang@freescale.com><1179805110272-git-send-email-wei.zhang@freescale.com><1179805110278-git-send-email-wei.zhang@freescale.com><1179856792.27985.22.camel@rhino><46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net><F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org><46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net><A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>
	<18015.48278.312517.781244@cargo.ozlabs.ibm.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Paul,=20

> -----Original Message-----
> From: Paul Mackerras [mailto:paulus@samba.org]=20
>=20
> Kumar Gala writes:
>=20
> > > That's my original doing. If there a PCI bridge card be=20
> pluged into =20
> > > PCI
> > > slot of hose0, I can not ensue the bus_offset number of hose1.
> >=20
> > Ok, but can't we use hose0's last_busno and use that set hose1-=20
> >  >first_busno & hose1->bus_offset?
>=20
> Why do the bus numbers for hose0 and hose1 have to have any relation
> to each other at all?  Aren't they separate PCI domains?

There are lots of lagacy PCI codes in kernel, such as
pci_bus_to_hose(busnr). If two hose's bus number have overlaps,
pci_bus_to_hose() can not return the correct hose. And there will effect
/proc/pci and lspci tools.

Thanks!
Wei.
