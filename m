Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Bk3G2t1CzDrNC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 23:05:29 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id l27so3063319pfk.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 05:05:29 -0700 (PDT)
Date: Thu, 29 Mar 2018 22:04:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/14] numa aware allocation for pacas, stacks, pagetables
Message-ID: <20180329220456.026147ff@roar.ozlabs.ibm.com>
In-Reply-To: <87in9f1k2j.fsf@concordia.ellerman.id.au>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <87muzkdusj.fsf@concordia.ellerman.id.au>
 <20180308120412.1cbe9ace@roar.ozlabs.ibm.com>
 <87in9f1k2j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Mar 2018 17:18:12 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> > On Wed, 07 Mar 2018 21:50:04 +1100
> > Michael Ellerman <mpe@ellerman.id.au> wrote:  
> >> Nicholas Piggin <npiggin@gmail.com> writes:  
> >> > This series allows numa aware allocations for various early data
> >> > structures for radix. Hash still has a bolted SLB limitation that
> >> > prevents at least pacas and stacks from node-affine allocations.
> >> >
> >> > Fixed up a number of bugs, got pSeries working, added a couple more
> >> > cases where page tables can be allocated node-local.    
> >> 
> >> Few problems in here:
> >> 
> >> FAILURE kernel-build-linux » powerpc,gcc_ubuntu_be,pmac32
> >>   arch/powerpc/kernel/prom.c:748:2: error: implicit declaration of function 'allocate_paca_ptrs' [-Werror=implicit-function-declaration]
> >> 
> >> FAILURE kernel-build-linux » powerpc,gcc_ubuntu_le,powernv
> >>   arch/powerpc/include/asm/paca.h:49:33: error: 'struct paca_struct' has no member named 'lppaca_ptr'
> >>   arch/powerpc/include/asm/paca.h:49:33: error: 'struct paca_struct' has no member named 'lppaca_ptr'
> >> 
> >> Did I miss a follow-up or something?  
> >
> > Here's a patch that applies to "powerpc/64: defer paca allocation
> > until memory topology is discovered". The first hunk fixes the ppc32
> > issue, and the second hunk avoids freeing the cpu_to_phys_id array
> > if the platform didn't allocate it. But I've just realized that
> > should go into the previous patch (which is missing the
> > memblock_free).
> > --  
> ...
> > diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> > index 56f7a2b793e0..2ba05acc2973 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -854,8 +854,10 @@ static void smp_setup_pacas(void)
> >  		set_hard_smp_processor_id(cpu, cpu_to_phys_id[cpu]);
> >  	}
> >  
> > -	memblock_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
> > -	cpu_to_phys_id = NULL;
> > +	if (cpu_to_phys_id) {
> > +		memblock_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
> > +		cpu_to_phys_id = NULL;
> > +	}
> >  }
> >  #endif  
>  
> Where did you want that?

Patch 8 should have

	if (cpu_to_phys_id) {
		memblock_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
		cpu_to_phys_id = NULL;
	}

Right after its ight after the set_hard_smp_processor_id() loop. Patch 9
moves it all to smp_setup_pacas plus the allocate_paca() call in the loop.

I think that makes sense.

Thanks for fixing it all up, had a few rough edges.
