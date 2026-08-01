Return-Path: <linuxppc-dev+bounces-25193-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50C5C54FCD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Aug 2026 03:54:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBpw90G44z2yT0;
	Sat, 01 Aug 2026 13:54:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785556456;
	cv=none; b=kEEMB6aXeVyE1CH1XOjV5hPP0TPESxm/00hodFJa36sdS3PU7KxUk2mwODc6gtK93a7J0ipqyXvq0nTOakj0HOuphVFium5rPqtkdAmFz1f+9E9+EjqrOuYERvq3w5p1TfUMRvZun3O024UDAg1zgco5pTd9oriyiAZnbQoKxU93CKecDyTyExjztmjmg81gBUkZWBEJf08ZJu19MpkXNo+Se/nWTdi0SUcu+2hZx88e7/f/LvEM6DNNOxmbQWOXPtZMYzki19qat6OMTvft/nmmiS2sxuVudcld9+U3NezzzzvguLDFiESDx9khAW0xDcem2wo/X1JymzWIs43MFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785556456; c=relaxed/relaxed;
	bh=fmuD0A3gHLCqcxJWDatvnUbpxYMU9+7orq1g0dskuMs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YsQaN1r+HW7CtqBrTq7cp+1U35YrjjMmkRuyWk/rVxeiEWQ5gxlIxe5ZvE0mYfSUCGrYMyC2eExSGSCA+gMxtPG0nvVMDNzUrJjhbZA7/LOOup0jCWyyfuS8Q3sOLIDrwHATrmaz9KQMf2Vp6ilyX4J3Pi5OoWEVQUcWi2tEOXDxbCOvDoryGCf1n9OIdZl147rkFe/fr+6J0+IO+K0rKQKobfKyT7MfMh/WavFpQw1QNlnqlKAAqKzIwTQE/2sPtoV3TCl0Oz7qVzZDCo8O6R4qUBiHGrEzfxGaDJdHDkYX4dYKUQFRbQM66RY6sosxKQOJGCVZeSSrZDXXYub/Kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W/H/mqJg; dkim-atps=neutral; spf=pass (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W/H/mqJg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBpw560Fwz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 13:54:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785556454; x=1817092454;
  h=date:from:to:cc:subject:message-id;
  bh=3oEy3vsnrrEJ5uKAV8P9Jh33MAzCt1WrrCqRWKtqHz4=;
  b=W/H/mqJgAXMqGT0Ca1HCEE7O5kahiBfGt1dnIrL586ydGKZ+dzI8xW/8
   zgbxZ+aU4MD64NOrcA+f8INRjlhlb9AMEAK8N0KIhvNNosSjjBxs6ngnA
   jd6qkCeeUiJNc/cs2TbYOwFrFC3dXFPjj5M5pcjR5Y3FBc835RcdBNUZF
   m7JaQ88bC5nv5thyCgX1l2q9hvj1ZXg3JB8xEcj0JyaxpYGb/8upOOB4s
   4kIaiVvdQrCr511ff1qMXU02y2oGkhBRw5wfpluSatU6lBZzKvG2I5F9f
   gO39SlCZ59oEdJPtwoHeQ7kJRSCH0i7FXABCXVJ7+xEWQHHrYv4JwsyLA
   g==;
X-CSE-ConnectionGUID: vvS9ROSRRG2T1BwiCI6aiQ==
X-CSE-MsgGUID: mkMavNllSRG9hmBXG/xssg==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="86297452"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="86297452"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 20:54:08 -0700
X-CSE-ConnectionGUID: kBTdNMpbSWOOXKq7nS8AqA==
X-CSE-MsgGUID: obUPvkaKRIGKdTgP6s11tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="264550251"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Jul 2026 20:54:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wq0nU-000000002gd-2j4s;
	Sat, 01 Aug 2026 03:54:04 +0000
Date: Sat, 01 Aug 2026 11:53:24 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 fa40f9dbdd4af53e7445d9135b5b207eb8adf372
Message-ID: <202608011110.Jf3nOXWO-lkp@intel.com>
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
branch HEAD: fa40f9dbdd4af53e7445d9135b5b207eb8adf372  powerpc/kexec_file: Prevent kexec range truncation

elapsed time: 790m

configs tested: 86
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260801    gcc-12.5.0
arc                  randconfig-002-20260801    gcc-12.5.0
arm                  randconfig-001-20260801    gcc-12.5.0
arm                  randconfig-002-20260801    gcc-12.5.0
arm                  randconfig-003-20260801    gcc-12.5.0
arm                  randconfig-004-20260801    gcc-12.5.0
arm64                randconfig-001-20260801    gcc-10.5.0
arm64                randconfig-002-20260801    gcc-10.5.0
arm64                randconfig-003-20260801    gcc-10.5.0
arm64                randconfig-004-20260801    gcc-10.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260801    gcc-10.5.0
csky                 randconfig-002-20260801    gcc-10.5.0
hexagon              randconfig-001-20260801    gcc-16.1.0
hexagon              randconfig-002-20260801    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260801    gcc-14
i386       buildonly-randconfig-002-20260801    gcc-14
i386       buildonly-randconfig-003-20260801    gcc-14
i386       buildonly-randconfig-004-20260801    gcc-14
i386       buildonly-randconfig-005-20260801    gcc-14
i386       buildonly-randconfig-006-20260801    gcc-14
i386                 randconfig-011-20260801    gcc-14
i386                 randconfig-012-20260801    gcc-14
i386                 randconfig-013-20260801    gcc-14
i386                 randconfig-014-20260801    gcc-14
i386                 randconfig-015-20260801    gcc-14
i386                 randconfig-016-20260801    gcc-14
i386                 randconfig-017-20260801    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260801    gcc-16.1.0
loongarch            randconfig-002-20260801    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260801    gcc-16.1.0
nios2                randconfig-002-20260801    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260801    gcc-9.5.0
parisc               randconfig-002-20260801    gcc-9.5.0
powerpc                     bamboo_defconfig    clang-21
powerpc              randconfig-001-20260801    gcc-9.5.0
powerpc              randconfig-002-20260801    gcc-9.5.0
powerpc64            randconfig-001-20260801    gcc-9.5.0
powerpc64            randconfig-002-20260801    gcc-9.5.0
riscv                randconfig-001-20260801    gcc-14.3.0
riscv                randconfig-002-20260801    gcc-14.3.0
s390                 randconfig-001-20260801    gcc-14.3.0
s390                 randconfig-002-20260801    gcc-14.3.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260801    gcc-14.3.0
sh                   randconfig-002-20260801    gcc-14.3.0
sparc                randconfig-001-20260801    gcc-11.5.0
sparc                randconfig-002-20260801    gcc-11.5.0
sparc64              randconfig-001-20260801    gcc-11.5.0
sparc64              randconfig-002-20260801    gcc-11.5.0
um                   randconfig-001-20260801    gcc-11.5.0
um                   randconfig-002-20260801    gcc-11.5.0
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260801    gcc-14
x86_64               randconfig-002-20260801    gcc-14
x86_64               randconfig-003-20260801    gcc-14
x86_64               randconfig-004-20260801    gcc-14
x86_64               randconfig-005-20260801    gcc-14
x86_64               randconfig-006-20260801    gcc-14
x86_64               randconfig-011-20260801    clang-22
x86_64               randconfig-012-20260801    clang-22
x86_64               randconfig-013-20260801    clang-22
x86_64               randconfig-014-20260801    clang-22
x86_64               randconfig-015-20260801    clang-22
x86_64               randconfig-016-20260801    clang-22
x86_64               randconfig-071-20260801    clang-22
x86_64               randconfig-072-20260801    clang-22
x86_64               randconfig-073-20260801    clang-22
x86_64               randconfig-074-20260801    clang-22
x86_64               randconfig-075-20260801    clang-22
x86_64               randconfig-076-20260801    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260801    gcc-11.5.0
xtensa               randconfig-002-20260801    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

