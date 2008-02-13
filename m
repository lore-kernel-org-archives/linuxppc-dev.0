Return-Path: <haveblue@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F162DDFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 04:05:23 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1DH6oWE005625
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 12:06:50 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1DH4txS1085466
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 12:04:55 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1DH4sw9004713
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 12:04:54 -0500
Subject: Re: [PATCH] drivers/base: export gpl (un)register_memory_notifier
From: Dave Hansen <haveblue@us.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200802131617.58646.ossthema@de.ibm.com>
References: <200802111724.12416.ossthema@de.ibm.com>
	<1202748429.8276.21.camel@nimitz.home.sr71.net>
	<200802131617.58646.ossthema@de.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Feb 2008 09:05:00 -0800
Message-Id: <1202922300.25500.37.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, "Themann, Jan-Bernd" <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, apw <apw@uk.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Badari Pulavarty <pbadari@us.ibm.com>, Greg KH <greg@kroah.com>,
	Thomas Klein <osstklei@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-02-13 at 16:17 +0100, Jan-Bernd Themann wrote:
> Constraints imposed by HW / FW:
> - eHEA has own MMU
> - eHEA  Memory Regions (MRs) are used by the eHEA MMU  to translate virtual
>   addresses to absolute addresses (like DMA mapped memory on a PCI bus)
> - The number of MRs is limited (not enough to have one MR per packet)

Are there enough to have one per 16MB section?

> Our current understanding about the current Memory Hotplug System are
> (please correct me if I'm wrong):
> 
> - depends on sparse mem

You're wrong ;).  In mainline, this is true.  There was a version of the
SUSE kernel that did otherwise.  But you can not and should not depend
on this never changing.  But, someone is perfectly free to go out an
implement something better than sparsemem for memory hotplug.  If they
go and do this, your driver may get left behind. 

> - only whole memory sections are added / removed
> - for each section a memory resource is registered

True, and true. (There might be exceptions to the whole sections one,
but that's blatant abuse and should be fixed. :)

> From the driver side we need:
> - some kind of memory notification mechanism.
>   For memory add we can live without any external memory notification
>   event. For memory remove we do need an external trigger (see explanation
>   above).

You can export and use (un)register_memory_notifier.  You just need to
do it in a reasonable way that compiles for randconfig on your
architecture.  Believe me, we don't want to start teaching drivers about
sparsemem.  

> - a way to iterate over all kernel pages and a way to detect holes in the
>   kernel memory layout in order to build up our own ehea_bmap.

Look at kernel/resource.c

But, I'm really not convinced that you can actually keep this map
yourselves.  It's not as simple as you think.  What happens if you get
on an LPAR with two sections, one 256MB@0x0 and another
16MB@0x1000000000000000.  That's quite possible.  I think your vmalloc'd
array will eat all of memory.  

That's why we have SPARSEMEM_EXTREME and SPARSEMEM_VMEMMAP implemented
in the core, so that we can deal with these kinds of problems, once and
*NOT* in every single little driver out there.  

> Functions to use while building ehea_bmap + MRs:
> - Use either the functions that are used by the memory hotplug system as
>   well, that means using the section defines + functions (section_nr_to_pfn,
>   pfn_valid)

Basically, you can't use anything related to sections outside of the
core code.  You can use things like pfn_valid(), or you can create new
interfaces that are properly abstracted.  

> - Use currently other not exported functions in kernel/resource.c, like
>   walk_memory_resource (where we would still need the maximum possible number
>   of pages NR_MEM_SECTIONS)

It isn't the act of exporting that's the problem.  It's making sure that
the exports won't be prone to abuse and that people are using them
properly.  You should assume that you can export and use
walk_memory_resource().

Do you know what other operating systems do with this hardware?

In the future, please make an effort to get review from knowledgeable
people about these kinds of things before using them in your driver.
Your company has many, many resources available, and all you need to do
is ask.  All that you have to do is look to the tops of the files of the
functions you are calling.

-- Dave
