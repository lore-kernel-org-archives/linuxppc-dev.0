Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk00h59MKzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:05:24 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 11 Apr 2016 16:05:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3CACD2CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:04:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3B64n0L41025724
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:04:57 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3B64O36004017
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:04:25 +1000
Message-ID: <570B3E51.2090308@linux.vnet.ibm.com>
Date: Mon, 11 Apr 2016 11:34:01 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kbuild test robot <lkp@intel.com>
CC: dave.hansen@intel.com, mgorman@techsingularity.net, hughd@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kbuild-all@01.org,
 kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 03/10] mm/hugetlb: Protect follow_huge_(pud|pgd) functions
 from race
References: <201604071708.osnfXWQP%fengguang.wu@intel.com>
In-Reply-To: <201604071708.osnfXWQP%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/2016 03:04 PM, kbuild test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    mm/hugetlb.c: In function 'follow_huge_pud':
>>> >> mm/hugetlb.c:4360:3: error: implicit declaration of function 'pud_page' [-Werror=implicit-function-declaration]
>       page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
>       ^
>    mm/hugetlb.c:4360:8: warning: assignment makes pointer from integer without a cast
>       page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
>            ^
>    mm/hugetlb.c: In function 'follow_huge_pgd':
>    mm/hugetlb.c:4395:3: error: implicit declaration of function 'pgd_page' [-Werror=implicit-function-declaration]
>       page = pgd_page(*pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);

Both the build errors here are because of the fact that pgd_page() is
not available for some platforms and config options. It got missed as
I ran only powerpc config options for build test purpose. My bad, will
fix it.
