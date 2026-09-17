Return-Path: <linuxppc-dev+bounces-27641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4940C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 23:18:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmBWT6k3qz2y8p;
	Fri, 18 Sep 2026 09:18:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789687093;
	cv=none; b=L/YoxwT8z+E0QW6TNS+4lqKC+VLqDX8fzEOrkVFFyPBtu3WjlHUmvfOg1eJrFSstBA9Xrfwb/HOepKGXjK7K23Y9GZ8spnFllTIRiyKTFz7oQQIAFqRh7UCRvDKopasPIVSvuBEErgJi++4rAh5iua5//U8AuZKd3Ck5g6oiFxAhwa9mgfhCGHUDig6vDDJvtWgq/j2dfymz4CaZXl2glq52074/ykvukeLy6yE0wa2ViQ74aL3q/BGlqYjKiVoexvPrShzxiq3aPdFm1gITxOTnNIgRNc6yw6yzGoWd8lQzLqhsC+5KNLWF8DERrIIfYDSCPgRWye3V+kGG7yD8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789687093; c=relaxed/relaxed;
	bh=m0vF3RRHHOaUejjcxd7yUcQEJL63eIFTFbe5nR5x0II=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lUbtmo+6Hn5j0vhEhzOo9PVR8l6WrWYLzSkc74QPJAlET78Za5oGVjrt/PjjEUfT4isjCZqyqBx98ka4xzZP0ONW9KwhgCgbrm98d1u8jf4FLJnqTzpNdraDPyPm73WxAYxOjzUuzipvxaZlb5Cn9NEK1i8cP3aMph5DCTDE6RRAWu6fMAUQcwLvO/+lN4SgQ1PTCP/30fBIm2RCGu8bj1ygqmCMdpWAvLdb20G382A1akv73/fqc5d03Kn1A+BsnEdGnkVdVTKjGYp9zBlUfOHSJqujFZ9wi4gXfp5kxLEFQL1BJpRPl36BLlEW6o45FG/okWZ1GAHjqX+tI2Wo1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YR3v9U1E; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YR3v9U1E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmBWQ2RSyz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 09:18:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789687090; x=1821223090;
  h=date:from:to:cc:subject:message-id;
  bh=rLOzmXzsZFK2Ow74cjcDGNlDcVMA0dfX2N+zInZKtKc=;
  b=YR3v9U1E6a7lDFTRJWdvF/j8nj3PXhrU4me/jc/RqZ5835w7DjxpgZMR
   j3Q0ys+GGn+mDucE8Wo5c3az+MJDz3N73GNh8wlEnTPdUKP6phFL6cgSJ
   owNd0/uoBoN9dd7aOZRzxk9yUetNqlur/CVoR+9NXIm2obUOjzFRMsEm4
   7hylek6bY08TJDbuRfI/SDE+UHu4VYglHs89dQiR0nkdSo+16NLKeetPk
   ZnoHJBJMd0bdNb5z5bb7NoM+2SOmGNgq1R7zKHU4i9ZdeEpb3D6AKQ5vI
   PFVi7E/PksKVVGPpW/ttN4G+n03C8A8xVlkmHMXEqSO8WECOLJleHawCJ
   A==;
X-CSE-ConnectionGUID: Yzj1bZdUT+ybp8wZueSSRQ==
X-CSE-MsgGUID: ZnP5gMUYThy+IrM20pSXdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92669217"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92669217"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 16:18:05 -0700
X-CSE-ConnectionGUID: Lxi12YjITc2Zyja+p/n9xQ==
X-CSE-MsgGUID: w+yqBknkSzCOIhxCw2e+2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279310402"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Sep 2026 16:18:04 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7LMf-000000008hP-1Ux6;
	Thu, 17 Sep 2026 23:18:01 +0000
Date: Fri, 18 Sep 2026 07:17:22 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 2e384b86e81dabc326c63d34d5dbe9784c768352
Message-ID: <202609180718.f83uSk08-lkp@intel.com>
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
branch HEAD: 2e384b86e81dabc326c63d34d5dbe9784c768352  Automatic merge of 'fixes' into merge (2026-09-16 13:46)

elapsed time: m

configs tested: 255
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             alldefconfig    gcc-16.1.0
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1304-20260917    clang-21   sparse
alpha                randconfig-r1306-20260917    clang-24   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260917    gcc-15.2.0
arc                   randconfig-1000-20260918    gcc-16.1.0
arc                   randconfig-1001-20260917    gcc-15.2.0
arc                   randconfig-1001-20260918    gcc-16.1.0
arc                  randconfig-r1302-20260917    gcc-8.5.0  sparse
arc                  randconfig-r1303-20260917    gcc-8.5.0  sparse
arc                  randconfig-r1305-20260917    gcc-8.5.0  sparse
arc                            tb10x_defconfig    gcc-16.1.0
arc                         vdk_hs38_defconfig    clang-24
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                        aspeed_g4_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                        imx_v6_v7_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260917    gcc-15.2.0
arm                   randconfig-1000-20260918    gcc-16.1.0
arm                   randconfig-1001-20260917    gcc-15.2.0
arm                   randconfig-1001-20260918    gcc-16.1.0
arm                   randconfig-1002-20260917    gcc-15.2.0
arm                   randconfig-1002-20260918    gcc-16.1.0
arm                   randconfig-1003-20260917    gcc-15.2.0
arm                   randconfig-1003-20260918    gcc-16.1.0
arm                  randconfig-r1308-20260917    gcc-13.4.0 sparse
arm                          s5pv210_defconfig    clang-24
arm64                             alldefconfig    gcc-16.1.0
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260917    gcc-11.5.0
arm64                 randconfig-1001-20260917    gcc-11.5.0
arm64                 randconfig-1002-20260917    gcc-11.5.0
arm64                 randconfig-1003-20260917    gcc-11.5.0
arm64                randconfig-r1306-20260917    clang-18   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260917    gcc-11.5.0
csky                  randconfig-1001-20260917    gcc-11.5.0
csky                 randconfig-r1308-20260917    clang-24   sparse
csky                 randconfig-r1309-20260917    clang-18   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260917    clang-24
hexagon               randconfig-1001-20260917    clang-24
hexagon              randconfig-r1300-20260917    clang-21   sparse
hexagon              randconfig-r1301-20260917    gcc-8.5.0  sparse
hexagon              randconfig-r1304-20260917    gcc-8.5.0  sparse
hexagon              randconfig-r1307-20260917    clang-18   sparse
hexagon              randconfig-r2105-20260917    clang-19
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260917    gcc-13
i386        buildonly-randconfig-1000-20260918    gcc-14
i386        buildonly-randconfig-1001-20260917    gcc-13
i386        buildonly-randconfig-1001-20260918    gcc-14
i386        buildonly-randconfig-1002-20260917    gcc-13
i386        buildonly-randconfig-1002-20260918    gcc-14
i386        buildonly-randconfig-1003-20260917    gcc-13
i386        buildonly-randconfig-1003-20260918    gcc-14
i386        buildonly-randconfig-1004-20260917    gcc-13
i386        buildonly-randconfig-1004-20260918    gcc-14
i386        buildonly-randconfig-1005-20260917    gcc-13
i386        buildonly-randconfig-1005-20260918    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260917    clang-22
i386                  randconfig-1000-20260918    gcc-12
i386                  randconfig-1001-20260917    clang-22
i386                  randconfig-1001-20260918    gcc-12
i386                  randconfig-1002-20260917    clang-22
i386                  randconfig-1002-20260918    gcc-12
i386                  randconfig-1003-20260917    clang-22
i386                  randconfig-1003-20260918    gcc-12
i386                  randconfig-1004-20260917    clang-22
i386                  randconfig-1004-20260918    gcc-12
i386                  randconfig-1005-20260917    clang-22
i386                  randconfig-1005-20260918    gcc-12
i386                  randconfig-1006-20260917    clang-22
i386                  randconfig-1006-20260918    gcc-12
i386                  randconfig-1007-20260917    clang-22
i386                  randconfig-1008-20260917    clang-22
i386                  randconfig-1009-20260917    clang-22
i386                  randconfig-1010-20260917    clang-22
i386                  randconfig-1011-20260917    clang-22
i386                  randconfig-1012-20260917    clang-22
i386                  randconfig-1013-20260917    clang-22
i386                  randconfig-1300-20260917    gcc-14     sparse
i386                  randconfig-1301-20260917    gcc-14     sparse
i386                  randconfig-1302-20260917    gcc-14     sparse
i386                  randconfig-2200-20260917    clang-22
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260917    clang-24
loongarch             randconfig-1001-20260917    clang-24
loongarch            randconfig-r1307-20260917    clang-24   sparse
loongarch            randconfig-r1309-20260917    gcc-13.4.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    gcc-16.1.0
m68k                         mvme147_defconfig    gcc-16.1.0
m68k                           sun3x_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                          cobalt_defconfig    gcc-16.1.0
mips                            gcw0_defconfig    clang-24
mips                            ip27_defconfig    gcc-16.1.0
mips                       malta_kvm_defconfig    gcc-16.1.0
mips                         omega2p_defconfig    clang-24
mips                 randconfig-r1309-20260917    clang-24   sparse
mips                 randconfig-r2104-20260917    clang-17
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260917    clang-24
nios2                 randconfig-1001-20260917    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r1300-20260917    gcc-8.5.0  sparse
openrisc             randconfig-r1308-20260917    clang-18   sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260917    gcc-11.5.0
parisc                randconfig-1000-20260918    gcc-8.5.0
parisc                randconfig-1001-20260917    gcc-11.5.0
parisc                randconfig-1001-20260918    gcc-8.5.0
parisc               randconfig-r1302-20260917    clang-21   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                        ebony_defconfig    clang-24
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc                           g5_defconfig    clang-24
powerpc                      kmeter1_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260917    gcc-11.5.0
powerpc               randconfig-1000-20260918    gcc-8.5.0
powerpc               randconfig-1001-20260917    gcc-11.5.0
powerpc               randconfig-1001-20260918    gcc-8.5.0
powerpc              randconfig-r2107-20260917    gcc-8.5.0
powerpc                   storcenter_defconfig    gcc-16.1.0
powerpc                         warp_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260917    gcc-11.5.0
powerpc64             randconfig-1000-20260918    gcc-8.5.0
powerpc64             randconfig-1001-20260917    gcc-11.5.0
powerpc64             randconfig-1001-20260918    gcc-8.5.0
powerpc64            randconfig-r1305-20260917    clang-21   sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv              nommu_k210_sdcard_defconfig    clang-24
riscv                 randconfig-1000-20260917    clang-17
riscv                 randconfig-1001-20260917    clang-17
riscv                randconfig-r2106-20260917    gcc-8.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260917    clang-17
s390                  randconfig-1001-20260917    clang-17
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                          ecovec24_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260917    clang-17
sh                    randconfig-1001-20260917    clang-17
sh                            se7750_defconfig    clang-24
sh                             shmin_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260917    clang-17
sparc                 randconfig-1001-20260917    clang-17
sparc                randconfig-r1306-20260917    gcc-13.4.0 sparse
sparc                randconfig-r1307-20260917    gcc-13.4.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260917    clang-17
sparc64               randconfig-1001-20260917    clang-17
sparc64              randconfig-r1301-20260917    clang-21   sparse
sparc64              randconfig-r1303-20260917    clang-21   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260917    clang-17
um                    randconfig-1001-20260917    clang-17
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260917    gcc-14
x86_64      buildonly-randconfig-1001-20260917    gcc-14
x86_64      buildonly-randconfig-1002-20260917    gcc-14
x86_64      buildonly-randconfig-1003-20260917    gcc-14
x86_64      buildonly-randconfig-1004-20260917    gcc-14
x86_64      buildonly-randconfig-1005-20260917    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260917    clang-22
x86_64                randconfig-1001-20260917    clang-22
x86_64                randconfig-1002-20260917    clang-22
x86_64                randconfig-1003-20260917    clang-22
x86_64                randconfig-1004-20260917    clang-22
x86_64                randconfig-1005-20260917    clang-22
x86_64                randconfig-1006-20260917    clang-22
x86_64                randconfig-1007-20260917    clang-22
x86_64                randconfig-1008-20260917    clang-22
x86_64                randconfig-1009-20260917    clang-22
x86_64                randconfig-1010-20260917    clang-22
x86_64                randconfig-1011-20260917    clang-22
x86_64                randconfig-1012-20260917    clang-22
x86_64                randconfig-1013-20260917    clang-22
x86_64                randconfig-1014-20260917    clang-22
x86_64                randconfig-1015-20260917    clang-22
x86_64                randconfig-1016-20260917    clang-22
x86_64                randconfig-1017-20260917    clang-22
x86_64                randconfig-1300-20260917    gcc-14     sparse
x86_64                randconfig-1301-20260917    gcc-14     sparse
x86_64                randconfig-1302-20260917    gcc-14     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   cadence_csp_defconfig    gcc-16.1.0
xtensa                           iss_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20260917    clang-17
xtensa                randconfig-1001-20260917    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

