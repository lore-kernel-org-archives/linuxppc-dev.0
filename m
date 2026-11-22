Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DE606A32A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jiZf2AFt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXPW4657vz2xdY;
	Sun, 22 Nov 2026 20:52:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795341136;
	cv=none; b=Vtb3uFaZfXh708M89exG6scG5eGMtxhbFZOjIbCySFJhoCGyOZU/Z67a7zik+hECqcAZFGmDsj3vD8JQbV2K3Q/KLmCDck5kkdV6fbzLoEUuHnTEnV8qYiylZclMLbuCkIP22g5Sw3Tr5Nd6GBahri2+JOyGS7nLrsq0IR6ic3/UXQOlbdQGm1fo8C2j+egXYuiiCwp+xxcerd16qpZOjpmLo0v2Nhsa5uctxcqQXn7b5rs4LtF8I8zkc2GRcBvD1xtkq9eELlT2Di8DeLIlnnmJWo43/L1basGvuH6zrHu6TIu1XuLYASpcYBlyBGT21/zy5yJprgngG6gzCMpUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795341136; c=relaxed/relaxed;
	bh=uuOy3iab6jz+6J77GB9YH14JTK/fX8SGRfjureKNkmU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XY+Xy8IQtIMkX5vubpcgKBo5Vp7TcyETNbK4xXJJOsqqxv0X/OWdEEwhDbiXsjoROc6T9ZtKrSaOCagAssEgw4+T6TWo4ITEhZs4JCjMdu74vxSUY15oxuYsGoIIGFUf3hLE+52jrxuZPeb3qmnEgAFzElVUncSWCpCSfNoI+0VDOFVpu6hGQLTnVKLyqdhuoptis2epUOK6jaJnky9pw/bEm/9w0huw87vt6u50ffqEtebD3354KU8fU+wky7ReG1jJgRcO/jPHPP3l+WVC7oSFJwbYdCYkUe1BOaxP0x+CV4XYhLd0K+8LOr/Sn7o7QgkEH8OLjHovk7N7y4QElQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jiZf2AFt; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jiZf2AFt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXPW15P1rz2xLr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 20:52:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795341135; x=1826877135;
  h=date:from:to:cc:subject:message-id;
  bh=9nGsPHwO+J2cG21I/Kaptg7004jSC2n+6cKao/qPpEc=;
  b=jiZf2AFtSwAfNFUzkq2nNQtK4/1uMQt7Khq3+85J3uuRmTkPsQGK6Imc
   8k7/n53TAN7qOPyI0lwSJqnOxtLYXZydkf0cMCF2B0OB5VtvDzhZ5FpSt
   trwRmvyW7Fty1gyh8+lgbgGp2xU5JNSznqItlXWzIQyY2bjSQkPymSGCy
   KrIRuk0pv+FwdCMWSrurgI1MMN37oKO0quzuNWCzynz7A2qhN255hGcdF
   TDRoOms6aKARopnufwLdfDu+chHsspoBI2cdNoHDWQoYL1CK8kegRyCYO
   FaCrd8MDtDy8B8TZqAfkU72hIn5YPtuAjUkyvP+PkFpjF1JnL03GqxKJ9
   Q==;
X-CSE-ConnectionGUID: cGUlicIeTTahivy4fIz81g==
X-CSE-MsgGUID: 5SOeQFfiQB6ebKg4cRSU1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4077191"
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="4077191"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 01:52:07 -0800
X-CSE-ConnectionGUID: p/dMM0iPSTGvx1j4pbUvPg==
X-CSE-MsgGUID: PbMA7Sb7RcyWrFKFV2vk9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="10953243"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Nov 2026 01:52:05 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xV4Es-00000001LJS-3FCs;
	Sun, 22 Nov 2026 09:52:02 +0000
Date: Sun, 22 Nov 2026 17:51:03 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes] BUILD SUCCESS
 bd6d2f87c2239d10bf5f37ab52b3968565528417
Message-ID: <20261122175103.xMevPA56-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes
branch HEAD: bd6d2f87c2239d10bf5f37ab52b3968565528417  KVM: PPC: Fix TOCTOU kernel stack disclosure via kvm_run->mmio.len

elapsed time: 773m

configs tested: 487
configs skipped: 263

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261121    gcc-14.4.0
alpha                 randconfig-2001-20261121    gcc-14.4.0
alpha                 randconfig-2200-20261121    gcc-10.5.0 smatch
alpha                randconfig-r2100-20261121    gcc-16.2.0 cocci
alpha                randconfig-r2100-20261121    gcc-8.5.0  cocci
alpha                randconfig-r2110-20261121    gcc-11.5.0 cocci
alpha                randconfig-r2111-20261121    gcc-13.5.0 cocci
alpha                randconfig-r2302-20261121    gcc-8.5.0  sparse
alpha                randconfig-r2304-20261122    clang-24   sparse
alpha                randconfig-r2309-20261121    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261122    clang-17
arc                   randconfig-1001-20261122    clang-17
arc                   randconfig-2000-20261121    gcc-8.5.0
arc                   randconfig-2001-20261121    gcc-8.5.0
arc                   randconfig-2002-20261121    gcc-8.5.0
arc                   randconfig-2003-20261121    gcc-8.5.0
arc                   randconfig-2004-20261121    gcc-8.5.0
arc                   randconfig-2005-20261121    gcc-8.5.0
arc                   randconfig-2200-20261121    gcc-14.4.0 smatch
arc                  randconfig-r2111-20261121    gcc-14.4.0 cocci
arc                  randconfig-r2302-20261121    gcc-13.5.0 sparse
arc                  randconfig-r2303-20261121    gcc-13.5.0 sparse
arc                  randconfig-r2306-20261121    clang-18   sparse
arc                  randconfig-r2307-20261121    clang-22   sparse
arc                  randconfig-r2310-20261121    gcc-10.5.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                        multi_v4t_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261122    clang-17
arm                   randconfig-1001-20261122    clang-17
arm                   randconfig-1002-20261122    clang-17
arm                   randconfig-1003-20261122    clang-17
arm                   randconfig-2000-20261121    clang-24
arm                   randconfig-2001-20261121    clang-24
arm                   randconfig-2002-20261121    clang-24
arm                   randconfig-2200-20261121    clang-19   smatch
arm                  randconfig-r2103-20261121    gcc-8.5.0  cocci
arm                  randconfig-r2106-20261121    clang-24   cocci
arm                  randconfig-r2106-20261121    gcc-11.5.0 cocci
arm                  randconfig-r2108-20261121    clang-18   cocci
arm                  randconfig-r2108-20261121    clang-20   cocci
arm                  randconfig-r2108-20261121    gcc-16.2.0 cocci
arm                  randconfig-r2300-20261121    clang-24   sparse
arm                  randconfig-r2304-20261121    gcc-8.5.0  sparse
arm                  randconfig-r2305-20261121    gcc-8.5.0  sparse
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261122    gcc-8.5.0
arm64                 randconfig-1001-20261122    gcc-8.5.0
arm64                 randconfig-1002-20261122    gcc-8.5.0
arm64                 randconfig-1003-20261122    gcc-8.5.0
arm64                 randconfig-2000-20261121    clang-24
arm64                 randconfig-2001-20261121    clang-24
arm64                 randconfig-2002-20261121    clang-24
arm64                 randconfig-2200-20261121    clang-22   smatch
arm64                randconfig-r2100-20261121    gcc-15.3.0 cocci
arm64                randconfig-r2104-20261121    gcc-15.3.0 cocci
arm64                randconfig-r2105-20261121    gcc-16.2.0 cocci
arm64                randconfig-r2105-20261121    gcc-8.5.0  cocci
arm64                randconfig-r2110-20261121    clang-17   cocci
arm64                randconfig-r2111-20261121    clang-24   cocci
arm64                randconfig-r2300-20261121    gcc-14.4.0 sparse
arm64                randconfig-r2301-20261121    clang-24   sparse
arm64                randconfig-r2301-20261121    gcc-11.5.0 sparse
arm64                randconfig-r2305-20261121    clang-24   sparse
arm64                randconfig-r2307-20261121    gcc-10.5.0 sparse
arm64                randconfig-r2308-20261121    gcc-11.5.0 sparse
arm64                randconfig-r2310-20261121    clang-22   sparse
arm64                randconfig-r2310-20261121    gcc-14     sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261122    gcc-8.5.0
csky                  randconfig-1001-20261122    gcc-8.5.0
csky                  randconfig-2000-20261121    gcc-16.2.0
csky                  randconfig-2001-20261121    gcc-16.2.0
csky                  randconfig-2200-20261121    gcc-16.2.0 smatch
csky                 randconfig-r2100-20261121    gcc-10.5.0 cocci
csky                 randconfig-r2101-20261121    gcc-16.2.0 cocci
csky                 randconfig-r2101-20261121    gcc-8.5.0  cocci
csky                 randconfig-r2105-20261121    gcc-16.2.0 cocci
csky                 randconfig-r2109-20261121    gcc-13.5.0 cocci
csky                 randconfig-r2300-20261121    clang-24   sparse
csky                 randconfig-r2306-20261121    clang-22   sparse
csky                 randconfig-r2306-20261121    gcc-10.5.0 sparse
csky                 randconfig-r2307-20261121    gcc-11.5.0 sparse
csky                 randconfig-r2310-20261121    gcc-12.5.0 sparse
csky                 randconfig-r2311-20261121    clang-18   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261122    gcc-8.5.0
hexagon               randconfig-1001-20261122    gcc-8.5.0
hexagon               randconfig-2000-20261121    gcc-16.2.0
hexagon               randconfig-2001-20261121    gcc-16.2.0
hexagon               randconfig-2200-20261121    clang-24   smatch
hexagon              randconfig-r2102-20261121    gcc-15.3.0 cocci
hexagon              randconfig-r2102-20261121    gcc-16.2.0 cocci
hexagon              randconfig-r2102-20261121    gcc-8.5.0  cocci
hexagon              randconfig-r2103-20261121    gcc-15.3.0 cocci
hexagon              randconfig-r2104-20261121    gcc-16.2.0 cocci
hexagon              randconfig-r2108-20261121    gcc-14.4.0 cocci
hexagon              randconfig-r2305-20261121    clang-24   sparse
hexagon              randconfig-r2305-20261121    gcc-14.4.0 sparse
hexagon              randconfig-r2308-20261121    clang-22   sparse
hexagon              randconfig-r2309-20261121    clang-20   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261122    gcc-14
i386        buildonly-randconfig-1001-20261122    gcc-14
i386        buildonly-randconfig-1002-20261122    gcc-14
i386        buildonly-randconfig-1003-20261122    gcc-14
i386        buildonly-randconfig-1004-20261122    gcc-14
i386        buildonly-randconfig-1005-20261122    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261122    gcc-14
i386                  randconfig-1001-20261122    gcc-14
i386                  randconfig-1002-20261122    gcc-14
i386                  randconfig-1003-20261122    gcc-14
i386                  randconfig-1004-20261122    gcc-14
i386                  randconfig-1005-20261122    gcc-14
i386                  randconfig-1006-20261122    gcc-14
i386                  randconfig-1007-20261122    gcc-14
i386                  randconfig-1008-20261122    gcc-14
i386                  randconfig-1009-20261122    gcc-14
i386                  randconfig-1010-20261122    gcc-14
i386                  randconfig-1011-20261122    gcc-14
i386                  randconfig-1012-20261122    gcc-14
i386                  randconfig-1013-20261122    gcc-14
i386                  randconfig-2000-20261121    gcc-14
i386                  randconfig-2001-20261121    gcc-14
i386                  randconfig-2002-20261121    gcc-14
i386                  randconfig-2003-20261121    gcc-14
i386                  randconfig-2004-20261121    gcc-14
i386                  randconfig-2005-20261121    gcc-14
i386                  randconfig-2100-20261121    clang-22   cocci
i386                  randconfig-2101-20261121    clang-22   cocci
i386                  randconfig-2102-20261121    clang-22   cocci
i386                  randconfig-2103-20261121    clang-22   cocci
i386                  randconfig-2104-20261121    clang-22   cocci
i386                  randconfig-2105-20261121    clang-22   cocci
i386                  randconfig-2200-20261121    clang-22   smatch
i386                  randconfig-2300-20261121    gcc-14     sparse
i386                  randconfig-2301-20261121    gcc-14     sparse
i386                  randconfig-2302-20261121    gcc-14     sparse
i386                 randconfig-r2103-20261121    gcc-10.5.0 cocci
i386                 randconfig-r2111-20261121    clang-20   cocci
i386                 randconfig-r2300-20261121    gcc-8.5.0  sparse
i386                 randconfig-r2311-20261121    gcc-10.5.0 sparse
i386                 randconfig-r2311-20261121    gcc-11.5.0 sparse
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261122    gcc-8.5.0
loongarch             randconfig-1001-20261122    gcc-8.5.0
loongarch             randconfig-2000-20261121    clang-22
loongarch             randconfig-2001-20261121    clang-22
loongarch             randconfig-2200-20261121    gcc-16.2.0 smatch
loongarch            randconfig-r2100-20261121    gcc-8.5.0  cocci
loongarch            randconfig-r2102-20261121    gcc-16.2.0 cocci
loongarch            randconfig-r2111-20261121    gcc-16.2.0 cocci
loongarch            randconfig-r2301-20261121    gcc-14.4.0 sparse
loongarch            randconfig-r2302-20261121    clang-24   sparse
loongarch            randconfig-r2306-20261121    clang-20   sparse
loongarch            randconfig-r2311-20261121    clang-22   sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                  randconfig-2000-20261121    gcc-14.4.0
m68k                  randconfig-2001-20261121    gcc-14.4.0
m68k                  randconfig-2200-20261121    gcc-8.5.0  smatch
m68k                 randconfig-r2105-20261121    gcc-8.5.0  cocci
m68k                 randconfig-r2107-20261121    clang-24   cocci
m68k                 randconfig-r2107-20261121    gcc-8.5.0  cocci
m68k                 randconfig-r2111-20261121    gcc-11.5.0 cocci
m68k                 randconfig-r2303-20261121    gcc-14.4.0 sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261121    gcc-14.4.0
microblaze            randconfig-2001-20261121    gcc-14.4.0
microblaze            randconfig-2200-20261121    gcc-8.5.0  smatch
microblaze           randconfig-r2101-20261121    gcc-16.2.0 cocci
microblaze           randconfig-r2102-20261121    gcc-10.5.0 cocci
microblaze           randconfig-r2105-20261121    gcc-10.5.0 cocci
microblaze           randconfig-r2105-20261121    gcc-15.3.0 cocci
microblaze           randconfig-r2106-20261121    clang-20   cocci
microblaze           randconfig-r2107-20261121    clang-17   cocci
microblaze           randconfig-r2107-20261121    gcc-16.2.0 cocci
microblaze           randconfig-r2109-20261121    gcc-11.5.0 cocci
microblaze           randconfig-r2304-20261121    gcc-13.5.0 sparse
microblaze           randconfig-r2304-20261121    gcc-14.4.0 sparse
microblaze           randconfig-r2311-20261121    clang-20   sparse
microblaze           randconfig-r2311-20261121    gcc-11.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                         bcm47xx_defconfig    gcc-16.2.0
mips                           eyeq5_defconfig    gcc-16.2.0
mips                       fuloong2e_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261121    gcc-16.2.0
mips                  randconfig-2001-20261121    gcc-16.2.0
mips                  randconfig-2002-20261121    gcc-16.2.0
mips                  randconfig-2200-20261121    clang-21   smatch
mips                 randconfig-r2100-20261121    gcc-8.5.0  cocci
mips                 randconfig-r2109-20261121    clang-17   cocci
mips                 randconfig-r2109-20261121    clang-18   cocci
mips                 randconfig-r2109-20261121    clang-24   cocci
mips                 randconfig-r2110-20261121    gcc-14.4.0 cocci
mips                 randconfig-r2110-20261121    gcc-16.2.0 cocci
mips                 randconfig-r2111-20261121    gcc-8.5.0  cocci
mips                 randconfig-r2308-20261121    clang-20   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261122    gcc-8.5.0
nios2                 randconfig-1001-20261122    gcc-8.5.0
nios2                 randconfig-2000-20261121    clang-22
nios2                 randconfig-2001-20261121    clang-22
nios2                 randconfig-2200-20261121    gcc-10.5.0 smatch
nios2                randconfig-r2101-20261121    gcc-8.5.0  cocci
nios2                randconfig-r2104-20261121    gcc-10.5.0 cocci
nios2                randconfig-r2106-20261121    clang-17   cocci
nios2                randconfig-r2106-20261121    gcc-13.5.0 cocci
nios2                randconfig-r2108-20261121    gcc-11.5.0 cocci
nios2                randconfig-r2111-20261121    clang-17   cocci
nios2                randconfig-r2303-20261121    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261121    gcc-16.2.0
openrisc              randconfig-2001-20261121    gcc-16.2.0
openrisc              randconfig-2002-20261121    gcc-16.2.0
openrisc              randconfig-2200-20261121    gcc-14.4.0 smatch
openrisc             randconfig-r2102-20261121    gcc-8.5.0  cocci
openrisc             randconfig-r2104-20261121    gcc-8.5.0  cocci
openrisc             randconfig-r2106-20261121    clang-18   cocci
openrisc             randconfig-r2106-20261121    gcc-8.5.0  cocci
openrisc             randconfig-r2109-20261121    gcc-16.2.0 cocci
openrisc             randconfig-r2111-20261121    clang-18   cocci
openrisc             randconfig-r2302-20261121    gcc-11.5.0 sparse
openrisc             randconfig-r2302-20261122    clang-24   sparse
openrisc             randconfig-r2303-20261121    gcc-11.5.0 sparse
openrisc             randconfig-r2306-20261121    clang-22   sparse
openrisc             randconfig-r2308-20261121    gcc-10.5.0 sparse
openrisc             randconfig-r2309-20261121    gcc-14     sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261122    clang-24
parisc                randconfig-1001-20261122    clang-24
parisc                randconfig-2000-20261121    clang-22
parisc                randconfig-2001-20261121    clang-22
parisc                randconfig-2200-20261121    gcc-16.2.0 smatch
parisc               randconfig-r2101-20261121    gcc-10.5.0 cocci
parisc               randconfig-r2103-20261121    gcc-16.2.0 cocci
parisc               randconfig-r2103-20261121    gcc-8.5.0  cocci
parisc               randconfig-r2107-20261121    clang-18   cocci
parisc               randconfig-r2107-20261121    gcc-13.5.0 cocci
parisc               randconfig-r2300-20261121    gcc-11.5.0 sparse
parisc               randconfig-r2304-20261121    clang-24   sparse
parisc               randconfig-r2306-20261121    gcc-11.5.0 sparse
parisc               randconfig-r2308-20261121    gcc-12.5.0 sparse
parisc               randconfig-r2309-20261121    clang-22   sparse
parisc               randconfig-r2311-20261121    gcc-14     sparse
parisc64                             defconfig    clang-24
powerpc                      akebono_defconfig    gcc-16.2.0
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                    bluestone_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261122    clang-24
powerpc               randconfig-1001-20261122    clang-24
powerpc               randconfig-2000-20261121    clang-24
powerpc               randconfig-2001-20261121    clang-24
powerpc               randconfig-2001-20261121    gcc-15.3.0
powerpc               randconfig-2002-20261121    clang-24
powerpc               randconfig-2200-20261121    gcc-11.5.0 smatch
powerpc              randconfig-r2103-20261121    gcc-8.5.0  cocci
powerpc              randconfig-r2107-20261121    gcc-11.5.0 cocci
powerpc              randconfig-r2301-20261121    clang-24   sparse
powerpc              randconfig-r2301-20261122    clang-24   sparse
powerpc              randconfig-r2303-20261122    clang-24   sparse
powerpc              randconfig-r2305-20261121    gcc-11.5.0 sparse
powerpc              randconfig-r2305-20261122    clang-24   sparse
powerpc              randconfig-r2309-20261121    clang-18   sparse
powerpc              randconfig-r2309-20261121    gcc-10.5.0 sparse
powerpc              randconfig-r2310-20261121    clang-18   sparse
powerpc              randconfig-r2310-20261121    gcc-11.5.0 sparse
powerpc64             randconfig-1000-20261122    clang-24
powerpc64             randconfig-1001-20261122    clang-24
powerpc64             randconfig-2000-20261121    clang-24
powerpc64             randconfig-2001-20261121    clang-24
powerpc64             randconfig-2001-20261121    gcc-10.5.0
powerpc64             randconfig-2002-20261121    clang-24
powerpc64             randconfig-2002-20261121    gcc-8.5.0
powerpc64             randconfig-2200-20261121    gcc-10.5.0 smatch
powerpc64            randconfig-r2102-20261121    gcc-8.5.0  cocci
powerpc64            randconfig-r2106-20261121    gcc-16.2.0 cocci
powerpc64            randconfig-r2109-20261121    gcc-14.4.0 cocci
powerpc64            randconfig-r2303-20261121    gcc-8.5.0  sparse
powerpc64            randconfig-r2304-20261121    gcc-11.5.0 sparse
powerpc64            randconfig-r2307-20261121    gcc-12.5.0 sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261122    gcc-9.5.0
riscv                 randconfig-1001-20261122    gcc-9.5.0
riscv                 randconfig-2000-20261121    gcc-9.5.0
riscv                 randconfig-2001-20261121    gcc-9.5.0
riscv                 randconfig-2002-20261121    gcc-9.5.0
riscv                 randconfig-2003-20261121    gcc-9.5.0
riscv                 randconfig-2004-20261121    gcc-9.5.0
riscv                 randconfig-2005-20261121    gcc-9.5.0
riscv                 randconfig-2200-20261121    clang-24   smatch
riscv                randconfig-r2108-20261121    clang-24   cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261122    gcc-9.5.0
s390                  randconfig-1001-20261122    gcc-9.5.0
s390                  randconfig-2000-20261121    clang-22
s390                  randconfig-2001-20261121    clang-22
s390                  randconfig-2002-20261121    clang-22
s390                  randconfig-2003-20261121    clang-22
s390                  randconfig-2004-20261121    clang-22
s390                  randconfig-2005-20261121    clang-22
s390                  randconfig-2200-20261121    gcc-8.5.0  smatch
s390                 randconfig-r2101-20261121    gcc-15.3.0 cocci
s390                 randconfig-r2106-20261121    gcc-14.4.0 cocci
s390                 randconfig-r2107-20261121    clang-20   cocci
s390                 randconfig-r2108-20261121    clang-17   cocci
s390                 randconfig-r2110-20261121    clang-20   cocci
s390                 randconfig-r2110-20261121    gcc-13.5.0 cocci
s390                 randconfig-r2302-20261121    gcc-14.4.0 sparse
s390                 randconfig-r2303-20261121    clang-24   sparse
s390                 randconfig-r2306-20261121    gcc-11.5.0 sparse
s390                 randconfig-r2307-20261121    clang-18   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261122    gcc-9.5.0
sh                    randconfig-1001-20261122    gcc-9.5.0
sh                    randconfig-2000-20261121    gcc-16.2.0
sh                    randconfig-2001-20261121    gcc-16.2.0
sh                    randconfig-2002-20261121    gcc-16.2.0
sh                    randconfig-2003-20261121    gcc-16.2.0
sh                    randconfig-2004-20261121    gcc-16.2.0
sh                    randconfig-2005-20261121    gcc-16.2.0
sh                    randconfig-2200-20261121    gcc-10.5.0 smatch
sh                   randconfig-r2101-20261121    gcc-8.5.0  cocci
sh                   randconfig-r2104-20261121    gcc-8.5.0  cocci
sh                   randconfig-r2110-20261121    clang-24   cocci
sh                   randconfig-r2306-20261121    gcc-14     sparse
sh                   randconfig-r2307-20261121    gcc-11.5.0 sparse
sh                   randconfig-r2308-20261121    clang-22   sparse
sh                           rsk7203_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261122    clang-24
sparc                 randconfig-1001-20261122    clang-24
sparc                 randconfig-2000-20261121    gcc-8.5.0
sparc                 randconfig-2001-20261121    gcc-8.5.0
sparc                 randconfig-2200-20261121    gcc-8.5.0  smatch
sparc                randconfig-r2100-20261121    gcc-16.2.0 cocci
sparc                randconfig-r2105-20261121    gcc-8.5.0  cocci
sparc                randconfig-r2107-20261121    gcc-14.4.0 cocci
sparc                randconfig-r2109-20261121    gcc-8.5.0  cocci
sparc                randconfig-r2110-20261121    clang-18   cocci
sparc                randconfig-r2301-20261121    gcc-11.5.0 sparse
sparc                randconfig-r2304-20261121    clang-24   sparse
sparc                randconfig-r2305-20261121    gcc-13.5.0 sparse
sparc                randconfig-r2308-20261121    clang-18   sparse
sparc                randconfig-r2310-20261121    clang-20   sparse
sparc                randconfig-r2310-20261121    gcc-11.5.0 sparse
sparc                randconfig-r2311-20261121    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261122    clang-24
sparc64               randconfig-1001-20261122    clang-24
sparc64               randconfig-2000-20261121    gcc-8.5.0
sparc64               randconfig-2001-20261121    gcc-8.5.0
sparc64               randconfig-2200-20261121    clang-20   smatch
sparc64              randconfig-r2108-20261121    gcc-8.5.0  cocci
sparc64              randconfig-r2109-20261121    clang-20   cocci
sparc64              randconfig-r2300-20261122    clang-24   sparse
sparc64              randconfig-r2301-20261121    gcc-8.5.0  sparse
sparc64              randconfig-r2302-20261121    clang-24   sparse
sparc64              randconfig-r2302-20261121    gcc-11.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261122    clang-24
um                    randconfig-1001-20261122    clang-24
um                    randconfig-2000-20261121    gcc-8.5.0
um                    randconfig-2001-20261121    gcc-8.5.0
um                    randconfig-2200-20261121    gcc-14     smatch
um                   randconfig-r2108-20261121    gcc-13.5.0 cocci
um                   randconfig-r2307-20261121    clang-22   sparse
um                   randconfig-r2307-20261121    gcc-14     sparse
um                   randconfig-r2308-20261121    gcc-11.5.0 sparse
um                   randconfig-r2309-20261121    gcc-12.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261122    gcc-14
x86_64                randconfig-1001-20261122    gcc-14
x86_64                randconfig-1002-20261122    gcc-14
x86_64                randconfig-1003-20261122    gcc-14
x86_64                randconfig-1004-20261122    gcc-14
x86_64                randconfig-1005-20261122    gcc-14
x86_64                randconfig-1006-20261122    gcc-14
x86_64                randconfig-1007-20261122    gcc-14
x86_64                randconfig-1008-20261122    gcc-14
x86_64                randconfig-1009-20261122    gcc-14
x86_64                randconfig-1010-20261122    gcc-14
x86_64                randconfig-1011-20261122    gcc-14
x86_64                randconfig-1012-20261122    clang-22
x86_64                randconfig-1013-20261122    clang-22
x86_64                randconfig-1014-20261122    clang-22
x86_64                randconfig-1015-20261122    clang-22
x86_64                randconfig-1016-20261122    clang-22
x86_64                randconfig-1017-20261122    clang-22
x86_64                randconfig-2000-20261121    gcc-14
x86_64                randconfig-2001-20261121    gcc-14
x86_64                randconfig-2002-20261121    gcc-14
x86_64                randconfig-2003-20261121    gcc-14
x86_64                randconfig-2004-20261121    gcc-14
x86_64                randconfig-2005-20261121    gcc-14
x86_64                randconfig-2100-20261121    gcc-14     cocci
x86_64                randconfig-2101-20261121    gcc-14     cocci
x86_64                randconfig-2102-20261121    gcc-14     cocci
x86_64                randconfig-2103-20261121    gcc-14     cocci
x86_64                randconfig-2104-20261121    gcc-14     cocci
x86_64                randconfig-2105-20261121    gcc-14     cocci
x86_64                randconfig-2200-20261121    gcc-14     smatch
x86_64                randconfig-2300-20261121    gcc-14     sparse
x86_64                randconfig-2301-20261121    gcc-14     sparse
x86_64                randconfig-2302-20261121    gcc-14     sparse
x86_64               randconfig-r2103-20261121    gcc-16.2.0 cocci
x86_64               randconfig-r2110-20261121    gcc-8.5.0  cocci
x86_64               randconfig-r2300-20261121    gcc-11.5.0 sparse
x86_64               randconfig-r2303-20261121    clang-24   sparse
x86_64               randconfig-r2306-20261121    gcc-12.5.0 sparse
x86_64               randconfig-r2307-20261121    clang-20   sparse
x86_64               randconfig-r2308-20261121    gcc-14     sparse
x86_64               randconfig-r2309-20261121    clang-22   sparse
x86_64               randconfig-r2310-20261121    clang-22   sparse
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
xtensa                randconfig-1000-20261122    clang-24
xtensa                randconfig-1001-20261122    clang-24
xtensa                randconfig-2000-20261121    gcc-16.2.0
xtensa                randconfig-2001-20261121    gcc-16.2.0
xtensa                randconfig-2200-20261121    gcc-12.5.0 smatch
xtensa               randconfig-r2300-20261121    gcc-13.5.0 sparse
xtensa               randconfig-r2301-20261121    gcc-13.5.0 sparse
xtensa               randconfig-r2304-20261121    gcc-11.5.0 sparse
xtensa               randconfig-r2305-20261121    gcc-11.5.0 sparse
xtensa               randconfig-r2311-20261121    clang-22   sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

