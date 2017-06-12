Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmgRq5zq3zDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:51:03 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CHn6Or102724
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 13:50:54 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b1wb0y2hu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 13:50:53 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 03:50:50 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5CHomr95832978
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:50:48 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5CHoeJ8007735
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:50:40 +1000
Date: Mon, 12 Jun 2017 23:20:44 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/14] powerpc/64s: cpuidle read mostly for common globals
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-12-npiggin@gmail.com>
 <20170612153027.GH10921@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170612153027.GH10921@in.ibm.com>
Message-Id: <20170612175044.GD4340@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Gautham R Shenoy <ego@linux.vnet.ibm.com> [2017-06-12 21:00:27]:

> On Mon, Jun 12, 2017 at 09:58:32AM +1000, Nicholas Piggin wrote:
> > Ensure these don't get put into bouncing cachelines.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
 
Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
 
> > ---
> >  drivers/cpuidle/cpuidle-powernv.c | 10 +++++-----
> >  drivers/cpuidle/cpuidle-pseries.c |  8 ++++----
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> > index 50b3c2e0306f..9d03326ac05e 100644
> > --- a/drivers/cpuidle/cpuidle-powernv.c
> > +++ b/drivers/cpuidle/cpuidle-powernv.c
> > @@ -32,18 +32,18 @@ static struct cpuidle_driver powernv_idle_driver = {
> >  	.owner            = THIS_MODULE,
> >  };
> > 
> > -static int max_idle_state;
> > -static struct cpuidle_state *cpuidle_state_table;
> > +static int max_idle_state __read_mostly;
> > +static struct cpuidle_state *cpuidle_state_table __read_mostly;
> > 
> >  struct stop_psscr_table {
> >  	u64 val;
> >  	u64 mask;
> >  };
> > 
> > -static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX];
> > +static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
> > 
> > -static u64 snooze_timeout;
> > -static bool snooze_timeout_en;
> > +static u64 snooze_timeout __read_mostly;
> > +static bool snooze_timeout_en __read_mostly;
> > 
> >  static int snooze_loop(struct cpuidle_device *dev,
> >  			struct cpuidle_driver *drv,
> > diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> > index 7b12bb2ea70f..a404f352d284 100644
> > --- a/drivers/cpuidle/cpuidle-pseries.c
> > +++ b/drivers/cpuidle/cpuidle-pseries.c
> > @@ -25,10 +25,10 @@ struct cpuidle_driver pseries_idle_driver = {
> >  	.owner            = THIS_MODULE,
> >  };
> > 
> > -static int max_idle_state;
> > -static struct cpuidle_state *cpuidle_state_table;
> > -static u64 snooze_timeout;
> > -static bool snooze_timeout_en;
> > +static int max_idle_state __read_mostly;
> > +static struct cpuidle_state *cpuidle_state_table __read_mostly;
> > +static u64 snooze_timeout __read_mostly;
> > +static bool snooze_timeout_en __read_mostly;
> > 

Simple annotation of  __read_mostly could save us a few cache line
bounces.  Good idea.

--Vaidy
