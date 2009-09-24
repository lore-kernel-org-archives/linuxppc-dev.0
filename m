Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B128FB7B85
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 18:40:48 +1000 (EST)
Subject: Re: [PATCH v2 0/2] cpu: pseries: Offline state framework.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1253778667.7695.130.camel@twins>
References: <20090828095741.10641.32053.stgit@sofia.in.ibm.com>
	<1251869611.7547.38.camel@twins>  <1253753307.7103.356.camel@pasglop>
	<1253778667.7695.130.camel@twins>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 18:38:27 +1000
Message-Id: <1253781508.7103.437.camel@pasglop>
Mime-Version: 1.0
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

On Thu, 2009-09-24 at 09:51 +0200, Peter Zijlstra wrote:
> > I don't quite follow your logic here. This is useful for more than just
> > hypervisors. For example, take the HV out of the picture for a moment
> > and imagine that the HW has the ability to offline CPU in various power
> > levels, with varying latencies to bring them back.
> 
> cpu-hotplug is an utter slow path, anybody saying latency and hotplug in
> the same sentence doesn't seem to grasp either or both concepts.

Let's forget about latency then. Let's imagine I want to set a CPU
offline to save power, vs. setting it offline -and- opening the back
door of the machine to actually physically replace it :-)

In any case, I don't see the added feature as being problematic, and
not such a "layering violation" as you seem to imply it is. It's a
convenient way to atomically take the CPU out -and- convey some
information about the "intent" to the hypervisor, and I really fail
to see why you have so strong objections about it.

Ben.
