Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60592B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 10:54:01 +1000 (EST)
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1253016701.5506.73.camel@laptop>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 10:51:41 +1000
Message-Id: <1253753501.7103.358.camel@pasglop>
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

On Tue, 2009-09-15 at 14:11 +0200, Peter Zijlstra wrote:
> I still think its a layering violation... its the hypervisor manager
> that should be bothered in what state an off-lined cpu is in. 
> 
That's not how our hypervisor works.

If you ask through the management interface, to remove a CPU from a
partition, the HV will communicate with a daemon inside the partition
that will then unplug the CPU via the right call.

I don't really understand your objections to be honest. And I fail to
see why it would be a layering violation to have the ability for the OS
to indicate in what state it wishes to relinguish a CPU to the
hypervisor, which more or less defines what is the expected latency for
getting it back later on.

Ben.
