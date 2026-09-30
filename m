Return-Path: <linuxppc-dev+bounces-28577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67582CA5FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:47:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvyZh5MCKz2y24;
	Thu, 01 Oct 2026 00:47:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790779676;
	cv=none; b=a144/Z6Pdi1yV/vaah7oXH8gb2U3QEUr5LZowc8phJ9WrtUMPtQY0DIA5CtyotLjrKAlgAmxTea5efkn9UaO8ygjTQ/U/ggzxUCi/J1gHnd0uAEJnBuvpsiRgXJLrgY2eZFadTaWttfT8EpoiIUlAuNx69J1uMm1QsOkG9mTkqc2hL26HlzBrIkD29IVdegoAasFMcov+eJ9cUXmkDNdqGJadpHT9DPxqDQA/rC6053lO0c5HEWtuJtywV5jnson1tVYf/LFFPkR8DBbzy3nLhc6J+JXGv+RpaSdvy6zXb/B4WoPJaXUSsKJczlPTdBqSrbLsPbbb3C2fU28d84Ptw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790779676; c=relaxed/relaxed;
	bh=lfwMrV6/58lwP1RL7923ea+a2KbLjjmy2VbY2muUjjo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=L8px1a8vK+4eluavvVNCCFtBKVOOJBd/emfQbrKOzkBAKOub7SoIDneNQxR7gUJ5lVZHU4mjv8pX+UeaJaJJOEpbYOGQ+WhFNBQIDFxYaRmwy0dBDvfqP6rdZ83NFzyWCmajLckLoC+MqhGoaEyAdw24vIV3PqizR+LxN9vzJuGmiBlSMr3+fku6pjSZYOC3DnbipowM7v2hZyVI3GET0AqcndZUmgzgHkUxen9RALOwYrqq+xAwY0fAn/pgUe4xpcdAnZ4b57gr7PLyozBWGRXGTqPqlfp3POQMzzWkdpWWuTMxac8Uu45Bt5kIWz2agWPh/wgmnRLlebwdsrFncA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hiOixidK; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hiOixidK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvyZd5YnBz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:47:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790779674; x=1822315674;
  h=date:from:to:cc:subject:message-id;
  bh=pkA6h1A8szErEn0ZKAlKyo8S+4TS/65uL2xb3FuR32Q=;
  b=hiOixidKR9anio99FUewqfcIepc9q9SFw9/wV2Mn4qJuDvgqyidOfADK
   sYTWpLXvWB5Yj7xqPzJvJCVecx7jKrVfvBygMqe4mGoz+1yyA/Q5apoJN
   Cv4N+OfWHD5JAmPA94IRpYuNj7jVokF6EOwxE09bpO7hSGkiGyVIuQcXN
   sPWDetnLw1R4Gg+IybN0HzV2p+h/dOg1etNQbxXneCAtoOvbMWP7/YhuK
   KbMln08vzlUSOYQ9bBfXd5CVTYXSAM+ELrrubJBkWYJA0k+b0+tUnErpC
   8+mqYwwKMpTdZNgMFhw6bKhfTnFVA44fml0FPXc5MLqAXbhY2p1pRq6+1
   w==;
X-CSE-ConnectionGUID: q2O40MfDRXa0Fl73cRRGrQ==
X-CSE-MsgGUID: 7DZsKVfRQ9Weo1Z7Bb7oWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="94003852"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="94003852"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:47:49 -0700
X-CSE-ConnectionGUID: uIr3OMfVSZGp/8ucxE/rQQ==
X-CSE-MsgGUID: /BnCAwulSxqju9YSoTGENA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="313636150"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Sep 2026 07:47:48 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xBvaz-00000000QkZ-2mgo;
	Wed, 30 Sep 2026 14:47:45 +0000
Date: Wed, 30 Sep 2026 22:46:58 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 aaabc4aaa54de5f745638244d096f2f6802b1491
Message-ID: <202609302254.7ud8j5N2-lkp@intel.com>
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
branch HEAD: aaabc4aaa54de5f745638244d096f2f6802b1491  Automatic merge of 'next' into merge (2026-09-29 11:36)

elapsed time: 1032m

configs tested: 344
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2302-20260929    gcc-12.5.0 sparse
alpha                randconfig-r2303-20260929    gcc-12.5.0 sparse
alpha                randconfig-r2309-20260929    gcc-13.4.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                  randconfig-r2100-20260929    clang-24   cocci
arc                  randconfig-r2101-20260930    gcc-16.1.0 cocci
arc                  randconfig-r2102-20260929    gcc-9.5.0  cocci
arc                  randconfig-r2105-20260929    gcc-13.4.0 cocci
arc                  randconfig-r2301-20260930    clang-24   sparse
arc                  randconfig-r2302-20260929    gcc-8.5.0  sparse
arc                  randconfig-r2307-20260929    gcc-13.4.0 sparse
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
arm                  randconfig-r2103-20260929    gcc-15.2.0 cocci
arm                  randconfig-r2106-20260929    gcc-10.5.0 cocci
arm                  randconfig-r2106-20260930    clang-21   cocci
arm                  randconfig-r2305-20260929    gcc-12.5.0 sparse
arm                  randconfig-r2305-20260929    gcc-8.5.0  sparse
arm                  randconfig-r2306-20260930    clang-24   sparse
arm                  randconfig-r2308-20260929    gcc-13.4.0 sparse
arm                  randconfig-r2308-20260929    gcc-9.5.0  sparse
arm                            sama5_defconfig    gcc-16.1.0
arm                         spear6xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260930    gcc-16.1.0
arm64                 randconfig-1001-20260930    gcc-16.1.0
arm64                 randconfig-1002-20260930    gcc-16.1.0
arm64                 randconfig-1003-20260930    gcc-16.1.0
arm64                randconfig-r2102-20260929    clang-24   cocci
arm64                randconfig-r2301-20260929    gcc-12.5.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260930    gcc-16.1.0
csky                  randconfig-1001-20260930    gcc-16.1.0
csky                 randconfig-r2105-20260929    gcc-16.1.0 cocci
csky                 randconfig-r2107-20260929    gcc-16.1.0 cocci
csky                 randconfig-r2200-20260929    gcc-14.3.0 smatch
csky                 randconfig-r2300-20260929    gcc-12.5.0 sparse
csky                 randconfig-r2307-20260929    clang-22   sparse
csky                 randconfig-r2309-20260929    clang-22   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260930    clang-24
hexagon               randconfig-1001-20260930    clang-24
hexagon              randconfig-r2103-20260930    gcc-16.1.0 cocci
hexagon              randconfig-r2202-20260929    clang-17   smatch
hexagon              randconfig-r2306-20260929    gcc-9.5.0  sparse
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
i386                  randconfig-2100-20260929    clang-22   cocci
i386                  randconfig-2100-20260930    clang-22   cocci
i386                  randconfig-2101-20260929    clang-22   cocci
i386                  randconfig-2101-20260930    clang-22   cocci
i386                  randconfig-2102-20260929    clang-22   cocci
i386                  randconfig-2102-20260930    clang-22   cocci
i386                  randconfig-2103-20260929    clang-22   cocci
i386                  randconfig-2103-20260930    clang-22   cocci
i386                  randconfig-2200-20260929    gcc-14     smatch
i386                  randconfig-2200-20260930    gcc-14     smatch
i386                  randconfig-2300-20260929    gcc-14     sparse
i386                  randconfig-2300-20260930    gcc-13     sparse
i386                  randconfig-2301-20260929    gcc-14     sparse
i386                  randconfig-2301-20260930    gcc-13     sparse
i386                  randconfig-2302-20260929    gcc-14     sparse
i386                  randconfig-2302-20260930    gcc-13     sparse
i386                 randconfig-r2102-20260930    gcc-16.1.0 cocci
i386                 randconfig-r2104-20260929    gcc-10.5.0 cocci
i386                 randconfig-r2106-20260929    gcc-16.1.0 cocci
i386                 randconfig-r2202-20260930    gcc-13     smatch
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260930    clang-24
loongarch             randconfig-1001-20260930    clang-24
loongarch            randconfig-r2200-20260929    clang-24   smatch
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    clang-24
m68k                           atari_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5475evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2101-20260929    clang-24   cocci
m68k                 randconfig-r2300-20260930    clang-24   sparse
m68k                 randconfig-r2304-20260929    gcc-8.5.0  sparse
m68k                 randconfig-r2305-20260929    gcc-12.5.0 sparse
m68k                 randconfig-r2306-20260929    clang-22   sparse
m68k                            virt_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2200-20260930    gcc-11.5.0 smatch
microblaze           randconfig-r2201-20260929    gcc-13.4.0 smatch
microblaze           randconfig-r2300-20260929    gcc-8.5.0  sparse
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
mips                 randconfig-r2103-20260929    clang-24   cocci
mips                 randconfig-r2104-20260929    gcc-13.4.0 cocci
mips                 randconfig-r2306-20260929    gcc-13.4.0 sparse
mips                 randconfig-r2308-20260930    clang-24   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260930    clang-24
nios2                 randconfig-1001-20260930    clang-24
nios2                randconfig-r2202-20260929    gcc-10.5.0 smatch
nios2                randconfig-r2309-20260929    gcc-9.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20260929    gcc-9.5.0  cocci
openrisc             randconfig-r2100-20260930    gcc-16.1.0 cocci
openrisc             randconfig-r2107-20260929    gcc-10.5.0 cocci
openrisc             randconfig-r2304-20260929    gcc-12.5.0 sparse
openrisc             randconfig-r2309-20260930    clang-24   sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260930    gcc-8.5.0
parisc                randconfig-1001-20260930    gcc-8.5.0
parisc               randconfig-r2100-20260929    gcc-15.2.0 cocci
parisc               randconfig-r2101-20260929    gcc-9.5.0  cocci
parisc               randconfig-r2200-20260929    gcc-14.3.0 smatch
parisc               randconfig-r2301-20260929    gcc-12.5.0 sparse
parisc               randconfig-r2303-20260929    gcc-12.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.1.0
powerpc                         fsp2_defconfig    gcc-16.1.0
powerpc                       ppc64e_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc              randconfig-r2102-20260929    gcc-15.2.0 cocci
powerpc              randconfig-r2103-20260929    gcc-9.5.0  cocci
powerpc              randconfig-r2104-20260929    gcc-16.1.0 cocci
powerpc              randconfig-r2105-20260930    clang-21   cocci
powerpc              randconfig-r2201-20260929    gcc-10.5.0 smatch
powerpc              randconfig-r2201-20260930    gcc-14.3.0 smatch
powerpc              randconfig-r2302-20260930    clang-24   sparse
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
riscv                 randconfig-2001-20260929    gcc-11.5.0
riscv                 randconfig-2001-20260930    gcc-14.3.0
riscv                randconfig-r2101-20260929    gcc-15.2.0 cocci
riscv                randconfig-r2202-20260929    clang-24   smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260930    gcc-16.1.0
s390                  randconfig-1001-20260930    gcc-16.1.0
s390                  randconfig-2000-20260929    gcc-11.5.0
s390                  randconfig-2000-20260930    gcc-14.3.0
s390                  randconfig-2001-20260929    gcc-11.5.0
s390                  randconfig-2001-20260930    gcc-14.3.0
s390                 randconfig-r2105-20260929    gcc-10.5.0 cocci
s390                 randconfig-r2304-20260930    clang-24   sparse
s390                 randconfig-r2307-20260930    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         edosk7760_defconfig    clang-24
sh                              espt_defconfig    gcc-16.1.0
sh                             hp6xx_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260930    gcc-16.1.0
sh                    randconfig-1001-20260930    gcc-16.1.0
sh                    randconfig-2000-20260929    gcc-11.5.0
sh                    randconfig-2000-20260930    gcc-14.3.0
sh                    randconfig-2001-20260929    gcc-11.5.0
sh                    randconfig-2001-20260930    gcc-14.3.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260930    clang-22
sparc                 randconfig-1001-20260930    clang-22
sparc                 randconfig-2000-20260929    gcc-12.5.0
sparc                 randconfig-2000-20260930    gcc-10.5.0
sparc                 randconfig-2001-20260929    gcc-12.5.0
sparc                 randconfig-2001-20260930    gcc-10.5.0
sparc                randconfig-r2301-20260929    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260930    clang-22
sparc64               randconfig-1001-20260930    clang-22
sparc64               randconfig-2000-20260929    gcc-12.5.0
sparc64               randconfig-2000-20260930    gcc-10.5.0
sparc64               randconfig-2001-20260929    gcc-12.5.0
sparc64               randconfig-2001-20260930    gcc-10.5.0
sparc64              randconfig-r2104-20260930    clang-21   cocci
sparc64              randconfig-r2300-20260929    gcc-12.5.0 sparse
sparc64              randconfig-r2303-20260929    gcc-8.5.0  sparse
sparc64              randconfig-r2303-20260930    clang-24   sparse
sparc64              randconfig-r2305-20260930    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260930    clang-22
um                    randconfig-1001-20260930    clang-22
um                    randconfig-2000-20260929    gcc-12.5.0
um                    randconfig-2000-20260930    gcc-10.5.0
um                    randconfig-2001-20260929    gcc-12.5.0
um                    randconfig-2001-20260930    gcc-10.5.0
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
x86_64                randconfig-2100-20260929    clang-22   cocci
x86_64                randconfig-2100-20260930    clang-22   cocci
x86_64                randconfig-2101-20260929    clang-22   cocci
x86_64                randconfig-2101-20260930    clang-22   cocci
x86_64                randconfig-2102-20260929    clang-22   cocci
x86_64                randconfig-2102-20260930    clang-22   cocci
x86_64                randconfig-2103-20260929    clang-22   cocci
x86_64                randconfig-2103-20260930    clang-22   cocci
x86_64                randconfig-2200-20260929    clang-22   smatch
x86_64                randconfig-2200-20260930    gcc-14     smatch
x86_64                randconfig-2300-20260929    gcc-14     sparse
x86_64                randconfig-2300-20260930    gcc-13     sparse
x86_64                randconfig-2301-20260929    gcc-14     sparse
x86_64                randconfig-2301-20260930    gcc-13     sparse
x86_64                randconfig-2302-20260929    gcc-14     sparse
x86_64                randconfig-2302-20260930    gcc-13     sparse
x86_64               randconfig-r2107-20260929    gcc-13.4.0 cocci
x86_64               randconfig-r2308-20260929    clang-22   sparse
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
xtensa                randconfig-2000-20260929    gcc-12.5.0
xtensa                randconfig-2000-20260930    gcc-10.5.0
xtensa                randconfig-2001-20260929    gcc-12.5.0
xtensa                randconfig-2001-20260930    gcc-10.5.0
xtensa               randconfig-r2106-20260929    gcc-13.4.0 cocci
xtensa               randconfig-r2201-20260929    gcc-10.5.0 smatch
xtensa               randconfig-r2307-20260929    gcc-9.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

