Return-Path: <linuxppc-dev+bounces-24311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1DCC44507
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2026 03:10:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0yhZ2PrWz2yXj;
	Thu, 16 Jul 2026 13:10:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784171406;
	cv=none; b=PLABizPcL4awe+D59Kb35SD0aMu5aHupn2kAlXD6QISAmS14A33U9hqP9IoqyH1MucqZxB60aoGNujFBARQrXRqTtnzRjdBPidR6AiNwKhOq8VdCpS3meOrEIbIjuUmHatfoe+vJcatak3y4fj7574uJ1n1lSnNqUD4zbI0b3JpEy7byiLuL1RRHZ71uGaVhQAnoRMXBUvE3iPNP9mkTVFUs3dcPtn4if4NctUZqh+je/baxsxr6yWP8Dpj5UQ0FRcQOy4vFkzYQttOpRxLG0XoExmebG3XYOXYJyyH+B3AKh1T/0kdcGHLJ3gHFE9/CaK4eNWvI1+Jbkbtu2ZzQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784171406; c=relaxed/relaxed;
	bh=a6XcMNqgb40dvS0aO7aVdq9EER3NESeBTZl5cKELHRM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NiAM4yMzRGeE/gTq6nCkjhch03WscxxFHE39gRgSOUaUdmc4D5TLlQMEZutGnuQHJk79AtkvLDhnzsffs/fjjgqwQBB4YEzIrvhRUKH5iXuSxAQP324D6SZqSsda63aewciQCObhqmm72kRkLTVnDD3gcDHQS/EwDM7yqTwFD5GriK/Cwox5DZ1Gjll2zrI+C4aWLLk3VcCUUIF+GszUIN0aVn8KiFqVO02JiF3ZvImyuT49zuLrdzxuxWWQyJUGyXLdrWhPp6hazGgz7YKgufn6FLLsJNJzLUHez1e6xZ7r5FOGfnnmQKX2n2dlRxX9qKBNj++1pC5ZqZYnHRHjMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVaHhoGk; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVaHhoGk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0yhV70CYz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 13:10:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784171403; x=1815707403;
  h=date:from:to:cc:subject:message-id;
  bh=8SpUhbxCWov6VhjaFUbD5HF0DCDeFBJ6iMO0yr9emZg=;
  b=RVaHhoGkXDua/egl6WzwSJsZF0nK8u/eGNyQNNLHhb1LKQK6gJszmTnU
   C2GMpugOU63e++mWUsFUD8GuZVXn0i6lzUaUba/WuMZv/fDZ5Jl4083wi
   vsXDIEdIpd03DS/fohkwxio59UjixeMGeMeChQ/sUmDrTEMbmAgYa9zHF
   8txuZrzIyLo5/f43rimIDJQyRoJ2AYLSxVr9wwxcCifJJw+86o+q1j5/R
   wGGddBq3uEU4qNgFWgpTAv/3owPPgnNDsLaBKSRMO9gd8bj01bH6IjqKS
   yDJbJgagSKIKUpeMaPyvUjjznpzoYmWhbBrJpnQ4Xa/mS53cAQl0C3Rw4
   A==;
X-CSE-ConnectionGUID: FaAyzFt7Tq+fhOnUJl1oEg==
X-CSE-MsgGUID: QwOwWlA9SKaOqDFho3YH0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95425568"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="95425568"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 20:09:57 -0700
X-CSE-ConnectionGUID: /BRZ6C3BTtyjFSyNUypq6w==
X-CSE-MsgGUID: b2N62skOTT6aB1h3nneVfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="260176697"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 15 Jul 2026 20:09:56 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkCTx-00000000OG0-2Ubn;
	Thu, 16 Jul 2026 03:09:53 +0000
Date: Thu, 16 Jul 2026 11:08:29 +0800
From: kernel test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc:fixes] BUILD SUCCESS
 a2c02aa0c6ca3ec9fab6f1c99912a440c7b8bfdb
Message-ID: <202607161118.apAkJbxp-lkp@intel.com>
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
branch HEAD: a2c02aa0c6ca3ec9fab6f1c99912a440c7b8bfdb  powerpc: Remove dead non-preemption code

elapsed time: 729m

configs tested: 5
configs skipped: 316

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
powerpc               allmodconfig    gcc-16.1.0
powerpc                allnoconfig    gcc-16.1.0
powerpc    randconfig-002-20260716    clang-19
powerpc64  randconfig-001-20260716    clang-22
powerpc64  randconfig-002-20260716    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

