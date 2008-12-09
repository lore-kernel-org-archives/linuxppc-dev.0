Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D0FEDDEFF
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 14:14:39 +1100 (EST)
Date: Mon, 8 Dec 2008 19:14:26 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Add support for SMP initialization
In-Reply-To: <1228204546-1506-1-git-send-email-galak@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0812081855330.4837@t2.domain.actdsltmp>
References: <1228204546-1506-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Fleming Andy <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2 Dec 2008, Kumar Gala wrote:
> Added 85xx specifc smp_ops structure.  We use ePAPR style boot release
> and the MPIC for IPIs at this point.
>
> Additionally added routines for secondary cpu entry and initializtion.
>
> @@ -740,6 +750,9 @@ finish_tlb_load:
> #else
> 	rlwimi	r12, r11, 26, 27, 31	/* extract WIMGE from pte */
> #endif
> +#ifdef CONFIG_SMP
> +	ori	r12, r12, MAS2_M
> +#endif
> 	mtspr	SPRN_MAS2, r12

Wouldn't it be more efficient to set _PAGE_COHERENT when the pte is created
vs setting MAS2_M each time it's loaded?

Is it correct to set MAS2_M for all pages, even uncached ones?

The code for ioremap() has this:

         /* Non-cacheable page cannot be coherent */
         if (flags & _PAGE_NO_CACHE)
                 flags &= ~_PAGE_COHERENT;

It seems odd that ioremap would explictly unset _PAGE_COHERENT when the
code that sets the tlb will just force it back on.
