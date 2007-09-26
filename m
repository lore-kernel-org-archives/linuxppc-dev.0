Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 701FFDDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 14:06:58 +1000 (EST)
In-Reply-To: <20070925201935.GA4792@loki.buserror.net>
References: <20070925201935.GA4792@loki.buserror.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <48D32BE9-F195-4DAC-A9CC-6FA5FC52BB69@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] Make instruction dumping work in real mode.
Date: Tue, 25 Sep 2007 23:06:49 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 25, 2007, at 3:19 PM, Scott Wood wrote:

> On non-book-E-or-4xx, exceptions execute in real mode.  If a fault  
> happens
> that leads to a register dump, the kernel currently prints XXXXXXXX  
> because
> it doesn't realize that PC is a physical address.
>
> This patch checks the state of the IMMU, and if necessary converts  
> PC into a
> virtual address.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This version uses MSR_IR rather than address heuristics, and fixes  
> breakage
> that somehow crept into the address adjustment in the previous patch.
>
>  arch/powerpc/kernel/process.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/ 
> process.c
> index 57c589c..6dbde7f 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -354,6 +354,14 @@ static void show_instructions(struct pt_regs  
> *regs)
>  		if (!(i % 8))
>  			printk("\n");
>
> +#if !defined(CONFIG_BOOKE) && !defined(CONFIG_40x)

40x has a real mode and can have the IMMU off.

> +		/* If executing with the IMMU off, adjust pc rather
> +		 * than print XXXXXXXX.
> +		 */
> +		if (!(regs->msr & MSR_IR))
> +			pc = (unsigned long)phys_to_virt(pc);
> +#endif
> +
>  		/* We use __get_user here *only* to avoid an OOPS on a
>  		 * bad address because the pc *should* only be a
>  		 * kernel address.
> -- 
> 1.5.3.1
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
