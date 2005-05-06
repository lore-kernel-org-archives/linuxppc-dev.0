Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98401679E8
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 08:49:23 +1000 (EST)
In-Reply-To: <20050506133858.GA6032@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 6 May 2005 18:49:11 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 6, 2005, at 9:38 AM, Marcelo Tosatti wrote:

> 1) avoids the creation of pte tables in the 8Mbyte range, thus 
> preserving
> the pinned TLB entry.

This has nothing to do with "preserving" the pinned TLB entry.
The pinned entries are placed into the reserved portion of the TLB,
and are never evicted.  We never get a fault on these pages, so we
never look up an entry in the page table.  We need to create the
page tables for informational purposes, so software or debugger
lookups will do the right thing.


> 2) restricts bootmem to above 8Mbyte region

Why is this necessary?

> 3) Memory for DMA pages must not be in the pinned region. ie. drivers
> should not allocate memory directly for DMA purposes.

Why not?  It doesn't matter if we cover a VM space with a bunch of 4K
entries or a single 8M entry.   The physical pages are always going to
be multiple mapped, either through the mapin_ram() space or a single 8M
entry, and also through the vmalloc() space.  You just have to ensure,
in any case, that you don't access the pages through both VM spaces.

> Dan, I would really enjoy having access to some of your precious 8xx
> knowledge: share it, along with the correct way to fix this and the
> other pending issues.

The correct fix is rather simple, just make sure you configure the TLB
to reserve entries, and get the pinned entries into those reserved
entries.  I know I had it right once, I don't know what happened :-)

Just hang on and I'll get you some code to test ....

Thanks.


	-- Dan
