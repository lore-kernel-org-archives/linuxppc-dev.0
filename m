Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2103B7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 22:01:15 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id n98B1DbL004654
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 22:01:13 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n98AwiaP1097876
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 21:58:44 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n98B1CDs003767
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 22:01:13 +1100
Date: Thu, 8 Oct 2009 16:31:06 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
Message-ID: <20091008110106.GK20595@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
	<1254998162.26976.270.camel@twins>
	<20091008104249.GJ20595@linux.vnet.ibm.com>
	<1254999033.26976.272.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1254999033.26976.272.camel@twins>
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

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-10-08 12:50:33]:

> On Thu, 2009-10-08 at 16:12 +0530, Arun R Bharadwaj wrote:
> > 
> > > So cpuidle didn't already have a list of idle functions it takes an
> > > appropriate one from?
> > > 
> > 
> > No.. As of now, cpuidle supported only one _set_ of idle states that
> > can be registered. So in this one set, it would choose the appropriate
> > idle state. But this list mechanism(actually a stack) allows for
> > multiple sets.
> > 
> > This is needed because we have a hierarchy of idle states discovery
> > in x86. First, select_idle_routine() would select poll/mwait/default/c1e.
> > It doesn't know of existance of ACPI. Later when ACPI comes up,
> > it registers a set of routines on top of the earlier set.
> > 
> > > Then what does this governor do?
> > >
> > 
> > The governor would only select the best idle state available from the
> > set of states which is at the top of the stack. (In the above case, it
> > would only consider the states registered by ACPI).
> > 
> > If the top-of-the-stack set of idle states is unregistered, the next
> > set of states on the stack are considered.
> > 
> > > Also, does this imply the governor doesn't consider these idle routines?
> > >
> > 
> > As i said above, governor would only consider the idle routines which
> > are at the top of the stack.
> > 
> > Hope this gave a better idea..
> 
> So does it make sense to have a set of sets?
> 
> Why not integrate them all into one set to be ruled by this governor
> thing?
> 

Right now there is a clean hierarchy. So breaking that would mean
putting the registration of all idle routines under ACPI. So, if ACPI
fails to come up or if ACPI is not supported, that would lead to
problems. Because if that happens now, we can fallback to the
initially registered set.

Also, if a module wants to register a set of routines later on, that
cant be added to the initially registered set. So i think we need this
set of sets.
