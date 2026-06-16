Return-Path: <linuxppc-dev+bounces-22676-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE7DCD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 01:10:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfTRw4h3Cz3btJ;
	Tue, 16 Jun 2026 11:10:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781572204;
	cv=none; b=ZjY11QvlfcBKG8meM6Y77I1VenFN+YhwFBqYhciYYX3qxJi78VvCFnvJBIBE6vQH7lVnjKBWyvTH2Rys8Az4IW6OQiAIBp5p/FBXXZe/CLzKWWqo7igleCsRtDYy8mK5zwkiXDoon035konAgepYweyIuWqIOwLJ80M2oiR5luQcE3nCx39BKcquBQQs9ezhjSEgPh2IcGx2CBhjResshvLD1Pv5ob0RpWJDo9ZMIABsKZ/hocH4t2AubVF7oVmUhtqcg6z0iDzqQaqRJaFc+gpP64tGAGGr/PA71IF3jBWjMdQ9LbCvwQNLfcXLqladol479r7uNMiEwDVndhsILg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781572204; c=relaxed/relaxed;
	bh=3DaoJjHQN9X5tlcjCCjLZ5CUhOi/suohD2rRN9Q9Pyo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q6Cs2tqu7bs3QMoxL86+w0yFUZvahKCPKu/ztPyIi6uFlpzqYoraqEHjtyMADJcwyB0A7aAHrdxf+iu3hJCTuGIUJi591QUKXsEnPb0x+Ao+x7NolqhoKd6dgafW+0hqxOb4b2gshusO2TF95tuj7LuAl68f4pS6h6PdcrToNi0RaeL3/pLsnChBYEuuFFoI4JYA8iRAGQpUygvTFMA66nLgbG16jmi6Mz6Ia/g+1L91vqEm77OU3oGbRzYCHMgiDkE/7Te+vV6ERb46H6DHzZ6NjAYdtDFzfXPF1OZa5YDdgjIxVCLRRxPML1H60YQSH+fCj2A8gGYnf0l4IZWCeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aaPqCNgK; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aaPqCNgK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfTRs3jmPz3bt2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 11:09:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781572202; x=1813108202;
  h=date:from:to:cc:subject:message-id;
  bh=5Xe5tVuIejQkXKMXZl3ew7sODFthTQAoWW6tx1HLqX4=;
  b=aaPqCNgKr61teppQAY/8f2ruVTcHxd0IlPYx55lggYFQUfDxoqEdgdCr
   HwYL+P6Qz5o40egdxJFnChv4xdWkfwhPq+FZS78rxr9eu5zBfc8ewPfLH
   llTPSC7D+3wiWStk7k1PAX5fGkyAh/3HdHarCJRWB/aVZjwLLi3hY0QS/
   nL4G2hZSTeQ9gnflVBwzvd9RrSxhdj/cObj49bB9IYQfpCdo7rnWOFA4i
   0ghR4Ka1ME7UqQltCjbz3ugPz4xapcxmkxLwsxWuNQvlON4GJaKZGuZD3
   r3UlFtQtT+Zwdjr7NwPVpHBuE6iSyrJtDo+B6mrDxTa45T358V5v3Jbw4
   Q==;
X-CSE-ConnectionGUID: LC8dK++pTACy0GIbmksqrw==
X-CSE-MsgGUID: VsgTKgDMRDadmOUguQ1Xxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="99900506"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="99900506"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 18:09:55 -0700
X-CSE-ConnectionGUID: mMdBRVlqRk6ayh4MO211OA==
X-CSE-MsgGUID: 6nkqnl/nRRCXtmRGP9Yjuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="247702515"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Jun 2026 18:09:54 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZIJK-00000000Sa6-35t7;
	Tue, 16 Jun 2026 01:09:50 +0000
Date: Tue, 16 Jun 2026 09:09:41 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 21ea7a68c5c1999cee9da55759a366576a838bbb
Message-ID: <202606160933.PRhfsPtU-lkp@intel.com>
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
branch HEAD: 21ea7a68c5c1999cee9da55759a366576a838bbb  Automatic merge of 'next' into merge (2026-06-15 16:20)

elapsed time: 853m

configs tested: 276
configs skipped: 2

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
arc                   randconfig-001-20260615    gcc-10.5.0
arc                   randconfig-001-20260616    gcc-9.5.0
arc                   randconfig-002-20260615    gcc-10.5.0
arc                   randconfig-002-20260616    gcc-9.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                       imx_v4_v5_defconfig    clang-23
arm                         orion5x_defconfig    clang-21
arm                   randconfig-001-20260615    gcc-10.5.0
arm                   randconfig-001-20260616    gcc-9.5.0
arm                   randconfig-002-20260615    gcc-10.5.0
arm                   randconfig-002-20260616    gcc-9.5.0
arm                   randconfig-003-20260615    gcc-10.5.0
arm                   randconfig-003-20260616    gcc-9.5.0
arm                   randconfig-004-20260615    gcc-10.5.0
arm                   randconfig-004-20260616    gcc-9.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260615    gcc-10.5.0
arm64                 randconfig-001-20260616    gcc-13.4.0
arm64                 randconfig-002-20260615    gcc-10.5.0
arm64                 randconfig-002-20260616    gcc-13.4.0
arm64                 randconfig-003-20260615    gcc-10.5.0
arm64                 randconfig-003-20260616    gcc-13.4.0
arm64                 randconfig-004-20260615    gcc-10.5.0
arm64                 randconfig-004-20260616    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260615    gcc-10.5.0
csky                  randconfig-001-20260616    gcc-13.4.0
csky                  randconfig-002-20260615    gcc-10.5.0
csky                  randconfig-002-20260616    gcc-13.4.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260615    clang-18
hexagon               randconfig-001-20260616    clang-23
hexagon               randconfig-002-20260615    clang-18
hexagon               randconfig-002-20260616    clang-23
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260615    clang-22
i386        buildonly-randconfig-001-20260616    clang-22
i386        buildonly-randconfig-002-20260615    clang-22
i386        buildonly-randconfig-002-20260616    clang-22
i386        buildonly-randconfig-003-20260615    clang-22
i386        buildonly-randconfig-003-20260616    clang-22
i386        buildonly-randconfig-004-20260615    clang-22
i386        buildonly-randconfig-004-20260616    clang-22
i386        buildonly-randconfig-005-20260615    clang-22
i386        buildonly-randconfig-005-20260616    clang-22
i386        buildonly-randconfig-006-20260615    clang-22
i386        buildonly-randconfig-006-20260616    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260615    clang-22
i386                  randconfig-001-20260616    gcc-14
i386                  randconfig-002-20260615    clang-22
i386                  randconfig-002-20260616    gcc-14
i386                  randconfig-003-20260615    clang-22
i386                  randconfig-003-20260616    gcc-14
i386                  randconfig-004-20260615    clang-22
i386                  randconfig-004-20260616    gcc-14
i386                  randconfig-005-20260615    clang-22
i386                  randconfig-005-20260616    gcc-14
i386                  randconfig-006-20260615    clang-22
i386                  randconfig-006-20260616    gcc-14
i386                  randconfig-007-20260615    clang-22
i386                  randconfig-007-20260616    gcc-14
i386                  randconfig-011-20260615    gcc-14
i386                  randconfig-011-20260616    clang-22
i386                  randconfig-012-20260615    gcc-14
i386                  randconfig-012-20260616    clang-22
i386                  randconfig-013-20260615    gcc-14
i386                  randconfig-013-20260616    clang-22
i386                  randconfig-014-20260615    gcc-14
i386                  randconfig-014-20260616    clang-22
i386                  randconfig-015-20260615    gcc-14
i386                  randconfig-015-20260616    clang-22
i386                  randconfig-016-20260615    gcc-14
i386                  randconfig-016-20260616    clang-22
i386                  randconfig-017-20260615    gcc-14
i386                  randconfig-017-20260616    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260615    clang-18
loongarch             randconfig-001-20260616    clang-23
loongarch             randconfig-002-20260615    clang-18
loongarch             randconfig-002-20260616    clang-23
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
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260615    clang-18
nios2                 randconfig-001-20260616    clang-23
nios2                 randconfig-002-20260615    clang-18
nios2                 randconfig-002-20260616    clang-23
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260615    gcc-13.4.0
parisc                randconfig-001-20260616    gcc-8.5.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260615    gcc-13.4.0
parisc                randconfig-002-20260616    gcc-8.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                      ep88xc_defconfig    gcc-16.1.0
powerpc                      pmac32_defconfig    clang-23
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260615    gcc-13.4.0
powerpc               randconfig-001-20260616    gcc-8.5.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260615    gcc-13.4.0
powerpc               randconfig-002-20260616    gcc-8.5.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260615    gcc-13.4.0
powerpc64             randconfig-001-20260616    gcc-8.5.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260615    gcc-13.4.0
powerpc64             randconfig-002-20260616    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-16.1.0
riscv                 randconfig-001-20260615    gcc-16.1.0
riscv                 randconfig-001-20260616    gcc-16.1.0
riscv                          randconfig-002    gcc-16.1.0
riscv                 randconfig-002-20260615    gcc-16.1.0
riscv                 randconfig-002-20260616    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-16.1.0
s390                  randconfig-001-20260615    gcc-16.1.0
s390                  randconfig-001-20260616    gcc-16.1.0
s390                           randconfig-002    gcc-16.1.0
s390                  randconfig-002-20260615    gcc-16.1.0
s390                  randconfig-002-20260616    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-16.1.0
sh                    randconfig-001-20260615    gcc-16.1.0
sh                    randconfig-001-20260616    gcc-16.1.0
sh                             randconfig-002    gcc-16.1.0
sh                    randconfig-002-20260615    gcc-16.1.0
sh                    randconfig-002-20260616    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260615    gcc-15.2.0
sparc                 randconfig-001-20260616    gcc-8.5.0
sparc                 randconfig-002-20260615    gcc-15.2.0
sparc                 randconfig-002-20260616    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260615    gcc-15.2.0
sparc64               randconfig-001-20260616    gcc-8.5.0
sparc64               randconfig-002-20260615    gcc-15.2.0
sparc64               randconfig-002-20260616    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260615    gcc-15.2.0
um                    randconfig-001-20260616    gcc-8.5.0
um                    randconfig-002-20260615    gcc-15.2.0
um                    randconfig-002-20260616    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260615    clang-22
x86_64      buildonly-randconfig-001-20260616    gcc-14
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260615    clang-22
x86_64      buildonly-randconfig-002-20260616    gcc-14
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260615    clang-22
x86_64      buildonly-randconfig-003-20260616    gcc-14
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260615    clang-22
x86_64      buildonly-randconfig-004-20260616    gcc-14
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260615    clang-22
x86_64      buildonly-randconfig-005-20260616    gcc-14
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260615    clang-22
x86_64      buildonly-randconfig-006-20260616    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260615    clang-22
x86_64                randconfig-001-20260616    clang-22
x86_64                randconfig-002-20260615    clang-22
x86_64                randconfig-002-20260616    clang-22
x86_64                randconfig-003-20260615    clang-22
x86_64                randconfig-003-20260616    clang-22
x86_64                randconfig-004-20260615    clang-22
x86_64                randconfig-004-20260616    clang-22
x86_64                randconfig-005-20260615    clang-22
x86_64                randconfig-005-20260616    clang-22
x86_64                randconfig-006-20260615    clang-22
x86_64                randconfig-006-20260616    clang-22
x86_64                randconfig-011-20260615    clang-22
x86_64                randconfig-011-20260616    clang-22
x86_64                randconfig-012-20260615    clang-22
x86_64                randconfig-012-20260616    clang-22
x86_64                randconfig-013-20260615    clang-22
x86_64                randconfig-013-20260616    clang-22
x86_64                randconfig-014-20260615    clang-22
x86_64                randconfig-014-20260616    clang-22
x86_64                randconfig-015-20260615    clang-22
x86_64                randconfig-015-20260616    clang-22
x86_64                randconfig-016-20260615    clang-22
x86_64                randconfig-016-20260616    clang-22
x86_64                randconfig-071-20260615    gcc-14
x86_64                randconfig-071-20260616    gcc-14
x86_64                randconfig-072-20260615    gcc-14
x86_64                randconfig-072-20260616    gcc-14
x86_64                randconfig-073-20260615    gcc-14
x86_64                randconfig-073-20260616    gcc-14
x86_64                randconfig-074-20260615    gcc-14
x86_64                randconfig-074-20260616    gcc-14
x86_64                randconfig-075-20260615    gcc-14
x86_64                randconfig-075-20260616    gcc-14
x86_64                randconfig-076-20260615    gcc-14
x86_64                randconfig-076-20260616    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260615    gcc-15.2.0
xtensa                randconfig-001-20260616    gcc-8.5.0
xtensa                randconfig-002-20260615    gcc-15.2.0
xtensa                randconfig-002-20260616    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

