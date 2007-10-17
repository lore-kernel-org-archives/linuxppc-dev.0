Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79C48DDE9A
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 23:45:13 +1000 (EST)
In-Reply-To: <1192195728-24189-3-git-send-email-leoli@freescale.com>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BB3ACE22-7584-49D9-BEB0-DC355FA25BA1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 2/9] ipic: add new interrupts introduced by new chip
Date: Wed, 17 Oct 2007 08:45:45 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 12, 2007, at 8:28 AM, Li Yang wrote:

> These interrupts are introduced by the latest Freescale SoC such as
> MPC837x.  The patch also adds comment to interrupts.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/sysdev/ipic.c |  224 +++++++++++++++++++++++++++++++++ 
> +----------
>  arch/powerpc/sysdev/ipic.h |    7 +-
>  include/asm-powerpc/ipic.h |   12 ++-
>  3 files changed, 186 insertions(+), 57 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
> index 05a56e5..cd8590d 100644
> --- a/arch/powerpc/sysdev/ipic.c
> +++ b/arch/powerpc/sysdev/ipic.c
> @@ -33,7 +33,31 @@ static struct ipic * primary_ipic;
>  static DEFINE_SPINLOCK(ipic_lock);
>
>  static struct ipic_info ipic_info[] = {
> -	[9] = {
> +	[1] = {	/* PEX1 CNT */

Remove the comments, they are not correct for all IPIC users and thus  
misleading.

> +		.pend	= IPIC_SIPNR_H,
> +		.mask	= IPIC_SIMSR_H,
> +		.prio	= IPIC_SIPRR_C,
> +		.force	= IPIC_SIFCR_H,
> +		.bit	= 16,
> +		.prio_mask = 0,
> +	},

[snip]

- k
