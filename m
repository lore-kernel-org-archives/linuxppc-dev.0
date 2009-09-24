Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38EA4B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 10:50:52 +1000 (EST)
Subject: Re: [PATCH v2 0/2] cpu: pseries: Offline state framework.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1251869611.7547.38.camel@twins>
References: <20090828095741.10641.32053.stgit@sofia.in.ibm.com>
	<1251869611.7547.38.camel@twins>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 10:48:27 +1000
Message-Id: <1253753307.7103.356.camel@pasglop>
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

On Wed, 2009-09-02 at 07:33 +0200, Peter Zijlstra wrote:
> 
> I'm still thinking this is a bad idea.
> 
> The OS should only know about online/offline.
> 
> Use the hypervisor interface to deal with the cpu once its offline.
> 
> That is, I think this interface you propose is a layering violation.
> 
I don't quite follow your logic here. This is useful for more than just
hypervisors. For example, take the HV out of the picture for a moment
and imagine that the HW has the ability to offline CPU in various power
levels, with varying latencies to bring them back.

For example, the HW can put them in some low power state where they can
be re-plugged quickly, or can shutdown entire power planes completely,
possibly allowing physical hotplug, but that takes much longer to bring
them back into the pool.

In any case, regarding the pseries case, this is how our hypervisor
works and I don't think we can change it, other than by always going
into the "cede" function and having some weird separate interface in the
arch to then whack them into some different state.

Ben.
