Return-Path: <linuxppc-dev+bounces-28989-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1CBCA5FFF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:25:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j08QS1fjtz30CZ;
	Wed, 07 Oct 2026 21:25:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791368720;
	cv=none; b=jxqnjwLBKx0ldgjADstVIid6P9vR05RAfbJ0uG6B2MCZh9LCqVe0j0EH24A88AT2N2XO1B6NlggLBcaoUO5g3Cx8br8PBlhe3JGL4sUx+h5VvNini6stl9Zs6Xxy9Op/lmy+H8bPxSofk2WlzLGbP9Q9VohlHWh8Cqv+my67Vq/ySebhQsq/NgzaIv0AVp04MTJp2lT/HnAJl+sGUIooqvuc2uG5j+Lws5tE/APsjsMuxVPlCHWNdg5khccKkCRuDo1dbV5muEcP3N2EAV37c4u+cHfIu6WgQC25AfIAba9FvK8WE3qaWdYn+01zB+3/avPeSmuZcbl5oV6ekd2d5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791368720; c=relaxed/relaxed;
	bh=L/RnNB2aePTaqvStmg3MJ6CF2I6e4p1D600TSBrG2uQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dDI2KdbmkvfpzAcBaMeQ563xAp96KK8K0gBN8rKmI6DM7oWhPlRjJDQ8ygh9v37rH6xs6lsdoHGDmicdnYOyiBnXq2ezEz2T33x6agK5QunKnSJXbIp8IOYXwYTDeqFGMBlzKJDZE+ZIM6bXXGP8SceJ5DsADedpd9vnTdz/1h6/1ynT+to0URNhqdu1N/mJS+RK9jafoK0t3vo1RjwIglAdSv+26c/YEHea2zScvlw5gFZ2Lfp9n9QB0IqSG7KcjtnbfVd0Bj/BY198YfK/zxfXkitAZLZhzA3fl/t1gytXTijwvUik33upapuSfffHbLAwZlkDm2tUXh+uSKLbRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IOEA5ulE; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IOEA5ulE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j08QP3yGgz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 21:25:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791368717; x=1822904717;
  h=date:from:to:cc:subject:message-id;
  bh=M5nNzJr5gRey3Yfe749IA4I8Ka4PJdRHY3qZkVQwUAQ=;
  b=IOEA5ulENGXd23ml13n5U3ad0O7K1YJ655NTIRy5LDNw5zKvnECcS8Fh
   uXFfg2rcCQ1jinIru29XDcyQWPprxnvFNQ0kSmttjpgCAnFH+T/n7qRRB
   RSWO3c9b2Q2uipgWWFK9t000q82DOFZBGlgik18Sw+cd5rZXY+XfNfv6Y
   J4ptvy0WgscR486QMFX8+3BP/JBEZy1RPY+yDkCkKmLOUBOjJ2gx7GBqL
   LS0UYQfHk7Sr2H4mh/GbavgNxQNkRSzSJduQ1WflwxCoRUEhLmCCrA8Bv
   fUsMkjGAfTVgPuU0g7gWhexpyD/ORw/JmSWyEBT+3RSNEARWY+U/jPEK9
   A==;
X-CSE-ConnectionGUID: rYpT5Z9yTBiYE5g1v1xiIg==
X-CSE-MsgGUID: GedlHmKPTuuwBqxzmRzAcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="20483"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="20483"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 03:25:12 -0700
X-CSE-ConnectionGUID: Jz2GXDJhQiC0xE7nXR2ECw==
X-CSE-MsgGUID: B0dZK7zWScqS+fKwh/jYfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1521582"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 07 Oct 2026 03:25:11 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEOpg-000000002oV-2rkY;
	Wed, 07 Oct 2026 10:25:08 +0000
Date: Wed, 07 Oct 2026 18:24:42 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 f77e26926610c4e49e41aeb5edca70abd2a81e1e
Message-ID: <202610071838.W5IqlkGY-lkp@intel.com>
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
branch HEAD: f77e26926610c4e49e41aeb5edca70abd2a81e1e  Automatic merge of 'next' into merge (2026-10-06 16:55)

elapsed time: 1276m

configs tested: 313
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2101-20261006    gcc-9.5.0  cocci
alpha                randconfig-r2104-20261007    gcc-10.5.0 cocci
alpha                randconfig-r2107-20261006    clang-24   cocci
alpha                randconfig-r2200-20261006    gcc-14.3.0 smatch
alpha                randconfig-r2201-20261006    gcc-8.5.0  smatch
alpha                randconfig-r2303-20261006    gcc-8.5.0  sparse
alpha                randconfig-r2307-20261006    clang-19   sparse
alpha                randconfig-r2308-20261006    clang-19   sparse
alpha                randconfig-r2309-20261006    clang-24   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261007    clang-24
arc                   randconfig-1001-20261007    clang-24
arc                  randconfig-r2102-20261007    gcc-10.5.0 cocci
arc                  randconfig-r2105-20261006    gcc-14.3.0 cocci
arc                  randconfig-r2106-20261006    clang-24   cocci
arc                  randconfig-r2200-20261006    gcc-13.4.0 smatch
arc                  randconfig-r2201-20261006    gcc-11.5.0 smatch
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                      davinci_all_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                           pxa168_defconfig    gcc-16.1.0
arm                           pxa3xx_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261007    clang-24
arm                   randconfig-1001-20261007    clang-24
arm                   randconfig-1002-20261007    clang-24
arm                   randconfig-1003-20261007    clang-24
arm                  randconfig-r2103-20261006    clang-24   cocci
arm                  randconfig-r2305-20261006    gcc-8.5.0  sparse
arm                          wpcm450_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261007    gcc-13.4.0
arm64                 randconfig-1001-20261007    gcc-13.4.0
arm64                 randconfig-1002-20261007    gcc-13.4.0
arm64                 randconfig-1003-20261007    gcc-13.4.0
arm64                randconfig-r2100-20261007    gcc-10.5.0 cocci
arm64                randconfig-r2104-20261006    gcc-14.3.0 cocci
arm64                randconfig-r2105-20261006    clang-24   cocci
arm64                randconfig-r2300-20261006    gcc-8.5.0  sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261007    gcc-13.4.0
csky                  randconfig-1001-20261007    gcc-13.4.0
csky                 randconfig-r2101-20261006    gcc-16.1.0 cocci
csky                 randconfig-r2103-20261006    gcc-16.1.0 cocci
csky                 randconfig-r2200-20261006    gcc-15.2.0 smatch
csky                 randconfig-r2201-20261007    gcc-16.1.0 smatch
csky                 randconfig-r2300-20261006    gcc-15.2.0 sparse
csky                 randconfig-r2304-20261006    gcc-8.5.0  sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261007    gcc-12.5.0
hexagon               randconfig-1001-20261007    gcc-12.5.0
hexagon              randconfig-r2301-20261006    gcc-8.5.0  sparse
hexagon              randconfig-r2307-20261006    gcc-10.5.0 sparse
hexagon              randconfig-r2308-20261006    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261007    gcc-14
i386        buildonly-randconfig-1001-20261007    gcc-14
i386        buildonly-randconfig-1002-20261007    gcc-14
i386        buildonly-randconfig-1003-20261007    gcc-14
i386        buildonly-randconfig-1004-20261007    gcc-14
i386        buildonly-randconfig-1005-20261007    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261007    clang-22
i386                  randconfig-1001-20261007    clang-22
i386                  randconfig-1002-20261007    clang-22
i386                  randconfig-1003-20261007    clang-22
i386                  randconfig-1004-20261007    clang-22
i386                  randconfig-1005-20261007    clang-22
i386                  randconfig-1006-20261007    clang-22
i386                  randconfig-1007-20261007    gcc-14
i386                  randconfig-1008-20261007    gcc-14
i386                  randconfig-1009-20261007    gcc-14
i386                  randconfig-1010-20261007    gcc-14
i386                  randconfig-1011-20261007    gcc-14
i386                  randconfig-1012-20261007    gcc-14
i386                  randconfig-1013-20261007    gcc-14
i386                  randconfig-2100-20261006    clang-22   cocci
i386                  randconfig-2101-20261006    clang-22   cocci
i386                  randconfig-2102-20261006    clang-22   cocci
i386                  randconfig-2103-20261006    clang-22   cocci
i386                  randconfig-2200-20261006    gcc-13     smatch
i386                  randconfig-2200-20261007    gcc-14     smatch
i386                  randconfig-2300-20261006    gcc-14     sparse
i386                  randconfig-2301-20261006    gcc-14     sparse
i386                  randconfig-2302-20261006    gcc-14     sparse
i386                 randconfig-r2101-20261006    clang-24   cocci
i386                 randconfig-r2105-20261006    gcc-16.1.0 cocci
i386                 randconfig-r2202-20261006    gcc-14     smatch
i386                 randconfig-r2300-20261006    gcc-14     sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261007    gcc-12.5.0
loongarch             randconfig-1001-20261007    gcc-12.5.0
loongarch            randconfig-r2106-20261006    gcc-8.5.0  cocci
loongarch            randconfig-r2200-20261006    clang-18   smatch
loongarch            randconfig-r2201-20261006    gcc-13.4.0 smatch
loongarch            randconfig-r2308-20261006    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2101-20261006    gcc-10.5.0 cocci
m68k                 randconfig-r2103-20261006    gcc-9.5.0  cocci
m68k                 randconfig-r2106-20261007    gcc-10.5.0 cocci
m68k                 randconfig-r2302-20261006    gcc-14     sparse
m68k                 randconfig-r2304-20261006    gcc-15.2.0 sparse
m68k                 randconfig-r2305-20261006    gcc-15.2.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2104-20261006    gcc-11.5.0 cocci
microblaze           randconfig-r2303-20261006    gcc-15.2.0 sparse
microblaze           randconfig-r2306-20261006    clang-24   sparse
microblaze           randconfig-r2307-20261006    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           ath79_defconfig    gcc-16.1.0
mips                 randconfig-r2202-20261006    gcc-13.4.0 smatch
mips                 randconfig-r2301-20261006    gcc-14     sparse
mips                 randconfig-r2303-20261006    gcc-8.5.0  sparse
mips                 randconfig-r2309-20261006    clang-20   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261007    gcc-12.5.0
nios2                 randconfig-1001-20261007    gcc-12.5.0
nios2                randconfig-r2100-20261006    gcc-10.5.0 cocci
nios2                randconfig-r2102-20261006    gcc-10.5.0 cocci
nios2                randconfig-r2105-20261007    gcc-10.5.0 cocci
nios2                randconfig-r2106-20261006    gcc-14.3.0 cocci
nios2                randconfig-r2107-20261006    gcc-11.5.0 cocci
nios2                randconfig-r2202-20261006    gcc-8.5.0  smatch
nios2                randconfig-r2305-20261006    gcc-8.5.0  sparse
nios2                randconfig-r2306-20261006    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20261007    gcc-10.5.0 cocci
openrisc             randconfig-r2103-20261006    gcc-10.5.0 cocci
openrisc             randconfig-r2104-20261006    gcc-8.5.0  cocci
openrisc             randconfig-r2200-20261007    gcc-12.5.0 smatch
openrisc             randconfig-r2309-20261006    gcc-10.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261007    gcc-15.2.0
parisc                randconfig-1001-20261007    gcc-15.2.0
parisc               randconfig-r2201-20261006    gcc-8.5.0  smatch
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                         icon_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261007    gcc-15.2.0
powerpc               randconfig-1001-20261007    gcc-15.2.0
powerpc              randconfig-r2102-20261006    gcc-16.1.0 cocci
powerpc              randconfig-r2104-20261006    gcc-16.1.0 cocci
powerpc              randconfig-r2107-20261006    gcc-16.1.0 cocci
powerpc              randconfig-r2302-20261006    gcc-15.2.0 sparse
powerpc64             randconfig-1000-20261007    gcc-15.2.0
powerpc64             randconfig-1001-20261007    gcc-15.2.0
powerpc64            randconfig-r2102-20261006    clang-24   cocci
powerpc64            randconfig-r2102-20261006    gcc-9.5.0  cocci
powerpc64            randconfig-r2103-20261007    gcc-10.5.0 cocci
powerpc64            randconfig-r2104-20261006    clang-24   cocci
powerpc64            randconfig-r2301-20261006    gcc-15.2.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261007    clang-24
riscv                 randconfig-1001-20261007    clang-24
riscv                 randconfig-2000-20261006    gcc-16.1.0
riscv                 randconfig-2001-20261006    gcc-16.1.0
riscv                randconfig-r2105-20261006    gcc-8.5.0  cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261007    clang-24
s390                  randconfig-1001-20261007    clang-24
s390                  randconfig-2000-20261006    gcc-16.1.0
s390                  randconfig-2001-20261006    gcc-16.1.0
s390                 randconfig-r2306-20261006    clang-19   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261007    clang-24
sh                    randconfig-1001-20261007    clang-24
sh                    randconfig-2000-20261006    gcc-16.1.0
sh                    randconfig-2001-20261006    gcc-16.1.0
sh                   randconfig-r2107-20261006    gcc-14.3.0 cocci
sh                   randconfig-r2302-20261006    gcc-8.5.0  sparse
sh                   randconfig-r2304-20261006    gcc-8.5.0  sparse
sh                   randconfig-r2308-20261006    clang-20   sparse
sh                    secureedge5410_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261007    clang-17
sparc                 randconfig-1001-20261007    clang-17
sparc                 randconfig-2000-20261006    clang-24
sparc                 randconfig-2001-20261006    clang-24
sparc                randconfig-r2100-20261006    clang-24   cocci
sparc                randconfig-r2201-20261006    gcc-16.1.0 smatch
sparc                randconfig-r2300-20261006    gcc-8.5.0  sparse
sparc                randconfig-r2304-20261006    gcc-14     sparse
sparc                randconfig-r2306-20261006    clang-20   sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261007    clang-17
sparc64               randconfig-1001-20261007    clang-17
sparc64               randconfig-2000-20261006    clang-24
sparc64               randconfig-2001-20261006    clang-24
sparc64              randconfig-r2100-20261006    gcc-9.5.0  cocci
sparc64              randconfig-r2106-20261006    gcc-11.5.0 cocci
sparc64              randconfig-r2308-20261006    gcc-10.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261007    clang-17
um                    randconfig-1001-20261007    clang-17
um                    randconfig-2000-20261006    clang-24
um                    randconfig-2001-20261006    clang-24
um                   randconfig-r2105-20261006    gcc-11.5.0 cocci
um                   randconfig-r2107-20261006    gcc-8.5.0  cocci
um                   randconfig-r2202-20261006    clang-24   smatch
um                   randconfig-r2202-20261007    clang-24   smatch
um                   randconfig-r2302-20261006    gcc-8.5.0  sparse
um                   randconfig-r2303-20261006    gcc-14     sparse
um                   randconfig-r2305-20261006    gcc-14     sparse
um                   randconfig-r2309-20261006    clang-19   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261007    gcc-14
x86_64      buildonly-randconfig-1001-20261007    gcc-14
x86_64      buildonly-randconfig-1002-20261007    gcc-14
x86_64      buildonly-randconfig-1003-20261007    gcc-14
x86_64      buildonly-randconfig-1004-20261007    gcc-14
x86_64      buildonly-randconfig-1005-20261007    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261007    clang-22
x86_64                randconfig-1001-20261007    clang-22
x86_64                randconfig-1002-20261007    clang-22
x86_64                randconfig-1003-20261007    clang-22
x86_64                randconfig-1004-20261007    clang-22
x86_64                randconfig-1005-20261007    clang-22
x86_64                randconfig-1012-20261007    gcc-12
x86_64                randconfig-1013-20261007    gcc-12
x86_64                randconfig-1014-20261007    gcc-12
x86_64                randconfig-1015-20261007    gcc-12
x86_64                randconfig-1016-20261007    gcc-12
x86_64                randconfig-1017-20261007    gcc-12
x86_64                randconfig-2100-20261006    clang-22   cocci
x86_64                randconfig-2100-20261007    clang-22   cocci
x86_64                randconfig-2101-20261006    clang-22   cocci
x86_64                randconfig-2101-20261007    clang-22   cocci
x86_64                randconfig-2102-20261006    clang-22   cocci
x86_64                randconfig-2102-20261007    clang-22   cocci
x86_64                randconfig-2103-20261006    clang-22   cocci
x86_64                randconfig-2103-20261007    clang-22   cocci
x86_64                randconfig-2200-20261006    clang-22   smatch
x86_64                randconfig-2300-20261006    gcc-14     sparse
x86_64                randconfig-2301-20261006    gcc-14     sparse
x86_64                randconfig-2302-20261006    gcc-14     sparse
x86_64               randconfig-r2106-20261006    gcc-16.1.0 cocci
x86_64               randconfig-r2107-20261007    gcc-10.5.0 cocci
x86_64               randconfig-r2200-20261006    clang-22   smatch
x86_64               randconfig-r2301-20261006    gcc-8.5.0  sparse
x86_64               randconfig-r2307-20261006    clang-20   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261007    clang-17
xtensa                randconfig-1001-20261007    clang-17
xtensa                randconfig-2000-20261006    clang-24
xtensa                randconfig-2001-20261006    clang-24
xtensa               randconfig-r2100-20261006    gcc-16.1.0 cocci
xtensa               randconfig-r2200-20261006    gcc-9.5.0  smatch
xtensa               randconfig-r2306-20261006    gcc-10.5.0 sparse
xtensa               randconfig-r2307-20261006    clang-24   sparse
xtensa               randconfig-r2309-20261006    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

