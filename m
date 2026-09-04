Return-Path: <linuxppc-dev+bounces-26532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC31C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:25:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmfj5sYpz2y2K;
	Fri, 04 Sep 2026 16:25:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788503117;
	cv=none; b=Ru3SyPJ/miPAqZqGIwPZ9eik3Ffo27k+EOo75OrOeqidWZgiIE3t0vT+CFHQwGd/1OE0zDL99gOeHIciLu9ceJZnW1asV3+EV58xcQLMy5dOVNhn/8CHiqU10LQg6+CDIr4t4M5wtDG0FpR0zmStyffPV8iy4vJ1lv5tWnwPtJMvSENMZQyr+fM/fNJRGNiWhUUbsTpUEJckeVu6C/BusoMtHI/7+4/o+FqNmvowUbX24IdNd3nGJOHZupY3pRdp3R//qI0o4Of/hs5hzqdDDWI4m/V24+6J4XzKkI0PkY0Lut0QlUTOC1thkrzhkpaLkNOXQ6tQxcgw64cW/MkJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788503117; c=relaxed/relaxed;
	bh=AZ+gkL+kAhz70qMRssvC2XkaP7rEvg3/EkCtVOXdxqs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=m9v18vAiybJDgFq6yY5q99fWvocrj2tE0pWMBWBoIiI6j9LJ4mPOD/A3CGZO0kX3vvbrQn2sNWZwmwwRlObb1kkfzjvvbO/2e6PX7IvufTcYg783Uvrwgg1AfRpsD5WXofkiWpvvBiQa6/lie34mN+wMJL5Tp2ekAv+I6bAmIQTpQI5n4fAg/58pdgtUFNuqCmgIiWjhkc49PxLeKegXy6J03z6s9o6aK8C2/UQ6VQGLKf8ihiGllUoOZremAqs1Vdf2MTM5mUq1Gtmpku8oaMzaCwC5fZVP/dM7PvWZqQneTdRatHEdZAJE4tPLi+N0i/ixjZxVdIFg2Z53/x8omw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OKg/rngG; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OKg/rngG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmff20TTz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:25:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788503115; x=1820039115;
  h=date:from:to:cc:subject:message-id;
  bh=Q0thsJVCL2yWgmeCwzBjtrK20hyy/5448rohEyXqDzs=;
  b=OKg/rngGqdBQOL9BRL8YFH11/ybUNDP+7DzMESPkFGKYVONCqATl3XL2
   ckbqCl47WKTsXd055XSOod7N2VMrER3AISt35oN3++TCKHZxUZ0wQkOvd
   CQTrtBoEN67Z8RVQdRMF/m0jQ9KZkGf/QhAkwfzaw1wb7ooAv8l9eqvGR
   fHTXlKOBVyfUOhpytg3hskTRG7/BG9dk3FurFGYgGerP8xe2VabhxPiGH
   Me4G0zhlxrXwnKOce3/cvCqM68tmRNStfebKIuVJT9fMKtg5CkH+dkZsU
   lJ1YEyZLosr+1x3/ICOYWD4YAl51w+bXLTO/OGlqtHvD7X5OR0LcTO7z3
   g==;
X-CSE-ConnectionGUID: r8SuqJ4kTK6ClUJ1caZh7g==
X-CSE-MsgGUID: 1+OfVN7STZ6XO1P9wPID7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92697061"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92697061"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:25:08 -0700
X-CSE-ConnectionGUID: LKpuIoMqSYOfxFn/41FDrw==
X-CSE-MsgGUID: UvVMnzjgRpq7G3TqSeJxhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="273735904"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Sep 2026 23:25:07 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x2NMG-000000005y6-2mgj;
	Fri, 04 Sep 2026 06:25:04 +0000
Date: Fri, 04 Sep 2026 14:24:46 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 a20e19e5e5b03d547359f0f0b614ad3c2370fed7
Message-ID: <202609041443.M9kBxIE6-lkp@intel.com>
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
branch HEAD: a20e19e5e5b03d547359f0f0b614ad3c2370fed7  Automatic merge of 'fixes' into merge (2026-09-02 12:26)

elapsed time: 2816m

configs tested: 61
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-24
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    clang-20
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    clang-24
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-14
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

