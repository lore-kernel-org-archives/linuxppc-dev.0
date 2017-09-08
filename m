Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x229.google.com (mail-pg0-x229.google.com
 [IPv6:2607:f8b0:400e:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpZb71v8mzDrb9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 21:19:14 +1000 (AEST)
Received: by mail-pg0-x229.google.com with SMTP id m9so4403395pgd.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 04:19:14 -0700 (PDT)
Date: Fri, 8 Sep 2017 21:18:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 alistair@popple.id.au
Subject: Re: [PATCH v3 2/2] cxl: Enable global TLBIs for cxl contexts
Message-ID: <20170908211849.59d1f74e@roar.ozlabs.ibm.com>
In-Reply-To: <20170908205402.09840f45@roar.ozlabs.ibm.com>
References: <20170903181513.29635-1-fbarrat@linux.vnet.ibm.com>
 <20170903181513.29635-2-fbarrat@linux.vnet.ibm.com>
 <20170908165624.22dca915@roar.ozlabs.ibm.com>
 <d7ee68c6-a43d-a3e7-84ab-896ca87cd7e9@linux.vnet.ibm.com>
 <20170908205402.09840f45@roar.ozlabs.ibm.com>
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

On Fri, 8 Sep 2017 20:54:02 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Fri, 8 Sep 2017 09:34:39 +0200
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> wrote:
> 
> > Le 08/09/2017 à 08:56, Nicholas Piggin a écrit :  
> > > On Sun,  3 Sep 2017 20:15:13 +0200
> > > Frederic Barrat <fbarrat@linux.vnet.ibm.com> wrote:
> > >     
> > >> The PSL and nMMU need to see all TLB invalidations for the memory
> > >> contexts used on the adapter. For the hash memory model, it is done by
> > >> making all TLBIs global as soon as the cxl driver is in use. For
> > >> radix, we need something similar, but we can refine and only convert
> > >> to global the invalidations for contexts actually used by the device.
> > >>
> > >> The new mm_context_add_copro() API increments the 'active_cpus' count
> > >> for the contexts attached to the cxl adapter. As soon as there's more
> > >> than 1 active cpu, the TLBIs for the context become global. Active cpu
> > >> count must be decremented when detaching to restore locality if
> > >> possible and to avoid overflowing the counter.
> > >>
> > >> The hash memory model support is somewhat limited, as we can't
> > >> decrement the active cpus count when mm_context_remove_copro() is
> > >> called, because we can't flush the TLB for a mm on hash. So TLBIs
> > >> remain global on hash.    
> > > 
> > > Sorry I didn't look at this earlier and just wading in here a bit, but
> > > what do you think of using mmu notifiers for invalidating nMMU and
> > > coprocessor caches, rather than put the details into the host MMU
> > > management? npu-dma.c already looks to have almost everything covered
> > > with its notifiers (in that it wouldn't have to rely on tlbie coming
> > > from host MMU code).    
> > 
> > Does npu-dma.c really do mmio nMMU invalidations?  
> 
> No, but it does do a flush_tlb_mm there to do a tlbie (probably
> buggy in some cases and does tlbiel without this patch of yours).
> But the point is when you control the flushing you don't have to
> mess with making the core flush code give you tlbies.
> 
> Just add a flush_nmmu_mm or something that does what you need.
> 
> If you can make a more targeted nMMU invalidate, then that's
> even better.
> 
> One downside at first I thought is that the core code might already
> do a broadcast tlbie, then the mmu notifier does not easily know
> about that so it will do a second one which will be suboptimal.
> 
> Possibly we could add some flag or state so the nmmu flush can
> avoid the second one.
> 
> But now that I look again, the NPU code has this comment:
> 
>         /*
>          * Unfortunately the nest mmu does not support flushing specific
>          * addresses so we have to flush the whole mm.
>          */
> 
> Which seems to indicate that you can't rely on core code to give
> you full flushes because for range flushing it is possible that the
> core code will do it with address flushes. Or am I missing something?
> 
> So it seems you really do need to always issue a full PID tlbie from
> a notifier.

Oh I see, actually it's fixed in newer firmware and there's a patch
out for it.

Okay, so the nMMU can take address tlbie, in that case it's not a
correctness issue (except for old firmware that still has the bug).
