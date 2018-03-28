Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8Gk3n5yzF2Jv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 00:43:26 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id l27so972607pfk.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 06:43:26 -0700 (PDT)
Date: Wed, 28 Mar 2018 23:43:10 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Fix smp_wmb barrier definition use use lwsync
 consistently
Message-ID: <20180328234119.313ef0dc@roar.ozlabs.ibm.com>
In-Reply-To: <874ll02x22.fsf@concordia.ellerman.id.au>
References: <20180322104146.5350-1-npiggin@gmail.com>
 <874ll02x22.fsf@concordia.ellerman.id.au>
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

On Wed, 28 Mar 2018 23:40:05 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > asm/barrier.h is not always included after asm/synch.h, which meant
> > it was missing __SUBARCH_HAS_LWSYNC, so in some files smp_wmb() would
> > be eieio when it should be lwsync. kernel/time/hrtimer.c is one case.  
> 
> Wow nice catch. Only broken since 2008 presumably.
> 
> Some days I think maybe we aren't very good at this writing software
> thing, good to have some certainty :)

Yeah, I only caught it by luck when looking through instruction traces.
The pipeline model just happens to make eieio look different to most
other instructions (which is likely a bug in the model) which made me
look closer at it. Could have been with us for another 10 years.

> > __SUBARCH_HAS_LWSYNC is only used in one place, so just fold it in
> > to where it's used. Previously with my small simulator config, 377
> > instances of eieio in the tree. After this patch there are 55.  
> 
> At least for Book3S this isn't actually a terrible bug AFAICS:
> 
>  - smp_wmb() is only defined to order accesses to cacheable memory.
>  - smp_wmb() only orders prior stores vs later stores.
>  - eieio orders all prior stores vs all later stores for cacheable
>    memory.
>  - lwsync orders everything except prior stores vs later loads for
>    cacheable memory.
> 
> So eieio and lwsync are both valid to use as smp_wmb(), but it's still
> terrible fishy that we were using both in different places depending on
> include ordering.

Oh yeah it's not a bug in that it would cause violation of memory
ordering, only performance (and expectations when debugging and
observing things I guess). eieio works fine for smp_wmb().

> I'm inclined to tag this for stable unless anyone can think of a reason
> not to?

I think that would be good.

Thanks,
Nick
