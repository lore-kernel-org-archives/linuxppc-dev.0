Return-Path: <linuxppc-dev+bounces-19613-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555E9F459F7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 18:09:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fslDz5K6kz2yjn;
	Sat, 11 Apr 2026 04:09:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775844563;
	cv=none; b=g65Jsq9suYtFAQ3tleTVfdnCbTh3cadMPEGPVHfNpSeNrCvnoyoFuZl/mQgsmAucKQ0hheOMBvy+Zoo3Ja3H+/l4siyxhZCzXTPVjIdnxwvouAu8Je3k+hq2Nxikvn7EOr075cEMKyIDToBFwZnPRJf44REyM/VUynDJpAuQbldeIa7YVk4wVsm3Df3lTyGQAGTlMOCax18bfiwDEzvHgt1VkLUNfknkQLLOjwSGDwTpUKaooKXZt0L1Fy93GftK94L7MuBYrdN3kZvD9+hbiaULSlluWHTBs7hX9V5OLDdKjjnSl7zHlNoBOSJKCfzrUzjJyTw/j/wzFp4474/vig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775844563; c=relaxed/relaxed;
	bh=WEeGy+N6gDW9GeZsoi4Q+GE+XnLvfYxwjA7O39Ic/1w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YvpLQuABXWQHsf/5AofK5M2FiR8PJ3fASg/sxsz5ddIpPWcItl5v34u1FnbodQuQ+9i9tpImlxDOwPrYNuAkFgKv9Gg5njt54fDbrZ+3FhQkXnv6PKgxdiVxBPt3inOSuNs2QPmbjSwe1KNZPglbDNght6cEfsepbYwiukmsGjqmWFFCzuW6MGsmnLfhqweLwKxs5hPrvKWDxuQWBj73rBDorgMTjUdwKI4U6zJrDPj8cRK225xXlSoWBiyUzjieA7kYTcZorPc78Z5LfRJYyKjhixPPnU6H0ZWYTClo+EQyHBsUv+vUANuYLw132iEnzfV3f+AMewYGKko03td1RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B9tftWfC; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B9tftWfC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fslDw1fklz2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 04:09:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775844561; x=1807380561;
  h=date:from:to:cc:subject:message-id;
  bh=nua+0N1DwCQGOa8Gz7Z5A2Tz6UtoUYmi9/W7XjiP5EE=;
  b=B9tftWfCxWTVZtv5xbbF+ET5DNheZVncOeLfDoStl0f231vFgF7k8A3f
   axsKwdEdFPyCKnbada3T3vuYiAt1kOUzsKkYeRyv8lYlNNG1Tx6Iesuom
   /S4JvApf7e2hgnvnmWSBXsHS6LX82i6tOwe2+7zDbWcjTQ1zbk3Udo1jh
   4TAv+NispJctXSvDP2H8+2wg83w2+5X9Oj2VbgvQBmcBtyqpHQ6iyeh1l
   YydKv7D15QaPIFdDg8OGGmWJbuE67mqymb7cQvyWPJhnisnFDgew6wOUI
   /7WWJKBGyT2gwU0j2pAMAtjDU2t+n98+UBOzGG2o92HmUtt5Gy2Y8+63o
   Q==;
X-CSE-ConnectionGUID: jgcUAwDoToe0pp8JzRN2ZQ==
X-CSE-MsgGUID: LhPOX4ejQ0efT7SzpG4n+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76039370"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="76039370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:09:13 -0700
X-CSE-ConnectionGUID: msoZltiOSWqX78IaSkDhPg==
X-CSE-MsgGUID: WQ/jSqQgRtyKhgPyLaCzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="259616494"
Received: from lkp-server01.sh.intel.com (HELO 6449335cace3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Apr 2026 11:09:12 -0700
Received: from kbuild by 6449335cace3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBGI1-000000004BV-2GhL;
	Fri, 10 Apr 2026 18:09:09 +0000
Date: Sat, 11 Apr 2026 02:08:42 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next] BUILD SUCCESS
 b80777aef570ac561977d7210d04890f9df7e484
Message-ID: <202604110235.B3P9CbWx-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
branch HEAD: b80777aef570ac561977d7210d04890f9df7e484  mailmap: Add entry for Andrew Donnellan

elapsed time: 729m

configs tested: 55
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

