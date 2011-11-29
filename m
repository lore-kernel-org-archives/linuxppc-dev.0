Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 697BA1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 16:25:44 +1100 (EST)
Message-ID: <1322544333.23348.69.camel@pasglop>
Subject: Re: [PATCH 04/13] powerpc: Update hugetlb huge_pte_alloc and
 tablewalk code for FSL BOOKE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Date: Tue, 29 Nov 2011 16:25:33 +1100
In-Reply-To: <1318279870278-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-10-10 at 15:50 -0500, Becky Bruce wrote:
> From: Becky Bruce <beckyb@kernel.crashing.org>
> 
> This updates the hugetlb page table code to handle 64-bit FSL_BOOKE.
> The previous 32-bit work counted on the inner levels of the page table
> collapsing.

Seriously, my brain hurts !!!

So I've tried to understand that code and so far, what I came up with is
this, please reply and let me know if I'm full of crack or what ...

 - David's code has entire levels "branching off" into hugepd's which
are hugetlb specific page dirs. That requires address space constrainst.

 - The hack you do with HUGEPD_PGD_SHIFT defined to PGDIR_SHIFT and
HUGEPD_PUD_SHIFT to PUD_SHIFT consists of collasping that back into the
normal levels.

 - I really don't understand what you are doing in __hugepte_alloc(). It
seems to me that you are trying to make things still point to some kind
of separate hugepd dir with the hugeptes in it and have the page tables
point to that but I don't quite get it.

 - Couldn't we just instead ditch the whole hugepd concept alltogether
and simply have the huge ptes in the page table at the right level,
using possibly multiple consecutive of them for a single page when
needed ?

Example: 4K base page size. PMD maps 2M. a 16M page could be
representing by having 8 consecutive hugeptes pointing to the same huge
page in the PMD directory.

I believe we always "know" when accessing a PTE whether it's going to be
huge or not and if it's huge, the page size. IE. All the functions we
care about either get the vma (which gets you everything you need) or
the size (huge_pte_alloc).

This should be much simpler than what we have today.

That way, we have a completely generic accross-the-board way to store
huge pte's in our page tables, which is totally disconnected from the
slices. The later remains a purely server-only thing which only affects
the SLB code and get_unmapped_area().

That means that we'll have to find another option for PowerEN giant
indirects but that's a non issue at the moment. I think we can keep the
complexity local to the PowerEN code by doing shadows there if we need
to.

What do you think ?

Ben.
