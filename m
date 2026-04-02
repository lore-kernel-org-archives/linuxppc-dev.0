Return-Path: <linuxppc-dev+bounces-19229-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B48D6AAFE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:40:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmsfF67H7z2xls;
	Fri, 03 Apr 2026 06:40:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775158853;
	cv=none; b=SqyUrMHmzMzH3H72p/sXXDTA+69WVCq9ySTsxOnID91QHv+HE8J+7KhjZO6DpzXe9Wir7+mPs/0GSaxA6fz//GhgtGNpZX2psbLVAJ2tIti22M/shzEIL1DobHrbWIrMaj64ujxDFTF0KV5wnZgIkWoq9DPvkSr/RoLsiyzNpjgIaRvRSMDpBiS+YoZ8Vi5x1X3mdC69rL7V2s2GXWMS0XojYqJXc/rAMYfrbYrmYWKrZXqwEk/3088PgW96wzJxL2yr45crk/1qe6d2A9JD7mmXUpBfvf90PPXN0ywDrpCaF+2UDqykohhR5ytNQLxZ9cvFD3qOXQ0Jb2h3koSb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775158853; c=relaxed/relaxed;
	bh=KS4S9kc/FU21u9E+yXN73X7A8UrqMOTWwcVhtNC0AVs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DZ/raD67t4l+hvact1xYu0r5KyQ8SqT/frcfxCT6s3nb7hhXbJwhzOb/XThgLjz0ib6tUPy1f+uotKNv9MnxNOcX5iC6CRDRxd7aZ06vC2X5l8Z+WyQifIzQSnezWEl4mKzoFP1CArhneg0RofkRORdURshI9cTpl7BSQ7vwdYC+xh9E279BJnj/M5GJf9API23YvFtuXWR4jBX0V07fS45NolOuqE5dDDOgx7bHT1fvCY2Z3KJ6vPTrWAoNXdlwTUAiDuR8Ahf3tJhWSSGzurTa+l7UiAu6wD2gjU7jeifWE3z+2HgEoxAH2acUQPk22lfNmYpYTuSGeXO3AzzQMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GVokGxBM; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GVokGxBM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmsfB6Q54z2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 06:40:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775158852; x=1806694852;
  h=date:from:to:cc:subject:message-id;
  bh=W4YcQ3+q9g2WU6TgP0LdlHYvyig4DKViKEYJhjwHCDw=;
  b=GVokGxBMHlv+yo6MQ8SpehOEzrj1su/rUJ+z81p2F59Z5X+j/+c+NJBg
   6ohDmeUo2F0X3OzMkWh7821rCcUQRoAKS2gkPr7e323hz/bEJF5BOCMBy
   SFJuIB6mH2Td/aX0xSEUfgcTPyhI2nfEu11xhWnc/ycXBg0moEo5J4pQA
   KvJztyoLS4z486mTSJf5UDDKcnKrQW98TmuxpDzT4MYREOtrj8TeM81qV
   NC/xhuWZ50CEO9VJ9DH8ZFq/Ije63bhfLjiRGaWl5Xt1Yc+eKyDs+wCXX
   opxdaz4PqHJVkJ6bFVP4oXkunc/D5lkrLJ16jo7ttopQstbFjqEuWVNP8
   A==;
X-CSE-ConnectionGUID: W/NZPsQ1T9STwI8hG8aw/Q==
X-CSE-MsgGUID: q+8ZflTJQ0u+C8dDuna2Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75946060"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75946060"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 12:40:45 -0700
X-CSE-ConnectionGUID: N5ysZ7GVSmesJVGXepv26A==
X-CSE-MsgGUID: ggI7tPEURCe4n+AyBcZybQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="257542651"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Apr 2026 12:40:43 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8NuC-000000000Mf-1wBm;
	Thu, 02 Apr 2026 19:40:40 +0000
Date: Fri, 03 Apr 2026 03:39:47 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes-test] BUILD SUCCESS
 328335a79487ec38d6b0e1aa807785b0f75e594d
Message-ID: <202604030338.LyaSdb91-lkp@intel.com>
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
branch HEAD: 328335a79487ec38d6b0e1aa807785b0f75e594d  powerpc/powernv/iommu: iommu incorrectly bypass DMA APIs

elapsed time: 744m

configs tested: 190
configs skipped: 328

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260402    gcc-11.5.0
arc                   randconfig-002-20260402    gcc-11.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                         orion5x_defconfig    clang-23
arm                   randconfig-001-20260402    gcc-11.5.0
arm                   randconfig-002-20260402    gcc-11.5.0
arm                   randconfig-003-20260402    gcc-11.5.0
arm                   randconfig-004-20260402    gcc-11.5.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260402    gcc-15.2.0
arm64                 randconfig-002-20260402    gcc-15.2.0
arm64                 randconfig-003-20260402    gcc-15.2.0
arm64                 randconfig-004-20260402    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260402    gcc-15.2.0
csky                  randconfig-002-20260402    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260402    clang-18
hexagon               randconfig-001-20260403    clang-23
hexagon               randconfig-002-20260402    clang-18
hexagon               randconfig-002-20260403    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260402    clang-20
i386        buildonly-randconfig-001-20260403    gcc-14
i386        buildonly-randconfig-002-20260402    clang-20
i386        buildonly-randconfig-002-20260403    gcc-14
i386        buildonly-randconfig-003-20260402    clang-20
i386        buildonly-randconfig-003-20260403    gcc-14
i386        buildonly-randconfig-004-20260402    clang-20
i386        buildonly-randconfig-004-20260403    gcc-14
i386        buildonly-randconfig-005-20260402    clang-20
i386        buildonly-randconfig-005-20260403    gcc-14
i386        buildonly-randconfig-006-20260402    clang-20
i386        buildonly-randconfig-006-20260403    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260402    clang-20
i386                  randconfig-002-20260402    clang-20
i386                  randconfig-003-20260402    clang-20
i386                  randconfig-004-20260402    clang-20
i386                  randconfig-005-20260402    clang-20
i386                  randconfig-006-20260402    clang-20
i386                  randconfig-007-20260402    clang-20
i386                  randconfig-011-20260402    clang-20
i386                  randconfig-012-20260402    clang-20
i386                  randconfig-013-20260402    clang-20
i386                  randconfig-014-20260402    clang-20
i386                  randconfig-015-20260402    clang-20
i386                  randconfig-016-20260402    clang-20
i386                  randconfig-017-20260402    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260402    clang-18
loongarch             randconfig-001-20260403    clang-23
loongarch             randconfig-002-20260402    clang-18
loongarch             randconfig-002-20260403    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260402    clang-18
nios2                 randconfig-001-20260403    clang-23
nios2                 randconfig-002-20260402    clang-18
nios2                 randconfig-002-20260403    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260402    clang-20
parisc                randconfig-002-20260402    clang-20
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260402    clang-20
powerpc               randconfig-002-20260402    clang-20
powerpc64             randconfig-001-20260402    clang-20
powerpc64             randconfig-002-20260402    clang-20
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260402    clang-23
riscv                 randconfig-002-20260402    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260402    clang-23
s390                  randconfig-002-20260402    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260402    clang-23
sh                    randconfig-002-20260402    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260402    gcc-14
sparc                 randconfig-002-20260402    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260402    gcc-14
sparc64               randconfig-002-20260402    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260402    gcc-14
um                    randconfig-002-20260402    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260402    clang-20
x86_64      buildonly-randconfig-002-20260402    clang-20
x86_64      buildonly-randconfig-003-20260402    clang-20
x86_64      buildonly-randconfig-004-20260402    clang-20
x86_64      buildonly-randconfig-005-20260402    clang-20
x86_64      buildonly-randconfig-006-20260402    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260402    gcc-14
x86_64                randconfig-002-20260402    gcc-14
x86_64                randconfig-003-20260402    gcc-14
x86_64                randconfig-004-20260402    gcc-14
x86_64                randconfig-005-20260402    gcc-14
x86_64                randconfig-006-20260402    gcc-14
x86_64                randconfig-011-20260402    clang-20
x86_64                randconfig-012-20260402    clang-20
x86_64                randconfig-013-20260402    clang-20
x86_64                randconfig-014-20260402    clang-20
x86_64                randconfig-015-20260402    clang-20
x86_64                randconfig-016-20260402    clang-20
x86_64                randconfig-071-20260402    clang-20
x86_64                randconfig-072-20260402    clang-20
x86_64                randconfig-073-20260402    clang-20
x86_64                randconfig-074-20260402    clang-20
x86_64                randconfig-075-20260402    clang-20
x86_64                randconfig-076-20260402    clang-20
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
xtensa                randconfig-001-20260402    gcc-14
xtensa                randconfig-002-20260402    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

