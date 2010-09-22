Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8C579B70F1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 10:36:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Questions on interrupt vector assignment on MPC8641D
Date: Wed, 22 Sep 2010 02:36:43 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8C0A3@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <20100921170700.53a99e56@udp111988uds.am.freescale.net>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost><1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"Anderson, Trevor" <tanderson@curtisswright.com>
Cc: david.hagood@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.o
> zlabs.org] On Behalf Of Scott Wood
> Sent: Wednesday, September 22, 2010 6:07 AM
> To: Anderson, Trevor
> Cc: david.hagood@gmail.com; linuxppc-dev@lists.ozlabs.org
> Subject: Re: Questions on interrupt vector assignment on MPC8641D
>=20
> On Tue, 21 Sep 2010 17:37:15 -0400
> "Anderson, Trevor" <tanderson@curtisswright.com> wrote:
>=20
> > IRQ assignments for MPC8641D are "virtual",
>=20
> This is true for powerpc in general.
>=20
> > meaning "made up" and quite difficult to determine by=20
> looking through code.
> > But I believe the plan goes something like this:
> >=20
> >   IRQ
> > ---------
> >     0           No interrupt
> >   1 - 15        External interrupts (only 1..12 would be used)
> >  16 - 127       Internal interrupts - see Table 9-2 of=20
> 8641D ref man,
> >             Add 15 to the numbers shown
> > 128 - 255       Yours, or your BSP's, to do with as you like
> > 256 - 511       Message Signaled Interrupts
> >=20
> > If you look in the sample device trees for 8641 cards=20
> you'll see that=20
> > the interrupt values cited there for various devices match=20
> the 16..127=20
> > group above.
>=20
> There are two different numberspaces involved here.
>=20
> The MPIC interrupt numberspace in the device tree (which is=20
> not virtual; it is a private numberspace to MPIC) is based on=20
> the offset of the registers for that interrupt source.=20
> External interrupts start at zero (which is valid), internal=20
> at 16, and special things like MSIs at higher numbers (I=20
> don't think it's quite 256).

Agreed.=20

This should be depend on the given platform. For example 0xe0~0xe7 are
ranged for MSI on Freescale targets. And it can avoid easily to conflict
those used lower numbers when the special MSI interrupt numbers are
higher.=20

Tiejun

>=20
> The numberspace for virtual interrupts, which is what you=20
> pass to request_irq(), is dynamically allocated.  You=20
> shouldn't need to know anything about it other than that zero=20
> is invalid, and you get the virtual IRQ from=20
> irq_of_parse_and_map() or another such mapping function.
>=20
> In neither case is there a range that is set aside for you=20
> "to do with as you like".  If you have another interrupt=20
> controller and need a block of virtual interrupts, register=20
> the controller with
> irq_alloc_host() and you'll get a block assigned.
>=20
> -Scott
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
