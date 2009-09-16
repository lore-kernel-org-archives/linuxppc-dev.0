Return-Path: <dipankar@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E415B7B8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Sep 2009 01:28:32 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8GFSSM2004168
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 20:58:28 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GFSStA2416892
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 20:58:28 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8GFSRHA005093
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 20:58:28 +0530
Date: Wed, 16 Sep 2009 20:58:20 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
Message-ID: <20090916152820.GA12571@in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253016701.5506.73.camel@laptop>
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

On Tue, Sep 15, 2009 at 02:11:41PM +0200, Peter Zijlstra wrote:
> On Tue, 2009-09-15 at 17:36 +0530, Gautham R Shenoy wrote:
> > This patchset contains the offline state driver implemented for
> > pSeries. For pSeries, we define three available_hotplug_states. They are:
> > 
> >         online: The processor is online.
> > 
> >         offline: This is the the default behaviour when the cpu is offlined
> > 
> >         inactive: This cedes the vCPU to the hypervisor with a cede latency
> > 
> > Any feedback on the patchset will be immensely valuable.
> 
> I still think its a layering violation... its the hypervisor manager
> that should be bothered in what state an off-lined cpu is in. 

The problem is that all hypervisor managers cannot figure out what sort
of latency guest OS can tolerate under the situation. They wouldn't know
from what context guest OS has ceded the vcpu. It has to have
some sort of hint, which is what the guest OS provides.

Thanks
Dipankar
