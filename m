Return-Path: <linuxppc-dev+bounces-25655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE276C5AD5A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 02:42:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJJvH0ddzz2yqT;
	Mon, 10 Aug 2026 12:42:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786329755;
	cv=none; b=QYlNy90oLz1MNReVjhSmGVVC2r1X/PpuVviJgjYrxaCgkV4cwgw2+d0T4sonuH5ooLsNHPLabJXRYTEJlyiS/qIz5u6mqZualSwU94bvn1z5xutVEgn3hEHlMg2/WcRxHm62eENFzfo1JQY4DlHHf+D2bgVzHVzgb+DRXj9nFEFXgvTaTb50UfOrKa+3MtZOT63L/Av4QwAKwNRhSFA2IR0B5NbDm0BmxRIWiZsUFyP+e/xVB7lx9+4XPt7uBdgje/B3nGiGOud2+6X2nR8Ukx8EHG0WxW3o7AahTd9lLK+vg56d9LLay5IOZQmO/21l8LFcqCAbAPBxdzGS7cnNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786329755; c=relaxed/relaxed;
	bh=AHVtMLe+VykIBHMJmJ+EJWEL4fQSL5pgrbR6YFVgfnI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=X6c59QxjKFGzPyAmPFohcHz+bXK+QEe3vkv2cg9s5zhh7NTdvIrZssIZio3nlq9WuwRNQZYhNGe8YO/VvSqpDvA8i+ah6QIK6HDXmUVWSOx+/eHyNSRd+6gdXA9mPO499g3tlX8Uuz6RdpHIyUdhltOjVPdmq1yHr0hHDPR8H+mARTL/bwMfCKhKxxnywRNP4ufUJLbjBT1mhPFT6qy/6nGM+PZX2pabFkqCKfgd5nkvW7QJ7bsgFFl1i/yeSsn43BdwOp/OTfksbdpEtO+Chlap+9bTx5K3P+gpRgJjwDzYvX2zM5UzbskTF9gt/GrDQ+5nIhGTvWlf78SlJBqzUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UFcMwTlw; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UFcMwTlw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJJvF3dGXz2yqP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 12:42:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786329754; x=1817865754;
  h=date:from:to:cc:subject:message-id;
  bh=B0ubLuE/eCOzHKTgI3WmNC+3dGnY/IgTBfqHiYB78sA=;
  b=UFcMwTlwgxjan4WoAn2Yzw1vj6tpOghXqqHkhNtXWuuVvX5eh/k+t6zX
   Ql73Y9tgcdHh8VabscDkh2I2uKIT/3lDNYIMKk2Tabz9Aic+Vke+lzF0a
   THIUI9HfdaDNkC8V/6nWeRU3i8OQV/aSPWAxz6+PkcIEX7ZoOQYuoP65C
   SlaA/EJyRH/Oz+QsDtCqwqyEXohoYufVDJETx+B/BTPGxtuT7x0hGurll
   3AqRzNBFoLiCV/Ok3htktJX2khVhB4gPnA5SloTnJ9VjTAzEYF9ZMn3yu
   4MyJCS30Mr6MSmjGIHzzoiA/onrgBUk/Q/BCmADZ+uodRGmAbyuX+yRdw
   Q==;
X-CSE-ConnectionGUID: w+iifA1+TX+qRh5fo1QyPQ==
X-CSE-MsgGUID: PqiBfmydTV+4T6dlizT/lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98199084"
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="98199084"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 19:42:30 -0700
X-CSE-ConnectionGUID: lB/HnMy+TVigh81erE0U3g==
X-CSE-MsgGUID: 7FDNYsAKQnm1iRgxO51X4g==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Aug 2026 19:42:28 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wtFy6-00000000Mba-0jyf;
	Mon, 10 Aug 2026 02:42:26 +0000
Date: Mon, 10 Aug 2026 10:41:22 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 ba54fb0b3cbf7048fcffa0e2685d136d81263462
Message-ID: <202608101011.0H6ZiPlg-lkp@intel.com>
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
branch HEAD: ba54fb0b3cbf7048fcffa0e2685d136d81263462  Automatic merge of 'fixes' into merge (2026-08-08 10:45)

elapsed time: 1507m

configs tested: 187
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260809    gcc-12.5.0
arc                  randconfig-001-20260810    gcc-8.5.0
arc                  randconfig-002-20260809    gcc-12.5.0
arc                  randconfig-002-20260810    gcc-8.5.0
arm                           hisi_defconfig    gcc-16.1.0
arm                  randconfig-001-20260809    gcc-12.5.0
arm                  randconfig-001-20260810    gcc-8.5.0
arm                  randconfig-002-20260809    gcc-12.5.0
arm                  randconfig-002-20260810    gcc-8.5.0
arm                  randconfig-003-20260809    gcc-12.5.0
arm                  randconfig-003-20260810    gcc-8.5.0
arm                  randconfig-004-20260809    gcc-12.5.0
arm                  randconfig-004-20260810    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260809    gcc-14.3.0
arm64                randconfig-001-20260810    gcc-16.1.0
arm64                randconfig-002-20260809    gcc-14.3.0
arm64                randconfig-002-20260810    gcc-16.1.0
arm64                randconfig-003-20260809    gcc-14.3.0
arm64                randconfig-003-20260810    gcc-16.1.0
arm64                randconfig-004-20260809    gcc-14.3.0
arm64                randconfig-004-20260810    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260809    gcc-14.3.0
csky                 randconfig-001-20260810    gcc-16.1.0
csky                 randconfig-002-20260809    gcc-14.3.0
csky                 randconfig-002-20260810    gcc-16.1.0
hexagon              randconfig-001-20260809    gcc-12.5.0
hexagon              randconfig-001-20260810    gcc-10.5.0
hexagon              randconfig-002-20260809    gcc-12.5.0
hexagon              randconfig-002-20260810    gcc-10.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260809    clang-22
i386       buildonly-randconfig-001-20260810    clang-22
i386       buildonly-randconfig-002-20260809    clang-22
i386       buildonly-randconfig-002-20260810    clang-22
i386       buildonly-randconfig-003-20260809    clang-22
i386       buildonly-randconfig-003-20260810    clang-22
i386       buildonly-randconfig-004-20260809    clang-22
i386       buildonly-randconfig-004-20260810    clang-22
i386       buildonly-randconfig-005-20260809    clang-22
i386       buildonly-randconfig-005-20260810    clang-22
i386       buildonly-randconfig-006-20260809    clang-22
i386       buildonly-randconfig-006-20260810    clang-22
i386                 randconfig-001-20260809    clang-22
i386                 randconfig-001-20260810    gcc-14
i386                 randconfig-002-20260809    clang-22
i386                 randconfig-002-20260810    gcc-14
i386                 randconfig-003-20260809    clang-22
i386                 randconfig-003-20260810    gcc-14
i386                 randconfig-004-20260809    clang-22
i386                 randconfig-004-20260810    gcc-14
i386                 randconfig-005-20260809    clang-22
i386                 randconfig-005-20260810    gcc-14
i386                 randconfig-006-20260809    clang-22
i386                 randconfig-006-20260810    gcc-14
i386                 randconfig-007-20260809    clang-22
i386                 randconfig-007-20260810    gcc-14
i386                          randconfig-011    clang-22
i386                 randconfig-011-20260809    clang-22
i386                 randconfig-011-20260810    clang-22
i386                 randconfig-012-20260809    clang-22
i386                 randconfig-012-20260810    clang-22
i386                 randconfig-013-20260809    clang-22
i386                 randconfig-013-20260810    clang-22
i386                 randconfig-014-20260809    clang-22
i386                 randconfig-014-20260810    clang-22
i386                 randconfig-015-20260809    clang-22
i386                 randconfig-015-20260810    clang-22
i386                 randconfig-016-20260809    clang-22
i386                 randconfig-016-20260810    clang-22
i386                 randconfig-017-20260809    clang-22
i386                 randconfig-017-20260810    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260809    gcc-12.5.0
loongarch            randconfig-001-20260810    gcc-10.5.0
loongarch            randconfig-002-20260809    gcc-12.5.0
loongarch            randconfig-002-20260810    gcc-10.5.0
mips                         ath25_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260809    gcc-12.5.0
nios2                randconfig-001-20260810    gcc-10.5.0
nios2                randconfig-002-20260809    gcc-12.5.0
nios2                randconfig-002-20260810    gcc-10.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260809    gcc-8.5.0
parisc               randconfig-001-20260810    gcc-8.5.0
parisc               randconfig-002-20260809    gcc-8.5.0
parisc               randconfig-002-20260810    gcc-8.5.0
powerpc              randconfig-001-20260809    gcc-8.5.0
powerpc              randconfig-001-20260810    gcc-8.5.0
powerpc              randconfig-002-20260809    gcc-8.5.0
powerpc              randconfig-002-20260810    gcc-8.5.0
powerpc64            randconfig-001-20260809    gcc-8.5.0
powerpc64            randconfig-001-20260810    gcc-8.5.0
powerpc64            randconfig-002-20260809    gcc-8.5.0
powerpc64            randconfig-002-20260810    gcc-8.5.0
riscv                randconfig-001-20260809    clang-24
riscv                randconfig-001-20260810    gcc-8.5.0
riscv                randconfig-002-20260809    clang-24
riscv                randconfig-002-20260810    gcc-8.5.0
s390                 randconfig-001-20260809    clang-24
s390                 randconfig-001-20260810    gcc-8.5.0
s390                 randconfig-002-20260809    clang-24
s390                 randconfig-002-20260810    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                        ecovec24_defconfig    gcc-16.1.0
sh                   randconfig-001-20260809    clang-24
sh                   randconfig-001-20260810    gcc-8.5.0
sh                   randconfig-002-20260809    clang-24
sh                   randconfig-002-20260810    gcc-8.5.0
sh                             ul2_defconfig    gcc-16.1.0
sparc                randconfig-001-20260809    gcc-11.5.0
sparc                randconfig-001-20260810    gcc-11.5.0
sparc                randconfig-002-20260809    gcc-11.5.0
sparc                randconfig-002-20260810    gcc-11.5.0
sparc64              randconfig-001-20260809    gcc-11.5.0
sparc64              randconfig-001-20260810    gcc-11.5.0
sparc64              randconfig-002-20260809    gcc-11.5.0
sparc64              randconfig-002-20260810    gcc-11.5.0
um                   randconfig-001-20260809    gcc-11.5.0
um                   randconfig-001-20260810    gcc-11.5.0
um                   randconfig-002-20260809    gcc-11.5.0
um                   randconfig-002-20260810    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260809    clang-22
x86_64     buildonly-randconfig-001-20260810    gcc-14
x86_64     buildonly-randconfig-002-20260809    clang-22
x86_64     buildonly-randconfig-002-20260810    gcc-14
x86_64     buildonly-randconfig-003-20260809    clang-22
x86_64     buildonly-randconfig-003-20260810    gcc-14
x86_64     buildonly-randconfig-004-20260809    clang-22
x86_64     buildonly-randconfig-004-20260810    gcc-14
x86_64     buildonly-randconfig-005-20260809    clang-22
x86_64     buildonly-randconfig-005-20260810    gcc-14
x86_64     buildonly-randconfig-006-20260809    clang-22
x86_64     buildonly-randconfig-006-20260810    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260809    clang-22
x86_64               randconfig-001-20260810    gcc-14
x86_64               randconfig-002-20260809    clang-22
x86_64               randconfig-002-20260810    gcc-14
x86_64               randconfig-003-20260809    clang-22
x86_64               randconfig-003-20260810    gcc-14
x86_64               randconfig-004-20260809    clang-22
x86_64               randconfig-004-20260810    gcc-14
x86_64               randconfig-005-20260809    clang-22
x86_64               randconfig-005-20260810    gcc-14
x86_64               randconfig-006-20260809    clang-22
x86_64               randconfig-006-20260810    gcc-14
x86_64               randconfig-011-20260809    gcc-14
x86_64               randconfig-011-20260810    clang-22
x86_64               randconfig-012-20260809    gcc-14
x86_64               randconfig-012-20260810    clang-22
x86_64               randconfig-013-20260809    gcc-14
x86_64               randconfig-013-20260810    clang-22
x86_64               randconfig-014-20260809    gcc-14
x86_64               randconfig-014-20260810    clang-22
x86_64               randconfig-015-20260809    gcc-14
x86_64               randconfig-015-20260810    clang-22
x86_64               randconfig-016-20260809    gcc-14
x86_64               randconfig-016-20260810    clang-22
x86_64               randconfig-071-20260809    clang-22
x86_64               randconfig-071-20260810    clang-22
x86_64               randconfig-072-20260809    clang-22
x86_64               randconfig-072-20260810    clang-22
x86_64               randconfig-073-20260809    clang-22
x86_64               randconfig-073-20260810    clang-22
x86_64               randconfig-074-20260809    clang-22
x86_64               randconfig-074-20260810    clang-22
x86_64               randconfig-075-20260809    clang-22
x86_64               randconfig-075-20260810    clang-22
x86_64               randconfig-076-20260809    clang-22
x86_64               randconfig-076-20260810    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260809    gcc-11.5.0
xtensa               randconfig-001-20260810    gcc-11.5.0
xtensa               randconfig-002-20260809    gcc-11.5.0
xtensa               randconfig-002-20260810    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

