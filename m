Return-Path: <linuxppc-dev+bounces-26758-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F346AC79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:14:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfGv06bh8z2xqp;
	Tue, 08 Sep 2026 18:14:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788855276;
	cv=none; b=NsrvPgbgIjA9zaxCCzp47H4UbTJUefxlW/atZtFwtK5uIfG97Kp7KFV7AeH5rjgYN9ez00zM1ooD1Osmiw7vhbApME6CHPK9URKvZabEm1DdLlRCduMcva+zKf3vvcWjnghWKh6ZhNYFA1hQlUNG6TxjhcAKmlkseNi9qC2UzZnoXTdYCIcRb7wubsoisvu6VsxuOvffFCjZJbMcWlYj8CFP6FPlD2xTUWahl84jJfaeKORMqinL/ylpZnyAoLP6IgiuJpVTewiJoECeUtM2l+74Y1/sNYQuzfSQMiExkUhNH7AfcqzQ3oFEc/6nXmkVCjm+2wg7uSLMTtbKZwVuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788855276; c=relaxed/relaxed;
	bh=1bNpq1tFp0ee5C7ELKl11y/UpdJHPoyRNwHfMWNCtts=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ib5ddvWbqDdcXLZ/NlU4rxUOp96WqEDKsN3Qmp3zQxA58YZz4h4HLpbSHCkRX+3wIsUJqNQnT16IW9hqE9gAiB071JwWxlYD/eV6BWEBb7sVG1LEqE33c/dC1HFxN27G4Rz8Ccdcf3Qaw0mEgKgcfIA5PG3ucttGUviDC7/wqQVKJqCEyVrFJppV6pkp75mp1ngKzSuGTUfaFST1yLFu7x9n76/mmizJnZBb2kIvY0oilheAmOD/6tyV9IKzTWmgU7Q76cxhMocv6dfKMmh35cGqPbkEXRudiaZg1bElcDf+ZHj5S4TZA3TGneHWtvNJs2TBU1VfYfOKz7bs4Ihzag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVjtbPaU; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVjtbPaU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfGtx33xCz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:14:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788855274; x=1820391274;
  h=date:from:to:cc:subject:message-id;
  bh=vCfqN/QkmnlVJfzgAv8KP3sKAqhgFcMfNjIdj94S2wE=;
  b=RVjtbPaU3s6P4JkEMTzk5jH0gv73KBHuCZhCuPBqds9YYD+3X28SXJaA
   A+mQMLTmD1RZFsulu2UDI/fIrNDTR0bjR7a/F2ejdglSBbn0gNgF5DkOM
   +Me5O4tKGdC2GgVGaDbeHc7SIau5RHEEmM30I2gYzmGnydROWOzJiLcvQ
   1vKuVjxhpW9HAhRsh/P1G2PXBb3f+tQIYdkH7nHR2Yg4lpWPJITrTVGaO
   iA/TeJYiCy1OBwcIhk93BiARz/6bDF22L1FjkSIUImmOvA7hXPwY+SyD8
   O6bzJVOK0dxq55fWO6P29Pr3d51/hhR2Jg8/5H0MgaDA3uyqFL6k5MmbS
   A==;
X-CSE-ConnectionGUID: Z2o11cBNRg2qcLppITFaoQ==
X-CSE-MsgGUID: 8YDTfrgTRWCCpjEPyYZ2iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100409299"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="100409299"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:14:26 -0700
X-CSE-ConnectionGUID: /AlWHuyVTvu7lqMdN+j+CQ==
X-CSE-MsgGUID: n1NsfNH8SXiQ1eZK4PPwZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="267683681"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 Sep 2026 01:14:23 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3qyC-000000001sa-46f4;
	Tue, 08 Sep 2026 08:14:21 +0000
Date: Tue, 08 Sep 2026 16:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes] BUILD SUCCESS
 45a5f7285f835adb3b74c9344c09a7bd2c4fb664
Message-ID: <202609081654.cPYFJ82H-lkp@intel.com>
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
branch HEAD: 45a5f7285f835adb3b74c9344c09a7bd2c4fb664  MAINTAINERS: powerpc: Add Ritesh and Shrikanth

elapsed time: 1523m

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

