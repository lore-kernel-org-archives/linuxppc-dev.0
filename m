Return-Path: <hughd@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E27E31A05B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 08:08:06 +1100 (AEDT)
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ED963140662
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 08:08:05 +1100 (AEDT)
Received: by mail-pf0-x22a.google.com with SMTP id x65so118468002pfb.1
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 13:08:05 -0800 (PST)
Date: Tue, 23 Feb 2016 13:07:53 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: Question on follow_page_mask
In-Reply-To: <20160223140349.GA21820@node.shutemov.name>
Message-ID: <alpine.LSU.2.11.1602231230010.3043@eggly.anvils>
References: <56CC5B59.4030902@linux.vnet.ibm.com>
 <20160223140349.GA21820@node.shutemov.name>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 23 Feb 2016, Kirill A. Shutemov wrote:
> On Tue, Feb 23, 2016 at 06:45:05PM +0530, Anshuman Khandual wrote:
> > Not able to understand the first code block of follow_page_mask
> > function. follow_huge_addr function is expected to find the page
> > struct for the given address if it turns out to be a HugeTLB page
> > but then when it finds the page we bug on if it had been called
> > with FOLL_GET flag.
> > 
> > 	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
> > 	if (!IS_ERR(page)) {
> > 		BUG_ON(flags & FOLL_GET);
> > 		return page;
> > 	}
> > 
> > do_move_page_to_node_array calls follow_page with FOLL_GET which
> > in turn calls follow_page_mask with FOLL_GET. On POWER, the
> > function follow_huge_addr is defined and does not return -EINVAL
> > like the generic one. It returns the page struct if its a HugeTLB
> > page. Just curious to know what is the purpose behind the BUG_ON.
> 
> I would guess requesting pin on non-reclaimable page is considered
> useless, meaning suspicius behavior. BUG_ON() is overkill, I think.
> WARN_ON_ONCE() would make it.

No, it's there to guard against abuse, until the correct functionality
is implemented: which has not so far been required, I think.

The problem is that a get_page() here is too late: it needs to be done
inside each arch's implementation of follow_huge_addr(), while holding
whatever is the appropriate lock, dropped by the time it returns here.

If you look through where FOLL_GET is usually implemented, such as in
follow_page_pte(), but pud and pmd cases too, I hope you'll still find
that they are careful to get the reference on the page while it's safe
in the pagetable.

But follow_huge_addr() would need some work to offer the same guarantees:
it's good for those "peep at a page without actually getting a reference"
cases, but not good enough for preventing a page for being put to some
other use completely, before we've secured it with our reference.

Unless something's changed: the last time I recall the issue coming up,
was when Naoya Horiguchi was working on hugetlbfs page migration: see
linux-kernel/linux-mm mail thread "BUG at mm/memory.c:1489!" from
28 May 2014; and the resolution there was not to support the
follow_huge_addr() case (which IIRC is peculiar to powerpc alone?).

Hugh
