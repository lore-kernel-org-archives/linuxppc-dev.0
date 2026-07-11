Return-Path: <linuxppc-dev+bounces-24038-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C76EC43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 03:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxv1V3GhMz2yH4;
	Sat, 11 Jul 2026 13:14:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783739646;
	cv=none; b=WHlJkqqyBg7H6jhBLnABzT+T0CtlHWapT32iIDpp/x5ZZYeAAXuIs83hHWUYFwwu61ByOV2lw9rfCgpncxNCZE5afN0dVIZulBw1hbR/Ps+ampQr+odp39MuBSvKfxXu36ks1UQZxjLGU4X1B3+agBPJDHuX5Nf2OVljmRlwOmQJZSvqYJEUMUlJHMBy4ZsANjPY1vb8zi3dHMlka6v2to465Fe0dNGimXv6PlZQus+NjWFStyC2OZ3CvpNYzA87N1GlJPfNczmzV0ayIuEwT8IPNXp1j7ZtFYvq3xFE/XNur+sNeiG6qofrY78mA8hs9IPcF87s9QhpdFSVPqHovg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783739646; c=relaxed/relaxed;
	bh=S4hvzXbxEvbZmam6qhSMtpL6NUaCOInsQQvKsP07Wps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cJc+QQxmGqNP3hK2JFn80HXgEmT0DZ1PTbkB5+uIlcqFXYzXq6rbdM2dngGh54oCoIYTgYlTwzIS+IRwZ0p/NgAKguixze2xHsjXBB8SvlRS2d/KdW6003teifn6/aCHeu5iWvooM6sZ+IH9a4NjhwAzbPwLi/B2Gh+CtRHFr2+IQUFGQcTNlem/ns9nZr+oQt/m51+IaORbVkssG/om1SyCTfBxGj7xYQK0AaYj+LnlsqpOY1QV+L4cxv5zFWy07+ufe47fn+dNsVSradyWxVyacd/0vfyqd7vXhns50+k0oGqBq3LqIANMLzCRf9o8+pnURU5B07aajx+ygpCUkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P1ecD6GO; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P1ecD6GO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 66 seconds by postgrey-1.37 at boromir; Sat, 11 Jul 2026 13:14:02 AEST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxv1Q35xRz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 13:14:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783739643; x=1815275643;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4JbO2OMYTZoSGibXGDIBwRzxXPtxvD4HSeT5+HlZ1Bo=;
  b=P1ecD6GOryN5e1CBhFQS8JLgA0X1iCgX9GlWYVFWnDIvnqMUpuI6WObb
   Wh+Ni3s+HooJ9+o3h9EaSgRRgUx7YaFXCRwH4JEWBIC3V4GTpwsP9Hp0x
   rNh7v81usQ26s/uLMkuucTxKS3GnK9g/4Veez2Ul3Wxpc/pfDOYWWnaKg
   uec1t9zjx6CS/VrR+FiQzl6PvPE2P27L9uXeqKEqfajEtFBq2SPfna4Vp
   qaTIbKGaf5SRYhUIWhpUnZgUODIeRD9i6DHZBcyjpL4ELW5A+qmZr8NGs
   hkxPxJR47UyBbF1fPj6cpyLtVI5N4rifslNfL47CI5PnhMrYyA7MKRg9z
   A==;
X-CSE-ConnectionGUID: U9i0YjtnTk6B9ibstshBeQ==
X-CSE-MsgGUID: YgFobjCiRwis+sGo8dx74w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84216924"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84216924"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 20:12:27 -0700
X-CSE-ConnectionGUID: O6NIMTBpTcm/PbVUoNyuLg==
X-CSE-MsgGUID: J5+KOHQGSEaTcv/LyJm3eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252409674"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jul 2026 20:12:25 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiO8c-00000000Jge-3oIY;
	Sat, 11 Jul 2026 03:12:22 +0000
Date: Sat, 11 Jul 2026 11:12:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Michal =?utf-8?Q?Such=C3=A1nek"?= <msuchanek@suse.de>
Subject: [powerpc:fixes-test 12/12]
 arch/powerpc/include/asm/ptrace.h:245:23: error: call to undeclared function
 'BIT'; ISO C99 and later do not support implicit function declarations
Message-ID: <202607111027.VbonWf7Z-lkp@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes-test
head:   afc2830892a128a13a65f677271a0a48aeb61b5e
commit: afc2830892a128a13a65f677271a0a48aeb61b5e [12/12] powerpc/syscall: Fix syscall skip handling for seccomp and ptrace
config: powerpc-randconfig-r112-20260711 (https://download.01.org/0day-ci/archive/20260711/202607111027.VbonWf7Z-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607111027.VbonWf7Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607111027.VbonWf7Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/of/fdt.c:11:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:5:
   In file included from include/linux/user.h:1:
   In file included from arch/powerpc/include/asm/user.h:5:
>> arch/powerpc/include/asm/ptrace.h:245:23: error: call to undeclared function 'BIT'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     245 |         regs->entry_flags |= SYSCALL_ENTRY_RET_SET;
         |                              ^
   arch/powerpc/include/asm/ptrace.h:241:31: note: expanded from macro 'SYSCALL_ENTRY_RET_SET'
     241 | #define SYSCALL_ENTRY_RET_SET   BIT(0)
         |                                 ^
   arch/powerpc/include/asm/ptrace.h:250:36: error: call to undeclared function 'BIT'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     250 |         bool set = !!(regs->entry_flags & SYSCALL_ENTRY_RET_SET);
         |                                           ^
   arch/powerpc/include/asm/ptrace.h:241:31: note: expanded from macro 'SYSCALL_ENTRY_RET_SET'
     241 | #define SYSCALL_ENTRY_RET_SET   BIT(0)
         |                                 ^
   In file included from drivers/of/fdt.c:11:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:9:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/of/fdt.c:11:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:9:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/of/fdt.c:11:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:9:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/of/fdt.c:11:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:9:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/of/fdt.c:11:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:9:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/of/fdt.c:11:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:9:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/of/fdt.c:11:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:9:
   include/linux/signal.h:157:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     157 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:8: note: expanded from macro '_SIG_SET_BINOP'
     138 |                 a3 = a->sig[3]; a2 = a->sig[2];                         \
         |                      ^      ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/of/fdt.c:11:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:9:
   include/linux/signal.h:157:1: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     157 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:24: note: expanded from macro '_SIG_SET_BINOP'


vim +/BIT +245 arch/powerpc/include/asm/ptrace.h

   242	
   243	static inline void set_syscall_entry_ret(struct pt_regs *regs)
   244	{
 > 245		regs->entry_flags |= SYSCALL_ENTRY_RET_SET;
   246	}
   247	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

