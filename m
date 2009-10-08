Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 101EAB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 21:42:58 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n98AeQp0025049
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 21:40:26 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n98AgveH422226
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 21:42:57 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n98AguTG016610
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 21:42:56 +1100
Date: Thu, 8 Oct 2009 16:12:49 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
Message-ID: <20091008104249.GJ20595@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
	<1254998162.26976.270.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1254998162.26976.270.camel@twins>
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

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-10-08 12:36:02]:

> On Thu, 2009-10-08 at 15:20 +0530, Arun R Bharadwaj wrote:
> > * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-10-08 15:18:28]:
> > 
> > Implement a list based registering mechanism for architectures which
> > have multiple sets of idle routines which are to be registered.
> > 
> > Currently, in x86 it is done by merely setting pm_idle = idle_routine
> > and managing this pm_idle pointer is messy.
> > 
> > To give an example of how this mechanism works:
> > In x86, initially, idle routine is selected from the set of poll/mwait/
> > c1e/default idle loops. So the selected idle loop is registered in cpuidle
> > as one idle state cpuidle devices. Once ACPI comes up, it registers
> > another set of idle states on top of this state. Again, suppose a module
> > registers another set of idle loops, it is added to this list.
> > 
> > This provides a clean way of registering and unregistering idle state
> > routines.
> 
> So cpuidle didn't already have a list of idle functions it takes an
> appropriate one from?
> 

No.. As of now, cpuidle supported only one _set_ of idle states that
can be registered. So in this one set, it would choose the appropriate
idle state. But this list mechanism(actually a stack) allows for
multiple sets.

This is needed because we have a hierarchy of idle states discovery
in x86. First, select_idle_routine() would select poll/mwait/default/c1e.
It doesn't know of existance of ACPI. Later when ACPI comes up,
it registers a set of routines on top of the earlier set.

> Then what does this governor do?
>

The governor would only select the best idle state available from the
set of states which is at the top of the stack. (In the above case, it
would only consider the states registered by ACPI).

If the top-of-the-stack set of idle states is unregistered, the next
set of states on the stack are considered.

> Also, does this imply the governor doesn't consider these idle routines?
>

As i said above, governor would only consider the idle routines which
are at the top of the stack.

Hope this gave a better idea..
