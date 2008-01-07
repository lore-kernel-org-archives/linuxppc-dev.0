Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2039BDDDFE
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 23:35:49 +1100 (EST)
Date: Mon, 7 Jan 2008 12:04:11 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCh v3] powerpc: add hugepagesz boot-time parameter
Message-ID: <20080107120410.GB29254@csn.ul.ie>
References: <477D68E6.2070108@linux.vnet.ibm.com>
	<200801040034.25329.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200801040034.25329.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>,
	csnook@redhat.com, Paul Mackerras <paulus@samba.org>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (04/01/08 00:34), Arnd Bergmann didst pronounce:
> On Thursday 03 January 2008, Jon Tollefson wrote:
> > Paul, please include this in 2.6.25 if there are no objections.
> 
> No objections to this version from me, just questions.
> 
> > This patch adds the hugepagesz boot-time parameter for ppc64.  It lets
> > one pick the size for huge pages. The choices available are 64K and 16M
> > when the base page size is 4k. It defaults to 16M (previously the only
> > only choice) if nothing or an invalid choice is specified.
> 
> We started discussing this in v1, but the discussion got sidetracked:
> Is there a technical reason why you don't also allow 1M pages, which
> may be useful in certain scenarios?
> 

I cannot see why not although the ideal would be that the necessary
information to support the pagesize would be provided by the firmware
instead of hard-coded values.

> On the Cell/B.E. platforms (IBM/Mercury blades, Toshiba Celleb, PS3), the
> second large page size is an option that can be set in a HID SPR
> to either 64KB or 1MB. Unfortunately, we can't do these two simultaneously,
> but the firmware can change the default and put it into the device tree,
> or you could have the kernel override the firmware settings.
> 
> Going a lot further, do you have plans for a fully dynamic hugepage size,
> e.g. using a mount option for hugetlbfs?

A mount option for hugetlbfs to select a hugepage size is a long-term
goal. However, a lot of changes are required to support such a thing. Selecting
the hugepage size at boot-time is a reasonable starting point and one that
might be usable with some additional work by x86-64 on AMD processors
supporting 1GiB pages.

> I can see that as rather useful,
> but at the same time it's probably much more complicated than the boot time
> option.
> 

Not probably at all. It is *certainly* much more complicated than the
boot-time option :)

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
