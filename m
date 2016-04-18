Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpMCJ286yzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 18:44:44 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 14:14:42 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3I8ibMn20709880
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:14:37 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3I8iXDs028870
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:14:39 +0530
Message-ID: <57149E68.5020207@linux.vnet.ibm.com>
Date: Mon, 18 Apr 2016 14:14:24 +0530
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
References: <201604071717.fjhqVZh6%fengguang.wu@intel.com>
In-Reply-To: <201604071717.fjhqVZh6%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/2016 02:46 PM, kbuild test robot wrote:
> Hi Anshuman,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.6-rc2 next-20160407]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/Enable-HugeTLB-page-migration-on-POWER/20160407-165841
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: sparc64-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    mm/hugetlb.c: In function 'follow_huge_pgd':
>>> >> mm/hugetlb.c:4395:3: error: implicit declaration of function 'pgd_page' [-Werror=implicit-function-declaration]
>       page = pgd_page(*pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
>       ^


The following change seems to fix the build problem on SPARC but will
require some inputs from SPARC maintainers regarding the functional
correctness of the patch.

diff --git a/arch/sparc/include/asm/pgtable_64.h
b/arch/sparc/include/asm/pgtable_64.h
index f089cfa..7b7e6a0 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -804,6 +804,7 @@ static inline unsigned long __pmd_page(pmd_t pmd)
 #define pmd_clear(pmdp)                        (pmd_val(*(pmdp)) = 0UL)
 #define pud_present(pud)               (pud_val(pud) != 0U)
 #define pud_clear(pudp)                        (pud_val(*(pudp)) = 0UL)
+#define pgd_page(pgd)                  (pgd_val(pgd))
 #define pgd_page_vaddr(pgd)            \
        ((unsigned long) __va(pgd_val(pgd)))
 #define pgd_present(pgd)               (pgd_val(pgd) != 0U)
