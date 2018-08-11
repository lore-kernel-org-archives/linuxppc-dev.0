Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41nWRS2P9lzDr5r
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 15:54:59 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id x5-v6so5301797pgp.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 22:54:59 -0700 (PDT)
Date: Sat, 11 Aug 2018 15:54:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, huntbag@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 3/3] cpuidle/powernv: Conditionally save-restore
 sprs using opal
Message-ID: <20180811155449.020de1e8@roar.ozlabs.ibm.com>
In-Reply-To: <20180808154116.GA31919@in.ibm.com>
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
 <20180802045132.12432-4-akshay.adiga@linux.vnet.ibm.com>
 <20180803000547.08a37175@roar.ozlabs.ibm.com>
 <20180808154116.GA31919@in.ibm.com>
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

On Wed, 8 Aug 2018 21:11:16 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hello Nicholas,
> 
> On Fri, Aug 03, 2018 at 12:05:47AM +1000, Nicholas Piggin wrote:
> > On Thu,  2 Aug 2018 10:21:32 +0530
> > Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:
> >   
> > > From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> > > 
> > > If a state has "opal-supported" compat flag in device-tree, an opal call
> > > needs to be made during the entry and exit of the stop state. This patch
> > > passes a hint to the power9_idle_stop and power9_offline_stop.
> > > 
> > > This patch moves the saving and restoring of sprs for P9 cpuidle
> > > from kernel to opal. This patch still uses existing code to detect
> > > first thread in core.
> > > In an attempt to make the powernv idle code backward compatible,
> > > and to some extent forward compatible, add support for pre-stop entry
> > > and post-stop exit actions in OPAL. If a kernel knows about this
> > > opal call, then just a firmware supporting newer hardware is required,
> > > instead of waiting for kernel updates.  
> > 
> > Still think we should make these do-everything calls. Including
> > executing nap/stop instructions, restoring timebase, possibly even
> > saving and restoring SLB (although a return code could be used to
> > tell the kernel to do that maybe if performance advantage is  
> enough).
> 
> So, if we execute the stop instruction in opal, the wakeup from stop
> still happens at the hypervisor 0x100. On wake up, we need to check
> SRR1 to see if we have lost state, in which case, the stop exit also
> needs to be handled inside opal.

Yes. That's okay, SRR1 seems to be pretty well architected.

> On return from this opal call, we
> need to unwind the extra stack frame that would have been created when
> kernel entered opal to execute the stop from which there was no
> return. In the case where a lossy stop state was requested, but wakeup
> happened from a lossless stop state, this adds additional overhead.

True, but you're going from 1 OPAL call to 2. So you still have that
overhead. Although possibly we could implement some special light
weight stackless calls (I'm thinking about doing that for MCE handling
too). Or you could perhaps just discard the stack without needing to
unwind anything in the case of a lossless wakeup.

> 
> Furthermore, the measurements show that the additional time taken to
> perform the restore of the resources in OPAL vs doing so in Kernel on
> wakeup from stop takes additional 5-10us. For the current stop states
> that lose hypervisor state, since the latency is relatively high (100s
> of us), this is a relatively small penalty (~1%) .

Yeah OPAL is pretty heavy to enter. We can improve that a bit. But
yes for P10 timeframe it may be still heavy weight.

> 
> However, in future if we do have states that lose only a part of
> hypervisor state to provide a wakeup latency in the order of few tens
> of microseconds the additional latency caused by OPAL call would
> become noticable, no ?

I think so long as we can do shallow states in Linux it really won't
be that big a deal (even if we don't do any of the above speedup
tricks).

I think it's really desirable to have a complete firmware
implementation. Having this compromise seems like the worst of both
in a way (does not allow firmware to control everything, and does
not have great performance).

> 
> 	
> > 
> > I haven't had a lot of time to go through it, I'm working on moving
> > ~all of idle_book3s.S to C code, I'd like to do that before this
> > OPAL idle driver if possible.
> > 
> > A minor thing I just noticed, you don't have to allocate the opal
> > spr save space in Linux, just do it all in OPAL.  
> 
> The idea was to not leave any state in OPAL, as OPAL is supposed to be
> state-less. However, I agree, that if OPAL is not going to interpret
> the contents of the save/area, it should be harmless to move that bit
> into OPAL.
> 
> That said, if we are going to add the logic of determining the first
> thread in the core waking up, etc, then we have no choice but to
> maintain that state in OPAL.

I don't think it's such a problem for particular very carefully
defined cases like this.

Thanks,
Nick
