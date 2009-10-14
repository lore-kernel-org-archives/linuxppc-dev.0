Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC096B7B76
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 03:56:45 +1100 (EST)
Date: Wed, 14 Oct 2009 11:56:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 1/8] 8xx: invalidate non present TLBs
Message-ID: <20091014165654.GA21215@loki.buserror.net>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 11, 2009 at 06:35:05PM +0200, Joakim Tjernlund wrote:
> 8xx sometimes need to load a invalid/non-present TLBs in
> it DTLB asm handler.
> These must be invalidated separaly as linux mm don't.
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

arch/powerpc/mm/fault.c:253: error: too few arguments to function ‘_tlbil_va’

-Scott
