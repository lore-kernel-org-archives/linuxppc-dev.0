Return-Path: <linuxppc-dev+bounces-25529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA74FC56208
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 20:33:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGJrK4qsDz3bgK;
	Fri, 07 Aug 2026 06:33:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786048385;
	cv=none; b=gXnj+ydDmtKdrJYomUG5CN6/sQgwOBUPJFmRp5/oE3VW32cIpmzEv/2s2zZbWD1thnfjGWzSvGJM2U5TjYHEWsdg0LyitFJu7KmtrxAB7cjxyuAxEdPPTbyEYWtfQAGq78mgqh/4VythBa7rQ8FbrsF0jv4NCaLAoSr0pS0P++kYy+5+qgFlaQ2XcPFq7Qiedo206EH0kiCWlyYR7r4RpTFWHjcJUP/wW2+pcQCBztAfHR2fVkRVqlJa6spdLeTmK3EkigFaNTa+7NTh9lWR/Kr2QISdEhldjtGbIz5xzWbHkOJN+AjOOjYUggSd15LVDE5Z11H5mrIMBAgCBcZCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786048385; c=relaxed/relaxed;
	bh=SKhxcfVSRRidBusoQ7fmlafVujgZ2sp5G+6E0mUZOPE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hluSaB2M0YpLOzW9HBHPeCpNbJnzZjrGTA+fje8R1eDM7sDmQ2Fa8Kw6/U11vDguJrar+TGodJpMD/5RUkzoMWqk7zR6kbXHFhBaymrHiEpIN6B6Y2cWPVyjf8fJKyHh+Ob0R739/AzksRitOdEtxTGbpqK4Akptos5ce4YPruEtxrWKcSo/LkPq10FkD5bLO7cct0IiwKa1TprUkpR6Fno0s9bbAneHLlTJ+ZhOQWe6rFtEe+X8kVGuozEHaS/iXZgaJu3nINQ55bcVitR9vMY46Xoane9O1BZNjYkHdlKQ/qDnwe/fJgnW4Zk1juuRGUOJRLo0Ts9MyoNnuK93PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+g+p5Zd; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+g+p5Zd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGJrG1x4Pz30Dq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 06:32:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786048382; x=1817584382;
  h=date:from:to:cc:subject:message-id;
  bh=knj0++rD3avKgigPiBPYNNQ32lWuUIJu/iUhfIzpc2s=;
  b=L+g+p5ZdO1PfOL7hNQbpXoMwMKnMs5chxMimuMYuI0WRv2Wr9KltPqzL
   wSDVI1HOftljflSsJIgfFiXkqn7g6EoOmNyHo2hoIk3oPU3fJT5bJrKxD
   tOb4RNMco+OfpUge0c8T1FqFpztOJD40YSYCthtP8Ax/GDpoGeMtcy3DC
   /89yLzNr5GkKcwDnP7opvf7SeL2z+wl2J8LrQJPvO7vNsu0Dg6dRmQBS+
   Y21Ycmvhz0g61/zm18FwzM8mJIKPhhuum1lJROfieYvHVfhHLUDuOh9pP
   b3gNvZJzRwsu+L9JS6sSfDnDdAAYxaerpL8nZii1FuMNjEhz/4gPxYvvA
   w==;
X-CSE-ConnectionGUID: 48Z19nCUQZy6ulaZgwpI5g==
X-CSE-MsgGUID: ITnTiA/VRqSXbWumbtqWKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="109448790"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="109448790"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:32:46 -0700
X-CSE-ConnectionGUID: s5JOwlF/TMqmqT+DRfK3bg==
X-CSE-MsgGUID: VUgO25J8QKyh1BDZ3tHDug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260933906"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Aug 2026 13:32:46 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws4lf-00000000GBI-0lEz;
	Thu, 06 Aug 2026 20:32:43 +0000
Date: Fri, 07 Aug 2026 04:32:39 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 9e6205b0e7979066966de5ce237ad17994bfb388
Message-ID: <202608070427.oDik3miV-lkp@intel.com>
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
branch HEAD: 9e6205b0e7979066966de5ce237ad17994bfb388  Automatic merge of 'next' into merge (2026-08-05 10:06)

elapsed time: 1941m

configs tested: 104
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arm64                              defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260806    gcc-8.5.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-002-20260806    gcc-11.5.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-003-20260806    clang-17
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-004-20260806    clang-17
arm64                randconfig-004-20260807    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260806    gcc-15.2.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-002-20260806    gcc-13.4.0
csky                 randconfig-002-20260807    gcc-16.1.0
hexagon              randconfig-001-20260806    clang-24
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-002-20260806    clang-24
hexagon              randconfig-002-20260807    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260806    gcc-14
i386       buildonly-randconfig-002-20260806    gcc-14
i386       buildonly-randconfig-003-20260806    clang-22
i386       buildonly-randconfig-004-20260806    clang-22
i386       buildonly-randconfig-005-20260806    gcc-14
i386       buildonly-randconfig-006-20260806    gcc-14
i386                 randconfig-011-20260807    clang-22
i386                 randconfig-012-20260807    clang-22
i386                 randconfig-013-20260807    clang-22
i386                 randconfig-014-20260807    clang-22
i386                 randconfig-015-20260807    clang-22
i386                 randconfig-016-20260807    clang-22
i386                 randconfig-017-20260807    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260806    clang-22
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-002-20260806    clang-24
loongarch            randconfig-002-20260807    clang-18
m68k                         sun3x_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260806    gcc-9.5.0
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-002-20260806    gcc-11.5.0
nios2                randconfig-002-20260807    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260806    gcc-8.5.0
parisc               randconfig-001-20260807    gcc-8.5.0
parisc               randconfig-002-20260806    gcc-8.5.0
parisc               randconfig-002-20260807    gcc-8.5.0
powerpc                    asp8347_defconfig    clang-24
powerpc              randconfig-001-20260806    gcc-11.5.0
powerpc              randconfig-001-20260807    gcc-8.5.0
powerpc              randconfig-002-20260806    gcc-8.5.0
powerpc              randconfig-002-20260807    gcc-8.5.0
powerpc64            randconfig-001-20260806    gcc-8.5.0
powerpc64            randconfig-001-20260807    gcc-8.5.0
powerpc64            randconfig-002-20260806    clang-22
powerpc64            randconfig-002-20260807    gcc-8.5.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-002-20260807    gcc-12.5.0
s390                 randconfig-001-20260807    gcc-12.5.0
s390                 randconfig-002-20260807    gcc-12.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260807    gcc-12.5.0
sh                   randconfig-002-20260807    gcc-12.5.0
sparc                randconfig-001-20260806    gcc-16.1.0
sparc                randconfig-001-20260807    gcc-16.1.0
sparc                randconfig-002-20260806    gcc-8.5.0
sparc                randconfig-002-20260807    gcc-16.1.0
sparc64              randconfig-001-20260806    clang-20
sparc64              randconfig-001-20260807    gcc-16.1.0
sparc64              randconfig-002-20260806    gcc-8.5.0
sparc64              randconfig-002-20260807    gcc-16.1.0
um                   randconfig-001-20260806    gcc-14
um                   randconfig-001-20260807    gcc-16.1.0
um                   randconfig-002-20260806    gcc-14
um                   randconfig-002-20260807    gcc-16.1.0
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260806    clang-22
x86_64               randconfig-002-20260806    clang-22
x86_64               randconfig-003-20260806    gcc-14
x86_64               randconfig-004-20260806    clang-22
x86_64               randconfig-005-20260806    clang-22
x86_64               randconfig-006-20260806    gcc-14
x86_64               randconfig-011-20260806    clang-22
x86_64               randconfig-012-20260806    gcc-12
x86_64               randconfig-013-20260806    clang-22
x86_64               randconfig-014-20260806    clang-22
x86_64               randconfig-015-20260806    clang-22
x86_64               randconfig-016-20260806    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260806    gcc-14.3.0
xtensa               randconfig-001-20260807    gcc-16.1.0
xtensa               randconfig-002-20260806    gcc-16.1.0
xtensa               randconfig-002-20260807    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

