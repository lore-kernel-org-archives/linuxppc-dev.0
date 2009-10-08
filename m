Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26F29B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Oct 2009 00:10:26 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id n98D82un001213
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 00:08:02 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n98DAOke283014
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 00:10:24 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n98DANNh015425
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2009 00:10:24 +1100
Date: Thu, 8 Oct 2009 18:40:15 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
Message-ID: <20091008131015.GD3735@dirshya.in.ibm.com>
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
	linux-acpi@vger.kernel.org, arun@linux.vnet.ibm.com,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Arjan van de Ven <arjan@infradead.org>
Reply-To: svaidy@linux.vnet.ibm.com
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

Don't we need an explicit 'don't use this routine' apart from having
the weights based on power consumption and latency.  In multiple
registration the assumption is that the top most 'set' has all
necessary routines and we do not need any other idle routines for
optimum operation.

Otherwise the governor has to select from larger 'set' which could
have redundant or conflicting idle routines.

For example we now have c1e_idle to start with and then a set of ACPI
C1, C2, C3 routines.  The expectation now is that once we have the
ACPI's routines, we do not need the previous used c1e_idle because
this new set is self contained and picking one from this set based on
latency is good for power savings.
 
> > Also, the way governor works is that, it assumes that idle routines
> > are indexed in the increasing order of power benefit that can be got
> > out of the state. So this would get messed up.
> 
> Right, which is why I initially had a power-savings field in my
> proposal, so it could weight the power savings vs the wakeup latency.
> 
>   http://lkml.org/lkml/2009/8/27/159

This proposal that you had suggested is being used for the 'set' of
idle routines.  The patch changes the idle routines as 'sets' and does
not mix use of routines between two registrations.
 
> There it was said that was exactly what these governors were doing,
> seems its not.

Governors select from a set of idle routines based on latency.  But
there is a probability that any of the routine in the set can be
selected.  

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

If un-registration is not needed, then this framework can easily
override the current set with the new one and not worry about the set
of sets.

Ideally, during system boot, we could wait until we know enough
information about idle states and then have a single registration.
The boot process can be in poll-idle until this decision happens.
Like in x86, we can register either c1e_idle or ACPI's routines at
a stage where we know for sure if ACPI is enabled or not.

--Vaidy
 
