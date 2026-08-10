Return-Path: <linuxppc-dev+bounces-25654-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518AAC5AD5A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 02:40:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJJrl4nDtz2yqP;
	Mon, 10 Aug 2026 12:40:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786329623;
	cv=none; b=Ms/3BQAU5nhKjLxkT/AE2zOf2zBADHiJlRCNJnDN6sMULO0vQjK6NRhPohujSfXESCQX6KNbNSIXEQeMqGTQkJKUEJT38eUIppqwtiN5+JztGLnZH3ubowGjtIgRm/pf8jOL3MawuuQ41kNYNsqSj5Jsz+/pNrmY+o5CTCdxQyoK97IvrMfWGNoEDCWn7tRYYB6jNcLeyXVt43FBTmPenBdUNO3PUr8SF/OEmBvg8uIr8yj+jaYLkokgo0V5JWpqALYYpGvoJVQA2xYaSQI6rquV33GoZmbF3EQ3dCakdUmz/Uj7hIU5Ycd+bnV5BPQ2uQkKKKk7JwFTPcCeW8i8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786329623; c=relaxed/relaxed;
	bh=kSB0I2Z5rdhBtasT+kTiuskuVNJp7fnxTa4bRJrvp44=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TISUuQ+bKIMbEpygNoNonDlE0l/GaHtyurhwUr0SLKwyVvKbl29m7wpNQ+P0cCRTW3K5HocDkmPruT7Wv5pj9ad1Sy+tzcYaAlkvHRtPAYMY470xMpYeTcKLpKcnphT61qbit8ePEMktUyKCDZNO27apPbbgdrvQh03+mX6NKtH/UWmU026BZQ10JpjSsOvzZo+6E7TXzryH4FLU9vnhtNPTbPtYhqYcOnm02j2EiQ2a1V1VwRZ4+y4LcIrSygvU5nZidbrXIMHLx/Gi3g7s9Or2K3ud+VSU9O8jlpZNsno28Fy1zvzrClnOv8dP2jVwB+iO4VmeI19pWHWQgZ/BAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a4V+EwI5; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a4V+EwI5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJJrh00scz2ypk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 12:40:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786329620; x=1817865620;
  h=date:from:to:cc:subject:message-id;
  bh=VEKxGoC5CTzBzRfYL6msYc9KJhdnw+g1YTrT8fQlQX8=;
  b=a4V+EwI5+jdSnzKcl2rD4bE8pheCsmBYjdHn8Oj7Als5qAMn3/DiiaQ8
   MKeXJi0qoIzAAnHbtkiHqWOu4ud0uF4xOLY9M7SkkqDZge256ZUNHsThJ
   QTJRZKPanQGjeuT5sEDH6Thg0dfQIJScbua8Kaj2O56clvFVzTWgZDFaK
   3ZJhosgvP9htWDn+S5stYeBxDjXaQ1Wz7KrYz4XZ7dfEVgGSnLSnO9lcB
   OAv8Mf82eqjC92Akrj4AeS9T45Y4c7h82P4+l97bv/KBw81MlqV54cqHL
   PgM+LL5EYGOIms/CLL6UU7QM2coRDf/SpHfaJggzJVtWlUAVO25+bQZYo
   w==;
X-CSE-ConnectionGUID: qupAoGDCSdGeqerttfLZzA==
X-CSE-MsgGUID: Uq9Tf55qRDqkX3CQkvMq8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85806555"
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="85806555"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 19:40:12 -0700
X-CSE-ConnectionGUID: 3nwLUzLuT4Gaorcfo/uoMQ==
X-CSE-MsgGUID: flZz5lMDQ36HsHvvOyGGVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="287621725"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Aug 2026 19:40:11 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wtFvs-00000000MbB-21PQ;
	Mon, 10 Aug 2026 02:40:08 +0000
Date: Mon, 10 Aug 2026 10:40:02 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes] BUILD SUCCESS
 fb442a6673ff1046bf67754957d95880fdb394b5
Message-ID: <202608101051.29NVBNam-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes
branch HEAD: fb442a6673ff1046bf67754957d95880fdb394b5  powerpc/pseries: lparcfg - fix kbuf[] underflow

elapsed time: 1506m

configs tested: 188
configs skipped: 2

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
openrisc                 or1klitex_defconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260809    gcc-8.5.0
parisc               randconfig-001-20260810    gcc-8.5.0
parisc               randconfig-002-20260809    gcc-8.5.0
parisc               randconfig-002-20260810    gcc-8.5.0
powerpc                     katmai_defconfig    clang-24
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
sh                   randconfig-001-20260809    clang-24
sh                   randconfig-001-20260810    gcc-8.5.0
sh                   randconfig-002-20260809    clang-24
sh                   randconfig-002-20260810    gcc-8.5.0
sh                          se7619_defconfig    gcc-16.1.0
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

