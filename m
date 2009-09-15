Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7843AB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 00:58:43 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8FEwcax019801
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2009 20:28:38 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8FEwb3h2375820
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2009 20:28:37 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8FEwaJu027192
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 00:58:37 +1000
Date: Tue, 15 Sep 2009 20:28:34 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
Message-ID: <20090915145834.GG4846@balbir.in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1253016701.5506.73.camel@laptop>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	"Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-09-15 14:11:41]:

> On Tue, 2009-09-15 at 17:36 +0530, Gautham R Shenoy wrote:
> > This patchset contains the offline state driver implemented for
> > pSeries. For pSeries, we define three available_hotplug_states. They are:
> > 
> >         online: The processor is online.
> > 
> >         offline: This is the the default behaviour when the cpu is offlined
> >         even in the absense of this driver. The CPU would call make an
> >         rtas_stop_self() call and hand over the CPU back to the resource pool,
> >         thereby effectively deallocating that vCPU from the LPAR.
> >         NOTE: This would result in a configuration change to the LPAR
> >         which is visible to the outside world.
> > 
> >         inactive: This cedes the vCPU to the hypervisor with a cede latency
> >         specifier value 2.
> >         NOTE: This option does not result in a configuration change
> >         and the vCPU would be still entitled to the LPAR to which it earlier
> >         belong to.
> > 
> > Any feedback on the patchset will be immensely valuable.
> 
> I still think its a layering violation... its the hypervisor manager
> that should be bothered in what state an off-lined cpu is in. 
>

>From a design standpoint where we stand today is

1. A cede indicates that the CPU is no longer needed and can be
reassigned (remember we do dedicated CPU partitions in power)
2. What this patch is trying to do is to say "We don't need the
CPU, but please don't reassign, put it to sleep"

We work the same way with the hypervisor, that applications work with
the OS today, by providing madvise and other hints.

-- 
	Balbir
