Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep11-int.chello.at (viefep11-int.chello.at [62.179.121.31])
	by ozlabs.org (Postfix) with ESMTP id D9410B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 17:55:48 +1000 (EST)
Subject: Re: [PATCH v2 0/2] cpu: pseries: Offline state framework.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1253753307.7103.356.camel@pasglop>
References: <20090828095741.10641.32053.stgit@sofia.in.ibm.com>
	<1251869611.7547.38.camel@twins>  <1253753307.7103.356.camel@pasglop>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 09:51:07 +0200
Message-Id: <1253778667.7695.130.camel@twins>
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

On Thu, 2009-09-24 at 10:48 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-09-02 at 07:33 +0200, Peter Zijlstra wrote:
> > 
> > I'm still thinking this is a bad idea.
> > 
> > The OS should only know about online/offline.
> > 
> > Use the hypervisor interface to deal with the cpu once its offline.
> > 
> > That is, I think this interface you propose is a layering violation.
> > 
> I don't quite follow your logic here. This is useful for more than just
> hypervisors. For example, take the HV out of the picture for a moment
> and imagine that the HW has the ability to offline CPU in various power
> levels, with varying latencies to bring them back.

cpu-hotplug is an utter slow path, anybody saying latency and hotplug in
the same sentence doesn't seem to grasp either or both concepts.
