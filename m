Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pg0-x22c.google.com (mail-pg0-x22c.google.com
 [IPv6:2607:f8b0:400e:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpSmL5Kz8zDrZx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 16:56:50 +1000 (AEST)
Received: by mail-pg0-x22c.google.com with SMTP id m9so3540487pgd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 23:56:50 -0700 (PDT)
Date: Fri, 8 Sep 2017 16:56:24 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 alistair@popple.id.au
Subject: Re: [PATCH v3 2/2] cxl: Enable global TLBIs for cxl contexts
Message-ID: <20170908165624.22dca915@roar.ozlabs.ibm.com>
In-Reply-To: <20170903181513.29635-2-fbarrat@linux.vnet.ibm.com>
References: <20170903181513.29635-1-fbarrat@linux.vnet.ibm.com>
 <20170903181513.29635-2-fbarrat@linux.vnet.ibm.com>
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

On Sun,  3 Sep 2017 20:15:13 +0200
Frederic Barrat <fbarrat@linux.vnet.ibm.com> wrote:

> The PSL and nMMU need to see all TLB invalidations for the memory
> contexts used on the adapter. For the hash memory model, it is done by
> making all TLBIs global as soon as the cxl driver is in use. For
> radix, we need something similar, but we can refine and only convert
> to global the invalidations for contexts actually used by the device.
> 
> The new mm_context_add_copro() API increments the 'active_cpus' count
> for the contexts attached to the cxl adapter. As soon as there's more
> than 1 active cpu, the TLBIs for the context become global. Active cpu
> count must be decremented when detaching to restore locality if
> possible and to avoid overflowing the counter.
> 
> The hash memory model support is somewhat limited, as we can't
> decrement the active cpus count when mm_context_remove_copro() is
> called, because we can't flush the TLB for a mm on hash. So TLBIs
> remain global on hash.

Sorry I didn't look at this earlier and just wading in here a bit, but
what do you think of using mmu notifiers for invalidating nMMU and
coprocessor caches, rather than put the details into the host MMU
management? npu-dma.c already looks to have almost everything covered
with its notifiers (in that it wouldn't have to rely on tlbie coming
from host MMU code).

This change is not too bad today, but if we get to more complicated
MMU/nMMU TLB management like directed invalidation of particular units,
then putting more knowledge into the host code will end up being
complex I think.

I also want to also do optimizations on the core code that assumes we
only have to take care of other CPUs, e.g.,

https://patchwork.ozlabs.org/patch/811068/

Or, another example, directed IPI invalidations from the mm_cpumask
bitmap.

I realize you want to get something merged! For the merge window and
backports this seems fine. I think it would be nice soon afterwards to
get nMMU knowledge out of the core code... Though I also realize with
our tlbie instruction that does everything then it may be tricky to
make a really optimal notifier.

Thanks,
Nick

> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Fixes: f24be42aab37 ("cxl: Add psl9 specific code")
> ---
> Changelog:
> v3: don't decrement active cpus count with hash, as we don't know how to flush
> v2: Replace flush_tlb_mm() by the new flush_all_mm() to flush the TLBs
> and PWCs (thanks to Ben)
