Return-Path: <linuxppc-dev+bounces-24041-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8374C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 06:10:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxywv4XxMz2yH4;
	Sat, 11 Jul 2026 16:10:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783750223;
	cv=none; b=XF9w93FspuIKn358IZsp4zixTomsDHgY6+Ko0KeKEtJPl3L22Z/ssRZF1u4n6icL8dyfjc5jKzd62jJhe63lUqP3xNz3PjVxK4udldU0ckm4ZYA8Ha1Tp7g7TTLTAIoZu8p4gyUs5SbVVzg5h90VeNBiYuqiYOzBOp9hBp85dTtlQePxYt+7C1rgfVF+Y0dkH06M2xrq9D5ZtYzMv/59T6nct22cV0PnFbshIZWj83af8iEg9KRgQO1c6+Z8tskpuy0a10XkcVdJw40hhP/fh1i4GBPOM1ZlJLBAXOgXFteTAHmbjXVMa4lEkQ2Boc6eCQ4RErS2btd1Kx61C6rrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783750223; c=relaxed/relaxed;
	bh=Ps5ECDIjFLF+/0HwU0wGRXNNSijmo2Gn4WFU4mTwi80=;
	h=Date:From:To:Cc:Subject:Message-ID; b=L4X+OZ78oNparMK1iSpPZpbYAKXiZLie4pjQUFt87Kvvop/8FLZg01+lf5SwnjHMkOpQh1EWqtthviVikKPv6hOGrSaHasIUkF/yuk2o/2e9AWLB5koUH77ZT3J69kqqwctocJO7eq8za8Jda3gTX1gIVAqTJF9kfa36d+BaFMVlj8BJi2shHlgsbfDF6ej8mZIdPfz+kjhUZaAb/Rb2qP3CpyYx/8Chhm9DyCdCzG5GGbrakGgILPfEC9FiDaegN5tNQzxna415F93uyfvnGgH8tFVU5WLTgcaWQtuCdo/DqL4x9OY+XJgL215zDdYyCeJmFWlOmrUCidDoRb2HVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SI9oJ3a6; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SI9oJ3a6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxywr0G2mz2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 16:10:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783750220; x=1815286220;
  h=date:from:to:cc:subject:message-id;
  bh=Hm+k6CCIWVVNF7nkJK2LxoHLjpU04QYdXC17B2sHjCA=;
  b=SI9oJ3a670RYe/IyPgu2ecJwvD6ewh0rsKYJ2jRqpaaV29qmbtuLEyLA
   kmaPOMFwW3ef2/Ke4aXeXEKHMrAEZrnZ3o8XmtJfS+dQJvtCFKU9RI4Oy
   hE/p6n3nB9w8epxNUg4QcwMGb92FFZudukesr51j3jWfvjKHK7UEDAesw
   73XHFtao8wB4yTCg7GgUqyk54DR6B4Jt8PAJM0gYTleGH8aPvy5sS/Z0h
   QtjwQdoMFhAZGrSb4oiD3J2HlbEdscRvj4oNtL9SqwV4Kzr6FTkVbkm2P
   zSSOqWpo+QdJKQLbaPtvUJFo4lU5zaXnGtPRz++vlB4NLCrNtfzRUYrEq
   g==;
X-CSE-ConnectionGUID: VeaSv2QYTl+JxSvQWKrmvQ==
X-CSE-MsgGUID: +qWjUfM+RBS+9IqzZTEEoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71964244"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71964244"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 23:10:12 -0700
X-CSE-ConnectionGUID: Ego9bicsSHyvfJPR1p9j+g==
X-CSE-MsgGUID: wFwFdniKSjKLTE33/3kUlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258943262"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 10 Jul 2026 23:10:10 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiQud-00000000Jo6-3MD7;
	Sat, 11 Jul 2026 06:10:07 +0000
Date: Sat, 11 Jul 2026 14:08:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [powerpc:fixes-test 10/12] kernel/sched/core.c:7449:1:
 error: parameter names (without types) in function declaration
Message-ID: <202607111437.4PFwCibd-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes-test
head:   afc2830892a128a13a65f677271a0a48aeb61b5e
commit: 4747e17fe063720a30b1c0075bae3e8f8acd26f4 [10/12] powerpc/32: Use HAVE_PREEMPT_DYNAMIC_CALL instead of HAVE_PREEMPT_DYNAMIC_KEY
config: powerpc-mvme5100_defconfig (https://download.01.org/0day-ci/archive/20260711/202607111437.4PFwCibd-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607111437.4PFwCibd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607111437.4PFwCibd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:95,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:16:
   include/linux/static_call.h:223:9: warning: data definition has no type or storage class
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7449:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Wimplicit-int]
   kernel/sched/core.c:7449:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:7449:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
    7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: warning: data definition has no type or storage class
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7522:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7522 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Wimplicit-int]
   kernel/sched/core.c:7522:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7522 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7522:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
    7522 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: warning: data definition has no type or storage class
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7769:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7769 | EXPORT_STATIC_CALL_TRAMP(cond_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Wimplicit-int]
   kernel/sched/core.c:7769:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7769 | EXPORT_STATIC_CALL_TRAMP(cond_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7769:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
    7769 | EXPORT_STATIC_CALL_TRAMP(cond_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: warning: data definition has no type or storage class
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7774:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7774 | EXPORT_STATIC_CALL_TRAMP(might_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Wimplicit-int]
   kernel/sched/core.c:7774:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7774 | EXPORT_STATIC_CALL_TRAMP(might_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7774:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
    7774 | EXPORT_STATIC_CALL_TRAMP(might_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~


vim +7449 kernel/sched/core.c

009f60e2763568 Oleg Nesterov          2014-10-05  7441  
2c9a98d3bc8087 Peter Zijlstra (Intel  2021-01-18  7442) #ifdef CONFIG_PREEMPT_DYNAMIC
b7ebb758568b60 Ingo Molnar            2025-05-28  7443  # ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
8a69fe0be143b0 Mark Rutland           2022-02-14  7444  #  ifndef preempt_schedule_dynamic_enabled
8a69fe0be143b0 Mark Rutland           2022-02-14  7445  #   define preempt_schedule_dynamic_enabled	preempt_schedule
8a69fe0be143b0 Mark Rutland           2022-02-14  7446  #   define preempt_schedule_dynamic_disabled	NULL
8a69fe0be143b0 Mark Rutland           2022-02-14  7447  #  endif
8a69fe0be143b0 Mark Rutland           2022-02-14  7448  DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
ef72661e28c64a Peter Zijlstra         2021-01-25 @7449  EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
99cf983cc8bca4 Mark Rutland           2022-02-14  7450  # elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
99cf983cc8bca4 Mark Rutland           2022-02-14  7451  static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule);
99cf983cc8bca4 Mark Rutland           2022-02-14  7452  void __sched notrace dynamic_preempt_schedule(void)
99cf983cc8bca4 Mark Rutland           2022-02-14  7453  {
99cf983cc8bca4 Mark Rutland           2022-02-14  7454  	if (!static_branch_unlikely(&sk_dynamic_preempt_schedule))
99cf983cc8bca4 Mark Rutland           2022-02-14  7455  		return;
99cf983cc8bca4 Mark Rutland           2022-02-14  7456  	preempt_schedule();
99cf983cc8bca4 Mark Rutland           2022-02-14  7457  }
99cf983cc8bca4 Mark Rutland           2022-02-14  7458  NOKPROBE_SYMBOL(dynamic_preempt_schedule);
99cf983cc8bca4 Mark Rutland           2022-02-14  7459  EXPORT_SYMBOL(dynamic_preempt_schedule);
99cf983cc8bca4 Mark Rutland           2022-02-14  7460  # endif
b7ebb758568b60 Ingo Molnar            2025-05-28  7461  #endif /* CONFIG_PREEMPT_DYNAMIC */
2c9a98d3bc8087 Peter Zijlstra (Intel  2021-01-18  7462) 

:::::: The code at line 7449 was first introduced by commit
:::::: ef72661e28c64ad610f89acc2832ec67b27ba438 sched: Harden PREEMPT_DYNAMIC

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

