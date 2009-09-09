Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 086E6B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 04:43:48 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EE19DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 04:43:46 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n89IhhJN024057
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Sep 2009 11:43:43 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n89IjAkd001026
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Sep 2009 13:45:10 -0500 (CDT)
Date: Wed, 9 Sep 2009 13:43:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kenneth Johansson <kenneth@southpole.se>
Subject: Re: Question about e300 core decrementer interrupt
Message-ID: <20090909184343.GC8215@b07421-ec1.am.freescale.net>
References: <FF7429C6AD6EFB489C0A5A2021CDFEFA7C30E6@zmy16exm21.fsl.freescale.net>
	<1252494967.10293.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1252494967.10293.6.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Li Tao-B22598 <B22598@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 09, 2009 at 01:16:07PM +0200, Kenneth Johansson wrote:
> On Tue, 2009-09-08 at 13:48 +0800, Li Tao-B22598 wrote:
> > Dear all,
> > 
> > I have a problem in MPC5121 sleep mode. As you know MPC5121 use e300c4
> > core. When I make the e300c4 core into sleep mode, it will return to
> > full power mode when the“decrementer interrupt” occurred.
> > 
> > But in the e300 core reference manual said that the “decrementer
> > interrupt”have no effect when e300 core in sleep mode, because the
> > time
> > base and decrementer are disabled while the core is in sleep mode.
> > Can anybody explain about this procedure ?

I'm not specifically familiar with MPC5121, but I'll answer from the
perspective of MPC83xx which has a similar core:

The decrementer stops ticking when the core goes to sleep.  However, if a
decrementer was already pending (but masked with MSR[EE]) before you
enter sleep mode, it will cause a wakeup.

To avoid this, the decrementer is set to a very large value prior to and
after disabling interrupts.  See generic_suspend_disable_irqs() in
arch/powerpc/kernel/time.c.  Is this not happening for you?  Which kernel
version are you using, and what mechanism are you using to go to sleep? 

> I'm a bit irritated that it's not as the "solution" can mean hardware
> changes an thus it's potentially expensive.

What sort of hardware changes?

-Scott
