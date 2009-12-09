Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36364B6F0D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 15:20:19 +1100 (EST)
Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1258712471-3104-5-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-5-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 15:19:59 +1100
Message-ID: <1260332399.16132.7.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-11-20 at 11:21 +0100, Joakim Tjernlund wrote:
> Various kernel asm modifies SRR0/SRR1 just before executing
> a rfi. If such code crosses a page boundary you risk a TLB miss
> which will clobber SRR0/SRR1. Avoid this by always pinning
> kernel instruction TLB space.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
>  arch/powerpc/kernel/head_8xx.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index a9f1ace..e70503d 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -705,7 +705,7 @@ start_here:
>   */
>  initial_mmu:
>  	tlbia			/* Invalidate all TLB entries */
> -#ifdef CONFIG_PIN_TLB
> +#if 1 /* CONFIG_PIN_TLB */
>  	lis	r8, MI_RSV4I@h
>  	ori	r8, r8, 0x1c00
>  #else

Not nice. Either remove the config option or make sure all those code
sequences are appropriately aligned so it doesn't happen. I recommend
the later :-)

I'll apply the other patches.

Cheers,
Ben.
