Return-Path: <linuxppc-dev+bounces-17873-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19687EA8549
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 01:05:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTf2J1PDhz2xdL;
	Mon, 09 Mar 2026 12:05:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773018328;
	cv=none; b=AxwnkqbHjTPSdwVD7jL2V+XxIHEX9zNwTwwwuTvKu6TE92typ0R1TlSeFr2EVBX0hLBx6wVnRZXNhgtMXaiqXOL38P73v5ubWoNFbImrjJ77spD/EiF84XauoYSxkra1zn2dyKo2dSAV/Z3u0lYbCXIWO7IHW+vW9wGfzHJYONru0W8jovrZhwuQP08HBRTqA3TA2tnsEF+CFAdcP8n8vaI75VFIB95Bq//OhmQipXGS+T4AQlknI/FCN9YeiQLUPx7AnRrfROq98aPGRC4Sn3HtxbvBO+aH9PcdIibA5qB7z1bvbNZbem7XFtjDdea6mQa7MFgXc4W0wupjS844Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773018328; c=relaxed/relaxed;
	bh=aAC3RFJVLEjnSABVgv4cAkrEkPALPkaWdFG+sACSAf8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=M6ENSHOxoP8tdgrnV2B/Ap3kLNqAyrMEd1jI2tOUlUNOsYLkDJTd3gKNOhGDHUBUim4XLU5EBrgzNfWdT1Sm5yuQGKL2VhmD61EydFaRaDK7NwKwTv9aEH9OFN4YVdI/fGjdrm3qbasIBmSjSoVsReJzB1rkAuZvHl+sUKmrq76NhZW7pWm5qrEZgVFuiUF4rJnbdys487JD2mmZOk2Y2RROTQxy0xDhEugRn8aXszkBmy3ssKBDqQe3HqWUPv29pWpdicEpo633n2xdVgoEYWUQW3S4xZpBM+wpDIRZJljVwIcq/NFQ6FkbHToH3nQGje5tpnXgGMa2mlilDWbvFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=djEmI+Ml; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=djEmI+Ml;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTf2C3mymz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 12:05:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773018324; x=1804554324;
  h=date:from:to:cc:subject:message-id;
  bh=obpoGttZ3F8tcX58m+TMHXDjcrQe1ImiIltedZHapFQ=;
  b=djEmI+MlzuaMcNrJeXM8cznGmAxISrDJwm/JBkpMYj8njl2z1zs6NL6B
   B13LS3gBdEHAzt25/iWmxs5zHEIRfmSwfL5clJOIt4AB865244MpvHrhs
   +SwCazaa4yaOz8Hhib+tLJjL1q5pY3idBRRPdiPyeT/GSNY4WVUuC57Wh
   27dXZMvGEfll+mzPv3O1/f7KqRcFAHbgv9oP8xhruROyfHS4HkuwirmZq
   LZVFmZJMNhQQ0PvTNTMomEHL3kprbHNWXGt1/13OjKLR6SNyuOA4tqSoz
   UNqoMZRpYFq+q/gOn7i7eooRn30MIBxbpoyHgKbYmlZt/ZdK5lojHobcg
   g==;
X-CSE-ConnectionGUID: ZX2LbBihRvWNNxz4AYyd8Q==
X-CSE-MsgGUID: /rlK/bkLTFewmRNkMpGiuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84365888"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84365888"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 18:05:16 -0700
X-CSE-ConnectionGUID: U2wJzivAQUOlQnK+x1VMSQ==
X-CSE-MsgGUID: mmHG5gnbQniOUmjY6wAQZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="217232552"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2026 18:05:14 -0700
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzP3X-000000003WS-2jlJ;
	Mon, 09 Mar 2026 01:05:11 +0000
Date: Mon, 09 Mar 2026 09:04:34 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 6edcf9084ca5c607f90e47745e5ec060ec7d0445
Message-ID: <202603090918.EvPyjarA-lkp@intel.com>
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
branch HEAD: 6edcf9084ca5c607f90e47745e5ec060ec7d0445  Automatic merge of 'fixes' into merge (2026-03-08 18:12)

elapsed time: 728m

configs tested: 262
configs skipped: 3

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
arc                   randconfig-001-20260308    gcc-11.5.0
arc                   randconfig-001-20260308    gcc-8.5.0
arc                   randconfig-001-20260309    clang-17
arc                   randconfig-002-20260308    gcc-10.5.0
arc                   randconfig-002-20260308    gcc-8.5.0
arc                   randconfig-002-20260309    clang-17
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260308    clang-17
arm                   randconfig-001-20260308    gcc-8.5.0
arm                   randconfig-001-20260309    clang-17
arm                   randconfig-002-20260308    gcc-8.5.0
arm                   randconfig-002-20260309    clang-17
arm                   randconfig-003-20260308    clang-18
arm                   randconfig-003-20260308    gcc-8.5.0
arm                   randconfig-003-20260309    clang-17
arm                   randconfig-004-20260308    clang-23
arm                   randconfig-004-20260308    gcc-8.5.0
arm                   randconfig-004-20260309    clang-17
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260308    clang-23
arm64                 randconfig-002-20260308    clang-23
arm64                 randconfig-003-20260308    clang-23
arm64                 randconfig-004-20260308    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260308    clang-23
csky                  randconfig-002-20260308    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260308    clang-23
hexagon               randconfig-002-20260308    clang-16
hexagon               randconfig-002-20260308    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260308    clang-20
i386        buildonly-randconfig-002-20260308    clang-20
i386        buildonly-randconfig-003-20260308    clang-20
i386        buildonly-randconfig-004-20260308    clang-20
i386        buildonly-randconfig-005-20260308    clang-20
i386        buildonly-randconfig-006-20260308    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260308    gcc-14
i386                  randconfig-001-20260309    gcc-14
i386                  randconfig-002-20260308    gcc-14
i386                  randconfig-002-20260309    gcc-14
i386                  randconfig-003-20260308    gcc-14
i386                  randconfig-003-20260309    gcc-14
i386                  randconfig-004-20260308    gcc-14
i386                  randconfig-004-20260309    gcc-14
i386                  randconfig-005-20260308    gcc-14
i386                  randconfig-005-20260309    gcc-14
i386                  randconfig-006-20260308    gcc-14
i386                  randconfig-006-20260309    gcc-14
i386                  randconfig-007-20260308    gcc-14
i386                  randconfig-007-20260309    gcc-14
i386                  randconfig-011-20260308    clang-20
i386                  randconfig-011-20260308    gcc-14
i386                  randconfig-012-20260308    clang-20
i386                  randconfig-013-20260308    clang-20
i386                  randconfig-013-20260308    gcc-14
i386                  randconfig-014-20260308    clang-20
i386                  randconfig-014-20260308    gcc-14
i386                  randconfig-015-20260308    clang-20
i386                  randconfig-015-20260308    gcc-14
i386                  randconfig-016-20260308    clang-20
i386                  randconfig-017-20260308    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260308    clang-19
loongarch             randconfig-001-20260308    clang-23
loongarch             randconfig-002-20260308    clang-23
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
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260308    clang-23
nios2                 randconfig-001-20260308    gcc-11.5.0
nios2                 randconfig-002-20260308    clang-23
nios2                 randconfig-002-20260308    gcc-11.5.0
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
parisc                randconfig-001-20260308    gcc-8.5.0
parisc                randconfig-001-20260309    gcc-8.5.0
parisc                randconfig-002-20260308    gcc-8.5.0
parisc                randconfig-002-20260309    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260308    gcc-8.5.0
powerpc               randconfig-001-20260309    gcc-8.5.0
powerpc               randconfig-002-20260308    gcc-8.5.0
powerpc               randconfig-002-20260309    gcc-8.5.0
powerpc64             randconfig-001-20260308    gcc-8.5.0
powerpc64             randconfig-001-20260309    gcc-8.5.0
powerpc64             randconfig-002-20260308    gcc-8.5.0
powerpc64             randconfig-002-20260309    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260308    gcc-12.5.0
riscv                 randconfig-002-20260308    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260308    gcc-12.5.0
s390                  randconfig-002-20260308    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260308    gcc-12.5.0
sh                    randconfig-002-20260308    gcc-12.5.0
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260308    gcc-15.2.0
sparc                 randconfig-001-20260308    gcc-8.5.0
sparc                 randconfig-001-20260309    gcc-13.4.0
sparc                 randconfig-002-20260308    gcc-11.5.0
sparc                 randconfig-002-20260308    gcc-15.2.0
sparc                 randconfig-002-20260309    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260308    clang-20
sparc64               randconfig-001-20260308    gcc-15.2.0
sparc64               randconfig-001-20260309    gcc-13.4.0
sparc64               randconfig-002-20260308    gcc-15.2.0
sparc64               randconfig-002-20260308    gcc-8.5.0
sparc64               randconfig-002-20260309    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260308    gcc-14
um                    randconfig-001-20260308    gcc-15.2.0
um                    randconfig-001-20260309    gcc-13.4.0
um                    randconfig-002-20260308    gcc-14
um                    randconfig-002-20260308    gcc-15.2.0
um                    randconfig-002-20260309    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260308    clang-20
x86_64      buildonly-randconfig-001-20260309    gcc-14
x86_64      buildonly-randconfig-002-20260308    clang-20
x86_64      buildonly-randconfig-002-20260309    gcc-14
x86_64      buildonly-randconfig-003-20260308    clang-20
x86_64      buildonly-randconfig-003-20260309    gcc-14
x86_64      buildonly-randconfig-004-20260308    clang-20
x86_64      buildonly-randconfig-004-20260309    gcc-14
x86_64      buildonly-randconfig-005-20260308    clang-20
x86_64      buildonly-randconfig-005-20260309    gcc-14
x86_64      buildonly-randconfig-006-20260308    clang-20
x86_64      buildonly-randconfig-006-20260309    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260308    gcc-14
x86_64                randconfig-001-20260309    gcc-13
x86_64                randconfig-002-20260308    gcc-14
x86_64                randconfig-002-20260309    gcc-13
x86_64                randconfig-003-20260308    clang-20
x86_64                randconfig-003-20260308    gcc-14
x86_64                randconfig-003-20260309    gcc-13
x86_64                randconfig-004-20260308    gcc-14
x86_64                randconfig-004-20260309    gcc-13
x86_64                randconfig-005-20260308    clang-20
x86_64                randconfig-005-20260308    gcc-14
x86_64                randconfig-005-20260309    gcc-13
x86_64                randconfig-006-20260308    gcc-14
x86_64                randconfig-006-20260309    gcc-13
x86_64                randconfig-011-20260308    clang-20
x86_64                randconfig-012-20260308    clang-20
x86_64                randconfig-013-20260308    clang-20
x86_64                randconfig-014-20260308    clang-20
x86_64                randconfig-015-20260308    clang-20
x86_64                randconfig-016-20260308    clang-20
x86_64                randconfig-071-20260308    clang-20
x86_64                randconfig-071-20260309    gcc-14
x86_64                randconfig-072-20260308    clang-20
x86_64                randconfig-072-20260309    gcc-14
x86_64                randconfig-073-20260308    clang-20
x86_64                randconfig-073-20260309    gcc-14
x86_64                randconfig-074-20260308    gcc-14
x86_64                randconfig-074-20260309    gcc-14
x86_64                randconfig-075-20260308    clang-20
x86_64                randconfig-075-20260309    gcc-14
x86_64                randconfig-076-20260308    gcc-14
x86_64                randconfig-076-20260309    gcc-14
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
xtensa                randconfig-001-20260308    gcc-11.5.0
xtensa                randconfig-001-20260308    gcc-15.2.0
xtensa                randconfig-001-20260309    gcc-13.4.0
xtensa                randconfig-002-20260308    gcc-15.2.0
xtensa                randconfig-002-20260309    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

