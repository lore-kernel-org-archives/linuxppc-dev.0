Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E2DC77B7C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 May 2023 05:37:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QFn4M5vwhz3fNx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 May 2023 15:37:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V9vt1sh0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V9vt1sh0;
	dkim-atps=neutral
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QFn3P3qcbz30Jy
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2023 15:37:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683610625; x=1715146625;
  h=date:from:to:cc:subject:message-id;
  bh=oFZNFjRTvJvmsE671cZrWoyBrxQKidpy3g4/f6zqrx8=;
  b=V9vt1sh0Pv5mWWdf2B79QzXjKUxWwrXtanPoE/0KXFYV9j3q5PVKcvJ2
   hof1UngTeEi78iZKcqInoqeA7cuBtq6vtFU/GMGZyZjtTojb7KO1P2wPV
   AXk9mxMj35/GpHZPILhZ46kGUQNqGDZ5VTSv7zv+1uNp+KyciaN2kAuHy
   c+04NXGsSPzrVz4A2GPKogKK7fT5kfrj7vOsYtkTkADCTIA+nswdKcDzt
   s82kuzv5mEwzymg/cr9Ui9XlXyJyJd1IU0cjL4VUhSjCHy2wW3zXlmPyo
   0ULsShmwXZ+HroK6x3AiJluYzQ19rx44QOIWoC2uQlZgdvuXqnMCkTzCm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347275200"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="347275200"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 22:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="822931440"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="822931440"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2023 22:37:00 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pwG1z-0001lO-2O;
	Tue, 09 May 2023 05:36:59 +0000
Date: Tue, 09 May 2023 13:36:00 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:fixes-test] BUILD SUCCESS
 536d948a8dee21166d9c5b5a4189af56beba16e3
Message-ID: <20230509053600.3EFPt%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes-test
branch HEAD: 536d948a8dee21166d9c5b5a4189af56beba16e3  powerpc/fsl_uli1575: fix kconfig warnings and build errors

elapsed time: 721m

configs tested: 2
configs skipped: 145

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
