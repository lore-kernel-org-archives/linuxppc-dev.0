Return-Path: <linuxppc-dev+bounces-18979-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB77F3D619
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 17:53:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkMSg4TNCz2ySS;
	Mon, 30 Mar 2026 04:53:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774806835;
	cv=none; b=HhebyniHJ3tQgkHoYxnq+GR/CEO9xWKoBXB0CpoGUPdHV9gJPItgs7QZJt+08mxRdnAu0fTxCfNzjb07oCnhYokJsWWoDJxXizLcpCUQ7uccwGMUpCWd9hB+VH3L7ra67UViTAFGxtHDZQixlHvYdtdS880aQm3pMLaTUnJ2BbZQwX+MYDzBv2RCVsaOLncnLsXRuMkEVbNOZLXQrINWc6KH0pveh+1sqDkEsTRsoxj9vHXg9mBuWxmPZddYjnvQpWna/XuCcu4Wk7Uv3D+PIOdohAtsY91K7sMli9AM/TneLHSpUvq0UgDY3Zb7onwgrGpBh/HLss1EKl3pWO5T7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774806835; c=relaxed/relaxed;
	bh=jqKSjvR4RozLU93WzViYAx1Hmvk3bf0QfkHSmDsrpVM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S2TeUZj05R9s76XsssSvKpWbVtjlcQQXmy6PgVb2EMsFWMRH1fKsG6ZCEtmYaeYlLYEFz32rYXYD8ewVJMX/HEwgJ73xhmgprd5aG7K2eJbHeX2ENGJAG0BrNuj6tNp7MJwPNEOY2zvZEg8sOrBU2I5TNXGFEqkVxS1riuDK6GxOVWXQIj/ANmrkxup0OU7mjSOhY0WPdhZ37kgF2mon21GrnbjcRlvcx59Kas00IDrScTpe9+fpHO38wjEKmWBjCESORYfR9kHPXAqyrgAjpYphiNgx/L/eHDxwnWVf5cJrPt6ddg7XXWhVou6Mdb6d7r9Ufex8QPpE01tE2IhQxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jfVcDe7d; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jfVcDe7d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkMSc5Z79z2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 04:53:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774806833; x=1806342833;
  h=date:from:to:cc:subject:message-id;
  bh=3viHqhMIPhwfW83yygBrW9K2KPdbOnfshrRpRexWzjw=;
  b=jfVcDe7dcHcL321uayHn8iuZZLpDLBgrIR+C2X72ALm51jlz4M2vwaLj
   y7DBS1ytrLGwJjL8ZNRh2EgoOOhrA1P5UJKgKsvIwEMPqx7wPBnZRE2Qp
   CpIxLdriX86cuotTBJD41B6gkXyRzCkItxVpVsq2VXDrs2Ou+zWkjh5ji
   2rIstrZDaIcVxfPI7/mO7uGUAcR9ikRNYj+Nm91wE6rl3IajBE0OhxtAp
   TPeMxEEjdKm/IYV61OhAy39i8HPCvNMH2wz+Le2j+h/GPF5sMvJbTTjB+
   fZlyaEsJlJI4PzhhM2I8rBpxFCIXzR52Q8x4638qcb1ZRqNRcrovqcY9Q
   Q==;
X-CSE-ConnectionGUID: tfQIjq9iRjyQSsJ1fHNU8Q==
X-CSE-MsgGUID: 8SwWbiZQSRCgxJ6bChdpSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="98420045"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="98420045"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 10:53:46 -0700
X-CSE-ConnectionGUID: QdszlVn2QP6VWibS4RwqRg==
X-CSE-MsgGUID: SdkNjCbUSnyDVb3DaPfDdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="248888107"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 29 Mar 2026 10:53:44 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6uKU-00000000CeB-0H1R;
	Sun, 29 Mar 2026 17:53:42 +0000
Date: Mon, 30 Mar 2026 01:53:04 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 a2f77341f05a8a16d5158f2ae650c71efac35a46
Message-ID: <202603300156.h5aiv7jU-lkp@intel.com>
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
branch HEAD: a2f77341f05a8a16d5158f2ae650c71efac35a46  Automatic merge of 'next' into merge (2026-03-29 10:35)

elapsed time: 752m

configs tested: 201
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260329    gcc-8.5.0
arc                   randconfig-002-20260329    gcc-8.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20260329    gcc-8.5.0
arm                   randconfig-002-20260329    gcc-8.5.0
arm                   randconfig-003-20260329    gcc-8.5.0
arm                   randconfig-004-20260329    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260329    gcc-12.5.0
arm64                 randconfig-002-20260329    gcc-12.5.0
arm64                 randconfig-003-20260329    gcc-12.5.0
arm64                 randconfig-004-20260329    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260329    gcc-12.5.0
csky                  randconfig-002-20260329    gcc-12.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260329    clang-23
hexagon               randconfig-001-20260329    gcc-11.5.0
hexagon               randconfig-002-20260329    clang-23
hexagon               randconfig-002-20260329    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260329    clang-20
i386        buildonly-randconfig-002-20260329    clang-20
i386        buildonly-randconfig-003-20260329    clang-20
i386        buildonly-randconfig-004-20260329    clang-20
i386        buildonly-randconfig-005-20260329    clang-20
i386        buildonly-randconfig-006-20260329    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260329    clang-20
i386                  randconfig-002-20260329    clang-20
i386                  randconfig-003-20260329    clang-20
i386                  randconfig-004-20260329    clang-20
i386                  randconfig-005-20260329    clang-20
i386                  randconfig-006-20260329    clang-20
i386                  randconfig-007-20260329    clang-20
i386                  randconfig-011-20260329    clang-20
i386                  randconfig-012-20260329    clang-20
i386                  randconfig-013-20260329    clang-20
i386                  randconfig-014-20260329    clang-20
i386                  randconfig-015-20260329    clang-20
i386                  randconfig-016-20260329    clang-20
i386                  randconfig-017-20260329    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260329    gcc-11.5.0
loongarch             randconfig-001-20260329    gcc-15.2.0
loongarch             randconfig-002-20260329    clang-23
loongarch             randconfig-002-20260329    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        maltaup_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260329    gcc-10.5.0
nios2                 randconfig-001-20260329    gcc-11.5.0
nios2                 randconfig-002-20260329    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260329    gcc-8.5.0
parisc                randconfig-002-20260329    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260329    gcc-8.5.0
powerpc               randconfig-002-20260329    gcc-8.5.0
powerpc64             randconfig-001-20260329    gcc-8.5.0
powerpc64             randconfig-002-20260329    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260329    clang-23
riscv                 randconfig-002-20260329    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260329    clang-23
s390                  randconfig-002-20260329    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260329    clang-23
sh                    randconfig-002-20260329    clang-23
sh                             sh03_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260329    gcc-13.4.0
sparc                 randconfig-001-20260329    gcc-14
sparc                 randconfig-002-20260329    gcc-14
sparc                 randconfig-002-20260329    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260329    clang-23
sparc64               randconfig-001-20260329    gcc-14
sparc64               randconfig-002-20260329    gcc-13.4.0
sparc64               randconfig-002-20260329    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260329    gcc-14
um                    randconfig-002-20260329    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260329    clang-20
x86_64      buildonly-randconfig-001-20260329    gcc-14
x86_64      buildonly-randconfig-002-20260329    gcc-14
x86_64      buildonly-randconfig-003-20260329    clang-20
x86_64      buildonly-randconfig-003-20260329    gcc-14
x86_64      buildonly-randconfig-004-20260329    gcc-14
x86_64      buildonly-randconfig-005-20260329    clang-20
x86_64      buildonly-randconfig-005-20260329    gcc-14
x86_64      buildonly-randconfig-006-20260329    clang-20
x86_64      buildonly-randconfig-006-20260329    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260329    gcc-14
x86_64                randconfig-002-20260329    gcc-14
x86_64                randconfig-003-20260329    gcc-14
x86_64                randconfig-004-20260329    gcc-14
x86_64                randconfig-005-20260329    gcc-14
x86_64                randconfig-006-20260329    gcc-14
x86_64                randconfig-011-20260329    gcc-14
x86_64                randconfig-012-20260329    gcc-14
x86_64                randconfig-013-20260329    gcc-14
x86_64                randconfig-014-20260329    gcc-14
x86_64                randconfig-015-20260329    gcc-14
x86_64                randconfig-016-20260329    gcc-14
x86_64                randconfig-071-20260329    clang-20
x86_64                randconfig-072-20260329    clang-20
x86_64                randconfig-073-20260329    clang-20
x86_64                randconfig-074-20260329    clang-20
x86_64                randconfig-075-20260329    clang-20
x86_64                randconfig-076-20260329    clang-20
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
xtensa                randconfig-001-20260329    gcc-10.5.0
xtensa                randconfig-001-20260329    gcc-14
xtensa                randconfig-002-20260329    gcc-11.5.0
xtensa                randconfig-002-20260329    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

