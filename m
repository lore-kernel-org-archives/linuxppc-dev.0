Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F7CEB70B3
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 08:25:18 +1100 (EST)
Subject: Re: [PATCH 2/8] 8xx: Update TLB asm so it behaves as linux mm expects.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Oct 2009 08:25:00 +1100
Message-Id: <1255296300.2192.41.camel@pasglop>
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
> @@ -522,26 +539,12 @@ DataTLBError:

I still think you should remove everything from DataTLBError, it's
just plain useless :-)

Ben.

>         mfspr   r11, SPRN_MD_TWC                /* ....and get the pte
> address */
>         lwz     r10, 0(r11)             /* Get the pte */
>  
> -       andi.   r11, r10, _PAGE_RW      /* Is it writeable? */
> -       beq     2f                      /* Bail out if not */
> -
> -       /* Update 'changed', among others.
> -       */
> -#ifdef CONFIG_SWAP
> -       ori     r10, r10, _PAGE_DIRTY|_PAGE_HWWRITE
> -       /* do not set the _PAGE_ACCESSED bit of a non-present page */
> -       andi.   r11, r10, _PAGE_PRESENT
> -       beq     4f
> -       ori     r10, r10, _PAGE_ACCESSED
> -4:
> -#else
> -       ori     r10, r10, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
> -#endif
> -       mfspr   r11, SPRN_MD_TWC                /* Get pte address
> again */
> +       ori     r10, r10, _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_HWWRITE
>         stw     r10, 0(r11)             /* and update pte in table */
> +       xori    r10, r10, _PAGE_RW      /* RW bit is inverted */
>  
>         /* The Linux PTE won't go exactly into the MMU TLB.
> -        * Software indicator bits 21, 22 and 28 must be clear.
> +        * Software indicator bits 22 and 28 must be clear.
>          * Software indicator bits 24, 25, 26, and 27 must be
>          * set.  All other Linux PTE bits control the behavior
>          * of the MMU.
> -- 
> 1.6.4.4
> 
> 
