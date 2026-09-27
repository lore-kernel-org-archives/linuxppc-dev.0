Return-Path: <linuxppc-dev+bounces-28307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E35C98324
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 07:53:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsxXJ6S6Sz2yPq;
	Sun, 27 Sep 2026 17:53:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790495632;
	cv=none; b=MWa8qyj3A0XBHm80vKDB+PNfD2xIWnlUcQuvu8xW7OMD2stJjVwuMc9G2iOZ4/lFmDu7iTnSVcqfWg0FMAtJZp75mHl7fvxFTrStSiU08FtQRTkibsjkRfiUZI254hSdqRfbDliPEE/LNeWu3qzl3uXSoFXTHAyTz3NQjaGHZWJKJ4TGyZtBSZQzjDKZ3x7tv78x11JJWsmTPBQKm5SZPOw5pkUyXIMRTJ8HmYJeVX+uusCwNzbWhFE+zxBfgJSQ7T5QSK/1NYzBT5sUfDo76dC9vB9c0fe6JKRo6x15prwsbBopxfNjgiXw3nfh0ekGKGYJtYoDGyT9ZFcT0lDqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790495632; c=relaxed/relaxed;
	bh=nnodL+R82Jq22mVFX9Y2+HiP1uIwJc8IaYfOtglJ/kw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Sq9JFGzN3vjD19BususY1o4Qz2DzAyLzTHRSCE/RyGFguq7am+66jqYabQRlhCNoUhbAZS5VzsvfOA2uAPbupZcoE28IlD1u+9PlR9L21MYBjRxOO/QGYB1VM/7ogT9sAejFH7tBoICparWGR1p6q8fX/3ytCJTq970M7aHX1ff+1z8RU8IbEpUeSjdyH6y0CqpFQK0T/ScCXWRgvyVjeM63laTpNz0dtin6RcnNwSWzPIrPBKM8cDgvQga9/2xx8qFuRwo3uJi1m7RZ4MA6/GU5H4gkRniYv7nmwe6keiBcYSjEGrdfA/NNBtXCwKsrjse8frVZK1z+pICXSn1YEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=choweuid; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=choweuid;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsxXF5Dxcz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 17:53:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790495630; x=1822031630;
  h=date:from:to:cc:subject:message-id;
  bh=lsgYT8sxP0z2LnsfK4hQ7fYNwuvdpo/2wr7O3ejd05M=;
  b=choweuidqPezIuKqX2f6cioG2h3FwToRP9fWGZMpf2KcIGnB/G/HYkmB
   D7/YfVgl6kzZ+5V8rHaS5tABVRDum8j9QcLEH2mkCtaK1krcbnWUiDcJV
   DQuZymDc1eZTqFSmpxtkxQbnn5OX9Pk6A+WifZRN03pwu33h5mOUHIZVW
   0P4gZHdkXZyH8gIaiTiXrmtzLbwGO56URbYUJ/qHbzN+nN+8OczxS+ppN
   G3WvSegPsumNw7c+FMeaRRaFyCF+OoqbM7OG7vaaKhTgSBXUowV1AWRwu
   waq/IRg0XDwX8aNrMicRwjit4sluVwhBx4E47irMid9EdUBqXV/WMNP25
   g==;
X-CSE-ConnectionGUID: dX6rmRBbQxOcw7B7GNoNGw==
X-CSE-MsgGUID: y+IUHxP1RTODCxH8KB3tAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11917"; a="90279366"
X-IronPort-AV: E=Sophos;i="6.27,125,1787036400"; 
   d="scan'208";a="90279366"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 00:53:44 -0700
X-CSE-ConnectionGUID: czXWz4fwR3GvSe/mUQb3eA==
X-CSE-MsgGUID: SDWm/n7NS2KcImx5gEDHyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,125,1787036400"; 
   d="scan'208";a="273860945"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2026 00:53:42 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xAjhc-00000000Mf7-12DL;
	Sun, 27 Sep 2026 07:53:40 +0000
Date: Sun, 27 Sep 2026 15:53:25 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD REGRESSION
 12d238d584ba485a99e02e033746100fc7099184
Message-ID: <202609271522.0VqGvTdU-lkp@intel.com>
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
branch HEAD: 12d238d584ba485a99e02e033746100fc7099184  powerpc/sysfs: Remove redundant wait time clamps

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202609271531.8kf2NTjK-lkp@intel.com

    ld.lld: error: undefined symbol: irq_proc_emit_counts

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc64-randconfig-1001-20260927
    `-- ld.lld:error:undefined-symbol:irq_proc_emit_counts

elapsed time: 1456m

configs tested: 255
configs skipped: 2

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260926    clang-24
arc                   randconfig-1000-20260927    gcc-11.5.0
arc                   randconfig-1001-20260926    clang-24
arc                   randconfig-1001-20260927    gcc-11.5.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.1.0
arm                          bcm2835_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                           exynos_defconfig    clang-24
arm                            h3600_defconfig    clang-24
arm                         keystone_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260926    clang-24
arm                   randconfig-1000-20260927    gcc-11.5.0
arm                   randconfig-1001-20260926    clang-24
arm                   randconfig-1001-20260927    gcc-11.5.0
arm                   randconfig-1002-20260926    clang-24
arm                   randconfig-1002-20260927    gcc-11.5.0
arm                   randconfig-1003-20260926    clang-24
arm                   randconfig-1003-20260927    gcc-11.5.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260926    gcc-8.5.0
arm64                 randconfig-1000-20260927    clang-17
arm64                 randconfig-1001-20260926    gcc-8.5.0
arm64                 randconfig-1001-20260927    clang-17
arm64                 randconfig-1002-20260926    gcc-8.5.0
arm64                 randconfig-1002-20260927    clang-17
arm64                 randconfig-1003-20260926    gcc-8.5.0
arm64                 randconfig-1003-20260927    clang-17
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260926    gcc-8.5.0
csky                  randconfig-1000-20260927    clang-17
csky                  randconfig-1001-20260926    gcc-8.5.0
csky                  randconfig-1001-20260927    clang-17
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260926    gcc-10.5.0
hexagon               randconfig-1000-20260927    gcc-11.5.0
hexagon               randconfig-1001-20260926    gcc-10.5.0
hexagon               randconfig-1001-20260927    gcc-11.5.0
i386                              alldefconfig    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260926    gcc-14
i386        buildonly-randconfig-1000-20260927    clang-22
i386        buildonly-randconfig-1001-20260926    gcc-14
i386        buildonly-randconfig-1001-20260927    clang-22
i386        buildonly-randconfig-1002-20260926    gcc-14
i386        buildonly-randconfig-1002-20260927    clang-22
i386        buildonly-randconfig-1003-20260926    gcc-14
i386        buildonly-randconfig-1003-20260927    clang-22
i386        buildonly-randconfig-1004-20260926    gcc-14
i386        buildonly-randconfig-1004-20260927    clang-22
i386        buildonly-randconfig-1005-20260926    gcc-14
i386        buildonly-randconfig-1005-20260927    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260927    clang-22
i386                  randconfig-1001-20260927    clang-22
i386                  randconfig-1002-20260927    clang-22
i386                  randconfig-1003-20260927    clang-22
i386                  randconfig-1004-20260927    clang-22
i386                  randconfig-1005-20260927    clang-22
i386                  randconfig-1006-20260927    clang-22
i386                  randconfig-1007-20260926    gcc-14
i386                  randconfig-1007-20260927    gcc-14
i386                  randconfig-1008-20260926    gcc-14
i386                  randconfig-1008-20260927    gcc-14
i386                  randconfig-1009-20260926    gcc-14
i386                  randconfig-1009-20260927    gcc-14
i386                  randconfig-1010-20260926    gcc-14
i386                  randconfig-1010-20260927    gcc-14
i386                  randconfig-1011-20260926    gcc-14
i386                  randconfig-1011-20260927    gcc-14
i386                  randconfig-1012-20260926    gcc-14
i386                  randconfig-1012-20260927    gcc-14
i386                  randconfig-1013-20260926    gcc-14
i386                  randconfig-1013-20260927    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260926    gcc-10.5.0
loongarch             randconfig-1000-20260927    gcc-11.5.0
loongarch             randconfig-1001-20260926    gcc-10.5.0
loongarch             randconfig-1001-20260927    gcc-11.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                       m54418evb_defconfig    gcc-16.1.0
m68k                            sun3_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                          cobalt_defconfig    gcc-16.1.0
mips                          db1xxx_defconfig    gcc-16.1.0
mips                           eyeq6_defconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
mips                 malta_qemu_32r6_defconfig    gcc-16.1.0
mips                   maltasmvp_eva_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260926    gcc-10.5.0
nios2                 randconfig-1000-20260927    gcc-11.5.0
nios2                 randconfig-1001-20260926    gcc-10.5.0
nios2                 randconfig-1001-20260927    gcc-11.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    gcc-16.1.0
openrisc                     or1ksim_defconfig    gcc-16.1.0
openrisc                  simple_smp_defconfig    clang-24
openrisc                  simple_smp_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260926    clang-24
parisc                randconfig-1000-20260927    clang-24
parisc                randconfig-1001-20260926    clang-24
parisc                randconfig-1001-20260927    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.1.0
powerpc                     ge_imp3a_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260926    clang-24
powerpc               randconfig-1000-20260927    clang-24
powerpc               randconfig-1001-20260926    clang-24
powerpc               randconfig-1001-20260927    clang-24
powerpc                       tqm8xx_defconfig    clang-24
powerpc                          wii_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260926    clang-24
powerpc64             randconfig-1000-20260927    clang-24
powerpc64             randconfig-1001-20260926    clang-24
powerpc64             randconfig-1001-20260927    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260927    gcc-16.1.0
riscv                 randconfig-1001-20260927    gcc-16.1.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260927    gcc-16.1.0
s390                  randconfig-1001-20260927    gcc-16.1.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                           polaris_defconfig    gcc-16.1.0
sh                           r7785rp_defconfig    clang-24
sh                    randconfig-1000-20260927    gcc-16.1.0
sh                    randconfig-1001-20260927    gcc-16.1.0
sh                           rsk7203_defconfig    clang-24
sh                           sdk7780_defconfig    gcc-16.1.0
sh                              sh03_defconfig    gcc-16.1.0
sh                             titan_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260926    gcc-14
sparc                 randconfig-1000-20260927    clang-24
sparc                 randconfig-1001-20260926    gcc-14
sparc                 randconfig-1001-20260927    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260926    gcc-14
sparc64               randconfig-1000-20260927    clang-24
sparc64               randconfig-1001-20260926    gcc-14
sparc64               randconfig-1001-20260927    clang-24
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260926    gcc-14
um                    randconfig-1000-20260927    clang-24
um                    randconfig-1001-20260926    gcc-14
um                    randconfig-1001-20260927    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260927    gcc-14
x86_64      buildonly-randconfig-1001-20260927    gcc-14
x86_64      buildonly-randconfig-1002-20260927    gcc-14
x86_64      buildonly-randconfig-1003-20260927    gcc-14
x86_64      buildonly-randconfig-1004-20260927    gcc-14
x86_64      buildonly-randconfig-1005-20260927    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260926    gcc-14
x86_64                randconfig-1000-20260927    clang-22
x86_64                randconfig-1001-20260926    gcc-14
x86_64                randconfig-1001-20260927    clang-22
x86_64                randconfig-1002-20260926    gcc-14
x86_64                randconfig-1002-20260927    clang-22
x86_64                randconfig-1003-20260926    gcc-14
x86_64                randconfig-1003-20260927    clang-22
x86_64                randconfig-1004-20260926    gcc-14
x86_64                randconfig-1004-20260927    clang-22
x86_64                randconfig-1005-20260926    gcc-14
x86_64                randconfig-1005-20260927    clang-22
x86_64                randconfig-1006-20260926    gcc-14
x86_64                randconfig-1006-20260927    clang-22
x86_64                randconfig-1007-20260926    gcc-14
x86_64                randconfig-1007-20260927    clang-22
x86_64                randconfig-1008-20260926    gcc-14
x86_64                randconfig-1008-20260927    clang-22
x86_64                randconfig-1009-20260926    gcc-14
x86_64                randconfig-1009-20260927    clang-22
x86_64                randconfig-1010-20260926    gcc-14
x86_64                randconfig-1010-20260927    clang-22
x86_64                randconfig-1011-20260926    gcc-14
x86_64                randconfig-1011-20260927    clang-22
x86_64                randconfig-1012-20260927    clang-22
x86_64                randconfig-1013-20260927    clang-22
x86_64                randconfig-1014-20260927    clang-22
x86_64                randconfig-1015-20260927    clang-22
x86_64                randconfig-1016-20260927    clang-22
x86_64                randconfig-1017-20260927    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260926    gcc-14
xtensa                randconfig-1000-20260927    clang-24
xtensa                randconfig-1001-20260926    gcc-14
xtensa                randconfig-1001-20260927    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

