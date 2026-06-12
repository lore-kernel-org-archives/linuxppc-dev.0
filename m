Return-Path: <linuxppc-dev+bounces-22548-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5EBCD98D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 05:46:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc7n75rh6z2ySC;
	Fri, 12 Jun 2026 15:46:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781243211;
	cv=none; b=MpPTEejmiGE++Cpj8IaoPgXmjrSxHQvtXKSkKyHnca8ndFcD09ZpJimIDX8LbzKdZsQTvuQFRyB7UkjL8p5h1IEhpExPypbl5r8zxqrpP4GbpBt/hUGCF5uz1EUDJTT0NyWW1g9Ch8/IvHFRp5ublwKr0+mCka8/4iTAWrtQDSBslBT7XzPx7dTQ6xVxs30PZn4mfzITDbPQ8SYiyCukcZcP9BZPurlA0aCje9ksSFhAsqWiB9IUfhz5i/XT9fk138ZVWLhpPhD5qfNuK8TjAm/4y3mHggfMMBXMr4mEkoJAaGHs3U0h8FtKJiYpc1SYdWuWguwkBkwnzRwkLhs+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781243211; c=relaxed/relaxed;
	bh=hEYCBzKX2lEOvbEUmYJVEOAf7Iv5VMqw5VJMJRMHmGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zmp4BLVbmFkkYTbMgqmTZ5RiLW6l1WPGUfNKls4fFI+uw7D5oAKJz07IoecnierCufAZNiBmLLTz271hKqOUvavuv5PAHiCNHMhFOP4iZw5tjVXB33Mvm2a/Q3KRzNlJOKhkXlW7lpAFhzTyUaHCLFLZ5/AUhx/H5OfMqGuGVip1uPgwcDpzHr8zRFL/NXZYQEObvfBNeO9snKEMgTcHYGqWzVQRqdLKkukh7IwdUY2LlPWHjkNaD57uMMDo+2SCryVIXqq7ldOjV5nI/gPSXMeTFC6iEPFCN9aMxZIAxYWBzT2+E1YOQo2rrI1OWxyviX3CXlT/Jai08ZE9qT/2uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kqub8l60; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kqub8l60;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc7n33ydPz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 15:46:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781243208; x=1812779208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KaA366UF8HyTXkjqDa9pvzv1rGq0sZL+FOYgv4qd85A=;
  b=kqub8l60s6F7rkNwCinI/k6rLnfq9xgVMjQ1dCR9N8DI+SgUAryOnbOG
   NcTXXzlDcZbrtVK+vI7ONttOoJu3tpkw/DXmWgPMw+QbKa2kvqIYOCHzV
   G4wMMcqVj0OlLE3B4SKZrPwus+23gCY5SRwEKpDqftm4yOjMWGM5J4LE8
   m7rEsFAK2+767KSUElV++h3YkNLr9b9CIa+HnP6EgwIIkxa4DeP1DoARP
   xJRNWIXiJccyVimLZ4z5cj6x275Skca/wG9WhC+Rr7EzkMW650d1DE8yK
   Qi2nhqHus5OQs/8csGsx1koerRHC9eEHUmpLRFaSwdhCeX9ytCpc8/9qY
   g==;
X-CSE-ConnectionGUID: 5/HIuX8FRFKHcq4b/7Erxg==
X-CSE-MsgGUID: KYbNNHv/Qp6qQXzUWqDU0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93179827"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="93179827"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 22:46:40 -0700
X-CSE-ConnectionGUID: nEEdCaH7Q06wrOi5DlRThA==
X-CSE-MsgGUID: brFEOOJOSAmRGMxHfJZsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="276925120"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Jun 2026 22:46:35 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXuiu-00000000ONd-0p3y;
	Fri, 12 Jun 2026 05:46:32 +0000
Date: Fri, 12 Jun 2026 13:46:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
Message-ID: <202606121305.h0cxjhP2-lkp@intel.com>
References: <3abf510d24c8ef17bd5e324cccc5e03e548afade.1781170904.git.ritesh.list@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3abf510d24c8ef17bd5e324cccc5e03e548afade.1781170904.git.ritesh.list@gmail.com>

Hi Ritesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linux-review/Ritesh-Harjani-IBM/include-linux-swap-h-Remove-unused-leftovers/20260611-111124 next-20260611]
[cannot apply to powerpc/next powerpc/fixes linus/master v7.1-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ritesh-Harjani-IBM/mm-swap-make-SWAPFILE_CLUSTER-runtime/20260611-181121
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/3abf510d24c8ef17bd5e324cccc5e03e548afade.1781170904.git.ritesh.list%40gmail.com
patch subject: [PATCH v2 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
config: arm64-randconfig-r133-20260611 (https://download.01.org/0day-ci/archive/20260612/202606121305.h0cxjhP2-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260612/202606121305.h0cxjhP2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606121305.h0cxjhP2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/swapfile.c:133:6: sparse: sparse: symbol 'swap_table_use_page' was not declared. Should it be static?

vim +/swap_table_use_page +133 mm/swapfile.c

   131	
   132	unsigned int swap_slots_in_cluster __read_mostly;
 > 133	bool swap_table_use_page __read_mostly;
   134	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

