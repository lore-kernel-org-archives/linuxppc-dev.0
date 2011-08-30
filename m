Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B4F7B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 16:11:22 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix xmon for systems without MSR[RI]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <1312838739-20660-1-git-send-email-jimix@pobox.com>
References: <1312838739-20660-1-git-send-email-jimix@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Aug 2011 16:11:10 +1000
Message-ID: <1314684670.2488.82.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-08-08 at 16:25 -0500, Jimi Xenidis wrote:
> From: David Gibson <dwg@au1.ibm.com>
> 
> Based on patch by David Gibson <dwg@au1.ibm.com>
> 
> xmon has a longstanding bug on systems which are SMP-capable but lack
> the MSR[RI] bit.  In these cases, xmon invoked by IPI on secondary
> CPUs will not properly keep quiet, but will print stuff, thereby
> garbling the primary xmon's output.  This patch fixes it, by ignoring
> the RI bit if the processor does not support it.
> 
> There's already a version of this for 4xx upstream, which we'll need
> to extend to other RI-lacking CPUs at some point.  For now this adds
> BookE processors to the mix.

Don't freescale one have RI ?

Cheers,
Ben.

> Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> ---
>  arch/powerpc/xmon/xmon.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 42541bb..fdb2f7e 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -340,8 +340,8 @@ int cpus_are_in_xmon(void)
>  
>  static inline int unrecoverable_excp(struct pt_regs *regs)
>  {
> -#ifdef CONFIG_4xx
> -	/* We have no MSR_RI bit on 4xx, so we simply return false */
> +#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
> +	/* We have no MSR_RI bit on 4xx or Book3e, so we simply return false */
>  	return 0;
>  #else
>  	return ((regs->msr & MSR_RI) == 0);
