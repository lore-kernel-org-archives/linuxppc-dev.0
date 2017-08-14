Return-Path: <srs0=xyon=7q=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWVW82P1HzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 08:23:32 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xWVW81c5Hz8t0Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 08:23:32 +1000 (AEST)
Message-ID: <1502749386.4493.33.camel@kernel.crashing.org>
Subject: Re: [PATCH v6 14/17] powerpc: Add support for setting SPRN_TIDR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>
Cc: mikey@neuling.org, stewart@linux.vnet.ibm.com, apopple@au1.ibm.com,
 hbabu@us.ibm.com, oohall@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 15 Aug 2017 08:23:06 +1000
In-Reply-To: <87pobyqtzu.fsf@concordia.ellerman.id.au>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
 <87pobyqtzu.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-14 at 21:16 +1000, Michael Ellerman wrote:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> 
> > We need the SPRN_TIDR to bet set for use with fast thread-wakeup
> > (core-to-core wakeup).  Each thread in a process needs to have a
> > unique id within the process but as explained below, for now, we
> > assign globally unique thread ids to all threads in the system.
> 
> Each thread in a process already has a unique id, ie. its pid (in the
> init PID namespace), accessible in the kernel as task_pid_nr(task).
> 
> So if that's all we need, we don't need a new allocator, and we don't
> need to store it in the thread_struct.

We need an allocator, I think, due to size restriction on the HW TID.

> Also 99.99% of processes aren't going to care about the TIDR, so we
> should avoid setting it in the common case. ie. it should start out zero
> and only be initialised in the FTW code, or a helper that it calls.


> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 9f3e2c9..6123859 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1213,6 +1213,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
> >  		hard_irq_disable();
> >  	}
> >  
> > +#ifdef CONFIG_PPC_VAS
> > +	mtspr(SPRN_TIDR, new->thread.tidr);
> > +#endif
> 
> That should be in restore_sprs().
> 
> It should also check that the TIDR is initialised, and only switch it
> when necessary.
> 
> > +	/*
> > +	 * We can't take a PMU exception inside _switch() since there is a
> > +	 * window where the kernel stack SLB and the kernel stack are out
> > +	 * of sync. Hard disable here.
> > +	 */
> > +	hard_irq_disable();
> 
> We removed that in June in:
> 
>  e4c0fc5f72bc ("powerpc/64s: Leave interrupts hard enabled in context switch for radix")
> 
> You've obviously picked it up somewhere along the line during a rebase,
> please be more careful!
> 
> cheers
