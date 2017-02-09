Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJl9n4fqBzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 15:15:41 +1100 (AEDT)
Message-ID: <1486613729.3401.15.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/mm/radix: Update pte update sequence for
 pte clear case
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 09 Feb 2017 15:15:29 +1100
In-Reply-To: <1486612188.3401.14.camel@kernel.crashing.org>
References: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486612188.3401.14.camel@kernel.crashing.org>
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

On Thu, 2017-02-09 at 14:49 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2017-02-09 at 08:28 +0530, Aneesh Kumar K.V wrote:
> > In the kernel we do follow the below sequence in different code
> > paths.
> > pte = ptep_get_clear(ptep)
> > ....
> > set_pte_at(ptep, pte)
> > 
> > We do that for mremap, autonuma protection update and softdirty
> > clearing. This
> > implies our optimization to skip a tlb flush when clearing a pte
> > update is
> > not valid, because for DD1 system that followup set_pte_at will be
> > done witout
> > doing the required tlbflush. Fix that by always doing the dd1 style
> > pte update
> > irrespective of new_pte value. In a later patch we will optimize
> > the application
> > exit case.
> 
> What about my change to set_pte_at() ? We seem to be overwriting
> valid PTEs,
> shouldn't we deal with that ?

So the HW guys confirmed that the TLB will never cache a valid entry
that has all permissions clear. That leaves the THP write problem
though.

Cheers,
Ben.

> Cheers,
> Ben.
> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > 
> > ---
> >  arch/powerpc/include/asm/book3s/64/radix.h | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/radix.h
> > b/arch/powerpc/include/asm/book3s/64/radix.h
> > index b4d1302387a3..70a3cdcdbe47 100644
> > --- a/arch/powerpc/include/asm/book3s/64/radix.h
> > +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> > @@ -144,16 +144,10 @@ static inline unsigned long
> > radix__pte_update(struct mm_struct *mm,
> > >  		 * new value of pte
> > >  		 */
> > >  		new_pte = (old_pte | set) & ~clr;
> > > -		/*
> > > -		 * If we are trying to clear the pte, we can
> > > skip
> > > -		 * the below sequence and batch the tlb flush.
> > > The
> > > -		 * tlb flush batching is done by mmu gather code
> > > -		 */
> > > -		if (new_pte) {
> > > -			asm volatile("ptesync" : : : "memory");
> > > -			radix__flush_tlb_pte_p9_dd1(old_pte, mm,
> > > addr);
> > > +		asm volatile("ptesync" : : : "memory");
> > > +		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
> > > +		if (new_pte)
> > >  			__radix_pte_update(ptep, 0, new_pte);
> > > -		}
> > >  	} else
> > >  		old_pte = __radix_pte_update(ptep, clr, set);
> > >  	asm volatile("ptesync" : : : "memory");
