Return-Path: <linuxppc-dev+bounces-19446-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F880FEEF49
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:56:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqq640Dpzz2yZ3;
	Wed, 08 Apr 2026 00:56:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775573803;
	cv=none; b=AR2OuGmTXbDbBSZ4oP2QYJak5TSDjkSB5HNOmiI+0uzu1GSuGcJ7iQoyFJmZRUdiAQC6MeZv0hzmimJ8R36x0+wj2FSp+AJXn9cqsuRO+5/SIN/O5BZI2zrGzpSFECEp0Lpd+VWH0loRsMxPTE5bsrvBddzA7PdyynMO4/URdSjMWqp3LR6UrCJKtyf+zg4iOsryM8EZXKUR+/bxy62P+I3arTQvbjoKX4ZXsM0ksVQRS68SaNcgoGeN2JwNCybeCISvYdxDidm7a4WY9zAfhVxEjo8DhuTD5BGz342VfYFbYLinCq4v5DmGWq33OsOUd8O/Au+oXG3cxrPkjCzC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775573803; c=relaxed/relaxed;
	bh=q+kDPdztNBrx8nvQVPMY+1VnQwdWCfTxSEI+0MCOL2w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a6mW0Vur/wSVH8Sl0lCEsyUpVzWhZuKNfB3sTqx947aTJIjTGw6VYPqwuxx50N2j3BU8Mk2y98cKY0zRyLnKWY18rPGrjexdZFOSqQqxi44lykB4qm8fCx5JQsqT4JLDVHI1C09hoWEBAeKp0jhGOql4RQuo5uPiIuqELNlQ6Pl/Mi2JpEkCZxplo2W7t8H1TtbRtqd5XkdDn57C5aSSd3+2GznaJVY0DVrhz4SYOnir8dDrQy4XM3nPPx2QBf+sxt90b8KNKXqxqyd9QSlP+zj3+9oP7Eh6NcM1WJEzcecK27ow7Yt5saE7TAniL9KbO0cJFTzPq6eAAlnOZyPgsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BmPBVhBO; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BmPBVhBO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqq6067Txz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:56:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775573802; x=1807109802;
  h=date:from:to:cc:subject:message-id;
  bh=KmaawhOKmbLpTMtzOLI0GX2oqTyEmNo/DVq6xzccQ4s=;
  b=BmPBVhBOo6bvZNyuH66kOBiyvE6Rrr2N3l0Ore/6U120kwmpO1EWZDXm
   wi2SsY1g3tF0KckNjta3ysEOwg1cvvwqTjMwmYFeJW5idmt0q1Va1J6Vl
   EAAPk95OvtPniOrG84MoOW/XcMxYNC4Xz/dc3818CleAzjiqaiSc2aGO3
   ZFVy90K0POX01SS2NNh/z+RFb8C94byFLMUJfcB2/GotJAo0tGEjaZK74
   sUS8zem3I4sANUZafbGxRd4xuPQhuMSEAjR73hYerYp8avKgyVvAn74NR
   tU11Tmpyk/8VNjL2VseBQoHMIOc+IZao1cYKju4+VcZrIdf3dIWnM+37N
   w==;
X-CSE-ConnectionGUID: 65ClNemjTgysMbZcQ4z8bA==
X-CSE-MsgGUID: obYy36jYT6O/yYEOOr6nfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="99165496"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="99165496"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:56:35 -0700
X-CSE-ConnectionGUID: 4HcmxXBzSB+lQ36e/2AFSA==
X-CSE-MsgGUID: Iad6hgH1Tfe03LGQYRk0Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="232590138"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Apr 2026 07:56:33 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wA7qw-000000000hv-4Ben;
	Tue, 07 Apr 2026 14:56:30 +0000
Date: Tue, 07 Apr 2026 22:56:19 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 5c2c0bae18b1fdae463381215ba766709993615d
Message-ID: <202604072211.le31j2RQ-lkp@intel.com>
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
branch HEAD: 5c2c0bae18b1fdae463381215ba766709993615d  Automatic merge of 'next' into merge (2026-04-07 07:47)

elapsed time: 735m

configs tested: 183
configs skipped: 9

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
arc                   randconfig-001-20260407    clang-23
arc                   randconfig-002-20260407    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    clang-19
arm                        mvebu_v7_defconfig    clang-23
arm                   randconfig-001-20260407    clang-23
arm                   randconfig-002-20260407    clang-23
arm                   randconfig-003-20260407    clang-23
arm                   randconfig-004-20260407    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260407    gcc-9.5.0
arm64                 randconfig-002-20260407    gcc-9.5.0
arm64                 randconfig-003-20260407    gcc-9.5.0
arm64                 randconfig-004-20260407    gcc-9.5.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260407    gcc-9.5.0
csky                  randconfig-002-20260407    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260407    clang-23
hexagon               randconfig-002-20260407    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260407    clang-20
i386        buildonly-randconfig-002-20260407    clang-20
i386        buildonly-randconfig-003-20260407    clang-20
i386        buildonly-randconfig-004-20260407    clang-20
i386        buildonly-randconfig-005-20260407    clang-20
i386        buildonly-randconfig-006-20260407    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260407    gcc-14
i386                  randconfig-002-20260407    gcc-14
i386                  randconfig-003-20260407    gcc-14
i386                  randconfig-004-20260407    gcc-14
i386                  randconfig-005-20260407    gcc-14
i386                  randconfig-006-20260407    gcc-14
i386                  randconfig-007-20260407    gcc-14
i386                  randconfig-011-20260407    clang-20
i386                  randconfig-012-20260407    clang-20
i386                  randconfig-013-20260407    clang-20
i386                  randconfig-014-20260407    clang-20
i386                  randconfig-015-20260407    clang-20
i386                  randconfig-016-20260407    clang-20
i386                  randconfig-017-20260407    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260407    clang-23
loongarch             randconfig-002-20260407    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-15.2.0
nios2                 randconfig-001-20260407    clang-23
nios2                 randconfig-002-20260407    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                   de0_nano_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260407    gcc-10.5.0
parisc                randconfig-002-20260407    gcc-10.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      chrp32_defconfig    clang-19
powerpc                     mpc512x_defconfig    clang-23
powerpc               randconfig-001-20260407    gcc-10.5.0
powerpc               randconfig-002-20260407    gcc-10.5.0
powerpc64             randconfig-001-20260407    gcc-10.5.0
powerpc64             randconfig-002-20260407    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260407    clang-23
riscv                 randconfig-001-20260407    gcc-14.3.0
riscv                 randconfig-002-20260407    gcc-12.5.0
riscv                 randconfig-002-20260407    gcc-14.3.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260407    gcc-14.3.0
s390                  randconfig-002-20260407    clang-20
s390                  randconfig-002-20260407    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260407    gcc-13.4.0
sh                    randconfig-001-20260407    gcc-14.3.0
sh                    randconfig-002-20260407    gcc-14.3.0
sh                    randconfig-002-20260407    gcc-15.2.0
sh                           se7206_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260407    gcc-12
sparc                 randconfig-002-20260407    gcc-12
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260407    gcc-12
sparc64               randconfig-002-20260407    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260407    gcc-12
um                    randconfig-002-20260407    gcc-12
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260407    gcc-14
x86_64      buildonly-randconfig-002-20260407    gcc-14
x86_64      buildonly-randconfig-003-20260407    gcc-14
x86_64      buildonly-randconfig-004-20260407    gcc-14
x86_64      buildonly-randconfig-005-20260407    gcc-14
x86_64      buildonly-randconfig-006-20260407    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260407    gcc-14
x86_64                randconfig-002-20260407    gcc-14
x86_64                randconfig-003-20260407    gcc-14
x86_64                randconfig-004-20260407    gcc-14
x86_64                randconfig-005-20260407    gcc-14
x86_64                randconfig-006-20260407    gcc-14
x86_64                randconfig-011-20260407    clang-20
x86_64                randconfig-012-20260407    clang-20
x86_64                randconfig-013-20260407    clang-20
x86_64                randconfig-014-20260407    clang-20
x86_64                randconfig-015-20260407    clang-20
x86_64                randconfig-016-20260407    clang-20
x86_64                randconfig-071-20260407    clang-20
x86_64                randconfig-072-20260407    clang-20
x86_64                randconfig-073-20260407    clang-20
x86_64                randconfig-074-20260407    clang-20
x86_64                randconfig-075-20260407    clang-20
x86_64                randconfig-076-20260407    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260407    gcc-12
xtensa                randconfig-002-20260407    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

