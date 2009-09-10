Return-Path: <B22598@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 788EEB7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 21:50:43 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC93FDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 21:50:42 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8ABocrk001270
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 04:50:38 -0700 (MST)
Received: from zmy16exm21.fsl.freescale.net (zmy16exm21.ap.freescale.net
	[10.211.3.25])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n8ABqMuV012010
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 06:52:23 -0500 (CDT)
Subject: Re: Question about e300 core decrementer interrupt
From: Li Tao <b22598@freescale.com>
To: Kenneth Johansson <kenneth@southpole.se>
In-Reply-To: <1252573794.10293.13.camel@localhost>
References: <FF7429C6AD6EFB489C0A5A2021CDFEFA7C30E6@zmy16exm21.fsl.freescale.net>
	<1252494967.10293.6.camel@localhost>
	<20090909184343.GC8215@b07421-ec1.am.freescale.net>
	<1252573794.10293.13.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Sep 2009 19:53:17 +0800
Message-Id: <1252583597.26108.17.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Johansson,

Thanks for your response

=E5=9C=A8 2009-09-10=E5=9B=9B=E7=9A=84 11:09 +0200=EF=BC=8CKenneth Johansso=
n=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, 2009-09-09 at 13:43 -0500, Scott Wood wrote:
> > On Wed, Sep 09, 2009 at 01:16:07PM +0200, Kenneth Johansson wrote:
> > > On Tue, 2009-09-08 at 13:48 +0800, Li Tao-B22598 wrote:
> > > > Dear all,
> > > >=20
> > > > I have a problem in MPC5121 sleep mode. As you know MPC5121 use e30=
0c4
> > > > core. When I make the e300c4 core into sleep mode, it will return t=
o
> > > > full power mode when the=E2=80=9Cdecrementer interrupt=E2=80=9D occ=
urred.
> > > >=20
> > > > But in the e300 core reference manual said that the =E2=80=9Cdecrem=
enter
> > > > interrupt=E2=80=9Dhave no effect when e300 core in sleep mode, beca=
use the
> > > > time
> > > > base and decrementer are disabled while the core is in sleep mode.
> > > > Can anybody explain about this procedure ?
> >=20
> > I'm not specifically familiar with MPC5121, but I'll answer from the
> > perspective of MPC83xx which has a similar core:
> >=20
> > The decrementer stops ticking when the core goes to sleep.  However, if=
 a
> > decrementer was already pending (but masked with MSR[EE]) before you
> > enter sleep mode, it will cause a wakeup.
> >=20
> > To avoid this, the decrementer is set to a very large value prior to an=
d
> > after disabling interrupts.  See generic_suspend_disable_irqs() in
> > arch/powerpc/kernel/time.c.  Is this not happening for you?  Which kern=
el
> > version are you using, and what mechanism are you using to go to sleep?=
=20
> >=20
> > > I'm a bit irritated that it's not as the "solution" can mean hardware
> > > changes an thus it's potentially expensive.
> >=20
> > What sort of hardware changes?
>=20
>  I don't want to spread missinformation but this procedure has helped on
> the ads5121 rev3 and two custom boards.=20
>=20
> the gpio 28,29,30 needs to be low and gpio31 needs to be hi. regardless
> of what is used as wakeup source when the device enters deep sleep
> otherwise you end up in some sort of meta state where you might not wake
> up on anything and you have this 42 second auto wakeup from the
> decrementer.=20
I use ads5121 rev4.1 board, the gpio 28,29,30 is low and gpio31 is high.
I find that the RTC is fail too, when I use hwclock -f /dev/rtc0 cmd, it
was always "Wed Dec 31 23:59:59 1969  0.000000 seconds". I measured the
the RTC oscillator is 32.768 kHz, and the VBAT_RTC is 4.2v. I have no
idea about why RTC is fail.=20
>=20
> Other weired states has also been observed. the PMC module is a bit
> tempremental in this chip.
>=20
>=20
>=20
