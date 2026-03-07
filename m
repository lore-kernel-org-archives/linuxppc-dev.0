Return-Path: <linuxppc-dev+bounces-17867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912F7F55115
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Mar 2026 22:51:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSz6d4CV8z3bfG;
	Sun, 08 Mar 2026 09:51:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772923913;
	cv=none; b=MWzXEMSL4MuiX9KmLWYYwAn1fgg7mvnetC6yXKFvYYmxRlYGYL+r7vGcQEL5DfU+AFRFvy4j9+e+o9bl1pZqfTpPNIaouSGfI0SThzSA/UbJfO6yalaYNBk31oq4nIS6rf7Bp99kImP8l8YJvDFc4DNZqU+Q1QStttjKP9JxhP6IH9poaf4UGZuBKJvi1/yfa/7Gm4PhdeU5/eogqh+CcWwrpaRohLzidAhIePw4mO8KUz+e/w2MhDGSWNy5gVhnK+hrBCJ5klfurMIIcv/W/39A3w/syLP9tHsPkg6BpjFJ3fSEGY9vwxAbDmz0fMPQqbBH4XsbY1m0FHMDf8n55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772923913; c=relaxed/relaxed;
	bh=N0pTS62oPqREyNiOCojw+jr9E1vM+JQO6hKmk30epS0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RS3fX62U60nIV+eEUkbKCqMUnca35BGE8GhM8yk57yo/WaRjjvMuyiqnzfRNOyO56ErA5lyE6ZGSrXVapGU2kRrqgmRUbFBfn6C1vvBjhcUfnAgrs18CE2KDmfTd75RJt9IZKt/H4mT5BnYc28ue5UM8Kmg1H8wZyZmNkJnbI9vhnNzR+eMa7XV2twT6j6Eyrxf8BejDoxQrwhLKet+3oTXG9685XQ2uD0TnKy7txPylAB9HiV1qgrH+UYJNWP6hRyySIvkakGTHURgM3ubsqSRYP4vHk3mIeeTq4XguvPoz7+vhlZ/I4hT/CvdI53+VxRu+/4MQXjZnKpkGzXMTlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fj/p4DPi; dkim-atps=neutral; spf=temperror (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fj/p4DPi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSz6V6dbdz3bTf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2026 09:51:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772923907; x=1804459907;
  h=date:from:to:cc:subject:message-id;
  bh=2QJRlTQHntGb6egbDKqxZY5trhpKyoevhR4WlY1WZBQ=;
  b=Fj/p4DPi6MUPigKa6alNGP/WyrgijqyWdvOShp0y/m/5067D8DNsRMyk
   Pwng/XP3qsqGyeUlGePClQKyzFW3wT8ugAr1lidVNlixm0aNey+ng8XMi
   ChAG+ebfTcKG7b7Jf4rORY8ArC49qyMbkty9SED7a3oRBVXxeZfazgJ/1
   GbwhVB3h75RNSP80z00kXPUn9cdjvlPK/ypwUgMPjCXKGyMQTQ6oiHpOo
   6KeEqZctfhYHq+5kfAwrJLQh09aS+PMwR2xYbzxsl5gf+ZScGoWGgXL1U
   NS7e286RwpfYwZRrZWITWw31AjG0FZnKlEZtInZKl2lIPh3foRTPalvBt
   Q==;
X-CSE-ConnectionGUID: 5Dp+DSIUQdi+bK01AcFsQA==
X-CSE-MsgGUID: YT6jKHPfSrmnvPjICjcDqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73910985"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="73910985"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 14:51:21 -0800
X-CSE-ConnectionGUID: 4O4WePFMRx6YGTyAHgj8GQ==
X-CSE-MsgGUID: 7Z2/aldhSdiS47pv+KJTbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="249834472"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Mar 2026 14:51:19 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz0UO-000000002gr-3n4Y;
	Sat, 07 Mar 2026 22:51:16 +0000
Date: Sun, 08 Mar 2026 06:51:06 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes-test] BUILD SUCCESS
 35e4f2a17eb40288f9bcdb09549fa04a63a96279
Message-ID: <202603080600.rrPzsofW-lkp@intel.com>
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
branch HEAD: 35e4f2a17eb40288f9bcdb09549fa04a63a96279  powerpc/pseries: Correct MSI allocation tracking

elapsed time: 725m

configs tested: 162
configs skipped: 1

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
arc                   randconfig-001-20260308    gcc-11.5.0
arc                   randconfig-001-20260308    gcc-8.5.0
arc                   randconfig-002-20260308    gcc-10.5.0
arc                   randconfig-002-20260308    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260308    clang-17
arm                   randconfig-001-20260308    gcc-8.5.0
arm                   randconfig-002-20260308    gcc-8.5.0
arm                   randconfig-003-20260308    clang-18
arm                   randconfig-003-20260308    gcc-8.5.0
arm                   randconfig-004-20260308    clang-23
arm                   randconfig-004-20260308    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260308    gcc-15.2.0
arm64                 randconfig-002-20260308    clang-23
arm64                 randconfig-003-20260308    gcc-8.5.0
arm64                 randconfig-004-20260308    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260308    gcc-15.2.0
csky                  randconfig-002-20260308    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260308    clang-23
hexagon               randconfig-002-20260308    clang-16
hexagon               randconfig-002-20260308    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260308    clang-20
i386        buildonly-randconfig-002-20260308    clang-20
i386        buildonly-randconfig-003-20260308    clang-20
i386        buildonly-randconfig-004-20260308    clang-20
i386        buildonly-randconfig-005-20260308    clang-20
i386        buildonly-randconfig-006-20260308    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260308    gcc-13
i386                  randconfig-002-20260308    gcc-14
i386                  randconfig-003-20260308    gcc-14
i386                  randconfig-004-20260308    clang-20
i386                  randconfig-005-20260308    clang-20
i386                  randconfig-006-20260308    gcc-14
i386                  randconfig-007-20260308    clang-20
i386                  randconfig-013-20260308    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260308    clang-19
loongarch             randconfig-001-20260308    clang-23
loongarch             randconfig-002-20260308    clang-23
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
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260308    clang-23
nios2                 randconfig-001-20260308    gcc-11.5.0
nios2                 randconfig-002-20260308    clang-23
nios2                 randconfig-002-20260308    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260308    gcc-8.5.0
parisc                randconfig-002-20260308    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    clang-23
powerpc               randconfig-001-20260308    clang-23
powerpc               randconfig-002-20260308    gcc-8.5.0
powerpc64             randconfig-001-20260308    clang-23
powerpc64             randconfig-002-20260308    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260308    gcc-12.5.0
riscv                 randconfig-001-20260308    gcc-14.3.0
riscv                 randconfig-002-20260308    clang-23
riscv                 randconfig-002-20260308    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260308    gcc-12.5.0
s390                  randconfig-002-20260308    gcc-12.5.0
s390                  randconfig-002-20260308    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                    randconfig-001-20260308    gcc-12.5.0
sh                    randconfig-001-20260308    gcc-15.2.0
sh                    randconfig-002-20260308    gcc-12.5.0
sh                    randconfig-002-20260308    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260308    gcc-8.5.0
sparc                 randconfig-002-20260308    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260308    clang-20
sparc64               randconfig-002-20260308    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                    randconfig-001-20260308    gcc-14
um                    randconfig-002-20260308    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64                randconfig-011-20260308    gcc-14
x86_64                randconfig-012-20260308    gcc-14
x86_64                randconfig-013-20260308    gcc-14
x86_64                randconfig-014-20260308    gcc-14
x86_64                randconfig-015-20260308    clang-20
x86_64                randconfig-016-20260308    clang-20
x86_64                randconfig-071-20260308    gcc-14
x86_64                randconfig-072-20260308    gcc-14
x86_64                randconfig-073-20260308    gcc-14
x86_64                randconfig-074-20260308    gcc-14
x86_64                randconfig-075-20260308    gcc-14
x86_64                randconfig-076-20260308    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260308    gcc-11.5.0
xtensa                randconfig-002-20260308    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

