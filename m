Return-Path: <venkatesh.pallipadi@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 878CDB7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 10:34:42 +1000 (EST)
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20090810081941.GA18649@elf.ucw.cz>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
	<20090809120818.GA1338@ucw.cz> <200908091522.02898.rjw@sisk.pl>
	<20090810081941.GA18649@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 17:22:17 -0700
Message-Id: <1249950137.11545.38184.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "Brown, Len" <len.brown@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, "Li,
	Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-10 at 01:19 -0700, Pavel Machek wrote:
> On Sun 2009-08-09 15:22:02, Rafael J. Wysocki wrote:
> > On Sunday 09 August 2009, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > Also, approaches such as [1] can make use of this
> > > > > extended infrastructure instead of putting the CPU to an arbitrary C-state
> > > > > when it is offlined, thereby providing the system administrator a rope to hang
> > > > > himself with should he feel the need to do so.
> > > > I didn't see the reason why administrator needs to know which state offline cpu
> > > > should stay. Don't know about powerpc side, but in x86 side, it appears deepest
> > > > C-state is already preferred.
> > > > 
> > > 
> > > Agreed, deepest c-state is always best, there's no need to make it configurable.
> > 
> > Unless it doesn't work.
> 
> If it does not work, machine will not boot. We already have
> max_cstate= kernel command line option to work around that...
> 

On x86, my earlier patch was selecting deepest C-state based on CPU
capability. There, "unless it doesn't work" will not hold good. If a CPU
C-state is reported in cpuid it will work. If there is any errata we
will workaround it as we do with anything else in the kernel.

My concern about having this interface for offline CPU is
- How are we going to populate this possible states. On x86, there are
2-3 CPU mwait cstates with each having few sub C-states. And there can
be some BIOS supplied C-states which are IO port invocations which will
map to some CPU mwait state,sub state pair mentioned above and we won't
know anything about this mapping. So, we want to give all these options
in sysfs?
- Having all these states and having no information on what basis one
should change this or on what reasons one should change this will result
in some userspace superpowersaver daemon using this in a wrong way and
some distro shipping it.

Also, I don't think using just the ACPI/BIOS supplied states in _CST is
right thing to do for offline. _CST is meant for C-state and BIOS may
not include some C-state in _CST if the system manufacturer thinks that
the latency is too high for the state to be used as a C-state. That
limitation applies for C-state as the cpu is expected to come out of
C-state often and execute code handle interrupts etc. But, that
restriction does not apply for offline online which is not as frequent
as C-state entry and it already has big latency with startup IPI, and a
whole baggage of CPU setup code. So, using BIOS CST info for CPU offline
state doesn't seem right.

May be having (to pick a number) 3 possible offline states for all
platforms with one for halt equivalent and one for deepest possible that
CPU can handle and one for deepest possible that platform likes for
C-states may make sense. Will keeps things simpler in terms of usage
expectations and possibly reduce the misuse oppurtubity?

Thanks,
Venki
