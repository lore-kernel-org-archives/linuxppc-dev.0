Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 752581A035C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 22:46:04 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 273EA140325
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 22:46:04 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 24 Feb 2016 21:46:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 652A62BB0045
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 22:45:58 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1OBjoLh5833004
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 22:45:58 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1OBjOf0002630
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 22:45:26 +1100
Message-ID: <56CD97C3.6080407@linux.vnet.ibm.com>
Date: Wed, 24 Feb 2016 17:15:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Hugh Dickins <hughd@google.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
CC: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 kirill.shutemov@linux.intel.com
Subject: Re: Question on follow_page_mask
References: <56CC5B59.4030902@linux.vnet.ibm.com>
 <20160223140349.GA21820@node.shutemov.name>
 <alpine.LSU.2.11.1602231230010.3043@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1602231230010.3043@eggly.anvils>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2016 02:37 AM, Hugh Dickins via Linuxppc-dev wrote:
> On Tue, 23 Feb 2016, Kirill A. Shutemov wrote:
>> On Tue, Feb 23, 2016 at 06:45:05PM +0530, Anshuman Khandual wrote:
>>> Not able to understand the first code block of follow_page_mask
>>> function. follow_huge_addr function is expected to find the page
>>> struct for the given address if it turns out to be a HugeTLB page
>>> but then when it finds the page we bug on if it had been called
>>> with FOLL_GET flag.
>>>
>>> 	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
>>> 	if (!IS_ERR(page)) {
>>> 		BUG_ON(flags & FOLL_GET);
>>> 		return page;
>>> 	}
>>>
>>> do_move_page_to_node_array calls follow_page with FOLL_GET which
>>> in turn calls follow_page_mask with FOLL_GET. On POWER, the
>>> function follow_huge_addr is defined and does not return -EINVAL
>>> like the generic one. It returns the page struct if its a HugeTLB
>>> page. Just curious to know what is the purpose behind the BUG_ON.
>>
>> I would guess requesting pin on non-reclaimable page is considered
>> useless, meaning suspicius behavior. BUG_ON() is overkill, I think.
>> WARN_ON_ONCE() would make it.

Hugh, thanks for such a detailed response.

> 
> No, it's there to guard against abuse, until the correct functionality
> is implemented: which has not so far been required, I think.
> 
> The problem is that a get_page() here is too late: it needs to be done
> inside each arch's implementation of follow_huge_addr(), while holding
> whatever is the appropriate lock, dropped by the time it returns here.

Got it.

> 
> If you look through where FOLL_GET is usually implemented, such as in
> follow_page_pte(), but pud and pmd cases too, I hope you'll still find
> that they are careful to get the reference on the page while it's safe
> in the pagetable.

yeah, true.

> 
> But follow_huge_addr() would need some work to offer the same guarantees:
> it's good for those "peep at a page without actually getting a reference"
> cases, but not good enough for preventing a page for being put to some
> other use completely, before we've secured it with our reference.

Yeah, I understand that now.

> 
> Unless something's changed: the last time I recall the issue coming up,
> was when Naoya Horiguchi was working on hugetlbfs page migration: see
> linux-kernel/linux-mm mail thread "BUG at mm/memory.c:1489!" from
> 28 May 2014; and the resolution there was not to support the
> follow_huge_addr() case (which IIRC is peculiar to powerpc alone?).

Yeah correct, looked into that discussion. Also tried out the discussed
small patch where we do a get_page(page) if the returned page is a head
of a HugeTLB compound page and the flag contains FOLL_GET.

That made the do_move_page_to_node_array function work before hitting a
race condition with the test case in the commit message of e66f17ff7177
("mm/hugetlb: take page table lock in follow_huge_pmd()").

I believe the test exposes the locking problem which is not being taken
care at the follow_huge_addr function level right now on powerpc and
forces it to call follow_huge_pmd (which does a BUG_ON() on powerpc)
after failing to detect a huge page at the PMD level when it checked
the first time around.
