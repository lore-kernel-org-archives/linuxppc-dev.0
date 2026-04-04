Return-Path: <linuxppc-dev+bounces-19298-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F7CE88D6E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 00:49:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fncRP50hDz2ySc;
	Sat, 04 Apr 2026 11:49:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775263745;
	cv=none; b=PRCjqUQ6P5+/sh5ezFN5fG/p94Xu8CeysW6zddpIwlEEc1/mOl9EFbNQGbMU5M1lav9MmkdK1IFs4i9GBbYp6e3nywjRk271+c38mrWgaVCEFsrcxE/QMp+3x035sLLosXMtax+zde59kn+votA/DUV5hhi5y8v7tytc4DWQoAlud3P7fNNjtl87/whURan9SVRfNNLeFJAIjjcUrs6qJsX3TUUQbXnIo88TKz6ketXrDoB8DlBZlxOEdv3W7e/+r56nVvC0CC3uvuPZrvhpf0yrrSVu1usmXwuFAr85qTtB1Mg6drPyz3M6wODuwxPQgeRlVWK84Jlkmk5L+rsCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775263745; c=relaxed/relaxed;
	bh=dN8TBpoipWJBT338PeNEO45GMfmix4Ly3TtoZHmY8Q4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y2f/wsk0sKzwdKBipCfKAXCTpen03T3e/FRee9hBlfg6T/hcPNLe2Sy/uImhv0kherXUo/9WpLnmd4otpx2pgxyQ1aZG4rR5REguiLkiS69rqCqtsJlpEmGNFOtwY7/Tk1XxUCt3ps3yKqEmw2Kf+n/5r09WLsDLIWvIbBL4+ZtxJE+bGgO4V+x/TzDw1wfFYguHrbh0xQ9EeCtiJ2Df8ijfthKX9nAvDMzEWL+UbO+lbx9q9n0tkqZx3OdS3Fx3ChsSze4T3Pqi5NmI9PuttIs95VHgO4vci9LcDr0JtsR91/WtHPNqBl0B3YINVVcBVGOgdfQeXRC8WnaMBe3rZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jCzRO29I; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jCzRO29I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fncRK6bF7z2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 11:48:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775263743; x=1806799743;
  h=date:from:to:cc:subject:message-id;
  bh=AMy/+m7G7qnPlgm+mBJCIHAEC6fmfz4/6nmwG2vgu5Q=;
  b=jCzRO29Ix6wBS3lXv2OyK2PWw7RnBSt5D5T4AoBkuCa0NbaqTWkR5D2N
   J6BKrv19PFC09Mtk/4XvbFPb0Eii1Fy4xhUC1dXPWZ43XiUpvtfWMzKM4
   aYCN1wGKtercrkqYDPASIUuWarkVbK9w7Z7dQPalHmRKkZuFBSNp2KsVU
   DRbXUURxuJEoBi3x6qzfzi0cikpwW22WXed+jGSTPTk+nmAxXiP1tXpmE
   4VxSq07Ptp8AlKWMvYjIUKBw8O3BjZ8yPQtMLjI+d4gOPo2X/fCo79O7L
   kziRXH3YKldaQBaw9gsw9DFfBv1JWShrlfQGDAiff+5T0/7JwFHgqHEX6
   w==;
X-CSE-ConnectionGUID: IoCgNGsUSdSAuvIaFLE6tg==
X-CSE-MsgGUID: nhEb0IXgS82Yv6/J1WhxAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76043289"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76043289"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 17:48:55 -0700
X-CSE-ConnectionGUID: iWMTDXA4S3CFniqN26N6/A==
X-CSE-MsgGUID: GnOsj0qtTJ6xP+3kV3hBaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="229006214"
Received: from lkp-server01.sh.intel.com (HELO 3afb7d003cac) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Apr 2026 17:48:53 -0700
Received: from kbuild by 3afb7d003cac with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8pBy-000000000OD-2mpl;
	Sat, 04 Apr 2026 00:48:50 +0000
Date: Sat, 04 Apr 2026 08:48:22 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 691dd9c01863b8b6ae525c28ea2b046e3781b7c6
Message-ID: <202604040813.3I0j9Ng2-lkp@intel.com>
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
branch HEAD: 691dd9c01863b8b6ae525c28ea2b046e3781b7c6  Automatic merge of 'next' into merge (2026-04-03 13:48)

elapsed time: 790m

configs tested: 314
configs skipped: 3

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
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260403    clang-23
loongarch             randconfig-001-20260404    gcc-15.2.0
loongarch             randconfig-002-20260403    clang-23
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
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260403    clang-23
nios2                 randconfig-001-20260404    gcc-15.2.0
nios2                 randconfig-002-20260403    clang-23
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
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260403    clang-23
riscv                 randconfig-001-20260403    gcc-10.5.0
riscv                 randconfig-001-20260404    clang-20
riscv                 randconfig-002-20260403    clang-23
riscv                 randconfig-002-20260403    gcc-10.5.0
riscv                 randconfig-002-20260404    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260403    clang-23
s390                  randconfig-001-20260404    clang-20
s390                  randconfig-002-20260403    clang-18
s390                  randconfig-002-20260403    clang-23
s390                  randconfig-002-20260404    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                        apsh4ad0a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260403    clang-23
sh                    randconfig-001-20260403    gcc-13.4.0
sh                    randconfig-001-20260404    clang-20
sh                    randconfig-002-20260403    clang-23
sh                    randconfig-002-20260403    gcc-15.2.0
sh                    randconfig-002-20260404    clang-20
sh                           se7751_defconfig    gcc-15.2.0
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
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260403    clang-20
um                    randconfig-001-20260404    clang-20
um                    randconfig-002-20260403    clang-20
um                    randconfig-002-20260403    gcc-14
um                    randconfig-002-20260404    clang-20
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260403    clang-20
xtensa                randconfig-001-20260403    gcc-9.5.0
xtensa                randconfig-001-20260404    clang-20
xtensa                randconfig-002-20260403    clang-20
xtensa                randconfig-002-20260403    gcc-8.5.0
xtensa                randconfig-002-20260404    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

