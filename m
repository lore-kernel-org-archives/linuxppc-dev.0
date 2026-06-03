Return-Path: <linuxppc-dev+bounces-21984-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1B8CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:39:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVsMP73d5z2ySJ;
	Thu, 04 Jun 2026 01:39:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780501185;
	cv=none; b=U602xoqf0+hZHuN1KZaYsMlNkK09Y+bPtie9V5hat6LqfCB/K+8UP7X4YClR0oeXP3MNGJ7BDwedPlrVUrgCgL7Y9d9Cts5QQ7ScYO4LyS3ouQLbpHQFMjPGRlb5fA9JULXajY4ob6crPtr/h1FcNKW2oDNgzKvOdQHe4hK9PtLpkiiPswGtvbmgFGRePskLwZgCJVp5f3i6cxC6X4avx/hmxGeBTV/2oZmQLB8GWNc6Wn7DNxcUvLm7kUJDJLXsKj17oZ2xs3EHQ+77bXRqHK2XMEdmrH+Us8fe2Z2R/syD4xD+PsScz/z7Wouxz5YzQnn5cTQfAcLgP/8UMjQh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780501185; c=relaxed/relaxed;
	bh=9mOqUfVotq/oUyApRvIPaXRSdxSA19xKtQN15FwcGms=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SnzCThbC3D0uKlCTG57pxO/dbPL+I4L9j2Gwa6sYwMdD40la5ufI5OGETvwvT8neRxOvn2Wm+1bD5RVSTSlrldtQEGvMXq++iAO1SxHvGoTWq94vaCcXpOggKzWiQE8suua8fVpqWXvUM2NER6f+VrXpKDaD2JAQ5qvw79PMN9tQAxPpOb0oN4ExqIAhAf2Av2oPOpcPI6lF5C+9q2X6OCUlWcfZcfbG/jxCmQJlKr2wKzGvkusyEERi1R6ZoCyQz0zzwbNYe3ZJRM/ZsNGLdane+QMw9HZ2cBBBuGw4MtJ9Ulkq3Qtvb5g+dmv5YleI1Gs7t2l7osMnVJx9XEWqiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rfx6wB0I; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rfx6wB0I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVsML740Hz2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 01:39:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780501183; x=1812037183;
  h=date:from:to:cc:subject:message-id;
  bh=nRDRnTTcCQWlvEytI7w0GH5THLAQ9uCU3WkjalTWhxs=;
  b=Rfx6wB0ItZ7qRyhlu0sTF/NbEQEcJa5W7RbZJseEhwhhSdcV4Xls4TzL
   tiSIVZ1c1hu16nwy10KGluHnevmH1rwiIAk737UaqGUgS40Zh+aVoD8UZ
   fQNCRI1wuZmjBlPfveGbCIJOgfqYz8CrksnyGzsu0KprYwGYBsTr0am4Q
   CnyhJqyMFbZAvpPWN8OndTksTIXgt9nleJLYVGqtPrUzxWD8nj0Clw7uY
   qOagTeRVH1sMlWtWsz8LYHSj1NOSnlAraiIcAvU0iYDknZKyb7iyzSnGq
   abZ/eKqaMKdlcPXlj1+V5orPG8iCaf0BmTJcU/bgbBergH/f9C9zWhUuy
   w==;
X-CSE-ConnectionGUID: mAyu+p4tT6C1MsmmX6tSOA==
X-CSE-MsgGUID: gDZoiIPYR6O7L/5VqVXiqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85170532"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="85170532"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 08:39:37 -0700
X-CSE-ConnectionGUID: vxbh6PV2ShiNJPLTNyIUEQ==
X-CSE-MsgGUID: YE0pEDLPSjKwnTyeff78oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="282373379"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2026 08:39:36 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUngq-00000000DaI-2Rn4;
	Wed, 03 Jun 2026 15:39:32 +0000
Date: Wed, 03 Jun 2026 23:39:24 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 c8f80f95da32618d49c2a068ee561b85655b761d
Message-ID: <202606032315.LEzk69SI-lkp@intel.com>
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
branch HEAD: c8f80f95da32618d49c2a068ee561b85655b761d  powerpc/pseries/lparcfg: Replace deprecated strcpy in parse_system_parameter_string

elapsed time: 1977m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260603    gcc-13.4.0
arc                   randconfig-002-20260603    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260603    gcc-13.4.0
arm                   randconfig-002-20260603    gcc-10.5.0
arm                   randconfig-003-20260603    gcc-8.5.0
arm                   randconfig-004-20260603    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260603    clang-20
arm64                 randconfig-002-20260603    gcc-11.5.0
arm64                 randconfig-003-20260603    clang-23
arm64                 randconfig-004-20260603    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260603    gcc-10.5.0
csky                  randconfig-002-20260603    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260603    clang-16
hexagon               randconfig-002-20260603    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260603    gcc-14
i386        buildonly-randconfig-002-20260603    gcc-14
i386        buildonly-randconfig-003-20260603    clang-20
i386        buildonly-randconfig-004-20260603    gcc-12
i386        buildonly-randconfig-005-20260603    gcc-14
i386        buildonly-randconfig-006-20260603    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260603    gcc-14
i386                  randconfig-002-20260603    gcc-14
i386                  randconfig-003-20260603    gcc-14
i386                  randconfig-004-20260603    gcc-14
i386                  randconfig-005-20260603    clang-20
i386                  randconfig-006-20260603    gcc-12
i386                  randconfig-007-20260603    clang-20
i386                  randconfig-011-20260603    gcc-14
i386                  randconfig-012-20260603    gcc-14
i386                  randconfig-013-20260603    clang-20
i386                  randconfig-014-20260603    clang-20
i386                  randconfig-015-20260603    clang-20
i386                  randconfig-016-20260603    gcc-14
i386                  randconfig-017-20260603    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260603    gcc-16.1.0
loongarch             randconfig-002-20260603    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260603    gcc-8.5.0
nios2                 randconfig-002-20260603    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260603    gcc-8.5.0
parisc                randconfig-002-20260603    gcc-15.2.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260603    gcc-13.4.0
powerpc               randconfig-002-20260603    gcc-13.4.0
powerpc64             randconfig-001-20260603    clang-16
powerpc64             randconfig-002-20260603    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260603    gcc-8.5.0
riscv                 randconfig-002-20260603    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260603    clang-16
s390                  randconfig-002-20260603    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260603    gcc-10.5.0
sh                    randconfig-002-20260603    gcc-13.4.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260603    gcc-8.5.0
sparc                 randconfig-002-20260603    gcc-16.1.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260603    clang-23
sparc64               randconfig-002-20260603    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260603    gcc-14
um                    randconfig-002-20260603    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260603    gcc-14
x86_64      buildonly-randconfig-002-20260603    gcc-14
x86_64      buildonly-randconfig-003-20260603    clang-20
x86_64      buildonly-randconfig-004-20260603    clang-20
x86_64      buildonly-randconfig-005-20260603    clang-20
x86_64      buildonly-randconfig-006-20260603    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260603    clang-20
x86_64                randconfig-002-20260603    clang-20
x86_64                randconfig-003-20260603    clang-20
x86_64                randconfig-004-20260603    clang-20
x86_64                randconfig-005-20260603    clang-20
x86_64                randconfig-006-20260603    gcc-14
x86_64                randconfig-011-20260603    gcc-14
x86_64                randconfig-012-20260603    gcc-14
x86_64                randconfig-013-20260603    clang-20
x86_64                randconfig-014-20260603    gcc-14
x86_64                randconfig-015-20260603    gcc-14
x86_64                randconfig-016-20260603    clang-20
x86_64                randconfig-071-20260603    clang-20
x86_64                randconfig-072-20260603    gcc-14
x86_64                randconfig-073-20260603    gcc-12
x86_64                randconfig-074-20260603    clang-20
x86_64                randconfig-075-20260603    clang-20
x86_64                randconfig-076-20260603    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260603    gcc-9.5.0
xtensa                randconfig-002-20260603    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

