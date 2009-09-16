Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED2C8B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 17:49:54 +1000 (EST)
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n8G7n6Pr217284
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 07:49:11 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n8G7mo8Y577732
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 08:48:56 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n8G7mnoL029790
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2009 08:48:50 +0100
Date: Wed, 16 Sep 2009 09:48:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
Message-ID: <20090916074848.GB4870@osiris.boeblingen.de.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
	<20090915145834.GG4846@balbir.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090915145834.GG4846@balbir.in.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	linux-kernel@vger.kernel.org,
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

On Tue, Sep 15, 2009 at 08:28:34PM +0530, Balbir Singh wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-09-15 14:11:41]:
> 
> > On Tue, 2009-09-15 at 17:36 +0530, Gautham R Shenoy wrote:
> > > This patchset contains the offline state driver implemented for
> > > pSeries. For pSeries, we define three available_hotplug_states. They are:
> > > 
> > >         online: The processor is online.
> > > 
> > >         offline: This is the the default behaviour when the cpu is offlined
> > >         even in the absense of this driver. The CPU would call make an
> > >         rtas_stop_self() call and hand over the CPU back to the resource pool,
> > >         thereby effectively deallocating that vCPU from the LPAR.
> > >         NOTE: This would result in a configuration change to the LPAR
> > >         which is visible to the outside world.
> > > 
> > >         inactive: This cedes the vCPU to the hypervisor with a cede latency
> > >         specifier value 2.
> > >         NOTE: This option does not result in a configuration change
> > >         and the vCPU would be still entitled to the LPAR to which it earlier
> > >         belong to.
> > > 
> > > Any feedback on the patchset will be immensely valuable.
> > 
> > I still think its a layering violation... its the hypervisor manager
> > that should be bothered in what state an off-lined cpu is in. 
> >
> 
> From a design standpoint where we stand today is
> 
> 1. A cede indicates that the CPU is no longer needed and can be
> reassigned (remember we do dedicated CPU partitions in power)
> 2. What this patch is trying to do is to say "We don't need the
> CPU, but please don't reassign, put it to sleep"

FWIW, this sounds exactly like the same we have already on s390.
But back then I didn't consider adding a common code infrastructure
would make sense :)

Besides the "online" attribute we have an additional "configure"
attribute to which can only be written if the cpu is offline.
Writing a "0" to it would mean that you currently won't need the cpu
anymore and the hypervisor is free to reassign the cpu to a different
LPAR.
Writing a "1" to it means you want to use it. If there are enough
resources you will get it. If not.. bad luck.
