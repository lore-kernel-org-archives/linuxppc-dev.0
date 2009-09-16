Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E5CBB7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Sep 2009 03:03:32 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8GH15gS009433
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2009 03:01:05 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GH3UwA1274068
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2009 03:03:30 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8GH3T24027903
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2009 03:03:30 +1000
Date: Wed, 16 Sep 2009 22:33:14 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
Message-ID: <20090916170314.GH15538@dirshya.in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
	<20090916152820.GA12571@in.ibm.com>
	<1253115171.7180.1.camel@laptop>
	<20090916162459.GB12571@in.ibm.com>
	<1253118916.7180.6.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1253118916.7180.6.camel@laptop>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
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

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-09-16 18:35:16]:

> On Wed, 2009-09-16 at 21:54 +0530, Dipankar Sarma wrote:
> 
> > No, for this specific case, latency isn't an issue. The issue is -
> > how do we cede unused vcpus to hypervisor for better energy management ?
> > Yes, it can be done by a hypervisor manager telling the kernel to
> > offline and make a bunch of vcpus "inactive". It does have to choose
> > offline (release vcpu) vs. inactive (cede but guranteed if needed).
> > The problem is that long ago we exported a lot of hotplug stuff to
> > userspace through the sysfs interface and we cannot do something
> > inside the kernel without keeping the sysfs stuff consistent.
> > This seems like a sane way to do that without undoing all the
> > virtual cpu hotplug infrastructure in different supporting archs.
> 
> I'm still not getting it..
> 
> Suppose we have some guest, it booted with 4 cpus.
> 
> We then offline 2 of them.
> 
> Apparently this LPAR binds guest cpus to physical cpus?
> So we use a hypervisor interface to reclaim these 2 offlined cpus and
> re-assign them to some other guest.
> 
> So far so good, right?
> 
> Now if you were to try and online the cpus in the guest, it'd fail
> because the cpus aren't backed anymore, and the hot-plug simply
> times-out and fails.
> 
> And we're still good, right?

The requirement differ here.  If we had offlined 2 vCPUs for the
purpose of system reconfiguration, the expected behavior with offline
interface will work right.  However the proposed cede interface is
needed when we want them to temporarily go away but still come back
when we do an online.  We want the online to always succeed since the
backing physical resources are not relinquished.  The proposed
interface facilitates offline without relinquishing the physical
resources assigned to LPARs.

--Vaidy
