Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 257F3DDF16
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 17:42:41 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add support for SMP initialization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0812081855330.4837@t2.domain.actdsltmp>
References: <1228204546-1506-1-git-send-email-galak@kernel.crashing.org>
	<Pine.LNX.4.64.0812081855330.4837@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Tue, 09 Dec 2008 17:40:30 +1100
Message-Id: <1228804830.7101.80.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Fleming Andy <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-08 at 19:14 -0800, Trent Piepho wrote:
> On Tue, 2 Dec 2008, Kumar Gala wrote:
> > Added 85xx specifc smp_ops structure.  We use ePAPR style boot release
> > and the MPIC for IPIs at this point.
> >
> > Additionally added routines for secondary cpu entry and initializtion.
> >
> > @@ -740,6 +750,9 @@ finish_tlb_load:
> > #else
> > 	rlwimi	r12, r11, 26, 27, 31	/* extract WIMGE from pte */
> > #endif
> > +#ifdef CONFIG_SMP
> > +	ori	r12, r12, MAS2_M
> > +#endif
> > 	mtspr	SPRN_MAS2, r12
> 
> Wouldn't it be more efficient to set _PAGE_COHERENT when the pte is created
> vs setting MAS2_M each time it's loaded?
> 
> Is it correct to set MAS2_M for all pages, even uncached ones?

That sounds strange indeed. However, I would do it the other way around,
which is to set M in the PTEs and filter it out on !SMP. The stuff in
pgtable is a bit of a mess at the moment, which makes things harder
though. I have some patches reworking bits for 64-bit but I haven't had
a chance to sort that out yet for 32-bit.

> The code for ioremap() has this:
> 
>          /* Non-cacheable page cannot be coherent */
>          if (flags & _PAGE_NO_CACHE)
>                  flags &= ~_PAGE_COHERENT;
> 
> It seems odd that ioremap would explictly unset _PAGE_COHERENT when the
> code that sets the tlb will just force it back on.

Depends on your HW implementation but yes, it's fishy to have M and I
set at the same time.

Cheers,
Ben.
