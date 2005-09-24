Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A02868385
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 08:11:24 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0509221450190.30738@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0509221450190.30738@nylon.am.freescale.net>
Content-Type: text/plain
Date: Sun, 25 Sep 2005 08:10:11 +1000
Message-Id: <1127599811.27674.47.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: make sure we have an L3 before touch its
	control register
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-09-22 at 14:51 -0500, Kumar Gala wrote:
> Ben,
> 
> Can you take a look at this.  I think its pretty straight forward and if 
> your ok with it please forward on to linus.

We usually haven't dong the fixup of cpu features yet at the point
setup() is run, thus your change will have no effect. You need to
actually go look at the CPU feature bits. (You can look a bit below in
that same code how it does for CPU_FTR_L3_DISABLE_NAP and
CCPU_FTR_CAN_NAP.

Also, it's 745x, those CPUs so far always existed in their 744x version
without L3 and no way to recongnize them via PVR afaik (until before
7447A). I would expect L3CR to just return 0. Is this not the case on
7447/7448 ? If yes, then there is no need to change the code...

Ben.

> - kumar
> 
> --
> 
> Some variants of 745x may not actually have the L3CR register.  Since
> we mark which variants of 745x have L3CRs in the cputable we can
> use that information to ensure that the mfspr L3CR will not cause
> an exception in the processors that don't have the register.
> 
> Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>
> 
> ---
> commit f706b6046f1fee29bdf3081dd783f7e482012165
> tree 6d42ee61458ec94ac7d4567e3f0383dd1e47a537
> parent d8ac10639b6a1ed900efbee38c18baaca31e64dc
> author Kumar K. Gala <kumar.gala@freescale.com> Thu, 22 Sep 2005 14:47:52 -0500
> committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 22 Sep 2005 14:47:52 -0500
> 
>  arch/ppc/kernel/cpu_setup_6xx.S |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/ppc/kernel/cpu_setup_6xx.S b/arch/ppc/kernel/cpu_setup_6xx.S
> --- a/arch/ppc/kernel/cpu_setup_6xx.S
> +++ b/arch/ppc/kernel/cpu_setup_6xx.S
> @@ -212,9 +212,11 @@ setup_745x_specifics:
>  	 * the firmware. If any, we disable NAP capability as
>  	 * it's known to be bogus on rev 2.1 and earlier
>  	 */
> +BEGIN_FTR_SECTION
>  	mfspr	r11,SPRN_L3CR
>  	andis.	r11,r11,L3CR_L3E@h
>  	beq	1f
> +END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
>  	lwz	r6,CPU_SPEC_FEATURES(r5)
>  	andi.	r0,r6,CPU_FTR_L3_DISABLE_NAP
>  	beq	1f
