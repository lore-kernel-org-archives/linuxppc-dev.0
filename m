Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z39cJ1jSMzF0Bj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 01:19:12 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBMEIN4H051751
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 09:19:10 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f11rexv06-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 09:19:09 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Fri, 22 Dec 2017 09:19:07 -0500
Date: Fri, 22 Dec 2017 12:19:00 -0200
From: joserz@linux.vnet.ibm.com
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] powerpc/pseries: Use the system workqueue as
 fallback to hotplug workqueue
References: <20171221154448.22965-1-joserz@linux.vnet.ibm.com>
 <20171221154448.22965-2-joserz@linux.vnet.ibm.com>
 <20171222005410.GB26042@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171222005410.GB26042@umbus.fritz.box>
Message-Id: <20171222141900.qo2biskfbziakfda@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 22, 2017 at 11:54:10AM +1100, David Gibson wrote:
> On Thu, Dec 21, 2017 at 01:44:48PM -0200, Jose Ricardo Ziviani wrote:
> > The hotplug engine uses its own workqueue to handle IRQ requests, the
> > problem is that such workqueue is initialized not so early in the boot
> > process.
> > 
> > Thus, when the kernel is ready to handle IRQ requests, after the system
> > workqueue is initialized, we have a timeframe where any hotplug issued
> > by the client will result in a kernel panic. That timeframe goes until
> > the hotplug workqueue is initialized.
> > 
> > It would be good to have the hotplug workqueue initialized as soon as
> > the system workqueue but I don't think it is possible. So, this patch
> > uses the system workqueue as a fallback the handle such IRQs.
> > 
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> 
> I don't think this is the right approach.
> 
> It seems to me the bug is that the hotplug interrupt is registered in
> init_ras_IRQ(), before the work queue is initialized in
> pseries_dlpar_init().  We need to correct that ordering.
> 

Oh, this makes much more sense. I'm going to make some tests and send a
v2 then.

Thanks for reviewing it!

> > ---
> >  arch/powerpc/platforms/pseries/dlpar.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> > index 6e35780c5962..0474aa14b5f6 100644
> > --- a/arch/powerpc/platforms/pseries/dlpar.c
> > +++ b/arch/powerpc/platforms/pseries/dlpar.c
> > @@ -399,7 +399,15 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
> >  		work->errlog = hp_errlog_copy;
> >  		work->hp_completion = hotplug_done;
> >  		work->rc = rc;
> > -		queue_work(pseries_hp_wq, (struct work_struct *)work);
> > +
> > +		/* The hotplug workqueue may happen to be NULL at the moment
> > +		 * this code is executed, during the boot phase. So, in this
> > +		 * scenario, we can fallback to the system workqueue.
> > +		 */
> > +		if (unlikely(pseries_hp_wq == NULL))
> > +			schedule_work((struct work_struct *)work);
> > +		else
> > +			queue_work(pseries_hp_wq, (struct work_struct *)work);
> >  	} else {
> >  		*rc = -ENOMEM;
> >  		kfree(hp_errlog_copy);
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
