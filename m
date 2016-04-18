Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpM8f2ylJzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 18:42:26 +1000 (AEST)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 14:12:24 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3I8gLSk14942344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:12:21 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IEAMV4030859
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 19:40:25 +0530
Message-ID: <57149DE9.9060600@linux.vnet.ibm.com>
Date: Mon, 18 Apr 2016 14:12:17 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kbuild test robot <lkp@intel.com>
CC: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, hughd@google.com,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com, kbuild-all@01.org,
 kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 mgorman@techsingularity.net, akpm@linux-foundation.org,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 03/10] mm/hugetlb: Protect follow_huge_(pud|pgd) functions
 from race
References: <201604071708.osnfXWQP%fengguang.wu@intel.com>
 <570B3E51.2090308@linux.vnet.ibm.com>
In-Reply-To: <570B3E51.2090308@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2016 11:34 AM, Anshuman Khandual wrote:
> On 04/07/2016 03:04 PM, kbuild test robot wrote:
>> > All errors (new ones prefixed by >>):
>> > 
>> >    mm/hugetlb.c: In function 'follow_huge_pud':
>>>>>> >>> >> mm/hugetlb.c:4360:3: error: implicit declaration of function 'pud_page' [-Werror=implicit-function-declaration]
>> >       page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
>> >       ^
>> >    mm/hugetlb.c:4360:8: warning: assignment makes pointer from integer without a cast
>> >       page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
>> >            ^
>> >    mm/hugetlb.c: In function 'follow_huge_pgd':
>> >    mm/hugetlb.c:4395:3: error: implicit declaration of function 'pgd_page' [-Werror=implicit-function-declaration]
>> >       page = pgd_page(*pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> Both the build errors here are because of the fact that pgd_page() is
> not available for some platforms and config options. It got missed as
> I ran only powerpc config options for build test purpose. My bad, will
> fix it.

The following change seems to fix the build problem on S390 but will
require some inputs from S390 maintainers regarding the functional
correctness of the patch.

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2f66645..834a8a6 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -963,6 +963,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 #define pte_page(x) pfn_to_page(pte_pfn(x))
 
 #define pmd_page(pmd) pfn_to_page(pmd_pfn(pmd))
+#define pud_page(pud) pud_val(pud)
+#define pgd_page(pgd) pgd_val(pgd)
