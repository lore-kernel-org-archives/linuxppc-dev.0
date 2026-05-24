Return-Path: <linuxppc-dev+bounces-21438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF382CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2026 11:15:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gNbyj05L9z2yMl;
	Sun, 24 May 2026 21:15:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779621308;
	cv=none; b=i+bS3jWjtdvC2LIwuaDO58q6zh4pjycJ5gm178B83bIxRQbIuCuDqQ8RWopHmvpQgmGi/ARzvjxcbPM1lUXYcNoubA4gUH9SQb4W6WCQWl8BuUyjwReSxDzbqBMAnkNNpX0F1FuqdVRbMpf1MWWrQxglPjSmRQ6e94up5VGX4Je7qf2dAtyM4vxcYr4+t3n8+o73Eq+wPws8Ah15w/MUXEvO/uB0wXPu+A7d9Dz0shhHr+aNiBcRB6h6r4sp6ThvK2h7piN7R00B9bm+0xA2j22PDNfwQI8KLfOyZQls2RuNhNJ10OO7s+3JQNr0acVN3DneG+hJcGcoaND6yEcbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779621308; c=relaxed/relaxed;
	bh=0r0CQOVlkgRaKXzdzvOOdI8wFsHGvh1Ta2HAdwnh78A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jMvrJidPv5Mjrn3DYJvWcl5qH/1xbN+Qmp8f+6ee0Pm94BtcXVU/Gp9bYC1a4Odtq1E83plpru/+jO8O5tVkD80ha0YgkbScIcKzVucSoDeDTB+VoVrEzSk+wE2sT0mTPo4J3Z5hmiTqiS4WApty8Uvn1xab7EjsFZtR3lDH9sIXrVlnUYstglWZU1thumfzHVPn6k5suRtfNXal6qHFIG97IE7BQ0LuZ50quCupz+yEJqWS9OMT+gx52NPW69Nuc0zZF9zCBjLJs9mLMmRMo1k5fUeD6G3VOt5Pz+VCPpVR8kV9w6QQqj8o25HGnil5cWipixey/uVbea4LOHz+rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BdhTRprR; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BdhTRprR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gNbyd3SyMz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2026 21:15:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779621306; x=1811157306;
  h=date:from:to:cc:subject:message-id;
  bh=gZoxzRK7koPU8mHXZbbQaw8maKmFWD95AXbh29nVxWQ=;
  b=BdhTRprRzDRHesQB/j9YoYqv0KpkZHclsoI5MyeGNB7towSu8S+kFHAZ
   nvJM/Z8j386MUf/I8x3WKPQRKu+oqBpM9o3E6Jg4aNS2vKzmtoPnt/+Yz
   CTeN2YqLDP8mC37uDNXKoWI1HiGlWqpbK5soaDxCXFCxY+R6v2nPAn7L1
   yU+/Rf2UNIHPEuZ3GHt2MBEILUypwsF82/caHz8GbVts2YKfaVy54USqn
   fN5ZseR/HuPWiroZ3MCk3iJ8S3ggc2VVVBm4ldBOOBHcIhAgTWbqiYrU1
   LqJgxTpBKg2ZLuyKO6hk5LUkGhusj1Yd23ou4odltBvbsbv0NWWFC0XID
   g==;
X-CSE-ConnectionGUID: 3rZEadLYRr+A7ZvQ+E5eGA==
X-CSE-MsgGUID: fI30LwhkRUWLfvAtpG8moA==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="80382584"
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="80382584"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 04:14:57 -0700
X-CSE-ConnectionGUID: feC8FK1hTrirtbyePuHCBw==
X-CSE-MsgGUID: H3zapKtMRTS3VpwVPppZgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="234977264"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 May 2026 04:14:56 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wR6nF-0000000009H-3aKm;
	Sun, 24 May 2026 11:14:53 +0000
Date: Sun, 24 May 2026 19:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 3af068d1f05b10756292a435d6e90bdba83747d7
Message-ID: <202605241948.GFK5mm9L-lkp@intel.com>
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
branch HEAD: 3af068d1f05b10756292a435d6e90bdba83747d7  Automatic merge of 'next' into merge (2026-05-22 09:59)

elapsed time: 2786m

configs tested: 275
configs skipped: 11

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
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260523    gcc-10.5.0
arc                   randconfig-001-20260524    clang-23
arc                   randconfig-002-20260523    gcc-14.3.0
arc                   randconfig-002-20260524    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260523    gcc-10.5.0
arm                   randconfig-001-20260524    clang-23
arm                   randconfig-002-20260523    clang-19
arm                   randconfig-002-20260524    clang-23
arm                   randconfig-003-20260523    clang-23
arm                   randconfig-003-20260524    clang-23
arm                   randconfig-004-20260523    gcc-10.5.0
arm                   randconfig-004-20260524    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260523    gcc-15.2.0
arm64                 randconfig-002-20260523    gcc-8.5.0
arm64                 randconfig-003-20260523    gcc-9.5.0
arm64                 randconfig-004-20260523    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260523    gcc-9.5.0
csky                  randconfig-002-20260523    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260523    clang-23
hexagon               randconfig-001-20260524    gcc-8.5.0
hexagon               randconfig-002-20260523    clang-23
hexagon               randconfig-002-20260524    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260523    gcc-14
i386        buildonly-randconfig-001-20260524    gcc-14
i386        buildonly-randconfig-002-20260523    clang-20
i386        buildonly-randconfig-002-20260524    gcc-14
i386        buildonly-randconfig-003-20260523    gcc-14
i386        buildonly-randconfig-003-20260524    gcc-14
i386        buildonly-randconfig-004-20260523    gcc-12
i386        buildonly-randconfig-004-20260524    gcc-14
i386        buildonly-randconfig-005-20260523    clang-20
i386        buildonly-randconfig-005-20260524    gcc-14
i386        buildonly-randconfig-006-20260523    gcc-14
i386        buildonly-randconfig-006-20260524    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    clang-20
i386                  randconfig-001-20260523    gcc-14
i386                  randconfig-001-20260524    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260523    gcc-12
i386                  randconfig-002-20260524    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260523    gcc-14
i386                  randconfig-003-20260524    gcc-14
i386                           randconfig-004    clang-20
i386                  randconfig-004-20260523    gcc-12
i386                  randconfig-004-20260524    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260523    gcc-14
i386                  randconfig-005-20260524    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260523    gcc-14
i386                  randconfig-006-20260524    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260523    gcc-14
i386                  randconfig-007-20260524    gcc-14
i386                  randconfig-011-20260523    gcc-14
i386                  randconfig-012-20260523    gcc-14
i386                  randconfig-013-20260523    gcc-14
i386                  randconfig-014-20260523    clang-20
i386                  randconfig-015-20260523    clang-20
i386                  randconfig-016-20260523    clang-20
i386                  randconfig-017-20260523    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260523    gcc-15.2.0
loongarch             randconfig-001-20260524    gcc-8.5.0
loongarch             randconfig-002-20260523    gcc-15.2.0
loongarch             randconfig-002-20260524    gcc-8.5.0
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
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260523    gcc-11.5.0
nios2                 randconfig-001-20260524    gcc-8.5.0
nios2                 randconfig-002-20260523    gcc-9.5.0
nios2                 randconfig-002-20260524    gcc-8.5.0
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
parisc                randconfig-001-20260523    gcc-15.2.0
parisc                randconfig-001-20260524    clang-23
parisc                randconfig-002-20260523    gcc-9.5.0
parisc                randconfig-002-20260524    clang-23
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260523    gcc-15.2.0
powerpc               randconfig-001-20260524    clang-23
powerpc               randconfig-002-20260523    gcc-8.5.0
powerpc               randconfig-002-20260524    clang-23
powerpc64             randconfig-001-20260523    clang-16
powerpc64             randconfig-001-20260524    clang-23
powerpc64             randconfig-002-20260523    clang-20
powerpc64             randconfig-002-20260524    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    clang-23
riscv                 randconfig-001-20260523    gcc-8.5.0
riscv                 randconfig-001-20260524    gcc-15.2.0
riscv                 randconfig-002-20260523    gcc-8.5.0
riscv                 randconfig-002-20260524    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260523    clang-23
s390                  randconfig-001-20260524    gcc-15.2.0
s390                  randconfig-002-20260523    clang-23
s390                  randconfig-002-20260524    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260523    gcc-15.2.0
sh                    randconfig-001-20260524    gcc-15.2.0
sh                    randconfig-002-20260523    gcc-11.5.0
sh                    randconfig-002-20260524    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260523    gcc-8.5.0
sparc                 randconfig-002-20260523    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260523    clang-23
sparc64               randconfig-002-20260523    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260523    gcc-14
um                    randconfig-002-20260523    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260523    gcc-14
x86_64      buildonly-randconfig-001-20260524    clang-20
x86_64      buildonly-randconfig-002-20260523    gcc-14
x86_64      buildonly-randconfig-002-20260524    clang-20
x86_64      buildonly-randconfig-003-20260523    gcc-14
x86_64      buildonly-randconfig-003-20260524    clang-20
x86_64      buildonly-randconfig-004-20260523    clang-20
x86_64      buildonly-randconfig-004-20260524    clang-20
x86_64      buildonly-randconfig-005-20260523    gcc-14
x86_64      buildonly-randconfig-005-20260524    clang-20
x86_64      buildonly-randconfig-006-20260523    clang-20
x86_64      buildonly-randconfig-006-20260524    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260523    clang-20
x86_64                randconfig-001-20260524    clang-20
x86_64                randconfig-002-20260523    gcc-14
x86_64                randconfig-002-20260524    clang-20
x86_64                randconfig-003-20260523    clang-20
x86_64                randconfig-003-20260524    clang-20
x86_64                randconfig-004-20260523    clang-20
x86_64                randconfig-004-20260524    clang-20
x86_64                randconfig-005-20260523    gcc-14
x86_64                randconfig-005-20260524    clang-20
x86_64                randconfig-006-20260523    gcc-14
x86_64                randconfig-006-20260524    clang-20
x86_64                randconfig-011-20260523    gcc-14
x86_64                randconfig-011-20260524    clang-20
x86_64                randconfig-012-20260523    clang-20
x86_64                randconfig-012-20260524    clang-20
x86_64                randconfig-013-20260523    gcc-14
x86_64                randconfig-013-20260524    clang-20
x86_64                randconfig-014-20260523    clang-20
x86_64                randconfig-014-20260524    clang-20
x86_64                randconfig-015-20260523    gcc-14
x86_64                randconfig-015-20260524    clang-20
x86_64                randconfig-016-20260523    clang-20
x86_64                randconfig-016-20260524    clang-20
x86_64                randconfig-071-20260523    gcc-14
x86_64                randconfig-071-20260524    gcc-14
x86_64                randconfig-072-20260523    gcc-14
x86_64                randconfig-072-20260524    gcc-14
x86_64                randconfig-073-20260523    gcc-14
x86_64                randconfig-073-20260524    gcc-14
x86_64                randconfig-074-20260523    clang-20
x86_64                randconfig-074-20260524    gcc-14
x86_64                randconfig-075-20260523    clang-20
x86_64                randconfig-075-20260524    gcc-14
x86_64                randconfig-076-20260523    clang-20
x86_64                randconfig-076-20260524    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260523    gcc-15.2.0
xtensa                randconfig-002-20260523    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

