Return-Path: <linuxppc-dev+bounces-25317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DC4C55182
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 01:48:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDc022KtGz2yWK;
	Tue, 04 Aug 2026 11:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785808130;
	cv=none; b=bknmHQxYVk5u6LS2cWo9B42zLeeeiqa2xznw8KuBAemx386PWnNY2iCx5Pp8xuRjzQm9SzU6kfuzz84KZefBysFAYU0HobYu8ShSBS2oQjtGB2Vdq8vOLsziJRoCSraHUu/gdjTMuyTQlTDKgyL+hDx8pa+laW+MiSpy6FKZ9AmmW7N+QBPSByDzPN6GPy13yHJIVIfk10VUKZxXbtlEtxSgpGV7K2h8HJHh6Wxu9fq5LhOjQ93bhoaeBrwndmS9L+EryxoWYDDXMhcWBKChySoKakTdBJpR3P7jcCa+n3LYl8LQNoJ7o7j9We1EfEjB2S9mjBEk0+241R+spmlnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785808130; c=relaxed/relaxed;
	bh=OpRYuu8hl+zjhK/yNDD5V3om/KdP3P9P0jvIGjqR0wg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=m+h3aL80G+ul6PKw5xOPQJT2gQC+wQIQfve6XfVWYCXv0CepUkqonI37ofbKlzD5fbeqxrVaWEUWLyXcIK55NxrmCD4800Fchpeki/MHGWP9ImCIL7CFY9Jf0xB6GyRqQ3X+4Ww0vO/bTn+BPJMHcPnze1bpWGuGS5wKdpA/+wquG5ltewohBpL24mYvEZofgmLuECQE7H8TmpKDSKAuQDaEUIsb+bqVCVet2keml4pPs5qLNq7nro7E8nxoiioS79G+zKp7yBnWp9gYNaNCJxCXItssnP6WkSU3dAw+9KoRr25sUZXdM1oL+GkiNN+dF4g91J3oMmfuRRajDNdALw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DsC8gvwR; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DsC8gvwR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDbzz6vrCz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 11:48:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785808128; x=1817344128;
  h=date:from:to:cc:subject:message-id;
  bh=q3xu5mGf+pQC1FW+2zCh2/8y22HGPQDH38dZwQ1804M=;
  b=DsC8gvwR3wlRfkYR/K+xQZ+PKc46fve7w4vTp6ZwNJsXDMNGRy/bdCBm
   4t9mz+Q4Az5maHOAQwqvYAQRT/BujPUjKxFbgGk/EDS8kzzdYhGlJd+3r
   QjGW/YNDJTKk5JoLM03beC2eTlgIWimVAi+TU/JDtrk6NFRBn+9hWuqc2
   QvR4Ert1jtlvnevymlkw3Le0Ng5ybXKOb306d98GCyBLFDLm9Ig/0XtkB
   1+pV2v20pd8QuzW8J6FxamWYXfgF9u6U8gLrzhfACEd9I3aIEco2tByY0
   WwJMaBBplhUegdnOAJcshMOVq3iV7n0jnTiqibna214PHy7gZO+G257nq
   g==;
X-CSE-ConnectionGUID: zBpsozN4RRSEx1B2kY/0qw==
X-CSE-MsgGUID: UdHC4oapTVytSa30WBxLIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86431723"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86431723"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 18:48:42 -0700
X-CSE-ConnectionGUID: 22V0a+IWTcSXrTAA7HlO7A==
X-CSE-MsgGUID: BWdqJte/QsWEs7o/Is4h8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="263353379"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Aug 2026 18:48:41 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr4Gk-000000008cp-39RX;
	Tue, 04 Aug 2026 01:48:38 +0000
Date: Tue, 04 Aug 2026 09:48:37 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:next-test] BUILD SUCCESS
 5458b50b5291390ce0af2872a1baa51cc58e8f08
Message-ID: <202608040925.mXOqeAoy-lkp@intel.com>
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
branch HEAD: 5458b50b5291390ce0af2872a1baa51cc58e8f08  KVM: PPC: Validate irqchip index in MPIC routing

elapsed time: 736m

configs tested: 43
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   alldefconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arc        randconfig-001-20260804    gcc-15.2.0
arc        randconfig-002-20260804    gcc-8.5.0
arm        randconfig-001-20260804    gcc-10.5.0
arm        randconfig-002-20260804    gcc-15.2.0
arm        randconfig-003-20260804    clang-17
arm        randconfig-004-20260804    gcc-8.5.0
csky                  allmodconfig    gcc-16.1.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
mips               rb532_defconfig    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
parisc              randconfig-001    gcc-8.5.0
parisc     randconfig-001-20260804    gcc-8.5.0
parisc     randconfig-002-20260804    gcc-8.5.0
powerpc    randconfig-001-20260804    clang-24
powerpc    randconfig-002-20260804    gcc-11.5.0
powerpc64  randconfig-001-20260804    gcc-8.5.0
powerpc64  randconfig-002-20260804    gcc-8.5.0
riscv      randconfig-002-20260804    gcc-13.4.0
s390       randconfig-001-20260804    clang-21
s390       randconfig-002-20260804    clang-18
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260804    gcc-16.1.0
sh         randconfig-002-20260804    gcc-16.1.0
sparc      randconfig-001-20260804    gcc-16.1.0
sparc      randconfig-002-20260804    gcc-16.1.0
sparc64    randconfig-001-20260804    clang-24
sparc64    randconfig-002-20260804    clang-20
um         randconfig-001-20260804    gcc-14
um         randconfig-002-20260804    gcc-14
x86_64                rhel-9.4-bpf    gcc-14
xtensa     randconfig-001-20260804    gcc-8.5.0
xtensa     randconfig-002-20260804    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

