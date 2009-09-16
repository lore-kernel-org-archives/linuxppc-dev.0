Return-Path: <dipankar@in.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [59.145.155.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7FC2B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Sep 2009 06:18:03 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp01.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8GKHvgw007841
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2009 01:47:57 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GKHvHX2752718
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2009 01:47:57 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8GKHunI008911
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2009 06:17:57 +1000
Date: Thu, 17 Sep 2009 01:47:49 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
Message-ID: <20090916201749.GA19107@in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
	<20090916152820.GA12571@in.ibm.com>
	<1253115171.7180.1.camel@laptop>
	<20090916162459.GB12571@in.ibm.com>
	<1253118916.7180.6.camel@laptop>
	<20090916170314.GH15538@dirshya.in.ibm.com>
	<1253121755.7180.8.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253121755.7180.8.camel@laptop>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	"Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: dipankar@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 16, 2009 at 07:22:35PM +0200, Peter Zijlstra wrote:
> On Wed, 2009-09-16 at 22:33 +0530, Vaidyanathan Srinivasan wrote:
> > * Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-09-16 18:35:16]:
> > 
> > > Now if you were to try and online the cpus in the guest, it'd fail
> > > because the cpus aren't backed anymore, and the hot-plug simply
> > > times-out and fails.
> > > 
> > > And we're still good, right?
> > 
> > The requirement differ here.  If we had offlined 2 vCPUs for the
> > purpose of system reconfiguration, the expected behavior with offline
> > interface will work right.  However the proposed cede interface is
> > needed when we want them to temporarily go away but still come back
> > when we do an online.  We want the online to always succeed since the
> > backing physical resources are not relinquished.  The proposed
> > interface facilitates offline without relinquishing the physical
> > resources assigned to LPARs.
> 
> Then make that the platform default and leave the lpar management to
> whatever pokes at the lpar?

That could have worked - however lpar management already uses
the same sysfs interface to poke. The current semantics make the lpar 
vcpu deconfig state the platform default assuming that it will be used for
lpar management. The only clean way to do this without breaking lpar
management stuff is to add another state - "inactive" and retain backward
compatibility.

Thanks
Dipankar
