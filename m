Return-Path: <linuxppc-dev+bounces-18217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4424F013C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 07:31:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ6Gp0Bz6z2xln;
	Mon, 16 Mar 2026 18:31:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773646305;
	cv=none; b=jituf88DEKNH1PEriJORTRnOsdsagEeY/C/oyimH/tV6PvVvMo/eVaogYkvGMkLt3KIBy6JbBeQViR+y1NBG98r45Jjc10dHouTwR0mXmuJ8iUKw+rGvysyaSnKBQ8jBcPkMsaKLhc3SDNTWgCnrlYBySh3SCtNwlI3ixBJ0vTXKmu/SG3cwh0VeMsOEyrAkgN4686aum112KLL0BGJ+uIie5MTwGJepGXv2UlAJWJn4i79sQHBisIBP1T6x/zLaLQbT1OLntnlesqP4tlpbwtOHeckYN4u9gZrby7so5/Hk+/uZXWtTZ+T9WBz22wHe2vAXnXXvykkbkngCpmJrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773646305; c=relaxed/relaxed;
	bh=SQBK23h/yA5cxoWiJsLr9s5pUAY9fBckP3uNgBUndd0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K7wjEAYMKmhoqDPRxe1jCWsu9hzxK8q82rpZYvf9yfq3KXr8CSMmCFPkP2bHcpfDL35dLihGKXrVQpMNPJNQxjC8h3exrlOawnixnSL5hyJKs5I6foKXqXZnBWoTAYV3NXNUFjMOgMMqc1NV88xGLy0QRjoMvRkaVvclCop1643vm5rWb0imESgEzuErB+dgPg4p9/IpT+vtQ8Rnt/iwTCTzoT5WVfiXKT2kQClR14WpF9QtgH/TEWUPXXgGSgDX0fE8LEH0dk70dnP/YtFrsWMfaFOScjbhuiGF2p5/5JzGb5rI+dF4T/kZjjb7MTq14w7WtcTjCnrAJWVnkxTE+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UJkTu1yd; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UJkTu1yd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ6Gl3H5Dz2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 18:31:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646303; x=1805182303;
  h=date:from:to:cc:subject:message-id;
  bh=+avREIxW59eGl2EK3HrzXeIqhempyb8HmrwnRMWA2KU=;
  b=UJkTu1ydz3U9xPbO5MEaEIMCn7/rL8s6kBHFVB71+EKwptwqcCoiScJ9
   wDHUWUfSRhcwBQ6bLby/PsCQ7SgrNT8vQeyt2W3rHvk1DvTErcWN+qqWv
   WBulHEsEDZbNj+93Vrb9iK0kPsK21T8hLZ34QpPpQ++mZ0DBzjtQaMfcJ
   24Nxk/jeNujK3yRcCbCCK6yEoLjbOp6zZyZwoQUgLvKIqJdZvZJa2a8Eq
   10PLX/Gq8x/5oZGXfVEn9FqVIEs5tM5JXAzyYhOIwMbAaoyvXH7n8fWVt
   j0OSs48PlJiMKD6RQTO9V3uujajBclSv+0FLTZd6qJlOoOEKejF46VqoA
   g==;
X-CSE-ConnectionGUID: vycSKvIXSf+duOho0ZrRcg==
X-CSE-MsgGUID: A9o2+WqmQOqH2nCnrQIlTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74629672"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="74629672"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:31:38 -0700
X-CSE-ConnectionGUID: OuRow97FRRC6hVqjccAOuA==
X-CSE-MsgGUID: oRuJIdyxQkGxHG2Jx3ekqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="217686742"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Mar 2026 00:31:37 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w22QI-000000000IY-3YJ0;
	Mon, 16 Mar 2026 07:31:34 +0000
Date: Mon, 16 Mar 2026 15:30:55 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes-test] BUILD SUCCESS
 82f73ef9c41e0623e0a8bdce4fa44a7237709f0c
Message-ID: <202603161549.2Capg5Nh-lkp@intel.com>
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
branch HEAD: 82f73ef9c41e0623e0a8bdce4fa44a7237709f0c  powerpc/iommu: fix lockdep warning during PCI enumeration

elapsed time: 734m

configs tested: 198
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260316    clang-23
arc                   randconfig-002-20260316    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260316    clang-23
arm                   randconfig-002-20260316    clang-23
arm                   randconfig-003-20260316    clang-23
arm                   randconfig-004-20260316    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260316    clang-23
arm64                 randconfig-001-20260316    gcc-11.5.0
arm64                 randconfig-002-20260316    clang-23
arm64                 randconfig-003-20260316    clang-23
arm64                 randconfig-004-20260316    clang-19
arm64                 randconfig-004-20260316    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260316    clang-23
csky                  randconfig-001-20260316    gcc-15.2.0
csky                  randconfig-002-20260316    clang-23
csky                  randconfig-002-20260316    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260316    gcc-11.5.0
hexagon               randconfig-002-20260316    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260316    gcc-14
i386        buildonly-randconfig-002-20260316    gcc-14
i386        buildonly-randconfig-003-20260316    gcc-14
i386        buildonly-randconfig-004-20260316    gcc-14
i386        buildonly-randconfig-005-20260316    gcc-14
i386        buildonly-randconfig-006-20260316    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260316    gcc-14
i386                  randconfig-002-20260316    clang-20
i386                  randconfig-002-20260316    gcc-14
i386                  randconfig-003-20260316    gcc-14
i386                  randconfig-004-20260316    gcc-14
i386                  randconfig-005-20260316    clang-20
i386                  randconfig-005-20260316    gcc-14
i386                  randconfig-006-20260316    gcc-12
i386                  randconfig-006-20260316    gcc-14
i386                  randconfig-007-20260316    gcc-14
i386                  randconfig-011-20260316    gcc-13
i386                  randconfig-012-20260316    gcc-13
i386                  randconfig-013-20260316    gcc-13
i386                  randconfig-014-20260316    gcc-13
i386                  randconfig-015-20260316    gcc-13
i386                  randconfig-016-20260316    gcc-13
i386                  randconfig-017-20260316    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260316    gcc-11.5.0
loongarch             randconfig-002-20260316    gcc-11.5.0
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
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260316    gcc-11.5.0
nios2                 randconfig-002-20260316    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260316    gcc-13.4.0
parisc                randconfig-001-20260316    gcc-8.5.0
parisc                randconfig-002-20260316    gcc-12.5.0
parisc                randconfig-002-20260316    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260316    clang-23
powerpc               randconfig-001-20260316    gcc-13.4.0
powerpc               randconfig-002-20260316    clang-23
powerpc               randconfig-002-20260316    gcc-13.4.0
powerpc64             randconfig-001-20260316    gcc-13.4.0
powerpc64             randconfig-002-20260316    gcc-13.4.0
powerpc64             randconfig-002-20260316    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260316    gcc-12.5.0
riscv                 randconfig-002-20260316    gcc-12.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260316    gcc-12.5.0
s390                  randconfig-002-20260316    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260316    gcc-12.5.0
sh                    randconfig-002-20260316    gcc-12.5.0
sh                           sh2007_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260316    gcc-12.5.0
sparc                 randconfig-002-20260316    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260316    gcc-12.5.0
sparc64               randconfig-002-20260316    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260316    gcc-12.5.0
um                    randconfig-002-20260316    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260316    clang-20
x86_64      buildonly-randconfig-002-20260316    clang-20
x86_64      buildonly-randconfig-003-20260316    clang-20
x86_64      buildonly-randconfig-004-20260316    clang-20
x86_64      buildonly-randconfig-005-20260316    clang-20
x86_64      buildonly-randconfig-006-20260316    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260316    clang-20
x86_64                randconfig-002-20260316    clang-20
x86_64                randconfig-003-20260316    clang-20
x86_64                randconfig-004-20260316    clang-20
x86_64                randconfig-005-20260316    clang-20
x86_64                randconfig-006-20260316    clang-20
x86_64                randconfig-011-20260316    gcc-14
x86_64                randconfig-012-20260316    gcc-14
x86_64                randconfig-013-20260316    gcc-14
x86_64                randconfig-014-20260316    gcc-14
x86_64                randconfig-015-20260316    gcc-14
x86_64                randconfig-016-20260316    gcc-14
x86_64                randconfig-071-20260316    gcc-12
x86_64                randconfig-072-20260316    gcc-12
x86_64                randconfig-073-20260316    gcc-12
x86_64                randconfig-074-20260316    gcc-12
x86_64                randconfig-075-20260316    gcc-12
x86_64                randconfig-076-20260316    gcc-12
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
xtensa                randconfig-001-20260316    gcc-12.5.0
xtensa                randconfig-002-20260316    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

