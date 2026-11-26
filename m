Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DE606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dsWzQIdN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZs8C1fScz2xl0;
	Thu, 26 Nov 2026 20:44:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795686267;
	cv=none; b=OQvCDptw7SEJxNCG9l3o494yQec5dq22vAlP/L7SKCC/Xl62q4ZCJouIufjFgRyabPdz+7s9ArGHho3fmEyQB8LhcKFCG7qRm7UyfE51jIkv2m5j+hq9U6kwA8wYk9w3CD1rCqjktSF8u6CnsXgAgNg7zMGd3yVLtYsuGvRaZ81HJKltio8RIUacAfRPoTt2fi5wx1A8VneAzw8EhpdYoPI3K8BhqeFj4lImTrnHCH5hGkFdoAuPcSXqr8aVHyiOKnzm6io1WGAiHXkODTMm1i0suTKeQuQojkYNM0QKzNuelTMwITUhpRmddF3meXd6OZGk5KOYz9K5fXEsNDBKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795686267; c=relaxed/relaxed;
	bh=w31dTTlNHtQ7iCu3qbYffSsu98yCBWF03bUy1RSjxFg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HnBV4b4Mm54AxQh7GaYwNizuZtdo4Sb2M8h4XIVYRbBSAhspW1b9t7FJz5NYjca5yG790DEqtUD1lbgSNtBhEfCTRudc1cB2rPJ+zO9xswBH+COTnqo6jb9NxMUz6bj20Uj9TlpkPc/gwSDt5zC4YBBF2rpZGfIkG02BeByjO+mNRPwQ1rqGKnEBpOg/RGDMKYrvEQMCbAPx9/pskmfTAR4bz/GIvaa2ScUUBEGmy+ylLYhtgA0U0E3PFM3DNf8msf0u0QqWrRvi0rYMGl9RiaTDhzEZTerBdo2bxqZQfFDCCeRQoEQsppqMUL2L91O4zcji363RQ6jVgK5vyelkcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dsWzQIdN; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dsWzQIdN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZs880vBzz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 20:44:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795686265; x=1827222265;
  h=date:from:to:cc:subject:message-id;
  bh=uYCwArAqA0ZeD63+GXehgdcQNVDpd4voVCL+qR1s91E=;
  b=dsWzQIdNXgPQu45MY5OJXefNDrRqApCtJ+xT9i8WXE65UA0wrkb0K6Hz
   OtdgieZpn23oFj4HH+Oqv+WZw/qWANnQn2n06v+ezo60hgBQGvXsXwSD9
   jMgG6dsy8VnhpFgS36cndh6UJx2LqFV667K12nYTDUV6Gs03FFysVkucf
   QZMGxb4sFqjPT7LEcv6n/h4Vbz2yrPQZd3it/WEBsXrcEbMErelvArB+Z
   E3ZzTcC1PqMDyh6j7Q9odTkY+hCzvilBvjvNgp3R84EQ7cP2726Z67zbE
   97/fe0dFc1/FMuWQJjL4vXNgg8hpct7LnrpxMzi3c9vl1PDCKe6V3Yu97
   A==;
X-CSE-ConnectionGUID: VEQpmOltSUeiXR4h/wnF4g==
X-CSE-MsgGUID: 1wQ99zklRSWabH980LAXEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4496814"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4496814"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 01:44:18 -0800
X-CSE-ConnectionGUID: uytqG9owT+io5S1y/xTiOg==
X-CSE-MsgGUID: bA6aWOohQkCv8PxanhYa8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12390649"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Nov 2026 01:44:15 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWW1V-00000001Tlg-1lwf;
	Thu, 26 Nov 2026 09:44:13 +0000
Date: Thu, 26 Nov 2026 17:43:56 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 65f262b0a9a2da1df92470c826d1760401ace5ec
Message-ID: <20261126174356.fZcSIghW-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
branch HEAD: 65f262b0a9a2da1df92470c826d1760401ace5ec  KVM: PPC: remove unnecessary #ifdef

elapsed time: 883m

configs tested: 505
configs skipped: 266

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261125    gcc-8.5.0
alpha                 randconfig-2001-20261125    gcc-8.5.0
alpha                 randconfig-2200-20261125    gcc-10.5.0 smatch
alpha                 randconfig-2200-20261126    gcc-9.5.0  smatch
alpha                randconfig-r2100-20261125    gcc-9.5.0  cocci
alpha                randconfig-r2106-20261125    gcc-16.2.0 cocci
alpha                randconfig-r2301-20261125    gcc-11.5.0 sparse
alpha                randconfig-r2305-20261125    gcc-12     sparse
alpha                randconfig-r2305-20261125    gcc-12.5.0 sparse
alpha                randconfig-r2309-20261125    gcc-8.5.0  sparse
alpha                randconfig-r2311-20261125    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                      haps_hs_smp_defconfig    gcc-16.2.0
arc                         nsim_700_defconfig    gcc-16.2.0
arc                   randconfig-2000-20261125    gcc-10.5.0
arc                   randconfig-2001-20261125    gcc-10.5.0
arc                   randconfig-2002-20261125    gcc-10.5.0
arc                   randconfig-2003-20261125    gcc-10.5.0
arc                   randconfig-2004-20261125    gcc-10.5.0
arc                   randconfig-2005-20261125    gcc-10.5.0
arc                   randconfig-2200-20261125    gcc-14.4.0 smatch
arc                  randconfig-r2103-20261125    gcc-12.5.0 cocci
arc                  randconfig-r2104-20261125    gcc-9.5.0  cocci
arc                  randconfig-r2106-20261125    gcc-15.3.0 cocci
arc                  randconfig-r2110-20261125    gcc-16.2.0 cocci
arc                  randconfig-r2111-20261125    gcc-10.5.0 cocci
arc                  randconfig-r2304-20261125    gcc-11.5.0 sparse
arc                  randconfig-r2305-20261125    clang-24   sparse
arc                  randconfig-r2307-20261125    gcc-10.5.0 sparse
arc                  randconfig-r2307-20261125    gcc-14     sparse
arc                  randconfig-r2309-20261125    gcc-10.5.0 sparse
arc                  randconfig-r2310-20261125    gcc-10.5.0 sparse
arm                               alldefconfig    gcc-16.2.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                         clps711x_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                           ixp4xx_defconfig    gcc-16.2.0
arm                            omap1_defconfig    gcc-16.2.0
arm                   randconfig-2000-20261125    clang-22
arm                   randconfig-2001-20261125    clang-22
arm                   randconfig-2002-20261125    clang-22
arm                   randconfig-2200-20261125    clang-21   smatch
arm                  randconfig-r2105-20261125    gcc-8.5.0  cocci
arm                  randconfig-r2107-20261125    gcc-9.5.0  cocci
arm                  randconfig-r2108-20261125    gcc-11.5.0 cocci
arm                  randconfig-r2109-20261125    gcc-11.5.0 cocci
arm                  randconfig-r2110-20261125    gcc-10.5.0 cocci
arm                  randconfig-r2306-20261125    gcc-8.5.0  sparse
arm                  randconfig-r2310-20261125    clang-24   sparse
arm                  randconfig-r2311-20261125    gcc-13.5.0 sparse
arm                          s3c6400_defconfig    gcc-16.2.0
arm                         spear6xx_defconfig    gcc-16.2.0
arm                            u8500_defconfig    gcc-16.2.0
arm64                             alldefconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-2000-20261125    clang-22
arm64                 randconfig-2001-20261125    clang-22
arm64                 randconfig-2002-20261125    clang-22
arm64                 randconfig-2200-20261125    gcc-13.5.0 smatch
arm64                 randconfig-2200-20261126    clang-24   smatch
arm64                randconfig-r2104-20261125    gcc-10.5.0 cocci
arm64                randconfig-r2104-20261125    gcc-8.5.0  cocci
arm64                randconfig-r2108-20261125    clang-18   cocci
arm64                randconfig-r2110-20261125    clang-18   cocci
arm64                randconfig-r2301-20261125    gcc-12.5.0 sparse
arm64                randconfig-r2308-20261125    gcc-14     sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-2000-20261125    gcc-14.4.0
csky                  randconfig-2001-20261125    gcc-14.4.0
csky                  randconfig-2200-20261125    gcc-16.2.0 smatch
csky                 randconfig-r2100-20261125    gcc-10.5.0 cocci
csky                 randconfig-r2100-20261125    gcc-9.5.0  cocci
csky                 randconfig-r2102-20261125    gcc-8.5.0  cocci
csky                 randconfig-r2105-20261125    gcc-8.5.0  cocci
csky                 randconfig-r2106-20261125    clang-18   cocci
csky                 randconfig-r2108-20261125    gcc-9.5.0  cocci
csky                 randconfig-r2109-20261125    gcc-11.5.0 cocci
csky                 randconfig-r2300-20261125    clang-24   sparse
csky                 randconfig-r2308-20261125    gcc-11.5.0 sparse
csky                 randconfig-r2311-20261125    gcc-10.5.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261126    gcc-11.5.0
hexagon               randconfig-1001-20261126    gcc-11.5.0
hexagon               randconfig-2000-20261125    gcc-14.4.0
hexagon               randconfig-2001-20261125    gcc-14.4.0
hexagon               randconfig-2200-20261125    clang-17   smatch
hexagon              randconfig-r2100-20261125    gcc-8.5.0  cocci
hexagon              randconfig-r2104-20261125    gcc-8.5.0  cocci
hexagon              randconfig-r2104-20261125    gcc-9.5.0  cocci
hexagon              randconfig-r2111-20261125    gcc-16.2.0 cocci
hexagon              randconfig-r2303-20261125    clang-24   sparse
hexagon              randconfig-r2304-20261125    clang-24   sparse
hexagon              randconfig-r2309-20261125    gcc-8.5.0  sparse
hexagon              randconfig-r2311-20261125    gcc-15.3.0 sparse
i386                               allnoconfig    gcc-16.2.0
i386        buildonly-randconfig-1000-20261126    gcc-14
i386        buildonly-randconfig-1001-20261126    gcc-14
i386        buildonly-randconfig-1002-20261126    gcc-14
i386        buildonly-randconfig-1003-20261126    gcc-14
i386        buildonly-randconfig-1004-20261126    gcc-14
i386        buildonly-randconfig-1005-20261126    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261126    clang-22
i386                  randconfig-1001-20261126    clang-22
i386                  randconfig-1002-20261126    clang-22
i386                  randconfig-1003-20261126    clang-22
i386                  randconfig-1004-20261126    clang-22
i386                  randconfig-1005-20261126    clang-22
i386                  randconfig-1006-20261126    clang-22
i386                  randconfig-2000-20261125    gcc-14
i386                  randconfig-2001-20261125    gcc-14
i386                  randconfig-2002-20261125    gcc-14
i386                  randconfig-2003-20261125    gcc-14
i386                  randconfig-2004-20261125    gcc-14
i386                  randconfig-2005-20261125    gcc-14
i386                  randconfig-2100-20261125    clang-22   cocci
i386                  randconfig-2101-20261125    clang-22   cocci
i386                  randconfig-2102-20261125    clang-22   cocci
i386                  randconfig-2103-20261125    clang-22   cocci
i386                  randconfig-2104-20261125    clang-22   cocci
i386                  randconfig-2105-20261125    clang-22   cocci
i386                  randconfig-2200-20261125    clang-22   smatch
i386                  randconfig-2300-20261125    clang-22   sparse
i386                  randconfig-2301-20261125    clang-22   sparse
i386                  randconfig-2302-20261125    clang-22   sparse
i386                 randconfig-r2106-20261125    gcc-14     cocci
i386                 randconfig-r2108-20261125    gcc-10.5.0 cocci
i386                 randconfig-r2301-20261125    clang-24   sparse
i386                 randconfig-r2304-20261125    gcc-12     sparse
i386                 randconfig-r2304-20261125    gcc-8.5.0  sparse
i386                 randconfig-r2311-20261125    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.2.0
loongarch             randconfig-1000-20261126    gcc-11.5.0
loongarch             randconfig-1001-20261126    gcc-11.5.0
loongarch             randconfig-2000-20261125    clang-19
loongarch             randconfig-2001-20261125    clang-19
loongarch             randconfig-2200-20261125    clang-18   smatch
loongarch            randconfig-r2101-20261125    gcc-12.5.0 cocci
loongarch            randconfig-r2106-20261125    gcc-14     cocci
loongarch            randconfig-r2106-20261125    gcc-9.5.0  cocci
loongarch            randconfig-r2107-20261125    gcc-16.2.0 cocci
loongarch            randconfig-r2110-20261125    gcc-15.3.0 cocci
loongarch            randconfig-r2300-20261125    clang-24   sparse
loongarch            randconfig-r2301-20261125    clang-24   sparse
loongarch            randconfig-r2311-20261125    gcc-14     sparse
m68k                              alldefconfig    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261125    gcc-8.5.0
m68k                  randconfig-2001-20261125    gcc-8.5.0
m68k                  randconfig-2200-20261125    gcc-15.3.0 smatch
m68k                 randconfig-r2101-20261125    gcc-9.5.0  cocci
m68k                 randconfig-r2108-20261125    gcc-16.2.0 cocci
m68k                 randconfig-r2110-20261125    gcc-11.5.0 cocci
m68k                 randconfig-r2306-20261125    gcc-14     sparse
m68k                 randconfig-r2307-20261125    gcc-16.2.0 sparse
m68k                 randconfig-r2309-20261125    gcc-15.3.0 sparse
m68k                 randconfig-r2311-20261125    gcc-11.5.0 sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261125    gcc-8.5.0
microblaze            randconfig-2001-20261125    gcc-8.5.0
microblaze            randconfig-2200-20261125    gcc-8.5.0  smatch
microblaze            randconfig-2200-20261126    gcc-9.5.0  smatch
microblaze           randconfig-r2101-20261125    gcc-10.5.0 cocci
microblaze           randconfig-r2104-20261125    gcc-8.5.0  cocci
microblaze           randconfig-r2107-20261125    gcc-15.3.0 cocci
microblaze           randconfig-r2109-20261125    gcc-9.5.0  cocci
microblaze           randconfig-r2301-20261125    gcc-12     sparse
microblaze           randconfig-r2302-20261125    clang-24   sparse
microblaze           randconfig-r2307-20261125    gcc-8.5.0  sparse
microblaze           randconfig-r2308-20261125    gcc-8.5.0  sparse
microblaze           randconfig-r2310-20261125    gcc-13.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                          bigsur_defconfig    gcc-16.2.0
mips                         maltaup_defconfig    clang-20
mips                  randconfig-2000-20261125    gcc-16.2.0
mips                  randconfig-2001-20261125    gcc-16.2.0
mips                  randconfig-2002-20261125    gcc-16.2.0
mips                  randconfig-2200-20261125    clang-24   smatch
mips                 randconfig-r2103-20261125    gcc-9.5.0  cocci
mips                 randconfig-r2106-20261125    gcc-10.5.0 cocci
mips                 randconfig-r2107-20261125    clang-18   cocci
mips                 randconfig-r2108-20261125    gcc-11.5.0 cocci
mips                 randconfig-r2109-20261125    gcc-14     cocci
mips                 randconfig-r2110-20261125    gcc-9.5.0  cocci
mips                 randconfig-r2111-20261125    gcc-11.5.0 cocci
mips                 randconfig-r2111-20261125    gcc-14     cocci
mips                 randconfig-r2302-20261125    gcc-12     sparse
mips                 randconfig-r2305-20261125    gcc-15.3.0 sparse
mips                 randconfig-r2310-20261125    gcc-16.2.0 sparse
mips                 randconfig-r2311-20261125    gcc-16.2.0 sparse
mips                    sb1250_swarm_defconfig    clang-20
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261126    gcc-11.5.0
nios2                 randconfig-1001-20261126    gcc-11.5.0
nios2                 randconfig-2000-20261125    clang-19
nios2                 randconfig-2001-20261125    clang-19
nios2                 randconfig-2200-20261125    gcc-8.5.0  smatch
nios2                 randconfig-2200-20261126    gcc-9.5.0  smatch
nios2                randconfig-r2100-20261125    gcc-8.5.0  cocci
nios2                randconfig-r2103-20261125    gcc-10.5.0 cocci
nios2                randconfig-r2109-20261125    gcc-16.2.0 cocci
nios2                randconfig-r2300-20261125    clang-24   sparse
nios2                randconfig-r2300-20261125    gcc-11.5.0 sparse
nios2                randconfig-r2306-20261125    gcc-16.2.0 sparse
nios2                randconfig-r2306-20261125    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261125    gcc-16.2.0
openrisc              randconfig-2001-20261125    gcc-16.2.0
openrisc              randconfig-2002-20261125    gcc-16.2.0
openrisc              randconfig-2200-20261125    gcc-10.5.0 smatch
openrisc             randconfig-r2102-20261125    gcc-8.5.0  cocci
openrisc             randconfig-r2105-20261125    gcc-9.5.0  cocci
openrisc             randconfig-r2300-20261125    gcc-12.5.0 sparse
openrisc             randconfig-r2301-20261125    gcc-15.3.0 sparse
openrisc             randconfig-r2305-20261125    clang-24   sparse
openrisc             randconfig-r2307-20261125    gcc-11.5.0 sparse
openrisc             randconfig-r2308-20261125    gcc-10.5.0 sparse
openrisc             randconfig-r2310-20261125    gcc-15.3.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261126    gcc-13.5.0
parisc                randconfig-1001-20261126    gcc-13.5.0
parisc                randconfig-2000-20261125    clang-19
parisc                randconfig-2001-20261125    clang-19
parisc                randconfig-2200-20261125    gcc-12.5.0 smatch
parisc               randconfig-r2101-20261125    gcc-8.5.0  cocci
parisc               randconfig-r2102-20261125    gcc-12.5.0 cocci
parisc               randconfig-r2106-20261125    gcc-11.5.0 cocci
parisc               randconfig-r2107-20261125    gcc-14     cocci
parisc               randconfig-r2109-20261125    gcc-10.5.0 cocci
parisc               randconfig-r2110-20261125    gcc-11.5.0 cocci
parisc               randconfig-r2300-20261125    gcc-15.3.0 sparse
parisc               randconfig-r2304-20261125    gcc-12.5.0 sparse
parisc               randconfig-r2305-20261125    clang-24   sparse
parisc               randconfig-r2306-20261125    gcc-15.3.0 sparse
parisc               randconfig-r2310-20261125    gcc-14     sparse
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    gcc-16.2.0
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       arches_defconfig    gcc-16.2.0
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                        ebony_defconfig    gcc-16.2.0
powerpc                   iss476-smp_defconfig    clang-20
powerpc                      mpc512x_defconfig    gcc-16.2.0
powerpc                  mpc8315_rdb_defconfig    gcc-16.2.0
powerpc                  mpc834x_itx_defconfig    gcc-16.2.0
powerpc                mpc834x_itxgp_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261126    gcc-13.5.0
powerpc               randconfig-1001-20261126    gcc-13.5.0
powerpc               randconfig-2000-20261125    clang-17
powerpc               randconfig-2000-20261125    gcc-9.5.0
powerpc               randconfig-2001-20261125    gcc-11.5.0
powerpc               randconfig-2001-20261125    gcc-9.5.0
powerpc               randconfig-2002-20261125    gcc-9.5.0
powerpc               randconfig-2200-20261125    gcc-11.5.0 smatch
powerpc              randconfig-r2101-20261125    gcc-8.5.0  cocci
powerpc              randconfig-r2102-20261125    gcc-9.5.0  cocci
powerpc              randconfig-r2106-20261125    clang-24   cocci
powerpc              randconfig-r2107-20261125    gcc-11.5.0 cocci
powerpc              randconfig-r2108-20261125    gcc-15.3.0 cocci
powerpc              randconfig-r2111-20261125    gcc-14     cocci
powerpc              randconfig-r2111-20261125    gcc-15.3.0 cocci
powerpc              randconfig-r2303-20261125    clang-24   sparse
powerpc              randconfig-r2306-20261125    gcc-13.5.0 sparse
powerpc              randconfig-r2310-20261125    gcc-8.5.0  sparse
powerpc                      tqm5200_defconfig    clang-20
powerpc                       tqm8xx_defconfig    clang-20
powerpc                          wii_defconfig    gcc-16.2.0
powerpc                  xes_mpc85xx_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261126    gcc-13.5.0
powerpc64             randconfig-1001-20261126    gcc-13.5.0
powerpc64             randconfig-2000-20261125    gcc-15.3.0
powerpc64             randconfig-2000-20261125    gcc-9.5.0
powerpc64             randconfig-2001-20261125    clang-17
powerpc64             randconfig-2001-20261125    gcc-9.5.0
powerpc64             randconfig-2002-20261125    clang-17
powerpc64             randconfig-2002-20261125    gcc-9.5.0
powerpc64             randconfig-2200-20261125    gcc-13.5.0 smatch
powerpc64            randconfig-r2101-20261125    gcc-9.5.0  cocci
powerpc64            randconfig-r2102-20261125    gcc-8.5.0  cocci
powerpc64            randconfig-r2107-20261125    gcc-11.5.0 cocci
powerpc64            randconfig-r2108-20261125    gcc-14     cocci
powerpc64            randconfig-r2303-20261125    clang-24   sparse
powerpc64            randconfig-r2303-20261125    gcc-8.5.0  sparse
powerpc64            randconfig-r2307-20261125    gcc-13.5.0 sparse
powerpc64            randconfig-r2309-20261125    gcc-16.2.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-2000-20261125    gcc-13.5.0
riscv                 randconfig-2001-20261125    gcc-13.5.0
riscv                 randconfig-2002-20261125    gcc-13.5.0
riscv                 randconfig-2003-20261125    gcc-13.5.0
riscv                 randconfig-2004-20261125    gcc-13.5.0
riscv                 randconfig-2005-20261125    gcc-13.5.0
riscv                 randconfig-2200-20261125    gcc-8.5.0  smatch
riscv                 randconfig-2200-20261126    gcc-8.5.0  smatch
riscv                randconfig-r2102-20261125    gcc-8.5.0  cocci
riscv                randconfig-r2102-20261125    gcc-9.5.0  cocci
riscv                randconfig-r2103-20261125    gcc-8.5.0  cocci
riscv                randconfig-r2104-20261125    gcc-8.5.0  cocci
riscv                randconfig-r2110-20261125    gcc-14     cocci
riscv                randconfig-r2111-20261125    gcc-11.5.0 cocci
riscv                randconfig-r2300-20261125    gcc-8.5.0  sparse
riscv                randconfig-r2302-20261125    clang-24   sparse
riscv                randconfig-r2304-20261125    clang-24   sparse
riscv                randconfig-r2311-20261125    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-2000-20261125    clang-24
s390                  randconfig-2001-20261125    clang-24
s390                  randconfig-2002-20261125    clang-24
s390                  randconfig-2003-20261125    clang-24
s390                  randconfig-2004-20261125    clang-24
s390                  randconfig-2005-20261125    clang-24
s390                  randconfig-2200-20261125    gcc-15.3.0 smatch
s390                 randconfig-r2103-20261125    gcc-8.5.0  cocci
s390                 randconfig-r2103-20261125    gcc-9.5.0  cocci
s390                 randconfig-r2105-20261125    gcc-10.5.0 cocci
s390                 randconfig-r2105-20261125    gcc-12.5.0 cocci
s390                 randconfig-r2105-20261125    gcc-8.5.0  cocci
s390                 randconfig-r2106-20261125    gcc-11.5.0 cocci
s390                 randconfig-r2109-20261125    clang-18   cocci
s390                 randconfig-r2303-20261125    gcc-11.5.0 sparse
s390                 randconfig-r2304-20261125    clang-24   sparse
s390                 randconfig-r2304-20261125    gcc-15.3.0 sparse
s390                 randconfig-r2305-20261125    gcc-11.5.0 sparse
s390                 randconfig-r2305-20261125    gcc-8.5.0  sparse
s390                 randconfig-r2307-20261125    clang-24   sparse
s390                 randconfig-r2308-20261125    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          apsh4a3a_defconfig    clang-20
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.2.0
sh                           polaris_defconfig    gcc-16.2.0
sh                    randconfig-2000-20261125    gcc-14.4.0
sh                    randconfig-2001-20261125    gcc-14.4.0
sh                    randconfig-2002-20261125    gcc-14.4.0
sh                    randconfig-2003-20261125    gcc-14.4.0
sh                    randconfig-2004-20261125    gcc-14.4.0
sh                    randconfig-2005-20261125    gcc-14.4.0
sh                    randconfig-2200-20261125    gcc-14.4.0 smatch
sh                   randconfig-r2107-20261125    gcc-10.5.0 cocci
sh                   randconfig-r2109-20261125    gcc-14     cocci
sh                   randconfig-r2110-20261125    gcc-14     cocci
sh                   randconfig-r2111-20261125    clang-18   cocci
sh                   randconfig-r2301-20261125    gcc-8.5.0  sparse
sh                   randconfig-r2308-20261125    gcc-15.3.0 sparse
sh                   randconfig-r2309-20261125    gcc-13.5.0 sparse
sh                    rts7751r2dplus_defconfig    clang-20
sh                            se7619_defconfig    gcc-16.2.0
sh                      sh7710voipgw_defconfig    gcc-16.2.0
sh                              shx3_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261126    clang-17
sparc                 randconfig-1001-20261126    clang-17
sparc                 randconfig-2000-20261125    gcc-8.5.0
sparc                 randconfig-2001-20261125    gcc-8.5.0
sparc                 randconfig-2200-20261125    gcc-14.4.0 smatch
sparc                 randconfig-2200-20261126    gcc-13.5.0 smatch
sparc                randconfig-r2100-20261125    gcc-8.5.0  cocci
sparc                randconfig-r2104-20261125    gcc-12.5.0 cocci
sparc                randconfig-r2111-20261125    gcc-9.5.0  cocci
sparc                randconfig-r2307-20261125    gcc-15.3.0 sparse
sparc                randconfig-r2308-20261125    gcc-13.5.0 sparse
sparc                randconfig-r2308-20261125    gcc-16.2.0 sparse
sparc                randconfig-r2308-20261125    gcc-8.5.0  sparse
sparc                randconfig-r2309-20261125    clang-24   sparse
sparc                randconfig-r2309-20261125    gcc-11.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261126    clang-17
sparc64               randconfig-1001-20261126    clang-17
sparc64               randconfig-2000-20261125    gcc-8.5.0
sparc64               randconfig-2001-20261125    gcc-8.5.0
sparc64               randconfig-2200-20261125    gcc-15.3.0 smatch
sparc64               randconfig-2200-20261126    gcc-12.5.0 smatch
sparc64              randconfig-r2109-20261125    gcc-15.3.0 cocci
sparc64              randconfig-r2300-20261125    gcc-12     sparse
sparc64              randconfig-r2302-20261125    gcc-15.3.0 sparse
sparc64              randconfig-r2303-20261125    gcc-12     sparse
sparc64              randconfig-r2303-20261125    gcc-12.5.0 sparse
sparc64              randconfig-r2309-20261125    gcc-8.5.0  sparse
sparc64              randconfig-r2310-20261125    gcc-11.5.0 sparse
sparc64              randconfig-r2311-20261125    gcc-8.5.0  sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261126    clang-17
um                    randconfig-1001-20261126    clang-17
um                    randconfig-2000-20261125    gcc-8.5.0
um                    randconfig-2001-20261125    gcc-8.5.0
um                    randconfig-2200-20261125    clang-17   smatch
um                   randconfig-r2102-20261125    gcc-10.5.0 cocci
um                   randconfig-r2105-20261125    gcc-8.5.0  cocci
um                   randconfig-r2108-20261125    gcc-14     cocci
um                   randconfig-r2301-20261125    clang-24   sparse
um                   randconfig-r2302-20261125    gcc-11.5.0 sparse
um                   randconfig-r2306-20261125    clang-24   sparse
um                   randconfig-r2306-20261125    gcc-8.5.0  sparse
um                            x86_64_defconfig    gcc-14
x86_64                            alldefconfig    clang-20
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261126    clang-22
x86_64      buildonly-randconfig-1001-20261126    clang-22
x86_64      buildonly-randconfig-1002-20261126    clang-22
x86_64      buildonly-randconfig-1003-20261126    clang-22
x86_64      buildonly-randconfig-1004-20261126    clang-22
x86_64      buildonly-randconfig-1005-20261126    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261126    clang-22
x86_64                randconfig-1001-20261126    clang-22
x86_64                randconfig-1002-20261126    clang-22
x86_64                randconfig-1003-20261126    clang-22
x86_64                randconfig-1004-20261126    clang-22
x86_64                randconfig-1005-20261126    clang-22
x86_64                randconfig-2000-20261125    gcc-14
x86_64                randconfig-2001-20261125    gcc-14
x86_64                randconfig-2002-20261125    gcc-14
x86_64                randconfig-2003-20261125    gcc-14
x86_64                randconfig-2004-20261125    gcc-14
x86_64                randconfig-2005-20261125    gcc-14
x86_64                randconfig-2100-20261125    clang-22   cocci
x86_64                randconfig-2101-20261125    clang-22   cocci
x86_64                randconfig-2102-20261125    clang-22   cocci
x86_64                randconfig-2103-20261125    clang-22   cocci
x86_64                randconfig-2104-20261125    clang-22   cocci
x86_64                randconfig-2105-20261125    clang-22   cocci
x86_64                randconfig-2200-20261125    gcc-14     smatch
x86_64                randconfig-2300-20261125    clang-22   sparse
x86_64                randconfig-2301-20261125    clang-22   sparse
x86_64                randconfig-2302-20261125    clang-22   sparse
x86_64               randconfig-r2107-20261125    gcc-14     cocci
x86_64               randconfig-r2302-20261125    gcc-8.5.0  sparse
x86_64               randconfig-r2306-20261125    gcc-10.5.0 sparse
x86_64               randconfig-r2306-20261125    gcc-11.5.0 sparse
x86_64               randconfig-r2307-20261125    gcc-8.5.0  sparse
x86_64               randconfig-r2309-20261125    gcc-14     sparse
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
xtensa                            alldefconfig    gcc-16.2.0
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261126    clang-17
xtensa                randconfig-1001-20261126    clang-17
xtensa                randconfig-2000-20261125    gcc-14.4.0
xtensa                randconfig-2001-20261125    gcc-14.4.0
xtensa                randconfig-2200-20261125    gcc-16.2.0 smatch
xtensa               randconfig-r2100-20261125    gcc-12.5.0 cocci
xtensa               randconfig-r2101-20261125    gcc-8.5.0  cocci
xtensa               randconfig-r2103-20261125    gcc-8.5.0  cocci
xtensa               randconfig-r2302-20261125    gcc-12.5.0 sparse
xtensa               randconfig-r2303-20261125    gcc-15.3.0 sparse
xtensa               randconfig-r2308-20261125    clang-24   sparse
xtensa               randconfig-r2310-20261125    gcc-8.5.0  sparse
xtensa                     xip_kc705_defconfig    gcc-16.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

