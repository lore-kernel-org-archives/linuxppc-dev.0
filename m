Return-Path: <ego@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [59.145.155.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 13164B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 23:48:57 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id n76Dk4AD001178
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2009 19:16:04 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n76DmoNH1892356
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2009 19:18:50 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n76DmnQh008168
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2009 23:48:50 +1000
Date: Thu, 6 Aug 2009 19:18:44 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090806134844.GA19146@in.ibm.com>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090806015855.GA20596@sli10-desk.sh.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shaohua,

On Thu, Aug 06, 2009 at 09:58:55AM +0800, Shaohua Li wrote:
> Hi,
> 
> On Wed, Aug 05, 2009 at 10:25:53PM +0800, Gautham R Shenoy wrote:
> > In this patch-series, we propose to extend the CPU-Hotplug infrastructure
> > and allow the system administrator to choose the desired state the CPU should
> > go to when it is offlined. We think this approach addresses the concerns about
> > determinism as well as transparency, since CPU-Hotplug already provides
> > notification mechanism which the userspace can listen to for any change
> > in the configuration and correspondingly readjust any previously set
> > cpu-affinities.
> Peter dislikes any approach (including cpuhotplug) which breaks userspace policy,
> even userspace can get a notification.

I think Peter's problem was more to do with the kernel offlining the CPUs
behind the scenes, right ?

We don't do that in this patch series. The option to offline the CPUs is
very much with the admin. The patch-series only provides the interface
that helps the admin choose the state the CPU must reside in when it
goes offline.

> 
> > Also, approaches such as [1] can make use of this
> > extended infrastructure instead of putting the CPU to an arbitrary C-state
> > when it is offlined, thereby providing the system administrator a rope to hang
> > himself with should he feel the need to do so.
> I didn't see the reason why administrator needs to know which state offline cpu
> should stay. Don't know about powerpc side, but in x86 side, it appears deepest
> C-state is already preferred.

We can still provide a sane default value based on what states are
available and what the BIOS limits us to. Thus we can still use the
idle-state-offline patch that Venki posted sometime ago, right ?

> 
> Thanks,
> Shaohua

-- 
Thanks and Regards
gautham
