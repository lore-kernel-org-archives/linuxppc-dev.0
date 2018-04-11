Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x236.google.com (mail-pl0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LSRR3BpBzDrnk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 12:19:47 +1000 (AEST)
Received: by mail-pl0-x236.google.com with SMTP id 61-v6so244293plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 19:19:46 -0700 (PDT)
Date: Wed, 11 Apr 2018 12:19:35 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 4/5] KVM: PPC: Book3S HV: handle need_tlb_flush in C
 before low-level guest entry
Message-ID: <20180411121935.40f488ee@roar.ozlabs.ibm.com>
In-Reply-To: <1523410332.11062.116.camel@au1.ibm.com>
References: <20180410124842.30184-1-npiggin@gmail.com>
 <20180410124842.30184-5-npiggin@gmail.com>
 <1523410332.11062.116.camel@au1.ibm.com>
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

On Wed, 11 Apr 2018 11:32:12 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Tue, 2018-04-10 at 22:48 +1000, Nicholas Piggin wrote:
> >  
> > +       /*
> > +        * Do we need to flush the TLB for the LPAR? (see TLB comment above)
> > +         * On POWER9, individual threads can come in here, but the
> > +         * TLB is shared between the 4 threads in a core, hence
> > +         * invalidating on one thread invalidates for all.
> > +         * Thus we make all 4 threads use the same bit here.
> > +         */  
> 
> This might be true of P9 implementation but isn't architecturally
> correct. From an ISA perspective, the threads could have dedicatd
> tagged TLB entries. Do we need to be careful here vs. backward
> compatiblity ?

I think so. I noticed that, just trying to do like for like replacement
with this patch.

Yes it should have a feature bit test for this optimization IMO. That
can be expanded if other CPUs have the same ability... Is it even
a worthwhile optimisation to do at this point, I wonder? I didn't see
it being hit a lot in traces.

> Also this won't flush ERAT entries for another thread afaik.

Yeah, I'm still not entirely clear exactly when ERATs get invalidated.
I would like to see more commentary here to show why it's okay.

> 
> > +       tmp = pcpu;
> > +       if (cpu_has_feature(CPU_FTR_ARCH_300))
> > +               tmp &= ~0x3UL;
> > +       if (cpumask_test_cpu(tmp, &vc->kvm->arch.need_tlb_flush)) {
> > +               if (kvm_is_radix(vc->kvm))
> > +                       radix__local_flush_tlb_lpid(vc->kvm->arch.lpid);
> > +               else
> > +                       hash__local_flush_tlb_lpid(vc->kvm->arch.lpid);
> > +               /* Clear the bit after the TLB flush */
> > +               cpumask_clear_cpu(tmp, &vc->kvm->arch.need_tlb_flush);
> > +       }
> > +  
> 
