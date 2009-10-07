Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36833B7B99
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 08:18:13 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Oct 2009 08:18:05 +1100
Message-Id: <1254950285.2409.10.camel@pasglop>
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

On Wed, 2009-10-07 at 22:46 +0200, Joakim Tjernlund wrote:
> 8xx sometimes need to load a invalid/non-present TLBs in
> it DTLB asm handler.
> These must be invalidated separaly as linux mm don't.

not sure about the dsisr test here, what is the point ?

Cheers,
Ben.

> ---
>  arch/powerpc/mm/fault.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 7699394..72941c7 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -39,7 +39,7 @@
>  #include <asm/uaccess.h>
>  #include <asm/tlbflush.h>
>  #include <asm/siginfo.h>
> -
> +#include <mm/mmu_decl.h>
>  
>  #ifdef CONFIG_KPROBES
>  static inline int notify_page_fault(struct pt_regs *regs)
> @@ -243,6 +243,12 @@ good_area:
>  		goto bad_area;
>  #endif /* CONFIG_6xx */
>  #if defined(CONFIG_8xx)
> +	/* 8xx sometimes need to load a invalid/non-present TLBs.
> +	 * These must be invalidated separately as linux mm don't.
> +	 */
> +	if (error_code & 0x40000000) /* no translation? */
> +		_tlbil_va(address);
> +
>          /* The MPC8xx seems to always set 0x80000000, which is
>           * "undefined".  Of those that can be set, this is the only
>           * one which seems bad.
