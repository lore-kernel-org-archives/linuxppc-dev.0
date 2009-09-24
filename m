Return-Path: <BATV+e3e6a292ed3714320c00+2223+infradead.org+arjan@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69396B7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 21:41:32 +1000 (EST)
Date: Thu, 24 Sep 2009 13:41:23 +0200
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v2 0/2] cpu: pseries: Offline state framework.
Message-ID: <20090924134123.4acd1adf@infradead.org>
In-Reply-To: <1253791987.7695.153.camel@twins>
References: <20090828095741.10641.32053.stgit@sofia.in.ibm.com>
	<1251869611.7547.38.camel@twins>
	<1253753307.7103.356.camel@pasglop>
	<1253778667.7695.130.camel@twins>
	<1253781508.7103.437.camel@pasglop>
	<1253791987.7695.153.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 24 Sep 2009 13:33:07 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Thu, 2009-09-24 at 18:38 +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2009-09-24 at 09:51 +0200, Peter Zijlstra wrote:
> > > > I don't quite follow your logic here. This is useful for more
> > > > than just hypervisors. For example, take the HV out of the
> > > > picture for a moment and imagine that the HW has the ability to
> > > > offline CPU in various power levels, with varying latencies to
> > > > bring them back.
> > > 
> > > cpu-hotplug is an utter slow path, anybody saying latency and
> > > hotplug in the same sentence doesn't seem to grasp either or both
> > > concepts.
> > 
> > Let's forget about latency then. Let's imagine I want to set a CPU
> > offline to save power, vs. setting it offline -and- opening the back
> > door of the machine to actually physically replace it :-)
> 
> If the hardware is capable of physical hotplug, then surely powering
> the socket down saves most power and is the preferred mode?

btw just to take away a perception that generally powering down sockets
help; it does not help for all cpus. Some cpus are so efficient in idle
that the incremental gain one would get by "offlining" a core is just
not worth it
(in fact, in x86, it's the same thing)

I obviously can't speak for p-series cpus, just wanted to point out
that there is no universal truth about "offlining saves power".

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
