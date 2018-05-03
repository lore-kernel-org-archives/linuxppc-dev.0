Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40c8RH3gRGzF2W4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 19:07:07 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4395Jbp042382
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 May 2018 05:07:04 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hquv3rrw1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 05:07:04 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 3 May 2018 10:07:02 +0100
Date: Thu, 3 May 2018 14:36:47 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, stewart@linux.vnet.ibm.com,
 skiboot@lists.ozlabs.org
Subject: Re: [Skiboot] [PATCH 1/2] SLW: Remove stop1_lite and stop0 stop states
References: <1525079529-2284-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20180501134723.5d00ddf0@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180501134723.5d00ddf0@roar.ozlabs.ibm.com>
Message-Id: <20180503090647.xsfw3p7mq2pwd2rw@aksadiga.ibm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 01, 2018 at 01:47:23PM +1000, Nicholas Piggin wrote:
> On Mon, 30 Apr 2018 14:42:08 +0530
> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:
> 
> > Powersaving for stop0_lite and stop1_lite is observed to be quite similar
> > and both states resume without state loss. Using context_switch test [1]
> > we observe that stop0_lite has slightly lower latency, hence removing
> > stop1_lite.
> > 
> > [1] linux/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> > 
> > Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> 
> I'm okay for removing stop1_lite and stop2_lite -- SMT switching
> is very latency critical. If we decide to actually start saving
> real power then SMT should already have been switched.
> 
> So I would put stop1_lite and stop2_lite removal in the same patch.

I can do this.

> 
> Then what do we have? stop0_lite, stop0, stop1 for our fast idle
> states.

Currently we were looking at  stop0_lite , stop1 as the fast idle states
because stop0 and stop1 have similar latency and powersaving.
Having so many low latency states does not make sense.

> 
> I would be against removing stop0 if that is our fastest way to
> release SMT resources, even if there is only a small advantage. Why
> not remove stop1 instead?
>
SMT-folding comes into picture only when we have at least one thread
running in the core. stop0 and stop1 has exactly same power-saving and
both will release SMT resources if at least one thread in the core is
running.

As soon as all threads are idle core enters stop0/stop1, where stop1
does a bit more powersaving than stop0.

> We also need to better evaluate stop0_lite. How much advantage does
> that have over snooze?

I evaluated snooze and stop0_lite, there is an additional ipi latency of
a few microseconds in case of stop0_lite. So snooze cannot still be
replaced by stop0_lite.

> 
> Thanks,
> Nick
> 
> 
> > ---
> >  hw/slw.c | 30 ------------------------------
> >  1 file changed, 30 deletions(-)
> > 
> > diff --git a/hw/slw.c b/hw/slw.c
> > index 3f9abaa..edfc783 100644
> > --- a/hw/slw.c
> > +++ b/hw/slw.c
> > @@ -521,36 +521,6 @@ static struct cpu_idle_states power9_cpu_idle_states[] = {
> >  				 | OPAL_PM_PSSCR_TR(3),
> >  		.pm_ctrl_reg_mask = OPAL_PM_PSSCR_MASK },
> >  	{
> > -		.name = "stop0",
> > -		.latency_ns = 2000,
> > -		.residency_ns = 20000,
> > -		.flags = 0*OPAL_PM_DEC_STOP \
> > -		       | 0*OPAL_PM_TIMEBASE_STOP  \
> > -		       | 1*OPAL_PM_LOSE_USER_CONTEXT \
> > -		       | 0*OPAL_PM_LOSE_HYP_CONTEXT \
> > -		       | 0*OPAL_PM_LOSE_FULL_CONTEXT \
> > -		       | 1*OPAL_PM_STOP_INST_FAST,
> > -		.pm_ctrl_reg_val = OPAL_PM_PSSCR_RL(0) \
> > -				 | OPAL_PM_PSSCR_MTL(3) \
> > -				 | OPAL_PM_PSSCR_TR(3) \
> > -				 | OPAL_PM_PSSCR_ESL \
> > -				 | OPAL_PM_PSSCR_EC,
> > -		.pm_ctrl_reg_mask = OPAL_PM_PSSCR_MASK },
> > -	{
> > -		.name = "stop1_lite", /* Enter stop1 with no state loss */
> > -		.latency_ns = 4900,
> > -		.residency_ns = 49000,
> > -		.flags = 0*OPAL_PM_DEC_STOP \
> > -		       | 0*OPAL_PM_TIMEBASE_STOP  \
> > -		       | 0*OPAL_PM_LOSE_USER_CONTEXT \
> > -		       | 0*OPAL_PM_LOSE_HYP_CONTEXT \
> > -		       | 0*OPAL_PM_LOSE_FULL_CONTEXT \
> > -		       | 1*OPAL_PM_STOP_INST_FAST,
> > -		.pm_ctrl_reg_val = OPAL_PM_PSSCR_RL(1) \
> > -				 | OPAL_PM_PSSCR_MTL(3) \
> > -				 | OPAL_PM_PSSCR_TR(3),
> > -		.pm_ctrl_reg_mask = OPAL_PM_PSSCR_MASK },
> > -	{
> >  		.name = "stop1",
> >  		.latency_ns = 5000,
> >  		.residency_ns = 50000,
> 
