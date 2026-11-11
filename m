Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313E606A324
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RzxIFpiC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPSgw2HlKz2xMQ;
	Wed, 11 Nov 2026 13:50:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794365452;
	cv=none; b=gcRbCoVHms5XHAfKZDb3uKwSyA4gUaHqZ9FnvjHvDXwWR4xKrpdOFKKLPtlQw3tDURprk5R8gLyvQlqgHZ72NfEddj4nKxIWqCRFqRIgoCYEkxTuv7QgqXV1YK0nerDXpkUzIU1xoVqxZ/YhahAngmzyS6El84+5McJ19stGpkRkTL6P3rKN0DniUaNewhXYvIqOGaRvjNaPUHXyw3TAYT8U0qn1SlhJyvWxdC6JSnD7qOkPQLs3UAOtlJ7FzMUKP1abXEN5zrT5rYGGUTJEZrQOw5qedGUKph+EfawzXbX7NyGhWc64gW+1RG9y14GiIfFmxQDDmkapQo4OjMxzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794365452; c=relaxed/relaxed;
	bh=bBqYbHsuiXcqTZVH5xuVrvwENGrrYay8R8yqPBVtse8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N/pIITkicdczu+YLsFB1tF+p0Vthxys03J9y0UfMCjZpzP+CRKOLPrQ9BTyEZniDCZLsMFNDDHz+hwwFbeUNk5IrsIwaT7h0YSVoaHBiCh1THx70rTufeU/C8WRA1V5jLfwN9Jpe5p0tFXKQe2Uk4e/Yy87WyukldAc15ylvAd/zhyM4EZ+ka9c8qMIsXN0sBWW7kyoocKUb+BY9C4+KFDJcPs76ndKOUE1ppaNh7P7QhR9bsfBVXboMk9qRBKQxoG34EkkDnn7Dp6YqnSsuOezOqS/Msfc7YmKU5BViJKNS6i45IKXlkbjTH8cvoUHXnAEwQ09zpmDVBosPl1RFBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RzxIFpiC; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RzxIFpiC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPSgs5qQvz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 13:50:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794365450; x=1825901450;
  h=date:from:to:cc:subject:message-id;
  bh=jNoFvSjRYs8KHRaXFaDKXVt8jqYB2aVfRjgxOA00Ezc=;
  b=RzxIFpiC2EqPGUzmR0WjwGEHTqUbimgZTDQnb49bAtG6nYB0JIBLyh7P
   wF8Deo6GRQ8Sfm+dJEI8oH56hYkhOUlQgL9hh0EmCgLz2OtpiiMrz8Uap
   as9gaBPGvwVaGQ0GDXcL3xbE+i5uQAaGSpH+0sjS5lqhxAAv2e+OEtpcL
   oj1Z7HgTtfVpE2K6ZCDJQ3/HlHWApQa1l7ODqKZirQmfAP4OFI4fQrM94
   npdgaDi5DSFtQId9R92VqESnpEgN1gpPBxlaWh/LfHDeQoPFo1EutqgMF
   CTvDAJb2OmdA6DnPsda4yCPGgMUWsPflfLu718ta7KY4Q5efunxmdpmlv
   w==;
X-CSE-ConnectionGUID: LjEDiIWbSDaWI4JjoRkkvw==
X-CSE-MsgGUID: 00wDi92hSaeX9sVZHOS60Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3134239"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3134239"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 18:50:44 -0800
X-CSE-ConnectionGUID: 3BvH02UKTbGlIveJq94DSg==
X-CSE-MsgGUID: sn3Di4R1Qdqql1kJtJlD/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8300675"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Nov 2026 18:50:42 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQyQ3-00000000xxt-2QSB;
	Wed, 11 Nov 2026 02:50:39 +0000
Date: Wed, 11 Nov 2026 10:50:17 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 e4438b41690cb2a5dff1e0f75dc6f36f24019e79
Message-ID: <20261111105017.CEOosiDl-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git merge
branch HEAD: e4438b41690cb2a5dff1e0f75dc6f36f24019e79  Automatic merge of 'fixes' into merge (2026-11-10 09:25)

elapsed time: 917m

configs tested: 266
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                         nsimosci_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261111    gcc-15.3.0
arc                   randconfig-1001-20261111    gcc-15.3.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                       footbridge_defconfig    gcc-16.2.0
arm                         mvebu_v5_defconfig    gcc-16.2.0
arm                         mvebu_v7_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261111    gcc-15.3.0
arm                   randconfig-1001-20261111    gcc-15.3.0
arm                   randconfig-1002-20261111    gcc-15.3.0
arm                   randconfig-1003-20261111    gcc-15.3.0
arm                            spitz_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261110    gcc-12.5.0
arm64                 randconfig-1000-20261111    gcc-13.5.0
arm64                 randconfig-1001-20261110    gcc-12.5.0
arm64                 randconfig-1001-20261111    gcc-13.5.0
arm64                 randconfig-1002-20261110    gcc-12.5.0
arm64                 randconfig-1002-20261111    gcc-13.5.0
arm64                 randconfig-1003-20261110    gcc-12.5.0
arm64                 randconfig-1003-20261111    gcc-13.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261110    gcc-12.5.0
csky                  randconfig-1000-20261111    gcc-13.5.0
csky                  randconfig-1001-20261110    gcc-12.5.0
csky                  randconfig-1001-20261111    gcc-13.5.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261110    clang-17
hexagon               randconfig-1000-20261111    clang-17
hexagon               randconfig-1001-20261110    clang-17
hexagon               randconfig-1001-20261111    clang-17
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261110    clang-22
i386        buildonly-randconfig-1000-20261111    clang-22
i386        buildonly-randconfig-1001-20261110    clang-22
i386        buildonly-randconfig-1001-20261111    clang-22
i386        buildonly-randconfig-1002-20261110    clang-22
i386        buildonly-randconfig-1002-20261111    clang-22
i386        buildonly-randconfig-1003-20261110    clang-22
i386        buildonly-randconfig-1003-20261111    clang-22
i386        buildonly-randconfig-1004-20261110    clang-22
i386        buildonly-randconfig-1004-20261111    clang-22
i386        buildonly-randconfig-1005-20261110    clang-22
i386        buildonly-randconfig-1005-20261111    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261110    gcc-14
i386                  randconfig-1000-20261111    gcc-13
i386                  randconfig-1001-20261110    gcc-14
i386                  randconfig-1001-20261111    gcc-13
i386                  randconfig-1002-20261110    gcc-14
i386                  randconfig-1002-20261111    gcc-13
i386                  randconfig-1003-20261110    gcc-14
i386                  randconfig-1003-20261111    gcc-13
i386                  randconfig-1004-20261110    gcc-14
i386                  randconfig-1004-20261111    gcc-13
i386                  randconfig-1005-20261110    gcc-14
i386                  randconfig-1005-20261111    gcc-13
i386                  randconfig-1006-20261110    gcc-14
i386                  randconfig-1006-20261111    gcc-13
i386                  randconfig-1007-20261110    clang-22
i386                  randconfig-1007-20261111    clang-22
i386                  randconfig-1008-20261110    clang-22
i386                  randconfig-1008-20261111    clang-22
i386                  randconfig-1009-20261110    clang-22
i386                  randconfig-1009-20261111    clang-22
i386                  randconfig-1010-20261110    clang-22
i386                  randconfig-1010-20261111    clang-22
i386                  randconfig-1011-20261110    clang-22
i386                  randconfig-1011-20261111    clang-22
i386                  randconfig-1012-20261110    clang-22
i386                  randconfig-1012-20261111    clang-22
i386                  randconfig-1013-20261110    clang-22
i386                  randconfig-1013-20261111    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson32_defconfig    gcc-16.2.0
loongarch             randconfig-1000-20261110    clang-17
loongarch             randconfig-1000-20261111    clang-17
loongarch             randconfig-1001-20261110    clang-17
loongarch             randconfig-1001-20261111    clang-17
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.2.0
m68k                           atari_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                        bmips_be_defconfig    gcc-16.2.0
mips                      cu1830-neo_defconfig    gcc-16.2.0
mips                      decstation_defconfig    gcc-16.2.0
mips                            ip22_defconfig    gcc-16.2.0
mips                      loongson2k_defconfig    gcc-16.2.0
mips                         maltaup_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261110    clang-17
nios2                 randconfig-1000-20261111    clang-17
nios2                 randconfig-1001-20261110    clang-17
nios2                 randconfig-1001-20261111    clang-17
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            alldefconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261110    gcc-14.4.0
parisc                randconfig-1000-20261111    gcc-15.3.0
parisc                randconfig-1001-20261110    gcc-14.4.0
parisc                randconfig-1001-20261111    gcc-15.3.0
parisc64                          alldefconfig    gcc-16.2.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       arches_defconfig    gcc-16.2.0
powerpc                        eiger_defconfig    gcc-16.2.0
powerpc                         icon_defconfig    gcc-16.2.0
powerpc                   iss476-smp_defconfig    gcc-16.2.0
powerpc                    microwatt_defconfig    gcc-16.2.0
powerpc                      mpc83xx_defconfig    gcc-16.2.0
powerpc                        ppc64_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261110    gcc-14.4.0
powerpc               randconfig-1000-20261111    gcc-15.3.0
powerpc               randconfig-1001-20261110    gcc-14.4.0
powerpc               randconfig-1001-20261111    gcc-15.3.0
powerpc                      tqm8555_defconfig    gcc-16.2.0
powerpc64                         alldefconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261110    gcc-14.4.0
powerpc64             randconfig-1000-20261111    gcc-15.3.0
powerpc64             randconfig-1001-20261110    gcc-14.4.0
powerpc64             randconfig-1001-20261111    gcc-15.3.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261110    clang-24
riscv                 randconfig-1000-20261111    clang-17
riscv                 randconfig-1001-20261110    clang-24
riscv                 randconfig-1001-20261111    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261110    clang-24
s390                  randconfig-1000-20261111    clang-17
s390                  randconfig-1001-20261110    clang-24
s390                  randconfig-1001-20261111    clang-17
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                         apsh4ad0a_defconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                 ecovec24-romimage_defconfig    gcc-16.2.0
sh                  kfr2r09-romimage_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261110    clang-24
sh                    randconfig-1000-20261111    clang-17
sh                    randconfig-1001-20261110    clang-24
sh                    randconfig-1001-20261111    clang-17
sh                            se7722_defconfig    gcc-16.2.0
sh                            se7751_defconfig    gcc-16.2.0
sh                    secureedge5410_defconfig    gcc-16.2.0
sh                   sh7785lcr_32bit_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261110    gcc-12.5.0
sparc                 randconfig-1000-20261111    gcc-16.2.0
sparc                 randconfig-1001-20261110    gcc-12.5.0
sparc                 randconfig-1001-20261111    gcc-16.2.0
sparc                        sparc32_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261110    gcc-12.5.0
sparc64               randconfig-1000-20261111    gcc-16.2.0
sparc64               randconfig-1001-20261110    gcc-12.5.0
sparc64               randconfig-1001-20261111    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261110    gcc-12.5.0
um                    randconfig-1000-20261111    gcc-16.2.0
um                    randconfig-1001-20261110    gcc-12.5.0
um                    randconfig-1001-20261111    gcc-16.2.0
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261110    gcc-14
x86_64      buildonly-randconfig-1000-20261111    gcc-14
x86_64      buildonly-randconfig-1001-20261110    gcc-14
x86_64      buildonly-randconfig-1001-20261111    gcc-14
x86_64      buildonly-randconfig-1002-20261110    gcc-14
x86_64      buildonly-randconfig-1002-20261111    gcc-14
x86_64      buildonly-randconfig-1003-20261110    gcc-14
x86_64      buildonly-randconfig-1003-20261111    gcc-14
x86_64      buildonly-randconfig-1004-20261110    gcc-14
x86_64      buildonly-randconfig-1004-20261111    gcc-14
x86_64      buildonly-randconfig-1005-20261110    gcc-14
x86_64      buildonly-randconfig-1005-20261111    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261110    gcc-14
x86_64                randconfig-1000-20261111    clang-22
x86_64                randconfig-1001-20261110    gcc-14
x86_64                randconfig-1001-20261111    clang-22
x86_64                randconfig-1002-20261110    gcc-14
x86_64                randconfig-1002-20261111    clang-22
x86_64                randconfig-1003-20261110    gcc-14
x86_64                randconfig-1003-20261111    clang-22
x86_64                randconfig-1004-20261110    gcc-14
x86_64                randconfig-1004-20261111    clang-22
x86_64                randconfig-1005-20261110    gcc-14
x86_64                randconfig-1005-20261111    clang-22
x86_64                randconfig-1006-20261110    gcc-14
x86_64                randconfig-1006-20261111    clang-22
x86_64                randconfig-1007-20261110    gcc-14
x86_64                randconfig-1007-20261111    clang-22
x86_64                randconfig-1008-20261110    gcc-14
x86_64                randconfig-1008-20261111    clang-22
x86_64                randconfig-1009-20261110    gcc-14
x86_64                randconfig-1009-20261111    clang-22
x86_64                randconfig-1010-20261110    gcc-14
x86_64                randconfig-1010-20261111    clang-22
x86_64                randconfig-1011-20261110    gcc-14
x86_64                randconfig-1011-20261111    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261110    gcc-12.5.0
xtensa                randconfig-1000-20261111    gcc-16.2.0
xtensa                randconfig-1001-20261110    gcc-12.5.0
xtensa                randconfig-1001-20261111    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

