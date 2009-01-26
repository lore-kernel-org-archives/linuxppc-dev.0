Return-Path: <Dai.Haruki@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35E51DE0D4
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 10:40:02 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0QNdvV9017300
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 16:39:57 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0QNduKb013420
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 17:39:56 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] gianfar: Revive VLAN support
Date: Mon, 26 Jan 2009 16:39:55 -0700
Message-ID: <18AEF66AFDF06F4CAAA1D419D000FD33029D5F46@az33exm24.fsl.freescale.net>
In-Reply-To: <324701F1-4A84-41A6-BC2D-4A61A8E135D9@freescale.com>
References: <20090126205043.GA15581@oksana.dev.rtsoft.ru>
	<324701F1-4A84-41A6-BC2D-4A61A8E135D9@freescale.com>
From: "Haruki Dai" <Dai.Haruki@freescale.com>
To: "Fleming Andy-AFLEMING" <afleming@freescale.com>,
	"Anton Vorontsov" <avorontsov@ru.mvista.com>
Cc: netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Fleming Andy-AFLEMING
> Sent: Monday, January 26, 2009 3:08 PM
> To: Anton Vorontsov
> Cc: Jeff Garzik; David Miller; Haruki Dai-R35557;
netdev@vger.kernel.org;
> linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] gianfar: Revive VLAN support
>=20
>=20
> On Jan 26, 2009, at 2:50 PM, Anton Vorontsov wrote:
>=20
> > commit 77ecaf2d5a8bfd548eed3f05c1c2e6573d5de4ba ("gianfar: Fix VLAN
> > HW feature related frame/buffer size calculation") wrongly removed
> > priv->vlgrp assignment, and now priv->vlgrp is always NULL.
> >
> > This patch fixes the issue, plus fixes following sparse warning
> > introduced by the same commit:
> > gianfar.c:1406:13: warning: context imbalance in
> > 'gfar_vlan_rx_register' - wrong count at exit
> >
> > gfar_vlan_rx_register() checks for "if (old_grp =3D=3D grp)" and =
tries
> > to return w/o dropping the lock.
> >
> > According to net/8021q/vlan.c VLAN core issues rx_register()
callback:
> > 1. In register_vlan_dev() only on a newly created group;
> > 2. In unregister_vlan_dev() only if the group becomes empty.
> >
> > Thus the check in the gianfar driver isn't needed.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>=20
> Acked-by: Andy Fleming <afleming@freescale.com>

Acked-by: Dai Haruki <dai.haruki@freescale.com>
