Return-Path: <dipankar@in.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 98EA7B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 14:59:50 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7D4xZAZ028462
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2009 10:29:35 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7D4xZjj2023442
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2009 10:29:35 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7D4xXqx025311
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2009 14:59:35 +1000
Date: Thu, 13 Aug 2009 10:29:31 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090813045931.GB14649@in.ibm.com>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
	<20090809120818.GA1338@ucw.cz> <200908091522.02898.rjw@sisk.pl>
	<20090810081941.GA18649@elf.ucw.cz>
	<1249950137.11545.38184.camel@localhost.localdomain>
	<20090812115806.GK24339@elf.ucw.cz>
	<20090812195753.GA14649@in.ibm.com>
	<alpine.LFD.2.00.0908122036580.22946@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.00.0908122036580.22946@localhost.localdomain>
Cc: "Brown, Len" <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "Li,
	Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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

On Wed, Aug 12, 2009 at 08:45:18PM -0400, Len Brown wrote:
> On Thu, 13 Aug 2009, Dipankar Sarma wrote:
> > In a native system, I think we should the platform-specific code
> > export what makes sense. That may be just the lowest possible
> > state only. Or may be more than one.
> 
> For x86, it is 1 state.

Native x86, yes. For virtualized systems, that may not be the
case depending on how the hypervisor behaves.

> > In a virtualized system, we would want to do at least the following -
> 
> Are you talking about Linux as a para-virtualized guest here?
> 
> > 1. An offline configuration state where the hypervisor can
> > take the cpu back and allocate it to another VM.
> 
> The hypervisor gets control no matter what idle state
> the guest enters, yes?

The hypervisor may get control, but what they do may depend
on that the guest OS wished/hinted for - config change or just
shutdown unused cpu if possible for a while.

> > 2. A low-power state where the guest indicates it doesn't need the
> > CPU (and can be put in low power state) but doesn't want to give up 
> > its allocated cpu share. IOW, no visible configuration changes.
> > 
> > So, in any case we would probably want more than one states.
> 
> How are #1 and #2 different when the hypervisor
> gets control in all idle states?  I assert that
> they are the same, and thus 1 state will suffice.

It depends on the hypervisor implementation. On pseries (powerpc)
hypervisor, for example, they are different. By offlining a vcpu
(and in turn shutting a cpu), you will actually create a configuration
change in the VM that is visible to other systems management tools
which may not be what the system administrator wanted. Ideally,
we would like to distinguish between these two states.

Hope that suffices as an example.

Thanks
Dipankar
