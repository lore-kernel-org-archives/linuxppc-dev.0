Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A50151007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 03:36:55 +1100 (EST)
Subject: Re: [PATCH 04/13] powerpc: Update hugetlb huge_pte_alloc and
 tablewalk code for FSL BOOKE
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1322544333.23348.69.camel@pasglop>
Date: Tue, 29 Nov 2011 10:36:42 -0600
Message-Id: <9FB8A0F3-ED6C-4C4F-BB9F-87CDEB19C3C2@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
 <1322544333.23348.69.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 28, 2011, at 11:25 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2011-10-10 at 15:50 -0500, Becky Bruce wrote:
>> From: Becky Bruce <beckyb@kernel.crashing.org>
>>=20
>> This updates the hugetlb page table code to handle 64-bit FSL_BOOKE.
>> The previous 32-bit work counted on the inner levels of the page =
table
>> collapsing.
>=20
> Seriously, my brain hurts !!!

Now you know how I felt when I got the original code from David :)

>=20
> So I've tried to understand that code and so far, what I came up with =
is
> this, please reply and let me know if I'm full of crack or what ...
>=20
> - David's code has entire levels "branching off" into hugepd's which
> are hugetlb specific page dirs. That requires address space =
constrainst.

Yes.

>=20
> - The hack you do with HUGEPD_PGD_SHIFT defined to PGDIR_SHIFT and
> HUGEPD_PUD_SHIFT to PUD_SHIFT consists of collasping that back into =
the
> normal levels.

That exists so Jimi's code for A2 and mine can coexist peacefully =
without ifdeffing huge blocks because we peel off the page table at =
different points for a hugepd.  In my case, if I have a 4M page, that is =
handled by having 2 entries at the 2M layer, each of which is a pointer =
to the same pte stored in a kmem_cache created for that purpose.  In the =
server/A2 case, they peel off at the layer above 4M and have a sub-table =
kmem_cache that has a bunch of same-size huge page ptes (this is all =
because of the slice constraint).

>=20
> - I really don't understand what you are doing in __hugepte_alloc(). =
It
> seems to me that you are trying to make things still point to some =
kind
> of separate hugepd dir with the hugeptes in it and have the page =
tables
> point to that but I don't quite get it.

In your example below, the alloc code is:
1) allocating a small kmem_cache for the pte

2) filling in 8 entries at the 2M level with the pointers to that pte, =
with the upper bit munged to indicate huge and bits in the lower region =
that store the huge page size because it can't be encoded in the book3e =
pte format

>=20
> - Couldn't we just instead ditch the whole hugepd concept alltogether
> and simply have the huge ptes in the page table at the right level,
> using possibly multiple consecutive of them for a single page when
> needed ?
>=20
> Example: 4K base page size. PMD maps 2M. a 16M page could be
> representing by having 8 consecutive hugeptes pointing to the same =
huge
> page in the PMD directory.

We currently have 8 consecutive PMD entries that are pointers to the =
same kmem_cache that holds the actual PTE.  I did this for a few =
reasons:

1) I was trying to stay as close to what David had done as possible

2) symmetry - in every other case entries at higher levels of the normal =
page table are pointers to something, and it's easy to identify that =
something is a pointer to hugepte using David's upper-bit-flipping =
trick.  If we have an actual entry mixed in with the pointers it might =
be hard to tell that's it's an actual PTE and not a pointer without =
getting information from somewhere else (i.e. the vma)

3) I was trying to avoid having multiple copies of the actual pte - this =
way it's easy to do stuff like change the perms on the PTE, since I only =
have to modify one copy

4) I needed the information laid out for quick TLB miss fault-handling =
of hugepte tlb misses (see below).

>=20
> I believe we always "know" when accessing a PTE whether it's going to =
be
> huge or not and if it's huge, the page size. IE. All the functions we
> care about either get the vma (which gets you everything you need) or
> the size (huge_pte_alloc).

An exception is the 32-bit fault hander asm code.  It does a walk of the =
page table to reload the tlb.  We need to be able to easily identify =
that we're walking into a hugepage area so we know to load the tlbcam.  =
Having the pointer there with the munged upper bit that David devised is =
very convenient for that.  Also, the Book3e page table format does not =
allow us to represent page sizes > 32m.  So that's encoded in the hugepd =
instead (and not in the pte).

I'm not sure how to get around this without slowing things down.  I =
originally had a slower handler and it turned out to impact performance =
of several important workloads and my perf guys griped at me. I was =
actually eventually planning to rewrite the 64b fsl book3e handler to =
deal with this in asm as well.   Large workloads on our systems do a lot =
of tlbcam entry replacement due to 1) the small size of the tlbcam and =
2) the lack of any hardware replacement policy on that array.

There are other places where we'd have to modify the code to have the =
vma available (not that it's hard to do, but it's not floating around =
everywhere).  And there may be other places where this is an issue - I'd =
have to go dig around a bit to answer that.

For the record, I hate the idea of not being able to walk the page table =
without going elsewhere for information.  IMHO I should be able to tell =
everything I need to load a TLB entry from there without digging up a =
vma.

>=20
> This should be much simpler than what we have today.
>=20
> That way, we have a completely generic accross-the-board way to store
> huge pte's in our page tables, which is totally disconnected from the
> slices. The later remains a purely server-only thing which only =
affects
> the SLB code and get_unmapped_area().

David and Jimi will have to comment about whether they can flatten out =
their stuff to just store PTEs.  A lot of my code exists because I was =
attempting to be as close to the IBM implementation as possible.

>=20
> That means that we'll have to find another option for PowerEN giant
> indirects but that's a non issue at the moment. I think we can keep =
the
> complexity local to the PowerEN code by doing shadows there if we need
> to.
>=20
> What do you think ?

I'm happy if we can come up with another solution that still allows me =
to do my miss fault handling efficiently in asm.... What we do on FSL =
Booke with storing multiple pointers to a single pte is actually a =
fairly clean solution given the constraints.  It's only in the context =
of having a different implementation coexisting with it that makes =
things start getting complicated.  If you have some suggestions on =
another way to deal with this, I'm all ears.

Cheers,
B
