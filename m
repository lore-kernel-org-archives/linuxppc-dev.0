Return-Path: <srs0=kucv=7q=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWRPP1dvVzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 06:03:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xWRPP0ns8z8t64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 06:03:21 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xWRPN3lpgz9sPm
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2017 06:03:20 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7EJxJH6055572
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 16:03:17 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cbc86k0ft-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 16:03:17 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 14 Aug 2017 14:03:16 -0600
Date: Mon, 14 Aug 2017 13:03:09 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/17] powerpc: Add support for setting SPRN_TIDR
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
 <87pobyqtzu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87pobyqtzu.fsf@concordia.ellerman.id.au>
Message-Id: <20170814200309.GD24096@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
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
> 
> Also 99.99% of processes aren't going to care about the TIDR, so we
> should avoid setting it in the common case. ie. it should start out zero
> and only be initialised in the FTW code, or a helper that it calls.

Good point. So, should we just set when the RX_WIN_OPEN ioctl is called
rather than at the time of clone()?

_switch_to() (restore_sprs() could check for non-zero and save/restore
the value.

As Ben pointed out, we are going to be have limit the number of TIDs (to
be within the size limits), so we won't be able to use task_pid_nr()? But
if we assign the TIDs in the RX_WIN_OPEN ioctl, then only the FTW processes
will need the TIDR value.

Can we then assign new, globally-unique TID values for now and have the ioctl
fail with -EAGAIN if all TIDs are in use? We can extend to per-process TID
values, later?

> 
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

ok.
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

Yeah, That was stupid. I picked it up on a recent rebase. Will be careful.

> 
> cheers
