Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3fKW3jvQzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:52:15 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DBhi5o094057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 07:52:05 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29t7knudwe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 07:52:05 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 05:52:04 -0600
Date: Thu, 13 Apr 2017 17:21:58 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] powernv:idle: Decouple TB restore & Per-core SPRs
 restore
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
 <27511c1235ee58c66eabdea65b39f5dd35d91426.1491996797.git.ego@linux.vnet.ibm.com>
 <1492066545.4624.52.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1492066545.4624.52.camel@neuling.org>
Message-Id: <20170413115158.GB2425@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2017 at 04:55:45PM +1000, Michael Neuling wrote:
> On Wed, 2017-04-12 at 17:16 +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > The idle-exit code assumes that if Timebase is not lost, then neither
> > are the per-core hypervisor resources lost. 
> 
> Double negative!  How about:
> 
> The idle-exit code assumes that if the timebase is restored, then the
> per-core hypervisor resources are also restored.

Ok. To be more explicit, this was the intention:

On POWER8, in case of 
   -  nap: both timebase and hypervisor state is retained.
   -  fast-sleep: timebase is lost. But the hypervisor state is retained.
   -  winkle: timebase and hypervisor state is lost.

Hence, the current code assumes that if the timebase value is
retained, then so is the hypervisor state. Thus, the current code
doesn't restore per-core hypervisor state if this is the case.

But that is no longer true on POWER9 where we do have stop states
where timebase value is retained, but the hypervisor state is lost. So
we have to ensure that the per-core hypervisor state gets restored in
such cases.

> 
> > This was true on POWER8
> > where fast-sleep lost only TB but not per-core resources, and winkle
> > lost both.
> > 
> > This assumption is not true for POWER9 however, since there can be
> > states which do not lose timebase but can lose per-core SPRs.
> > 
> > Hence check if we need to restore the per-core hypervisor state even
> > if timebase is not lost.
> 
> I think I understand what you're doing, just seems awkwardly worded.

Will fix the wording.

> 
> Is this actually what the patch is doing?  It seem to be just changing one
> branch.
>

Yes, we change the branch to .Ltb_resynced which will ensure in the
case when timebase is retained, we explicitly check if we are waking
up from a deep stop that loses per-core hypervisor state (indicated by
cr4 being eq or gt).

> Mikey
> 
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/idle_book3s.S | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/idle_book3s.S
> > b/arch/powerpc/kernel/idle_book3s.S
> > index 9b747e9..6a9bd28 100644
> > --- a/arch/powerpc/kernel/idle_book3s.S
> > +++ b/arch/powerpc/kernel/idle_book3s.S
> > @@ -723,13 +723,14 @@ timebase_resync:
> >  	 * Use cr3 which indicates that we are waking up with atleast partial
> >  	 * hypervisor state loss to determine if TIMEBASE RESYNC is needed.
> >  	 */
> > -	ble	cr3,clear_lock
> > +	ble	cr3,.Ltb_resynced
> >  	/* Time base re-sync */
> >  	bl	opal_resync_timebase;
> >  	/*
> > -	 * If waking up from sleep, per core state is not lost, skip to
> > -	 * clear_lock.
> > +	 * If waking up from sleep (POWER8), per core state
> > +	 * is not lost, skip to clear_lock.
> >  	 */
> > +.Ltb_resynced:
> >  	blt	cr4,clear_lock
> >  
> >  	/*
