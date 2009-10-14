Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [59.145.155.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FAB6B7BAD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 17:17:37 +1100 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id n9E66uhl014769
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2009 11:36:56 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9E6HVWg2510946
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2009 11:47:31 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9E6HTvO028830
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2009 17:17:30 +1100
Date: Wed, 14 Oct 2009 11:47:27 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
Message-ID: <20091014061727.GA8605@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
	<1254998162.26976.270.camel@twins>
	<20091008104249.GJ20595@linux.vnet.ibm.com>
	<1254999033.26976.272.camel@twins>
	<8763akh4re.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <8763akh4re.fsf@basil.nowhere.org>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>,
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

* Andi Kleen <andi@firstfloor.org> [2009-10-12 20:00:05]:

> Peter Zijlstra <a.p.zijlstra@chello.nl> writes:
> >
> > So does it make sense to have a set of sets?
> >
> > Why not integrate them all into one set to be ruled by this governor
> > thing?
> 
> cpuidle is currently optional, that is why the two level hierarchy
> is there so that you can still have simple idle selection without it.
> 
> % size drivers/cpuidle/*.o
>    text    data     bss     dec     hex filename
>    5514    1416      44    6974    1b3e drivers/cpuidle/built-in.o
> 
> Adding it unconditionally would add ~7k to everyone who wants idle functions.
> 
> I think making it unconditional would require putting it on a serious
> diet first.
> 

Hi Andi,

Yes, this is a valid point.

How about something like this..
If the arch does not enable CONFIG_CPU_IDLE, the cpuidle_idle_call
which is called from cpu_idle() should call default_idle without
involving the registering cpuidle steps. This should prevent bloating
up of the kernel for archs which dont want to use cpuidle.

--arun
> -Andi
> -- 
> ak@linux.intel.com -- Speaking for myself only.
