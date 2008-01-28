Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26206DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 23:33:16 +1100 (EST)
Date: Mon, 28 Jan 2008 13:32:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
Message-ID: <20080128123253.GA32496@elte.hu>
References: <1201092131.6341.51.camel@lappy>
	<1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop>
	<1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
	<1201510236.6149.24.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201510236.6149.24.camel@lappy>
Cc: linuxppc-dev@ozlabs.org,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>,
	vatsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> >       * With CONFIG_FAIR_USER_SCHED disabled, there are severe
> >         interactivity hickups with a niced CPU hog and top running. This
> >         started with commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8. 
> 
> The revert at the bottom causes the wakeup granularity to shrink for + 
> nice and to grow for - nice. That is, it becomes easier to preempt a + 
> nice task, and harder to preempt a - nice task.

i think it would be OK to do half of this: make it easier to preempt a 
+nice task. Michel, do you really need the -nice portion as well? It's 
not a problem to super-preempt positively reniced tasks, but it can be 
quite annoying if negatively reniced tasks have super-slices.

	Ingo
