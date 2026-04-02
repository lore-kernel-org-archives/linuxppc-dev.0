Return-Path: <linuxppc-dev+bounces-19187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8BECC6B00
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 06:56:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmXh764ddz2ySk;
	Thu, 02 Apr 2026 17:56:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775112983;
	cv=none; b=cUwzwBYI72BfXIrb/GeN29QjnW0yge0z1nAMOWmh6c+y9Tp+GnzYRUnHw4Xlu+RBjpGaGlb4/FLx/7vy6/NaBUnDjHozGfQwSELmc9IR/xNsAbF+auiAwBCDPnmeEwC4UHhdN/TVJgJHR+wh8fT7xdC1CYIdLXeRk4gyiRCt6GsbSomXSOjevdwt912j8lb5+jF2NSja8X9YsjHh9f1dr919BhoJrCHbCY+YDUGn9z1fyjffy5VO+M/9/XhLA9Pp36w0S/AH/nr8s/ywCSfyZQR/2OJFGs8LKR/HD9kXR0GukCYCcnq6XdANotScRNNWHt2oZhYAEdIOVmqpnFjOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775112983; c=relaxed/relaxed;
	bh=cU4Lw2/Q5iTV2t0poXv6wqs6R+ejJmwebCXy21QPuzY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EfV3+Js7+GrYCrZDbxj01ZvX2X1gKIH3l3cbR9ypzP4TGX6sTPQ5mG//URAePNPBljeu1Cfp4lic3n+DsK/i7qy0ScuBDSOnIMjTKBdAdsVxQPewjVZa4p1LJzlk+32i0te+k32I22MBGImCjjA54Zbmpcynu+nDyA1DhaGY2ags5CA51tL/WXjSjcXiOhv+G7+l8wrOH3WHFpaKBC8MKROL/oT1aJkGHxpox22pDY2RvYXjuFcN6L9xUYnKPK619aAqpp+vG49f+AQtjNUsp8ge40HE48buRCxbr58yl9rX7iCdPAKFah+Mg9dtg2VPND6k6lMavWFqUWjxNvxY0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EnzHVM1o; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EnzHVM1o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmXh45FrBz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 17:56:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775112981; x=1806648981;
  h=date:from:to:cc:subject:message-id;
  bh=8cgO3rJzPUUNLxb8rpRU1Bh9iurRMBEoJ7Cl+3Df94g=;
  b=EnzHVM1oqjt6Xr+4hgNit3NZldsmAQT9/6qyVm7P6XiYuzoQQ5YbzFND
   hWrfeno8Fa+KGO7JYS/EXAVdwiSR/2cZ0fPe4RLZX3edh1fZml3kewtnG
   a/j+SKwxoxk+7YE3wzgPQ53M5j6OVqZoIq9eGgTge4asGJdBi665/cWnF
   /ty0a8svkBcPQifq11b+pUpiVXFyojPWAPrX+4xO4O9r6vSAStm3Kd4cr
   NDEi38PEU9LTht9zx4zarQq4/78oLg/g8GGQWc1oiEek1mvsFzUobS/Zh
   8TRdA6eQWEOMR7htptkDm4ZClx6OoiF3Doyzzvg9SifPniMKwKCmzqQkF
   A==;
X-CSE-ConnectionGUID: XxhpAZmSQMi8L7TO0FOrNg==
X-CSE-MsgGUID: lDHKnYDHSl6pMc6mkKsSwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80053901"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="80053901"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:56:14 -0700
X-CSE-ConnectionGUID: 3m4GOxn2R2OgIF29901v7w==
X-CSE-MsgGUID: Jaw3CMiwRzupxHU9j2K5VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="250106048"
Received: from lkp-server02.sh.intel.com (HELO cedfeeed6c12) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 01 Apr 2026 23:56:13 -0700
Received: from kbuild by cedfeeed6c12 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8ByG-000000000L3-0cxT;
	Thu, 02 Apr 2026 06:56:06 +0000
Date: Thu, 02 Apr 2026 12:39:15 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 bd77a34e9a619ee92c03cbb227ca86d814aa6601
Message-ID: <202604021209.HXGQioXv-lkp@intel.com>
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
branch HEAD: bd77a34e9a619ee92c03cbb227ca86d814aa6601  powerpc: pci-ioda: Optimize pnv_ioda_pick_m64_pe()

elapsed time: 1472m

configs tested: 153
configs skipped: 4

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
arc                   randconfig-001-20260402    gcc-13.4.0
arc                   randconfig-002-20260402    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                         bcm2835_defconfig    clang-23
arm                                 defconfig    clang-23
arm                   randconfig-001-20260402    clang-23
arm                   randconfig-002-20260402    gcc-11.5.0
arm                   randconfig-003-20260402    gcc-13.4.0
arm                   randconfig-004-20260402    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260401    clang-18
arm64                 randconfig-002-20260401    gcc-8.5.0
arm64                 randconfig-003-20260401    gcc-8.5.0
arm64                 randconfig-004-20260401    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260401    gcc-13.4.0
csky                  randconfig-002-20260401    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260401    clang-23
hexagon               randconfig-002-20260401    clang-17
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260402    clang-20
i386        buildonly-randconfig-002-20260402    gcc-13
i386        buildonly-randconfig-003-20260402    gcc-14
i386        buildonly-randconfig-004-20260402    clang-20
i386        buildonly-randconfig-005-20260402    gcc-13
i386        buildonly-randconfig-006-20260402    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260402    clang-20
i386                  randconfig-002-20260402    clang-20
i386                  randconfig-003-20260402    gcc-13
i386                  randconfig-004-20260402    clang-20
i386                  randconfig-005-20260402    clang-20
i386                  randconfig-006-20260402    clang-20
i386                  randconfig-007-20260402    clang-20
i386                  randconfig-011-20260401    clang-20
i386                  randconfig-012-20260401    clang-20
i386                  randconfig-013-20260401    clang-20
i386                  randconfig-014-20260401    clang-20
i386                  randconfig-015-20260401    clang-20
i386                  randconfig-016-20260401    gcc-14
i386                  randconfig-017-20260401    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-002-20260401    clang-23
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
nios2                 randconfig-001-20260401    gcc-8.5.0
nios2                 randconfig-002-20260401    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260401    gcc-8.5.0
parisc                randconfig-002-20260401    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260401    gcc-8.5.0
powerpc               randconfig-002-20260401    clang-18
powerpc64             randconfig-001-20260401    gcc-14.3.0
powerpc64             randconfig-002-20260401    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260402    clang-17
riscv                 randconfig-002-20260402    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260402    clang-23
s390                  randconfig-002-20260402    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260402    gcc-11.5.0
sh                    randconfig-002-20260402    gcc-13.4.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260402    gcc-8.5.0
sparc                 randconfig-002-20260402    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260402    gcc-10.5.0
sparc64               randconfig-002-20260402    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260402    gcc-14
um                    randconfig-002-20260402    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260402    clang-20
x86_64                randconfig-002-20260402    clang-20
x86_64                randconfig-003-20260402    gcc-14
x86_64                randconfig-004-20260402    gcc-14
x86_64                randconfig-005-20260402    clang-20
x86_64                randconfig-006-20260402    gcc-14
x86_64                randconfig-011-20260402    clang-20
x86_64                randconfig-012-20260402    clang-20
x86_64                randconfig-013-20260402    clang-20
x86_64                randconfig-014-20260402    gcc-14
x86_64                randconfig-015-20260402    clang-20
x86_64                randconfig-016-20260402    gcc-14
x86_64                randconfig-071-20260402    clang-20
x86_64                randconfig-072-20260402    clang-20
x86_64                randconfig-073-20260402    clang-20
x86_64                randconfig-074-20260402    clang-20
x86_64                randconfig-075-20260402    gcc-14
x86_64                randconfig-076-20260402    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260402    gcc-12.5.0
xtensa                randconfig-002-20260402    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

