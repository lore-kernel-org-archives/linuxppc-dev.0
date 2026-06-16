Return-Path: <linuxppc-dev+bounces-22730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33EDCD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 22:13:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gg1TG3TPwz2ybR;
	Wed, 17 Jun 2026 08:13:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781647986;
	cv=none; b=XIO8ikDFp+DdY4byYarLgbAENUatvceiXVYZCAmOFWfeUVr/TqgjMFzjCfa3NESURMWIcYLkosn2MmWnk0hdyriyo4oLRTIMzWp8xhKB9W93V1pnMRwP+CNU4XwgIpdOtJhCI2ZffewRxxPdur/wxWgp8NxGTVD1bsQTRosEvMk1sPYSrht7/LbB4HpDTWuoagKK/9cAa5M+yBkrJtA97dgpKslVKu62uwxVzQc0R+jJd7RjlPHkebHAwjEtHvTbcLK9UaVwL1Ef4BJHWKJKIOM6FPVRThtqhLCc49P6xoKjo3XnQcPXck7HdPZELXTDMSTQPg/aZ/AiuihfbR+ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781647986; c=relaxed/relaxed;
	bh=yWAkn0NHjSrOWZLtJSIaHTf/PdWpf/8BY4pwCbxvOww=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eMxrGDZ8cqbQGC7cn055zooDAU10P8RJgEXhZ83ps6wqAGXFpNv1SrkS3sFNoI7ziDKyS6PCEKUMTvy9VvifMrpNbBcSBbMXglSduN8pgO9c4G15GEu/Tsr6H5G43lLpiPRyKhRmhxRu69qWBDYXGh6gFNiTynCFF+nTSFFiPuVv7dLdZZjmx7oATWMWbZa6B5foEwTJaLG5xpZtKgzddMETITFsKeE05tY8Zf+XEumPNt1nJGR7unPVtzS6dBLNRjAl/R6mO11jOYPpORb5UEk82NtmhFcdisZQ6tAP8WRIP3F7L2MWX+kseD/ZRusBdrQf+88vCe1jzGAqvXtMGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UkUEgXLF; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UkUEgXLF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gg1TB6phdz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 08:13:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781647983; x=1813183983;
  h=date:from:to:cc:subject:message-id;
  bh=Ady9G6yPnHjEL5znJ+blSYfY2tl6htMOfxpEZrI/Y/0=;
  b=UkUEgXLFUItxyhDV6LEhzMOva+whS867jftbXTMqhroBG5j+Cqn33iCd
   IYpENJUs/45aJPnzkKEXF29R/gtz1KRqtkJK83jnnXxsVck0bI+FT5mDa
   lY6aeFtp+nUpFifIpQgtHzQvY4eb4sYgjxPZXssUgSJZbtrECjRWz3H1I
   uCgp3PTVgYFdWPMCCnJu+mmdMLeslsmTHS3diiEiTXY5eL5E6QR2CgBjr
   wlZirbvQNSZBbPlVMzJtj7us94EcIgV2F58xZOsfkeNSeyINq1BAkrfzO
   sVarX+1WBQP2/Q5hZJ/ae9h+1OIBgAIgtmGgL9RUjLl293hOrtTYVUBuH
   A==;
X-CSE-ConnectionGUID: OEOkFMMdSjONMfjT5ofrkw==
X-CSE-MsgGUID: KBN0VpvOQo2w7Vds+6qMoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="86344605"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86344605"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 15:12:57 -0700
X-CSE-ConnectionGUID: aMaAOJtCRtmuUvE23BMQdA==
X-CSE-MsgGUID: HKx42tzzS0eJVKnSbTc6Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="243730770"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jun 2026 15:12:55 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZc1d-00000000Tnc-1AAW;
	Tue, 16 Jun 2026 22:12:53 +0000
Date: Wed, 17 Jun 2026 06:12:42 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 42f252f5a646866a95f025863c8b201042494ba1
Message-ID: <202606170630.ARDBT7wo-lkp@intel.com>
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
branch HEAD: 42f252f5a646866a95f025863c8b201042494ba1  powerpc/fadump: define MIN_RMA in bytes rather than MB

elapsed time: 729m

configs tested: 284
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260616    gcc-9.5.0
arc                   randconfig-001-20260617    gcc-16.1.0
arc                   randconfig-002-20260616    gcc-9.5.0
arc                   randconfig-002-20260617    gcc-16.1.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                         lpc18xx_defconfig    clang-23
arm                   randconfig-001-20260616    gcc-9.5.0
arm                   randconfig-001-20260617    gcc-16.1.0
arm                   randconfig-002-20260616    gcc-9.5.0
arm                   randconfig-002-20260617    gcc-16.1.0
arm                   randconfig-003-20260616    gcc-9.5.0
arm                   randconfig-003-20260617    gcc-16.1.0
arm                   randconfig-004-20260616    gcc-9.5.0
arm                   randconfig-004-20260617    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260616    clang-23
arm64                 randconfig-001-20260617    gcc-12.5.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260616    clang-23
arm64                 randconfig-002-20260617    gcc-12.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260616    clang-23
arm64                 randconfig-003-20260617    gcc-12.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260616    clang-23
arm64                 randconfig-004-20260617    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260616    clang-23
csky                  randconfig-001-20260617    gcc-12.5.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260616    clang-23
csky                  randconfig-002-20260617    gcc-12.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260616    clang-23
hexagon               randconfig-001-20260617    clang-17
hexagon               randconfig-002-20260616    clang-23
hexagon               randconfig-002-20260617    clang-17
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260616    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260616    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260616    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260616    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260616    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260616    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260616    gcc-14
i386                  randconfig-002-20260616    gcc-14
i386                  randconfig-003-20260616    gcc-14
i386                  randconfig-004-20260616    gcc-14
i386                  randconfig-005-20260616    gcc-14
i386                  randconfig-006-20260616    gcc-14
i386                  randconfig-007-20260616    gcc-14
i386                           randconfig-011    clang-22
i386                  randconfig-011-20260616    clang-22
i386                  randconfig-011-20260617    clang-22
i386                           randconfig-012    clang-22
i386                  randconfig-012-20260616    clang-22
i386                  randconfig-012-20260617    clang-22
i386                           randconfig-013    clang-22
i386                  randconfig-013-20260616    clang-22
i386                  randconfig-013-20260617    clang-22
i386                           randconfig-014    clang-22
i386                  randconfig-014-20260616    clang-22
i386                  randconfig-014-20260617    clang-22
i386                           randconfig-015    clang-22
i386                  randconfig-015-20260616    clang-22
i386                  randconfig-015-20260617    clang-22
i386                           randconfig-016    clang-22
i386                  randconfig-016-20260616    clang-22
i386                  randconfig-016-20260617    clang-22
i386                           randconfig-017    clang-22
i386                  randconfig-017-20260616    clang-22
i386                  randconfig-017-20260617    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260616    clang-23
loongarch             randconfig-001-20260617    clang-17
loongarch             randconfig-002-20260616    clang-23
loongarch             randconfig-002-20260617    clang-17
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                      malta_kvm_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260616    clang-23
nios2                 randconfig-001-20260617    clang-17
nios2                 randconfig-002-20260616    clang-23
nios2                 randconfig-002-20260617    clang-17
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260616    gcc-8.5.0
parisc                randconfig-001-20260617    gcc-15.2.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260616    gcc-8.5.0
parisc                randconfig-002-20260617    gcc-15.2.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc8315_rdb_defconfig    clang-23
powerpc                        randconfig-001    gcc-8.5.0
powerpc               randconfig-001-20260616    gcc-8.5.0
powerpc               randconfig-001-20260617    gcc-15.2.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260616    gcc-8.5.0
powerpc               randconfig-002-20260617    gcc-15.2.0
powerpc64                      randconfig-001    gcc-8.5.0
powerpc64             randconfig-001-20260616    gcc-8.5.0
powerpc64             randconfig-001-20260617    gcc-15.2.0
powerpc64                      randconfig-002    gcc-8.5.0
powerpc64             randconfig-002-20260616    gcc-8.5.0
powerpc64             randconfig-002-20260617    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260616    gcc-16.1.0
riscv                 randconfig-001-20260617    gcc-16.1.0
riscv                 randconfig-002-20260616    gcc-16.1.0
riscv                 randconfig-002-20260617    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260616    gcc-16.1.0
s390                  randconfig-001-20260617    gcc-16.1.0
s390                  randconfig-002-20260616    gcc-16.1.0
s390                  randconfig-002-20260617    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260616    gcc-16.1.0
sh                    randconfig-001-20260617    gcc-16.1.0
sh                    randconfig-002-20260616    gcc-16.1.0
sh                    randconfig-002-20260617    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260616    gcc-8.5.0
sparc                 randconfig-001-20260617    gcc-16.1.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260616    gcc-8.5.0
sparc                 randconfig-002-20260617    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260616    gcc-8.5.0
sparc64               randconfig-001-20260617    gcc-16.1.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260616    gcc-8.5.0
sparc64               randconfig-002-20260617    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260616    gcc-8.5.0
um                    randconfig-001-20260617    gcc-16.1.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260616    gcc-8.5.0
um                    randconfig-002-20260617    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260616    gcc-14
x86_64      buildonly-randconfig-001-20260617    clang-22
x86_64      buildonly-randconfig-002-20260616    gcc-14
x86_64      buildonly-randconfig-002-20260617    clang-22
x86_64      buildonly-randconfig-003-20260616    gcc-14
x86_64      buildonly-randconfig-003-20260617    clang-22
x86_64      buildonly-randconfig-004-20260616    gcc-14
x86_64      buildonly-randconfig-004-20260617    clang-22
x86_64      buildonly-randconfig-005-20260616    gcc-14
x86_64      buildonly-randconfig-005-20260617    clang-22
x86_64      buildonly-randconfig-006-20260616    gcc-14
x86_64      buildonly-randconfig-006-20260617    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260616    clang-22
x86_64                randconfig-001-20260617    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260616    clang-22
x86_64                randconfig-002-20260617    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260616    clang-22
x86_64                randconfig-003-20260617    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260616    clang-22
x86_64                randconfig-004-20260617    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260616    clang-22
x86_64                randconfig-005-20260617    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260616    clang-22
x86_64                randconfig-006-20260617    clang-22
x86_64                randconfig-011-20260616    clang-22
x86_64                randconfig-011-20260617    clang-22
x86_64                randconfig-012-20260616    clang-22
x86_64                randconfig-012-20260617    clang-22
x86_64                randconfig-013-20260616    clang-22
x86_64                randconfig-013-20260617    clang-22
x86_64                randconfig-014-20260616    clang-22
x86_64                randconfig-014-20260617    clang-22
x86_64                randconfig-015-20260616    clang-22
x86_64                randconfig-015-20260617    clang-22
x86_64                randconfig-016-20260616    clang-22
x86_64                randconfig-016-20260617    clang-22
x86_64                         randconfig-071    gcc-13
x86_64                randconfig-071-20260616    gcc-13
x86_64                randconfig-071-20260617    clang-22
x86_64                         randconfig-072    gcc-13
x86_64                randconfig-072-20260616    gcc-13
x86_64                randconfig-072-20260617    clang-22
x86_64                         randconfig-073    gcc-13
x86_64                randconfig-073-20260616    gcc-13
x86_64                randconfig-073-20260617    clang-22
x86_64                         randconfig-074    gcc-13
x86_64                randconfig-074-20260616    gcc-13
x86_64                randconfig-074-20260617    clang-22
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260616    gcc-13
x86_64                randconfig-075-20260617    clang-22
x86_64                         randconfig-076    gcc-13
x86_64                randconfig-076-20260616    gcc-13
x86_64                randconfig-076-20260617    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260616    gcc-8.5.0
xtensa                randconfig-001-20260617    gcc-16.1.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260616    gcc-8.5.0
xtensa                randconfig-002-20260617    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

