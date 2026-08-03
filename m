Return-Path: <linuxppc-dev+bounces-25224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBB6C5516F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 04:20:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD3Q124YDz2yFP;
	Mon, 03 Aug 2026 14:20:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785730857;
	cv=none; b=f4r25deZrScGFk07Zko6FfESQWHs0nHytb+WGZN1R0qEa2oUEWjnt1M4Lj25dESUuXL/IQp/NVKDyJCH83ww3lZQAcWQDXAxYNj2n4mVX0c5ob9CJjSEiw3YKF7mEf8BNqdNZNZGpZKa+wJSya3QFDCwqbAxec6jMBzf7zvOA4EkfgrhVUbYdWfZEF1wIVYXmS58KiU+OSLPCRMZ7Fowu/IDkjHeJ5LGsKLacz35vy/HZIhyp9y6pQifQAz5/ACuOG6oriFt435Cs47o+/k1NuCTlBGrOaPuzzEcCr8ApPj/Muue95lAulIZxYpfCDHaxLRmyrlZcwHarJZv6zq7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785730857; c=relaxed/relaxed;
	bh=Jf7BpioRJs2pb1FUHgnV5ivZYoIz2L22QV29+EVlZoA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TlEQH81rT7EkA8VmqXS9anPa08cjSpeTG6PlgkSEOv3hTp0amt13DM5XNqXPDVE6zFF4ZAutH1LHH6O1qZmQpRswdOV/jmnlxsVm6sMoQ760mYymCmH0bOu1Df+7/ghSeFHcArzD1m3qq0Uo6UqfNO8RDra603YjeugDtltZZoj8BJVFmU1a9Qc+afLLCGCQ97mBQUtSnG5zKxEKZWZPDy9CDD/KjKJiXjzgFbILycm5AZmGG4lG6wWiMGnFhx57q5XPo9vH5AmdFhdiCAytK84L4XdY3HlrvaOD8sxfCMlf9fU36y4wQgGIVxmbre8M3iX9NfyZoxe327AgqNT7jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HvWxqEK5; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HvWxqEK5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD3Py5vD3z2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:20:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785730855; x=1817266855;
  h=date:from:to:cc:subject:message-id;
  bh=U5vnQRFsS3FrEsxMawLRWAWvEouzis8NOsOhSICNuAI=;
  b=HvWxqEK50nW5IAKI9tq9NW2ICcvrmqkx98PZvHX79ecODWIAoHoHLsXB
   gRsX4o+zyZWCP8ISMVSjWVv4t7LXT48Y7KppqBmQE1LTBLeNJgKDVB4EW
   ajObcVvAAKEn0TJeGN3t+1XZoMRi1zTcNZwaTZ+ytRrGxEDeZ95VS76Fz
   d5aXIAjgdQjs5qY7Emfby1C0VwSYFpbp4AABxWW49wabEDajHpHPsKnLl
   6+EkCfHkNpY9LnllusKHofuePcoBLAMw1ufalvlqOpEdPx2aNPp2yi8KR
   9jYM2mJOTtOrUi1mTC6gajgzLKLBPyydNcWpdjiKJrpAWgniZAyMFI8qC
   g==;
X-CSE-ConnectionGUID: T+9n8d6nQi2H0pumLniBHg==
X-CSE-MsgGUID: PfwwwOpqSwSTm+BXFb4yYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="97633270"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="97633270"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 21:20:48 -0700
X-CSE-ConnectionGUID: iTleNeniTCubFRUtePJ8Nw==
X-CSE-MsgGUID: IHL+VHl7RXmzCrYsJSy2qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="285742534"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Aug 2026 21:20:47 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqkAO-0000000063i-0kq5;
	Mon, 03 Aug 2026 04:20:44 +0000
Date: Mon, 03 Aug 2026 12:19:44 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 e15474c8dfc2526f582e268565dd2af41c13b1ce
Message-ID: <202608031232.PkaZ8Wxl-lkp@intel.com>
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
branch HEAD: e15474c8dfc2526f582e268565dd2af41c13b1ce  Automatic merge of 'next' into merge (2026-08-02 14:09)

elapsed time: 748m

configs tested: 167
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260802    gcc-8.5.0
arc                  randconfig-001-20260803    gcc-8.5.0
arc                  randconfig-002-20260802    gcc-15.2.0
arc                  randconfig-002-20260803    gcc-8.5.0
arm                            mxs_defconfig    clang-17
arm                  randconfig-001-20260802    gcc-11.5.0
arm                  randconfig-001-20260803    gcc-8.5.0
arm                  randconfig-002-20260802    gcc-13.4.0
arm                  randconfig-002-20260803    gcc-8.5.0
arm                  randconfig-003-20260802    clang-24
arm                  randconfig-003-20260803    gcc-8.5.0
arm                  randconfig-004-20260802    gcc-13.4.0
arm                  randconfig-004-20260803    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260802    clang-18
arm64                randconfig-001-20260803    gcc-12.5.0
arm64                randconfig-002-20260802    gcc-15.2.0
arm64                randconfig-002-20260803    gcc-12.5.0
arm64                randconfig-003-20260802    gcc-13.4.0
arm64                randconfig-003-20260803    gcc-12.5.0
arm64                randconfig-004-20260802    gcc-8.5.0
arm64                randconfig-004-20260803    gcc-12.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260802    gcc-11.5.0
csky                 randconfig-001-20260803    gcc-12.5.0
csky                 randconfig-002-20260802    gcc-9.5.0
csky                 randconfig-002-20260803    gcc-12.5.0
hexagon              randconfig-001-20260802    clang-24
hexagon              randconfig-001-20260803    clang-18
hexagon              randconfig-002-20260802    clang-17
hexagon              randconfig-002-20260803    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260803    clang-22
i386       buildonly-randconfig-002-20260803    clang-22
i386       buildonly-randconfig-003-20260803    clang-22
i386       buildonly-randconfig-004-20260803    clang-22
i386       buildonly-randconfig-005-20260803    clang-22
i386       buildonly-randconfig-006-20260803    clang-22
i386                 randconfig-001-20260803    gcc-13
i386                 randconfig-002-20260803    gcc-13
i386                 randconfig-003-20260803    gcc-13
i386                 randconfig-004-20260803    gcc-13
i386                 randconfig-005-20260803    gcc-13
i386                 randconfig-006-20260803    gcc-13
i386                 randconfig-007-20260803    gcc-13
i386                 randconfig-011-20260802    clang-22
i386                 randconfig-011-20260803    clang-22
i386                 randconfig-012-20260802    clang-22
i386                 randconfig-012-20260803    clang-22
i386                 randconfig-013-20260802    clang-22
i386                 randconfig-013-20260803    clang-22
i386                 randconfig-014-20260802    clang-22
i386                 randconfig-014-20260803    clang-22
i386                 randconfig-015-20260802    clang-22
i386                 randconfig-015-20260803    clang-22
i386                 randconfig-016-20260802    gcc-14
i386                 randconfig-016-20260803    clang-22
i386                 randconfig-017-20260802    gcc-13
i386                 randconfig-017-20260803    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260802    gcc-16.1.0
loongarch            randconfig-001-20260803    clang-18
loongarch            randconfig-002-20260802    clang-24
loongarch            randconfig-002-20260803    clang-18
mips                          ci20_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260802    gcc-9.5.0
nios2                randconfig-001-20260803    clang-18
nios2                randconfig-002-20260802    gcc-11.5.0
nios2                randconfig-002-20260803    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260802    gcc-8.5.0
parisc               randconfig-001-20260803    gcc-15.2.0
parisc               randconfig-002-20260802    gcc-14.3.0
parisc               randconfig-002-20260803    gcc-15.2.0
powerpc              randconfig-001-20260802    gcc-8.5.0
powerpc              randconfig-001-20260803    gcc-15.2.0
powerpc              randconfig-002-20260802    clang-24
powerpc              randconfig-002-20260803    gcc-15.2.0
powerpc64            randconfig-001-20260802    gcc-10.5.0
powerpc64            randconfig-001-20260803    gcc-15.2.0
powerpc64            randconfig-002-20260802    clang-24
powerpc64            randconfig-002-20260803    gcc-15.2.0
riscv                randconfig-001-20260802    gcc-13.4.0
riscv                randconfig-001-20260803    gcc-8.5.0
riscv                randconfig-002-20260802    clang-24
riscv                randconfig-002-20260803    gcc-8.5.0
s390                 randconfig-001-20260802    clang-24
s390                 randconfig-001-20260803    gcc-8.5.0
s390                 randconfig-002-20260802    gcc-8.5.0
s390                 randconfig-002-20260803    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260802    gcc-11.5.0
sh                   randconfig-001-20260803    gcc-8.5.0
sh                   randconfig-002-20260802    gcc-13.4.0
sh                   randconfig-002-20260803    gcc-8.5.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260802    gcc-14.3.0
sparc                randconfig-001-20260803    gcc-16.1.0
sparc                randconfig-002-20260802    gcc-12.5.0
sparc                randconfig-002-20260803    gcc-16.1.0
sparc64              randconfig-001-20260802    clang-20
sparc64              randconfig-001-20260803    gcc-16.1.0
sparc64              randconfig-002-20260802    clang-22
sparc64              randconfig-002-20260803    gcc-16.1.0
um                   randconfig-001-20260802    gcc-14
um                   randconfig-001-20260803    gcc-16.1.0
um                   randconfig-002-20260802    clang-24
um                   randconfig-002-20260803    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260803    clang-22
x86_64     buildonly-randconfig-002-20260803    clang-22
x86_64     buildonly-randconfig-003-20260803    clang-22
x86_64     buildonly-randconfig-004-20260803    clang-22
x86_64     buildonly-randconfig-005-20260803    clang-22
x86_64     buildonly-randconfig-006-20260803    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260802    clang-22
x86_64               randconfig-001-20260803    gcc-14
x86_64               randconfig-002-20260802    gcc-14
x86_64               randconfig-002-20260803    gcc-14
x86_64               randconfig-003-20260802    gcc-14
x86_64               randconfig-003-20260803    gcc-14
x86_64               randconfig-004-20260802    clang-22
x86_64               randconfig-004-20260803    gcc-14
x86_64               randconfig-005-20260802    clang-22
x86_64               randconfig-005-20260803    gcc-14
x86_64               randconfig-006-20260802    clang-22
x86_64               randconfig-006-20260803    gcc-14
x86_64               randconfig-011-20260802    gcc-14
x86_64               randconfig-011-20260803    gcc-14
x86_64               randconfig-012-20260802    gcc-14
x86_64               randconfig-012-20260803    gcc-14
x86_64               randconfig-013-20260802    clang-22
x86_64               randconfig-013-20260803    gcc-14
x86_64               randconfig-014-20260802    clang-22
x86_64               randconfig-014-20260803    gcc-14
x86_64               randconfig-015-20260802    gcc-14
x86_64               randconfig-015-20260803    gcc-14
x86_64               randconfig-016-20260802    clang-22
x86_64               randconfig-016-20260803    gcc-14
x86_64               randconfig-071-20260802    gcc-14
x86_64               randconfig-071-20260803    clang-22
x86_64               randconfig-072-20260802    clang-22
x86_64               randconfig-072-20260803    clang-22
x86_64               randconfig-073-20260802    gcc-14
x86_64               randconfig-073-20260803    clang-22
x86_64               randconfig-074-20260802    gcc-14
x86_64               randconfig-074-20260803    clang-22
x86_64               randconfig-075-20260802    clang-22
x86_64               randconfig-075-20260803    clang-22
x86_64               randconfig-076-20260802    gcc-12
x86_64               randconfig-076-20260803    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260802    gcc-10.5.0
xtensa               randconfig-001-20260803    gcc-16.1.0
xtensa               randconfig-002-20260802    gcc-12.5.0
xtensa               randconfig-002-20260803    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

