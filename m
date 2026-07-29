Return-Path: <linuxppc-dev+bounces-25025-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7C0C53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 15:49:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9GwV5qwcz2xwP;
	Thu, 30 Jul 2026 01:49:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785340154;
	cv=none; b=UAHQm/+1JvJ3ChAlA3uYza3zc4jC5HXcb7pmN/mibBfNHRItKWesJ2kpz+yL3Z5yf2Eh5FLxLT+L31S6KZ2pqI3damSKYAQ/FYAx553FLlxUUlLuwxWG8FNggBTpjlZKGMyet8+fW9fSbXoLfnqG7vVDlgrK8BX6VaG3Wx3KgC4HPEJEAqeB6+iNZeMlhupR5UGmkVpA8LhlfKiMFPfxFHidrqMLux1bIvtDumcy4REmgCtnE1t2wNvA4cfkENHfxHgyhZAD4yDeMfxE37P7vABRW/JwExo5NZrf9HDCyHfs2JmX6eGKVXAyaH6KTXT1kvjaPeHSwLwimks8tzHW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785340154; c=relaxed/relaxed;
	bh=xOwzC+ITKjCDEwLBXPI2lGWGK0RzzAgGq87z+Y8IJhM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RLueZyDxgih+RbZmpT/3ZzuwbNd9/3oeYDj7nFbSxtoW3y82Ksz3zQeo+23sXn3suwq5ZNLsnnn/9nyF+mf4aAuNsKJc6ac2Ie3+ZPmxU9aV6nUKrE+xMaudURdLGQ1q7EIyMy5DJiXEqI0V2IfkANWqLmsZI3Uj97L57QRstd7Tw3EYSNPcH143/FIHm9YCkHxaHtvu2KWjesnpNLxJn0aDjXk+xHM5rlbCTy82xoxbPtnKqa7FmpcM6nQ9VzNJ5iKiUqorTQ/s+lMMD0P24CBC/KoDKwPQwy9nwpKTnf6WlZ2dLKEvlmCToNNJ1W2PIeAfPitXuyVPlYL34fJk1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kEi1XJc6; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kEi1XJc6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9GwR31Cvz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 01:49:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785340152; x=1816876152;
  h=date:from:to:cc:subject:message-id;
  bh=4MD2gRFIaWNmBDKgVYvpvkr1nNoEeZhl1lv0mxZpg0Q=;
  b=kEi1XJc6fbKqlRiT1sUziQa6LHz/kmnwEF3UIijjyvb0synP2gMFOhqr
   1ivTiR3Ms4/FE3dyZpe1d1lDRa5zNbO9NoUvxYZgA7Mg/0ayDtUC/5H+G
   IRq4swA18p8DdI9lCm91ezOJnKKKhYFmXTf48G6vGDfJep3n7v7Q1b1fj
   Cbmv1kyY4B3ivBmdL7Cl1wwZ6KwNXdkREqsvEHnaAGCmBf8dmcB2L6Atc
   tz1HWEaFClxw3uBzi/P74jw6WdOzpEhHQ28ZQGLxdCun70fwUxpqtf5x/
   312auIv+B4pzgRGgqjX0ukV2gqkjNUNqMKLtIuEprztBYlwr/al5qmitm
   A==;
X-CSE-ConnectionGUID: IxKIgayESqSxUmRwqA7kVg==
X-CSE-MsgGUID: RPqllZEOQjK++uLrjkdJ5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96535925"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="96535925"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 08:49:04 -0700
X-CSE-ConnectionGUID: zo+QXSsfTouru/i36jEhEA==
X-CSE-MsgGUID: glV2+0ghQRO4ujitmCbxng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="264322017"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 29 Jul 2026 08:49:03 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wp6Wi-00000000fSB-0tjL;
	Wed, 29 Jul 2026 15:49:00 +0000
Date: Wed, 29 Jul 2026 23:48:45 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes-test] BUILD SUCCESS
 5732bd17feb9ddf843591c4d038eb6de1f8daf4c
Message-ID: <202607292332.dL4fdFHC-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes-test
branch HEAD: 5732bd17feb9ddf843591c4d038eb6de1f8daf4c  MAINTAINERS: Demote myself to reviewer

elapsed time: 164m

configs tested: 28
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arc                 randconfig-001    gcc-8.5.0
arc        randconfig-001-20260729    gcc-8.5.0
arc        randconfig-002-20260729    gcc-13.4.0
arm        randconfig-001-20260729    gcc-10.5.0
arm        randconfig-002-20260729    gcc-8.5.0
arm        randconfig-003-20260729    clang-24
arm        randconfig-004-20260729    clang-18
csky                  allmodconfig    gcc-16.1.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
mips            lemote2f_defconfig    gcc-16.1.0
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
riscv      randconfig-001-20260729    gcc-8.5.0
riscv      randconfig-002-20260729    gcc-9.5.0
s390       randconfig-001-20260729    clang-17
s390       randconfig-002-20260729    clang-24
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260729    gcc-13.4.0
sh         randconfig-002-20260729    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

