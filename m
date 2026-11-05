Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F9606D833
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RmninhDk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL1TJ3v2Gz2xqh;
	Thu, 05 Nov 2026 23:14:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793880884;
	cv=none; b=SzFOvoxIoxmjqmBDaXxQ/N4zAT2EOyNUjrnlQw/JcFhByFyHykmqlitBDxIw73y49vcY+1nPRldPQXcPQXXudI8q/8jWQCUrYQhbgSfD9YP/zMzjN4EPYm1pOFzDpJgfLB2yYsTtVkcu6H8kP0UMmb4N+KeO9zaFHkYDd/ZLRDCEHMQKW/FCxSEV9QS3y5qqC4rLtQ988VYF+cR4aYwHO6NUgLGtYYkpWfj/1TnlK+XZoCIM9X7F5q/QpfepR6rhKqOR4bJmsn6zI/k3SJBj8N8TEovIyiwKfjW+1ttaLuNIC+MiHYChOxZPzDklHJsJAVBgcQKt/93lCQRP9qQzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793880884; c=relaxed/relaxed;
	bh=cRwA5sbmlFTv4dr/TsrihpefpRsTJ7E+PJDAiAJhZlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5d01oadv2tHpMb4UZUeI0qcWj4KMDAXB/gaD2clV/5dsGro0Ef/X/j6mxyQvC3q277ycGkj7l1rL8dVxIqQrvl5w0QKiIY/aRyiRu2E+dHuVPN6vR8pZ30C7IgL2VhuN/20dmWxtlO6Si6yVvWvBauZ/Qt8mj5QeyFa9WFiM2+9M604wnbRDKXdisFcfOKtygpoNtUHfFtd5Au4aHbWEL9YcVGE7W6gv4y5lwK0Szy2BUgUiv6arZfdvzeffSG4L8rwzDCd3bMXgEYuk9qdaWUnO1LdCEY2cWS/vvMruaaWPTXxzRVgZuNJSPx4JMjKeQGaWWgsySpK/ajuHI7mMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RmninhDk; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RmninhDk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL1TG42RKz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 23:14:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793880882; x=1825416882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hNZG3p/TmBT75mwn4JDU6B5IEwPzDkrT+siPwGcILcw=;
  b=RmninhDkjzvKTUhcAAm0/19OixccdVl2M1YMcot6V+BQcl+dSsLryYDd
   sRdRCSxPY06Qd6vj7Xclc2Zij7vaahYSYcLHLi3guoQMpq3DjzhtBJ494
   gAVZjIrIazfx1SccxU8IBTjfOkhxH/J7xPtW4Ld4w2O63556TJdU2Q18i
   7LJAKfLzX04LgiwGyRiM2FL7J91cvEczwYiPQHlxu7TuIdcwJDF3q9Eil
   1jPpwDKvlsdhRsswczgZSVkIXGICxxHL5YMHCmHPot+cWo7V1RFR8XL/3
   H+B6hJWqwa1fPrwYRQnE00eO1H4+j7hcfA53CIrB7MV0GAB+p5sveRoGn
   w==;
X-CSE-ConnectionGUID: v0SQMek5RTeNWLVQwQDFeg==
X-CSE-MsgGUID: rwokDq53T4e6DPdqvExC+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2659742"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2659742"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 04:14:38 -0800
X-CSE-ConnectionGUID: n1CgJxqsSv2cC6PyZtAf1Q==
X-CSE-MsgGUID: PaUjo+ZjS1y3BQJZcClOSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7401165"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Nov 2026 04:14:33 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOwMP-00000000mAX-3Cl8;
	Thu, 05 Nov 2026 12:14:29 +0000
Date: Thu, 5 Nov 2026 20:13:50 +0800
From: kernel test robot <lkp@intel.com>
To: Muchun Song <songmuchun@bytedance.com>,
	David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Message-ID: <202611052055.TcIXFI7V-lkp@intel.com>
References: <20261105061217.13302-3-songmuchun@bytedance.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105061217.13302-3-songmuchun@bytedance.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Muchun,

kernel test robot noticed the following build errors:

[auto build test ERROR on dba8aba0a9a00ff781c03d82ae534fc6f8c2e263]

url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/powerpc-mm-make-vmemmap_populate_compound_pages-static/20261105-141213
base:   dba8aba0a9a00ff781c03d82ae534fc6f8c2e263
patch link:    https://lore.kernel.org/r/20261105061217.13302-3-songmuchun%40bytedance.com
patch subject: [PATCH v2 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20261105/202611052055.TcIXFI7V-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052055.TcIXFI7V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052055.TcIXFI7V-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:31:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/loongarch/include/asm/pgtable.h:75:
   include/linux/vmemmap-optimization.h:62:9: error: call to undeclared function 'vmemmap_optimizable_order'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      62 |         return vmemmap_optimizable_order(section_compound_order(section));
         |                ^
>> include/linux/vmemmap-optimization.h:68:22: error: use of undeclared identifier 'vmemmap'; did you mean 'mem_map'?
      68 |         unsigned long pfn = page_to_pfn((struct page *)start);
         |                             ^
   include/asm-generic/memory_model.h:73:21: note: expanded from macro 'page_to_pfn'
      73 | #define page_to_pfn __page_to_pfn
         |                     ^
   include/asm-generic/memory_model.h:47:54: note: expanded from macro '__page_to_pfn'
      47 | #define __page_to_pfn(page)     (unsigned long)((page) - vmemmap)
         |                                                          ^
   include/linux/mmzone.h:1452:21: note: 'mem_map' declared here
    1452 | extern struct page *mem_map;
         |                     ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:31:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/loongarch/include/asm/pgtable.h:75:
   include/linux/vmemmap-optimization.h:138:20: error: conflicting types for 'vmemmap_optimizable_order'
     138 | static inline bool vmemmap_optimizable_order(unsigned int order)
         |                    ^
   include/linux/vmemmap-optimization.h:62:9: note: previous implicit declaration is here
      62 |         return vmemmap_optimizable_order(section_compound_order(section));
         |                ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];


vim +68 include/linux/vmemmap-optimization.h

    64	
    65	static inline void section_vmemmap_optimization_disable(unsigned long start,
    66			unsigned long end)
    67	{
  > 68		unsigned long pfn = page_to_pfn((struct page *)start);
    69		unsigned long nr_pages = (end - start) / sizeof(struct page);
    70		struct mem_section *section = __pfn_to_section(pfn);
    71	
    72		if (nr_pages < PAGES_PER_SECTION) {
    73			VM_WARN_ON_ONCE(section_vmemmap_optimizable(section));
    74			return;
    75		}
    76	
    77		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
    78		section_set_compound_order(section, 0);
    79	}
    80	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

