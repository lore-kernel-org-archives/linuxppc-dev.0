Return-Path: <linuxppc-dev+bounces-22755-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706C6CD98E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 03:33:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggmXb3rwPz2xM7;
	Thu, 18 Jun 2026 13:33:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781753615;
	cv=none; b=fGsRjeG+zOzoAWuNKeORDl8usMHHwy4ng5/IGLKrScQHAC4L0Ax7tyDOa9mhawWez3d6LrYRem4eeyU3utproBqtFPn7nKk2jg6SJCHtY5fwL/xthp6ps3d6TOMWdunZhETV8S2uHzzKuO3XQ2fcQ0m8RYF44LT9OO1mpQyTDjscXjFjxpZ1H/C/Rf2zf7CPUO9q0IdF+1/a3h16H16zBADr5nzuAcgQF5LT6WBj8HJqU7LBGXgURWVzVR7KI61Pnh3mhvvSNWwAbyFK40U3q47si1l8Lo8BNA/KA1acip9UdtVVoxRl2aoaF38lTJGAKyDKNMw8c/T9fiH5lqfqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781753615; c=relaxed/relaxed;
	bh=gkGZfV9T8MYvU3uWzm4c7siKTpXiHPnpr/ZD0vYMy04=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RFcr0QeGIc3PyVJsDPDOyoP4rpdaLLjtYlmj92dm76b+eOKSqJ5cznTjHhb9zQnvZbFsM/lZS2ohHO+VFT0bsKV7Xfil19hAWnuEpzQkXvAZUTYvyWWXs1n7ulHpCdKUyLkDW+ILRf7MTpFq4i1+mypABI+E/2b5GIG1+pzoPoNmC+A86RRl/J/tFKKdEZGmU7SsnaobyxoF2Vq53cILVeUIxdVDEYfnHeJKqyInbRmCaKWdN3LdycCjg19BrGC5FL37RRHP/x4kQKUf8UQaW1Leww+Y2yNN3hjMW9kqO1oNzg5Yfgy2fHNOE7lSd5L1WQmnybaUO4muZjkvrF9IHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DFXF5qv5; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DFXF5qv5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggmXW4CMMz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 13:33:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781753612; x=1813289612;
  h=date:from:to:cc:subject:message-id;
  bh=FMIwiOuKuXuNj9ZkDltqzUK7GzOyFm8+NXrtoU2twXA=;
  b=DFXF5qv53eCHnSiLyyCdEJZm01cINLY44Rne/s9yQBuvwA71hE7rM7+U
   uEBorwzGkKY8BG9XGZmE6G7t1avgp3KEba9mU6W86eevrWH0qqNRMfyKt
   lbhzBgtEkq3v2Gtau5Aeb/st/OPfizem8yODdb7vmPydLLc0DjgIRJ8J0
   CnLD6RnqCBaPX/h6+Aqxw4H/dZ+0X+bBtdqVsVhcTuG1yR1l9gcKe0sm2
   IwNk5pvtXU6nKQacu/wKywZ3Lh8Q+4IO97bG2tUxZkWy6xFNGd+wG/ywV
   ktT+fBiH8VD2uqBsMaU6J1lAl95f4HeTpqBMiurCRxb3AXRRKWNgA7eo8
   A==;
X-CSE-ConnectionGUID: Y8bsRqWLRyCaLkTbmJxuUw==
X-CSE-MsgGUID: k4niHWyzSl+5qWvDelv0Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93233284"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="93233284"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 20:33:26 -0700
X-CSE-ConnectionGUID: N2aywQBVQny/GzcH+HiLrg==
X-CSE-MsgGUID: R/MHnYONRMOO/Sz17tzuPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="248117851"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 17 Jun 2026 20:33:24 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wa3VJ-00000000VD4-1KlK;
	Thu, 18 Jun 2026 03:33:21 +0000
Date: Thu, 18 Jun 2026 11:32:30 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 8b3f2c1577c80ff666654798f434106f8ae991e8
Message-ID: <202606181117.OdTwoBch-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git merge
branch HEAD: 8b3f2c1577c80ff666654798f434106f8ae991e8  Automatic merge of 'next' into merge (2026-06-17 08:40)

elapsed time: 1013m

configs tested: 304
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260617    gcc-16.1.0
arc                   randconfig-001-20260618    gcc-15.2.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260617    gcc-16.1.0
arc                   randconfig-002-20260618    gcc-15.2.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                       multi_v4t_defconfig    clang-19
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260617    gcc-16.1.0
arm                   randconfig-001-20260618    gcc-15.2.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260617    gcc-16.1.0
arm                   randconfig-002-20260618    gcc-15.2.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260617    gcc-16.1.0
arm                   randconfig-003-20260618    gcc-15.2.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260617    gcc-16.1.0
arm                   randconfig-004-20260618    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-15.2.0
arm64                 randconfig-001-20260617    gcc-12.5.0
arm64                 randconfig-001-20260618    gcc-15.2.0
arm64                          randconfig-002    gcc-15.2.0
arm64                 randconfig-002-20260617    gcc-12.5.0
arm64                 randconfig-002-20260618    gcc-15.2.0
arm64                          randconfig-003    gcc-15.2.0
arm64                 randconfig-003-20260617    gcc-12.5.0
arm64                 randconfig-003-20260618    gcc-15.2.0
arm64                          randconfig-004    gcc-15.2.0
arm64                 randconfig-004-20260617    gcc-12.5.0
arm64                 randconfig-004-20260618    gcc-15.2.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-15.2.0
csky                  randconfig-001-20260617    gcc-12.5.0
csky                  randconfig-001-20260618    gcc-15.2.0
csky                           randconfig-002    gcc-15.2.0
csky                  randconfig-002-20260617    gcc-12.5.0
csky                  randconfig-002-20260618    gcc-15.2.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260617    clang-17
hexagon               randconfig-001-20260618    clang-23
hexagon               randconfig-002-20260617    clang-17
hexagon               randconfig-002-20260618    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260617    gcc-14
i386        buildonly-randconfig-001-20260618    gcc-14
i386        buildonly-randconfig-002-20260617    gcc-14
i386        buildonly-randconfig-002-20260618    gcc-14
i386        buildonly-randconfig-003-20260617    gcc-14
i386        buildonly-randconfig-003-20260618    gcc-14
i386        buildonly-randconfig-004-20260617    gcc-14
i386        buildonly-randconfig-004-20260618    gcc-14
i386        buildonly-randconfig-005-20260617    gcc-14
i386        buildonly-randconfig-005-20260618    gcc-14
i386        buildonly-randconfig-006-20260617    gcc-14
i386        buildonly-randconfig-006-20260618    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260617    gcc-13
i386                  randconfig-001-20260618    clang-22
i386                  randconfig-002-20260617    gcc-13
i386                  randconfig-002-20260618    clang-22
i386                  randconfig-003-20260617    gcc-13
i386                  randconfig-003-20260618    clang-22
i386                  randconfig-004-20260617    gcc-13
i386                  randconfig-004-20260618    clang-22
i386                  randconfig-005-20260617    gcc-13
i386                  randconfig-005-20260618    clang-22
i386                  randconfig-006-20260617    gcc-13
i386                  randconfig-006-20260618    clang-22
i386                  randconfig-007-20260617    gcc-13
i386                  randconfig-007-20260618    clang-22
i386                  randconfig-011-20260617    clang-22
i386                  randconfig-011-20260618    clang-22
i386                  randconfig-012-20260617    clang-22
i386                  randconfig-012-20260618    clang-22
i386                  randconfig-013-20260617    clang-22
i386                  randconfig-013-20260618    clang-22
i386                  randconfig-014-20260617    clang-22
i386                  randconfig-014-20260618    clang-22
i386                  randconfig-015-20260617    clang-22
i386                  randconfig-015-20260618    clang-22
i386                  randconfig-016-20260617    clang-22
i386                  randconfig-016-20260618    clang-22
i386                  randconfig-017-20260617    clang-22
i386                  randconfig-017-20260618    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260617    clang-17
loongarch             randconfig-001-20260618    clang-23
loongarch             randconfig-002-20260617    clang-17
loongarch             randconfig-002-20260618    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260617    clang-17
nios2                 randconfig-001-20260618    clang-23
nios2                 randconfig-002-20260617    clang-17
nios2                 randconfig-002-20260618    clang-23
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc         de0_nano_multicore_defconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    clang-23
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260617    gcc-15.2.0
parisc                randconfig-001-20260618    gcc-16.1.0
parisc                randconfig-002-20260617    gcc-15.2.0
parisc                randconfig-002-20260618    gcc-16.1.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                          g5_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260617    gcc-15.2.0
powerpc               randconfig-001-20260618    gcc-16.1.0
powerpc               randconfig-002-20260617    gcc-15.2.0
powerpc               randconfig-002-20260618    gcc-16.1.0
powerpc64             randconfig-001-20260617    gcc-15.2.0
powerpc64             randconfig-001-20260618    gcc-16.1.0
powerpc64             randconfig-002-20260617    gcc-15.2.0
powerpc64             randconfig-002-20260618    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-16.1.0
riscv                 randconfig-001-20260617    gcc-16.1.0
riscv                 randconfig-001-20260618    gcc-13.4.0
riscv                          randconfig-002    gcc-16.1.0
riscv                 randconfig-002-20260617    gcc-16.1.0
riscv                 randconfig-002-20260618    gcc-13.4.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-16.1.0
s390                  randconfig-001-20260617    gcc-16.1.0
s390                  randconfig-001-20260618    gcc-13.4.0
s390                           randconfig-002    gcc-16.1.0
s390                  randconfig-002-20260617    gcc-16.1.0
s390                  randconfig-002-20260618    gcc-13.4.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    clang-23
sh                         ap325rxa_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-16.1.0
sh                    randconfig-001-20260617    gcc-16.1.0
sh                    randconfig-001-20260618    gcc-13.4.0
sh                             randconfig-002    gcc-16.1.0
sh                    randconfig-002-20260617    gcc-16.1.0
sh                    randconfig-002-20260618    gcc-13.4.0
sh                           se7619_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260617    gcc-16.1.0
sparc                 randconfig-001-20260618    gcc-14.3.0
sparc                 randconfig-002-20260617    gcc-16.1.0
sparc                 randconfig-002-20260618    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260617    gcc-16.1.0
sparc64               randconfig-001-20260618    gcc-14.3.0
sparc64               randconfig-002-20260617    gcc-16.1.0
sparc64               randconfig-002-20260618    gcc-14.3.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260617    gcc-16.1.0
um                    randconfig-001-20260618    gcc-14.3.0
um                    randconfig-002-20260617    gcc-16.1.0
um                    randconfig-002-20260618    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260617    clang-22
x86_64      buildonly-randconfig-001-20260618    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260617    clang-22
x86_64      buildonly-randconfig-002-20260618    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260617    clang-22
x86_64      buildonly-randconfig-003-20260618    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260617    clang-22
x86_64      buildonly-randconfig-004-20260618    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260617    clang-22
x86_64      buildonly-randconfig-005-20260618    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260617    clang-22
x86_64      buildonly-randconfig-006-20260618    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260617    clang-22
x86_64                randconfig-001-20260618    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260617    clang-22
x86_64                randconfig-002-20260618    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260617    clang-22
x86_64                randconfig-003-20260618    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260617    clang-22
x86_64                randconfig-004-20260618    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260617    clang-22
x86_64                randconfig-005-20260618    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260617    clang-22
x86_64                randconfig-006-20260618    clang-22
x86_64                randconfig-011-20260617    clang-22
x86_64                randconfig-011-20260618    gcc-14
x86_64                randconfig-012-20260617    clang-22
x86_64                randconfig-012-20260618    gcc-14
x86_64                randconfig-013-20260617    clang-22
x86_64                randconfig-013-20260618    gcc-14
x86_64                randconfig-014-20260617    clang-22
x86_64                randconfig-014-20260618    gcc-14
x86_64                randconfig-015-20260617    clang-22
x86_64                randconfig-015-20260618    gcc-14
x86_64                randconfig-016-20260617    clang-22
x86_64                randconfig-016-20260618    gcc-14
x86_64                         randconfig-071    gcc-13
x86_64                randconfig-071-20260617    gcc-13
x86_64                randconfig-071-20260618    clang-22
x86_64                         randconfig-072    gcc-13
x86_64                randconfig-072-20260617    gcc-13
x86_64                randconfig-072-20260618    clang-22
x86_64                         randconfig-073    gcc-13
x86_64                randconfig-073-20260617    gcc-13
x86_64                randconfig-073-20260618    clang-22
x86_64                         randconfig-074    gcc-13
x86_64                randconfig-074-20260617    gcc-13
x86_64                randconfig-074-20260618    clang-22
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260617    gcc-13
x86_64                randconfig-075-20260618    clang-22
x86_64                         randconfig-076    gcc-13
x86_64                randconfig-076-20260617    gcc-13
x86_64                randconfig-076-20260618    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260617    gcc-16.1.0
xtensa                randconfig-001-20260618    gcc-14.3.0
xtensa                randconfig-002-20260617    gcc-16.1.0
xtensa                randconfig-002-20260618    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

