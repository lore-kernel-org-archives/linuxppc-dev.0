Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXjNV5GhJzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 02:36:26 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 25so1965843pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 07:36:26 -0800 (PST)
Date: Wed, 1 Mar 2017 01:36:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego.lkml@gmail.com>
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, Vaidyanathan
 Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] powerpc/64: stop using bit in HSPRG0 to test winkle
Message-ID: <20170301013607.66162e79@roar.ozlabs.ibm.com>
In-Reply-To: <CAHZ_5WyA7hUu53vzCZY2WSUzm+q_-2=6cwkdutmGN5SsdkNgrw@mail.gmail.com>
References: <20170216183901.28611-1-npiggin@gmail.com>
 <20170216183901.28611-3-npiggin@gmail.com>
 <CAHZ_5WyA7hUu53vzCZY2WSUzm+q_-2=6cwkdutmGN5SsdkNgrw@mail.gmail.com>
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

On Tue, 28 Feb 2017 20:38:19 +0530
Gautham R Shenoy <ego.lkml@gmail.com> wrote:

> Hi Nick,
> 
> On Fri, Feb 17, 2017 at 12:08 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > The POWER8 idle code has a neat trick of programming the power on engine
> > to restore a low bit into HSPRG0, so idle wakeup code can test and see
> > if it has been programmed this way and therefore lost all state. Restore
> > time can be reduced if winkle has not been reached.
> >  
> 
> > However this messes with our r13 PACA pointer, and requires HSPRG0 to
> > be written to. It also optimizes the slowest and most uncommon case at
> > the expense of another SPR write in the common nap state wakeup.  
> 
> Actually, this optimization was needed to reduce the guest entry time
> for a KVM guest vcore.
> 
> While running KVM on POWER8, the host is in SMT=1 mode with the
> secondary threads
> being hotplugged out and supposed to have entered the winkle state.
> Since the primary thread is still running, the core would still be in Nap.
> 
> However, each time a guest vcore is scheduled on the core, the
> secondary threads are sent an IPI to wake them up from the idle state.
> 
> On waking up, they use the last bit of HSPRG0 and conclude that they
> don't need to restore resources before executing the guest entry code.
> 
> Thus, the HSPRG0 trick help the secondary threads avoid spending
> extra cycles restoring the SLBs and per-thread SPRs.

Ah, thanks. Until now I didn't really understand why that case was
optimimized. My mistake and apologies for assuming it was not a good
reason :)


> > Remove this complexity and assume winkle sleeps always require a state
> > restore. This speedup could be made entirely contained within the winkle
> > idle code by counting per-core winkles and setting a thread bitmap when
> > all have gone to winkle.  
> 
> This is a good idea! We are anyway taking the lock in pnv_wakeup_tb_loss()
> to check if we are the first thread in the core waking up from a deep-state.
> 
> We can check another bitmap if we are the first thread waking up from winkle
> and set cr4 to the result of that comparison while holding the lock.
> 
> That shouldn't cost us much, at least for the fake-wakeup-from-winkle
> for KVM case alluded to above.
> 
> Otherwise, the patch looks good to me.

Okay, I had a half-done patch for this. I'll finish it and send it
out for review.

Thanks,
Nick
