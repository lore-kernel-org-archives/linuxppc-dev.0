Return-Path: <linuxppc-dev+bounces-18330-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D8BFEDA14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 19:30:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb29t0w2Rz2yjw;
	Wed, 18 Mar 2026 06:30:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773775842;
	cv=none; b=btH664szdMebgZK389rU0jJaFNzzp8O/pveyXRTJAF4nSGwtx+hnolCPq4Iyyg44viHRU4pM2P+975X8T92C+eaCPInv/WW7KN+Cj8M5dOu713Df53WeBjysK90md4UNwKM/K/2SLk7SXihIOSockQcbISEmrV77d9bUH44IirVUF0p7kNQYc5rO//HPw7lOAI2y4udgTf0x7fnQ1QnRlmHSb9Yw0UUwah9jSZ8rc77Ll0eywUChs1WojAZyya/b7H3xkIV/V8MXH2M27/a3hNP2MXjxlV0JX+JEtXZQJa/A705+HUW9Uo5Ey6WhwfefAVdeynwDQFjUbZycnnoF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773775842; c=relaxed/relaxed;
	bh=qtSvClU2eXqCmjKnTGW3W4JiVJtFN+kfQxTyrHA3aZY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T3YSLjdt1lazokVonCL8AN0rX/EE2EHZb/ElfeqiTn1yChtRNtFO7V4ePq4f3Gs0bnw/KZ7Xpf5ecsFwcyk4WbdHN3zCwZdd2Hmquqm182ZapnKlhpcm+N1yvaiMR0i8p5dFyqEgwLVBpM57r9zvk7uI7Sx/GrAIkv3QRvJwK9vVbtawsFrqTVsQbt1kH1p4SmzW/7G33G5pSQTvWr+1ELx2pbSP4jGXhxWnuiH1PO6KTUOQ87ONZHk2SBqdgyj74ZEVoT2rOkWuax45v0Wld4AxqGIZ+QsJfBQbdVWNQmoR2brATSgI1oBkUGhFdEWCzmqNU7NobhKCxEmT2OEU3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LlO/86h0; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LlO/86h0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb29q5yYTz2yjn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 06:30:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773775840; x=1805311840;
  h=date:from:to:cc:subject:message-id;
  bh=XZ09JYQuG4aAayn+g3KIuZQ83G5nhncIsJeGkxU7bus=;
  b=LlO/86h0QOXqW69nNfPEi5KU/8u8wlOYRxPVCleNVd1KZ0ppNODvf5aC
   LrKBMP4BQ3ZEsBJyPbRZbWHRrL9Jy42AbwR7t32+b0bVXET9Gzxd8WYtD
   OXAfVYzAbyJfvXqLFH+bEs8Ij/jrAHAyW7nJtiEOfnebohSuCqzimQJpu
   t72bYWht7HBX4n+RRfxG9gnbKt/dXxsr+iBuqLENC6QXg9+L99dM80iWF
   QFb6rzeCECcxURwMbAcdSY3RtCKZ6d+yT7Ono47lg7PvOp3CUNn2OZNrz
   syk+3VEEMDygtEgTLLY3qkJ/DZFmVP9QPfXVK7XCei95NHQoxfYbvAL6j
   w==;
X-CSE-ConnectionGUID: 9B6n0hG1R1uLBXQ7RFhMFw==
X-CSE-MsgGUID: oeLzlQ4oTGyWsYYEY7jmEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="62384076"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="62384076"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 12:30:34 -0700
X-CSE-ConnectionGUID: Hk7zZS6DTU2ptJiqelo2mA==
X-CSE-MsgGUID: OAXq5m2uSmevfCNuFtLqhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226833967"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Mar 2026 12:30:32 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2a7a-000000001sn-0zD3;
	Tue, 17 Mar 2026 19:30:30 +0000
Date: Wed, 18 Mar 2026 03:29:55 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 4f37907abd000cabf97ce728c8bff9b95ee0f663
Message-ID: <202603180349.jDQgNCJp-lkp@intel.com>
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
branch HEAD: 4f37907abd000cabf97ce728c8bff9b95ee0f663  Automatic merge of 'fixes' into merge (2026-03-16 17:27)

elapsed time: 1880m

configs tested: 198
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260317    clang-23
arc                   randconfig-002-20260317    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260317    clang-23
arm                   randconfig-002-20260317    clang-23
arm                   randconfig-003-20260317    clang-23
arm                   randconfig-004-20260317    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-002-20260317    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260317    gcc-8.5.0
hexagon               randconfig-002-20260317    gcc-8.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260317    clang-20
i386        buildonly-randconfig-002-20260317    clang-20
i386        buildonly-randconfig-003-20260317    clang-20
i386        buildonly-randconfig-004-20260317    clang-20
i386        buildonly-randconfig-005-20260317    clang-20
i386        buildonly-randconfig-006-20260317    clang-20
i386                  randconfig-001-20260317    gcc-14
i386                  randconfig-002-20260317    clang-20
i386                  randconfig-002-20260317    gcc-14
i386                  randconfig-003-20260317    gcc-14
i386                  randconfig-004-20260317    gcc-14
i386                  randconfig-005-20260317    gcc-14
i386                  randconfig-006-20260317    gcc-14
i386                  randconfig-007-20260317    clang-20
i386                  randconfig-007-20260317    gcc-14
i386                  randconfig-011-20260317    clang-20
i386                  randconfig-012-20260317    clang-20
i386                  randconfig-013-20260317    clang-20
i386                  randconfig-014-20260317    clang-20
i386                  randconfig-015-20260317    clang-20
i386                  randconfig-016-20260317    clang-20
i386                  randconfig-017-20260317    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260317    gcc-8.5.0
loongarch             randconfig-002-20260317    gcc-8.5.0
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
mips                 decstation_r4k_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260317    gcc-8.5.0
nios2                 randconfig-002-20260317    gcc-8.5.0
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
parisc                randconfig-001-20260317    gcc-11.5.0
parisc                randconfig-001-20260317    gcc-8.5.0
parisc                randconfig-002-20260317    gcc-14.3.0
parisc                randconfig-002-20260317    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260317    gcc-8.5.0
powerpc               randconfig-002-20260317    gcc-8.5.0
powerpc64             randconfig-001-20260317    gcc-8.5.0
powerpc64             randconfig-002-20260317    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260317    clang-23
riscv                 randconfig-001-20260317    gcc-10.5.0
riscv                 randconfig-002-20260317    gcc-10.5.0
riscv                 randconfig-002-20260317    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260317    gcc-10.5.0
s390                  randconfig-001-20260317    gcc-15.2.0
s390                  randconfig-002-20260317    clang-23
s390                  randconfig-002-20260317    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260317    gcc-10.5.0
sh                    randconfig-001-20260317    gcc-15.2.0
sh                    randconfig-002-20260317    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260317    gcc-12.5.0
sparc                 randconfig-001-20260317    gcc-8.5.0
sparc                 randconfig-002-20260317    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260317    clang-23
sparc64               randconfig-001-20260317    gcc-12.5.0
sparc64               randconfig-002-20260317    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260317    clang-23
um                    randconfig-001-20260317    gcc-12.5.0
um                    randconfig-002-20260317    clang-23
um                    randconfig-002-20260317    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260317    clang-20
x86_64      buildonly-randconfig-002-20260317    gcc-14
x86_64      buildonly-randconfig-003-20260317    clang-20
x86_64      buildonly-randconfig-004-20260317    clang-20
x86_64      buildonly-randconfig-005-20260317    clang-20
x86_64      buildonly-randconfig-006-20260317    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260317    clang-20
x86_64                randconfig-002-20260317    clang-20
x86_64                randconfig-003-20260317    clang-20
x86_64                randconfig-004-20260317    clang-20
x86_64                randconfig-005-20260317    clang-20
x86_64                randconfig-006-20260317    clang-20
x86_64                randconfig-011-20260317    clang-20
x86_64                randconfig-011-20260317    gcc-14
x86_64                randconfig-012-20260317    clang-20
x86_64                randconfig-013-20260317    clang-20
x86_64                randconfig-014-20260317    clang-20
x86_64                randconfig-014-20260317    gcc-14
x86_64                randconfig-015-20260317    clang-20
x86_64                randconfig-016-20260317    clang-20
x86_64                randconfig-071-20260317    clang-20
x86_64                randconfig-072-20260317    clang-20
x86_64                randconfig-073-20260317    clang-20
x86_64                randconfig-074-20260317    clang-20
x86_64                randconfig-075-20260317    clang-20
x86_64                randconfig-076-20260317    clang-20
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
xtensa                randconfig-001-20260317    gcc-12.5.0
xtensa                randconfig-001-20260317    gcc-9.5.0
xtensa                randconfig-002-20260317    gcc-11.5.0
xtensa                randconfig-002-20260317    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

