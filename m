Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8FAB2B7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 21:30:34 +1000 (EST)
Date: Fri, 14 Aug 2009 13:30:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090814113021.GL32418@elf.ucw.cz>
References: <20090805142311.553.78286.stgit@sofia.in.ibm.com>
	<20090806015855.GA20596@sli10-desk.sh.intel.com>
	<20090809120818.GA1338@ucw.cz> <200908091522.02898.rjw@sisk.pl>
	<20090810081941.GA18649@elf.ucw.cz>
	<1249950137.11545.38184.camel@localhost.localdomain>
	<20090812115806.GK24339@elf.ucw.cz>
	<20090812195753.GA14649@in.ibm.com>
	<alpine.LFD.2.00.0908122036580.22946@localhost.localdomain>
	<20090813045931.GB14649@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090813045931.GB14649@in.ibm.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>, "Li,
	Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Len Brown <lenb@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > > 2. A low-power state where the guest indicates it doesn't need the
> > > CPU (and can be put in low power state) but doesn't want to give up 
> > > its allocated cpu share. IOW, no visible configuration changes.
> > > 
> > > So, in any case we would probably want more than one states.
> > 
> > How are #1 and #2 different when the hypervisor
> > gets control in all idle states?  I assert that
> > they are the same, and thus 1 state will suffice.
> 
> It depends on the hypervisor implementation. On pseries (powerpc)
> hypervisor, for example, they are different. By offlining a vcpu
> (and in turn shutting a cpu), you will actually create a configuration
> change in the VM that is visible to other systems management tools
> which may not be what the system administrator wanted. Ideally,
> we would like to distinguish between these two states.
> 
> Hope that suffices as an example.

So... you have something like "physically pulling out hotplug cpu" on
powerpc.

But maybe it is useful to take already offline cpus (from linux side),
and make that visible to hypervisor, too.

So maybe something like "echo 1 > /sys/devices/system/cpu/cpu1/unplug"
would be more useful for hypervisor case?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
