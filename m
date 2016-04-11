Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk0750L1ZzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:10:56 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 11 Apr 2016 11:40:55 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3B6Apnp6226288
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 11:40:51 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3B6Ahsc009363
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 11:40:47 +0530
Message-ID: <570B3FDB.90305@linux.vnet.ibm.com>
Date: Mon, 11 Apr 2016 11:40:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: hughd@google.com, dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com,
 kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 mgorman@techsingularity.net, akpm@linux-foundation.org
Subject: Re: [PATCH 02/10] mm/hugetlb: Add PGD based implementation awareness
References: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1460007464-26726-3-git-send-email-khandual@linux.vnet.ibm.com>
 <570622B4.5020407@gmail.com> <570B3531.2000808@linux.vnet.ibm.com>
In-Reply-To: <570B3531.2000808@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2016 10:55 AM, Anshuman Khandual wrote:
> On 04/07/2016 02:34 PM, Balbir Singh wrote:
>> > 
>> > 
>> > On 07/04/16 15:37, Anshuman Khandual wrote:
>>> >> Currently the config ARCH_WANT_GENERAL_HUGETLB enabled functions like
>>> >> 'huge_pte_alloc' and 'huge_pte_offset' dont take into account HugeTLB
>>> >> page implementation at the PGD level. This is also true for functions
>>> >> like 'follow_page_mask' which is called from move_pages() system call.
>>> >> This lack of PGD level huge page support prohibits some architectures
>>> >> to use these generic HugeTLB functions.
>>> >>
>> > 
>> > From what I know of move_pages(), it will always call follow_page_mask()
>> > with FOLL_GET (I could be wrong here) and the implementation below
>> > returns NULL for follow_huge_pgd().
> You are right. This patch makes ARCH_WANT_GENERAL_HUGETLB functions aware
> of PGD implementation so that we can do all transactions on 16GB pages
> using these function instead of the present arch overrides. But that also
> requires follow_page_mask() changes for every other access to the page
> than the migrate_pages() usage.
> 
> But yes, we dont support migrate_pages() on PGD based pages yet, hence
> it just returns NULL in that case. May be the commit message needs to
> reflect this.

The next commit actually changes follow_huge_pud|pgd() functions to
support FOLL_GET and PGD based huge page migration.
