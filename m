Return-Path: <linuxppc-dev+bounces-19297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F256E88D6E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 00:16:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnbjG6Zhkz2ySc;
	Sat, 04 Apr 2026 11:16:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775261762;
	cv=none; b=GfPAYlK5e2dG8Sdju0eIv9AbSojH315fUuXgnNPUfN6f/5n9zk2URs8JRnKJ+pZYs/64WmBScKj4+q34kht6UN3dxD33awZXOQJEo93mhNXek6q2WM7oWKWyqQaEpfR/+xEJmZdv67JxWLfp2NHKXpAwOmcO540HehFistvUL0ZZ4MR08CuP8R/ra3arsb+7d5IvXba0xjahxgKHGOksrHF8Gn0ek5ivjfdZejldM2UTqGt1U2Vs2pVQfO20woXBM34qLLyxrqvAPz6gM5KhCgrqkhXyCetn/DJ8lvMZqbYkUlHPVpAUTS6urZLzhbk2eQYnHIvijsnwZsV6QpC1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775261762; c=relaxed/relaxed;
	bh=nGe1Kfkmywf5144Yj1dF1noKNQ1Tv9EW34Vb4vd+V6A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=R4qfTRAR+1IdXsNMPfPrw3UIADoiCKkAAytDH9os8Ni5n/up7dvWkPU14SbDuqcPKv1b3nY32N3ePEkmXiN2/FfX9PeQafsE4wgvzNFoTqfw6RQQD/V74mgHyLOKi6kH4ZXQah7Y5d1DH5Rg2g4WhlC/w/u+r1/HcJfIktSkHeOErhMkDbRB+sqOMwqcEU/uU+al0jEnERsj67aEgL4c0Y0mw5Ftwlb7we4fYxED7g1L1jqnieraKh7ZPovfj0G5EumIjjIQk4Qx1ml/HtSLOxNeb+pRE5BwLIqOUk3w2d+0QuT/BgGt2PhhdjVrBMFSH6lQ+tBWNmkQlQkvidMJXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FaR+MwEN; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FaR+MwEN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnbjC0XDQz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 11:15:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775261759; x=1806797759;
  h=date:from:to:cc:subject:message-id;
  bh=nTmSvfUoYPbqcBDSWr6NvY084gvaTyzJJtTYa5mcT8k=;
  b=FaR+MwENU+JkdRa4VHKuc9TPuX2bnb9LhcVoqpINM6nqxSMyOwdOTJBH
   YPW74q06Aa6GQP68dkFu1ORZEKWU2wfdgUIvDi1088Ys6sryNH0umM84X
   SkfdVsiMj+LeBU6WeDlZJSYyy2f6k2cTlNiH5mSJb5SiVmiM/h/QPc7uN
   Bs0oWriqgldOq5dbtLvcBrf9E1/IY8530zKz87MD5whpUwFNV0uRfMWYw
   v7NsGEVE2UeK0VjlB2UZKG5uu4+gw+Nf/h55Y6U/RgR/ai6fdzqLajTr/
   pxXYUhdn1CZDesuw9KopFYIPQNm/rNVQsxuvQdXZEhHWnPiohe1ryZPag
   g==;
X-CSE-ConnectionGUID: IC5zPM8VSWWDS4xveu1xGw==
X-CSE-MsgGUID: w/DnZZWLQMSPv/kAlFOAuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="87025316"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="87025316"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 17:15:53 -0700
X-CSE-ConnectionGUID: DkGDgb/zTN2DWA/vCUvUFw==
X-CSE-MsgGUID: eY7Q7c8ASRyqM51p9Ra1dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="223026091"
Received: from lkp-server01.sh.intel.com (HELO 3afb7d003cac) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 03 Apr 2026 17:15:52 -0700
Received: from kbuild by 3afb7d003cac with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8og1-000000000NR-2mwu;
	Sat, 04 Apr 2026 00:15:49 +0000
Date: Sat, 04 Apr 2026 08:14:57 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD REGRESSION
 e1f7a0e196e293c223a882788c6d1a884d06d6d8
Message-ID: <202604040846.ddESqvNz-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
branch HEAD: e1f7a0e196e293c223a882788c6d1a884d06d6d8  selftest/bpf: Enable gotox tests for powerpc64

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202604040005.1ocss28U-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202604040212.jIxEd2DW-lkp@intel.com

    arch/powerpc/net/bpf_jit_comp32.c:153:7: error: call to undeclared function 'PPC_RAW_LI32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    arch/powerpc/net/bpf_jit_comp32.c:153:7: error: implicit declaration of function 'PPC_RAW_LI32'; did you mean 'PPC_RAW_LI'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- powerpc-randconfig-001-20260403
|   `-- arch-powerpc-net-bpf_jit_comp32.c:error:call-to-undeclared-function-PPC_RAW_LI32-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- powerpc-randconfig-001-20260404
    `-- arch-powerpc-net-bpf_jit_comp32.c:error:implicit-declaration-of-function-PPC_RAW_LI32

elapsed time: 756m

configs tested: 330
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260403    gcc-10.5.0
arc                   randconfig-001-20260403    gcc-8.5.0
arc                   randconfig-001-20260404    gcc-15.2.0
arc                   randconfig-002-20260403    gcc-10.5.0
arc                   randconfig-002-20260403    gcc-8.5.0
arc                   randconfig-002-20260404    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260403    clang-23
arm                   randconfig-001-20260403    gcc-10.5.0
arm                   randconfig-001-20260404    gcc-15.2.0
arm                   randconfig-002-20260403    gcc-10.5.0
arm                   randconfig-002-20260404    gcc-15.2.0
arm                   randconfig-003-20260403    gcc-10.5.0
arm                   randconfig-003-20260403    gcc-15.2.0
arm                   randconfig-003-20260404    gcc-15.2.0
arm                   randconfig-004-20260403    gcc-10.5.0
arm                   randconfig-004-20260403    gcc-8.5.0
arm                   randconfig-004-20260404    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260403    gcc-13.4.0
arm64                 randconfig-001-20260403    gcc-8.5.0
arm64                 randconfig-001-20260404    gcc-15.2.0
arm64                 randconfig-002-20260403    clang-23
arm64                 randconfig-002-20260403    gcc-13.4.0
arm64                 randconfig-002-20260404    gcc-15.2.0
arm64                 randconfig-003-20260403    gcc-13.4.0
arm64                 randconfig-003-20260403    gcc-8.5.0
arm64                 randconfig-003-20260404    gcc-15.2.0
arm64                 randconfig-004-20260403    clang-17
arm64                 randconfig-004-20260403    gcc-13.4.0
arm64                 randconfig-004-20260404    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260403    gcc-13.4.0
csky                  randconfig-001-20260403    gcc-9.5.0
csky                  randconfig-001-20260404    gcc-15.2.0
csky                  randconfig-002-20260403    gcc-13.4.0
csky                  randconfig-002-20260404    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260403    clang-23
hexagon               randconfig-001-20260404    gcc-15.2.0
hexagon               randconfig-002-20260403    clang-20
hexagon               randconfig-002-20260403    clang-23
hexagon               randconfig-002-20260404    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260403    gcc-14
i386        buildonly-randconfig-001-20260404    clang-20
i386        buildonly-randconfig-002-20260403    clang-20
i386        buildonly-randconfig-002-20260403    gcc-14
i386        buildonly-randconfig-002-20260404    clang-20
i386        buildonly-randconfig-003-20260403    gcc-14
i386        buildonly-randconfig-003-20260404    clang-20
i386        buildonly-randconfig-004-20260403    gcc-14
i386        buildonly-randconfig-004-20260404    clang-20
i386        buildonly-randconfig-005-20260403    gcc-14
i386        buildonly-randconfig-005-20260404    clang-20
i386        buildonly-randconfig-006-20260403    gcc-14
i386        buildonly-randconfig-006-20260404    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260403    clang-20
i386                  randconfig-001-20260404    clang-20
i386                  randconfig-002-20260403    gcc-12
i386                  randconfig-002-20260404    clang-20
i386                  randconfig-003-20260403    gcc-14
i386                  randconfig-003-20260404    clang-20
i386                  randconfig-004-20260403    clang-20
i386                  randconfig-004-20260404    clang-20
i386                  randconfig-005-20260403    gcc-14
i386                  randconfig-005-20260404    clang-20
i386                  randconfig-006-20260403    gcc-14
i386                  randconfig-006-20260404    clang-20
i386                  randconfig-007-20260403    clang-20
i386                  randconfig-007-20260404    clang-20
i386                  randconfig-011-20260403    clang-20
i386                  randconfig-011-20260403    gcc-14
i386                  randconfig-011-20260404    clang-20
i386                  randconfig-012-20260403    clang-20
i386                  randconfig-012-20260404    clang-20
i386                  randconfig-013-20260403    clang-20
i386                  randconfig-013-20260404    clang-20
i386                  randconfig-014-20260403    clang-20
i386                  randconfig-014-20260404    clang-20
i386                  randconfig-015-20260403    clang-20
i386                  randconfig-015-20260404    clang-20
i386                  randconfig-016-20260403    clang-20
i386                  randconfig-016-20260403    gcc-14
i386                  randconfig-016-20260404    clang-20
i386                  randconfig-017-20260403    clang-20
i386                  randconfig-017-20260403    gcc-13
i386                  randconfig-017-20260404    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260403    clang-23
loongarch             randconfig-001-20260404    gcc-15.2.0
loongarch             randconfig-002-20260403    clang-23
loongarch             randconfig-002-20260403    gcc-15.2.0
loongarch             randconfig-002-20260404    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
microblaze                      mmu_defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260403    clang-23
nios2                 randconfig-001-20260403    gcc-8.5.0
nios2                 randconfig-001-20260404    gcc-15.2.0
nios2                 randconfig-002-20260403    clang-23
nios2                 randconfig-002-20260403    gcc-11.5.0
nios2                 randconfig-002-20260404    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260403    gcc-10.5.0
parisc                randconfig-001-20260403    gcc-11.5.0
parisc                randconfig-001-20260404    gcc-10.5.0
parisc                randconfig-002-20260403    gcc-10.5.0
parisc                randconfig-002-20260403    gcc-8.5.0
parisc                randconfig-002-20260404    gcc-10.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     mpc83xx_defconfig    clang-23
powerpc               randconfig-001-20260403    clang-23
powerpc               randconfig-001-20260403    gcc-10.5.0
powerpc               randconfig-001-20260404    gcc-10.5.0
powerpc               randconfig-002-20260403    gcc-10.5.0
powerpc               randconfig-002-20260403    gcc-13.4.0
powerpc               randconfig-002-20260404    gcc-10.5.0
powerpc                  storcenter_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260403    clang-23
powerpc64             randconfig-001-20260403    gcc-10.5.0
powerpc64             randconfig-001-20260404    gcc-10.5.0
powerpc64             randconfig-002-20260403    gcc-10.5.0
powerpc64             randconfig-002-20260404    gcc-10.5.0
riscv                            alldefconfig    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260403    clang-23
riscv                 randconfig-001-20260404    clang-19
riscv                 randconfig-001-20260404    clang-20
riscv                 randconfig-002-20260403    clang-23
riscv                 randconfig-002-20260404    clang-20
riscv                 randconfig-002-20260404    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260403    clang-23
s390                  randconfig-001-20260404    clang-20
s390                  randconfig-002-20260403    clang-23
s390                  randconfig-002-20260404    clang-20
s390                  randconfig-002-20260404    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                        apsh4ad0a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260403    clang-23
sh                    randconfig-001-20260404    clang-20
sh                    randconfig-001-20260404    gcc-15.2.0
sh                    randconfig-002-20260403    clang-23
sh                    randconfig-002-20260404    clang-20
sh                    randconfig-002-20260404    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260403    clang-20
sparc                 randconfig-001-20260403    gcc-8.5.0
sparc                 randconfig-001-20260404    clang-20
sparc                 randconfig-002-20260403    clang-20
sparc                 randconfig-002-20260403    gcc-15.2.0
sparc                 randconfig-002-20260404    clang-20
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260403    clang-20
sparc64               randconfig-001-20260403    gcc-15.2.0
sparc64               randconfig-001-20260404    clang-20
sparc64               randconfig-002-20260403    clang-20
sparc64               randconfig-002-20260404    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260403    clang-20
um                    randconfig-001-20260404    clang-20
um                    randconfig-002-20260403    clang-20
um                    randconfig-002-20260403    gcc-14
um                    randconfig-002-20260404    clang-20
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260403    clang-20
x86_64      buildonly-randconfig-001-20260404    gcc-13
x86_64      buildonly-randconfig-002-20260403    clang-20
x86_64      buildonly-randconfig-002-20260403    gcc-14
x86_64      buildonly-randconfig-002-20260404    gcc-13
x86_64      buildonly-randconfig-003-20260403    clang-20
x86_64      buildonly-randconfig-003-20260404    gcc-13
x86_64      buildonly-randconfig-004-20260403    clang-20
x86_64      buildonly-randconfig-004-20260403    gcc-14
x86_64      buildonly-randconfig-004-20260404    gcc-13
x86_64      buildonly-randconfig-005-20260403    clang-20
x86_64      buildonly-randconfig-005-20260404    gcc-13
x86_64      buildonly-randconfig-006-20260403    clang-20
x86_64      buildonly-randconfig-006-20260403    gcc-12
x86_64      buildonly-randconfig-006-20260404    gcc-13
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260403    gcc-14
x86_64                randconfig-001-20260404    gcc-14
x86_64                randconfig-002-20260403    clang-20
x86_64                randconfig-002-20260404    gcc-14
x86_64                randconfig-003-20260403    gcc-13
x86_64                randconfig-003-20260404    gcc-14
x86_64                randconfig-004-20260403    clang-20
x86_64                randconfig-004-20260404    gcc-14
x86_64                randconfig-005-20260403    gcc-13
x86_64                randconfig-005-20260404    gcc-14
x86_64                randconfig-006-20260403    clang-20
x86_64                randconfig-006-20260404    gcc-14
x86_64                randconfig-011-20260403    gcc-14
x86_64                randconfig-011-20260404    gcc-14
x86_64                randconfig-012-20260403    gcc-14
x86_64                randconfig-012-20260404    gcc-14
x86_64                randconfig-013-20260403    gcc-14
x86_64                randconfig-013-20260404    gcc-14
x86_64                randconfig-014-20260403    gcc-14
x86_64                randconfig-014-20260404    gcc-14
x86_64                randconfig-015-20260403    gcc-14
x86_64                randconfig-015-20260404    gcc-14
x86_64                randconfig-016-20260403    gcc-14
x86_64                randconfig-016-20260404    gcc-14
x86_64                randconfig-071-20260403    gcc-14
x86_64                randconfig-071-20260404    gcc-14
x86_64                randconfig-072-20260403    gcc-14
x86_64                randconfig-072-20260404    gcc-14
x86_64                randconfig-073-20260403    gcc-14
x86_64                randconfig-073-20260404    gcc-14
x86_64                randconfig-074-20260403    gcc-14
x86_64                randconfig-074-20260404    gcc-14
x86_64                randconfig-075-20260403    clang-20
x86_64                randconfig-075-20260403    gcc-14
x86_64                randconfig-075-20260404    gcc-14
x86_64                randconfig-076-20260403    gcc-14
x86_64                randconfig-076-20260404    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260403    clang-20
xtensa                randconfig-001-20260403    gcc-9.5.0
xtensa                randconfig-001-20260404    clang-20
xtensa                randconfig-002-20260403    clang-20
xtensa                randconfig-002-20260403    gcc-8.5.0
xtensa                randconfig-002-20260404    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

