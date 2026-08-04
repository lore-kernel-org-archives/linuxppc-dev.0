Return-Path: <linuxppc-dev+bounces-25318-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633C5C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 01:48:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDc023r2yz3080;
	Tue, 04 Aug 2026 11:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785808130;
	cv=none; b=I/UGT3daNYfoPkKQdDddp8RFiKeYuMx4a7U/Ez3g9GpTFTONhEwkC4ixf/ZdbrHnPXhetjN8PBSyyLJN7dQ2R4mg2ONd3RJGqL0kX0vgmX4Gg65Z/+BkVwquYYe6H3JaPk+veNaS99loHFRelBD8zYRMQMmc79G92jg8eEto8Y/tHWBQtXBSh41JGYfHQjGMa7wlD5AAkqniQHMVXrL57Y4GHQUzArOQj5smkgd1hIj/vXiTBE7FXy8DTpIxjxhskay2uISHvGpPvcWxkxddJ6tPEGjzAvs2gbraovPIjW+7X4l5H96QmfUmD62DghBPpRQvXcfFKizNfXYC2oOx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785808130; c=relaxed/relaxed;
	bh=U5kCpA3fPXYJ1inzxy9omagtuitWgAStvJ9pfxoUx+4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Dau+W7anIYl3CBNU9yflsGHdbCzo/nm/StBrMAR2yUQpKUwb+3fpfkWyyztSgD+lLRzgAY5vuQqwEYsQxxGJ8ihvtQN0YYuN425lgipaD4co92D8uUj5ak+VRaOd+EhTKV8IOq5yb72AGGWyzws9TbdhSsbSMfRmA3wYmzYqHp42k7XxUQh4XceGnO7w1dNZndAPicnrm0c9uF0KBHeby+lHrY3zgM6ZOGsyejpeezUgSjLmSn7exSNfOn0ZS6+XrmRWP1DICgjLYlRRRAA/mUm1IJygBFos9uPWY8enTa8ENlhrnfwLPEdibZ1sDhM4F0DVTNOHknk+T3Latw0x8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nhCblJMq; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nhCblJMq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDbzz5r0Mz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 11:48:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785808128; x=1817344128;
  h=date:from:to:cc:subject:message-id;
  bh=3miSd8Xso9RMV0JQdNYh/LlPzJjmLZFonFi3WnVRNf0=;
  b=nhCblJMqayNMD6+wbhtLQGyH5WIYMtAMztoJjjLF0POx+D2+h9nXVUbI
   gcEHUWbcyrGlAgqsqKETL9pL/Wv7O1ldaPz10pUm8GN/FrjLC1pz7Us6p
   aRy3HF7eYAzg6yU4hv5Hx4zyziyy1r5tIOJ+kBZi/SE5Ijkw4pT9biN/f
   rfVIWeBQDmH5JqMCq0uDX4nm76E3QKQojtoANEUzqIo+9s9Z2od5WzBkj
   zCZicYROAZKUrECJfLDZO/B2SZvqzdJik3LTQtOumLQ1n5/bZIeG/PRIF
   8hYwkMWDc9B2UbUV40+S1if8U0SdaFHGqYo6sRirnu2PkycbZHdgFIjGf
   g==;
X-CSE-ConnectionGUID: 89RRraHPSsyQdpNbAwOVug==
X-CSE-MsgGUID: WQ7dMKQBRSSRCByw5d4rWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86119979"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86119979"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 18:48:41 -0700
X-CSE-ConnectionGUID: qqvQ42p2RVKVGEzey25h3w==
X-CSE-MsgGUID: lOixjj4LQpWlUOE77bl/wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="260121412"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Aug 2026 18:48:40 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr4Gk-000000008cn-2O5R;
	Tue, 04 Aug 2026 01:48:38 +0000
Date: Tue, 04 Aug 2026 09:48:21 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:merge] BUILD SUCCESS
 c29abb2e0d79f53042a971bc455ee0c6d28b9ccc
Message-ID: <202608040907.QkiBKWWw-lkp@intel.com>
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
branch HEAD: c29abb2e0d79f53042a971bc455ee0c6d28b9ccc  Revert "KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode"

elapsed time: 736m

configs tested: 89
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260804    gcc-8.5.0
arc                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-001-20260804    gcc-8.5.0
arm                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-003-20260804    gcc-8.5.0
arm                  randconfig-004-20260804    gcc-8.5.0
arm64                randconfig-001-20260804    gcc-11.5.0
arm64                randconfig-002-20260804    gcc-11.5.0
arm64                randconfig-003-20260804    gcc-11.5.0
arm64                randconfig-004-20260804    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260804    gcc-11.5.0
csky                 randconfig-002-20260804    gcc-11.5.0
hexagon              randconfig-001-20260804    gcc-16.1.0
hexagon              randconfig-002-20260804    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                 randconfig-001-20260804    clang-22
i386                 randconfig-002-20260804    clang-22
i386                 randconfig-003-20260804    clang-22
i386                 randconfig-004-20260804    clang-22
i386                 randconfig-005-20260804    clang-22
i386                 randconfig-006-20260804    clang-22
i386                 randconfig-007-20260804    clang-22
i386                 randconfig-011-20260804    gcc-13
i386                 randconfig-012-20260804    gcc-13
i386                 randconfig-013-20260804    gcc-13
i386                 randconfig-014-20260804    gcc-13
i386                 randconfig-015-20260804    gcc-13
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-017-20260804    gcc-13
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    gcc-16.1.0
loongarch            randconfig-002-20260804    gcc-16.1.0
m68k                         atari_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260804    gcc-16.1.0
nios2                randconfig-002-20260804    gcc-16.1.0
parisc                          alldefconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-002-20260804    gcc-8.5.0
powerpc              randconfig-001-20260804    gcc-8.5.0
powerpc              randconfig-002-20260804    gcc-8.5.0
powerpc                    taishan_defconfig    clang-21
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-001-20260804    gcc-16.1.0
sparc64              randconfig-002-20260804    gcc-16.1.0
um                   randconfig-001-20260804    gcc-16.1.0
um                   randconfig-002-20260804    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260804    gcc-14
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260804    gcc-14
x86_64     buildonly-randconfig-006-20260804    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260804    gcc-14
x86_64               randconfig-002-20260804    gcc-14
x86_64               randconfig-003-20260804    gcc-14
x86_64               randconfig-004-20260804    gcc-14
x86_64               randconfig-005-20260804    gcc-14
x86_64               randconfig-006-20260804    gcc-14
x86_64               randconfig-011-20260804    clang-22
x86_64               randconfig-012-20260804    clang-22
x86_64               randconfig-013-20260804    clang-22
x86_64               randconfig-014-20260804    clang-22
x86_64               randconfig-015-20260804    clang-22
x86_64               randconfig-016-20260804    clang-22
x86_64               randconfig-071-20260804    clang-22
x86_64               randconfig-072-20260804    clang-22
x86_64               randconfig-073-20260804    clang-22
x86_64               randconfig-074-20260804    clang-22
x86_64               randconfig-075-20260804    clang-22
x86_64               randconfig-076-20260804    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260804    gcc-16.1.0
xtensa               randconfig-002-20260804    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

