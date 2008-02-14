Return-Path: <pbadari@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56108DDFC0
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 04:33:52 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1EHXjZ1031037
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 12:33:45 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1EHXitb1974350
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 12:33:45 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1EHXhoB010585
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 10:33:44 -0700
Subject: Re: [PATCH] drivers/base: export gpl (un)register_memory_notifier
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <1203009163.19205.42.camel@nimitz.home.sr71.net>
References: <200802111724.12416.ossthema@de.ibm.com>
	<1202748429.8276.21.camel@nimitz.home.sr71.net>
	<200802131617.58646.ossthema@de.ibm.com>
	<OF64B9886B.CE795DED-ONC12573EF.002FFA8B-C12573EF.00301683@de.ibm.com>
	<1203009163.19205.42.camel@nimitz.home.sr71.net>
Content-Type: text/plain
Date: Thu, 14 Feb 2008 09:36:15 -0800
Message-Id: <1203010575.12312.6.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, ossthema@linux.vnet.ibm.com,
	Jan-Bernd Themann <THEMANN@de.ibm.com>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	apw <apw@uk.ibm.com>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, tklein@linux.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-02-14 at 09:12 -0800, Dave Hansen wrote:
..
> > > > - Use currently other not exported functions in kernel/resource.c, like
> > > >   walk_memory_resource (where we would still need the maximum
> > > possible number
> > > >   of pages NR_MEM_SECTIONS)
> > >
> > > It isn't the act of exporting that's the problem.  It's making sure that
> > > the exports won't be prone to abuse and that people are using them
> > > properly.  You should assume that you can export and use
> > > walk_memory_resource().
> > 
> > So this seems to come down to a basic question:
> > New hardware seems to have a tendency to get "private MMUs",
> > which need private mappings from the kernel address space into a
> > "HW defined address space with potentially unique characteristics"
> > RDMA in Openfabrics with global MR is the most prominent example heading
> > there
> 
> That's not a question. ;)
> 
> Please explain to me why walk_memory_resource() is insufficient for your
> needs.  I've now pointed it out to you at least 3 times.  

I am not sure what you are trying to do with walk_memory_resource(). The
behavior is different on ppc64. Hotplug memory usage assumes that all
the memory resources (all system memory, not just IOMEM) are represented
in /proc/iomem. Its the case with i386 and ia64. But on ppc64 is
contains ONLY iomem related. Paulus didn't want to export all the system
memory into /proc/iomem on ppc64. So I had to workaround by providing
arch-specific walk_memory_resource() function for ppc64.

Thanks,
Badari
