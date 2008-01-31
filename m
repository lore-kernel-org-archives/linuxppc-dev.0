Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0A0FDDDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 17:31:20 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0V6UfUf016773
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 23:31:02 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m0V6UFBZ006175
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 00:30:16 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/6] Add multi mport support.
Date: Thu, 31 Jan 2008 14:30:13 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEBD0697@zch01exm26.fsl.freescale.net>
In-Reply-To: <F2D2FCC7-D1ED-4DC6-BE7A-EE2755CCE125@kernel.crashing.org>
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
	<AF4B8466-C1CE-4FFB-8341-4BFC1CB76116@kernel.crashing.org>
	<ABF87B0B6A38C0458E319AC973ED68AEBD0677@zch01exm26.fsl.freescale.net>
	<EC566605-6890-4983-8700-3B15C9EFC1C5@kernel.crashing.org>
	<F2D2FCC7-D1ED-4DC6-BE7A-EE2755CCE125@kernel.crashing.org>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
>=20
> On Jan 31, 2008, at 12:15 AM, Kumar Gala wrote:
>=20
> >
> > On Jan 30, 2008, at 11:57 PM, Zhang Wei wrote:
> >
> >>
> >>
> >>> -----Original Message-----
> >>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >>>
> >>> On Jan 30, 2008, at 4:30 AM, Zhang Wei wrote:
> >>>
> >>>> Change lots of static variable to mport private. And add
> >>> mport to some
> >>>> function declaration.
> >>>
> >>> Can you explain this patch further.  Its not clear=20
> exactly from this
> >>> commit message why we are doing this.
> >>>
> >>> - k
> >>
> >> Sorry about I have a little hurry about it.
> >>
> >> The original RapidIO driver suppose there is only one mpc85xx RIO
> >> controller
> >> in system. So, some data structures are defined as mpc85xx_rio =20
> >> global,
> >> such as 'regs_win', 'dbell_ring', 'msg_tx_ring'. Now, I=20
> changed them
> >> to
> >> mport's private members. And you can define multi RIO=20
> OF-nodes in dts
> >> file
> >> for multi RapidIO controller in one processor, such as PCI/PCI-Ex =20
> >> host
> >> controllers
> >> in Freescale's silicon. And the mport operation function=20
> declaration
> >> should be changed
> >> to know which RapidIO controller is target.
> >
> > thanks, this makes a lot of sense and now reviewing the patch will
> > make some sense to me :)
>=20
> when we have multiple ports are the device IDs on the ports intended =20
> to be unique only to a port or unique across all ports?
>=20
I consider each RIO controller will has its own network, the device IDs
should be
unique only in its port network.

Cheers!
Wei
