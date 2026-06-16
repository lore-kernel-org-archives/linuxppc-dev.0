Return-Path: <linuxppc-dev+bounces-22674-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602E1CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 00:47:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfSyN2Schz2yZZ;
	Tue, 16 Jun 2026 10:47:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781570876;
	cv=none; b=LCpWabhua/TKtUIfzFPlR2sB+v1U4OatMQNIwsg0s74SYb7yH963nsqOrlIEDbYL2uXoml7qcx4SH08CG0Mk76Q6/mFOMlL4UDkoWx7Iz9wLfuMiDsll2iyHVAoC9PmHFRRU11Z5Cq3c5n7wQBXzFS3X+I+5vBYTDFgJYxgJvF37cIkLE2QGsWwha0hARMGhOLcmLhntcb3j4InLzNmO9X456pG0CLTQH1bnHq8u5T7kGyWlBQZV22Kj7uKULmn+nJ941QUeDddRe2rt8rOX3tVrMcjnP+p3CudShI6cvZBUyIJNu5l/xYUnqKRDW1a3TOy7CuZvwPUy8CBkho9M0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781570876; c=relaxed/relaxed;
	bh=JLAfjff6ifwhhuk7kg5ZtFRPDIqFDrR8/gM1dvox6/Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XYN9OXpjoEQEaON5GpOvur7D+klaZibPthsReMX9g3YtPoG4CZMPUeGehtUcPokxPtN0h/29ZDgUf6hHnJRPd7DUcpPI6GUZZNYcy7pgRTwitUi+eYV5PyUMRb5XkIRmhv2+J00Z3oEky/ZboFhKRWMfuQe8oR4xk9QYhZBfKMYfPd5tipHXolWWW0Y8AmGqH5RF0vubM1h11lraX/oVUSJ71Lo/q4ldg1Up3d5fIKB/9equ1qdaXmL0vWCdQ/ZXMIVIKcIkm62rwyGxXordrLQV4B3h940uIYXXhn1oVrTrmcS7XjxNwYys2uMH8FG3vBs57iTS3oSoKWRoy6LDtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cAYWJwJ7; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cAYWJwJ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfSyJ2tnHz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 10:47:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781570873; x=1813106873;
  h=date:from:to:cc:subject:message-id;
  bh=peY67Kenu5oc61uJS559XvEznJJXeHGSEaY7d9a+/0s=;
  b=cAYWJwJ7QC8nrONT1X7GAGUiNilopnw9OIesCcsNHHK+dJqHqyxr5zz8
   bpylTzGB2i5LT9OOsBkZeuwxM1dWyP4ecRz1OzPe8L4vs39oKs9GlDQAh
   Wid8+jwkd8tv0p+EAgcbP7Of2iVgQarCrZKe31O15ugVeovUVUTS8XuuN
   t4ddNsFnBouIkgYIagw8p92j4KGEpp9hxntCEZf97sA1XohAHEy6NEQed
   rIOIJHFl/0txANkI55QRq1jY/kzpENgbF1XukIaqid9ABmOJT5qItwWVI
   5BgcencN8dXH9ffgCvQqLM3biIomQWxCqstPp2/HubGJMxyh+Nk1Yv/1G
   Q==;
X-CSE-ConnectionGUID: X2joWPtPRkCveu58y9XD1w==
X-CSE-MsgGUID: +otGUea0RYiYHbXznLRnIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="104995243"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="104995243"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 17:47:46 -0700
X-CSE-ConnectionGUID: xTHXRuOsQNqXYfDt74w20g==
X-CSE-MsgGUID: 6cQRLb7GQtamTWrBUieDug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="251534027"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Jun 2026 17:47:45 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZHxt-00000000SXm-3gQ8;
	Tue, 16 Jun 2026 00:47:41 +0000
Date: Tue, 16 Jun 2026 08:47:15 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 5c86f1c1f972761a04bf22f4c0618d1aa714185b
Message-ID: <202606160807.i5P1ujiF-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
branch HEAD: 5c86f1c1f972761a04bf22f4c0618d1aa714185b  powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus

elapsed time: 807m

configs tested: 327
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260615    gcc-10.5.0
arc                   randconfig-001-20260616    gcc-9.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260615    gcc-10.5.0
arc                   randconfig-002-20260615    gcc-16.1.0
arc                   randconfig-002-20260616    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                       imx_v4_v5_defconfig    clang-23
arm                         orion5x_defconfig    clang-21
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260615    gcc-10.5.0
arm                   randconfig-001-20260615    gcc-12.5.0
arm                   randconfig-001-20260616    gcc-9.5.0
arm                            randconfig-002    gcc-15.2.0
arm                   randconfig-002-20260615    gcc-10.5.0
arm                   randconfig-002-20260615    gcc-8.5.0
arm                   randconfig-002-20260616    gcc-9.5.0
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260615    gcc-10.5.0
arm                   randconfig-003-20260615    gcc-16.1.0
arm                   randconfig-003-20260616    gcc-9.5.0
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260615    clang-23
arm                   randconfig-004-20260615    gcc-10.5.0
arm                   randconfig-004-20260616    gcc-9.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260615    gcc-10.5.0
arm64                 randconfig-001-20260616    gcc-13.4.0
arm64                 randconfig-002-20260615    gcc-10.5.0
arm64                 randconfig-002-20260616    gcc-13.4.0
arm64                 randconfig-003-20260615    gcc-10.5.0
arm64                 randconfig-003-20260616    gcc-13.4.0
arm64                 randconfig-004-20260615    gcc-10.5.0
arm64                 randconfig-004-20260616    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260615    gcc-10.5.0
csky                  randconfig-001-20260616    gcc-13.4.0
csky                  randconfig-002-20260615    gcc-10.5.0
csky                  randconfig-002-20260616    gcc-13.4.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260615    clang-18
hexagon               randconfig-001-20260615    clang-21
hexagon               randconfig-001-20260616    clang-23
hexagon               randconfig-002-20260615    clang-18
hexagon               randconfig-002-20260616    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260615    clang-22
i386        buildonly-randconfig-001-20260615    gcc-14
i386        buildonly-randconfig-001-20260616    clang-22
i386        buildonly-randconfig-002-20260615    clang-22
i386        buildonly-randconfig-002-20260616    clang-22
i386        buildonly-randconfig-003-20260615    clang-22
i386        buildonly-randconfig-003-20260615    gcc-13
i386        buildonly-randconfig-003-20260616    clang-22
i386        buildonly-randconfig-004-20260615    clang-22
i386        buildonly-randconfig-004-20260616    clang-22
i386        buildonly-randconfig-005-20260615    clang-22
i386        buildonly-randconfig-005-20260616    clang-22
i386        buildonly-randconfig-006-20260615    clang-22
i386        buildonly-randconfig-006-20260616    clang-22
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260615    clang-22
i386                  randconfig-001-20260616    gcc-14
i386                  randconfig-002-20260615    clang-22
i386                  randconfig-002-20260616    gcc-14
i386                  randconfig-003-20260615    clang-22
i386                  randconfig-003-20260616    gcc-14
i386                  randconfig-004-20260615    clang-22
i386                  randconfig-004-20260616    gcc-14
i386                  randconfig-005-20260615    clang-22
i386                  randconfig-005-20260616    gcc-14
i386                  randconfig-006-20260615    clang-22
i386                  randconfig-006-20260616    gcc-14
i386                  randconfig-007-20260615    clang-22
i386                  randconfig-007-20260616    gcc-14
i386                  randconfig-011-20260615    gcc-14
i386                  randconfig-011-20260616    clang-22
i386                  randconfig-012-20260615    gcc-14
i386                  randconfig-012-20260616    clang-22
i386                  randconfig-013-20260615    gcc-14
i386                  randconfig-013-20260616    clang-22
i386                  randconfig-014-20260615    gcc-14
i386                  randconfig-014-20260616    clang-22
i386                  randconfig-015-20260615    gcc-14
i386                  randconfig-015-20260616    clang-22
i386                  randconfig-016-20260615    gcc-14
i386                  randconfig-016-20260616    clang-22
i386                  randconfig-017-20260615    gcc-14
i386                  randconfig-017-20260616    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260615    clang-18
loongarch             randconfig-001-20260615    gcc-16.1.0
loongarch             randconfig-001-20260616    clang-23
loongarch             randconfig-002-20260615    clang-18
loongarch             randconfig-002-20260616    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260615    clang-18
nios2                 randconfig-001-20260615    gcc-10.5.0
nios2                 randconfig-001-20260616    clang-23
nios2                 randconfig-002-20260615    clang-18
nios2                 randconfig-002-20260615    gcc-8.5.0
nios2                 randconfig-002-20260616    clang-23
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260615    gcc-13.4.0
parisc                randconfig-001-20260616    gcc-8.5.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260615    gcc-13.4.0
parisc                randconfig-002-20260616    gcc-8.5.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                      ep88xc_defconfig    gcc-16.1.0
powerpc                      pmac32_defconfig    clang-23
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260615    gcc-13.4.0
powerpc               randconfig-001-20260616    gcc-8.5.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260615    gcc-13.4.0
powerpc               randconfig-002-20260616    gcc-8.5.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260615    gcc-13.4.0
powerpc64             randconfig-001-20260616    gcc-8.5.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260615    gcc-13.4.0
powerpc64             randconfig-002-20260616    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-16.1.0
riscv                 randconfig-001-20260615    gcc-16.1.0
riscv                 randconfig-001-20260616    gcc-16.1.0
riscv                          randconfig-002    gcc-16.1.0
riscv                 randconfig-002-20260615    gcc-16.1.0
riscv                 randconfig-002-20260616    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-16.1.0
s390                  randconfig-001-20260615    gcc-16.1.0
s390                  randconfig-001-20260616    gcc-16.1.0
s390                           randconfig-002    gcc-16.1.0
s390                  randconfig-002-20260615    gcc-16.1.0
s390                  randconfig-002-20260616    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-16.1.0
sh                    randconfig-001-20260615    gcc-16.1.0
sh                    randconfig-001-20260616    gcc-16.1.0
sh                             randconfig-002    gcc-16.1.0
sh                    randconfig-002-20260615    gcc-16.1.0
sh                    randconfig-002-20260616    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260615    gcc-15.2.0
sparc                 randconfig-001-20260616    gcc-8.5.0
sparc                 randconfig-002-20260615    gcc-15.2.0
sparc                 randconfig-002-20260616    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260615    gcc-15.2.0
sparc64               randconfig-001-20260616    gcc-8.5.0
sparc64               randconfig-002-20260615    gcc-15.2.0
sparc64               randconfig-002-20260616    gcc-8.5.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260615    gcc-15.2.0
um                    randconfig-001-20260616    gcc-8.5.0
um                    randconfig-002-20260615    gcc-15.2.0
um                    randconfig-002-20260616    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260615    clang-22
x86_64      buildonly-randconfig-001-20260616    gcc-14
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260615    clang-22
x86_64      buildonly-randconfig-002-20260616    gcc-14
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260615    clang-22
x86_64      buildonly-randconfig-003-20260616    gcc-14
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260615    clang-22
x86_64      buildonly-randconfig-004-20260616    gcc-14
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260615    clang-22
x86_64      buildonly-randconfig-005-20260616    gcc-14
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260615    clang-22
x86_64      buildonly-randconfig-006-20260616    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260615    clang-22
x86_64                randconfig-001-20260615    gcc-14
x86_64                randconfig-001-20260616    clang-22
x86_64                randconfig-002-20260615    clang-22
x86_64                randconfig-002-20260615    gcc-14
x86_64                randconfig-002-20260616    clang-22
x86_64                randconfig-003-20260615    clang-22
x86_64                randconfig-003-20260616    clang-22
x86_64                randconfig-004-20260615    clang-22
x86_64                randconfig-004-20260615    gcc-14
x86_64                randconfig-004-20260616    clang-22
x86_64                randconfig-005-20260615    clang-22
x86_64                randconfig-005-20260615    gcc-14
x86_64                randconfig-005-20260616    clang-22
x86_64                randconfig-006-20260615    clang-22
x86_64                randconfig-006-20260616    clang-22
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260615    clang-22
x86_64                randconfig-011-20260615    gcc-14
x86_64                randconfig-011-20260616    clang-22
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260615    clang-22
x86_64                randconfig-012-20260616    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260615    clang-22
x86_64                randconfig-013-20260616    clang-22
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260615    clang-22
x86_64                randconfig-014-20260616    clang-22
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260615    clang-22
x86_64                randconfig-015-20260615    gcc-14
x86_64                randconfig-015-20260616    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260615    clang-22
x86_64                randconfig-016-20260615    gcc-14
x86_64                randconfig-016-20260616    clang-22
x86_64                randconfig-071-20260615    gcc-14
x86_64                randconfig-071-20260616    gcc-14
x86_64                randconfig-072-20260615    gcc-14
x86_64                randconfig-072-20260616    gcc-14
x86_64                randconfig-073-20260615    gcc-14
x86_64                randconfig-073-20260616    gcc-14
x86_64                randconfig-074-20260615    gcc-14
x86_64                randconfig-074-20260616    gcc-14
x86_64                randconfig-075-20260615    gcc-14
x86_64                randconfig-075-20260616    gcc-14
x86_64                randconfig-076-20260615    gcc-14
x86_64                randconfig-076-20260616    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260615    gcc-15.2.0
xtensa                randconfig-001-20260616    gcc-8.5.0
xtensa                randconfig-002-20260615    gcc-15.2.0
xtensa                randconfig-002-20260616    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

