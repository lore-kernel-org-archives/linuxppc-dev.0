Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep16-int.chello.at (viefep16-int.chello.at [62.179.121.36])
	by ozlabs.org (Postfix) with ESMTP id 83E6DB7BCB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 22:26:30 +1100 (EST)
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20091008110106.GK20595@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
	<1254998162.26976.270.camel@twins>
	<20091008104249.GJ20595@linux.vnet.ibm.com>
	<1254999033.26976.272.camel@twins>
	<20091008110106.GK20595@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Oct 2009 13:25:10 +0200
Message-Id: <1255001110.26976.292.camel@twins>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 16:31 +0530, Arun R Bharadwaj wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-10-08 12:50:33]:
> 
> > On Thu, 2009-10-08 at 16:12 +0530, Arun R Bharadwaj wrote:
> > > 
> > > > So cpuidle didn't already have a list of idle functions it takes an
> > > > appropriate one from?
> > > > 
> > > 
> > > No.. As of now, cpuidle supported only one _set_ of idle states that
> > > can be registered. So in this one set, it would choose the appropriate
> > > idle state. But this list mechanism(actually a stack) allows for
> > > multiple sets.
> > > 
> > > This is needed because we have a hierarchy of idle states discovery
> > > in x86. First, select_idle_routine() would select poll/mwait/default/c1e.
> > > It doesn't know of existance of ACPI. Later when ACPI comes up,
> > > it registers a set of routines on top of the earlier set.
> > > 
> > > > Then what does this governor do?
> > > >
> > > 
> > > The governor would only select the best idle state available from the
> > > set of states which is at the top of the stack. (In the above case, it
> > > would only consider the states registered by ACPI).
> > > 
> > > If the top-of-the-stack set of idle states is unregistered, the next
> > > set of states on the stack are considered.
> > > 
> > > > Also, does this imply the governor doesn't consider these idle routines?
> > > >
> > > 
> > > As i said above, governor would only consider the idle routines which
> > > are at the top of the stack.
> > > 
> > > Hope this gave a better idea..
> > 
> > So does it make sense to have a set of sets?
> > 
> > Why not integrate them all into one set to be ruled by this governor
> > thing?
> > 
> 
> Right now there is a clean hierarchy. So breaking that would mean
> putting the registration of all idle routines under ACPI. 

Uhm, no, it would mean ACPI putting its idle routines on the same level
as all others.

> So, if ACPI
> fails to come up or if ACPI is not supported, that would lead to
> problems.

I think the problem is that ACPI is thinking its special, that should be
rectified, its not.

>  Because if that happens now, we can fallback to the
> initially registered set.

I'm thinking its all daft and we should be having one set of idle
routines, if ACPI fails (a tautology if ever there was one) we simply
wouldn't have its idle routines to pick from.

> Also, if a module wants to register a set of routines later on, that
> cant be added to the initially registered set. So i think we need this
> set of sets.

Sounds like something is wrong alright. If you can register an idle
routine you should be able to unregister it too.

What about making ACPI register its idle routines too, 1 for each C
state, and have the governor make a selection out of the full set?

That also allows you to do away with this default_idle() nonsense and
simply panic the box when there are no registered idle routines when the
box wants to go idle.
