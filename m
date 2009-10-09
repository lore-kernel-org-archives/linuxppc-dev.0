Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5EE88B7B81
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Oct 2009 20:39:43 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n999b824010578
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 20:37:08 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n999b81o1642648
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 20:37:08 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n999dbRj031197
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 20:39:38 +1100
Date: Fri, 9 Oct 2009 15:09:27 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
Message-ID: <20091009093927.GA8442@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
	<1254998162.26976.270.camel@twins>
	<20091008104249.GJ20595@linux.vnet.ibm.com>
	<1254999033.26976.272.camel@twins>
	<20091008110106.GK20595@linux.vnet.ibm.com>
	<1255001110.26976.292.camel@twins>
	<20091008120120.GL20595@linux.vnet.ibm.com>
	<1255004737.26976.307.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1255004737.26976.307.camel@twins>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Arun Bharadwaj <arun@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Arjan van de Ven <arjan@infradead.org>
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-10-08 14:25:37]:

> On Thu, 2009-10-08 at 17:31 +0530, Arun R Bharadwaj wrote:
> > 
> > > Uhm, no, it would mean ACPI putting its idle routines on the same level
> > > as all others.
> > > 
> > 
> > Putting them all on the same level would mean, we need an
> > enable/disable routine to enable only the currently active routines.
> 
> What's this enable/disable stuff about?
> 
> > Also, the way governor works is that, it assumes that idle routines
> > are indexed in the increasing order of power benefit that can be got
> > out of the state. So this would get messed up.
> 
> Right, which is why I initially had a power-savings field in my
> proposal, so it could weight the power savings vs the wakeup latency.
> 
>   http://lkml.org/lkml/2009/8/27/159
> 
> There it was said that was exactly what these governors were doing,
> seems its not.
> 
> > > Sounds like something is wrong alright. If you can register an idle
> > > routine you should be able to unregister it too.
> > >
> > 
> > Yes, we can register and unregister in a clean way now.
> > Consider this. We have a set of routines A, B, C currently registered.
> > Now a module comes and registers D and E, and later on at some point
> > of time wants to unregister. So how do you keep track of what all idle
> > routines the module registered and unregister only those?
> > Best way to do that is a stack, which is how I have currently
> > implemented.
> 
> Right, so destroy that inner set thing, that way we only have one
> left ;-)
> 

I'm not convinced with your argument. Why dont we do this
incrementally. Right now, this set of sets mechanism works fine and
doesn't look like it has any obvious flaws in it. We have a clean
register/unregister mechanism which solves all the earlier problems we
started out to solve.

We can gradually build on this and try to come up with a single set
of idle states for a governor to choose from.

thanks,
arun
