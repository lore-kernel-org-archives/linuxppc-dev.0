Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 37C8BDDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 04:09:45 +1000 (EST)
Message-ID: <46FBF1D6.7010400@ru.mvista.com>
Date: Thu, 27 Sep 2007 22:09:26 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3] Make instruction dumping work in real mode.
References: <20070927180001.GA18185@loki.buserror.net>
In-Reply-To: <20070927180001.GA18185@loki.buserror.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Scott Wood wrote:

> On non-book-E-or-4xx, exceptions execute in real mode.  If a fault happens
> that leads to a register dump, the kernel currently prints XXXXXXXX because
> it doesn't realize that PC is a physical address.

> This patch checks the state of the IMMU, and if necessary converts PC into a
> virtual address.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Resent with 40x->44x.
> 
>  arch/powerpc/kernel/process.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 57c589c..6dbde7f 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -354,6 +354,14 @@ static void show_instructions(struct pt_regs *regs)
>  		if (!(i % 8))
>  			printk("\n");
>  
> +#if !defined(CONFIG_BOOKE) && !defined(CONFIG_44x)

     Doesn't CONFIG_44x select CONFIG_BOOKE? Maybe you meant CONFIG_40x?

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

WBR, Sergei
