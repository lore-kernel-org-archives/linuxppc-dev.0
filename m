Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22e.google.com (mail-pg0-x22e.google.com
 [IPv6:2607:f8b0:400e:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpZ2Z3KmYzDrb2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 20:54:30 +1000 (AEST)
Received: by mail-pg0-x22e.google.com with SMTP id d8so4301995pgt.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 03:54:30 -0700 (PDT)
Date: Fri, 8 Sep 2017 20:54:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 alistair@popple.id.au
Subject: Re: [PATCH v3 2/2] cxl: Enable global TLBIs for cxl contexts
Message-ID: <20170908205402.09840f45@roar.ozlabs.ibm.com>
In-Reply-To: <d7ee68c6-a43d-a3e7-84ab-896ca87cd7e9@linux.vnet.ibm.com>
References: <20170903181513.29635-1-fbarrat@linux.vnet.ibm.com>
 <20170903181513.29635-2-fbarrat@linux.vnet.ibm.com>
 <20170908165624.22dca915@roar.ozlabs.ibm.com>
 <d7ee68c6-a43d-a3e7-84ab-896ca87cd7e9@linux.vnet.ibm.com>
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

On Fri, 8 Sep 2017 09:34:39 +0200
Frederic Barrat <fbarrat@linux.vnet.ibm.com> wrote:

> Le 08/09/2017 à 08:56, Nicholas Piggin a écrit :
> > On Sun,  3 Sep 2017 20:15:13 +0200
> > Frederic Barrat <fbarrat@linux.vnet.ibm.com> wrote:
> >   
> >> The PSL and nMMU need to see all TLB invalidations for the memory
> >> contexts used on the adapter. For the hash memory model, it is done by
> >> making all TLBIs global as soon as the cxl driver is in use. For
> >> radix, we need something similar, but we can refine and only convert
> >> to global the invalidations for contexts actually used by the device.
> >>
> >> The new mm_context_add_copro() API increments the 'active_cpus' count
> >> for the contexts attached to the cxl adapter. As soon as there's more
> >> than 1 active cpu, the TLBIs for the context become global. Active cpu
> >> count must be decremented when detaching to restore locality if
> >> possible and to avoid overflowing the counter.
> >>
> >> The hash memory model support is somewhat limited, as we can't
> >> decrement the active cpus count when mm_context_remove_copro() is
> >> called, because we can't flush the TLB for a mm on hash. So TLBIs
> >> remain global on hash.  
> > 
> > Sorry I didn't look at this earlier and just wading in here a bit, but
> > what do you think of using mmu notifiers for invalidating nMMU and
> > coprocessor caches, rather than put the details into the host MMU
> > management? npu-dma.c already looks to have almost everything covered
> > with its notifiers (in that it wouldn't have to rely on tlbie coming
> > from host MMU code).  
> 
> Does npu-dma.c really do mmio nMMU invalidations?

No, but it does do a flush_tlb_mm there to do a tlbie (probably
buggy in some cases and does tlbiel without this patch of yours).
But the point is when you control the flushing you don't have to
mess with making the core flush code give you tlbies.

Just add a flush_nmmu_mm or something that does what you need.

If you can make a more targeted nMMU invalidate, then that's
even better.

One downside at first I thought is that the core code might already
do a broadcast tlbie, then the mmu notifier does not easily know
about that so it will do a second one which will be suboptimal.

Possibly we could add some flag or state so the nmmu flush can
avoid the second one.

But now that I look again, the NPU code has this comment:

        /*
         * Unfortunately the nest mmu does not support flushing specific
         * addresses so we have to flush the whole mm.
         */

Which seems to indicate that you can't rely on core code to give
you full flushes because for range flushing it is possible that the
core code will do it with address flushes. Or am I missing something?

So it seems you really do need to always issue a full PID tlbie from
a notifier.

> My understanding was 
> that those atsd_launch operations are really targeted at the device 
> behind the NPU, i.e. the nvidia card.
> At some point, it was not possible to do mmio invalidations on the nMMU. 
> At least on dd1. I'm checking with the nMMU team the status on dd2.
> 
> Alistair: is your code really doing a nMMU invalidation? Considering 
> you're trying to also reuse the mm_context_add_copro() from this patch, 
> I think I know the answer.
> 
> There are also other components relying on broadcasted invalidations 
> from hardware: the PSL (for capi FPGA) and the XSL on the Mellanox CX5 
> card, when in capi mode. They rely on hardware TLBIs, snooped and 
> forwarded to them by the CAPP.
> For the PSL, we do have a mmio interface to do targeted invalidations, 
> but it was removed from the capi architecture (and left as a debug 
> feature for our PSL implementation), because the nMMU would be out of 
> sync with the PSL (due to the lack of interface to sync the nMMU, as 
> mentioned above).
> For the XSL on the Mellanox CX5, it's even more complicated. AFAIK, they 
> do have a way to trigger invalidations through software, though the 
> interface is private and Mellanox would have to be involved. They've 
> also stated the performance is much worse through software invalidation.

Okay, point is I think the nMMU and agent drivers will be in a better
position to handle all that. I don't see that flushing from your notifier
means that you can't issue a tlbie to do it.

> 
> Another consideration is performance. Which is best? Short of having 
> real numbers, it's probably hard to know for sure.

Let's come to that if we agree on a way to go. I *think* we can make it
at least no worse than we have today, using tlbie and possibly some small
changes to generic code callers.

Thanks,
Nick
