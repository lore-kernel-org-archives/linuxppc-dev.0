Return-Path: <dipankar@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 81A05B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 05:57:59 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id n7CJvnkS023908
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2009 05:57:49 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7CJvu3l1253536
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2009 05:57:56 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7CJvtkA007206
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2009 05:57:56 +1000
Date: Thu, 13 Aug 2009 01:27:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090812195753.GA14649@in.ibm.com>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
	<20090809120818.GA1338@ucw.cz> <200908091522.02898.rjw@sisk.pl>
	<20090810081941.GA18649@elf.ucw.cz>
	<1249950137.11545.38184.camel@localhost.localdomain>
	<20090812115806.GK24339@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090812115806.GK24339@elf.ucw.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>, "Li,
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

On Wed, Aug 12, 2009 at 01:58:06PM +0200, Pavel Machek wrote:
> Hi!
> 
> > May be having (to pick a number) 3 possible offline states for all
> > platforms with one for halt equivalent and one for deepest possible that
> > CPU can handle and one for deepest possible that platform likes for
> > C-states may make sense. Will keeps things simpler in terms of usage
> > expectations and possibly reduce the misuse oppurtubity?
> 
> Maybe just going to the deepest offline state automatically is the
> easiest option?

In a native system, I think we should the platform-specific code
export what makes sense. That may be just the lowest possible
state only. Or may be more than one.

In a virtualized system, we would want to do at least the following -

1. An offline configuration state where the hypervisor can
take the cpu back and allocate it to another VM.

2. A low-power state where the guest indicates it doesn't need the
CPU (and can be put in low power state) but doesn't want to give up 
its allocated cpu share. IOW, no visible configuration changes.

So, in any case we would probably want more than one states.

> cpu hotplug/unplug should be rare-enough operation that the latencies
> do not really matter, right?

As of now, from the platform perspective, I don't think low-power
state latencies matter in this code path. The only thing that might
have any relevance is electrical power-off technology and whether
there may be any h/w specific issues restricting its use. I don't know
that there will be any, but it may not be a good idea to prevent
platforms from requiring the use of multiple "offline" states.

Thanks
Dipankar
