Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B73F4DDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 16:31:15 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6C6V7om008927
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 23:31:08 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6C6V6AQ014076
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 01:31:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 3/4] Extend the DMA-engine API.
Date: Thu, 12 Jul 2007 14:31:05 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3DFA@zch01exm26.fsl.freescale.net>
In-Reply-To: <e9c3a7c20707110956r5ea91fd1q1d0b33b9583fe91c@mail.gmail.com>
References: <11840607111926-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20707101141m17e313e2k99be5b7197edc910@mail.gmail.com>
	<46B96294322F7D458F9648B60E15112C6F3CED@zch01exm26.fsl.freescale.net>
	<e9c3a7c20707110956r5ea91fd1q1d0b33b9583fe91c@mail.gmail.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Dan Williams" <dan.j.williams@intel.com>
Cc: shannon.nelson@intel.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Dan,

Thanks! I get it.
It's so lucky we have the same target.
When your patch could be accepted?

Cheers,
Wei.=20

> -----Original Message-----
> From: dan.j.williams@gmail.com=20
> [mailto:dan.j.williams@gmail.com] On Behalf Of Dan Williams
> Sent: Thursday, July 12, 2007 12:57 AM
> To: Zhang Wei-r63237
> Cc: akpm@linux-foundation.org; paulus@samba.org;=20
> galak@kernel.crashing.org; linuxppc-dev@ozlabs.org;=20
> linux-kernel@vger.kernel.org; shannon.nelson@intel.com
> Subject: Re: [PATCH 3/4] Extend the DMA-engine API.
>=20
> On 7/11/07, Zhang Wei-r63237 <Wei.Zhang@freescale.com> wrote:
> > Hi, Dan,
> >
> > Do you mention here:=20
> http://marc.info/?l=3Dlinux-raid&m=3D118290909614463&w=3D2 ?
> > I see the async_tx is located at crypto/ of the above page,=20
> but my patch is for DMA engine in drivers/dma and for DMA=20
> engine driver.
> >
> > Thanks!
> > Wei.
>=20
> Hi Wei,
>=20
> I was referring to:
> http://marc.info/?l=3Dlinux-raid&m=3D118290909528910&w=3D2
>=20
> async_tx is an api that exploits the raw capabilities of the new
> dmaengine interface.  For your case when the existing api calls do not
> provide the proper interface you can open code something like the
> following:
>=20
> tx =3D dev->device_prep_dma_<operation>(chan, len, int_flag)
> tx->tx_set_src(dma_addr_t, tx, index /* for multi-source ops */)
> tx->tx_set_dest(dma_addr_t, tx, index)
> tx->tx_submit(tx)
>=20
> The expectation is that the most common usages of dmaengines will use
> async_tx calls, or the 'dma_async_memcpy_foo_to_bar' helper routines.
>=20
> --
> Dan
>=20
