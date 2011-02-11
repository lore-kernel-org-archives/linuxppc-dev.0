Return-Path: <kho@belairnetworks.com>
Received: from mail.belairnetworks.com (mail.belairnetworks.com
	[142.46.200.253]) by ozlabs.org (Postfix) with ESMTP id E05BFB71A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 09:15:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Question on setting up external interrupt for P1020 (MPC8xxx)
	with device tree
Date: Fri, 11 Feb 2011 17:15:47 -0500
Message-ID: <92C536451C241244A14F3001819BF6688A503C@bnott05.belairnetworks.com>
In-Reply-To: <20110211155644.6799f6b6@udp111988uds>
References: <92C536451C241244A14F3001819BF6688A503B@bnott05.belairnetworks.com>
	<20110211155644.6799f6b6@udp111988uds>
From: "Kenny Ho" <kho@belairnetworks.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Scott.

Do you know the logic of the hwirq <-> virq mapping?  When I was digging
into the GPIO interrupt, the hwirq seems to be the same as the virq
(both are 47 which is 16 (external interrupt) + 31 (internal interrupt).
If I want to use external interrupt 7 and 8, should the virq also be 7
and 8?  For some reason I am getting 41 for virq... may be I am still
doing something wrong.

This is the node definition I created:
rpcl {
	compatible =3D "ba,rpcl";
	interrupts =3D <0x7 2 0x8 2>;
	interrupt-parent =3D <&mpic>;
};

Kenny

-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]=20
Sent: Friday, February 11, 2011 4:57 PM
To: Kenny Ho
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Question on setting up external interrupt for P1020
(MPC8xxx) with device tree

On Fri, 11 Feb 2011 14:07:26 -0500
Kenny Ho <kho@belairnetworks.com> wrote:

> Hi,
>=20
> =20
>=20
> I am trying to write a device driver that uses an external interrupt
> (one of the 16 irq lines) for the Freescale P1020 processor and I hope
> some of you can help.  Am I suppose to setup a separate node in the
dts
> and look for that node in my driver to setup the interrupt?=20

Ideally, yes.  It's good to describe your device with a node even if it
doesn't have interrupts.

> Or does the > dts interrupt declaration belong to the
interrupt-controller
> declaration?  I noticed the mpc8xxx_gpio driver defined its own
irq_chip
> but I thought that may be because each gpio pin can trigger an
> interrupt.

Right, it's because gpio is an interrupt controller, not just a user of
one.

> Do I need to define my own irq_chip structure for my device
> even if I am using one of the hard irq lines? =20

No.  If the device's node describes the interrupt correctly, you can use
irq_of_parse_and_map() on the device node to get a virtual irq that you
can
pass to request_irq().

-Scott
