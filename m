Return-Path: <linuxppc-dev+bounces-25615-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7725C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 17:55:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGsHh1rq3z3c7d;
	Sat, 08 Aug 2026 03:55:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786125312;
	cv=none; b=G15bD6CaQL+x7yI7M9vxh4nak9fADR76wY48oKLOSAhkcT69wfdF6Dkyn/Scxslw5F9Hs/dXWPWETRqWaIsuoayx8RVNQJfvniPNEqcHU6+A2vGTa2gSgJTkdw1wyMNbVlA62z4z7OsjT05unckNfXVVcraD8blzAYRGrF1kfepoe5oWRK3I3tOyCP1PIiyNaSerk2mfj6KM8hc1Q1p9rRHPgf/SP8FLEHD1k2Xz1MBl85yXrahJS8jPdu50yMBl3v/RABrUCi4NmRWvSxjWXngBlrxgul6adbLyNCgqcBvGb+UAV8GW0hQ6Ga2YInywJSquHQIWT+IaAQlHPxkK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786125312; c=relaxed/relaxed;
	bh=cMT9M+Qo6W/1+YGshUQD+r/PjOjwPwL/HfDdd3Fk6hE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MsBpS9LM91mywntxfNAf1YcoQseA/SYjbAzaTnCtY9qtaKmXa4VefALdn/nP9pNC0LQzUjmMwJstWY+OXbbAr3Fx5K849baR6hoXP9fin9W9gf72rpMh03fj/iQXIe6BIisnr2Nnn0ul58+dkwa5aTIQ0/goHYjJIOgMUa+8SKEQuaPs+X/9RoLDHkiE5fIFZ1s4pzfYXMC7DiiHq1z+INCsgka+NBBZcBO/M06O+9DqiFzbseIo2O/ETCATamYopTzGV7J8vMt0YMoEB2qj7Keqbd55LFZEWglQ5gu1lbs14vF/uw5JktfkkLi4XFcyzZhwdrJknf0lX3mK+ulufw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XPztx0fj; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XPztx0fj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGsHc6LX4z3c7S
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 03:55:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786125309; x=1817661309;
  h=date:from:to:cc:subject:message-id;
  bh=VAv1ubfydU98r5tfLY5w0x5jOw9hgxOzMj4NsWj6EZU=;
  b=XPztx0fjJqa0y4bQGeNPmZ7TwLRy6oJkHSwGfhkr8eGVCu2tu00VaAzs
   P/VroKIjK/MFwyz3ls8D4EgsgD2ZtAPvwYqtSZvYO3gz04LNKUpwt4A3D
   3SnETJLQP0AIwIVyoivf1rHt/ZD6DTqutLVRDGLX7ZlSlinMaN1Zu7qdC
   tq4LD1r8Iuf6ARcsakuklFQ4Ij6Vd/ZYuAs34jf8dil9aHL7KssPicg+e
   J/CE+1rZ5RHCpJ58lkwP0VPbiqkLhm6hrVpigPjpqu5lxVFO73ZpKyJia
   2WMtbK/CF7Ttn946JR2YHi9emcW7BoQsfk9zazhd71+Z6Do7TvdJXvjtb
   g==;
X-CSE-ConnectionGUID: BC3qZ9OsRZiuuJMZraSUWg==
X-CSE-MsgGUID: LHE8WQzbQ+Cz5ODpoEtz8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="89266640"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="89266640"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 10:55:01 -0700
X-CSE-ConnectionGUID: YqcKSI4JT+2CC92JyEQIuw==
X-CSE-MsgGUID: Zxo2fLpcTUGJNIr8j+MN3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="261935498"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Aug 2026 10:55:00 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsOmY-00000000IqP-0bdH;
	Fri, 07 Aug 2026 17:54:58 +0000
Date: Sat, 08 Aug 2026 01:54:32 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 0fcdb510932b90160c47d3c38f6ce43852d7e14f
Message-ID: <202608080112.XhGqoV0m-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next-test
branch HEAD: 0fcdb510932b90160c47d3c38f6ce43852d7e14f  KVM: PPC: Use min() in kvm_vm_ioctl_check_extension()

elapsed time: 1586m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             alldefconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arm64                           alldefconfig    gcc-16.1.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-004-20260807    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-002-20260807    gcc-16.1.0
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-002-20260807    clang-18
i386                            alldefconfig    gcc-14
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260807    gcc-13
i386       buildonly-randconfig-002-20260807    gcc-13
i386       buildonly-randconfig-003-20260807    gcc-13
i386       buildonly-randconfig-004-20260807    gcc-13
i386       buildonly-randconfig-005-20260807    gcc-13
i386       buildonly-randconfig-006-20260807    gcc-13
i386                 randconfig-001-20260807    gcc-14
i386                 randconfig-002-20260807    gcc-14
i386                 randconfig-003-20260807    gcc-14
i386                 randconfig-004-20260807    gcc-14
i386                 randconfig-005-20260807    gcc-14
i386                 randconfig-006-20260807    gcc-14
i386                 randconfig-007-20260807    gcc-14
i386                 randconfig-011-20260807    clang-22
i386                 randconfig-012-20260807    clang-22
i386                 randconfig-013-20260807    clang-22
i386                 randconfig-014-20260807    clang-22
i386                 randconfig-015-20260807    clang-22
i386                 randconfig-016-20260807    clang-22
i386                 randconfig-017-20260807    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-002-20260807    clang-18
m68k                      m5275evb_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-002-20260807    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260807    gcc-8.5.0
parisc               randconfig-002-20260807    gcc-8.5.0
powerpc              randconfig-001-20260807    gcc-8.5.0
powerpc              randconfig-002-20260807    gcc-8.5.0
powerpc64            randconfig-001-20260807    gcc-8.5.0
powerpc64            randconfig-002-20260807    gcc-8.5.0
riscv                         randconfig-001    gcc-12.5.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-002-20260807    gcc-12.5.0
s390                 randconfig-001-20260807    gcc-12.5.0
s390                 randconfig-002-20260807    gcc-12.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260807    gcc-12.5.0
sh                   randconfig-002-20260807    gcc-12.5.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260807    gcc-16.1.0
sparc                randconfig-002-20260807    gcc-16.1.0
sparc64              randconfig-001-20260807    gcc-16.1.0
sparc64              randconfig-002-20260807    gcc-16.1.0
um                   randconfig-001-20260807    gcc-16.1.0
um                   randconfig-002-20260807    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260807    clang-22
x86_64     buildonly-randconfig-002-20260807    clang-22
x86_64     buildonly-randconfig-003-20260807    clang-22
x86_64     buildonly-randconfig-004-20260807    clang-22
x86_64     buildonly-randconfig-005-20260807    clang-22
x86_64     buildonly-randconfig-006-20260807    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260807    clang-22
x86_64               randconfig-002-20260807    clang-22
x86_64               randconfig-003-20260807    clang-22
x86_64               randconfig-004-20260807    clang-22
x86_64               randconfig-005-20260807    clang-22
x86_64               randconfig-006-20260807    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260807    clang-22
x86_64               randconfig-012-20260807    clang-22
x86_64               randconfig-013-20260807    clang-22
x86_64               randconfig-014-20260807    clang-22
x86_64               randconfig-015-20260807    clang-22
x86_64               randconfig-016-20260807    clang-22
x86_64               randconfig-071-20260807    clang-22
x86_64               randconfig-072-20260807    clang-22
x86_64               randconfig-073-20260807    clang-22
x86_64               randconfig-074-20260807    clang-22
x86_64               randconfig-075-20260807    clang-22
x86_64               randconfig-076-20260807    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260807    gcc-16.1.0
xtensa               randconfig-002-20260807    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

