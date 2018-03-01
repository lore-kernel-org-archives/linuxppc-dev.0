Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsVnM33sLzF1W4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 22:38:47 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id g12so2200768pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Mar 2018 03:38:46 -0800 (PST)
Date: Thu, 1 Mar 2018 21:38:32 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 2/3] powerpc/64s/idle: avoid sync for KVM state when
 waking from idle
Message-ID: <20180301213832.3a53e5a3@roar.ozlabs.ibm.com>
In-Reply-To: <20180228181623.GA20168@drishya.in.ibm.com>
References: <20171117140807.22105-1-npiggin@gmail.com>
 <20171117140807.22105-3-npiggin@gmail.com>
 <20180228181623.GA20168@drishya.in.ibm.com>
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

On Wed, 28 Feb 2018 23:46:23 +0530
Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:

> * Nicholas Piggin <npiggin@gmail.com> [2017-11-18 00:08:06]:
> 
> > When waking from a CPU idle instruction (e.g., nap or stop), the sync
> > for ordering the KVM secondary thread state can be avoided if there
> > wakeup is coming from a kernel context rather than KVM context.
> > 
> > This improves performance for ping-pong benchmark with the stop0 idle
> > state by 0.46% for 2 threads in the same core, and 1.02% for different
> > cores.  
> 
> Cool, the improvement comes from avoiding the "sync" alone?

Yes, they can be pretty costly.

>  
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/kernel/idle_book3s.S | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> > index 2f8364e7b489..07a306173c5a 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -532,6 +532,9 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
> >  	mr	r3,r12
> > 
> >  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> > +	lbz	r0,HSTATE_HWTHREAD_STATE(r13)
> > +	cmpwi	r0,KVM_HWTHREAD_IN_KERNEL
> > +	beq	1f
> >  	li	r0,KVM_HWTHREAD_IN_KERNEL
> >  	stb	r0,HSTATE_HWTHREAD_STATE(r13)
> >  	/* Order setting hwthread_state vs. testing hwthread_req */  
> 
> With this change, we will not check for HSTATE_HWTHREAD_REQ != 0 
> condition but unconditionally goto host kernel if
> HSTATE_HWTHREAD_STATE == KVM_HWTHREAD_IN_KERNEL at wakeup.

That's right.

> Host is in ST mode and sibling thread got a wakeup event (door bell) to execute
> a new vcpu by calling kvm_start_guest, what will HSTATE_HWTHREAD_STATE be?

It should be KVM_HWTHREAD_IN_IDLE.

> Just to clarify, what will the flags looks like for
> 
> (a) Host cpu sibling thread is offline and need to execute guest
> (b) Host cpu sibling thread is idle and need to execute guest

In the idle case we are running with independent threads mode and
siblings not unplugged, so we should not get KVM wake-up requests
come through this path. I'm not fluent in KVM though, so I could
be wrong.

Thanks,
Nick
