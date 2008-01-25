Return-Path: <a.p.zijlstra@chello.nl>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16636DDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 19:50:14 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: benh@kernel.crashing.org
In-Reply-To: <1201245901.6815.133.camel@pasglop>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy>  <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop> <1201245901.6815.133.camel@pasglop>
Content-Type: text/plain
Date: Fri, 25 Jan 2008 09:50:00 +0100
Message-Id: <1201251000.6341.108.camel@lappy>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>,
	vatsa <vatsa@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-25 at 18:25 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2008-01-25 at 18:03 +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2008-01-25 at 17:54 +1100, Benjamin Herrenschmidt wrote:
> > > 
> > > Here, I do the test of running 4 times the repro-case provided by Michel
> > > with nice 19 and a dd eating CPU with nice 0.
> > > 
> > > Without this option, I get the dd at 100% and the nice 19 shells down
> > > below it with whatever is left of the CPUs.
> > > 
> > > With this option, dd gets about 50% of one CPU and the niced processes
> > > still get most of the time.
> > 
> > FYI. This is a 4 way G5 (ppc64)
> 
> I also tested responsiveness of X running with or without that option
> and with niced CPU eaters in the background (still 4 of them, one per
> CPU), and I can confirm Michel observations, it gets very sluggish
> (maybe not -as- bad as his but still pretty annoying) with the fair
> group scheduler enabled.
> 
> Here, X is running with nice=0

Curious, sounds like an issue with the group load balancer, vatsa, any
ideas?
