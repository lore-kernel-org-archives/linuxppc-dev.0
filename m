Return-Path: <linuxppc-dev+bounces-24037-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D201CC43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 02:22:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxstN6C0Vz2yH4;
	Sat, 11 Jul 2026 12:22:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783736572;
	cv=none; b=jORjmtymgzAu4xeDacsc5lPoxRZpv8Njwm0AG/THTvuPjI6wyMZyZO032U7guEwGnZnjeyTnY5Pp3bFrSPTvWRLD5NaM8BoP2b2OPPYMEkjLCdf3bmCSu0i4uQjcT8Muxl1pRlhVSccUy5FbGItUkZj5HPj77WJLxfKDy8B265xi9WjDCfPhIAbVChlenx3nFr6fUa8TLedtWEbp9X54unCYNGs/BNqgFoPmUAwefWq7rM0KYwZeZYR2j8UhmTrcHUxyq0lCjGtmHCRfPpjyBolBm4/yLacJ35rFnTxa8C1YmtDeQph//juzeyxWCY4GEqIsS95dWbhiAXlG3GUtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783736572; c=relaxed/relaxed;
	bh=RMyLEaQ6fN7+3tjj7cctLmSFee4JakMlc4IP1Zl+azQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VV+B+G2B+Xr55Pn10emymQrkwTc25jfs+6x5IP19HmBsH9tdtcU24+Ok3T3b/1J1UAi04Pp+I90omDcjb3fyff2H1Fzw3AmjOUTjXMsKA15zN+jaN4AVB06T8Fg4IJCGAyzoXgnmkiWvJXk2Oj0GDui00+L7v3fTo9qIcxAvxNIbvmIJoY797d6Q0+qGD8GYAJmhscw2oJiDimY9PoRIoZtJSLgWj6dz7kuK+otk2DSVQaDO3rpd5u+EFsxgqDQY4cUZ53wpwUfgR9E14/ZG9lDLqhNyviu/oJ3cgE9rxPsJSiRWrHytCP8N2r2rEyVE/uXfkh8lhrpDwJYzSleS1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wvt9zQhK; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wvt9zQhK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxstK6Pjvz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 12:22:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783736570; x=1815272570;
  h=date:from:to:cc:subject:message-id;
  bh=VK3IcAc8oxI9nIYhpuvuoaw5qB4IVwZwoyG21u3nZFw=;
  b=Wvt9zQhKQO4ker8aith9Sk2egJcoEjFCUqob1TAdBHwT2RU6nv8MGbwx
   aymQ7qV60rnUMZou1qP0FCAdO8UAere3b6Em5B+2RVQzTwSpB8daJh7FW
   vOJw876sAgSal5LRvay1bXrS4QIawZrP+NoFZSQdJkfshEfUVBhfFvTqb
   pcJGwC7Djy2EFY/CzLeJghuVhBMY8PQ5UK5fuGw8hDDRGoyR/GoaLVoYg
   qCcylVPWFjMQok122nnLwXDv5/+Wa1LiSAw0QhPlthw0rhaRO4uUVELnR
   4ULEaXlk2peNqtspdHYPzAAxtOuTbEizSftI8LamoOvju4+LOc3r6yoZz
   w==;
X-CSE-ConnectionGUID: gKs973MAR7G8VuJpfEAU7g==
X-CSE-MsgGUID: GZDbm8ChQEygzz82yb81/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71957721"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71957721"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 19:22:44 -0700
X-CSE-ConnectionGUID: 7IoYhTeaQdGXPdkF+Pa59Q==
X-CSE-MsgGUID: q4mfPUtJRwmF6IsSUkXIwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258912367"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 10 Jul 2026 19:22:42 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiNMV-00000000JeG-3Ooz;
	Sat, 11 Jul 2026 02:22:39 +0000
Date: Sat, 11 Jul 2026 10:22:15 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes-test] BUILD REGRESSION
 afc2830892a128a13a65f677271a0a48aeb61b5e
Message-ID: <202607111002.IHTkbYML-lkp@intel.com>
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
branch HEAD: afc2830892a128a13a65f677271a0a48aeb61b5e  powerpc/syscall: Fix syscall skip handling for seccomp and ptrace

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202607110141.nUx3NKwu-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202607110422.frjmJOf8-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202607110847.u4TL0RJC-lkp@intel.com

    arch/powerpc/include/asm/ptrace.h:241:31: error: implicit declaration of function 'BIT' [-Werror=implicit-function-declaration]
    arch/powerpc/include/asm/ptrace.h:241:33: error: implicit declaration of function 'BIT' [-Werror=implicit-function-declaration]
    arch/powerpc/include/asm/ptrace.h:241:33: error: implicit declaration of function 'BIT' [-Wimplicit-function-declaration]
    include/linux/static_call.h:223:9: warning: data definition has no type or storage class
    kernel/sched/core.c:7449:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    kernel/sched/core.c:7449:1: warning: parameter names (without types) in function declaration
    kernel/sched/core.c:7449:26: error: a parameter list without types is only allowed in a function definition
    kernel/sched/core.c:7453:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    kernel/sched/core.c:7453:26: error: a parameter list without types is only allowed in a function definition
    kernel/sched/core.c:7455:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    kernel/sched/core.c:7455:26: error: a parameter list without types is only allowed in a function definition

Error/Warning ids grouped by kconfigs:

recent_errors
|-- powerpc-allnoconfig
|   `-- arch-powerpc-include-asm-ptrace.h:error:implicit-declaration-of-function-BIT
|-- powerpc-randconfig-001
|   `-- arch-powerpc-include-asm-ptrace.h:error:implicit-declaration-of-function-BIT
|-- powerpc-randconfig-001-20260711
|   |-- arch-powerpc-include-asm-ptrace.h:error:implicit-declaration-of-function-BIT
|   |-- include-linux-static_call.h:warning:data-definition-has-no-type-or-storage-class
|   `-- kernel-sched-core.c:warning:parameter-names-(without-types)-in-function-declaration
|-- powerpc-randconfig-002
|   `-- arch-powerpc-include-asm-ptrace.h:error:implicit-declaration-of-function-BIT
|-- powerpc-randconfig-002-20260711
|   |-- kernel-sched-core.c:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   `-- kernel-sched-core.c:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- powerpc-randconfig-r071-20260711
|   |-- kernel-sched-core.c:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   `-- kernel-sched-core.c:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- powerpc-randconfig-r112-20260711
|   |-- kernel-sched-core.c:error:a-parameter-list-without-types-is-only-allowed-in-a-function-definition
|   `-- kernel-sched-core.c:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
`-- powerpc-randconfig-r113-20260711
    `-- arch-powerpc-include-asm-ptrace.h:error:implicit-declaration-of-function-BIT

elapsed time: 723m

configs tested: 189
configs skipped: 191

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260711    gcc-13.4.0
arc                   randconfig-002-20260711    gcc-13.4.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                           omap1_defconfig    gcc-16.1.0
arm                   randconfig-001-20260711    gcc-13.4.0
arm                   randconfig-002-20260711    gcc-13.4.0
arm                   randconfig-003-20260711    gcc-13.4.0
arm                   randconfig-004-20260711    gcc-13.4.0
arm                        vexpress_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260711    gcc-16.1.0
arm64                 randconfig-002-20260711    gcc-16.1.0
arm64                 randconfig-003-20260711    gcc-16.1.0
arm64                 randconfig-004-20260711    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260711    gcc-16.1.0
csky                  randconfig-002-20260711    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260711    gcc-16.1.0
hexagon               randconfig-002-20260711    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260711    gcc-14
i386        buildonly-randconfig-002-20260711    gcc-14
i386        buildonly-randconfig-003-20260711    gcc-14
i386        buildonly-randconfig-004-20260711    gcc-14
i386        buildonly-randconfig-005-20260711    gcc-14
i386        buildonly-randconfig-006-20260711    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260711    clang-22
i386                  randconfig-002-20260711    clang-22
i386                  randconfig-003-20260711    clang-22
i386                  randconfig-004-20260711    clang-22
i386                  randconfig-005-20260711    clang-22
i386                  randconfig-006-20260711    clang-22
i386                  randconfig-007-20260711    clang-22
i386                  randconfig-011-20260711    gcc-13
i386                  randconfig-012-20260711    gcc-13
i386                  randconfig-013-20260711    gcc-13
i386                  randconfig-014-20260711    gcc-13
i386                  randconfig-015-20260711    gcc-13
i386                  randconfig-016-20260711    gcc-13
i386                  randconfig-017-20260711    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260711    gcc-16.1.0
loongarch             randconfig-002-20260711    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                malta_qemu_32r6_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260711    gcc-16.1.0
nios2                 randconfig-002-20260711    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    clang-17
parisc                         randconfig-001    gcc-10.5.0
parisc                randconfig-001-20260711    clang-17
parisc                randconfig-001-20260711    gcc-10.5.0
parisc                         randconfig-002    clang-17
parisc                         randconfig-002    gcc-10.5.0
parisc                randconfig-002-20260711    clang-17
parisc                randconfig-002-20260711    gcc-10.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    clang-17
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260711    clang-17
powerpc               randconfig-001-20260711    gcc-10.5.0
powerpc               randconfig-001-20260711    gcc-11.5.0
powerpc                        randconfig-002    clang-17
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260711    clang-17
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260711    clang-17
powerpc64             randconfig-001-20260711    gcc-10.5.0
powerpc64                      randconfig-002    clang-17
powerpc64                      randconfig-002    gcc-10.5.0
powerpc64             randconfig-002-20260711    clang-17
powerpc64             randconfig-002-20260711    gcc-10.5.0
powerpc64             randconfig-002-20260711    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260711    gcc-8.5.0
riscv                 randconfig-002-20260711    gcc-8.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260711    gcc-8.5.0
s390                  randconfig-002-20260711    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260711    gcc-8.5.0
sh                    randconfig-002-20260711    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260711    gcc-16.1.0
sparc                 randconfig-002-20260711    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260711    gcc-16.1.0
sparc64               randconfig-002-20260711    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260711    gcc-16.1.0
um                    randconfig-002-20260711    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260711    gcc-14
x86_64      buildonly-randconfig-002-20260711    gcc-14
x86_64      buildonly-randconfig-003-20260711    gcc-14
x86_64      buildonly-randconfig-004-20260711    gcc-14
x86_64      buildonly-randconfig-005-20260711    gcc-14
x86_64      buildonly-randconfig-006-20260711    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260711    gcc-14
x86_64                randconfig-002-20260711    gcc-14
x86_64                randconfig-003-20260711    gcc-14
x86_64                randconfig-004-20260711    gcc-14
x86_64                randconfig-005-20260711    gcc-14
x86_64                randconfig-006-20260711    gcc-14
x86_64                randconfig-011-20260711    gcc-14
x86_64                randconfig-012-20260711    gcc-14
x86_64                randconfig-013-20260711    gcc-14
x86_64                randconfig-014-20260711    gcc-14
x86_64                randconfig-015-20260711    gcc-14
x86_64                randconfig-016-20260711    gcc-14
x86_64                randconfig-071-20260711    gcc-14
x86_64                randconfig-072-20260711    gcc-14
x86_64                randconfig-073-20260711    gcc-14
x86_64                randconfig-074-20260711    gcc-14
x86_64                randconfig-075-20260711    gcc-14
x86_64                randconfig-076-20260711    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260711    gcc-16.1.0
xtensa                randconfig-002-20260711    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

