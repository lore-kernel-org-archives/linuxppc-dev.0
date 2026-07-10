Return-Path: <linuxppc-dev+bounces-24018-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2746EC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 17:47:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxfRw0DlYz2yS4;
	Sat, 11 Jul 2026 03:47:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783705659;
	cv=none; b=fVFPFgcuKj0N9ljyMsnimrhVb0fOtI2Vz0CCl5VGRtIgZmsYyNZO+o+UUSaNNcq/FzTsH4ofWZBkIyAxp2Gj+oAedMSZ/9h613N+SqSjMYq1e4TnUjePIQwzBYi8e0gcl+3P7OP9BZCOr5VV6wIsug4X130h8R1PCUsTBJV1NKJ2NzzxV2rTFAT8XBxKQ4AFkMJ2QWul5xp3vkYW5GxC49IYmTdT02RhBjRp8RK7nf19L1HZLSyaoWGeRLvkaG/Qp+HNkvaohTm9XsSiVrOj1Ky/ZNlr3+j4QG9RYecQLZqxp10IW5gISaCf192+itLTT4fsiEm641eEqRP0R6kh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783705659; c=relaxed/relaxed;
	bh=7/LEs8BWu8lQfJmnwA6peWFrpxzDrqJ124232Rq+4es=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HBVN1BeRFB41LfJ+jLKkp3bKio6QtvYdzlCH3hikWzj4OVw06rvHKI8OqTYOOXStU/6TD95sWpAjAEQUg3I6CedMjZGDvHCg1sIlDXxF2fWPcgtETnstzADpgfyVaTsL+NdX9Pd1+QS0mcmVZaLEbwRgu953TiNyUKRSYP6CgoRBeBSqceixAXXpa/69WNzvqvG2cAbByHkHpLRaiJYKVfZlNExBAmpwZWacDXSC26S9AQkR6QoeMDCaw+FlZSsPSBMPYKjfKjjovz2+6bdWJlZbYeddH1WbZJQiZ3pJRzuQ36AeBq77XTXuuP0fezAl7fP8FcBIB8jUONOiWsLxXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CCJSRngq; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CCJSRngq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxfRr1s6bz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 03:47:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783705657; x=1815241657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AOGO+lL5I6IhIskXeEb34ah22LlgCjBp8tsSQwwqGlI=;
  b=CCJSRngqdhm8GXF7xbRTy2Lh9H+BUFXMd/4i/aAEtkrkE+d1jYVUGeB1
   cN7lwh0wrDfVai0fCxRDoSibb1aQSBOoBD5Y+4IOB7xdYuSQnJWscUaTd
   5paN/4M01UbKyBhEdEFuXm4h4zSTZnfhPa0trRmCGd6eyxF0bQMbJ4fWq
   MDOa0HLHK4xEDMP53chg17opRtEwNQZxVGXmp9oTMUX0PcrP8zi2hzzd3
   V41LRJgMvoNGyC1zZ+CQs1pbJJD7q8ZvBXVIh6YJ3NKnp1wiQ9Ds5Ww7H
   JNzk2N8d6f0NDIrp31q6El2idrr0kru/LQG4GF6U9xJD2Vy5MKmXZQRs7
   Q==;
X-CSE-ConnectionGUID: 0cE79LRWQ5CVJ3lUEsYoZA==
X-CSE-MsgGUID: uxVekDCTQpWQ94kf4SXG0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95011752"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95011752"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 10:47:31 -0700
X-CSE-ConnectionGUID: 2HRRpqBxTiuebTeRusk5og==
X-CSE-MsgGUID: Nx+nLDi1SIyl27LmJ6IRMg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jul 2026 10:47:29 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiFJu-00000000JC9-30Fb;
	Fri, 10 Jul 2026 17:47:26 +0000
Date: Sat, 11 Jul 2026 01:46:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Michal =?utf-8?Q?Such=C3=A1nek"?= <msuchanek@suse.de>
Subject: [powerpc:fixes-test 12/12]
 arch/powerpc/include/asm/ptrace.h:241:33: error: implicit declaration of
 function 'BIT'
Message-ID: <202607110141.nUx3NKwu-lkp@intel.com>
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
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20260711/202607110141.nUx3NKwu-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607110141.nUx3NKwu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607110141.nUx3NKwu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/user.h:5,
                    from include/linux/user.h:1,
                    from include/linux/elfcore.h:5,
                    from include/linux/vmcore_info.h:6,
                    from include/linux/kexec.h:18,
                    from include/linux/crash_dump.h:5,
                    from drivers/of/fdt.c:11:
   arch/powerpc/include/asm/ptrace.h: In function 'set_syscall_entry_ret':
>> arch/powerpc/include/asm/ptrace.h:241:33: error: implicit declaration of function 'BIT' [-Wimplicit-function-declaration]
     241 | #define SYSCALL_ENTRY_RET_SET   BIT(0)
         |                                 ^~~
   arch/powerpc/include/asm/ptrace.h:245:30: note: in expansion of macro 'SYSCALL_ENTRY_RET_SET'
     245 |         regs->entry_flags |= SYSCALL_ENTRY_RET_SET;
         |                              ^~~~~~~~~~~~~~~~~~~~~


vim +/BIT +241 arch/powerpc/include/asm/ptrace.h

   228	
   229	#define force_successful_syscall_return()   \
   230		do { \
   231			set_thread_flag(TIF_NOERROR); \
   232		} while(0)
   233	
   234	#define current_pt_regs() \
   235		((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
   236	
   237	/*
   238	 * SYSCALL_ENTRY_RET_SET: seccomp or ptrace called syscall_set_return_value()
   239	 * and wants the syscall skipped; regs->gpr[3] already holds the return value.
   240	 */
 > 241	#define SYSCALL_ENTRY_RET_SET	BIT(0)
   242	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

