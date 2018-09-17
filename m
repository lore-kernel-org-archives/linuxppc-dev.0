Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DKPG6bY1zF1RN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 18:42:10 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id g2-v6so7086738plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 01:42:10 -0700 (PDT)
Date: Mon, 17 Sep 2018 18:42:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/12] powerpc/64s/hash: Use POWER6 SLBIA IH=1 variant
 in switch_slb
Message-ID: <20180917184204.332ba755@roar.ozlabs.ibm.com>
In-Reply-To: <874leoirks.fsf@linux.ibm.com>
References: <20180914153056.3644-1-npiggin@gmail.com>
 <20180914153056.3644-6-npiggin@gmail.com>
 <874leoirks.fsf@linux.ibm.com>
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

On Mon, 17 Sep 2018 11:38:35 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > The SLBIA IH=1 hint will remove all non-zero SLBEs, but only
> > invalidate ERAT entries associated with a class value of 1, for
> > processors that support the hint (e.g., POWER6 and newer), which
> > Linux assigns to user addresses.
> >
> > This prevents kernel ERAT entries from being invalidated when
> > context switchig (if the thread faulted in more than 8 user SLBEs).  
> 
> 
> how about renaming stuff to indicate kernel ERAT entries are kept?
> something like slb_flush_and_rebolt_user()? 

User mappings aren't bolted though. I consider rebolt to mean update
the bolted kernel mappings when something has changed (like vmalloc
segment update). That doesn't need to be done here, so I think this
is okay. I can add a comment though.

Thanks,
Nick

> 
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/mm/slb.c | 38 +++++++++++++++++++++++---------------
> >  1 file changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> > index a5e58f11d676..03fa1c663ccf 100644
> > --- a/arch/powerpc/mm/slb.c
> > +++ b/arch/powerpc/mm/slb.c
> > @@ -128,13 +128,21 @@ void slb_flush_all_realmode(void)
> >  	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
> >  }
> >  
> > -static void __slb_flush_and_rebolt(void)
> > +void slb_flush_and_rebolt(void)
> >  {
> >  	/* If you change this make sure you change SLB_NUM_BOLTED
> >  	 * and PR KVM appropriately too. */
> >  	unsigned long linear_llp, lflags;
> >  	unsigned long ksp_esid_data, ksp_vsid_data;
> >  
> > +	WARN_ON(!irqs_disabled());
> > +
> > +	/*
> > +	 * We can't take a PMU exception in the following code, so hard
> > +	 * disable interrupts.
> > +	 */
> > +	hard_irq_disable();
> > +
> >  	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
> >  	lflags = SLB_VSID_KERNEL | linear_llp;
> >  
> > @@ -160,20 +168,7 @@ static void __slb_flush_and_rebolt(void)
> >  		     :: "r"(ksp_vsid_data),
> >  		        "r"(ksp_esid_data)
> >  		     : "memory");
> > -}
> >  
> > -void slb_flush_and_rebolt(void)
> > -{
> > -
> > -	WARN_ON(!irqs_disabled());
> > -
> > -	/*
> > -	 * We can't take a PMU exception in the following code, so hard
> > -	 * disable interrupts.
> > -	 */
> > -	hard_irq_disable();
> > -
> > -	__slb_flush_and_rebolt();
> >  	get_paca()->slb_cache_ptr = 0;
> >  }
> >  
> > @@ -248,7 +243,20 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
> >  
> >  		asm volatile("isync" : : : "memory");
> >  	} else {
> > -		__slb_flush_and_rebolt();
> > +		struct slb_shadow *p = get_slb_shadow();
> > +		unsigned long ksp_esid_data =
> > +			be64_to_cpu(p->save_area[KSTACK_INDEX].esid);
> > +		unsigned long ksp_vsid_data =
> > +			be64_to_cpu(p->save_area[KSTACK_INDEX].vsid);
> > +
> > +		asm volatile("isync\n"
> > +			     PPC_SLBIA(1) "\n"
> > +			     "slbmte	%0,%1\n"
> > +			     "isync"
> > +			     :: "r"(ksp_vsid_data),
> > +				"r"(ksp_esid_data));
> > +
> > +		asm volatile("isync" : : : "memory");
> >  	}
> >  
> >  	get_paca()->slb_cache_ptr = 0;
> > -- 
> > 2.18.0  
> 
