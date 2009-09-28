Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50649B7B8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Sep 2009 23:54:02 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8SDrwPn025452
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 23:53:58 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8SDs0KX254072
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 23:54:00 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8SDrx6e017629
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2009 23:54:00 +1000
Date: Mon, 28 Sep 2009 19:23:44 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
Message-ID: <20090928135344.GK8595@dirshya.in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
	<1253753501.7103.358.camel@pasglop>
	<1253890120.18939.189.camel@laptop>
	<1253913169.7103.529.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1253913169.7103.529.camel@pasglop>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	linux-kernel@vger.kernel.org,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	"Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2009-09-26 07:12:48]:

> On Fri, 2009-09-25 at 16:48 +0200, Peter Zijlstra wrote:
> > On Thu, 2009-09-24 at 10:51 +1000, Benjamin Herrenschmidt wrote:
> > > On Tue, 2009-09-15 at 14:11 +0200, Peter Zijlstra wrote:
> > > > I still think its a layering violation... its the hypervisor manager
> > > > that should be bothered in what state an off-lined cpu is in. 
> > > > 
> > > That's not how our hypervisor works.
> > 
> > Then fix it?
> 
> Are you serious ? :-)
> 
> > CPU hotplug is terribly invasive and expensive to the kernel, doing
> > hotplug on a minute basis is just plain crazy.
> > 
> > If you want a CPU in a keep it near and don't hand it back to the HV
> > state, why not use cpusets to isolate it and simply not run tasks on it?
> > 
> > cpusets don't use stopmachine and are much nicer to the rest of the
> > kernel over-all.
> 
> Gautham, what is the different in term of power saving between having
> it idle for long periods of time (which could do H_CEDE and with NO_HZ,
> probably wouln't need to wake up that often) and having it unplugged in
> a H_CEDE loop ?

Hi Ben,

A cede latency specifier value indicating latency expectation of the
guest OS can be established in the VPA to inform the hypervisor during
the H_CEDE call.  Currently, we do call H_CEDE during NO_HZ for
efficient idle.  However, higher cede latency values may not be
suitable for idle CPUs in the kernel and instead more energy savings
may result from exploiting this feature through CPU hotplug
interface.

--Vaidy
