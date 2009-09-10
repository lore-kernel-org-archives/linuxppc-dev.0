Return-Path: <B22598@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8677EB7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 21:56:14 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF54CDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 21:56:13 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8ABu08h002336
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 04:56:10 -0700 (MST)
Received: from zmy16exm21.fsl.freescale.net (zmy16exm21.ap.freescale.net
	[10.211.3.25])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8ABvRZ5013317
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 06:57:28 -0500 (CDT)
Subject: Re: Question about e300 core decrementer interrupt
From: Li Tao <b22598@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090909184343.GC8215@b07421-ec1.am.freescale.net>
References: <FF7429C6AD6EFB489C0A5A2021CDFEFA7C30E6@zmy16exm21.fsl.freescale.net>
	<1252494967.10293.6.camel@localhost>
	<20090909184343.GC8215@b07421-ec1.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Sep 2009 19:58:42 +0800
Message-Id: <1252583922.26108.23.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kenneth Johansson <kenneth@southpole.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott Wood,
Thanks for your response

=E5=9C=A8 2009-09-09=E4=B8=89=E7=9A=84 13:43 -0500=EF=BC=8CScott Wood=E5=86=
=99=E9=81=93=EF=BC=9A
> On Wed, Sep 09, 2009 at 01:16:07PM +0200, Kenneth Johansson wrote:
> > On Tue, 2009-09-08 at 13:48 +0800, Li Tao-B22598 wrote:
> > > Dear all,
> > >=20
> > > I have a problem in MPC5121 sleep mode. As you know MPC5121 use e300c=
4
> > > core. When I make the e300c4 core into sleep mode, it will return to
> > > full power mode when the=E2=80=9Cdecrementer interrupt=E2=80=9D occur=
red.
> > >=20
> > > But in the e300 core reference manual said that the =E2=80=9Cdecremen=
ter
> > > interrupt=E2=80=9Dhave no effect when e300 core in sleep mode, becaus=
e the
> > > time
> > > base and decrementer are disabled while the core is in sleep mode.
> > > Can anybody explain about this procedure ?
>=20
> I'm not specifically familiar with MPC5121, but I'll answer from the
> perspective of MPC83xx which has a similar core:
>=20
> The decrementer stops ticking when the core goes to sleep.  However, if a
> decrementer was already pending (but masked with MSR[EE]) before you
> enter sleep mode, it will cause a wakeup.
>=20
> To avoid this, the decrementer is set to a very large value prior to and
> after disabling interrupts.  See generic_suspend_disable_irqs() in
> arch/powerpc/kernel/time.c.  Is this not happening for you?  Which kernel
> version are you using, and what mechanism are you using to go to sleep?
I use 2.6.24 kernel. The PM driver code have set decrementer to
0x7fffffff before go to sleep mode.
The driver set HID0[10]=3D1, then set MSR POW bit. PMCCR =3D 00111.
> =20
>=20
> > I'm a bit irritated that it's not as the "solution" can mean hardware
> > changes an thus it's potentially expensive.
>=20
> What sort of hardware changes?
>=20
> -Scott
