Return-Path: <linuxppc-dev+bounces-24953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A4EC54F51
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 22:28:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8qqZ34ZDz2xWY;
	Wed, 29 Jul 2026 08:28:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785277706;
	cv=none; b=mWpATOD8h85zphJoNoyjiu2kGnS+fC88gzNqoGYFvQQp6m6kBqx/cDkCyVYh9Md64PBTpyowkwzG7dlrgKjy1IwQMDpi++pN82HlEbg+JQQCV3T8ZM1QgeF/BV91CbPrePhodeKJfZunT+np/d5qmDCb2X43WhgG0BDtbUrq2IUodhVgyKAYyG6OE2ZIgdUNYC+sZRlMVpewlMl3aBoiv79Z68GZHKiIoMzpQAjh9Qr+F95LzLtxEge4vns/wQPE6WNTQOOL2fg4yBYV7DrmbX3+zzAP2IX+We5nZWut/p/9WIuUagPo6wEXXnodZrCGl51N+T+A/OCCCBRA2+cGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785277706; c=relaxed/relaxed;
	bh=gytRFUduEehdwosBt5+araJzdnLx2EmiZkKWZjmH61w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aNE0a1hV4ggCLTH7QfMOoqt/OhYiNKI+pq7qah1P0DSvzeQ7rUYh7SemVmaQYfrRWNNGd0hwfaoVkERvmDvg6lVyFIA324cJM6mjSz56LHiIp1Cul5WrdWxcOkyvqYotBjO7ddOpwXWZOoq/6RIPixMOX3WkP6iGSxTNRTpONQHbX7igXd+IaWsRFJPXIHjuZ7ncn6MRvAH+pxkzcofLMO+We4HsP9ioWXRfhLLWQ4SKa+PjWKcDhc02TFoe9FfytdjOMev1V+Oc20eo06NyJ9LSlbnwSb0kyU34f7hS0siZO1/RJl2UR3YA6mDfcCr8w4SxQVZM2IFR8uAUc2xuqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nqI4ORoK; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nqI4ORoK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8qqW33rWz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 08:28:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785277704; x=1816813704;
  h=date:from:to:cc:subject:message-id;
  bh=YpdFcnNaPKslzN46W7ocUqZhFCTyh6LTPlGL6Ohk/Zc=;
  b=nqI4ORoKKDy28uC2w8glxMdd3y9Mhbem+QEp95J4dIUU9swiVrdrYqxv
   ob7uE9s8O46fHOt1vlKZf4g1p9RkvFNiGTLeGSqnXAIFrgjSdB/0yXbAe
   LontAs8kHpj+LHDyKy5Byz7v7QbEU3dsR7ez9DZf7xP5vq+E4QiM1FR3N
   xLuGnSAJQ9XC7ScNEn4VGYKrizKVAUjLeO9W0K1k+YmmGSpeuhwko4Pl6
   rhJ6zQSiybRCT6pKfyHQjBJtt7v3Xdl68UcDkD124zfq/KLziXaNH8h8I
   EEgdw47yyYYmsaae/ljyzrod1imA5Z2zakAO5kpVH55FqB1Bh18U6QtzY
   Q==;
X-CSE-ConnectionGUID: Ai95MLE8QrqN+OwNZIIibw==
X-CSE-MsgGUID: b8i0zCY9TKeoH9BJlkjSPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85917669"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85917669"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 15:28:16 -0700
X-CSE-ConnectionGUID: epPamMTQSHSlYFOErgbxSA==
X-CSE-MsgGUID: kj4Z7yy6TkCOUUt71sBVfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="263639370"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 28 Jul 2026 15:28:15 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woqHV-00000000eol-0QPd;
	Tue, 28 Jul 2026 22:28:13 +0000
Date: Wed, 29 Jul 2026 06:27:53 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 f7b562b3c0749a47b17e30a0e0179e7723f581ae
Message-ID: <202607290639.4cWngw4U-lkp@intel.com>
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
branch HEAD: f7b562b3c0749a47b17e30a0e0179e7723f581ae  Automatic merge of 'fixes' into merge (2026-07-27 18:03)

elapsed time: 825m

configs tested: 90
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-003-20260729    gcc-8.5.0
arm                  randconfig-004-20260729    gcc-8.5.0
arm64                randconfig-001-20260729    clang-17
arm64                randconfig-002-20260729    clang-17
arm64                randconfig-003-20260729    clang-17
arm64                randconfig-004-20260729    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    clang-17
csky                 randconfig-002-20260729    clang-17
hexagon              randconfig-001-20260729    gcc-9.5.0
hexagon              randconfig-002-20260729    gcc-9.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-006-20260729    gcc-14
i386                 randconfig-001-20260729    clang-22
i386                 randconfig-002-20260729    clang-22
i386                 randconfig-003-20260729    clang-22
i386                 randconfig-004-20260729    clang-22
i386                 randconfig-005-20260729    clang-22
i386                 randconfig-006-20260729    clang-22
i386                 randconfig-007-20260729    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-002-20260729    gcc-9.5.0
mips                       bcm63xx_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-002-20260729    gcc-9.5.0
parisc                          alldefconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-002-20260729    clang-24
powerpc                   adder875_defconfig    gcc-16.1.0
powerpc                    ksi8560_defconfig    gcc-16.1.0
powerpc                mpc8313_rdb_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-002-20260729    clang-24
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-002-20260729    clang-24
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-15.2.0
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-002-20260729    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sparc                randconfig-001-20260729    gcc-10.5.0
sparc                randconfig-002-20260729    gcc-10.5.0
sparc64              randconfig-001-20260729    gcc-10.5.0
sparc64              randconfig-002-20260729    gcc-10.5.0
um                   randconfig-001-20260729    gcc-10.5.0
um                   randconfig-002-20260729    gcc-10.5.0
x86_64     buildonly-randconfig-001-20260729    clang-22
x86_64     buildonly-randconfig-002-20260729    clang-22
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    clang-22
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260729    clang-22
x86_64               randconfig-002-20260729    clang-22
x86_64               randconfig-003-20260729    clang-22
x86_64               randconfig-004-20260729    clang-22
x86_64               randconfig-005-20260729    clang-22
x86_64               randconfig-006-20260729    clang-22
x86_64               randconfig-011-20260729    gcc-14
x86_64               randconfig-012-20260729    gcc-14
x86_64               randconfig-013-20260729    gcc-14
x86_64               randconfig-014-20260729    gcc-14
x86_64               randconfig-015-20260729    gcc-14
x86_64               randconfig-016-20260729    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260729    gcc-10.5.0
xtensa               randconfig-002-20260729    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

