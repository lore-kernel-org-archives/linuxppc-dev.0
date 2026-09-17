Return-Path: <linuxppc-dev+bounces-27558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9282C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 09:29:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlr6v1Mrsz2xns;
	Thu, 17 Sep 2026 19:29:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789637351;
	cv=none; b=fSKuED48GNM5DkyOuV9fw9AFy90lzpYsJQuvk9bIwXZGPD06XvrUjqRkZbHonM5pfYkVv3LvvC/bmzMmgagUzRVqMBhEQYlNKeYRrvtEe0szSBbr0PSQwYiPrcLY4pCR33qYWsf0/jt+ZWwbAGbPneon3sBf8srDN9SffD95Yet/4/FiuyBVQtuHgJZtaBeGwHFrsk3LeKQ4oI8UJzF3NUKyHXWqCZ2LR/DRQZMA68A8n5BlLaY4u16tdmr0gYkSBeVMUt0MCrDOMHGBdZsN/3D5UbzYZtSRmrnmC8IqsE8Y2gdUVsysWwymUlGHXnzT+FhvMSgsZLVrDGwV/mal+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789637351; c=relaxed/relaxed;
	bh=K1X/y2CV8ghd239L4stNWtYnahnpFyK7eZGPa/PTKHY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bdqBXzG5H5pOBEh3fhXdL2qaG1SRu4atSngNFgFqwA1WOfFAvJHy1H1rh4atZdUVqmjsmqLgEYr0kONKk0gYFxuV0ewcgFjWhEGgmBzHTmFLYkXw7woRKiuKSPFuMTRBfMMnDScF+mnGnnZVm3MOklEl/aiyvtdHkhhd5mF3l9olszEDyoFgkSQtbDRQVfFSYVQr9nsfL6efiTCJlNsx/7oViNvgrjCWrKjCkeRznq0CX6XushQ1D+Y1mlnyezwLtiwHWBxEn4y7EXeMb0buJ+Sn2gZLN3ySe6kwtRhFsTBNMtYR3i53ouEdqjecPCG8r+hS6Spyk1O+vYP1of4oww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hfspXlup; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hfspXlup;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlr6r3d7Gz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 19:29:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789637349; x=1821173349;
  h=date:from:to:cc:subject:message-id;
  bh=kZDy9aIetaeZkv7TBwzavQtKRU+aJJ6HQdAj1z21E2w=;
  b=hfspXlupf4WGBsQGxR7TfsNRRM/ss6MjMT8EWENnkyqnim7+jRhnUHEk
   TBb681f8x1YUHZRqAQ19mMpdQ/JfbesJqmgC+iaSseC1z+48zGhb4ZWNl
   Zr0aRRRzTtnFV/HFljALkud9/cpIlMVXyGXCRUWl2ZNOmb4F7c8M0bSav
   29mP8pMKpZRpPnl005RSEDFZiNItlKSU9WRm6DTlRpeFVnFM93fpz3fib
   mmZbf7u8Jc9+sqymlQYzrd9S6oMssronW9klVODXyyOLdpotQyLvOZjWk
   XIxR6efoCTfveY6R6IM8wmaU+3BiSDQlUVu0iQsBrZDP5sEekhlh7M1lE
   w==;
X-CSE-ConnectionGUID: ypMOS5hcTv+fCPK7AGQcHA==
X-CSE-MsgGUID: s/0kjb4TQTGPFKpYErPXqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89177106"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89177106"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:28:53 -0700
X-CSE-ConnectionGUID: n0SkiLJNTW2dX1Mtm4Nv7Q==
X-CSE-MsgGUID: oC/qSWNWRrCZHxD1fGrYeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1882481"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 17 Sep 2026 02:28:51 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x78QD-000000007Vv-1GWo;
	Thu, 17 Sep 2026 09:28:49 +0000
Date: Thu, 17 Sep 2026 17:28:42 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes] BUILD SUCCESS
 0b271f7d7f5ed45bc498a03ce0aa9cfd8402fc71
Message-ID: <202609171737.Xi3FtMkP-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes
branch HEAD: 0b271f7d7f5ed45bc498a03ce0aa9cfd8402fc71  powerpc/iommu: Fix the overflow validation in iommu_tce_check_ioba

elapsed time: m

configs tested: 188
configs skipped: 171

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1306-20260917    clang-24   sparse
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260917    gcc-15.2.0
arc                   randconfig-1001-20260917    gcc-15.2.0
arc                  randconfig-r1302-20260917    gcc-8.5.0  sparse
arc                  randconfig-r1303-20260917    gcc-8.5.0  sparse
arc                  randconfig-r1305-20260917    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.1.0
arm                          assabet_defconfig    clang-24
arm                          at91_dt_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                           gemini_defconfig    gcc-16.1.0
arm                         mvebu_v5_defconfig    gcc-16.1.0
arm                          nhk8815_defconfig    clang-24
arm                          orion5x_defconfig    clang-24
arm                   randconfig-1000-20260917    gcc-15.2.0
arm                   randconfig-1001-20260917    gcc-15.2.0
arm                   randconfig-1002-20260917    gcc-15.2.0
arm                   randconfig-1003-20260917    gcc-15.2.0
arm                  randconfig-r1300-20260917    clang-24   sparse
arm                  randconfig-r1304-20260917    clang-24   sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260917    gcc-11.5.0
arm64                 randconfig-1001-20260917    gcc-11.5.0
arm64                 randconfig-1002-20260917    gcc-11.5.0
arm64                 randconfig-1003-20260917    gcc-11.5.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260917    gcc-11.5.0
csky                  randconfig-1001-20260917    gcc-11.5.0
csky                 randconfig-r1308-20260917    clang-24   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260917    clang-24
hexagon               randconfig-1001-20260917    clang-24
hexagon              randconfig-r1301-20260917    gcc-8.5.0  sparse
hexagon              randconfig-r1304-20260917    gcc-8.5.0  sparse
hexagon              randconfig-r1305-20260917    clang-24   sparse
i386                              alldefconfig    gcc-16.1.0
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20260917    gcc-13
i386        buildonly-randconfig-1001-20260917    gcc-13
i386        buildonly-randconfig-1002-20260917    gcc-13
i386        buildonly-randconfig-1003-20260917    gcc-13
i386        buildonly-randconfig-1004-20260917    gcc-13
i386        buildonly-randconfig-1005-20260917    gcc-13
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260917    clang-22
i386                  randconfig-1001-20260917    clang-22
i386                  randconfig-1002-20260917    clang-22
i386                  randconfig-1003-20260917    clang-22
i386                  randconfig-1004-20260917    clang-22
i386                  randconfig-1005-20260917    clang-22
i386                  randconfig-1006-20260917    clang-22
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
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260917    clang-24
loongarch             randconfig-1001-20260917    clang-24
loongarch            randconfig-r1307-20260917    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                         mvme147_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           ath25_defconfig    clang-24
mips                            ci20_defconfig    gcc-16.1.0
mips                 randconfig-r1301-20260917    clang-24   sparse
mips                 randconfig-r1309-20260917    clang-24   sparse
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260917    clang-24
nios2                 randconfig-1001-20260917    clang-24
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    gcc-16.1.0
openrisc                     or1ksim_defconfig    gcc-16.1.0
openrisc             randconfig-r1300-20260917    gcc-8.5.0  sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260917    gcc-11.5.0
parisc                randconfig-1001-20260917    gcc-11.5.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20260917    gcc-11.5.0
powerpc               randconfig-1001-20260917    gcc-11.5.0
powerpc64             randconfig-1000-20260917    gcc-11.5.0
powerpc64             randconfig-1001-20260917    gcc-11.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260917    clang-17
riscv                 randconfig-1001-20260917    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260917    clang-17
s390                  randconfig-1001-20260917    clang-17
s390                 randconfig-r1303-20260917    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                   defconfig    gcc-14
sh                           lboxre2_defconfig    clang-24
sh                    randconfig-1000-20260917    clang-17
sh                    randconfig-1001-20260917    clang-17
sh                           rsk7269_defconfig    gcc-16.1.0
sh                      sh7710voipgw_defconfig    gcc-16.1.0
sh                    sh7724_generic_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260917    clang-17
sparc                 randconfig-1001-20260917    clang-17
sparc                randconfig-r1302-20260917    clang-24   sparse
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260917    clang-17
sparc64               randconfig-1001-20260917    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260917    clang-17
um                    randconfig-1001-20260917    clang-17
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
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
xtensa                             allnoconfig    clang-24
xtensa                randconfig-1000-20260917    clang-17
xtensa                randconfig-1001-20260917    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

