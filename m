Return-Path: <kenneth@southpole.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7972FB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 19:09:58 +1000 (EST)
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 12CD5DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 19:09:58 +1000 (EST)
Subject: Re: Question about e300 core decrementer interrupt
From: Kenneth Johansson <kenneth@southpole.se>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090909184343.GC8215@b07421-ec1.am.freescale.net>
References: <FF7429C6AD6EFB489C0A5A2021CDFEFA7C30E6@zmy16exm21.fsl.freescale.net>
	<1252494967.10293.6.camel@localhost>
	<20090909184343.GC8215@b07421-ec1.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Sep 2009 11:09:54 +0200
Message-Id: <1252573794.10293.13.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Li Tao-B22598 <B22598@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-09 at 13:43 -0500, Scott Wood wrote:
> On Wed, Sep 09, 2009 at 01:16:07PM +0200, Kenneth Johansson wrote:
> > On Tue, 2009-09-08 at 13:48 +0800, Li Tao-B22598 wrote:
> > > Dear all,
> > > 
> > > I have a problem in MPC5121 sleep mode. As you know MPC5121 use e300c4
> > > core. When I make the e300c4 core into sleep mode, it will return to
> > > full power mode when the“decrementer interrupt” occurred.
> > > 
> > > But in the e300 core reference manual said that the “decrementer
> > > interrupt”have no effect when e300 core in sleep mode, because the
> > > time
> > > base and decrementer are disabled while the core is in sleep mode.
> > > Can anybody explain about this procedure ?
> 
> I'm not specifically familiar with MPC5121, but I'll answer from the
> perspective of MPC83xx which has a similar core:
> 
> The decrementer stops ticking when the core goes to sleep.  However, if a
> decrementer was already pending (but masked with MSR[EE]) before you
> enter sleep mode, it will cause a wakeup.
> 
> To avoid this, the decrementer is set to a very large value prior to and
> after disabling interrupts.  See generic_suspend_disable_irqs() in
> arch/powerpc/kernel/time.c.  Is this not happening for you?  Which kernel
> version are you using, and what mechanism are you using to go to sleep? 
> 
> > I'm a bit irritated that it's not as the "solution" can mean hardware
> > changes an thus it's potentially expensive.
> 
> What sort of hardware changes?

 I don't want to spread missinformation but this procedure has helped on
the ads5121 rev3 and two custom boards. 

the gpio 28,29,30 needs to be low and gpio31 needs to be hi. regardless
of what is used as wakeup source when the device enters deep sleep
otherwise you end up in some sort of meta state where you might not wake
up on anything and you have this 42 second auto wakeup from the
decrementer. 

Other weired states has also been observed. the PMC module is a bit
tempremental in this chip.
