Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fcyL2yZNzF14n
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 19:39:06 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id w129so16997879pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 02:39:06 -0700 (PDT)
Date: Mon, 7 May 2018 19:38:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Balbir Singh
 <bsingharora@gmail.com>
Subject: Re: [PATCH 06/10] powerpc/mm/radix: implement LPID based TLB
 flushes to be used by KVM
Message-ID: <20180507193849.43d701ef@roar.ozlabs.ibm.com>
In-Reply-To: <20180507051526.GE9440@fergus.ozlabs.ibm.com>
References: <20180506073731.13097-1-npiggin@gmail.com>
 <20180506073731.13097-7-npiggin@gmail.com>
 <20180507051526.GE9440@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 7 May 2018 15:15:26 +1000
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Sun, May 06, 2018 at 05:37:27PM +1000, Nicholas Piggin wrote:
> > Implement a local TLB flush for invalidating an LPID with variants for
> > process or partition scope. And a global TLB flush for invalidating
> > a partition scoped page of an LPID.
> > 
> > These will be used by KVM in subsequent patches.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  .../include/asm/book3s/64/tlbflush-radix.h    |   7 +
> >  arch/powerpc/mm/tlb-radix.c                   | 207 ++++++++++++++++++
> >  2 files changed, 214 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> > index 19b45ba6caf9..ef5c3f2994c9 100644
> > --- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> > +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
> > @@ -51,4 +51,11 @@ extern void radix__flush_tlb_all(void);
> >  extern void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
> >  					unsigned long address);
> >  
> > +extern void radix__flush_tlb_lpid_page(unsigned int lpid,
> > +					unsigned long addr,
> > +					unsigned long page_size);
> > +extern void radix__flush_pwc_lpid(unsigned int lpid);
> > +extern void radix__local_flush_tlb_lpid(unsigned int lpid);
> > +extern void radix__local_flush_tlb_lpid_guest(unsigned int lpid);
> > +
> >  #endif
> > diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> > index a5d7309c2d05..5ac3206c51cc 100644
> > --- a/arch/powerpc/mm/tlb-radix.c
> > +++ b/arch/powerpc/mm/tlb-radix.c
> > @@ -118,6 +118,53 @@ static inline void __tlbie_pid(unsigned long pid, unsigned long ric)
> >  	trace_tlbie(0, 0, rb, rs, ric, prs, r);
> >  }
> >  
> > +static inline void __tlbiel_lpid(unsigned long lpid, int set,
> > +				unsigned long ric)
> > +{
> > +	unsigned long rb,rs,prs,r;
> > +
> > +	rb = PPC_BIT(52); /* IS = 2 */
> > +	rb |= set << PPC_BITLSHIFT(51);
> > +	rs = 0;  /* LPID comes from LPIDR */
> > +	prs = 0; /* partition scoped */
> > +	r = 1;   /* radix format */
> > +
> > +	asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
> > +		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
> > +	trace_tlbie(lpid, 1, rb, rs, ric, prs, r);  
> 
> Do we really want 128 trace entries every time
> radix__local_flush_tlb_lpid() or radix__local_flush_tlb_lpid_guest()
> is called?  That seems like overkill to me.  Could we move the
> trace_tlbie calls here and in __tlbiel_lpid_guest() into the callers
> instead?

Yeah well that's how the powerpc:tlbie tracepoints are defined. I can
see possible benefit to feeding the trace directly to a model or
simulator, but it does make other things harder.

I have a patch around that changes all those tracepoints around to
match the Linux semantics rather than the instructions... If people
would prefer that I can send it (cc'ed Balbir).

But for this patch we should just match the existing tracepoints.

Thanks,
Nick
