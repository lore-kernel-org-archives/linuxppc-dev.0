Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3AF0DDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 13:07:07 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lB42726L013768
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 19:07:02 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB427177029067
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 20:07:01 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] ipic: change ack operation that register is accessedonly
	when needed
Date: Tue, 4 Dec 2007 10:06:47 +0800
Message-ID: <989B956029373F45A0B8AF029708189001B4D2DE@zch01exm26.fsl.freescale.net>
In-Reply-To: <1196715747.13230.233.camel@pasglop>
References: <1196684780-28408-1-git-send-email-leoli@freescale.com>
	<1196715747.13230.233.camel@pasglop>
From: "Li Yang" <LeoLi@freescale.com>
To: <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: Tuesday, December 04, 2007 5:02 AM
> To: Li Yang
> Cc: galak@kernel.crashing.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] ipic: change ack operation that register=20
> is accessedonly when needed
>=20
>=20
> >  static void ipic_ack_irq(unsigned int virq)  {
> > -	struct ipic *ipic =3D ipic_from_irq(virq);
> >  	unsigned int src =3D ipic_irq_to_hw(virq);
> > -	unsigned long flags;
> > -	u32 temp;
> > =20
> > -	spin_lock_irqsave(&ipic_lock, flags);
> > +	/* Only external interrupts in edge mode support ACK */
> > +	if (unlikely(ipic_info[src].ack &&
> > +			((get_irq_desc(virq)->status &=20
> IRQ_TYPE_SENSE_MASK) =3D=3D
> > +			IRQ_TYPE_EDGE_FALLING))) {
> > +		struct ipic *ipic =3D ipic_from_irq(virq);
> > +		unsigned long flags;
> > +		u32 temp;
> > =20
> > -	temp =3D ipic_read(ipic->regs, ipic_info[src].pend);
> > -	temp |=3D (1 << (31 - ipic_info[src].bit));
> > -	ipic_write(ipic->regs, ipic_info[src].pend, temp);
> > +		spin_lock_irqsave(&ipic_lock, flags);
> > =20
> > -	spin_unlock_irqrestore(&ipic_lock, flags);
> > +		temp =3D ipic_read(ipic->regs, ipic_info[src].ack);
> > +		temp |=3D (1 << (31 - ipic_info[src].bit));
> > +		ipic_write(ipic->regs, ipic_info[src].ack, temp);
> > +
> > +		spin_unlock_irqrestore(&ipic_lock, flags);
> > +	}
> >  }
>=20
> That doesn't look right...=20
>=20
> That should be handled by the higher level flow handler. The=20
> generic edge one calls ack and the level one mask_and_ack.=20
> Just make them do the right thing, no need to test for the=20
> flow type in the low level function.

But actually ack is called by edge and per cpu handlers.  Mask_and_ack
is also called by edge handler when the same interrupt is already in
progress.  So I don't think that ack/mask_and_ack implicates flow type
by design.

- Leo
