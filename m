Return-Path: <claudiu.manoil@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0107.outbound.protection.outlook.com [157.56.110.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93FE91A1A53
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 21:19:25 +1000 (AEST)
From: Manoil Claudiu <claudiu.manoil@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] gianfar: Fix warnings when built on 64-bit
Date: Wed, 29 Jul 2015 11:03:29 +0000
Message-ID: <CY1PR0301MB0732B8101733EF131F29D3F89C8C0@CY1PR0301MB0732.namprd03.prod.outlook.com>
References: <1438147477-393-1-git-send-email-scottwood@freescale.com>
 <4498062.4y369pLSmO@wuerfel>
In-Reply-To: <4498062.4y369pLSmO@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, July 29, 2015 11:02 AM
> To: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org; Manoil Claudiu=
-
> B08782; Wood Scott-B07421
> Subject: Re: [PATCH] gianfar: Fix warnings when built on 64-bit
>=20
> On Wednesday 29 July 2015 00:24:37 Scott Wood wrote:
>=20
> > Alternatively, if there's a desire to not mess with this code (I don't
> > know how to trigger this code path to test it), this driver should be
> > given dependencies that ensure that it only builds on 32-bit.
>=20
[...]

> > @@ -2964,8 +2967,13 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q
> *rx_queue, int rx_work_limit)
> >  		gfar_init_rxbdp(rx_queue, bdp, bufaddr);
> >
> >  		/* Update Last Free RxBD pointer for LFC */
> > -		if (unlikely(rx_queue->rfbptr && priv->tx_actual_en))
> > -			gfar_write(rx_queue->rfbptr, (u32)bdp);
> > +		if (unlikely(rx_queue->rfbptr && priv->tx_actual_en)) {
> > +			u32 bdp_dma;
> > +
> > +			bdp_dma =3D lower_32_bits(rx_queue-
> >rx_bd_dma_base);
> > +			bdp_dma +=3D (uintptr_t)bdp - (uintptr_t)base;
> > +			gfar_write(rx_queue->rfbptr, bdp_dma);
> > +		}
> >
> >  		/* Update to the next pointer */
> >  		bdp =3D next_bd(bdp, base, rx_queue->rx_ring_size);
>=20
> You are fixing two problems here: the warning about a size cast, and
> the fact that the driver is using the wrong pointer. I'd suggest
> explaining it in the changelog.
>=20

What would be the wrong pointer here? "base"?
"base" is " rx_queue->rx_bd_base".

> Note that we normally rely on void pointer arithmetic in the kernel, so
> I'd write it without the uintptr_t casts as
>=20
> 	bdp_dma =3D lower_32_bits(rx_queue->rx_bd_dma_base + (base -
> bdp));

I think you mean: (bdp-base)

Claudiu
