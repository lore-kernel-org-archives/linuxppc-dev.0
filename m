Return-Path: <dipankar@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AB170B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Aug 2009 04:26:42 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id n7GIQWiI013136
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 04:26:32 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7GIQdw91192020
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 04:26:40 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7GIQcRk027349
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 04:26:39 +1000
Date: Sun, 16 Aug 2009 23:56:29 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090816182629.GA31027@in.ibm.com>
References: <20090806015855.GA20596@sli10-desk.sh.intel.com>
	<20090809120818.GA1338@ucw.cz> <200908091522.02898.rjw@sisk.pl>
	<20090810081941.GA18649@elf.ucw.cz>
	<1249950137.11545.38184.camel@localhost.localdomain>
	<20090812115806.GK24339@elf.ucw.cz>
	<20090812195753.GA14649@in.ibm.com>
	<alpine.LFD.2.00.0908122036580.22946@localhost.localdomain>
	<20090813045931.GB14649@in.ibm.com>
	<20090814113021.GL32418@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090814113021.GL32418@elf.ucw.cz>
Cc: "Brown, Len" <len.brown@intel.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>, "Li,
	Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Len Brown <lenb@kernel.org>
Reply-To: dipankar@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 14, 2009 at 01:30:21PM +0200, Pavel Machek wrote:
> > 
> > It depends on the hypervisor implementation. On pseries (powerpc)
> > hypervisor, for example, they are different. By offlining a vcpu
> > (and in turn shutting a cpu), you will actually create a configuration
> > change in the VM that is visible to other systems management tools
> > which may not be what the system administrator wanted. Ideally,
> > we would like to distinguish between these two states.
> > 
> > Hope that suffices as an example.
> 
> So... you have something like "physically pulling out hotplug cpu" on
> powerpc.

If any system can do physical unplug, then it should do "offline"
with configuration changes reflected in the hypervisor and
other system configuration software.

> But maybe it is useful to take already offline cpus (from linux side),
> and make that visible to hypervisor, too.
> 
> So maybe something like "echo 1 > /sys/devices/system/cpu/cpu1/unplug"
> would be more useful for hypervisor case?

On pseries, we do an RTAS call ("stop-cpu") which effectively permantently
de-allocates it from the VM hands over the control to hypervisor. The
hypervisors may do whatever it wants including allocating it to
another VM. Once gone, the original VM may not get it back depending
on the situation.

The point I am making is that we may not always want to *release*
the CPU to hypervisor and induce a configuration change. That needs
to be reflected by extending the existing user interface - hence
the proposal for - /sys/devices/system/cpu/cpu<#>/state and
/sys/devices/system/cpu/cpu<#>/available_states. It allows
ceding to hypervisor without de-allocating. It is a minor
extension of the existing interface keeping backwards compatibility
and platforms can allow what make sense.

Thanks
Dipankar
