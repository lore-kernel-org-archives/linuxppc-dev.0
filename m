Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64BF4B7BAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 17:27:47 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8P7RiBs015489
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2009 17:27:44 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8P7RivP446660
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2009 17:27:44 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8P7Rhgl003943
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2009 17:27:44 +1000
Date: Fri, 25 Sep 2009 12:55:49 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH v2 0/2] cpu: pseries: Offline state framework.
Message-ID: <20090925072549.GB9562@dirshya.in.ibm.com>
References: <20090828095741.10641.32053.stgit@sofia.in.ibm.com>
	<1251869611.7547.38.camel@twins>
	<1253753307.7103.356.camel@pasglop>
	<1253778667.7695.130.camel@twins>
	<1253781508.7103.437.camel@pasglop>
	<1253791987.7695.153.camel@twins>
	<20090924134123.4acd1adf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090924134123.4acd1adf@infradead.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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

* Arjan van de Ven <arjan@infradead.org> [2009-09-24 13:41:23]:

> On Thu, 24 Sep 2009 13:33:07 +0200
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > On Thu, 2009-09-24 at 18:38 +1000, Benjamin Herrenschmidt wrote:
> > > On Thu, 2009-09-24 at 09:51 +0200, Peter Zijlstra wrote:
> > > > > I don't quite follow your logic here. This is useful for more
> > > > > than just hypervisors. For example, take the HV out of the
> > > > > picture for a moment and imagine that the HW has the ability to
> > > > > offline CPU in various power levels, with varying latencies to
> > > > > bring them back.
> > > > 
> > > > cpu-hotplug is an utter slow path, anybody saying latency and
> > > > hotplug in the same sentence doesn't seem to grasp either or both
> > > > concepts.
> > > 
> > > Let's forget about latency then. Let's imagine I want to set a CPU
> > > offline to save power, vs. setting it offline -and- opening the back
> > > door of the machine to actually physically replace it :-)
> > 
> > If the hardware is capable of physical hotplug, then surely powering
> > the socket down saves most power and is the preferred mode?
> 
> btw just to take away a perception that generally powering down sockets
> help; it does not help for all cpus. Some cpus are so efficient in idle
> that the incremental gain one would get by "offlining" a core is just
> not worth it
> (in fact, in x86, it's the same thing)
> 
> I obviously can't speak for p-series cpus, just wanted to point out
> that there is no universal truth about "offlining saves power".

Hi Arjan,

As you have said, on some cpus the extra effort of offlining does not
save us any extra power, and the state will be same as idle.  The
assertion that offlining saves power is still valid, it could be same
as idle or better depending on the architecture and implementation.

On x86 we still need the code (Venki posted) to take cpus to C6 on
offline to save power or else offlining consumes more power than idle
due to C1/hlt state.  This framework can help here as well if we have
any apprehension on making lowest sleep state as default on x86 and
want the administrator to decide.

--Vaidy
