Return-Path: <linuxppc-dev+bounces-28578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFDACA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:48:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvybp1HqQz2y24;
	Thu, 01 Oct 2026 00:48:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790779734;
	cv=none; b=Ore+ut8eybv3OXKyhBuMATgN8bK010lT8EereSm0p0HxSlfLbxGMi29w3tx9WhjaTZf97C9QNhvcZh6/svKEIW6MR/nyK6mUdm8vxlTi+5XE4G+L3s1CE8Vc/auqY2cNfCba2tb9PaLbkGX3rYKvAlBJa3wuNvl3t6LqVDhPBm3l6X0if4o6NK6gMglzM9jwMxIoVu3YBUzhIVdiGQpJpYWJhc1NiTkQP7nVKOllUH0SK8hoR16B8yjUjoR7HrMrl/dCWHN7Ul5+TlqxLJlcRB4FLtXNtTdDfbtHXpqQw3Zavx/sVpFTDs/NVtaUmVv0yl01237rge4XBw3du+Jzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790779734; c=relaxed/relaxed;
	bh=a2aGC4dO3V5QF/+P7LMJ1VoazXD4n9yf6+zkVL6qLZA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AC/qrmEg/m0AAB9ErEuj5iuP+1Iz0ukMZqdAuDfUP31Yk48MgzhkNmEwu+KlKS2fzOj1qyBQrJ84+2iNaWad9xaVqbSh/CYuvR8SDc1yCGVAlhIN/mJKpnfsww6lLdiJZmvDnivrNWs6OJHo5zSJWKuK7QiFicq5V/MdjHWcxAVDBlAgriTp91apXwucCfsOlM6NpiwkhTDLanE7YstgvlWNn1HxNRQpWP+WXVa95/p1zV1kHa382wFpJP4Xl0D0Sq/1vcmqOeFXt6r4NPJFP09b4wwkzjc8+ZL/vgNQj6ekqsDIgDrDUhsdEyatb53N1/X75re2+PXWzcLs2+Z3Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hA6zluht; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hA6zluht;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvybm49vlz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:48:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790779733; x=1822315733;
  h=date:from:to:cc:subject:message-id;
  bh=aSy++a9RcbVgq5irPJ/xMl29hoolAX3gELM2R8Trki4=;
  b=hA6zluhtIj7837CFYWHzSbFOxLSqw4cluonHXuO0B2zYOP/rvHg5V2gc
   inhrBrAlFo/BiNJ1MTcLdf7Hw6YMvl+eg7nVz0N+bw+gAF01RD2FZ1mx/
   6xPh2No3PiyWInDTl6u1LR/YaUJw5glIbTv5FVwxBgtPVuk1hMVMEUPzj
   DC/uG4pNYzxzZiWbKFEEDU3mr3oNF5UkfoPklJpKmhme2oTCrdZHH8BG8
   6JjmpVky0g9zoTKof1qlwHqWjHAykXrynQ/SkQ0/yFYKlvICfcQ+8hTj5
   lToLfIFhOKfL1st/gkDkVIgJXGsQo1/nmzyqQHF5DqxOFbrnCKeBiKZPi
   w==;
X-CSE-ConnectionGUID: LbFa9INLQriCNvkJT7tR3g==
X-CSE-MsgGUID: v5lmXGdgQF6ZEpfbAIiWww==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="113308264"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="113308264"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:48:50 -0700
X-CSE-ConnectionGUID: 97ZYoh2bQaqcRI1fXfj+Vw==
X-CSE-MsgGUID: XtvlGlImR+GthiWUemIpag==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 30 Sep 2026 07:48:48 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xBvbx-00000000Qkj-3HHf;
	Wed, 30 Sep 2026 14:48:45 +0000
Date: Wed, 30 Sep 2026 22:48:02 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD REGRESSION
 0b8b0c17a8998709ecb2852d56442ea981102941
Message-ID: <202609302258.0BXdfGnE-lkp@intel.com>
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
branch HEAD: 0b8b0c17a8998709ecb2852d56442ea981102941  powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202609300040.mopAJGuz-lkp@intel.com

    arch/powerpc/kernel/irq.c:116:(.text+0x49f8): undefined reference to `irq_proc_emit_counts'

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc64-randconfig-r2100-20260929
    `-- arch-powerpc-kernel-irq.c:(.text):undefined-reference-to-irq_proc_emit_counts

elapsed time: 1033m

configs tested: 266
configs skipped: 3

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2107-20260930    gcc-8.5.0  cocci
alpha                randconfig-r2300-20260929    gcc-12.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                  randconfig-r2101-20260930    gcc-16.1.0 cocci
arc                  randconfig-r2301-20260930    clang-24   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             dove_defconfig    gcc-16.1.0
arm                       integrator_defconfig    clang-24
arm                             mmp2_defconfig    gcc-16.1.0
arm                         mvebu_v5_defconfig    gcc-16.1.0
arm                             qcom_defconfig    clang-24
arm                   randconfig-1000-20260930    gcc-11.5.0
arm                   randconfig-1001-20260930    gcc-11.5.0
arm                   randconfig-1002-20260930    gcc-11.5.0
arm                   randconfig-1003-20260930    gcc-11.5.0
arm                  randconfig-r2106-20260930    clang-21   cocci
arm                  randconfig-r2304-20260929    gcc-15.2.0 sparse
arm                            sama5_defconfig    gcc-16.1.0
arm                         spear6xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260930    gcc-16.1.0
arm64                 randconfig-1001-20260930    gcc-16.1.0
arm64                 randconfig-1002-20260930    gcc-16.1.0
arm64                 randconfig-1003-20260930    gcc-16.1.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260930    gcc-16.1.0
csky                  randconfig-1001-20260930    gcc-16.1.0
csky                 randconfig-r2306-20260929    gcc-13.4.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260930    clang-24
hexagon               randconfig-1001-20260930    clang-24
hexagon              randconfig-r2103-20260930    gcc-16.1.0 cocci
hexagon              randconfig-r2309-20260929    clang-17   sparse
i386                              alldefconfig    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260930    gcc-14
i386        buildonly-randconfig-1001-20260930    gcc-14
i386        buildonly-randconfig-1002-20260930    gcc-14
i386        buildonly-randconfig-1003-20260930    gcc-14
i386        buildonly-randconfig-1004-20260930    gcc-14
i386        buildonly-randconfig-1005-20260930    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260930    gcc-14
i386                  randconfig-1001-20260930    gcc-14
i386                  randconfig-1002-20260930    gcc-14
i386                  randconfig-1003-20260930    gcc-14
i386                  randconfig-1004-20260930    gcc-14
i386                  randconfig-1005-20260930    gcc-14
i386                  randconfig-1006-20260930    gcc-14
i386                  randconfig-1007-20260930    clang-22
i386                  randconfig-1008-20260930    clang-22
i386                  randconfig-1009-20260930    clang-22
i386                  randconfig-1010-20260930    clang-22
i386                  randconfig-1011-20260930    clang-22
i386                  randconfig-1012-20260930    clang-22
i386                  randconfig-1013-20260930    clang-22
i386                  randconfig-2200-20260930    gcc-14     smatch
i386                  randconfig-2300-20260930    gcc-13     sparse
i386                  randconfig-2301-20260930    gcc-13     sparse
i386                  randconfig-2302-20260930    gcc-13     sparse
i386                 randconfig-r2102-20260930    gcc-16.1.0 cocci
i386                 randconfig-r2202-20260930    gcc-13     smatch
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260930    clang-24
loongarch             randconfig-1001-20260930    clang-24
loongarch            randconfig-r2302-20260929    gcc-13.4.0 sparse
loongarch            randconfig-r2303-20260929    gcc-16.1.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    clang-24
m68k                           atari_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5475evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2106-20260930    gcc-8.5.0  cocci
m68k                 randconfig-r2300-20260930    clang-24   sparse
m68k                 randconfig-r2307-20260930    gcc-12.5.0 sparse
m68k                 randconfig-r2308-20260929    gcc-8.5.0  sparse
m68k                            virt_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2200-20260930    gcc-11.5.0 smatch
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                          bigsur_defconfig    gcc-16.1.0
mips                      loongson2k_defconfig    gcc-16.1.0
mips                           malta_defconfig    clang-24
mips                       maltasmvp_defconfig    gcc-16.1.0
mips                         qi_lb60_defconfig    clang-24
mips                         qi_lb60_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260930    clang-24
nios2                 randconfig-1001-20260930    clang-24
nios2                randconfig-r2200-20260930    gcc-10.5.0 smatch
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20260930    gcc-16.1.0 cocci
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260930    gcc-8.5.0
parisc                randconfig-1001-20260930    gcc-8.5.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.1.0
powerpc                         fsp2_defconfig    gcc-16.1.0
powerpc                       ppc64e_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc              randconfig-r2105-20260930    clang-21   cocci
powerpc              randconfig-r2201-20260930    gcc-14.3.0 smatch
powerpc              randconfig-r2302-20260930    clang-24   sparse
powerpc              randconfig-r2306-20260930    gcc-12.5.0 sparse
powerpc                      sequoia_defconfig    gcc-16.1.0
powerpc                      tqm8548_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260930    gcc-8.5.0
powerpc64             randconfig-1001-20260930    gcc-8.5.0
powerpc64            randconfig-r2107-20260930    clang-21   cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                     nommu_k210_defconfig    clang-24
riscv                     nommu_k210_defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260930    gcc-16.1.0
riscv                 randconfig-1001-20260930    gcc-16.1.0
riscv                 randconfig-2000-20260929    gcc-11.5.0
riscv                 randconfig-2000-20260930    gcc-14.3.0
riscv                 randconfig-2001-20260929    gcc-9.5.0
riscv                 randconfig-2001-20260930    gcc-14.3.0
riscv                randconfig-r2307-20260929    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260930    gcc-16.1.0
s390                  randconfig-1001-20260930    gcc-16.1.0
s390                  randconfig-2000-20260929    clang-24
s390                  randconfig-2000-20260930    gcc-14.3.0
s390                  randconfig-2001-20260929    gcc-8.5.0
s390                  randconfig-2001-20260930    gcc-14.3.0
s390                 randconfig-r2104-20260930    gcc-8.5.0  cocci
s390                 randconfig-r2304-20260930    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         edosk7760_defconfig    clang-24
sh                              espt_defconfig    gcc-16.1.0
sh                             hp6xx_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260930    gcc-16.1.0
sh                    randconfig-1001-20260930    gcc-16.1.0
sh                    randconfig-2000-20260929    gcc-14.3.0
sh                    randconfig-2000-20260930    gcc-14.3.0
sh                    randconfig-2001-20260929    gcc-16.1.0
sh                    randconfig-2001-20260930    gcc-14.3.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260930    clang-22
sparc                 randconfig-1001-20260930    clang-22
sparc                 randconfig-2000-20260930    gcc-10.5.0
sparc                 randconfig-2001-20260930    gcc-10.5.0
sparc                randconfig-r2308-20260930    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260930    clang-22
sparc64               randconfig-1001-20260930    clang-22
sparc64               randconfig-2000-20260930    gcc-10.5.0
sparc64               randconfig-2001-20260930    gcc-10.5.0
sparc64              randconfig-r2104-20260930    clang-21   cocci
sparc64              randconfig-r2303-20260930    clang-24   sparse
sparc64              randconfig-r2305-20260930    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260930    clang-22
um                    randconfig-1001-20260930    clang-22
um                    randconfig-2000-20260930    gcc-10.5.0
um                    randconfig-2001-20260930    gcc-10.5.0
um                   randconfig-r2105-20260930    gcc-8.5.0  cocci
um                   randconfig-r2201-20260930    clang-17   smatch
um                   randconfig-r2309-20260930    gcc-12.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260930    clang-22
x86_64      buildonly-randconfig-1001-20260930    clang-22
x86_64      buildonly-randconfig-1002-20260930    clang-22
x86_64      buildonly-randconfig-1003-20260930    clang-22
x86_64      buildonly-randconfig-1004-20260930    clang-22
x86_64      buildonly-randconfig-1005-20260930    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260930    gcc-14
x86_64                randconfig-1001-20260930    gcc-14
x86_64                randconfig-1002-20260930    gcc-14
x86_64                randconfig-1003-20260930    gcc-14
x86_64                randconfig-1004-20260930    gcc-14
x86_64                randconfig-1005-20260930    gcc-14
x86_64                randconfig-1006-20260930    gcc-14
x86_64                randconfig-1007-20260930    gcc-14
x86_64                randconfig-1008-20260930    gcc-14
x86_64                randconfig-1009-20260930    gcc-14
x86_64                randconfig-1010-20260930    gcc-14
x86_64                randconfig-1011-20260930    gcc-14
x86_64                randconfig-1012-20260930    clang-22
x86_64                randconfig-1013-20260930    clang-22
x86_64                randconfig-1014-20260930    clang-22
x86_64                randconfig-1015-20260930    clang-22
x86_64                randconfig-1016-20260930    clang-22
x86_64                randconfig-1017-20260930    clang-22
x86_64                randconfig-2200-20260930    gcc-14     smatch
x86_64                randconfig-2300-20260930    gcc-13     sparse
x86_64                randconfig-2301-20260930    gcc-13     sparse
x86_64                randconfig-2302-20260930    gcc-13     sparse
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
xtensa                randconfig-1000-20260930    clang-22
xtensa                randconfig-1001-20260930    clang-22
xtensa                randconfig-2000-20260930    gcc-10.5.0
xtensa                randconfig-2001-20260930    gcc-10.5.0
xtensa               randconfig-r2301-20260929    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

