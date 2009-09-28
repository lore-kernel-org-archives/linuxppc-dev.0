Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B230B7B79
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Sep 2009 23:51:21 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8SDpFeH032680
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 19:21:15 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8SDpFgj2744508
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 19:21:15 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8SDpEfN021516
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 19:21:15 +0530
Date: Mon, 28 Sep 2009 19:21:03 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
Message-ID: <20090928135103.GA27218@dirshya.in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
	<1253753501.7103.358.camel@pasglop>
	<1253890120.18939.189.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1253890120.18939.189.camel@laptop>
Cc: Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-09-25 16:48:40]:

> On Thu, 2009-09-24 at 10:51 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2009-09-15 at 14:11 +0200, Peter Zijlstra wrote:
> > > I still think its a layering violation... its the hypervisor manager
> > > that should be bothered in what state an off-lined cpu is in. 
> > > 
> > That's not how our hypervisor works.
> 
> Then fix it?
> 
> > If you ask through the management interface, to remove a CPU from a
> > partition, the HV will communicate with a daemon inside the partition
> > that will then unplug the CPU via the right call.
> > 
> > I don't really understand your objections to be honest. And I fail to
> > see why it would be a layering violation to have the ability for the OS
> > to indicate in what state it wishes to relinguish a CPU to the
> > hypervisor, which more or less defines what is the expected latency for
> > getting it back later on.
> 
> OK, so the main objection is the abuse of CPU hotplug as resource
> management feature.
> 
> CPU hotplug is terribly invasive and expensive to the kernel, doing
> hotplug on a minute basis is just plain crazy.
> 
> If you want a CPU in a keep it near and don't hand it back to the HV
> state, why not use cpusets to isolate it and simply not run tasks on it?
> 
> cpusets don't use stopmachine and are much nicer to the rest of the
> kernel over-all.

Hi Peter,

This interface is not expected to be used every minute or so to impact
the operation of the rest of the system.  Cpuhotplug is currently used
as a resource management feature in virtualised system using dlpar
operations.  I do understand that cpu hotplug is invasive at run time
and that amount of complexity is required to carefully isolate the cpu
from any involvement in the running kernel.

Building another interface to isolate the cpus to the same extent as
cpu hotplug does today would be redundant and is going to be equally
invasive. Alternatives like cpuset for isolation migrates only tasks.

--Vaidy
