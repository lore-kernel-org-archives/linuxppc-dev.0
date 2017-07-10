Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5WgC0k90zDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:59:18 +1000 (AEST)
Message-ID: <1499659154.2865.5.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/mm/radix: Properly clear process table entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <michael.neuling@au1.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 10 Jul 2017 13:59:14 +1000
In-Reply-To: <87bmot9cf8.fsf@concordia.ellerman.id.au>
References: <1499517932.3397.22.camel@kernel.crashing.org>
 <87bmot9cf8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-10 at 13:51 +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On radix, the process table entry we want to clear when
> > destroying a context is entry 0, not entry 1
> 
> .. but has no real world consequence? Or causes the system to instantly
> catch fire?

It has no *immediate* consequence on P9 , but it can cause other bugs
to become worse (such as the KVM issue I'm chasing).
> 
> I'll tag it:
> 
> Fixes: 7e381c0ff618 ("powerpc/mm/radix: Add mmu context handling callback for radix")
> 
> cheers
> 
> > diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> > index 79d8c8a..9404b5e 100644
> > --- a/arch/powerpc/mm/mmu_context_book3s64.c
> > +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> > @@ -226,9 +226,15 @@ void destroy_context(struct mm_struct *mm)
> >  	mm->context.cop_lockp = NULL;
> >  #endif /* CONFIG_PPC_ICSWX */
> >  
> > -	if (radix_enabled())
> > -		process_tb[mm->context.id].prtb1 = 0;
> > -	else
> > +	if (radix_enabled()) {
> > +		/*
> > +		 * Radix doesn't have a valid bit in the process table
> > +		 * entries. However we know that at least P9 implementation
> > +		 * will avoid caching an entry with an invalid RTS field,
> > +		 * and 0 is invalid. So this will do.
> > +		 */
> > +		process_tb[mm->context.id].prtb0 = 0;
> > +	} else
> >  		subpage_prot_free(mm);
> >  	destroy_pagetable_page(mm);
> >  	__destroy_context(mm->context.id);
