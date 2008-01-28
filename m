Return-Path: <vatsa@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35DDBDDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 23:57:53 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0SCvoap026556
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 07:57:50 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0SCvoJ1208868
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 07:57:50 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0SCvnwS003542
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 07:57:50 -0500
Date: Mon, 28 Jan 2008 18:41:35 +0530
From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
Message-ID: <20080128131135.GJ1044@linux.vnet.ibm.com>
References: <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop>
	<1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
	<1201510236.6149.24.camel@lappy> <20080128123253.GA32496@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080128123253.GA32496@elte.hu>
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	michel@tungstengraphics.com
Reply-To: vatsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 28, 2008 at 01:32:53PM +0100, Ingo Molnar wrote:
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
> +nice task.

Hmm .. I doubt whether that would help Michel's case, as he seems to be running
+niced tasks and having problems getting control over his desktop.

Something is basically wrong here ..

> Michel, do you really need the -nice portion as well? It's 
> not a problem to super-preempt positively reniced tasks, but it can be 
> quite annoying if negatively reniced tasks have super-slices.

-- 
Regards,
vatsa
