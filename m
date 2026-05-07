Return-Path: <linuxppc-dev+bounces-20581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56FACD37AA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 22:34:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBRrt1kkBz2xLr;
	Fri, 08 May 2026 08:34:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778193294;
	cv=none; b=DNfiFlQ+ji+Bjw+YGz4F53YCI9QB2mlFEGF3OUU+c+aNRHPrksR3TBhHEEA4IIe+p52P7+dRK5UatsE54WTGWs5eOCY7I1hjIcqvLGzU9XwHXhIpj0CcJnPA4KzpMzsN1YAHUupCnysyiB4KIicmr1LiK2QtnAz+ATWZZxjuJ36OzN0cHNMQ5wA4DB9c7u4dMVYhwzi/kRNRvvaQe0hFpKeXcEVBgcGorhaRIXBkk9WqVU76hq2hXZ9bmat6DasZUcn7F8qsZi2LP6TzKJRQZLcLEhkokgvbctFVv/Cy5cjQU2Z0yD7APOyU95Wm9qWkjMHh7L57FfIHlzjuw3FoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778193294; c=relaxed/relaxed;
	bh=jrvKFXQms2tz6vQHLZQAvhlajfm5nl38j8Vs+sh76fI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NaRPJZ2/IZgG31/aPHElcRq9ZYaRfBSPgQFK0Ev4GTUAzsy4JYIun7STqfSNy7oMh4A/OlFaj8jh2XqJnMqknx/Ey+3fU2AcrmjboViuvPLyBdhoCmCyPhSpVFdGlh6fq9I0m2ThyvN2LpU1GAeQpJUD1+Slr+/owcycJB4HTmTptG8CFm3GvYIPb9CmVVO6l+lFhL0/dG2r6fQTTqxjPD0P0Sx5uZhHyZCIXN0PCQ+qM/4ibZcCCLYZGys0AvPG5jw5zPkmUhXT8Ri9oMCOv7iZcxS+bQSlkf0zeI2sIU1LwjF+ipwe67GIoiKpffMhw4dyVr96PdnaCLK7X1a9bA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hcLPrpST; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hcLPrpST;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBRrp5TQCz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 08:34:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778193291; x=1809729291;
  h=date:from:to:cc:subject:message-id;
  bh=Nda0Jo7oRWGRi8PmhI9ZN6mMmWsIS5YaCVag7WJzCQM=;
  b=hcLPrpSTykH/1ZBvKG5OQBwatzEZvzvjBr1Kn0Qe2Un5ZOXEcYhHkMvr
   W0Ir6es7rWKVf00VhlIF2qUn1FeDGppA5hF0CI7LXEXGlnuessX+w4VhR
   mYALrwq4mTaUdfmiWg3VpMRx/2xFPbfl4FPlzDdSS1lnOPnn2ia1NhMWb
   +aISiTSVuGsjPNsXK0pygZw2fKGR8g3QwEDC9YVLfR0SjgwrsydiJn/jM
   ZViYF6JIRzlEW+UFEEZxBUvIF6hf6WKlE91sMI3O9Sc8uBOvFIdrQNNJ/
   X1esnvaqYDhDv0BOBsdsRNYKG/Y3zhb1Zt3vlJPppW9xWelbXjdCoqmCN
   Q==;
X-CSE-ConnectionGUID: 30SBisdvTP6+O0qE7w41Mw==
X-CSE-MsgGUID: oC/yqG+ISQawvKWhN7JYqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96726516"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="96726516"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 15:34:46 -0700
X-CSE-ConnectionGUID: xb3Kr27NRu2g7wO/kY19ng==
X-CSE-MsgGUID: +Qtx3HuXRL2d4wcFKNzIFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="235762873"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 May 2026 15:34:45 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wL7Io-000000000X9-07lQ;
	Thu, 07 May 2026 22:34:42 +0000
Date: Fri, 08 May 2026 06:33:55 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 2e16485a3286c4e603873c40d13adc73bdbe3845
Message-ID: <202605080649.dXLL1U08-lkp@intel.com>
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
branch HEAD: 2e16485a3286c4e603873c40d13adc73bdbe3845  Automatic merge of 'fixes' into merge (2026-05-07 15:41)

elapsed time: 726m

configs tested: 233
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

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
arc                   randconfig-001-20260507    gcc-14.3.0
arc                   randconfig-002-20260507    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-002-20260507    gcc-14.3.0
arm                   randconfig-004-20260507    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260507    gcc-15.2.0
arm64                 randconfig-001-20260508    gcc-14.3.0
arm64                 randconfig-002-20260507    gcc-15.2.0
arm64                 randconfig-002-20260508    gcc-14.3.0
arm64                 randconfig-003-20260507    gcc-15.2.0
arm64                 randconfig-003-20260508    gcc-14.3.0
arm64                 randconfig-004-20260507    gcc-15.2.0
arm64                 randconfig-004-20260508    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260507    gcc-15.2.0
csky                  randconfig-001-20260508    gcc-14.3.0
csky                  randconfig-002-20260507    gcc-15.2.0
csky                  randconfig-002-20260508    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260507    clang-23
hexagon               randconfig-002-20260507    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260507    clang-20
i386        buildonly-randconfig-001-20260507    gcc-14
i386        buildonly-randconfig-001-20260508    gcc-14
i386        buildonly-randconfig-002-20260507    clang-20
i386        buildonly-randconfig-002-20260507    gcc-14
i386        buildonly-randconfig-002-20260508    gcc-14
i386        buildonly-randconfig-003-20260507    clang-20
i386        buildonly-randconfig-003-20260507    gcc-14
i386        buildonly-randconfig-003-20260508    gcc-14
i386        buildonly-randconfig-004-20260507    clang-20
i386        buildonly-randconfig-004-20260507    gcc-14
i386        buildonly-randconfig-004-20260508    gcc-14
i386        buildonly-randconfig-005-20260507    clang-20
i386        buildonly-randconfig-005-20260508    gcc-14
i386        buildonly-randconfig-006-20260507    clang-20
i386        buildonly-randconfig-006-20260507    gcc-14
i386        buildonly-randconfig-006-20260508    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260507    gcc-14
i386                  randconfig-001-20260508    gcc-14
i386                  randconfig-002-20260507    gcc-14
i386                  randconfig-002-20260508    gcc-14
i386                  randconfig-003-20260507    gcc-14
i386                  randconfig-003-20260508    gcc-14
i386                  randconfig-004-20260507    gcc-14
i386                  randconfig-004-20260508    gcc-14
i386                  randconfig-005-20260507    gcc-14
i386                  randconfig-005-20260508    gcc-14
i386                  randconfig-006-20260507    gcc-14
i386                  randconfig-006-20260508    gcc-14
i386                  randconfig-007-20260507    gcc-14
i386                  randconfig-007-20260508    gcc-14
i386                  randconfig-011-20260507    clang-20
i386                  randconfig-011-20260507    gcc-14
i386                  randconfig-012-20260507    clang-20
i386                  randconfig-013-20260507    clang-20
i386                  randconfig-013-20260507    gcc-14
i386                  randconfig-014-20260507    clang-20
i386                  randconfig-014-20260507    gcc-14
i386                  randconfig-015-20260507    clang-20
i386                  randconfig-016-20260507    clang-20
i386                  randconfig-016-20260507    gcc-14
i386                  randconfig-017-20260507    clang-20
i386                  randconfig-017-20260507    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260507    clang-23
loongarch             randconfig-002-20260507    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260507    clang-23
nios2                 randconfig-002-20260507    clang-23
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
parisc                randconfig-001-20260507    gcc-8.5.0
parisc                randconfig-001-20260508    gcc-9.5.0
parisc                randconfig-002-20260507    gcc-8.5.0
parisc                randconfig-002-20260508    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260507    gcc-8.5.0
powerpc               randconfig-001-20260508    gcc-9.5.0
powerpc               randconfig-002-20260507    gcc-8.5.0
powerpc               randconfig-002-20260508    gcc-9.5.0
powerpc64             randconfig-001-20260507    gcc-8.5.0
powerpc64             randconfig-001-20260508    gcc-9.5.0
powerpc64             randconfig-002-20260507    gcc-8.5.0
powerpc64             randconfig-002-20260508    gcc-9.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-12.5.0
sparc                 randconfig-001-20260507    gcc-12.5.0
sparc                          randconfig-002    gcc-12.5.0
sparc                 randconfig-002-20260507    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260507    gcc-12.5.0
sparc64                        randconfig-002    gcc-12.5.0
sparc64               randconfig-002-20260507    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-12.5.0
um                    randconfig-001-20260507    gcc-12.5.0
um                             randconfig-002    gcc-12.5.0
um                    randconfig-002-20260507    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260507    clang-20
x86_64      buildonly-randconfig-002-20260507    clang-20
x86_64      buildonly-randconfig-003-20260507    clang-20
x86_64      buildonly-randconfig-004-20260507    clang-20
x86_64      buildonly-randconfig-005-20260507    clang-20
x86_64      buildonly-randconfig-006-20260507    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260507    gcc-14
x86_64                randconfig-001-20260508    clang-20
x86_64                randconfig-002-20260507    gcc-14
x86_64                randconfig-002-20260508    clang-20
x86_64                randconfig-003-20260507    gcc-14
x86_64                randconfig-003-20260508    clang-20
x86_64                randconfig-004-20260507    gcc-14
x86_64                randconfig-004-20260508    clang-20
x86_64                randconfig-005-20260507    gcc-14
x86_64                randconfig-005-20260508    clang-20
x86_64                randconfig-006-20260507    gcc-14
x86_64                randconfig-006-20260508    clang-20
x86_64                randconfig-011-20260507    gcc-14
x86_64                randconfig-012-20260507    gcc-14
x86_64                randconfig-013-20260507    gcc-14
x86_64                randconfig-014-20260507    gcc-14
x86_64                randconfig-015-20260507    gcc-14
x86_64                randconfig-016-20260507    gcc-14
x86_64                randconfig-071-20260507    clang-20
x86_64                randconfig-072-20260507    clang-20
x86_64                randconfig-073-20260507    clang-20
x86_64                randconfig-074-20260507    clang-20
x86_64                randconfig-075-20260507    clang-20
x86_64                randconfig-076-20260507    clang-20
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
xtensa                         randconfig-001    gcc-12.5.0
xtensa                randconfig-001-20260507    gcc-12.5.0
xtensa                         randconfig-002    gcc-12.5.0
xtensa                randconfig-002-20260507    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

