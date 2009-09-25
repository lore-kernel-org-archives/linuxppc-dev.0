Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B178B7BC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 07:15:10 +1000 (EST)
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1253890120.18939.189.camel@laptop>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop> <1253753501.7103.358.camel@pasglop>
	<1253890120.18939.189.camel@laptop>
Content-Type: text/plain
Date: Sat, 26 Sep 2009 07:12:48 +1000
Message-Id: <1253913169.7103.529.camel@pasglop>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-09-25 at 16:48 +0200, Peter Zijlstra wrote:
> On Thu, 2009-09-24 at 10:51 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2009-09-15 at 14:11 +0200, Peter Zijlstra wrote:
> > > I still think its a layering violation... its the hypervisor manager
> > > that should be bothered in what state an off-lined cpu is in. 
> > > 
> > That's not how our hypervisor works.
> 
> Then fix it?

Are you serious ? :-)

> CPU hotplug is terribly invasive and expensive to the kernel, doing
> hotplug on a minute basis is just plain crazy.
> 
> If you want a CPU in a keep it near and don't hand it back to the HV
> state, why not use cpusets to isolate it and simply not run tasks on it?
> 
> cpusets don't use stopmachine and are much nicer to the rest of the
> kernel over-all.

Gautham, what is the different in term of power saving between having
it idle for long periods of time (which could do H_CEDE and with NO_HZ,
probably wouln't need to wake up that often) and having it unplugged in
a H_CEDE loop ?

Ben.
