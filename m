Return-Path: <lkp@intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415sxR0lgszDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 15:43:51 +1000 (AEST)
Date: Thu, 14 Jun 2018 13:43:26 +0800
From: kbuild test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc/64s/radix: Fix MADV_[FREE|DONTNEED] TLB flush
 miss problem with THP
Message-ID: <201806141305.sE7OFr9f%fengguang.wu@intel.com>
References: <20180614032256.5440-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
In-Reply-To: <20180614032256.5440-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on next-20180613]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-64s-radix-Fix-MADV_-FREE-DONTNEED-TLB-flush-miss-problem-with-THP/20180614-114728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: arm-allnoconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/mm.h:478:0,
                    from include/linux/memcontrol.h:29,
                    from include/linux/swap.h:9,
                    from mm/compaction.c:12:
   include/linux/migrate.h: In function 'new_page_nodemask':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
   include/linux/huge_mm.h:82:25: note: each undeclared identifier is reported only once for each function it appears in
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
--
   In file included from include/linux/mm.h:478:0,
                    from include/linux/dax.h:6,
                    from mm/filemap.c:14:
   mm/filemap.c: In function 'page_cache_free_page':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:80:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
    #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                             ^~~~~~~~~~~~~~~
>> mm/filemap.c:279:22: note: in expansion of macro 'HPAGE_PMD_NR'
      page_ref_sub(page, HPAGE_PMD_NR);
                         ^~~~~~~~~~~~
   include/linux/huge_mm.h:82:25: note: each undeclared identifier is reported only once for each function it appears in
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:80:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
    #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                             ^~~~~~~~~~~~~~~
>> mm/filemap.c:279:22: note: in expansion of macro 'HPAGE_PMD_NR'
      page_ref_sub(page, HPAGE_PMD_NR);
                         ^~~~~~~~~~~~
   mm/filemap.c: In function 'page_cache_tree_delete_batch':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:80:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
    #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                             ^~~~~~~~~~~~~~~
   mm/filemap.c:351:18: note: in expansion of macro 'HPAGE_PMD_NR'
        tail_pages = HPAGE_PMD_NR - 1;
                     ^~~~~~~~~~~~
--
   In file included from include/linux/mm.h:478:0,
                    from include/linux/dax.h:6,
                    from mm/truncate.c:12:
   mm/truncate.c: In function 'truncate_cleanup_page':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:80:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
    #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                             ^~~~~~~~~~~~~~~
>> mm/truncate.c:182:38: note: in expansion of macro 'HPAGE_PMD_NR'
      pgoff_t nr = PageTransHuge(page) ? HPAGE_PMD_NR : 1;
                                         ^~~~~~~~~~~~
   include/linux/huge_mm.h:82:25: note: each undeclared identifier is reported only once for each function it appears in
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:80:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
    #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                             ^~~~~~~~~~~~~~~
>> mm/truncate.c:182:38: note: in expansion of macro 'HPAGE_PMD_NR'
      pgoff_t nr = PageTransHuge(page) ? HPAGE_PMD_NR : 1;
                                         ^~~~~~~~~~~~
   mm/truncate.c: In function 'invalidate_mapping_pages':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:80:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
    #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                             ^~~~~~~~~~~~~~~
   mm/truncate.c:580:14: note: in expansion of macro 'HPAGE_PMD_NR'
        index += HPAGE_PMD_NR - 1;
                 ^~~~~~~~~~~~
--
   In file included from include/linux/mm.h:478:0,
                    from mm/vmscan.c:17:
   include/linux/migrate.h: In function 'new_page_nodemask':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
   include/linux/huge_mm.h:82:25: note: each undeclared identifier is reported only once for each function it appears in
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/migrate.h:47:11: note: in expansion of macro 'HPAGE_PMD_ORDER'
      order = HPAGE_PMD_ORDER;
              ^~~~~~~~~~~~~~~
   mm/vmscan.c: In function 'is_page_cache_freeable':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:80:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
    #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                             ^~~~~~~~~~~~~~~
>> mm/vmscan.c:579:3: note: in expansion of macro 'HPAGE_PMD_NR'
      HPAGE_PMD_NR : 1;
      ^~~~~~~~~~~~
   mm/vmscan.c: In function '__remove_mapping':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
>> include/linux/huge_mm.h:79:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                             ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:80:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
    #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                             ^~~~~~~~~~~~~~~
   mm/vmscan.c:742:18: note: in expansion of macro 'HPAGE_PMD_NR'
      refcount = 1 + HPAGE_PMD_NR;
                     ^~~~~~~~~~~~
--
   In file included from include/linux/mm.h:478:0,
                    from include/linux/pagemap.h:8,
                    from mm/shmem.c:29:
   mm/shmem.c: In function 'shmem_zero_setup':
>> include/linux/huge_mm.h:82:25: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
   include/linux/huge_mm.h:83:34: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_SIZE ((1UL) << HPAGE_PMD_SHIFT)
                                     ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:84:27: note: in expansion of macro 'HPAGE_PMD_SIZE'
    #define HPAGE_PMD_MASK (~(HPAGE_PMD_SIZE - 1))
                              ^~~~~~~~~~~~~~
>> mm/shmem.c:4322:23: note: in expansion of macro 'HPAGE_PMD_MASK'
       ((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
                          ^~~~~~~~~~~~~~
   include/linux/huge_mm.h:82:25: note: each undeclared identifier is reported only once for each function it appears in
    #define HPAGE_PMD_SHIFT PMD_SHIFT
                            ^
   include/linux/huge_mm.h:83:34: note: in expansion of macro 'HPAGE_PMD_SHIFT'
    #define HPAGE_PMD_SIZE ((1UL) << HPAGE_PMD_SHIFT)
                                     ^~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:84:27: note: in expansion of macro 'HPAGE_PMD_SIZE'
    #define HPAGE_PMD_MASK (~(HPAGE_PMD_SIZE - 1))
                              ^~~~~~~~~~~~~~
>> mm/shmem.c:4322:23: note: in expansion of macro 'HPAGE_PMD_MASK'
       ((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
                          ^~~~~~~~~~~~~~

vim +82 include/linux/huge_mm.h

5a6e75f8 Kirill A. Shutemov 2016-07-26  78  
d8c37c48 Naoya Horiguchi    2012-03-21 @79  #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
d8c37c48 Naoya Horiguchi    2012-03-21 @80  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
d8c37c48 Naoya Horiguchi    2012-03-21  81  
fde52796 Aneesh Kumar K.V   2013-06-05 @82  #define HPAGE_PMD_SHIFT PMD_SHIFT
fde52796 Aneesh Kumar K.V   2013-06-05  83  #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
fde52796 Aneesh Kumar K.V   2013-06-05 @84  #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
71e3aac0 Andrea Arcangeli   2011-01-13  85  

:::::: The code at line 82 was first introduced by commit
:::::: fde52796d487b675cde55427e3347ff3e59f9a7f mm/THP: don't use HPAGE_SHIFT in transparent hugepage code

:::::: TO: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--BXVAT5kNtrzKuDFl--
