Return-Path: <linuxppc-dev+bounces-20991-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9B0CD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 20:00:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHJ2p4GB9z2xSG;
	Sat, 16 May 2026 06:00:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778875218;
	cv=none; b=cqTDtCuZi7p7zo28H3FsyNdIz1fZtOCrhenTs81II9UMKzEHhn/nhSYOeJ2iZflfd+TkVaIYqWMxdEnm/BRTCjB7Yope4CVGhtKVRH1mBhGKsvHeRsqWCyYatXmSK9I2LVX4/Wfbhq+IDVXa8IbSOReN2RoP/DYN37d47JWt7Qc/luk5n/RiCXfMYlIZng27N+XH0HIWNs119YLk4YQ++K1d/sPGF1ou29ES/L24Z2cFm2PbpTBN6JUcTcmN3Qm8kqrmYHsdSX3ueb3tLH7nDLKokFjgfKnyTX0k8vl/dpj05PS84+gocwzBgo+lG2Vy0PPXEoF2+YmfNAOc3rElpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778875218; c=relaxed/relaxed;
	bh=AmWkWOFaTIca8D8IWdkCjhj3Q9u+QjJradgvOrGDMWM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Qew9odiWidOfoGIrvMG3TjWygTgu2TgzjVBo7uEkrqeRTvFziItKqXq/T2MRZuGsIq8aMDI5rkKpmimSklmpMNk7oigz6D0E8AqRIsABtXViLP4ZsR4WKZOSDCup5FluyG780TsL3pEbEI93n/aalFisWFQCuCK4G6TIcXeKpJdpKip5TdojiT9/iKTt8RTheV8EQrUmE2cHGMEDKDuja2EUKzI9HDGMRPi5ou+na50p/jbuUQPohgHKsEF2jEjMoYQLTwOzj3fG57JrsASo8T72IV2Di69PJT9Me0T49Oo8sVy3itPPfFPDWcNGg7q//xqjFJ8WzOYxoRQt2ZlvtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H7686ayI; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H7686ayI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHJ2l3zw2z2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 06:00:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778875217; x=1810411217;
  h=date:from:to:cc:subject:message-id;
  bh=2fFhso+WAdLblEpS8sjs7efpBTr0Lr9ew3ecTERSE6s=;
  b=H7686ayIgmaKQJEWS0JQzOVidojTpJUGy0SaKKB65kIjqpn4tZAnckT+
   3j27siOHO0IX3B3rfTUe8oPtIWP0iTPyG49qVauR21JDO37FS6MD77krB
   KK4KlR+lkAXkn6rW8Rb8eYWkquTvUF5skgl5yrH4xTdf60IYvErFbQQmy
   QBnZHKxReOqUUoae5B4jDOnXJJHKrwTQILVJYVXrE9C8E0f9CUsDqFSMB
   pdbmrewHPC6tK8LMMnQ5t5VTvrzwYcuhngAWS614vhDrTqSWe62M+BbCs
   ulA8n3JJTIiaCiGIQbeiCvj9aywUPh4MWBwwFgyfas+8sRrU9Ekj7YAby
   w==;
X-CSE-ConnectionGUID: NU019uSOSMes+jsfHq64Hg==
X-CSE-MsgGUID: I6naia0gQGa+NeaiasWAxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="97264897"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97264897"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 13:00:11 -0700
X-CSE-ConnectionGUID: LKhQtWOwSX2nz3x1OppyDg==
X-CSE-MsgGUID: VEwj/XjkS0+Wh2mje/SQzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262543392"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 15 May 2026 13:00:09 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNyha-000000002eW-2aX3;
	Fri, 15 May 2026 20:00:06 +0000
Date: Sat, 16 May 2026 03:56:55 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 1546b4ea65764226eacfb337b141e7563b336a75
Message-ID: <202605160336.mVyIawB2-lkp@intel.com>
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
branch HEAD: 1546b4ea65764226eacfb337b141e7563b336a75  Automatic merge of 'fixes' into merge (2026-05-15 12:09)

elapsed time: 793m

configs tested: 313
configs skipped: 6

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260515    gcc-13.4.0
arc                   randconfig-001-20260515    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260515    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260515    clang-23
arm                   randconfig-001-20260515    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260515    clang-23
arm                   randconfig-002-20260515    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260515    clang-23
arm                   randconfig-003-20260515    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260515    gcc-14.3.0
arm                   randconfig-004-20260515    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260515    clang-16
arm64                 randconfig-001-20260515    gcc-11.5.0
arm64                 randconfig-001-20260516    gcc-9.5.0
arm64                 randconfig-002-20260515    gcc-10.5.0
arm64                 randconfig-002-20260515    gcc-11.5.0
arm64                 randconfig-002-20260516    gcc-9.5.0
arm64                 randconfig-003-20260515    gcc-11.5.0
arm64                 randconfig-003-20260516    gcc-9.5.0
arm64                 randconfig-004-20260515    gcc-11.5.0
arm64                 randconfig-004-20260516    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260515    gcc-10.5.0
csky                  randconfig-001-20260515    gcc-11.5.0
csky                  randconfig-001-20260516    gcc-9.5.0
csky                  randconfig-002-20260515    gcc-11.5.0
csky                  randconfig-002-20260515    gcc-15.2.0
csky                  randconfig-002-20260516    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260515    clang-23
hexagon               randconfig-001-20260516    gcc-11.5.0
hexagon               randconfig-002-20260515    clang-23
hexagon               randconfig-002-20260516    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260515    gcc-14
i386        buildonly-randconfig-001-20260516    clang-20
i386        buildonly-randconfig-002-20260515    gcc-14
i386        buildonly-randconfig-002-20260516    clang-20
i386        buildonly-randconfig-003-20260515    gcc-12
i386        buildonly-randconfig-003-20260515    gcc-14
i386        buildonly-randconfig-003-20260516    clang-20
i386        buildonly-randconfig-004-20260515    gcc-12
i386        buildonly-randconfig-004-20260515    gcc-14
i386        buildonly-randconfig-004-20260516    clang-20
i386        buildonly-randconfig-005-20260515    gcc-14
i386        buildonly-randconfig-005-20260516    clang-20
i386        buildonly-randconfig-006-20260515    clang-20
i386        buildonly-randconfig-006-20260515    gcc-14
i386        buildonly-randconfig-006-20260516    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260515    clang-20
i386                  randconfig-002-20260515    clang-20
i386                  randconfig-003-20260515    clang-20
i386                  randconfig-004-20260515    clang-20
i386                  randconfig-005-20260515    clang-20
i386                  randconfig-006-20260515    gcc-14
i386                  randconfig-007-20260515    clang-20
i386                  randconfig-011-20260515    clang-20
i386                  randconfig-011-20260515    gcc-14
i386                  randconfig-012-20260515    gcc-14
i386                  randconfig-013-20260515    gcc-14
i386                  randconfig-014-20260515    clang-20
i386                  randconfig-014-20260515    gcc-14
i386                  randconfig-015-20260515    clang-20
i386                  randconfig-015-20260515    gcc-14
i386                  randconfig-016-20260515    clang-20
i386                  randconfig-016-20260515    gcc-14
i386                  randconfig-017-20260515    clang-20
i386                  randconfig-017-20260515    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    clang-23
loongarch             randconfig-001-20260515    gcc-15.2.0
loongarch             randconfig-001-20260516    gcc-11.5.0
loongarch             randconfig-002-20260515    clang-23
loongarch             randconfig-002-20260516    gcc-11.5.0
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
mips                 decstation_r4k_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260515    gcc-11.5.0
nios2                 randconfig-001-20260516    gcc-11.5.0
nios2                 randconfig-002-20260515    gcc-8.5.0
nios2                 randconfig-002-20260516    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260515    gcc-10.5.0
parisc                randconfig-001-20260515    gcc-8.5.0
parisc                randconfig-001-20260516    gcc-12.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260515    gcc-15.2.0
parisc                randconfig-002-20260515    gcc-8.5.0
parisc                randconfig-002-20260516    gcc-12.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-8.5.0
powerpc               randconfig-001-20260515    clang-16
powerpc               randconfig-001-20260515    gcc-8.5.0
powerpc               randconfig-001-20260516    gcc-12.5.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260515    gcc-8.5.0
powerpc               randconfig-002-20260516    gcc-12.5.0
powerpc64                      randconfig-001    gcc-8.5.0
powerpc64             randconfig-001-20260515    gcc-14.3.0
powerpc64             randconfig-001-20260515    gcc-8.5.0
powerpc64             randconfig-001-20260516    gcc-12.5.0
powerpc64                      randconfig-002    gcc-8.5.0
powerpc64             randconfig-002-20260515    clang-23
powerpc64             randconfig-002-20260515    gcc-8.5.0
powerpc64             randconfig-002-20260516    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260515    clang-23
riscv                 randconfig-001-20260515    gcc-15.2.0
riscv                 randconfig-001-20260516    gcc-15.2.0
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260515    clang-23
riscv                 randconfig-002-20260515    gcc-15.2.0
riscv                 randconfig-002-20260516    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-11.5.0
s390                  randconfig-001-20260515    clang-18
s390                  randconfig-001-20260515    gcc-15.2.0
s390                  randconfig-001-20260516    gcc-15.2.0
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260515    clang-23
s390                  randconfig-002-20260515    gcc-15.2.0
s390                  randconfig-002-20260516    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260515    gcc-13.4.0
sh                    randconfig-001-20260515    gcc-15.2.0
sh                    randconfig-001-20260516    gcc-15.2.0
sh                             randconfig-002    gcc-14.3.0
sh                    randconfig-002-20260515    gcc-15.2.0
sh                    randconfig-002-20260516    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260515    gcc-8.5.0
sparc                 randconfig-001-20260516    gcc-8.5.0
sparc                 randconfig-002-20260515    gcc-15.2.0
sparc                 randconfig-002-20260516    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260515    clang-20
sparc64               randconfig-001-20260516    gcc-8.5.0
sparc64               randconfig-002-20260515    clang-20
sparc64               randconfig-002-20260516    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260515    gcc-14
um                    randconfig-001-20260516    gcc-8.5.0
um                    randconfig-002-20260515    gcc-14
um                    randconfig-002-20260516    gcc-8.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260515    clang-20
x86_64      buildonly-randconfig-001-20260515    gcc-14
x86_64      buildonly-randconfig-002-20260515    gcc-14
x86_64      buildonly-randconfig-003-20260515    gcc-14
x86_64      buildonly-randconfig-004-20260515    gcc-12
x86_64      buildonly-randconfig-004-20260515    gcc-14
x86_64      buildonly-randconfig-005-20260515    gcc-14
x86_64      buildonly-randconfig-006-20260515    clang-20
x86_64      buildonly-randconfig-006-20260515    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260515    clang-20
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260515    clang-20
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260515    gcc-13
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260515    clang-20
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260515    clang-20
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260515    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260515    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260515    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260515    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260515    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260515    clang-20
x86_64                randconfig-015-20260515    gcc-14
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260515    clang-20
x86_64                randconfig-016-20260515    gcc-14
x86_64                randconfig-071-20260515    clang-20
x86_64                randconfig-071-20260515    gcc-12
x86_64                randconfig-072-20260515    gcc-12
x86_64                randconfig-072-20260515    gcc-14
x86_64                randconfig-073-20260515    gcc-12
x86_64                randconfig-073-20260515    gcc-14
x86_64                randconfig-074-20260515    clang-20
x86_64                randconfig-074-20260515    gcc-12
x86_64                randconfig-075-20260515    gcc-12
x86_64                randconfig-076-20260515    clang-20
x86_64                randconfig-076-20260515    gcc-12
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
xtensa                randconfig-001-20260515    gcc-9.5.0
xtensa                randconfig-001-20260516    gcc-8.5.0
xtensa                randconfig-002-20260515    gcc-11.5.0
xtensa                randconfig-002-20260516    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

