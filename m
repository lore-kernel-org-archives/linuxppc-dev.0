Return-Path: <linuxppc-dev+bounces-24031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510F9C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 20:54:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxkbs45X8z2yS4;
	Sat, 11 Jul 2026 06:54:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783716889;
	cv=none; b=V7KvBKRJMscT+BMfIQTgNAQtOzohsuY7DQ9fqCEF47lQYez7q8QuFQBBGgXsdq3UrDo/96QfWgO56i0u13sadHnfXQu83xJNV1j8NevwDLfU2Vt7j/k5VxCVbDtx8QjW/Hm0h5qF59oC6CUEXfe+aMyAgpL6eYYk0jM7T5Dx565/bIU3BwX6Umg2K6k6j0zO3N+gEx9+KyWcSMhOF7IU6zF6Y2pwAqJYWq1DDmUr3+BwXwRIzRAZxa/dWnluxh2Sv0JFSU0p7fUC1MkQRdyxYUR/0YDY5tjBWNKn8kVNTqLrPwPh/Got2LFAhqwSRCZJBOVC9Mi4EOVHujuXDDOBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783716889; c=relaxed/relaxed;
	bh=L3z/ny8fLKJCZiDaz49pc52iFYzbXA5ZLH+VRVsHhLc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OJ/49oW2Gl8Z+1AjLwf7HCFpNfKyejxioibHL5AsJ/VycuHgY4gq7n2Sx6Aos/JI8Kf9iXOXIupEvBxPM2EHmfLSwm7UlzgJXil6oOJl1BPznWP9xilVq93KURDWQ6ot8M5crp74vDGhNziv5uOUwOnbkFIIOaXZgZ66/CVJ151M2Dw28X+ciApACqEe6VWScYrFqpgNapn7COdsgNdQLymVICQlXZJ0phqxJLXntIZdcfLPkFBqY864+K3vO4sCxRd/IPKMZCwYvGLg10hgGSPo4Insx44n4IABGGlRr5mDCgtv2UtV7n/vp063A3vPJtX4LqTcN+JMU3ydD/TSSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eGLV3/0Z; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eGLV3/0Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxkbp2SCjz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 06:54:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783716887; x=1815252887;
  h=date:from:to:cc:subject:message-id;
  bh=ufgvTNGe+I32fwGgBejQFwRiEAFRtix7NiO4PxttKUs=;
  b=eGLV3/0ZxV8DBAiXcSxHmBdYlfWmjX2e7S96DSIKmoP+P1hw8M4GjlfP
   kR1KpIQosSwIBGlJ0SS6OrMHKt70/rgjaNBvDKqVXvgAmThH7M4nf6+Vu
   CMnYvwt/7P4TutOkkeLL1n9iX0EBnLzU5YT9t2BXBxOKAb57ra47jJqPo
   GtY52cxdg6TkBnE29twuE0fEz8I6IvfVgNXFfF8Epr2uRhBdrGTitAU54
   mSSRD8kh7PhYbUYQ4pjA0N8G0eJ4a6oJ6y0HTWOI9qP5JGuD7WXeqbiFI
   RrYfUHIs1Ya8urMSackSAr8aG/HRCMLDzLXDwTNeJLKrLcT2IxgYQxx72
   g==;
X-CSE-ConnectionGUID: SbiX9aa0QzOp/l5XsAzx0A==
X-CSE-MsgGUID: qMoNtkd/QIqWQHAsBmuy6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95571471"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95571471"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 13:54:40 -0700
X-CSE-ConnectionGUID: 0Wdr5OXlQRysnOkanXlE2A==
X-CSE-MsgGUID: k5CIbPDvSryOV2l3ORUYKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259873774"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 10 Jul 2026 13:54:37 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiIF0-00000000JNZ-1szm;
	Fri, 10 Jul 2026 20:54:34 +0000
Date: Sat, 11 Jul 2026 04:54:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [powerpc:fixes-test 10/12] kernel/sched/core.c:7449:1:
 error: type specifier missing, defaults to 'int'; ISO C99 and later do not
 support implicit int
Message-ID: <202607110422.frjmJOf8-lkp@intel.com>
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
config: powerpc-randconfig-002-20260711 (https://download.01.org/0day-ci/archive/20260711/202607110422.frjmJOf8-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607110422.frjmJOf8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607110422.frjmJOf8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/core.c:7449:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
         | ^
   include/linux/static_call.h:223:2: note: expanded from macro 'EXPORT_STATIC_CALL_TRAMP'
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^
>> kernel/sched/core.c:7449:26: error: a parameter list without types is only allowed in a function definition
    7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
         |                          ^
   kernel/sched/core.c:7522:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    7522 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
         | ^
   include/linux/static_call.h:223:2: note: expanded from macro 'EXPORT_STATIC_CALL_TRAMP'
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^
   kernel/sched/core.c:7522:26: error: a parameter list without types is only allowed in a function definition
    7522 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
         |                          ^
   kernel/sched/core.c:7769:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    7769 | EXPORT_STATIC_CALL_TRAMP(cond_resched);
         | ^
   include/linux/static_call.h:223:2: note: expanded from macro 'EXPORT_STATIC_CALL_TRAMP'
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^
   kernel/sched/core.c:7769:26: error: a parameter list without types is only allowed in a function definition
    7769 | EXPORT_STATIC_CALL_TRAMP(cond_resched);
         |                          ^
   kernel/sched/core.c:7774:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    7774 | EXPORT_STATIC_CALL_TRAMP(might_resched);
         | ^
   include/linux/static_call.h:223:2: note: expanded from macro 'EXPORT_STATIC_CALL_TRAMP'
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^
   kernel/sched/core.c:7774:26: error: a parameter list without types is only allowed in a function definition
    7774 | EXPORT_STATIC_CALL_TRAMP(might_resched);
         |                          ^
   8 errors generated.


vim +/int +7449 kernel/sched/core.c

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

