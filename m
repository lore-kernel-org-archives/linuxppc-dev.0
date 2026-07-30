Return-Path: <linuxppc-dev+bounces-25048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12479C54FCD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 02:20:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Xwf2Llpz2xJR;
	Thu, 30 Jul 2026 12:20:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785378018;
	cv=none; b=lO0bJsv9hhkDpaSvl/ApZR5N2w3/m6xzoDLH5Bg38LW56z7E0LpG9BITMobu7T69KHiUNpMBdBLF5IryESP1rBA0nc5rqIfwOxcoxJjLzmePfIG3AzvxnYoVOiyir1ua5eMK9vfB6VSL4IFelhCejqsLpPxKNP1DDjaJ5k7xDvQmT4NRM0b2Qj7F3g+QLgBOxYoAEn6zlX2H6NJ4cXChI/2FAPiNwVcK6ox73MZDISwi32jQir7B4msWx9VgLKwi2NUj6wOPYK2Rx1mrT2Qrv1mII7EAQjfMfykysbRbZXWYEqPN0+nVQz2be8EcAeT1rjSHjqDfvlFnGZPMg1KLew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785378018; c=relaxed/relaxed;
	bh=6Mtmr6X6hDhjd0FF1TwmJUllJw4dY4KLIhWkNvwDVQU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VtI/JFd/Sl3IELWrgPs9XcT+R7twr+Kd0qSGUgh7zogxuVyhjru6ebeBiN7dbrFY7wYGYwWCDrH8vZfFPda0tnZh8aQA7nDRGNAnJtHg4K9Z3HtxjjqBPlRqjNc0np6MqBzIEkJTnj/iqOjpwWFsImHXJJf7882nuLRFi4du9rtXnLXl0RI/8Q4Fmmv/OJ+4R05bh+EEb4foomxXaPcZwt3UiRCN87Zc5qKgis7oAPbwD3VmBa3egPPAkhU86ve/6dWM5kOtIHHLcZLRy+t4621Nyczb1gAe2cwOVS6goQv91bZdRnbp/y/gYxqZWiN34WS8J4vimTtS4Xs26oHD9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MwKk+62D; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MwKk+62D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Xwb0wlKz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 12:20:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785378015; x=1816914015;
  h=date:from:to:cc:subject:message-id;
  bh=xtjHm5uD9QXI8JhqxxWH1dpOs6Edz9IecAcgpRbOkZc=;
  b=MwKk+62DEo85HafZnVQ9Gl+t/VvFBf+0u5jEDLdu+5wDkJ0sP5LlLzwD
   xoTyWIB5cBM4bpdvNyO9vFc122CeWcAxOHyIeEt2lR+VaUBd6o3iIn+vA
   beaFEExkmG7BTwPocxvQ/GNMaoqoKY6xwt98pAGgqCrEnKwiYT/nzBUvm
   b7iLS7AJvLAlPTb4wvHhhE3WnXRy723il1mIe06XUR6prAs9Khc51dILr
   /UgIluR1s4fpIe2Jf58CJiCUUtRpvu68wXZFuh6ilackM+3weUsfzrNPG
   DRm6S4DKRjItRDnWMBFOQOhlmaPoRXE10QAUzfyCWjC2R9KmO8bZ+QNTU
   Q==;
X-CSE-ConnectionGUID: jX0U5ozsSDalAiKKKgGlLg==
X-CSE-MsgGUID: 7N6uldhpTDajBBNOrSvpKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97366493"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="97366493"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 19:20:09 -0700
X-CSE-ConnectionGUID: F7AlPwUuRfmACPhB/138cg==
X-CSE-MsgGUID: 255m2I0fQxSXdgEdYINRgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="264434081"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 29 Jul 2026 19:20:07 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpGNB-00000000fuf-42X6;
	Thu, 30 Jul 2026 02:19:55 +0000
Date: Thu, 30 Jul 2026 10:17:09 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 bd1b2c5e31de25ee148ff507ca7c51b1cd594b1b
Message-ID: <202607301059.MX6j8MxA-lkp@intel.com>
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
branch HEAD: bd1b2c5e31de25ee148ff507ca7c51b1cd594b1b  Automatic merge of 'fixes' into merge (2026-07-29 17:55)

elapsed time: 789m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-001-20260730    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-13.4.0
arc                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-10.5.0
arm                  randconfig-001-20260730    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-003-20260729    clang-24
arm                  randconfig-003-20260730    gcc-8.5.0
arm                  randconfig-004-20260729    clang-18
arm                  randconfig-004-20260730    gcc-8.5.0
arm                       realview_defconfig    clang-17
arm64                randconfig-001-20260729    gcc-15.2.0
arm64                randconfig-001-20260730    gcc-15.2.0
arm64                randconfig-002-20260729    gcc-13.4.0
arm64                randconfig-002-20260730    gcc-15.2.0
arm64                randconfig-003-20260729    gcc-11.5.0
arm64                randconfig-003-20260730    gcc-15.2.0
arm64                randconfig-004-20260729    clang-17
arm64                randconfig-004-20260730    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    gcc-16.1.0
csky                 randconfig-001-20260730    gcc-15.2.0
csky                 randconfig-002-20260729    gcc-16.1.0
csky                 randconfig-002-20260730    gcc-15.2.0
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260730    gcc-14
i386       buildonly-randconfig-002-20260730    gcc-14
i386       buildonly-randconfig-003-20260730    gcc-14
i386       buildonly-randconfig-004-20260730    gcc-14
i386       buildonly-randconfig-005-20260730    gcc-14
i386       buildonly-randconfig-006-20260730    gcc-14
i386                 randconfig-001-20260730    gcc-14
i386                 randconfig-002-20260730    gcc-14
i386                 randconfig-003-20260730    gcc-14
i386                 randconfig-004-20260730    gcc-14
i386                 randconfig-005-20260730    gcc-14
i386                 randconfig-006-20260730    gcc-14
i386                 randconfig-007-20260730    gcc-14
i386                 randconfig-011-20260730    clang-22
i386                 randconfig-012-20260730    clang-22
i386                 randconfig-013-20260730    clang-22
i386                 randconfig-014-20260730    clang-22
i386                 randconfig-015-20260730    clang-22
i386                 randconfig-016-20260730    clang-22
i386                 randconfig-017-20260730    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260730    clang-24
loongarch            randconfig-002-20260730    clang-24
mips                         ath25_defconfig    clang-24
mips                          ip30_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260730    clang-24
nios2                randconfig-002-20260730    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260730    gcc-14.3.0
parisc               randconfig-002-20260730    gcc-16.1.0
powerpc              randconfig-001-20260730    clang-24
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260730    gcc-11.5.0
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260730    clang-24
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260730    gcc-8.5.0
riscv                randconfig-001-20260729    gcc-8.5.0
riscv                randconfig-001-20260730    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-9.5.0
riscv                randconfig-002-20260730    gcc-15.2.0
s390                 randconfig-001-20260729    clang-17
s390                 randconfig-001-20260730    gcc-15.2.0
s390                 randconfig-002-20260729    clang-24
s390                 randconfig-002-20260730    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-13.4.0
sh                   randconfig-001-20260730    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sh                   randconfig-002-20260730    gcc-15.2.0
sparc                         randconfig-001    clang-24
sparc                randconfig-001-20260730    clang-24
sparc                randconfig-001-20260730    gcc-16.1.0
sparc                randconfig-002-20260730    clang-24
sparc                randconfig-002-20260730    gcc-16.1.0
sparc64              randconfig-001-20260730    clang-20
sparc64              randconfig-001-20260730    clang-24
sparc64              randconfig-002-20260730    clang-24
sparc64              randconfig-002-20260730    gcc-14.3.0
um                   randconfig-001-20260730    clang-17
um                   randconfig-001-20260730    clang-24
um                   randconfig-002-20260730    clang-24
x86_64     buildonly-randconfig-001-20260730    gcc-14
x86_64     buildonly-randconfig-002-20260730    gcc-14
x86_64     buildonly-randconfig-003-20260730    gcc-14
x86_64     buildonly-randconfig-004-20260730    gcc-14
x86_64     buildonly-randconfig-005-20260730    gcc-14
x86_64     buildonly-randconfig-006-20260730    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260730    clang-22
x86_64               randconfig-002-20260730    clang-22
x86_64               randconfig-003-20260730    clang-22
x86_64               randconfig-004-20260730    clang-22
x86_64               randconfig-005-20260730    clang-22
x86_64               randconfig-006-20260730    clang-22
x86_64               randconfig-011-20260729    gcc-14
x86_64               randconfig-011-20260730    clang-22
x86_64               randconfig-012-20260729    gcc-14
x86_64               randconfig-012-20260730    clang-22
x86_64               randconfig-013-20260729    gcc-14
x86_64               randconfig-013-20260730    clang-22
x86_64               randconfig-014-20260729    gcc-14
x86_64               randconfig-014-20260730    clang-22
x86_64               randconfig-015-20260729    gcc-14
x86_64               randconfig-015-20260730    clang-22
x86_64               randconfig-016-20260729    gcc-14
x86_64               randconfig-016-20260730    clang-22
x86_64               randconfig-071-20260730    gcc-12
x86_64               randconfig-072-20260730    gcc-12
x86_64               randconfig-073-20260730    gcc-12
x86_64               randconfig-074-20260730    gcc-12
x86_64               randconfig-075-20260730    gcc-12
x86_64               randconfig-076-20260730    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260730    clang-24
xtensa               randconfig-001-20260730    gcc-16.1.0
xtensa               randconfig-002-20260730    clang-24
xtensa               randconfig-002-20260730    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

