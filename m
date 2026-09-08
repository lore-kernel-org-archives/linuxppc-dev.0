Return-Path: <linuxppc-dev+bounces-26759-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CFEC79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:14:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfGv30T6Cz2xlJ;
	Tue, 08 Sep 2026 18:14:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788855279;
	cv=none; b=cS93UTdKuY9WGwIDENReudPx0pUyveVHzXJdHJCTh9ruGd3thrqNlqx1vR5PzB/rp/BuTMAYf3mZSWFNdajRHF0iNmme9wPdJNgrmX1vK+tB3HWMlcUxK7T4GcITn+KFDHUklfyrH0eq4pGC6aiexDpBWOCx45mXumsKklRbnKae35Xn0RJcDgKehUct0+uKzbgItkGguujsvSItvDrojqMnZIFhobSFafBlNAKV5Mgg7V0zPzJyvmNQEpjuxHgR6Z8pkelQJOszaFvYfNnqaJITEmVRpk1ggGNCb5PxY1nfKP7qWHEfyjoxS2HROYGx6rY1xbBSNGOR19cyL5aqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788855279; c=relaxed/relaxed;
	bh=y0iy/6PXQnFBdlEZNqZ9ir3wK3mqCVMj0sMsXlHYipI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QNzzYBwcb0HkaHrDV9P3i9sWZOz1MVjXiI3kt64O4HSsLXjvnNYAO8/bxvZmPGNcaSRtaBu80/Ywfhu7+EwkS1pJRrxZTgZ6qj3pvVvVdO6MEzF09jjYJf5Q41rf9HBsmQeTEhAdpn89J0ouRqmW0skbPTVgJ83EOCVtQfSZBeQCWsGQVZNYeaj/Wf8W7ZQPtJxFZmXGTQiRB7QMl9JeCP7ZFDGYVwaOl9Uy15XznY+6I/P5JKZg/qx2JT1hDgGsTzwUJTvzznd+npxp02Rd3zND1cTETLasxFJAy5+ZD243JkiGYxzoWXW/1R4ADAxzExj7qFomQdf+KdPN9/+oeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L8f5BFjv; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L8f5BFjv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfGv14s0kz2yqf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:14:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788855278; x=1820391278;
  h=date:from:to:cc:subject:message-id;
  bh=c7Icu6No/gCX7KSUPr1TVYUL03c9Nd+5pkwY8hvcB+4=;
  b=L8f5BFjvbfOgZkYeXVYHzIQR/tFcuuWQBfETNzcmGZXaGoR/t+WWw3Wd
   oEq7zyMLayPpJkSnrMSFbyvzJqj5XuZTw7jPpCQZYx7YUIwI+4Ng/SX33
   Qcdl8T0e0Nw8HEMftSB68jgoNkZyQOWAHSzQHXxXe1SCVwo1LfoCPb8vU
   TIkadHkG2f/GllPDNaxJoojy14SIu4laW8fXKDQ+4KFbIMhkN6TSFvs15
   yt3vMplRGOCRz8Xga5G6NLXRyT1clVdZ3Of8hy/iZr9rcReo+svsSFu4v
   SU8foP3HDq2ZP/r+2DW23xNUAGk7/bDvyEEVk5jtsGOMmjJh8zkrZXaSH
   g==;
X-CSE-ConnectionGUID: fsXlf7ZXQliUchrhQLQ5hQ==
X-CSE-MsgGUID: UZ5+6CMoQV2Nrxe2z/GR6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100409301"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="100409301"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:14:26 -0700
X-CSE-ConnectionGUID: KTOOY2xlQleH6W7fwivfxQ==
X-CSE-MsgGUID: q7+LF2hBTp+cKhn4HMgYEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="267683683"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 Sep 2026 01:14:23 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3qyD-000000001sc-0BTz;
	Tue, 08 Sep 2026 08:14:21 +0000
Date: Tue, 08 Sep 2026 16:14:05 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 5287fd840531386541ec039d9e06af92f33593d7
Message-ID: <202609081603.YNpIn6DP-lkp@intel.com>
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
branch HEAD: 5287fd840531386541ec039d9e06af92f33593d7  Automatic merge of 'fixes' into merge (2026-09-07 12:16)

elapsed time: 1522m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

