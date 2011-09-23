Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 807A6B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Sep 2011 02:34:41 +1000 (EST)
Message-ID: <4E7CB4B1.3080703@freescale.com>
Date: Fri, 23 Sep 2011 11:32:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [PATCH v2] powerpc: Fix xmon for systems without MSR[RI]
References: <1312838739-20660-1-git-send-email-jimix@pobox.com>
	<1316790104-10067-1-git-send-email-jimix@pobox.com>
In-Reply-To: <1316790104-10067-1-git-send-email-jimix@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/23/2011 10:01 AM, Jimi Xenidis wrote:
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
> Book3e processors to the mix.
> 
> Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> 
> ---
> Restricted it to Book3e
> ---
>  arch/powerpc/xmon/xmon.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 42541bb..13f82f8 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -340,8 +340,8 @@ int cpus_are_in_xmon(void)
>  
>  static inline int unrecoverable_excp(struct pt_regs *regs)
>  {
> -#ifdef CONFIG_4xx
> -	/* We have no MSR_RI bit on 4xx, so we simply return false */
> +#if defined(CONFIG_4xx) || defined(CONFIG_BOOK3E)
> +	/* We have no MSR_RI bit on 4xx or Book3e, so we simply return false */
>  	return 0;
>  #else
>  	return ((regs->msr & MSR_RI) == 0);

How is CONFIG_BOOK3E better than CONFIG_BOOKE?  Both e500mc (has RI) and
e500v2 (doesn't have RI) will select both symbols.  Sounds like it
should be a cputable flag.

-Scott
