Return-Path: <linuxppc-dev+bounces-25773-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2FFC5AD5A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 12:03:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKnF85H0Nz3bpP;
	Wed, 12 Aug 2026 22:03:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786536188;
	cv=none; b=ZotV65UQQ9QKvccFUz3CrrGqWelllW6xZZ7pdQp75VzfH3qoYoYFhOa9bYqSILWspPagPomaRY3LMWa/I712KnXEeikBzNd3oTsqlNfgYLhhw0fe/7l9LyAe8gU7K7wLw9B2vSI94FALR7mnouIMIegm/FamrERqcKr95r0CQVJhUUJ5frtjQc9+zTHm+sG4He2XYxBUR0i0NtPwPRp5neDuSou91xxAT5hpEIkzwz7kco8JtdPwQk91DztfypM97bj5jwNdna191NKXlxUAwe6ibTGG316Ic2LMcHRktCddGyhcIiX92oaX5tQ4zrEvXiC706yplHncJWEm9X4sHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786536188; c=relaxed/relaxed;
	bh=K0F3biVK8FOPck5eh9m74yHUFAGK+/ev341tvNKB4CU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Yfic6BdGmFcvZszjggWnRrqZdFqW+TsHDPGYpIEMQ5U4PV3WP3qivh0C5Biluf5Q+TwPN1fgxT27Gzqcql8NVZbqQYLEqO6yhGJRlhDfayN2Yg2TtUvhKTzf8mowp5lJYMXT3OjRKb5U6T8QSS61/5MmO2eheYa5D/hfrNK4zD6OtoBBqukD9kq6VGFjzQMFnkVedSfUi3OwjW1g9hTrgeFUWE2SuSJM1uvR9S+7yfQp6QBQpgaIf0YzHdghcR9H1VHWQRQJwcXKlS33hBiJ/o7XBHw35ePo6f0jCfgVNT+wbdBGukG51VrzAUzeH0fiayxJpjNf4FSCbyOdGBrYZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DPNlED3U; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DPNlED3U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKnF44Dnhz303K
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 22:03:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786536185; x=1818072185;
  h=date:from:to:cc:subject:message-id;
  bh=UTuIeDL8O6VlM7hFl8UKW7juUZP0htrqMNIMLT900s8=;
  b=DPNlED3UdSjFgonud0HbcLZrAhryDaERPAj4EiL7nPt7wteu/5Bklpqr
   5fIgbMsqHL3ttE0AHizvbUZwtHk4p/zVHe4zJjp4EA4XxfG1aAQOkql4n
   JqsLGnWJovdr3LM6dxYhWoF8RQcHoro++qmDHbjWoZinsjCXPPyQv2zGi
   Rw5X2zgOEAnhzQnay2VFoxqZag5UGhMP9c2LGmvNR7rDzBzZ0xrL1A3Mi
   h5gs1xZNqPL4xt+Efp05xV9i9UHibWx35zl62IvuLY+NdQvZGb4tacOXm
   wH21Ev4jbz+l7qewCe7x283uL+WfZTmuLh1l7Xwvl6tMKVaXZSj9mXdse
   Q==;
X-CSE-ConnectionGUID: eNlKUYqpS7SpNn2zkUtV8A==
X-CSE-MsgGUID: P7oNdrIERRyALOu+Ri8YLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87300762"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="87300762"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 05:02:58 -0700
X-CSE-ConnectionGUID: FS7fqkQLQpSqrEwIyqkudw==
X-CSE-MsgGUID: w08e7PKDQ+GnIPfXneyvMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267127179"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Aug 2026 05:02:57 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wu7fa-00000000Qb4-3HcD;
	Wed, 12 Aug 2026 12:02:54 +0000
Date: Wed, 12 Aug 2026 20:02:08 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 1304643a1c20badbb91b86a5084dd76cb7620c05
Message-ID: <202608122057.FJabCbzB-lkp@intel.com>
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
branch HEAD: 1304643a1c20badbb91b86a5084dd76cb7620c05  powerpc/pseries/iommu: switch to Default DMA window during kdump

elapsed time: 1552m

configs tested: 114
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-12.5.0
arc                  randconfig-001-20260812    gcc-12.5.0
arc                  randconfig-002-20260812    gcc-12.5.0
arm                    am200epdkit_defconfig    gcc-16.1.0
arm                  randconfig-001-20260812    gcc-12.5.0
arm                  randconfig-002-20260812    gcc-12.5.0
arm                  randconfig-003-20260812    gcc-12.5.0
arm                  randconfig-004-20260812    gcc-12.5.0
arm                        vf610m4_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260812    gcc-10.5.0
arm64                randconfig-001-20260812    gcc-14.3.0
arm64                randconfig-002-20260812    gcc-10.5.0
arm64                randconfig-002-20260812    gcc-14.3.0
arm64                randconfig-003-20260812    gcc-10.5.0
arm64                randconfig-003-20260812    gcc-14.3.0
arm64                randconfig-004-20260812    gcc-10.5.0
arm64                randconfig-004-20260812    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260812    gcc-10.5.0
csky                 randconfig-001-20260812    gcc-14.3.0
csky                 randconfig-002-20260812    gcc-10.5.0
csky                 randconfig-002-20260812    gcc-14.3.0
hexagon              randconfig-001-20260812    gcc-11.5.0
hexagon              randconfig-002-20260812    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260812    clang-22
i386       buildonly-randconfig-002-20260812    clang-22
i386       buildonly-randconfig-003-20260812    clang-22
i386       buildonly-randconfig-004-20260812    clang-22
i386       buildonly-randconfig-005-20260812    clang-22
i386       buildonly-randconfig-006-20260812    clang-22
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260812    clang-22
i386                 randconfig-002-20260812    clang-22
i386                 randconfig-003-20260812    clang-22
i386                 randconfig-004-20260812    clang-22
i386                 randconfig-005-20260812    clang-22
i386                 randconfig-006-20260812    clang-22
i386                 randconfig-007-20260812    clang-22
i386                 randconfig-011-20260812    gcc-12
i386                 randconfig-012-20260812    gcc-12
i386                 randconfig-013-20260812    gcc-12
i386                 randconfig-014-20260812    gcc-12
i386                 randconfig-015-20260812    gcc-12
i386                 randconfig-016-20260812    gcc-12
i386                 randconfig-017-20260812    gcc-12
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260812    gcc-11.5.0
loongarch            randconfig-002-20260812    gcc-11.5.0
mips                    cu1000-neo_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260812    gcc-11.5.0
nios2                randconfig-002-20260812    gcc-11.5.0
openrisc        de0_nano_multicore_defconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260812    clang-17
parisc               randconfig-002-20260812    clang-17
powerpc              randconfig-001-20260812    clang-17
powerpc              randconfig-002-20260812    clang-17
powerpc64            randconfig-001-20260812    clang-17
powerpc64            randconfig-002-20260812    clang-17
riscv                         randconfig-001    clang-24
riscv                randconfig-001-20260812    clang-24
riscv                randconfig-002-20260812    clang-24
s390                 randconfig-001-20260812    clang-24
s390                 randconfig-002-20260812    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260812    clang-24
sh                   randconfig-002-20260812    clang-24
sparc                randconfig-001-20260812    gcc-13.4.0
sparc                randconfig-002-20260812    gcc-13.4.0
sparc64              randconfig-001-20260812    gcc-13.4.0
sparc64              randconfig-002-20260812    gcc-13.4.0
um                   randconfig-001-20260812    gcc-13.4.0
um                   randconfig-002-20260812    gcc-13.4.0
x86_64     buildonly-randconfig-001-20260812    gcc-14
x86_64     buildonly-randconfig-002-20260812    gcc-14
x86_64     buildonly-randconfig-003-20260812    gcc-14
x86_64     buildonly-randconfig-004-20260812    gcc-14
x86_64     buildonly-randconfig-005-20260812    gcc-14
x86_64     buildonly-randconfig-006-20260812    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260812    clang-22
x86_64               randconfig-002-20260812    clang-22
x86_64               randconfig-003-20260812    clang-22
x86_64               randconfig-004-20260812    clang-22
x86_64               randconfig-005-20260812    clang-22
x86_64               randconfig-006-20260812    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260812    clang-22
x86_64               randconfig-012-20260812    clang-22
x86_64               randconfig-013-20260812    clang-22
x86_64               randconfig-014-20260812    clang-22
x86_64               randconfig-015-20260812    clang-22
x86_64               randconfig-016-20260812    clang-22
x86_64                        randconfig-071    clang-22
x86_64               randconfig-071-20260812    clang-22
x86_64               randconfig-072-20260812    clang-22
x86_64               randconfig-073-20260812    clang-22
x86_64               randconfig-074-20260812    clang-22
x86_64               randconfig-075-20260812    clang-22
x86_64               randconfig-076-20260812    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260812    gcc-13.4.0
xtensa               randconfig-002-20260812    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

