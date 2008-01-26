Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 699E2DDE06
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 16:16:53 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: vatsa@linux.vnet.ibm.com
In-Reply-To: <20080126050637.GA14177@linux.vnet.ibm.com>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy> <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop> <1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050637.GA14177@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Sat, 26 Jan 2008 16:15:52 +1100
Message-Id: <1201324552.6815.165.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Michel.=?iso-8859-1?Q?D=E4nzer_=3Cmichel=40tungstengraphics=2Ecom=3E?=@snowy.in.ibm.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Not that it seems that Michel reported far worse behaviour than what I
> > saw, including pretty hickup'ish X behaviour even without the fair group
> > scheduler compared to 2.6.23. It might be because he's running X niced
> > to -1 (I leave X at 0 and let the scheduler deal with it in general)
> > though.
> 
> Hmm ..with X niced to -1, it should get more cpu power leading to a
> better desktop experience.

It depends as X can end up starving it's own clients, especially with a
compositing manager or other fancy window manager...

> Michel,
> 	You had reported that commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8 
> was the cause for this bad behavior. Do you see behavior change (from good->bad)
> immediately after applying that patch during your bisect process?

Also Michel, double check your .config in both cases.

> I would prefer to have CONFIG_FAIR_GROUP_SCHED +
> CONFIG_FAIR_CGROUP_SCHED on by default. Can you pls let me know how you
> think is the desktop experience with that combination?

I'm going to give that a try but unfortunately, it will have to wait
until I'm back from LCA in a bit more than a week.

Ben.
