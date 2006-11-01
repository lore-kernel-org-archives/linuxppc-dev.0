Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx
	Interrupt	controller	support	for	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <454867AB.2010904@bplan-gmbh.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
	<4546F7DE.6070104@bplan-gmbh.de>
	<1162280335.25682.302.camel@localhost.localdomain>
	<4547086D.2050808@bplan-gmbh.de>
	<1162284176.25682.320.camel@localhost.localdomain>
	<454712A4.3000501@bplan-gmbh.de>  <4547AC30.3090208@bplan-gmbh.de>
	<1162331943.25682.358.camel@localhost.localdomain>
	<454867AB.2010904@bplan-gmbh.de>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 07:56:55 +1100
Message-Id: <1162414615.25682.427.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> In my opinion, as it reflects a bit better hwow the hw itself is 
> architectured (critical, main, peripheral...) it's better to do it like 
> this. I do not wish to change this. Moreover, it's yet working pretty well.

I disagree completely here. The HW works the way the registers are laid
out. The -whole-point- of doing that Level1 vs. Level2 thing was to
abstract is such that Level1 represents the register set used. Now, what
you essentially did is split is so that one Level1 is a special case of
one register set, the second Level1 can be either the rest of that
register or another, and 3 and 4 are properly separate register sets.
That makes no sense at all.

> It normaly does not compile if I remove it as state earlier. I'll remove 
> them and fixed the compile issue.
> 
> > if defined(CONFIG_PPC_MPC52xx) && !defined(CONFIG_PPC_MERGE)

It compiles if you also fixup asm-ppc/io.h by doing the above.

> Will be removed and replace by another define to reflect the highest 
> virq (0xd0).
> 
> #define MPC52xx_IRQ_MACVIRQ 		(0xd0)
> 
> sounds ok ?

No, it's not a V irq, it's a HW irq number. (and MAC vs. MAX ?)

Ben
