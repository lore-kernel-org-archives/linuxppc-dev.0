Return-Path: <linuxppc-dev+bounces-21139-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387F6CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 02:22:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKJN34fXrz2yCM;
	Tue, 19 May 2026 12:22:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779157331;
	cv=none; b=oXVkNxbLP7A5DEDNjY1mqX//KBZTdSzZTbXdDdX2D2e/nsaTfPXcFOUEdzgYIOUB8xtDHPvAqECkcibPvK23W6ZxZkJRgA0t1B/vYx15cMQMehcaFTYrPVofkbJ8xWRgT+6FBx16GupxwogTBhxGRIvUp4C/n2R+8z1Vc4znrAfpqnZBx71YjeoFRhLdiW9iIMJRV58ZdP3+M8moYqGgUeC1GLvAv7qbA4GmaRrOPPzvOJ26GDehZLC1Osz1/6zolzfrqS+M+d3BaU4qbRShnDZwQrr9C5Nav9KWYeP1BzoaTkCbYCgP0si7fPdNAnL1jlMNpziHr5XX4Ad/SC5imw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779157331; c=relaxed/relaxed;
	bh=yBA4YpBK1R6Ew7rvTc1PRPuRgnSG4e6ZoYmEG1SVvUc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=R7YL7DwbAqI/ZFrm8prb/rrrgrgxBV49EnCDK4uRROifs8/cKdQiYp9f5EtyO3huVdH8CiIHqBfIPjaJKF7NOtro5gfJD1piLGzSObYF2HrYbmMMwdeQcYR5ynzuDU5UzHLUzLNvk1xr4Q0b60qtcPNK2/7FFktb8ZQ3aMyGemcLKsTBcQsONyu7goO+kWogD5uIfdVUAajZmJxQBpnTv+Wh2h2Nk17HNaIGrRKb3eWYmIc/kV9nZsB+C82CYAt87iK57c9B7ljDsC0SE7IRu1JHhLaFdo8l/H4048Bvtz00fL5xAbN7OfkyKiBGsXmioM8f33aFQsNsCtjwmcWr6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AQS2mKBf; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AQS2mKBf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKJMz66zBz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 12:22:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779157328; x=1810693328;
  h=date:from:to:cc:subject:message-id;
  bh=GKq0LDPIO7cnLmfay6KuK7h+g3cCoAE0KWfKa2dq7W8=;
  b=AQS2mKBfbEbXJsoeVboBs65+ChfI4pnmwu94040ZLie7cORAnuUMzebt
   hajQ1Qk5yvBBuT7zK621cuu1rtyjqLo7aBlXozNy9HGHtGF91OWV++L1d
   0PtXmwgiTsJD6pD45npigC7czPzbRvYKSIgmwyW23kb1b7evS+FpNhAL1
   NIqvlJOS6Vf/HU3BVygFcSRqqZFMkpu5EQC1BWYhUvzpZzLC1/VMjHOfG
   HmoAIdgq8XbRbN3lJjtXcG46UAHdJFsZ/BdytMusfWTLZagcOTaauwFAq
   B4kSQiMaOVrX9MX32Evlto0PPo/Fz3EV/dgysdGcad3fUwpPkmiwhP1Kr
   w==;
X-CSE-ConnectionGUID: 5uo/DqSQTbGZwli6AkUF6w==
X-CSE-MsgGUID: IvTHhdPvRDiJqJDPOjwKqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97593370"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97593370"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 19:22:01 -0700
X-CSE-ConnectionGUID: cZPExifgSeWBQndDNuFeZw==
X-CSE-MsgGUID: HyL0NbW/R6Wlu3BP20LZYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="243920339"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 18 May 2026 19:21:59 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPA55-000000000Db-0O6p;
	Tue, 19 May 2026 02:21:26 +0000
Date: Tue, 19 May 2026 10:16:06 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 d850c9d4d46e1c3f70922e048815ce8bc0235cec
Message-ID: <202605191058.v6I3oHs4-lkp@intel.com>
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
branch HEAD: d850c9d4d46e1c3f70922e048815ce8bc0235cec  Automatic merge of 'fixes' into merge (2026-05-18 15:48)

elapsed time: 886m

configs tested: 326
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    clang-17
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260518    gcc-8.5.0
arc                   randconfig-001-20260518    gcc-9.5.0
arc                   randconfig-001-20260519    clang-23
arc                   randconfig-002-20260518    gcc-8.5.0
arc                   randconfig-002-20260519    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    clang-17
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20260518    clang-23
arm                   randconfig-001-20260518    gcc-8.5.0
arm                   randconfig-001-20260519    clang-23
arm                   randconfig-002-20260518    gcc-8.5.0
arm                   randconfig-002-20260519    clang-23
arm                   randconfig-003-20260518    gcc-8.5.0
arm                   randconfig-003-20260519    clang-23
arm                   randconfig-004-20260518    gcc-10.5.0
arm                   randconfig-004-20260518    gcc-8.5.0
arm                   randconfig-004-20260519    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260519    gcc-8.5.0
arm64                 randconfig-002-20260519    gcc-8.5.0
arm64                 randconfig-003-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260519    gcc-8.5.0
csky                  randconfig-002-20260518    gcc-11.5.0
csky                  randconfig-002-20260519    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260518    clang-16
hexagon               randconfig-001-20260518    gcc-11.5.0
hexagon               randconfig-001-20260519    clang-23
hexagon               randconfig-001-20260519    gcc-10.5.0
hexagon               randconfig-002-20260518    clang-23
hexagon               randconfig-002-20260518    gcc-11.5.0
hexagon               randconfig-002-20260519    clang-23
hexagon               randconfig-002-20260519    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260518    clang-20
i386        buildonly-randconfig-001-20260519    gcc-12
i386        buildonly-randconfig-002-20260518    clang-20
i386        buildonly-randconfig-002-20260519    gcc-12
i386        buildonly-randconfig-003-20260518    gcc-14
i386        buildonly-randconfig-003-20260519    gcc-12
i386        buildonly-randconfig-004-20260518    gcc-14
i386        buildonly-randconfig-004-20260519    gcc-12
i386        buildonly-randconfig-005-20260518    gcc-14
i386        buildonly-randconfig-005-20260519    gcc-12
i386        buildonly-randconfig-006-20260518    clang-20
i386        buildonly-randconfig-006-20260519    gcc-12
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260518    clang-20
i386                  randconfig-001-20260518    gcc-14
i386                  randconfig-001-20260519    gcc-14
i386                  randconfig-002-20260518    gcc-14
i386                  randconfig-002-20260519    gcc-14
i386                  randconfig-003-20260518    gcc-14
i386                  randconfig-003-20260519    gcc-14
i386                  randconfig-004-20260518    clang-20
i386                  randconfig-004-20260518    gcc-14
i386                  randconfig-004-20260519    gcc-14
i386                  randconfig-005-20260518    clang-20
i386                  randconfig-005-20260518    gcc-14
i386                  randconfig-005-20260519    gcc-14
i386                  randconfig-006-20260518    gcc-13
i386                  randconfig-006-20260518    gcc-14
i386                  randconfig-006-20260519    gcc-14
i386                  randconfig-007-20260518    clang-20
i386                  randconfig-007-20260518    gcc-14
i386                  randconfig-007-20260519    gcc-14
i386                  randconfig-011-20260518    gcc-14
i386                  randconfig-011-20260519    gcc-14
i386                  randconfig-012-20260518    clang-20
i386                  randconfig-012-20260518    gcc-14
i386                  randconfig-012-20260519    gcc-14
i386                  randconfig-013-20260518    gcc-14
i386                  randconfig-013-20260519    gcc-14
i386                  randconfig-014-20260518    gcc-14
i386                  randconfig-014-20260519    gcc-14
i386                  randconfig-015-20260518    clang-20
i386                  randconfig-015-20260518    gcc-14
i386                  randconfig-015-20260519    gcc-14
i386                  randconfig-016-20260518    gcc-14
i386                  randconfig-016-20260519    gcc-14
i386                  randconfig-017-20260518    gcc-14
i386                  randconfig-017-20260519    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260518    gcc-11.5.0
loongarch             randconfig-001-20260518    gcc-15.2.0
loongarch             randconfig-001-20260519    clang-23
loongarch             randconfig-001-20260519    gcc-10.5.0
loongarch             randconfig-002-20260518    clang-23
loongarch             randconfig-002-20260518    gcc-11.5.0
loongarch             randconfig-002-20260519    clang-23
loongarch             randconfig-002-20260519    gcc-10.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    clang-17
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    clang-18
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260518    gcc-11.5.0
nios2                 randconfig-001-20260519    gcc-10.5.0
nios2                 randconfig-002-20260518    gcc-11.5.0
nios2                 randconfig-002-20260519    gcc-10.5.0
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
parisc                randconfig-001-20260518    gcc-15.2.0
parisc                randconfig-001-20260519    gcc-8.5.0
parisc                randconfig-002-20260518    gcc-12.5.0
parisc                randconfig-002-20260519    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260518    clang-23
powerpc               randconfig-001-20260519    gcc-8.5.0
powerpc               randconfig-002-20260518    clang-23
powerpc               randconfig-002-20260519    gcc-8.5.0
powerpc64             randconfig-001-20260518    gcc-11.5.0
powerpc64             randconfig-001-20260519    gcc-8.5.0
powerpc64             randconfig-002-20260518    clang-23
powerpc64             randconfig-002-20260519    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    clang-17
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260518    clang-23
riscv                 randconfig-001-20260519    gcc-13.4.0
riscv                 randconfig-002-20260518    clang-23
riscv                 randconfig-002-20260519    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260518    gcc-12.5.0
s390                  randconfig-001-20260519    gcc-13.4.0
s390                  randconfig-002-20260518    gcc-12.5.0
s390                  randconfig-002-20260519    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260518    gcc-14.3.0
sh                    randconfig-001-20260519    gcc-13.4.0
sh                    randconfig-002-20260518    gcc-11.5.0
sh                    randconfig-002-20260519    gcc-13.4.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260518    gcc-15.2.0
sparc                 randconfig-001-20260519    gcc-14.3.0
sparc                 randconfig-002-20260518    gcc-15.2.0
sparc                 randconfig-002-20260519    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260518    gcc-15.2.0
sparc64               randconfig-001-20260519    gcc-14.3.0
sparc64               randconfig-002-20260518    gcc-15.2.0
sparc64               randconfig-002-20260519    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260518    clang-16
um                    randconfig-001-20260518    gcc-15.2.0
um                    randconfig-001-20260519    gcc-14.3.0
um                    randconfig-002-20260518    clang-23
um                    randconfig-002-20260518    gcc-15.2.0
um                    randconfig-002-20260519    gcc-14.3.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260518    clang-20
x86_64      buildonly-randconfig-001-20260518    gcc-14
x86_64      buildonly-randconfig-001-20260519    gcc-14
x86_64      buildonly-randconfig-002-20260518    clang-20
x86_64      buildonly-randconfig-002-20260518    gcc-14
x86_64      buildonly-randconfig-002-20260519    gcc-14
x86_64      buildonly-randconfig-003-20260518    clang-20
x86_64      buildonly-randconfig-003-20260518    gcc-14
x86_64      buildonly-randconfig-003-20260519    gcc-14
x86_64      buildonly-randconfig-004-20260518    gcc-14
x86_64      buildonly-randconfig-004-20260519    gcc-14
x86_64      buildonly-randconfig-005-20260518    gcc-14
x86_64      buildonly-randconfig-005-20260519    gcc-14
x86_64      buildonly-randconfig-006-20260518    clang-20
x86_64      buildonly-randconfig-006-20260518    gcc-14
x86_64      buildonly-randconfig-006-20260519    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260518    gcc-14
x86_64                randconfig-001-20260519    clang-20
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260518    clang-20
x86_64                randconfig-002-20260518    gcc-14
x86_64                randconfig-002-20260519    clang-20
x86_64                         randconfig-003    gcc-14
x86_64                randconfig-003-20260518    gcc-14
x86_64                randconfig-003-20260519    clang-20
x86_64                         randconfig-004    gcc-14
x86_64                randconfig-004-20260518    gcc-14
x86_64                randconfig-004-20260519    clang-20
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260518    gcc-14
x86_64                randconfig-005-20260519    clang-20
x86_64                         randconfig-006    gcc-14
x86_64                randconfig-006-20260518    gcc-14
x86_64                randconfig-006-20260519    clang-20
x86_64                randconfig-011-20260518    clang-20
x86_64                randconfig-011-20260519    clang-20
x86_64                randconfig-012-20260518    clang-20
x86_64                randconfig-012-20260519    clang-20
x86_64                randconfig-013-20260518    gcc-14
x86_64                randconfig-013-20260519    clang-20
x86_64                randconfig-014-20260518    clang-20
x86_64                randconfig-014-20260519    clang-20
x86_64                randconfig-015-20260518    clang-20
x86_64                randconfig-015-20260519    clang-20
x86_64                randconfig-016-20260518    gcc-14
x86_64                randconfig-016-20260519    clang-20
x86_64                randconfig-071-20260518    clang-20
x86_64                randconfig-071-20260518    gcc-14
x86_64                randconfig-071-20260519    gcc-14
x86_64                randconfig-072-20260518    clang-20
x86_64                randconfig-072-20260518    gcc-14
x86_64                randconfig-072-20260519    gcc-14
x86_64                randconfig-073-20260518    clang-20
x86_64                randconfig-073-20260519    gcc-14
x86_64                randconfig-074-20260518    clang-20
x86_64                randconfig-074-20260519    gcc-14
x86_64                randconfig-075-20260518    clang-20
x86_64                randconfig-075-20260519    gcc-14
x86_64                randconfig-076-20260518    clang-20
x86_64                randconfig-076-20260519    gcc-14
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260518    gcc-12.5.0
xtensa                randconfig-001-20260518    gcc-15.2.0
xtensa                randconfig-001-20260519    gcc-14.3.0
xtensa                randconfig-002-20260518    gcc-15.2.0
xtensa                randconfig-002-20260518    gcc-9.5.0
xtensa                randconfig-002-20260519    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

