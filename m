Return-Path: <linuxppc-dev+bounces-19618-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD69F45A12
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 03:43:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fszz162Qgz2yTK;
	Sat, 11 Apr 2026 13:43:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775878989;
	cv=none; b=gtIq58Dpkky8pKuuuo/qj451R6XgrclosCfhjrtYGedXfMUKMMa1dvjNAWksPmteCBB/IMZM/ue5ZIt36/UOZRW6OsnnzwgXHjPwzui3Rnmbbk//M8Q3fV1qGhIEMKws1RtHj9/2H4I94d//JlGKEzlEVYK1AIhXKvs3K2NRLWDP4oXpAdVXdOEaOgO9xxjFQz36e1S+fjBmpYjJuNwbJauiycM8ylowYRMWjv9+vxQczm0Bg+0Q6QTB64UT1L4rOD7AdHcsNBewhHYXc65LqcO3GoN4TjlkGaqts0gQZsUrjYFLeJj/KrnZHm+PrZxuEeSKTI5wEJWCH7V97BETFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775878989; c=relaxed/relaxed;
	bh=zOL/W1FKdbHfUr8jl2rEz6aSN7ThRCUJbRUsLN3XWLM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TbJ7tkz8CPPfjRa+uchQfTzUNQhGUI4gsSBHlSD/Q04NLd7KdjmCO3XPtsZUwDL+X5tcq0rluAMZpesdMS+hwe4r/xcEq0dUpbRShXSqH+d+if83o6r4ua3khn6JKWTFUUuqT783cknh9hjOSNkMXq4JgkLGHMrk2v4X6v47WBBaXol9O6aVNZz3jAMrLz9LFYz/E1VgeUGbhzFevcyOwGqvHBQdAK4V2vg9v3W0komEhP4Q9HcVtHgz3AuHiKqu2/gDgsHkAjzShfoc7VDiW+u80uCKMWREdSqWqbG3JHAmzNKqCH4t80U7EYrnqEmM3YsDglcLJdEG7HxJydWbaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHnyNtqH; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHnyNtqH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fszyy1HNhz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 13:43:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775878987; x=1807414987;
  h=date:from:to:cc:subject:message-id;
  bh=IV442ID2hspBeuPgxNK7LLXumGyKAwFUGyQko+m4PAo=;
  b=eHnyNtqHkt75XKrjSGGsohDORDPMnPvYMhKJAljqr1zln9KrYlX+uDiT
   NNTWBMM6oSXdNxpCj+6Rq+8FmyQqnLDbnAE6oieH1UMELI5KIL1/eHuUO
   Ky4SGzab5clmanOEal/CT7arBoXNcbANt5T20MtVES35Bj0HWoIV9qSKg
   csPG1xBABNytStmUEV/G+V4VP/tCGZaxrJQengwhXEblmWGCnWZTI52FE
   NgEd9kZ7grGMvn8YeM897D+SRWwCZXJ9f6x2OYQ+9wShwME+dFB7QxNaQ
   ouzmkhYVCCu/DO7tZDoiQOQ4UG/Cfia02DxIyIs83Q4QOa1X3D5PcCvk4
   A==;
X-CSE-ConnectionGUID: eKUbMZmYQauwm4Ku35WlpQ==
X-CSE-MsgGUID: 90r6hKX2ToKg8+aCd03/Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76615091"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="76615091"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 20:43:00 -0700
X-CSE-ConnectionGUID: 3kl5MS2AQQK7nTH7C8YA7Q==
X-CSE-MsgGUID: fJcieEF2TsuJoyn8fAr1UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="226548610"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Apr 2026 20:42:58 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBPFH-000000000iV-3s0G;
	Sat, 11 Apr 2026 03:42:55 +0000
Date: Sat, 11 Apr 2026 11:42:02 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 182544a8a10b291f0469737d8635d29e5ff96e48
Message-ID: <202604111156.cQt4mcYs-lkp@intel.com>
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
branch HEAD: 182544a8a10b291f0469737d8635d29e5ff96e48  Automatic merge of 'next' into merge (2026-04-09 11:06)

elapsed time: 1305m

configs tested: 151
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260411    gcc-12.5.0
arc                   randconfig-002-20260411    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260411    gcc-14.3.0
arm                   randconfig-002-20260411    clang-23
arm                   randconfig-003-20260411    clang-23
arm                   randconfig-004-20260411    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260411    clang-23
arm64                 randconfig-002-20260411    clang-23
arm64                 randconfig-003-20260411    clang-16
arm64                 randconfig-004-20260411    clang-19
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260411    gcc-12.5.0
csky                  randconfig-002-20260411    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260411    clang-23
hexagon               randconfig-002-20260411    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260411    clang-20
i386        buildonly-randconfig-002-20260411    clang-20
i386        buildonly-randconfig-003-20260411    clang-20
i386        buildonly-randconfig-004-20260411    clang-20
i386        buildonly-randconfig-005-20260411    gcc-14
i386        buildonly-randconfig-006-20260411    gcc-14
i386                  randconfig-001-20260411    clang-20
i386                  randconfig-002-20260411    clang-20
i386                  randconfig-003-20260411    clang-20
i386                  randconfig-004-20260411    clang-20
i386                  randconfig-005-20260411    gcc-14
i386                  randconfig-006-20260411    gcc-13
i386                  randconfig-007-20260411    clang-20
i386                  randconfig-011-20260411    clang-20
i386                  randconfig-012-20260411    gcc-14
i386                  randconfig-013-20260411    gcc-14
i386                  randconfig-014-20260411    gcc-14
i386                  randconfig-015-20260411    clang-20
i386                  randconfig-016-20260411    gcc-14
i386                  randconfig-017-20260411    gcc-14
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260411    gcc-14.3.0
loongarch             randconfig-002-20260411    clang-18
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260411    gcc-9.5.0
nios2                 randconfig-002-20260411    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260411    gcc-10.5.0
parisc                randconfig-002-20260411    gcc-11.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260411    clang-17
powerpc               randconfig-002-20260411    clang-17
powerpc64             randconfig-001-20260411    clang-16
powerpc64             randconfig-002-20260411    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260411    clang-17
riscv                 randconfig-002-20260411    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260411    gcc-8.5.0
s390                  randconfig-002-20260411    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260411    gcc-12.5.0
sh                    randconfig-002-20260411    gcc-12.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260411    gcc-8.5.0
sparc                 randconfig-002-20260411    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260411    gcc-15.2.0
sparc64               randconfig-002-20260411    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260411    gcc-14
um                    randconfig-002-20260411    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260411    gcc-14
x86_64      buildonly-randconfig-002-20260411    clang-20
x86_64      buildonly-randconfig-003-20260411    gcc-13
x86_64      buildonly-randconfig-004-20260411    gcc-14
x86_64      buildonly-randconfig-005-20260411    gcc-14
x86_64      buildonly-randconfig-006-20260411    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260410    gcc-14
x86_64                randconfig-002-20260410    clang-20
x86_64                randconfig-003-20260410    gcc-14
x86_64                randconfig-004-20260410    gcc-14
x86_64                randconfig-005-20260410    gcc-14
x86_64                randconfig-006-20260410    clang-20
x86_64                randconfig-011-20260411    gcc-14
x86_64                randconfig-012-20260411    clang-20
x86_64                randconfig-013-20260411    gcc-14
x86_64                randconfig-014-20260411    clang-20
x86_64                randconfig-015-20260411    gcc-14
x86_64                randconfig-016-20260411    clang-20
x86_64                randconfig-071-20260411    clang-20
x86_64                randconfig-072-20260411    clang-20
x86_64                randconfig-073-20260411    gcc-14
x86_64                randconfig-074-20260411    clang-20
x86_64                randconfig-075-20260411    gcc-14
x86_64                randconfig-076-20260411    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260411    gcc-15.2.0
xtensa                randconfig-002-20260411    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

