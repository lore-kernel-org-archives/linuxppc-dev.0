Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BmRV4LMWzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 14:53:26 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id 31-v6so2854547plc.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 21:53:26 -0700 (PDT)
Date: Fri, 22 Jun 2018 14:53:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/26] ppc: Convert mmu context allocation to new IDA API
Message-ID: <20180622145317.668cdafa@roar.ozlabs.ibm.com>
In-Reply-To: <20180622043815.GA31255@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-14-willy@infradead.org>
 <20180622121511.00ae9d00@roar.ozlabs.ibm.com>
 <20180622043815.GA31255@bombadil.infradead.org>
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

On Thu, 21 Jun 2018 21:38:15 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jun 22, 2018 at 12:15:11PM +1000, Nicholas Piggin wrote:
> > On Thu, 21 Jun 2018 14:28:22 -0700
> > Matthew Wilcox <willy@infradead.org> wrote:  
> > >  static int alloc_context_id(int min_id, int max_id)  
> ...
> > > -	spin_lock(&mmu_context_lock);
> > > -	err = ida_get_new_above(&mmu_context_ida, min_id, &index);
> > > -	spin_unlock(&mmu_context_lock);  
> ...
> > > @@ -182,13 +148,11 @@ static void destroy_contexts(mm_context_t *ctx)
> > >  {
> > >  	int index, context_id;
> > >  
> > > -	spin_lock(&mmu_context_lock);
> > >  	for (index = 0; index < ARRAY_SIZE(ctx->extended_id); index++) {
> > >  		context_id = ctx->extended_id[index];
> > >  		if (context_id)
> > > -			ida_remove(&mmu_context_ida, context_id);
> > > +			ida_free(&mmu_context_ida, context_id);
> > >  	}
> > > -	spin_unlock(&mmu_context_lock);
> > >  }
> > >  
> > >  static void pte_frag_destroy(void *pte_frag)  
> > 
> > This hunk should be okay because the mmu_context_lock does not protect
> > the extended_id array, right Aneesh?  
> 
> That's my understanding.  The code today does this:
> 
> static inline int alloc_extended_context(struct mm_struct *mm,
>                                          unsigned long ea)
> {
>         int context_id;
> 
>         int index = ea >> MAX_EA_BITS_PER_CONTEXT;
> 
>         context_id = hash__alloc_context_id();
>         if (context_id < 0)
>                 return context_id;
> 
>         VM_WARN_ON(mm->context.extended_id[index]);
>         mm->context.extended_id[index] = context_id;
> 
> so it's not currently protected by this lock.  I suppose we are currently
> protected from destroy_contexts() being called twice simultaneously, but
> you'll notice that we don't zero the array elements in destroy_contexts(),
> so if we somehow had a code path which could call it concurrently, we'd
> be seeing warnings when the second caller tried to remove the context

Yeah that'd be an existing bug.

> IDs from the IDA.  I deduced that something else must be preventing
> this situation from occurring (like, oh i don't know, this function only
> being called on process exit, so implicitly only called once per context).

I think that's exactly right.

Thanks,
Nick
