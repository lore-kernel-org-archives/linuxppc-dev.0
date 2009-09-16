Return-Path: <a.p.zijlstra@chello.nl>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9DEF9B7B6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Sep 2009 02:35:37 +1000 (EST)
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: dipankar@in.ibm.com
In-Reply-To: <20090916162459.GB12571@in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop> <20090916152820.GA12571@in.ibm.com>
	<1253115171.7180.1.camel@laptop>  <20090916162459.GB12571@in.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 18:35:16 +0200
Message-Id: <1253118916.7180.6.camel@laptop>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, "Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-16 at 21:54 +0530, Dipankar Sarma wrote:

> No, for this specific case, latency isn't an issue. The issue is -
> how do we cede unused vcpus to hypervisor for better energy management ?
> Yes, it can be done by a hypervisor manager telling the kernel to
> offline and make a bunch of vcpus "inactive". It does have to choose
> offline (release vcpu) vs. inactive (cede but guranteed if needed).
> The problem is that long ago we exported a lot of hotplug stuff to
> userspace through the sysfs interface and we cannot do something
> inside the kernel without keeping the sysfs stuff consistent.
> This seems like a sane way to do that without undoing all the
> virtual cpu hotplug infrastructure in different supporting archs.

I'm still not getting it..

Suppose we have some guest, it booted with 4 cpus.

We then offline 2 of them.

Apparently this LPAR binds guest cpus to physical cpus?
So we use a hypervisor interface to reclaim these 2 offlined cpus and
re-assign them to some other guest.

So far so good, right?

Now if you were to try and online the cpus in the guest, it'd fail
because the cpus aren't backed anymore, and the hot-plug simply
times-out and fails.

And we're still good, right?
