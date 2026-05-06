Return-Path: <linuxppc-dev+bounces-20526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FEACD343B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 14:49:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9dZ63b5zz2xnM;
	Thu, 07 May 2026 00:49:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778078958;
	cv=none; b=CH05f8o5Us7pttw7ukhZHr7A/tbjwCyjNWLijHFVVW8/TTLh1AwBPnW4K13Qk7gqkzp8Q2NhK7UdvIVhJXrGAJQDvcKQzBvdYZ5e/xWB/enB84cLvkjUfBetxMmUXbwP9mMaB4zxvKUIbqmwDBbYE8am/5b6Ovwc/vED14sENfP16rPMbp77LbqLo77gKn3MlDdtyUG6GJzf75dFXOTXwrIuqaVphhg7UViviI/v/YPqHkaiy6DlgIKVQpX1C9i6gMTDHHikeE2v/vncb9nGHH2gFtUHxuKyELyqdqwjX8mlaGNssl3/UfUhZsoszATwl5r6eTolKBYKSHPqqwjYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778078958; c=relaxed/relaxed;
	bh=FkhxA4uiht2rFe88+dhWIyb8bJboyUopFB5nkH1D33Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aqrZSuzyml8zKN7h7GmWwV6ZFkiz9nRTpT1fpx6khTzDe2giXc8Tr+AFUyMtGCzFA+cnMd7RIJmvJZAWUaLU4sd816lPwrxKaKQAbidbHE+CQJbQvNDepCb7TdTSQJVYcxgnzEARpgasUsecBKxLdrSF7eRasKDslybUsMWyKKMbueqyzP/STVxgXWSgGpLB3KhSP3EW+Sj4eqCrtn4rFjlIxEc9l77hWs9f/q7n0eqmVJtYaIbLTqcrbbX2O1plEGGCCNsqMFHkIw+EZcgkKfs8rdL3o9XQoCw1D4bCm/HcIayY+tbNAfI6lhtq5Cnoq0xLK1MDBpnuLbNHBkAJ8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KSgaWmTZ; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KSgaWmTZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9dZ25VZ9z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 00:49:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778078956; x=1809614956;
  h=date:from:to:cc:subject:message-id;
  bh=iY4mA9aCBZBEWtCDp2sKZBNB61IJr/zbrH6slpm+seQ=;
  b=KSgaWmTZN2aVGzxWWhpLdOyiH65PTrXaMfj4uYrlqaBAhkvOKKTc4RjM
   3SUYMiKvSsV98iOgYLCZa1Kv0mJuo7ZJsRDWb18YC3Rpyp/Br0EcE4Hg/
   cF8SXUlw1peNRhb2wcEwytqz87Qw9mnAXQPtd9PAtNfsiQE3n9SwdVkD9
   IN2xfF+2Lcd+8I8tFBKJPfCarqUqTwHmZ2QdZkYw6Hdi2vLiE/sI9MxJV
   UrM5nGDWtqnrpfukltJxeErVyWFoADO+S2xPDqLJ/egWMcp768ELT3+ul
   Tb8o0WXYFRP+gbF5eQnCbGcmzWjWQJXk9q9r9AaxWxcagSBjIvwm7iM58
   g==;
X-CSE-ConnectionGUID: 2gadEP2zT8uqFhqfUYXiqg==
X-CSE-MsgGUID: D4u3qHf7S6KPbxyS7okCWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="101687257"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="101687257"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 07:49:10 -0700
X-CSE-ConnectionGUID: JjU+qQ9ASXil/crijODv4A==
X-CSE-MsgGUID: WD/HMsm9QsKqjLHjMuraBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="229760917"
Received: from lkp-server01.sh.intel.com (HELO 9ec114424ce8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 May 2026 07:49:08 -0700
Received: from kbuild by 9ec114424ce8 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKdYf-000000000zn-2xMx;
	Wed, 06 May 2026 14:49:05 +0000
Date: Wed, 06 May 2026 22:48:58 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes-test] BUILD SUCCESS
 f583bd5f64d40e083dde5bb22846c4d93e59d471
Message-ID: <202605062243.xWfCTpmw-lkp@intel.com>
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
branch HEAD: f583bd5f64d40e083dde5bb22846c4d93e59d471  powerpc/pasemi: Drop redundant res assignment

elapsed time: 724m

configs tested: 235
configs skipped: 254

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260506    gcc-12.5.0
arc                   randconfig-001-20260506    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260506    gcc-12.5.0
arc                   randconfig-002-20260506    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260506    gcc-12.5.0
arm                   randconfig-001-20260506    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260506    gcc-12.5.0
arm                   randconfig-002-20260506    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260506    gcc-12.5.0
arm                   randconfig-003-20260506    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260506    gcc-12.5.0
arm                   randconfig-004-20260506    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260506    gcc-15.2.0
arm64                 randconfig-002-20260506    gcc-15.2.0
arm64                 randconfig-003-20260506    gcc-15.2.0
arm64                 randconfig-004-20260506    gcc-15.2.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260506    gcc-15.2.0
csky                  randconfig-002-20260506    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260506    clang-23
hexagon               randconfig-001-20260506    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260506    clang-23
hexagon               randconfig-002-20260506    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260506    clang-20
i386        buildonly-randconfig-001-20260506    gcc-14
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260506    clang-20
i386        buildonly-randconfig-002-20260506    gcc-14
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260506    clang-20
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260506    clang-20
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260506    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260506    clang-20
i386        buildonly-randconfig-006-20260506    gcc-14
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260506    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260506    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260506    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260506    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260506    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260506    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260506    gcc-14
i386                  randconfig-011-20260506    clang-20
i386                  randconfig-012-20260506    clang-20
i386                  randconfig-013-20260506    clang-20
i386                  randconfig-014-20260506    clang-20
i386                  randconfig-015-20260506    clang-20
i386                  randconfig-016-20260506    clang-20
i386                  randconfig-017-20260506    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260506    clang-23
loongarch             randconfig-001-20260506    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260506    clang-23
loongarch             randconfig-002-20260506    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         apollo_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         db1xxx_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260506    clang-23
nios2                 randconfig-001-20260506    gcc-11.5.0
nios2                 randconfig-001-20260506    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260506    clang-23
nios2                 randconfig-002-20260506    gcc-11.5.0
nios2                 randconfig-002-20260506    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260506    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260506    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260506    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260506    gcc-13.4.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260506    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260506    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260506    gcc-8.5.0
riscv                          randconfig-002    gcc-8.5.0
riscv                 randconfig-002-20260506    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-8.5.0
s390                  randconfig-001-20260506    gcc-8.5.0
s390                           randconfig-002    gcc-8.5.0
s390                  randconfig-002-20260506    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                 kfr2r09-romimage_defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-8.5.0
sh                    randconfig-001-20260506    gcc-8.5.0
sh                             randconfig-002    gcc-8.5.0
sh                    randconfig-002-20260506    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260506    gcc-11.5.0
sparc                 randconfig-002-20260506    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260506    gcc-11.5.0
sparc64               randconfig-002-20260506    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260506    gcc-11.5.0
um                    randconfig-002-20260506    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260506    clang-20
x86_64      buildonly-randconfig-002-20260506    clang-20
x86_64      buildonly-randconfig-003-20260506    clang-20
x86_64      buildonly-randconfig-004-20260506    clang-20
x86_64      buildonly-randconfig-005-20260506    clang-20
x86_64      buildonly-randconfig-006-20260506    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260506    clang-20
x86_64                randconfig-001-20260506    gcc-13
x86_64                randconfig-002-20260506    clang-20
x86_64                randconfig-003-20260506    clang-20
x86_64                randconfig-004-20260506    clang-20
x86_64                randconfig-005-20260506    clang-20
x86_64                randconfig-005-20260506    gcc-13
x86_64                randconfig-006-20260506    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260506    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260506    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260506    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260506    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260506    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260506    clang-20
x86_64                randconfig-071-20260506    clang-20
x86_64                randconfig-072-20260506    clang-20
x86_64                randconfig-073-20260506    clang-20
x86_64                randconfig-074-20260506    clang-20
x86_64                randconfig-075-20260506    clang-20
x86_64                randconfig-076-20260506    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260506    gcc-11.5.0
xtensa                randconfig-002-20260506    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

