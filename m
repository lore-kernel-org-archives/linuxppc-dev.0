Return-Path: <linuxppc-dev+bounces-24323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FD6C4450A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2026 23:30:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1Tmk18QVz3brV;
	Fri, 17 Jul 2026 09:30:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784244630;
	cv=none; b=Aq0M6CLIGMUo0Xq/6094+aYytQsFdM1Hni1ytblnZgBjnO80XP88ViWQWDE5WEfQum6ZvFx0l0p5p/5G//iG/ng/QAXqj6QuUh1Y0cwbLddEGaTthTX5sF8FS47w/yWv3OVe4o0TUokDLsofIXFH9QLDygpfhrfbdNb7MYg6ljPmhgs2KShdmILeI5THGSzrAXxb5X4bGeedpHMEwzs8E9kz8QHGh25Ein/4zqd8NM0afBAfUBL2jhNlxNyKkcoYV8CFE75KfFXnLQeC6BuBaR/pU8VJ2nY96CJTXQMsct4GPmixi8UBMEwMk8sGqRt6k4MVzx/svsDrRyrQATXyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784244630; c=relaxed/relaxed;
	bh=RedCVY9ijf9pZDgFlN+DazGTB3TBHvJ6ATrNuo8jT/E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cyAdSxzqdWZd7G0YYcvUaamGub4Q/48rcAABXDqK2WBgCr1930K1GtzrO3ma7Ou6+o62DemavXdq6Jw5tGLO2taZrRqIM/MMaw9O3xJDind3ZAhjkDS/qm8YqbDlgcYGG4HgYCBcWm8/oJnfHeQTDlV755NDbxDS+ONmS0ny81Rw257Ec3ikY6DJ9GsYUxWKUtu9MKLW/OfJTUJRYdWmOzznGerOVqQxPrbn8v1pf4A1mX8XSA2l1hfCH1dFrM2g5jnjHIh3qs/7vJFyju5Z0I5RYZ8gQwSJ/Up+Z0VvMTlSt/pJnJZsuLdEN35BrrBfce4OA4WvQAte2inOJfDckg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g3o3ePVJ; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g3o3ePVJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1Tmg4d7qz2y1F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 09:30:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784244628; x=1815780628;
  h=date:from:to:cc:subject:message-id;
  bh=wr09a1wB7KqbGzMQ3D/KkDlKSNWnDAT+oZmjUlCA9MM=;
  b=g3o3ePVJHGCCyN+jPr+ChbIoqIG6bDn7lXCm0ohC8X3WkmybgYSD+LQQ
   qXi+dfQh3zfZF26v6eMFIG9aD+e4Kl3HsbQTcRNspqai5TOri3dKO9aTJ
   /HR8NmzuA26Mx29ITJj4vV52AYvUgyiqguo2rD74+e1nrrxJHmpIT1fW3
   uBnMbuFPLmuc0ej4Rz8YAuJA1NvKPkVix5nTEtoPTOVSYlWuedmFkdycr
   TX19yIRDlqniw87i6Z8M1hzLgUDgjl7UgMeSu+4MBzVAPZ9P1hO42OG9h
   l/ZAEOwMbe4zcvjayQEWRxLEY3FhbQNduhMTjKFj9sGi0vwrqk07/xFZG
   g==;
X-CSE-ConnectionGUID: Wzhy7K4gQ1qv7H5hSTE7uA==
X-CSE-MsgGUID: S6M8jdUOTIuWKE0aILuiCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="102471462"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="102471462"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 16:30:20 -0700
X-CSE-ConnectionGUID: IvVOGn7OSg+/TUvL1762bw==
X-CSE-MsgGUID: lgrwZtyBQB+kP0PYSrUcZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="253226320"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jul 2026 16:30:19 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkVWm-00000000R4k-1Xiz;
	Thu, 16 Jul 2026 23:30:06 +0000
Date: Fri, 17 Jul 2026 07:11:35 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 0cf9f8680543a8e62f5bf7b73f1fba7739bf5e9a
Message-ID: <202607170717.YLHQQ4sI-lkp@intel.com>
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
branch HEAD: 0cf9f8680543a8e62f5bf7b73f1fba7739bf5e9a  Automatic merge of 'fixes' into merge (2026-07-15 08:07)

elapsed time: 1927m

configs tested: 105
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                   randconfig-001-20260716    gcc-14.3.0
arc                   randconfig-002-20260716    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm                   randconfig-001-20260716    gcc-8.5.0
arm                   randconfig-002-20260716    clang-17
arm                   randconfig-003-20260716    gcc-12.5.0
arm                   randconfig-004-20260716    clang-24
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                 randconfig-001-20260717    gcc-11.5.0
arm64                 randconfig-002-20260717    gcc-8.5.0
arm64                 randconfig-003-20260717    gcc-8.5.0
arm64                 randconfig-004-20260717    gcc-9.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                  randconfig-001-20260717    gcc-13.4.0
csky                  randconfig-002-20260717    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260717    clang-24
hexagon               randconfig-002-20260717    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260716    clang-22
i386        buildonly-randconfig-002-20260716    clang-22
i386        buildonly-randconfig-003-20260716    clang-22
i386        buildonly-randconfig-004-20260716    clang-22
i386        buildonly-randconfig-005-20260716    clang-22
i386        buildonly-randconfig-006-20260716    clang-22
i386                  randconfig-016-20260717    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260717    gcc-16.1.0
loongarch             randconfig-002-20260717    clang-24
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                        mvme147_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20260717    gcc-8.5.0
nios2                 randconfig-002-20260717    gcc-8.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260716    gcc-15.2.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260716    gcc-8.5.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260716    clang-21
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260716    clang-19
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260716    clang-22
powerpc64                      randconfig-002    clang-24
powerpc64             randconfig-002-20260716    clang-24
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-24
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260717    clang-24
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260717    gcc-9.5.0
sh                    randconfig-002-20260717    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260717    gcc-8.5.0
sparc                 randconfig-002-20260717    gcc-14.3.0
sparc64                          allmodconfig    clang-20
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260717    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

