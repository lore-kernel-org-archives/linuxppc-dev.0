Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5E4B8B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Aug 2009 05:44:53 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7GJdsvF000640
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 01:09:54 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7GJilBV2343100
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 01:14:47 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7GJijQ8031559
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 05:44:47 +1000
Date: Mon, 17 Aug 2009 01:14:41 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 0/3] cpu: idle state framework for offline CPUs.
Message-ID: <20090816194441.GA22626@balbir.in.ibm.com>
References: <20090809120818.GA1338@ucw.cz> <200908091522.02898.rjw@sisk.pl>
	<20090810081941.GA18649@elf.ucw.cz>
	<1249950137.11545.38184.camel@localhost.localdomain>
	<20090812115806.GK24339@elf.ucw.cz>
	<20090812195753.GA14649@in.ibm.com>
	<alpine.LFD.2.00.0908122036580.22946@localhost.localdomain>
	<20090813045931.GB14649@in.ibm.com>
	<20090814113021.GL32418@elf.ucw.cz>
	<20090816182629.GA31027@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090816182629.GA31027@in.ibm.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "Li,
	Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Len Brown <lenb@kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Dipankar Sarma <dipankar@in.ibm.com> [2009-08-16 23:56:29]:

> On Fri, Aug 14, 2009 at 01:30:21PM +0200, Pavel Machek wrote:
> > > 
> > > It depends on the hypervisor implementation. On pseries (powerpc)
> > > hypervisor, for example, they are different. By offlining a vcpu
> > > (and in turn shutting a cpu), you will actually create a configuration
> > > change in the VM that is visible to other systems management tools
> > > which may not be what the system administrator wanted. Ideally,
> > > we would like to distinguish between these two states.
> > > 
> > > Hope that suffices as an example.
> > 
> > So... you have something like "physically pulling out hotplug cpu" on
> > powerpc.
> 
> If any system can do physical unplug, then it should do "offline"
> with configuration changes reflected in the hypervisor and
> other system configuration software.
> 
> > But maybe it is useful to take already offline cpus (from linux side),
> > and make that visible to hypervisor, too.
> > 
> > So maybe something like "echo 1 > /sys/devices/system/cpu/cpu1/unplug"
> > would be more useful for hypervisor case?
> 
> On pseries, we do an RTAS call ("stop-cpu") which effectively permantently
> de-allocates it from the VM hands over the control to hypervisor. The
> hypervisors may do whatever it wants including allocating it to
> another VM. Once gone, the original VM may not get it back depending
> on the situation.
> 
> The point I am making is that we may not always want to *release*
> the CPU to hypervisor and induce a configuration change. That needs
> to be reflected by extending the existing user interface - hence
> the proposal for - /sys/devices/system/cpu/cpu<#>/state and
> /sys/devices/system/cpu/cpu<#>/available_states. It allows
> ceding to hypervisor without de-allocating. It is a minor
> extension of the existing interface keeping backwards compatibility
> and platforms can allow what make sense.
>


Agreed, I've tried to come with a little ASCII art to depict your
scenairos graphically


        +--------+ don't need (offline)
        |  OS    +----------->+------------+
        +--+-----+            | hypervisor +-----> Reuse CPU
           |                  |            |       for something
           |                  |            |       else
           |                  |            |   (visible to users)
           |                  |            |    as resource changed
           |                  +----------- +
           V (needed, but can cede)
       +------------+
       | hypervisor | Don't reuse CPU
       |            |  (CPU ceded)
       |            | give back to OS
       +------------+ when needed.
                        (Not visible to
                        users as so resource
                        binding changed)



-- 
	Balbir
