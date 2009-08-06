Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4C3FDB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 14:35:20 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id n764Ys2S027372
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2009 14:34:54 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n764YxS31200336
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2009 14:34:59 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n764Yw1a007758
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2009 14:34:59 +1000
Date: Thu, 6 Aug 2009 10:03:51 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090806043351.GC14333@dirshya.in.ibm.com>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090806015855.GA20596@sli10-desk.sh.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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

* Shaohua Li <shaohua.li@intel.com> [2009-08-06 09:58:55]:

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

Hi Shaohua,

Notification to userspace and an opportunity to react to the situation
is certainly better to manage as compared to under-the-cover reduction
in capacity.

We are already doing something to this effect in virtualized guests
where VCPU entitlement and assignment can be changed by the hypervisor
based on resource constraints.  This framework with notification and
determinism will help manage cpu capacity better.

I agree with Peter that scheduler approach is better, but it is not
deterministic.  This is simpler and cleaner alternative to keep the
complexity in userspace and provide only framework to control/notify
kernel.
 
> > Also, approaches such as [1] can make use of this
> > extended infrastructure instead of putting the CPU to an arbitrary C-state
> > when it is offlined, thereby providing the system administrator a rope to hang
> > himself with should he feel the need to do so.
> I didn't see the reason why administrator needs to know which state offline cpu
> should stay. Don't know about powerpc side, but in x86 side, it appears deepest
> C-state is already preferred.

Yes that is what we would expect, but the deepest sleep state may be
restricted by BIOS or other system level parameters.  This was the
main objection to Venki's deepest sleep state for offline cpus patch.
There could be higher level policy that restricts the deepest level
C-states for various reasons.  This framework is to provide an
opportunity to adhere to the policy with userspace inputs.  This
framework also helps to choose different states in a virtualized
system.

--Vaidy
