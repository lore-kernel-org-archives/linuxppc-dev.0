Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 5A6DDDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 17:16:07 +1000 (EST)
Subject: Re: IRQ2-4 number to use on mpc83xx?
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
In-Reply-To: <1222201093.12624.154.camel@gentoo-jocke.transmode.se>
References: <062501c91d03$0c46be40$24d43ac0$@se>
	<48D8B225.4000709@matrix-vision.de>
	<1222168128.12624.125.camel@gentoo-jocke.transmode.se>
	<1222201093.12624.154.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Sep 2008 09:16:05 +0200
Message-Id: <1222240565.12624.165.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-23 at 22:18 +0200, Joakim Tjernlund wrote:
> On Tue, 2008-09-23 at 13:08 +0200, Joakim Tjernlund wrote:
> > On Tue, 2008-09-23 at 11:08 +0200, Andre Schwarz wrote:
> > > I can only tell how I do on MPC834x :
> > >=20
> > > Table 8-6. IVEC/CVEC/MVEC Field Definition
> > >=20
> > > Interrupt ID Number         Interrupt Meaning
> > > 17                                           IRQ1
> > > 18                                           IRQ2
> > > 19                                           IRQ3
> > > 20                                           IRQ4
> > > 21                                           IRQ5
> > > 22                                           IRQ6
> > > 23                                           IRQ7
> > > 48                                           IRQ0
> > >=20
> > >=20
> > > Given this I can use this dts section for PCI devices connected @ IRQ=
0
> > > and IRQ1
> > >=20
> > > interrupt-map =3D <0x5800 0 0 1 &ipic 0x30 0x8
> > >                                  0x6000 0 0 1 &ipic 0x11 0x8
> > >                                  0x6000 0 0 2 &ipic 0x11 0x8>;
> > >=20
> > > You should be able to use IRQ-Nr 18-20 for IRQ2-4.
> >=20
> > Yes, that makes sense. Thanks.
> >=20
> >  Jocke
>=20
> OK, finally figured it out, see below, but I get a SEGV if I use=20
> =EF=BB=BFIRQ_TYPE_EDGE_FALLING as below. IRQ_TYPE_EDGE_FALLING works.

[SNIP]

> What am I missing? Kernel is 2.6.25

I was missing a set_irq_type(info->irq, IRQ_TYPE_EDGE_FALLING)
Works now.

 Jocke
