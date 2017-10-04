Return-Path: <jglisse@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6J482rZJzDqlC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 12:20:24 +1100 (AEDT)
Date: Tue, 3 Oct 2017 21:20:16 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Alistair Popple <alistair@popple.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-next@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: avoid double notification when it is
 useless
Message-ID: <20171004012016.GE20644@redhat.com>
References: <20170901173011.10745-1-jglisse@redhat.com>
 <20171003234215.GA5231@redhat.com>
 <20171004001559.GD20644@redhat.com>
 <0D64494B-AB3D-4091-B75A-883EA37BE098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0D64494B-AB3D-4091-B75A-883EA37BE098@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 03, 2017 at 05:43:47PM -0700, Nadav Amit wrote:
> Jerome Glisse <jglisse@redhat.com> wrote:
> 
> > On Wed, Oct 04, 2017 at 01:42:15AM +0200, Andrea Arcangeli wrote:
> > 
> >> I'd like some more explanation about the inner working of "that new
> >> user" as per comment above.
> >> 
> >> It would be enough to drop mmu_notifier_invalidate_range from above
> >> without adding it to the filebacked case. The above gives higher prio
> >> to the hypothetical and uncertain future case, than to the current
> >> real filebacked case that doesn't need ->invalidate_range inside the
> >> PT lock, or do you see something that might already need such
> >> ->invalidate_range?
> > 
> > No i don't see any new user today that might need such invalidate but
> > i was trying to be extra cautious as i have a tendency to assume that
> > someone might do a patch that use try_to_unmap() without going through
> > all the comments in the function and thus possibly using it in a an
> > unexpected way from mmu_notifier callback point of view. I am fine
> > with putting the burden on new user to get it right and adding an
> > extra warning in the function description to try to warn people in a
> > sensible way.
> 
> I must be missing something. After the PTE is changed, but before the
> secondary TLB notification/invalidation - What prevents another thread from
> changing the mappings (e.g., using munmap/mmap), and setting a new page
> at that PTE?
> 
> Wouldn’t it end with the page being mapped without a secondary TLB flush in
> between?

munmap would call mmu_notifier to invalidate the range too so secondary
TLB would be properly flush before any new pte can be setup in for that
particular virtual address range. Unlike CPU TLB flush, secondary TLB
flush are un-conditional and thus current pte value does not play any
role.

Cheers,
Jérôme
