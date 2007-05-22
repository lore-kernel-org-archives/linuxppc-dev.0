Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3CA55DDE36
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 14:46:56 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4M4ko77008187
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 21:46:50 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4M4kmo7019004
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 23:46:49 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/5] Add the support for MPC8641 silicon rev 2.0 and
	MPC8641HPCN board 2.0
Date: Tue, 22 May 2007 12:46:47 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C2348C8@zch01exm26.fsl.freescale.net>
In-Reply-To: <B9B280B9-3F66-479B-ABB2-FD294EC25C7E@kernel.crashing.org>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<B9B280B9-3F66-479B-ABB2-FD294EC25C7E@kernel.crashing.org>
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

Hi, Kumar,

Please see my inline comments:
> >
> >   [PATCH 1/5] Remove the errata fix codes for MPC8641 silicon ver =20
> > 1.0 which is end of life.

This patch is not included in Wade's patch.

MPC8641 silicon 1.0 is end of life and not full following
PCI/PCI-Express specifications.
Rev 2.0 silicon fixes these PCI/PCI-Express errata and follows the
PCI/PCI-Ex specifications.
So, using generic PCI codes is okay.


> >   [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.

This's a simple and clear solution to Wade's pci fix patch. Some changes
of Wade's pci fix patch are redundant.

> >   [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.

This patch is not included in Wade's patch.

Every PCI hose bus range number is started from 0 before. This patch
make the hose bus range number is started from previous hose last bus
number added one.
And PCI-Ex tranining status check is added to avoid the system halt.

> >   [PATCH 4/5] Set RC of mpc8641 to transparent bridge for transfer =20
> > legacy I/O access.

This patch is different than Wade's pci fix patch.
Wade's pci patch changing MPC8641 PCI_CLASS property is not a good
solution. Only set it to transport bridge is okay.
And this quirk functions should applied to both MPC8641 and MPC8641D,
not only dual core version.

> >   [PATCH 5/5] Set IDE in ULI1575 to not native mode.

This patch is not included in Wade's patch.
It makes IDE in ULI1575 works.

>=20
> How do these patches differ/interace from what Wade posted a=20
> few days =20
> ago?

Wade's MTD patch (patch 1), Legacy patch (patch 2), superIO patch (patch
3), RTC patch (patch 4) is not overlap with my patches.
But Wade's PCI patch (patch 5) most of codes is for supporting a
discontinued and end of life silicon and I do not agree with the changes
about PCI_CLASS of MPC8641. The dts fixing is too complex. I suggest to
reject Wade's PCI patch.

Thanks!
Wei
