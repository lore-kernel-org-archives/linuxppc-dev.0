Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6375B7B74
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 08:26:36 +1100 (EST)
Subject: Re: [PATCH 7/8] 8xx: Restore _PAGE_WRITETHRU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1255278912-8042-8-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-6-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-7-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-8-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Oct 2009 08:26:27 +1100
Message-Id: <1255296387.2192.43.camel@pasglop>
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

On Sun, 2009-10-11 at 18:35 +0200, Joakim Tjernlund wrote:
> 8xx has not had WRITETHRU due to lack of bits in the pte.
> After the recent rewrite of the 8xx TLB code, there are
> two bits left. Use one of them to WRITETHRU.
> 
> Perhaps use the last SW bit to PAGE_SPECIAL or PAGE_FILE?

_PAGE_FILE can already overwrite other bits as it's only set
when !present, and should pretty much always be 0x2

I think I've replaced _PAGE_EXEC with _PAGE_SPECIAL already
upstream since _PAGE_EXEC is unused on 8xx.

Cheers,
Ben.

> ---
>  arch/powerpc/include/asm/pte-8xx.h |    5 +++--
>  arch/powerpc/kernel/head_8xx.S     |    8 ++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
> index f23cd15..9349d83 100644
> --- a/arch/powerpc/include/asm/pte-8xx.h
> +++ b/arch/powerpc/include/asm/pte-8xx.h
> @@ -34,12 +34,13 @@
>  #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
>  #define _PAGE_DIRTY	0x0100	/* C: page changed */
>  
> -/* These 3 software bits must be masked out when the entry is loaded
> - * into the TLB, 2 SW bits left.
> +/* These 4 software bits must be masked out when the entry is loaded
> + * into the TLB, 1 SW bit left(0x0080).
>   */
>  #define _PAGE_EXEC	0x0008	/* software: i-cache coherency required */
>  #define _PAGE_GUARDED	0x0010	/* software: guarded access */
>  #define _PAGE_ACCESSED	0x0020	/* software: page referenced */
> +#define _PAGE_WRITETHRU	0x0040	/* software: caching is write through */
>  
>  /* Setting any bits in the nibble with the follow two controls will
>   * require a TLB exception handler change.  It is assumed unused bits
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 371b606..db5207e 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -422,6 +422,10 @@ DataStoreTLBMiss:
>  	 * above.
>  	 */
>  	rlwimi	r11, r10, 0, 27, 27
> +	/* Insert the WriteThru flag into the TWC from the Linux PTE.
> +	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
> +	 */
> +	rlwimi	r11, r10, 32-5, 30, 30
>  	DO_8xx_CPU6(0x3b80, r3)
>  	mtspr	SPRN_MD_TWC, r11
>  
> @@ -559,6 +563,10 @@ DARFix:	/* Return from dcbx instruction bug workaround, r10 holds value of DAR *
>  	 * It is bit 27 of both the Linux PTE and the TWC
>  	 */
>  	rlwimi	r11, r10, 0, 27, 27
> +	/* Insert the WriteThru flag into the TWC from the Linux PTE.
> +	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
> +	 */
> +	rlwimi	r11, r10, 32-5, 30, 30
>  	DO_8xx_CPU6(0x3b80, r3)
>  	mtspr	SPRN_MD_TWC, r11
>  	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
