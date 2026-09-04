Return-Path: <linuxppc-dev+bounces-26573-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614C4C624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 21:31:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc8m66GmYz2yft;
	Sat, 05 Sep 2026 07:31:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788557478;
	cv=none; b=L8JkeCr+Ty9gU3+JgAbojrcESpYXsfs68kotEz7rk5qfUlhP0bjnmoammPeTWPW/9GnLP8XmiTiKKy12YsT2ZbZ6Buk3tcots82W3x0Q+6bUNg8QEHuKJBMx0uvbY+rP+6TNtdV/Iog8FWJxX1o7PGNt1UQ8lrzz6D1mCvTE9yCZvTtthuNvs4qWqIKeDtSMzQecKUvL8iSTj6Mzo72FGgW2TiLni4rbOuYHkKOEKY0YH+35rQzoASbXvBPxwERoMobYcDXrFJkHEJ8K5BsgtwOf4+7UNVmwKQ1hozpSMTfAEdAcV+hvk+bq3a+dcKnmr4Vau1xPBl70Gl5YHDumww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788557478; c=relaxed/relaxed;
	bh=xO5WwweDHW3VnNRlSdEyMfNeRgAlRiXY2ahFSA/hAsA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EjaEAy5lATz0yY5CjERTGw8/1HBklbYbMLgbTmpV0RC3g97Utke/M1ii652RQogLVA0xv4IWXlA+/hvT+hgnFuIcR2l08oE0HSGsZ2P2SfrYCvAhNzhYHCrTONSSBfa5jgwGxnC/fWpVJ0Xdha7l21s21fDm2knd6TZnRd2UF8bv4YziAsfKN/VANB7tQL3blgAYPDr3h/3JZJJJvHkcaORbDseYWa0cDt8W65LTQC7udKTU88rYKZ5qU6SMzpI+d3C4BvnQKPbPUNfEhVyOruxbGKIvhHtKobtgeaxeKcFh+6AyTqj5vIBzCIpJ9iUB/v6LH3Xw25ezwGTpkjwMig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SwgHyFeh; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SwgHyFeh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc8m25Nv3z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 07:31:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788557475; x=1820093475;
  h=date:from:to:cc:subject:message-id;
  bh=+ep7pNri1UF5vvEFl3UbmVNP/B0KnFa/jZd7WN+Qb/U=;
  b=SwgHyFeh+YJtF0wuf8i514Fjq/DrL1dNaGMm0nIAO2CcC8uaY1DRhf3i
   8FfMWtYwXNIC/U2n0xj5bJpWgMEJpa6p4CtBUcgMfOCXa/0WJEU4QCbp8
   TgpDDFh040eHYaosMnGsPa9DHCXh7Y8aZhDmYtLYXMI8eAedn8Z1pODtC
   9Q/ElQW2SxMTnLYRFHJL7Ri4mN61/qhmH1OZiOMpPdltk0NrDIAeir+g/
   UYsL+OVLNBnEJWC6fqwxl12dNUmYwY7DLwJiNAVejSVj3JWsYZBJukq1C
   Jus4L7Gv9U9ERgDtTKSBpDPPQriojJtZl1lpxzwEzadCrp2BrMxs5SDWm
   A==;
X-CSE-ConnectionGUID: Z3hJzOwNShmAcFwbYB9CcQ==
X-CSE-MsgGUID: xEKgK38GQA+hYVfJT75bRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="89085209"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="89085209"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:31:04 -0700
X-CSE-ConnectionGUID: GK6ONbcHSia8pOOOazR3jA==
X-CSE-MsgGUID: yp8F1tbiRFeyV34i1zRM5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="270119801"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Sep 2026 14:31:02 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x2bUy-00000000ABO-0KdN;
	Fri, 04 Sep 2026 21:31:00 +0000
Date: Sat, 05 Sep 2026 05:30:56 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes-test] BUILD SUCCESS
 d79db535546b9858f64f27fe968005024d39f828
Message-ID: <202609050553.8FE3gJpe-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes-test
branch HEAD: d79db535546b9858f64f27fe968005024d39f828  powerpc/pseries/pci: Fix misleading VF limit error message

elapsed time: 2108m

configs tested: 36
configs skipped: 78

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arm           allnoconfig    gcc-16.1.0
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2         allnoconfig    clang-24
openrisc      allnoconfig    clang-24
parisc        allnoconfig    clang-24
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv         allnoconfig    clang-24
s390          allnoconfig    clang-24
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sparc         allnoconfig    clang-24
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

