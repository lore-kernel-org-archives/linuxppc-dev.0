Return-Path: <linuxppc-dev+bounces-19532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7F7F36BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 05:25:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsQHG3GGQz2yZ6;
	Fri, 10 Apr 2026 15:25:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775798714;
	cv=none; b=CjLdzUY5KXLvLRBR5/yJYS7lHKyMYR/3bkzNyJaJrqvVZnljJoeeIBY7OBpgTFv7I18kybFoA8u34sYSbdsAqS0ZyNHoUapnnOFU4Hb3ysy2Ad6w+Y1fhgC6VeShyfU1b1dbVUiCZo8X2nOoimAH85hYtAVBImugt8gpJy1118vos/XmohlNnrzpu2pZLARzdKGlUUKIGIHKUBH/23PBOpT+su51/CngJuHUJJAtJvH23SPeA1jj7u/qMtimPM7fbxxoG1/666iQY50nfkhhRGN2xLBVJU/2O9vKIUrzREl3AZZLjln28zUT1stGAsPvHTjU/zGrL16MwSgMAc5BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775798714; c=relaxed/relaxed;
	bh=lFtRIkHaoHxs8h9lNT4DKaBuFF0Sf2L27CeUB3NhMo0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VDmyELQ2yJj7x9Va4cBwLen5iA0t2kKcvv9WGDeQVPr9/HMR8GhNWlIQ5jqEDEE6GRdUw0MuYJpMR8O8dM3uTeDQzv0Z3rncS+qGaXFpfexTcJGNXC/XnRywJuWjBGe1NQXC7375MFWNtZU3lFcT/+ldkpen0gwFA6M8X39hJ1bYSOvnAvgAi2rXCCVUfAZY+swPshN4w0xwZwON3FXBj26OaFo3XNvzkjMsPXF3P/rsxeeRhTPU3QHTigZaP377YQnhYNJrahlxIMYZnXKP3unv/P/xUJZ59KU6Wo1WBPCSg70wW+nHKB4fzhSzEoHO/f2NuQZDxhzQrCZtrUCIPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bcZ2Rq9b; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bcZ2Rq9b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQHC4F2Sz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:25:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775798712; x=1807334712;
  h=date:from:to:cc:subject:message-id;
  bh=fF07AI2h/0LwqidNDVR6YYu//sv161Ak9H7uzaK1dRE=;
  b=bcZ2Rq9b3VAQTwsx8HSWBqa97bfAx4OllVpB2z6lRtRpBmn1DaxEYicx
   F+6T4ltUYuhpwaL1t121Pz/xVIi+jnQiBVnwouu1lsdPMRFPwq+eLnpS9
   vDNfWx4FMAxtB0Zsh8HGjTp2asflcppo8jVgQ5Ssycj8nQWHkcHH0AOJt
   8TafkCkOSyBlfhNdSpaENAdxwgFv4BM5LOjIXGsmlauyRd02u9ZDccKUx
   gLHKkKwEuuMJWUFkizME2MVmvpun0jr2Tfc+QUJx/2YrbQbT2N0jNR6fb
   kg63UEc9CQ0uY90/1UH1ZvyrjEIV7FD10LbjIDYhggaqtigQbyFxD1Q/Y
   A==;
X-CSE-ConnectionGUID: hDt3qE8XQJeLdxMToEYwkg==
X-CSE-MsgGUID: 0JC4kPJeTQ+LvEqr5PlmTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="94390187"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="94390187"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:25:05 -0700
X-CSE-ConnectionGUID: 88Z+Pc2iTJSzl9Z8Cvlshw==
X-CSE-MsgGUID: ijt5w2xmRP2P8+XBJpCBcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="222491825"
Received: from lkp-server01.sh.intel.com (HELO 6449335cace3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Apr 2026 22:25:04 -0700
Received: from kbuild by 6449335cace3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wB4MX-000000003HD-10De;
	Fri, 10 Apr 2026 05:25:01 +0000
Date: Fri, 10 Apr 2026 13:24:46 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 e6ef4eb871ed884f5f480579b2e5f4fc9d2cb003
Message-ID: <202604101340.1zsBA7Ep-lkp@intel.com>
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
branch HEAD: e6ef4eb871ed884f5f480579b2e5f4fc9d2cb003  powerpc32/bpf: fix loading fsession func metadata using PPC_LI32

elapsed time: 2913m

configs tested: 160
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260408    clang-23
arc                   randconfig-001-20260408    gcc-8.5.0
arc                   randconfig-002-20260408    clang-23
arc                   randconfig-002-20260408    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                         lpc18xx_defconfig    clang-23
arm                   randconfig-001-20260408    clang-23
arm                   randconfig-001-20260408    gcc-8.5.0
arm                   randconfig-002-20260408    clang-23
arm                   randconfig-003-20260408    clang-23
arm                   randconfig-004-20260408    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260408    gcc-14.3.0
arm64                 randconfig-002-20260408    gcc-14.3.0
arm64                 randconfig-003-20260408    gcc-14.3.0
arm64                 randconfig-004-20260408    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260408    gcc-14.3.0
csky                  randconfig-002-20260408    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260408    clang-23
hexagon               randconfig-002-20260408    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260408    clang-20
i386                  randconfig-002-20260408    clang-20
i386                  randconfig-003-20260408    clang-20
i386                  randconfig-004-20260408    clang-20
i386                  randconfig-005-20260408    clang-20
i386                  randconfig-006-20260408    clang-20
i386                  randconfig-007-20260408    clang-20
i386                  randconfig-011-20260408    gcc-14
i386                  randconfig-012-20260408    gcc-14
i386                  randconfig-013-20260408    gcc-14
i386                  randconfig-014-20260408    gcc-14
i386                  randconfig-015-20260408    gcc-14
i386                  randconfig-016-20260408    gcc-14
i386                  randconfig-017-20260408    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-002-20260408    clang-23
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
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260408    clang-23
nios2                 randconfig-002-20260408    clang-23
openrisc                         allmodconfig    gcc-11.5.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260408    gcc-8.5.0
parisc                randconfig-002-20260408    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                   motionpro_defconfig    clang-23
powerpc               randconfig-001-20260408    gcc-8.5.0
powerpc               randconfig-002-20260408    gcc-8.5.0
powerpc64             randconfig-001-20260408    gcc-8.5.0
powerpc64             randconfig-002-20260408    gcc-8.5.0
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260408    gcc-15.2.0
riscv                 randconfig-002-20260408    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260408    gcc-15.2.0
sh                    randconfig-002-20260408    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260408    gcc-14
sparc                 randconfig-002-20260408    gcc-14
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260408    gcc-14
sparc64               randconfig-002-20260408    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260408    gcc-14
um                    randconfig-002-20260408    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260408    clang-20
x86_64      buildonly-randconfig-002-20260408    clang-20
x86_64      buildonly-randconfig-003-20260408    clang-20
x86_64      buildonly-randconfig-004-20260408    clang-20
x86_64      buildonly-randconfig-005-20260408    clang-20
x86_64      buildonly-randconfig-006-20260408    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260408    gcc-12
x86_64                randconfig-002-20260408    gcc-12
x86_64                randconfig-003-20260408    gcc-12
x86_64                randconfig-004-20260408    gcc-12
x86_64                randconfig-005-20260408    gcc-12
x86_64                randconfig-006-20260408    gcc-12
x86_64                randconfig-011-20260408    clang-20
x86_64                randconfig-012-20260408    clang-20
x86_64                randconfig-013-20260408    clang-20
x86_64                randconfig-014-20260408    clang-20
x86_64                randconfig-015-20260408    clang-20
x86_64                randconfig-016-20260408    clang-20
x86_64                randconfig-071-20260408    clang-20
x86_64                randconfig-072-20260408    clang-20
x86_64                randconfig-073-20260408    clang-20
x86_64                randconfig-074-20260408    clang-20
x86_64                randconfig-075-20260408    clang-20
x86_64                randconfig-076-20260408    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    gcc-11.5.0
xtensa                randconfig-001-20260408    gcc-14
xtensa                randconfig-002-20260408    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

