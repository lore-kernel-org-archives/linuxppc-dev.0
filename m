Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-3.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 19EDFDDDFF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 06:11:26 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
References: <20090203164930.GA10101@mtls03> <ada8wonnh3t.fsf@cisco.com>
	<1233712248.16867.131.camel@pasglop>
	<20090203211329.d6190a08.akpm@linux-foundation.org>
	<aday6wmn2vr.fsf@cisco.com>
	<20090203222601.747ca8b7.akpm@linux-foundation.org>
Date: Wed, 04 Feb 2009 11:11:22 -0800
In-Reply-To: <20090203222601.747ca8b7.akpm@linux-foundation.org> (Andrew
	Morton's message of "Tue, 3 Feb 2009 22:26:01 -0800")
Message-ID: <adad4dym2zp.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Eli Cohen <eli@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > >  > 	huge_page_size(page_hstate(page))

 > > That would suit.  I assume the intention is for that to be usable by
 > > driver modules on any architecture?

 > erm, you overestimate the amount of planning and forethought which goes
 > into these things ;)

 > The lack of any EXPORT_SYMBOL(size_to_hstate) is a broadish hint.

Heh.  Looking into the implementation, it seems that I could actually do

	PAGE_SIZE << compound_order(page)

directly (since there's no reason to go from size to hstate and back to
size.  I don't know all the details of these VM internals, but that
seems to only work on the first (small) page of a giant page?  Which
causes problems for what we're trying to do here...

To summarize the goal, we are mapping user memory to a device that has
its own page tables, where the device's page tables can also use
multiple page sizes.  Using big pages on the device leads to similar
efficiencies as hugetlb pages do on the CPU, and in fact if a user has
used hugetlb pages for the memory they're giving to the device, that's a
very strong hint that the device should use big pages too.

But one valid situation we have to handle in the driver is if, say,
userspace has a hugetlb mapped at virtual address 0x200000, and wants to
map 0x80000 bytes at 0x280000 to the device.  In that case, we're going
to do essentially

	get_user_pages(..., 0x280000, 0x80000 / PAGE_SIZE, ...)

and get_user_pages() is going to give us a bunch of normal PAGE_SIZE
pages starting at offset 0x800000 within the compound page that makes up
the huge page mapped at 0x200000.

get_user_pages() also gives us the vma back, and we can see from
is_vm_hugetlb_page() (-- BTW can I just say that a function
is_xxx_page() that operates on vmas is horribly misnamed --) that these
pages all come from a hugetlb mapping, but figuring out the size of that
mapping is I guess a challenge.

 - R.
