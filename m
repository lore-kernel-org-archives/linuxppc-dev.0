Return-Path: <dipankar@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3D88B7B6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Sep 2009 02:25:14 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8GGP7pp004110
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 21:55:08 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GGP7AX2650360
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 21:55:07 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8GGP6Xw024925
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2009 02:25:07 +1000
Date: Wed, 16 Sep 2009 21:54:59 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
Message-ID: <20090916162459.GB12571@in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
	<20090916152820.GA12571@in.ibm.com>
	<1253115171.7180.1.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253115171.7180.1.camel@laptop>
Cc: Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: dipankar@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 16, 2009 at 05:32:51PM +0200, Peter Zijlstra wrote:
> On Wed, 2009-09-16 at 20:58 +0530, Dipankar Sarma wrote:
> > On Tue, Sep 15, 2009 at 02:11:41PM +0200, Peter Zijlstra wrote:
> > > On Tue, 2009-09-15 at 17:36 +0530, Gautham R Shenoy wrote:
> > > > This patchset contains the offline state driver implemented for
> > > > pSeries. For pSeries, we define three available_hotplug_states. They are:
> > > > 
> > > >         online: The processor is online.
> > > > 
> > > >         offline: This is the the default behaviour when the cpu is offlined
> > > > 
> > > >         inactive: This cedes the vCPU to the hypervisor with a cede latency
> > > > 
> > > > Any feedback on the patchset will be immensely valuable.
> > > 
> > > I still think its a layering violation... its the hypervisor manager
> > > that should be bothered in what state an off-lined cpu is in. 
> > 
> > The problem is that all hypervisor managers cannot figure out what sort
> > of latency guest OS can tolerate under the situation. They wouldn't know
> > from what context guest OS has ceded the vcpu. It has to have
> > some sort of hint, which is what the guest OS provides.
> 
> I'm missing something here, hot-unplug is a slow path and should not
> ever be latency critical..?

You aren't, I did :)

No, for this specific case, latency isn't an issue. The issue is -
how do we cede unused vcpus to hypervisor for better energy management ?
Yes, it can be done by a hypervisor manager telling the kernel to
offline and make a bunch of vcpus "inactive". It does have to choose
offline (release vcpu) vs. inactive (cede but guranteed if needed).
The problem is that long ago we exported a lot of hotplug stuff to
userspace through the sysfs interface and we cannot do something
inside the kernel without keeping the sysfs stuff consistent.
This seems like a sane way to do that without undoing all the
virtual cpu hotplug infrastructure in different supporting archs.

Thanks
Dipankar
