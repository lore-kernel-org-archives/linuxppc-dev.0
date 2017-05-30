Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcVF14gy3zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 20:28:21 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UAOYN9095071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 06:28:16 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2as0qd5bcx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 06:28:15 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 30 May 2017 06:28:14 -0400
Date: Tue, 30 May 2017 15:58:05 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] powernv:idle: Decouple Timebase restore & Per-core
 SPRs restore
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
 <d83df78bd8693f9a9814eb7b1d95537f663e47ea.1494585671.git.ego@linux.vnet.ibm.com>
 <20170530161238.08a8abe3@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170530161238.08a8abe3@roar.ozlabs.ibm.com>
Message-Id: <20170530102805.GB8563@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 30, 2017 at 04:12:38PM +1000, Nicholas Piggin wrote:
> On Tue, 16 May 2017 14:19:44 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > On POWER8, in case of
> >    -  nap: both timebase and hypervisor state is retained.
> >    -  fast-sleep: timebase is lost. But the hypervisor state is retained.
> >    -  winkle: timebase and hypervisor state is lost.
> > 
> > Hence, the current code for handling exit from a idle state assumes
> > that if the timebase value is retained, then so is the hypervisor
> > state. Thus, the current code doesn't restore per-core hypervisor
> > state in such cases.
> > 
> > But that is no longer the case on POWER9 where we do have stop states
> > in which timebase value is retained, but the hypervisor state is
> > lost. So we have to ensure that the per-core hypervisor state gets
> > restored in such cases.
> > 
> > Fix this by ensuring that even in the case when timebase is retained,
> > we explicitly check if we are waking up from a deep stop that loses
> > per-core hypervisor state (indicated by cr4 being eq or gt), and if
> > this is the case, we restore the per-core hypervisor state.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/idle_book3s.S | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> > index 4898d67..afd029f 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -731,13 +731,14 @@ timebase_resync:
> >  	 * Use cr3 which indicates that we are waking up with atleast partial
> >  	 * hypervisor state loss to determine if TIMEBASE RESYNC is needed.
> >  	 */
> > -	ble	cr3,clear_lock
> > +	ble	cr3,.Ltb_resynced
> >  	/* Time base re-sync */
> >  	bl	opal_resync_timebase;
> >  	/*
> > -	 * If waking up from sleep, per core state is not lost, skip to
> > -	 * clear_lock.
> > +	 * If waking up from sleep (POWER8), per core state
> > +	 * is not lost, skip to clear_lock.
> >  	 */
> > +.Ltb_resynced:
> >  	blt	cr4,clear_lock
> >  
> >  	/*
> 
> It's more that timebase was not lost, rather than resynced.
> Can we just do a 'bgtl cr3,opal_resync_timebase'?

Yes, that's looks much better. I hadn't thought of bgtl. Will update
this.


> 
> I guess cr4 branch will never be true on POWER9... I think

Yes. Inside pnv_wakeup_tb_loss, cr4 will either have gt or
eq set. This branch applies only to POWER8 where cr4 would be eq only
on winkle, and not on fastsleep (a state that loses timebase but not
hypervisor state).


> pnv_wakeup_tb_loss is going to end up clearer being split
> into two between isa 207 and 300. But that can wait until
> after POWER9 is working properly.

Sure. 

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 

--
Thanks and Regards
gautham.
