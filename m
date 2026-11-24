Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952E606A31E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ggUvnTFV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYYTF45fDz2xf8;
	Tue, 24 Nov 2026 17:54:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795503281;
	cv=none; b=b8arl2QhEhGqGrKQCHMOG0LXwlXCtLNmC7PHshyRbBNZ2eAAhCxkREExgpaGfvYZrdmFW/BEhMpj61ZpR/jhWxK0KLAMZ/brX1bRLZSEOib/mkUfY7qTAKA4bCez+su5qfPt3tOybQPAvPr+1YZ2Wvr6bGhnM5X6ATgId/BYHV9dpCWnqxqKgezXHYZEVPGpFEVKQEhuEhgPOUj1olFcoHH2AzXmoszK5V6pjDo9eerqDZek4xkAvjgijdf4AmQUXK4/WucIUhfYuoEsk9NL8Ude3wlbGELdR6cXFBpKZcyAIFduuoj0tFpBadHJ6eO2Ze+m0hdRX3AJdWC5AMVSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795503281; c=relaxed/relaxed;
	bh=erVrBY7mEtq0XLa8q9D3vXGvM3ODr4eU8X62EEa5/lU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KeAo1f2p+rHKBOM6dxKeamVqGhCoTHkmqxf7HD/9/hzCsQLLhvBV5B41nRrZeybl2Rb9Vju0P/OPUmbgES+W4PcRKQ2BrzLylPSTTTiBkYTVUZAnDl2KOnoCIIZgEAYfbZEf7ZEi4iVfwb8Ke4iW3eSDTXiZN/155rSceZ2Ilt5WYF/dvXcPGjPN9QndWMd+SmZkXByapzZpGaA0X1Zw7Ijs5VHkgV26erR8OKVSaHYx9txV6dRx0GBHmCSoQMr5oXq/wqFhqACQ3F6iPIX4DEy7ndRfT8GykOwzkIbsPcIeZrRCaRKxRn4yY5OkkL03Y8Zzg2Rd2YFI3wg85hMeJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ggUvnTFV; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ggUvnTFV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYYTB3FJmz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 17:54:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795503279; x=1827039279;
  h=date:from:to:cc:subject:message-id;
  bh=yTSBHmJa31nsZVl/rWN8x2PR42MTupbFarMvZZVyBm4=;
  b=ggUvnTFVvFOfA34l6Nkh/uhjZU+rvOZhySUBQ0uhctQcih+pMGlRqPVp
   JgeX6XMV4DQZ1rUJO76g3sIJKZF4akvrxw2GKd2nCFl4D9faYN7vgULUX
   qn7chb2Z6S57SnZ+i0yr4r86zy9M+dLr9SjjB6TMrg8PslMvASlM0Q47G
   TuAI7CM2fjixTSAizejToMHaMJcP6WX2TDnTQu6qCAr+xaNGlzitfUxkV
   tjQD/fQsM6dGnEG2ITacq2eJIUB9UEEtRV83ZxlWc7UAif4tV8uHX7yX9
   p51XVzIIIwdJYBXgOAm9TnKlnUgyuHO0b1p2+ksxLbBnhyP+JO8c8/KsN
   A==;
X-CSE-ConnectionGUID: GjYknWiWRQqqkx0B2aTkaA==
X-CSE-MsgGUID: Bzj3Ri7URciUUpfW8jO9Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4238946"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4238946"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 22:54:34 -0800
X-CSE-ConnectionGUID: ZHGHfEz2QeePHrbT8i6xeg==
X-CSE-MsgGUID: LI+AoW65TqKb2l972Jjhgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11367123"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 22:54:32 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xVkQ9-00000001OhU-2G0l;
	Tue, 24 Nov 2026 06:54:29 +0000
Date: Tue, 24 Nov 2026 14:54:11 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 e1c2c98f2516cf8d453344803313aadbaabb857e
Message-ID: <20261124145411.qaE0t8Zf-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git merge
branch HEAD: e1c2c98f2516cf8d453344803313aadbaabb857e  Automatic merge of 'fixes' into merge (2026-11-23 12:13)

elapsed time: 856m

configs tested: 663
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261123    gcc-14.4.0
alpha                 randconfig-2000-20261123    gcc-8.5.0
alpha                 randconfig-2000-20261124    gcc-11.5.0
alpha                 randconfig-2001-20261123    gcc-8.5.0
alpha                 randconfig-2001-20261124    gcc-11.5.0
alpha                 randconfig-2200-20261123    gcc-12.5.0 smatch
alpha                randconfig-r2106-20261123    gcc-14.4.0 cocci
alpha                randconfig-r2107-20261123    gcc-13.5.0 cocci
alpha                randconfig-r2108-20261123    gcc-10.5.0 cocci
alpha                randconfig-r2111-20261123    gcc-8.5.0  cocci
alpha                randconfig-r2300-20261124    clang-24   sparse
alpha                randconfig-r2301-20261123    gcc-11.5.0 sparse
alpha                randconfig-r2302-20261123    gcc-8.5.0  sparse
alpha                randconfig-r2303-20261123    gcc-14.4.0 sparse
alpha                randconfig-r2304-20261123    gcc-8.5.0  sparse
alpha                randconfig-r2305-20261123    gcc-11.5.0 sparse
alpha                randconfig-r2310-20261123    gcc-10.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                       axs103_smp_defconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261124    clang-24
arc                   randconfig-1001-20261124    clang-24
arc                   randconfig-2000-20261123    gcc-12.5.0
arc                   randconfig-2000-20261123    gcc-14.4.0
arc                   randconfig-2001-20261123    gcc-12.5.0
arc                   randconfig-2002-20261123    gcc-12.5.0
arc                   randconfig-2002-20261123    gcc-8.5.0
arc                   randconfig-2003-20261123    gcc-12.5.0
arc                   randconfig-2004-20261123    gcc-12.5.0
arc                   randconfig-2004-20261123    gcc-14.4.0
arc                   randconfig-2005-20261123    gcc-12.5.0
arc                   randconfig-2200-20261123    gcc-12.5.0 smatch
arc                   randconfig-2200-20261124    gcc-8.5.0  smatch
arc                  randconfig-r2102-20261123    gcc-8.5.0  cocci
arc                  randconfig-r2104-20261123    gcc-8.5.0  cocci
arc                  randconfig-r2106-20261123    gcc-13.5.0 cocci
arc                  randconfig-r2108-20261123    clang-20   cocci
arc                  randconfig-r2108-20261124    clang-24   cocci
arc                  randconfig-r2109-20261123    clang-20   cocci
arc                  randconfig-r2109-20261123    gcc-15.3.0 cocci
arc                  randconfig-r2109-20261123    gcc-8.5.0  cocci
arc                  randconfig-r2111-20261123    clang-17   cocci
arc                  randconfig-r2300-20261123    gcc-11.5.0 sparse
arc                  randconfig-r2304-20261123    gcc-15.3.0 sparse
arc                  randconfig-r2306-20261123    clang-24   sparse
arc                  randconfig-r2308-20261123    gcc-13.5.0 sparse
arc                  randconfig-r2309-20261123    clang-22   sparse
arc                  randconfig-r2310-20261123    gcc-13.5.0 sparse
arc                  randconfig-r2310-20261123    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          at91_dt_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                           ep93xx_defconfig    clang-24
arm                       footbridge_defconfig    clang-24
arm                         mvebu_v5_defconfig    clang-24
arm                   randconfig-1000-20261124    clang-24
arm                   randconfig-1001-20261124    clang-24
arm                   randconfig-1002-20261124    clang-24
arm                   randconfig-1003-20261124    clang-24
arm                   randconfig-2000-20261123    gcc-16.2.0
arm                   randconfig-2000-20261123    gcc-8.5.0
arm                   randconfig-2001-20261123    gcc-8.5.0
arm                   randconfig-2002-20261123    clang-20
arm                   randconfig-2002-20261123    gcc-8.5.0
arm                   randconfig-2200-20261123    gcc-8.5.0  smatch
arm                   randconfig-2200-20261124    clang-17   smatch
arm                  randconfig-r2100-20261123    gcc-8.5.0  cocci
arm                  randconfig-r2101-20261123    gcc-14.4.0 cocci
arm                  randconfig-r2103-20261123    gcc-8.5.0  cocci
arm                  randconfig-r2105-20261123    gcc-14.4.0 cocci
arm                  randconfig-r2106-20261123    clang-20   cocci
arm                  randconfig-r2106-20261123    gcc-8.5.0  cocci
arm                  randconfig-r2305-20261123    gcc-9.5.0  sparse
arm                  randconfig-r2306-20261123    clang-24   sparse
arm                  randconfig-r2308-20261123    clang-24   sparse
arm                  randconfig-r2309-20261123    clang-24   sparse
arm                          s5pv210_defconfig    clang-24
arm                         spear3xx_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261124    gcc-8.5.0
arm64                 randconfig-1001-20261124    gcc-8.5.0
arm64                 randconfig-1002-20261124    gcc-8.5.0
arm64                 randconfig-1003-20261124    gcc-8.5.0
arm64                 randconfig-2000-20261123    clang-24
arm64                 randconfig-2000-20261123    gcc-8.5.0
arm64                 randconfig-2001-20261123    gcc-8.5.0
arm64                 randconfig-2002-20261123    clang-24
arm64                 randconfig-2002-20261123    gcc-8.5.0
arm64                 randconfig-2200-20261123    clang-17   smatch
arm64                randconfig-r2100-20261123    gcc-8.5.0  cocci
arm64                randconfig-r2101-20261123    gcc-8.5.0  cocci
arm64                randconfig-r2103-20261123    gcc-8.5.0  cocci
arm64                randconfig-r2106-20261123    clang-17   cocci
arm64                randconfig-r2107-20261123    clang-17   cocci
arm64                randconfig-r2109-20261123    clang-17   cocci
arm64                randconfig-r2300-20261123    clang-24   sparse
arm64                randconfig-r2300-20261123    gcc-13.5.0 sparse
arm64                randconfig-r2301-20261123    gcc-14     sparse
arm64                randconfig-r2301-20261123    gcc-9.5.0  sparse
arm64                randconfig-r2303-20261123    gcc-8.5.0  sparse
arm64                randconfig-r2306-20261123    gcc-10.5.0 sparse
arm64                randconfig-r2309-20261123    gcc-13.5.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261124    gcc-8.5.0
csky                  randconfig-1001-20261124    gcc-8.5.0
csky                  randconfig-2000-20261123    gcc-12.5.0
csky                  randconfig-2000-20261123    gcc-14.4.0
csky                  randconfig-2001-20261123    gcc-12.5.0
csky                  randconfig-2200-20261123    gcc-16.2.0 smatch
csky                  randconfig-2200-20261124    gcc-15.3.0 smatch
csky                 randconfig-r2102-20261124    clang-24   cocci
csky                 randconfig-r2105-20261123    gcc-8.5.0  cocci
csky                 randconfig-r2107-20261123    clang-17   cocci
csky                 randconfig-r2107-20261123    gcc-8.5.0  cocci
csky                 randconfig-r2108-20261123    gcc-16.2.0 cocci
csky                 randconfig-r2306-20261123    clang-22   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261124    gcc-10.5.0
hexagon               randconfig-1001-20261124    gcc-10.5.0
hexagon               randconfig-2000-20261123    clang-18
hexagon               randconfig-2000-20261123    gcc-12.5.0
hexagon               randconfig-2001-20261123    clang-24
hexagon               randconfig-2001-20261123    gcc-12.5.0
hexagon               randconfig-2200-20261123    clang-24   smatch
hexagon               randconfig-2200-20261124    clang-24   smatch
hexagon              randconfig-r2100-20261123    gcc-8.5.0  cocci
hexagon              randconfig-r2105-20261123    gcc-8.5.0  cocci
hexagon              randconfig-r2105-20261124    clang-24   cocci
hexagon              randconfig-r2107-20261123    clang-20   cocci
hexagon              randconfig-r2111-20261123    clang-24   cocci
hexagon              randconfig-r2300-20261123    gcc-14.4.0 sparse
hexagon              randconfig-r2301-20261123    clang-24   sparse
hexagon              randconfig-r2302-20261124    clang-24   sparse
hexagon              randconfig-r2307-20261123    clang-24   sparse
hexagon              randconfig-r2309-20261123    gcc-12.5.0 sparse
hexagon              randconfig-r2309-20261123    gcc-15.3.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261124    gcc-12
i386        buildonly-randconfig-1001-20261124    gcc-12
i386        buildonly-randconfig-1002-20261124    gcc-12
i386        buildonly-randconfig-1003-20261124    gcc-12
i386        buildonly-randconfig-1004-20261124    gcc-12
i386        buildonly-randconfig-1005-20261124    gcc-12
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261124    gcc-14
i386                  randconfig-1001-20261124    gcc-14
i386                  randconfig-1002-20261124    gcc-14
i386                  randconfig-1003-20261124    gcc-14
i386                  randconfig-1004-20261124    gcc-14
i386                  randconfig-1005-20261124    gcc-14
i386                  randconfig-1006-20261124    gcc-14
i386                  randconfig-2000-20261123    gcc-14
i386                  randconfig-2000-20261124    gcc-14
i386                  randconfig-2001-20261123    gcc-14
i386                  randconfig-2001-20261124    gcc-14
i386                  randconfig-2002-20261123    gcc-14
i386                  randconfig-2002-20261124    gcc-14
i386                  randconfig-2003-20261123    gcc-14
i386                  randconfig-2003-20261124    gcc-14
i386                  randconfig-2004-20261123    gcc-14
i386                  randconfig-2004-20261124    gcc-14
i386                  randconfig-2005-20261123    gcc-14
i386                  randconfig-2005-20261124    gcc-14
i386                  randconfig-2100-20261123    clang-22   cocci
i386                  randconfig-2101-20261123    clang-22   cocci
i386                  randconfig-2102-20261123    clang-22   cocci
i386                  randconfig-2103-20261123    clang-22   cocci
i386                  randconfig-2103-20261123    gcc-14     cocci
i386                  randconfig-2104-20261123    clang-22   cocci
i386                  randconfig-2105-20261123    clang-22   cocci
i386                  randconfig-2105-20261123    gcc-14     cocci
i386                  randconfig-2200-20261123    gcc-14     smatch
i386                  randconfig-2200-20261124    clang-22   smatch
i386                  randconfig-2300-20261123    gcc-13     sparse
i386                  randconfig-2300-20261123    gcc-14     sparse
i386                  randconfig-2300-20261124    gcc-14     sparse
i386                  randconfig-2301-20261123    clang-22   sparse
i386                  randconfig-2301-20261123    gcc-14     sparse
i386                  randconfig-2301-20261124    gcc-14     sparse
i386                  randconfig-2302-20261123    clang-22   sparse
i386                  randconfig-2302-20261123    gcc-14     sparse
i386                  randconfig-2302-20261124    gcc-14     sparse
i386                 randconfig-r2100-20261123    gcc-14     cocci
i386                 randconfig-r2104-20261123    gcc-14     cocci
i386                 randconfig-r2106-20261123    clang-20   cocci
i386                 randconfig-r2108-20261123    gcc-8.5.0  cocci
i386                 randconfig-r2110-20261123    gcc-13.5.0 cocci
i386                 randconfig-r2300-20261123    gcc-8.5.0  sparse
i386                 randconfig-r2305-20261123    clang-24   sparse
i386                 randconfig-r2309-20261123    clang-24   sparse
i386                 randconfig-r2310-20261123    clang-22   sparse
i386                 randconfig-r2310-20261123    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261124    gcc-10.5.0
loongarch             randconfig-1001-20261124    gcc-10.5.0
loongarch             randconfig-2000-20261123    gcc-16.2.0
loongarch             randconfig-2000-20261124    clang-18
loongarch             randconfig-2001-20261123    clang-22
loongarch             randconfig-2001-20261123    gcc-16.2.0
loongarch             randconfig-2001-20261124    clang-18
loongarch             randconfig-2200-20261123    clang-24   smatch
loongarch            randconfig-r2100-20261123    gcc-14     cocci
loongarch            randconfig-r2101-20261124    clang-24   cocci
loongarch            randconfig-r2103-20261123    gcc-16.2.0 cocci
loongarch            randconfig-r2104-20261123    gcc-12.5.0 cocci
loongarch            randconfig-r2105-20261123    gcc-16.2.0 cocci
loongarch            randconfig-r2108-20261123    clang-20   cocci
loongarch            randconfig-r2109-20261123    gcc-13.5.0 cocci
loongarch            randconfig-r2302-20261123    gcc-11.5.0 sparse
loongarch            randconfig-r2302-20261123    gcc-14     sparse
loongarch            randconfig-r2302-20261123    gcc-14.4.0 sparse
loongarch            randconfig-r2305-20261123    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    clang-24
m68k                        m5235evb_defconfig    clang-24
m68k                       m54418evb_defconfig    gcc-16.2.0
m68k                        m5475evb_defconfig    clang-17
m68k                  randconfig-2000-20261123    gcc-15.3.0
m68k                  randconfig-2000-20261123    gcc-8.5.0
m68k                  randconfig-2000-20261124    gcc-11.5.0
m68k                  randconfig-2001-20261123    gcc-8.5.0
m68k                  randconfig-2001-20261123    gcc-9.5.0
m68k                  randconfig-2001-20261124    gcc-11.5.0
m68k                  randconfig-2200-20261123    gcc-8.5.0  smatch
m68k                  randconfig-2200-20261124    gcc-10.5.0 smatch
m68k                 randconfig-r2100-20261123    gcc-8.5.0  cocci
m68k                 randconfig-r2101-20261123    gcc-12.5.0 cocci
m68k                 randconfig-r2101-20261123    gcc-16.2.0 cocci
m68k                 randconfig-r2101-20261123    gcc-8.5.0  cocci
m68k                 randconfig-r2102-20261123    gcc-12.5.0 cocci
m68k                 randconfig-r2102-20261123    gcc-8.5.0  cocci
m68k                 randconfig-r2103-20261123    gcc-12.5.0 cocci
m68k                 randconfig-r2303-20261123    clang-24   sparse
m68k                 randconfig-r2303-20261123    gcc-14     sparse
m68k                 randconfig-r2303-20261123    gcc-14.4.0 sparse
m68k                 randconfig-r2304-20261123    gcc-14.4.0 sparse
m68k                 randconfig-r2305-20261123    gcc-13.5.0 sparse
m68k                 randconfig-r2305-20261123    gcc-8.5.0  sparse
m68k                 randconfig-r2307-20261123    gcc-8.5.0  sparse
m68k                 randconfig-r2308-20261123    clang-22   sparse
m68k                 randconfig-r2308-20261123    gcc-10.5.0 sparse
m68k                 randconfig-r2308-20261123    gcc-14     sparse
m68k                 randconfig-r2309-20261123    gcc-8.5.0  sparse
m68k                 randconfig-r2310-20261123    gcc-12.5.0 sparse
m68k                            sun3_defconfig    clang-17
m68k                            sun3_defconfig    gcc-16.2.0
microblaze                        alldefconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261123    gcc-8.5.0
microblaze            randconfig-2000-20261124    gcc-11.5.0
microblaze            randconfig-2001-20261124    gcc-11.5.0
microblaze            randconfig-2200-20261123    gcc-16.2.0 smatch
microblaze           randconfig-r2105-20261123    gcc-8.5.0  cocci
microblaze           randconfig-r2109-20261123    gcc-16.2.0 cocci
microblaze           randconfig-r2110-20261123    clang-17   cocci
microblaze           randconfig-r2301-20261123    gcc-8.5.0  sparse
microblaze           randconfig-r2302-20261123    clang-24   sparse
microblaze           randconfig-r2302-20261123    gcc-8.5.0  sparse
microblaze           randconfig-r2304-20261123    clang-24   sparse
microblaze           randconfig-r2306-20261123    gcc-12.5.0 sparse
microblaze           randconfig-r2309-20261123    gcc-10.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                          cobalt_defconfig    clang-24
mips                          db1xxx_defconfig    gcc-16.2.0
mips                     maltaup_xpa_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261123    gcc-10.5.0
mips                  randconfig-2000-20261123    gcc-8.5.0
mips                  randconfig-2000-20261124    gcc-16.2.0
mips                  randconfig-2001-20261123    gcc-10.5.0
mips                  randconfig-2001-20261124    gcc-16.2.0
mips                  randconfig-2002-20261123    gcc-10.5.0
mips                  randconfig-2002-20261123    gcc-16.2.0
mips                  randconfig-2002-20261124    gcc-16.2.0
mips                  randconfig-2200-20261123    gcc-14.4.0 smatch
mips                 randconfig-r2102-20261123    gcc-14     cocci
mips                 randconfig-r2103-20261123    gcc-8.5.0  cocci
mips                 randconfig-r2107-20261124    clang-24   cocci
mips                 randconfig-r2110-20261123    gcc-8.5.0  cocci
mips                 randconfig-r2300-20261123    clang-22   sparse
mips                 randconfig-r2301-20261123    gcc-8.5.0  sparse
mips                 randconfig-r2304-20261123    gcc-11.5.0 sparse
mips                 randconfig-r2304-20261123    gcc-13.5.0 sparse
mips                 randconfig-r2305-20261123    gcc-9.5.0  sparse
mips                 randconfig-r2311-20261123    clang-22   sparse
mips                 randconfig-r2311-20261123    gcc-12.5.0 sparse
mips                 randconfig-r2311-20261123    gcc-8.5.0  sparse
mips                            rs90_defconfig    gcc-16.2.0
mips                            xway_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261124    gcc-10.5.0
nios2                 randconfig-1001-20261124    gcc-10.5.0
nios2                 randconfig-2000-20261123    gcc-16.2.0
nios2                 randconfig-2000-20261123    gcc-8.5.0
nios2                 randconfig-2000-20261124    clang-18
nios2                 randconfig-2001-20261123    gcc-11.5.0
nios2                 randconfig-2001-20261123    gcc-16.2.0
nios2                 randconfig-2001-20261124    clang-18
nios2                 randconfig-2200-20261123    gcc-8.5.0  smatch
nios2                randconfig-r2102-20261123    gcc-8.5.0  cocci
nios2                randconfig-r2103-20261124    clang-24   cocci
nios2                randconfig-r2106-20261123    gcc-13.5.0 cocci
nios2                randconfig-r2106-20261123    gcc-15.3.0 cocci
nios2                randconfig-r2108-20261123    clang-17   cocci
nios2                randconfig-r2109-20261123    clang-20   cocci
nios2                randconfig-r2110-20261123    clang-17   cocci
nios2                randconfig-r2110-20261123    gcc-16.2.0 cocci
nios2                randconfig-r2300-20261123    gcc-9.5.0  sparse
nios2                randconfig-r2303-20261123    gcc-11.5.0 sparse
nios2                randconfig-r2304-20261123    clang-22   sparse
nios2                randconfig-r2304-20261123    gcc-8.5.0  sparse
nios2                randconfig-r2307-20261123    gcc-13.5.0 sparse
nios2                randconfig-r2308-20261123    gcc-15.3.0 sparse
nios2                randconfig-r2311-20261123    gcc-14     sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261123    gcc-10.5.0
openrisc              randconfig-2000-20261124    gcc-16.2.0
openrisc              randconfig-2001-20261123    gcc-10.5.0
openrisc              randconfig-2001-20261123    gcc-16.2.0
openrisc              randconfig-2001-20261124    gcc-16.2.0
openrisc              randconfig-2002-20261123    gcc-10.5.0
openrisc              randconfig-2002-20261124    gcc-16.2.0
openrisc              randconfig-2200-20261123    gcc-12.5.0 smatch
openrisc              randconfig-2200-20261124    gcc-11.5.0 smatch
openrisc             randconfig-r2101-20261123    gcc-8.5.0  cocci
openrisc             randconfig-r2108-20261123    gcc-13.5.0 cocci
openrisc             randconfig-r2303-20261123    gcc-9.5.0  sparse
openrisc             randconfig-r2304-20261123    gcc-14     sparse
openrisc             randconfig-r2305-20261123    clang-22   sparse
openrisc             randconfig-r2311-20261123    clang-24   sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                 generic-32bit_defconfig    clang-17
parisc                randconfig-1000-20261124    clang-24
parisc                randconfig-1001-20261124    clang-24
parisc                randconfig-2000-20261123    gcc-16.2.0
parisc                randconfig-2000-20261123    gcc-8.5.0
parisc                randconfig-2000-20261124    clang-18
parisc                randconfig-2001-20261123    gcc-10.5.0
parisc                randconfig-2001-20261123    gcc-16.2.0
parisc                randconfig-2001-20261124    clang-18
parisc                randconfig-2200-20261123    gcc-14.4.0 smatch
parisc               randconfig-r2100-20261123    gcc-14.4.0 cocci
parisc               randconfig-r2104-20261123    gcc-8.5.0  cocci
parisc               randconfig-r2109-20261123    gcc-14.4.0 cocci
parisc               randconfig-r2110-20261123    gcc-8.5.0  cocci
parisc               randconfig-r2303-20261123    gcc-13.5.0 sparse
parisc               randconfig-r2304-20261124    clang-24   sparse
parisc               randconfig-r2305-20261123    gcc-14     sparse
parisc               randconfig-r2305-20261123    gcc-14.4.0 sparse
parisc               randconfig-r2306-20261123    gcc-13.5.0 sparse
parisc               randconfig-r2307-20261123    gcc-12.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    gcc-16.2.0
powerpc                       cm5200_defconfig    clang-24
powerpc                        ebony_defconfig    clang-24
powerpc                         icon_defconfig    clang-17
powerpc                   mpc866_ads_defconfig    clang-17
powerpc                     mvme5100_defconfig    gcc-16.2.0
powerpc                        ppc64_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261124    clang-24
powerpc               randconfig-1001-20261124    clang-24
powerpc               randconfig-2000-20261123    clang-21
powerpc               randconfig-2001-20261123    clang-21
powerpc               randconfig-2002-20261123    clang-21
powerpc               randconfig-2200-20261123    gcc-9.5.0  smatch
powerpc               randconfig-2200-20261124    clang-21   smatch
powerpc              randconfig-r2102-20261123    gcc-14.4.0 cocci
powerpc              randconfig-r2104-20261123    gcc-8.5.0  cocci
powerpc              randconfig-r2111-20261123    gcc-13.5.0 cocci
powerpc              randconfig-r2300-20261123    gcc-8.5.0  sparse
powerpc              randconfig-r2301-20261123    gcc-14.4.0 sparse
powerpc              randconfig-r2301-20261123    gcc-9.5.0  sparse
powerpc              randconfig-r2307-20261123    clang-22   sparse
powerpc              randconfig-r2310-20261123    gcc-14     sparse
powerpc              randconfig-r2311-20261123    gcc-10.5.0 sparse
powerpc                      skiroot_defconfig    clang-17
powerpc                      skiroot_defconfig    clang-24
powerpc                     socrates_defconfig    gcc-16.2.0
powerpc                      stx_gp3_defconfig    gcc-16.2.0
powerpc                      tqm8541_defconfig    gcc-16.2.0
powerpc                      tqm8560_defconfig    gcc-16.2.0
powerpc                       tqm8xx_defconfig    clang-24
powerpc64                         alldefconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261124    clang-24
powerpc64             randconfig-1001-20261124    clang-24
powerpc64             randconfig-2000-20261123    clang-21
powerpc64             randconfig-2001-20261123    clang-21
powerpc64             randconfig-2002-20261123    clang-21
powerpc64             randconfig-2200-20261123    gcc-15.3.0 smatch
powerpc64             randconfig-2200-20261124    gcc-12.5.0 smatch
powerpc64            randconfig-r2100-20261123    gcc-8.5.0  cocci
powerpc64            randconfig-r2102-20261123    gcc-8.5.0  cocci
powerpc64            randconfig-r2103-20261123    gcc-14     cocci
powerpc64            randconfig-r2103-20261123    gcc-14.4.0 cocci
powerpc64            randconfig-r2302-20261123    gcc-13.5.0 sparse
powerpc64            randconfig-r2303-20261124    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-17
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261124    gcc-11.5.0
riscv                 randconfig-1001-20261124    gcc-11.5.0
riscv                 randconfig-2000-20261123    gcc-11.5.0
riscv                 randconfig-2001-20261123    gcc-11.5.0
riscv                 randconfig-2002-20261123    gcc-11.5.0
riscv                 randconfig-2003-20261123    gcc-11.5.0
riscv                 randconfig-2004-20261123    gcc-11.5.0
riscv                 randconfig-2005-20261123    gcc-11.5.0
riscv                 randconfig-2200-20261123    clang-17   smatch
riscv                 randconfig-2200-20261124    gcc-14.4.0 smatch
riscv                randconfig-r2100-20261123    gcc-16.2.0 cocci
riscv                randconfig-r2105-20261123    gcc-14     cocci
riscv                randconfig-r2106-20261124    clang-24   cocci
riscv                randconfig-r2108-20261123    gcc-14.4.0 cocci
riscv                randconfig-r2110-20261123    clang-20   cocci
riscv                randconfig-r2110-20261123    gcc-14.4.0 cocci
riscv                randconfig-r2111-20261123    gcc-14.4.0 cocci
riscv                randconfig-r2302-20261123    gcc-14.4.0 sparse
riscv                randconfig-r2306-20261123    gcc-15.3.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261124    gcc-11.5.0
s390                  randconfig-1001-20261124    gcc-11.5.0
s390                  randconfig-2000-20261123    clang-20
s390                  randconfig-2000-20261123    gcc-15.3.0
s390                  randconfig-2001-20261123    clang-20
s390                  randconfig-2001-20261123    gcc-9.5.0
s390                  randconfig-2002-20261123    clang-20
s390                  randconfig-2003-20261123    clang-20
s390                  randconfig-2003-20261123    clang-22
s390                  randconfig-2004-20261123    clang-20
s390                  randconfig-2004-20261123    gcc-15.3.0
s390                  randconfig-2005-20261123    clang-20
s390                  randconfig-2005-20261123    gcc-8.5.0
s390                  randconfig-2200-20261123    clang-24   smatch
s390                  randconfig-2200-20261124    clang-24   smatch
s390                 randconfig-r2104-20261123    gcc-16.2.0 cocci
s390                 randconfig-r2104-20261123    gcc-8.5.0  cocci
s390                 randconfig-r2108-20261123    gcc-15.3.0 cocci
s390                 randconfig-r2110-20261123    clang-20   cocci
s390                 randconfig-r2301-20261123    gcc-14.4.0 sparse
s390                 randconfig-r2302-20261123    clang-22   sparse
s390                 randconfig-r2303-20261123    clang-22   sparse
s390                 randconfig-r2308-20261123    clang-24   sparse
s390                 randconfig-r2311-20261123    gcc-13.5.0 sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                             migor_defconfig    clang-24
sh                    randconfig-1000-20261124    gcc-11.5.0
sh                    randconfig-1001-20261124    gcc-11.5.0
sh                    randconfig-2000-20261123    gcc-16.2.0
sh                    randconfig-2001-20261123    gcc-16.2.0
sh                    randconfig-2002-20261123    gcc-10.5.0
sh                    randconfig-2002-20261123    gcc-16.2.0
sh                    randconfig-2003-20261123    gcc-16.2.0
sh                    randconfig-2004-20261123    gcc-14.4.0
sh                    randconfig-2004-20261123    gcc-16.2.0
sh                    randconfig-2005-20261123    gcc-16.2.0
sh                    randconfig-2200-20261123    gcc-16.2.0 smatch
sh                    randconfig-2200-20261124    gcc-16.2.0 smatch
sh                   randconfig-r2106-20261123    clang-17   cocci
sh                   randconfig-r2107-20261123    gcc-14.4.0 cocci
sh                   randconfig-r2108-20261123    clang-17   cocci
sh                   randconfig-r2110-20261124    clang-24   cocci
sh                   randconfig-r2111-20261123    clang-20   cocci
sh                   randconfig-r2111-20261123    gcc-15.3.0 cocci
sh                   randconfig-r2302-20261123    gcc-9.5.0  sparse
sh                   randconfig-r2304-20261123    gcc-14.4.0 sparse
sh                   randconfig-r2306-20261123    gcc-14     sparse
sh                   randconfig-r2306-20261123    gcc-8.5.0  sparse
sh                   randconfig-r2310-20261123    gcc-15.3.0 sparse
sh                           sdk7780_defconfig    gcc-16.2.0
sh                           sdk7786_defconfig    clang-24
sh                            se7619_defconfig    gcc-16.2.0
sh                            se7721_defconfig    gcc-16.2.0
sh                            se7780_defconfig    clang-24
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                    sh7770_generic_defconfig    clang-24
sh                           urquell_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261124    clang-24
sparc                 randconfig-1001-20261124    clang-24
sparc                 randconfig-2000-20261123    gcc-9.5.0
sparc                 randconfig-2000-20261124    gcc-8.5.0
sparc                 randconfig-2001-20261123    gcc-9.5.0
sparc                 randconfig-2001-20261124    gcc-8.5.0
sparc                 randconfig-2200-20261123    gcc-12.5.0 smatch
sparc                 randconfig-2200-20261124    gcc-11.5.0 smatch
sparc                randconfig-r2100-20261124    clang-24   cocci
sparc                randconfig-r2101-20261123    gcc-8.5.0  cocci
sparc                randconfig-r2102-20261123    gcc-14     cocci
sparc                randconfig-r2104-20261123    gcc-14.4.0 cocci
sparc                randconfig-r2105-20261123    gcc-12.5.0 cocci
sparc                randconfig-r2107-20261123    gcc-12.5.0 cocci
sparc                randconfig-r2107-20261123    gcc-16.2.0 cocci
sparc                randconfig-r2303-20261123    gcc-8.5.0  sparse
sparc                randconfig-r2304-20261123    gcc-9.5.0  sparse
sparc                randconfig-r2305-20261123    gcc-14.4.0 sparse
sparc                randconfig-r2307-20261123    gcc-10.5.0 sparse
sparc                randconfig-r2307-20261123    gcc-15.3.0 sparse
sparc                randconfig-r2308-20261123    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261124    clang-24
sparc64               randconfig-1001-20261124    clang-24
sparc64               randconfig-2000-20261123    gcc-9.5.0
sparc64               randconfig-2000-20261124    gcc-8.5.0
sparc64               randconfig-2001-20261123    gcc-9.5.0
sparc64               randconfig-2001-20261124    gcc-8.5.0
sparc64               randconfig-2200-20261123    clang-22   smatch
sparc64               randconfig-2200-20261124    clang-24   smatch
sparc64              randconfig-r2103-20261123    gcc-14     cocci
sparc64              randconfig-r2104-20261123    gcc-14     cocci
sparc64              randconfig-r2104-20261124    clang-24   cocci
sparc64              randconfig-r2106-20261123    gcc-16.2.0 cocci
sparc64              randconfig-r2111-20261123    clang-20   cocci
sparc64              randconfig-r2302-20261123    gcc-8.5.0  sparse
sparc64              randconfig-r2311-20261123    gcc-15.3.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261124    clang-24
um                    randconfig-1001-20261124    clang-24
um                    randconfig-2000-20261123    gcc-9.5.0
um                    randconfig-2000-20261124    gcc-8.5.0
um                    randconfig-2001-20261123    gcc-9.5.0
um                    randconfig-2001-20261124    gcc-8.5.0
um                    randconfig-2200-20261123    clang-21   smatch
um                    randconfig-2200-20261124    gcc-14     smatch
um                   randconfig-r2103-20261123    gcc-8.5.0  cocci
um                   randconfig-r2105-20261123    gcc-14     cocci
um                   randconfig-r2105-20261123    gcc-8.5.0  cocci
um                   randconfig-r2109-20261124    clang-24   cocci
um                   randconfig-r2111-20261123    clang-17   cocci
um                   randconfig-r2300-20261123    gcc-14     sparse
um                   randconfig-r2301-20261124    clang-24   sparse
um                   randconfig-r2305-20261124    clang-24   sparse
um                   randconfig-r2307-20261123    gcc-14     sparse
um                   randconfig-r2310-20261123    clang-24   sparse
um                   randconfig-r2311-20261123    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261124    gcc-14
x86_64      buildonly-randconfig-1001-20261124    gcc-14
x86_64      buildonly-randconfig-1002-20261124    gcc-14
x86_64      buildonly-randconfig-1003-20261124    gcc-14
x86_64      buildonly-randconfig-1004-20261124    gcc-14
x86_64      buildonly-randconfig-1005-20261124    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261124    gcc-12
x86_64                randconfig-1001-20261124    gcc-12
x86_64                randconfig-1002-20261124    gcc-12
x86_64                randconfig-1003-20261124    gcc-12
x86_64                randconfig-1004-20261124    gcc-12
x86_64                randconfig-1005-20261124    gcc-12
x86_64                randconfig-2000-20261123    gcc-14
x86_64                randconfig-2000-20261124    gcc-14
x86_64                randconfig-2001-20261123    gcc-14
x86_64                randconfig-2001-20261124    gcc-14
x86_64                randconfig-2002-20261123    gcc-14
x86_64                randconfig-2002-20261124    gcc-14
x86_64                randconfig-2003-20261123    gcc-14
x86_64                randconfig-2003-20261124    gcc-14
x86_64                randconfig-2004-20261123    gcc-14
x86_64                randconfig-2004-20261124    gcc-14
x86_64                randconfig-2005-20261123    gcc-14
x86_64                randconfig-2005-20261124    gcc-14
x86_64                randconfig-2100-20261123    clang-22   cocci
x86_64                randconfig-2100-20261123    gcc-14     cocci
x86_64                randconfig-2101-20261123    clang-22   cocci
x86_64                randconfig-2102-20261123    clang-22   cocci
x86_64                randconfig-2103-20261123    clang-22   cocci
x86_64                randconfig-2104-20261123    clang-22   cocci
x86_64                randconfig-2105-20261123    clang-22   cocci
x86_64                randconfig-2105-20261123    gcc-13     cocci
x86_64                randconfig-2200-20261123    gcc-14     smatch
x86_64                randconfig-2200-20261124    gcc-14     smatch
x86_64                randconfig-2300-20261123    clang-22   sparse
x86_64                randconfig-2300-20261123    gcc-14     sparse
x86_64                randconfig-2300-20261124    gcc-14     sparse
x86_64                randconfig-2301-20261123    gcc-14     sparse
x86_64                randconfig-2301-20261124    gcc-14     sparse
x86_64                randconfig-2302-20261123    gcc-14     sparse
x86_64                randconfig-2302-20261124    gcc-14     sparse
x86_64               randconfig-r2101-20261123    gcc-14     cocci
x86_64               randconfig-r2104-20261123    gcc-8.5.0  cocci
x86_64               randconfig-r2107-20261123    gcc-15.3.0 cocci
x86_64               randconfig-r2109-20261123    clang-17   cocci
x86_64               randconfig-r2300-20261123    clang-22   sparse
x86_64               randconfig-r2301-20261123    gcc-13.5.0 sparse
x86_64               randconfig-r2309-20261123    gcc-14     sparse
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
xtensa                randconfig-1000-20261124    clang-24
xtensa                randconfig-1001-20261124    clang-24
xtensa                randconfig-2000-20261123    gcc-12.5.0
xtensa                randconfig-2000-20261123    gcc-16.2.0
xtensa                randconfig-2001-20261123    gcc-12.5.0
xtensa                randconfig-2001-20261123    gcc-8.5.0
xtensa                randconfig-2200-20261123    gcc-8.5.0  smatch
xtensa               randconfig-r2101-20261123    gcc-14     cocci
xtensa               randconfig-r2101-20261123    gcc-8.5.0  cocci
xtensa               randconfig-r2102-20261123    gcc-16.2.0 cocci
xtensa               randconfig-r2109-20261123    gcc-16.2.0 cocci
xtensa               randconfig-r2110-20261123    gcc-15.3.0 cocci
xtensa               randconfig-r2111-20261123    gcc-16.2.0 cocci
xtensa               randconfig-r2111-20261124    clang-24   cocci
xtensa               randconfig-r2301-20261123    clang-22   sparse
xtensa               randconfig-r2308-20261123    gcc-12.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

