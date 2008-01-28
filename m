Return-Path: <a.p.zijlstra@chello.nl>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9406ADDE45
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 23:53:30 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20080128123253.GA32496@elte.hu>
References: <1201092131.6341.51.camel@lappy>
	<1201244082.6815.128.camel@pasglop> <1201244618.6815.130.camel@pasglop>
	<1201245901.6815.133.camel@pasglop> <1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
	<1201510236.6149.24.camel@lappy>  <20080128123253.GA32496@elte.hu>
Content-Type: text/plain
Date: Mon, 28 Jan 2008 13:53:16 +0100
Message-Id: <1201524796.28547.5.camel@lappy>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>,
	vatsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-28 at 13:32 +0100, Ingo Molnar wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > >       * With CONFIG_FAIR_USER_SCHED disabled, there are severe
> > >         interactivity hickups with a niced CPU hog and top running. This
> > >         started with commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8. 
> > 
> > The revert at the bottom causes the wakeup granularity to shrink for + 
> > nice and to grow for - nice. That is, it becomes easier to preempt a + 
> > nice task, and harder to preempt a - nice task.
> 
> i think it would be OK to do half of this: make it easier to preempt a 
> +nice task. Michel, do you really need the -nice portion as well? It's 
> not a problem to super-preempt positively reniced tasks, but it can be 
> quite annoying if negatively reniced tasks have super-slices.

This should do that (unless I need a stronger cup of tea).

---
Index: linux-2.6/kernel/sched_fair.c
===================================================================
--- linux-2.6.orig/kernel/sched_fair.c
+++ linux-2.6/kernel/sched_fair.c
@@ -1106,7 +1106,11 @@ static void check_preempt_wakeup(struct 
 	}
 
 	gran = sysctl_sched_wakeup_granularity;
-	if (unlikely(se->load.weight != NICE_0_LOAD))
+	/*
+	 * More easily preempt - nice tasks, while not making
+	 * it harder for + nice tasks.
+	 */
+	if (unlikely(se->load.weight > NICE_0_LOAD))
 		gran = calc_delta_fair(gran, &se->load);
 
 	if (pse->vruntime + gran < se->vruntime)
