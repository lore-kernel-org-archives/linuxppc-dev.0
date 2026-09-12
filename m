Return-Path: <linuxppc-dev+bounces-27165-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2051EC88E45
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 04:04:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhd8S19D8z2xkr;
	Sat, 12 Sep 2026 14:04:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789185864;
	cv=none; b=bz0OdqgjUiXohtyRqehtopGo20GlLna+bnEZ253oldmIudHOwszGiFrNoT5UVp1G0N+cb6IBj5Ho9zmKcIuY2vAgCf9rH7D8/9IwhFmRoO/OVW+m7ZZOP1fnrzUEUifvUp4xe5n/E9d5m/lcvbRfojXOtDXSV204Ctj5AH7szdnVVSfFg2+g5Q3LHBx5rH/l1xRMoYNA3PgtPzo9Ts6+yUC9W8004RXVrQsBa1mrE4qRSDVgx9zVohl1ZIr+egOKnD8jJZAiH8EgK0u8eo1BhfnVQ/nZTLa4Z4nyRJuQ73mcml/TG/hJrQpiUAZ5S8L2cG24WkHLUsJEPfZFgpU2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789185864; c=relaxed/relaxed;
	bh=22JBKO0oxFosGYESimbmqXLJSoykgnvbyeSbxhA1Y+w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WtypQ0BG9IzxODCbEmduakjoIQR5U43jgF/lWaVzzSsHEN6YGi28EaIaNYZ9hZuuxlH4GLPALUL/Knp2Sd15UczzuUW3VM6eTFZvql1VDq75F0sJjfsEb4U+Xd3FkhdI3LgTr82DCOt/psklEadfuZsb6+3lb/VS+klzYRIF3zUjkkdJmlMPx8FtMctjCY4KBgcJ9hPVrGqwp2qjn/JyAbGXfZIrf7FF0jPO43tjoVt3FcA55SfAlsPhg2KwvRqUf8JC5+l0FkuP/+mjN1hn572B3qBol69pEB4jfXTOdFjcKWrcKThLvsSP0lGv2QCXIdxhYWtvGMlyK9bUgKmq+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R0DM5q9E; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R0DM5q9E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhd8N63Kxz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 14:04:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789185861; x=1820721861;
  h=date:from:to:cc:subject:message-id;
  bh=IAsLuvgrXnVhRaflqmgarPmz5i/vpoYmrRIDgnMyy9M=;
  b=R0DM5q9EMocKY4kVOBUv0H8NIkAGtSJx3fd5y52ut0eLYeylVR5fyLnS
   JLf5BfxMd6m9Ivn32nuSMBajEFJzC2ojpiIl5sVK0KtTVqGMSt25yBz3Q
   RBCa+M6tA0OmX3DjfuhgwUsfcEJBO+1c3bEqCHJ0dx5rQ84dvMgPhDk3W
   AbsEGtS/+ni5BqIsF6anX5zGONFo6/+ZKRWwAnsXELbYUDbh73EoStIkl
   FiBnoZ+/qo3otUx04ob6OFBqk/2zLtQoByu6DKLss0nsewqPHosgpN2VY
   dqkCu34tsxglKJJYSX50dZq16712YT872oOc+MgiZUjc/n9I31qum6oZl
   g==;
X-CSE-ConnectionGUID: jO4tE4VXQQGZrMtQKIKbRw==
X-CSE-MsgGUID: F1Ba+EKOQjay4S1wEhYfyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="112414966"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="112414966"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 21:04:14 -0700
X-CSE-ConnectionGUID: 1zrN8HGMS72ttYEKrxtgDg==
X-CSE-MsgGUID: MJctUwb2Q0uWIk+eVIgt8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="481429"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by fmviesa013.fm.intel.com with ESMTP; 11 Sep 2026 21:04:13 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x5ExZ-000000002bW-33cX;
	Sat, 12 Sep 2026 04:03:32 +0000
Date: Sat, 12 Sep 2026 12:01:42 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 2a0bdd1b03b21c53093da2c55edb630f4fde7d9a
Message-ID: <202609121238.aM9MwZc7-lkp@intel.com>
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
branch HEAD: 2a0bdd1b03b21c53093da2c55edb630f4fde7d9a  Automatic merge of 'fixes' into merge (2026-09-11 12:07)

elapsed time: 1255m

configs tested: 222
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260912    clang-17
arc                   randconfig-002-20260912    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                            mps2_defconfig    clang-24
arm                   randconfig-001-20260912    clang-17
arm                   randconfig-002-20260912    clang-17
arm                   randconfig-003-20260912    clang-17
arm                   randconfig-004-20260912    clang-17
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260911    gcc-16.1.0
arm64                 randconfig-001-20260912    gcc-15.2.0
arm64                 randconfig-002-20260911    gcc-16.1.0
arm64                 randconfig-002-20260912    gcc-15.2.0
arm64                 randconfig-003-20260911    gcc-16.1.0
arm64                 randconfig-003-20260912    gcc-15.2.0
arm64                 randconfig-004-20260911    gcc-16.1.0
arm64                 randconfig-004-20260912    gcc-15.2.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260911    gcc-16.1.0
csky                  randconfig-001-20260912    gcc-15.2.0
csky                  randconfig-002-20260911    gcc-16.1.0
csky                  randconfig-002-20260912    gcc-15.2.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260912    clang-24
hexagon               randconfig-002-20260912    clang-24
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260912    gcc-14
i386        buildonly-randconfig-002-20260912    gcc-14
i386        buildonly-randconfig-003-20260912    gcc-14
i386        buildonly-randconfig-004-20260912    gcc-14
i386        buildonly-randconfig-005-20260912    gcc-14
i386        buildonly-randconfig-006-20260912    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260912    gcc-14
i386                  randconfig-002-20260912    gcc-14
i386                  randconfig-003-20260912    gcc-14
i386                  randconfig-004-20260912    gcc-14
i386                  randconfig-005-20260912    gcc-14
i386                  randconfig-006-20260912    gcc-14
i386                  randconfig-007-20260912    gcc-14
i386                  randconfig-011-20260911    clang-22
i386                  randconfig-011-20260912    gcc-14
i386                  randconfig-012-20260911    clang-22
i386                  randconfig-012-20260912    gcc-14
i386                  randconfig-013-20260911    clang-22
i386                  randconfig-013-20260912    gcc-14
i386                  randconfig-014-20260911    clang-22
i386                  randconfig-014-20260912    gcc-14
i386                  randconfig-015-20260911    clang-22
i386                  randconfig-015-20260912    gcc-14
i386                  randconfig-016-20260911    clang-22
i386                  randconfig-016-20260912    gcc-14
i386                  randconfig-017-20260911    clang-22
i386                  randconfig-017-20260912    gcc-14
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260912    clang-24
loongarch             randconfig-002-20260912    clang-24
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                                defconfig    clang-24
m68k                       m5235evb_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze                      mmu_defconfig    clang-24
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     decstation_defconfig    clang-24
mips                     decstation_defconfig    gcc-16.1.0
mips                      fuloong2e_defconfig    gcc-16.1.0
mips                           gcw0_defconfig    clang-24
mips                           jazz_defconfig    clang-24
mips                       rbtx49xx_defconfig    clang-24
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260912    clang-24
nios2                 randconfig-002-20260912    clang-24
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                            defconfig    gcc-16.1.0
openrisc                 simple_smp_defconfig    clang-24
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                generic-64bit_defconfig    clang-24
parisc                randconfig-001-20260912    clang-24
parisc                randconfig-002-20260912    clang-24
parisc64                         alldefconfig    gcc-16.1.0
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                    amigaone_defconfig    gcc-16.1.0
powerpc                        icon_defconfig    clang-24
powerpc                   lite5200b_defconfig    gcc-16.1.0
powerpc                     mpc5200_defconfig    clang-24
powerpc                     rainier_defconfig    clang-24
powerpc               randconfig-001-20260912    clang-24
powerpc               randconfig-002-20260912    clang-24
powerpc                  storcenter_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260912    clang-24
powerpc64             randconfig-002-20260912    clang-24
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260912    gcc-11.5.0
riscv                 randconfig-002-20260912    gcc-11.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260912    gcc-11.5.0
s390                  randconfig-002-20260912    gcc-11.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260912    gcc-11.5.0
sh                    randconfig-002-20260912    gcc-11.5.0
sh                      rts7751r2d1_defconfig    clang-24
sh                           se7206_defconfig    gcc-16.1.0
sh                           se7751_defconfig    clang-24
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260911    gcc-13.4.0
sparc                 randconfig-001-20260912    gcc-14.3.0
sparc                 randconfig-002-20260911    gcc-13.4.0
sparc                 randconfig-002-20260912    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260911    gcc-13.4.0
sparc64               randconfig-001-20260912    gcc-14.3.0
sparc64               randconfig-002-20260911    gcc-13.4.0
sparc64               randconfig-002-20260912    gcc-14.3.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260911    gcc-13.4.0
um                    randconfig-001-20260912    gcc-14.3.0
um                    randconfig-002-20260911    gcc-13.4.0
um                    randconfig-002-20260912    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    clang-24
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260911    gcc-14
x86_64      buildonly-randconfig-001-20260912    gcc-14
x86_64      buildonly-randconfig-002-20260911    gcc-14
x86_64      buildonly-randconfig-002-20260912    gcc-14
x86_64      buildonly-randconfig-003-20260911    gcc-14
x86_64      buildonly-randconfig-003-20260912    gcc-14
x86_64      buildonly-randconfig-004-20260911    gcc-14
x86_64      buildonly-randconfig-004-20260912    gcc-14
x86_64      buildonly-randconfig-005-20260911    gcc-14
x86_64      buildonly-randconfig-005-20260912    gcc-14
x86_64      buildonly-randconfig-006-20260911    gcc-14
x86_64      buildonly-randconfig-006-20260912    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260911    clang-22
x86_64                randconfig-002-20260911    clang-22
x86_64                randconfig-003-20260911    clang-22
x86_64                randconfig-004-20260911    clang-22
x86_64                randconfig-005-20260911    clang-22
x86_64                randconfig-006-20260911    clang-22
x86_64                randconfig-011-20260911    gcc-14
x86_64                randconfig-011-20260912    gcc-14
x86_64                randconfig-012-20260911    gcc-14
x86_64                randconfig-012-20260912    gcc-14
x86_64                randconfig-013-20260911    gcc-14
x86_64                randconfig-013-20260912    gcc-14
x86_64                randconfig-014-20260911    gcc-14
x86_64                randconfig-014-20260912    gcc-14
x86_64                randconfig-015-20260911    gcc-14
x86_64                randconfig-015-20260912    gcc-14
x86_64                randconfig-016-20260911    gcc-14
x86_64                randconfig-016-20260912    gcc-14
x86_64                randconfig-071-20260912    gcc-14
x86_64                randconfig-072-20260912    gcc-14
x86_64                randconfig-073-20260912    gcc-14
x86_64                randconfig-074-20260912    gcc-14
x86_64                randconfig-075-20260912    gcc-14
x86_64                randconfig-076-20260912    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260911    gcc-13.4.0
xtensa                randconfig-001-20260912    gcc-14.3.0
xtensa                randconfig-002-20260911    gcc-13.4.0
xtensa                randconfig-002-20260912    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

