Return-Path: <linuxppc-dev+bounces-24036-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA65C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 01:53:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxsDw56lMz2yRn;
	Sat, 11 Jul 2026 11:53:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783734832;
	cv=none; b=HYN/Uh2CBHzIBKCo0goNliGR6VVhJJ5E4eTjOYEQkknUrnT/PqehJiQG64U0mcBQdQbdvvEGQ7NKHxnok7EPuljPWh0C9BdzrzmljEKiYQw/Oz/f/Br/K0YDchbolR9Hk3SRFnc4u5SD9y6SfYOwqO7NcKwia1PVAD8xerdRTq2pAU7DVO4goqjsiIZI70ZvRaFr2yEsVpm4ykc25jIp5q00OgqNXTp2pR86CVqv68cJWiUXWcrXIcsVAInvkeXtzvh23TphaX7oGLzIL6zpwRHJUyHhu0kx+w2qJ325TaQh+EjXEDT+aj9FH/Yi3aZ8nf5W7ag6TPl82ADtiggNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783734832; c=relaxed/relaxed;
	bh=K9Kp4rGTzl7KyzMMSuuNRS8/tZo6jBIs0eAwG/BVzJ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nbkbcf5/bzZcn8MIPVM0vWST3n+g2CkHvqLEaRwbpjzd+Ivf4mka4/gADzTCZ5NqaVKawwuM/76dvnokqTqa0m33m6HX/RQ37o8JmGip98VOzC6SPO2P7OwnyuNd6BuCtCLnGqKPz6SYbqeeBPjFd+8QpLEju+Vuf9nrC08Ybuo45Bc7iQjwxEy71nG1rqugI2ee+aHwB3OHBKAEbPTe61S3lEqNb9F8KCDhyaNlouA41PNKxhO4JTm/cUJHQYeOjQTQbd9R1ZbhwfwfKnA/5lPkvaYtyPr0bfzSC/MB4VIm2flzC8YB9a/GkHAXqI04jdS8EcNTSed//5WE/VRovQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lz/S1cvr; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lz/S1cvr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxsDr55t4z2yN8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 11:53:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783734829; x=1815270829;
  h=date:from:to:cc:subject:message-id;
  bh=Xih0NB+jFhynOeXHiBrDWRNbJpLGlJUSCR00d/KRWR0=;
  b=Lz/S1cvrnjixlcnxc4EfMjIJhlZ8rn5xZDzwc0DnBBaC7YK8OaMWsp/z
   38cYuDlKefpSKYrGB/tUISmnkgBw56AbV3WCog/32Y5IFTg6YoGyK89re
   Zv/7qpEWI5ft0SuTQwaQNWyxtIu0FZCUJW3aWGW2fSOp8tmE3B3SukRtn
   0dKPFAnIzotFtsZXFOrelpjXv1pA5HzVIOt8O6X533aUykRO7NaE37Fy+
   BcT88X/scxZHXlk4MupYfLTdk2obJuQ2yIxv49TLJ90icdvaJcoOITRC2
   dYP0KaLiWjqjgs4I0xPwlGNOIuMJtQkCpaSZ+4Eblh7O5KZyZHQMMmiro
   w==;
X-CSE-ConnectionGUID: 6cCx7foOSEC7lA9NW5S7rg==
X-CSE-MsgGUID: uqasu/WHQjy1JI3fuas0vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71956493"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71956493"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 18:53:41 -0700
X-CSE-ConnectionGUID: uLB3+yjaTvKR1wLSLP/A+A==
X-CSE-MsgGUID: dHg1WxDZQ9yZ2AnDWwcZrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259929405"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 10 Jul 2026 18:53:39 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiMuO-00000000JcI-1v6c;
	Sat, 11 Jul 2026 01:53:36 +0000
Date: Sat, 11 Jul 2026 09:52:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [powerpc:fixes-test 10/12]
 include/linux/static_call.h:223:9: warning: data definition has no type or
 storage class
Message-ID: <202607110847.u4TL0RJC-lkp@intel.com>
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
config: powerpc-randconfig-001-20260711 (https://download.01.org/0day-ci/archive/20260711/202607110847.u4TL0RJC-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607110847.u4TL0RJC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607110847.u4TL0RJC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:95,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:16:
>> include/linux/static_call.h:223:9: warning: data definition has no type or storage class
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7449:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Werror=implicit-int]
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7449:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7449 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:7449:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:95,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:16:
>> include/linux/static_call.h:223:9: warning: data definition has no type or storage class
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7522:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7522 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Werror=implicit-int]
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7522:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7522 | EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7522:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:95,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:16:
>> include/linux/static_call.h:223:9: warning: data definition has no type or storage class
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7769:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7769 | EXPORT_STATIC_CALL_TRAMP(cond_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Werror=implicit-int]
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7769:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7769 | EXPORT_STATIC_CALL_TRAMP(cond_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7769:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:95,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:16:
>> include/linux/static_call.h:223:9: warning: data definition has no type or storage class
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7774:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7774 | EXPORT_STATIC_CALL_TRAMP(might_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:223:9: error: type defaults to 'int' in declaration of 'ARCH_ADD_TRAMP_KEY' [-Werror=implicit-int]
     223 |         ARCH_ADD_TRAMP_KEY(name)
         |         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7774:1: note: in expansion of macro 'EXPORT_STATIC_CALL_TRAMP'
    7774 | EXPORT_STATIC_CALL_TRAMP(might_resched);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:7774:1: warning: parameter names (without types) in function declaration
   cc1: some warnings being treated as errors


vim +223 include/linux/static_call.h

9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  212  
9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  213  #define EXPORT_STATIC_CALL(name)					\
9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  214  	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  215  	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  216  #define EXPORT_STATIC_CALL_GPL(name)					\
9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  217  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  218  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
9183c3f9ed710a8 Josh Poimboeuf 2020-08-18  219  
73f44fe19d35963 Josh Poimboeuf 2021-01-27  220  /* Leave the key unexported, so modules can't change static call targets: */
73f44fe19d35963 Josh Poimboeuf 2021-01-27  221  #define EXPORT_STATIC_CALL_TRAMP(name)					\
73f44fe19d35963 Josh Poimboeuf 2021-01-27  222  	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
73f44fe19d35963 Josh Poimboeuf 2021-01-27 @223  	ARCH_ADD_TRAMP_KEY(name)
73f44fe19d35963 Josh Poimboeuf 2021-01-27  224  #define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
73f44fe19d35963 Josh Poimboeuf 2021-01-27  225  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
73f44fe19d35963 Josh Poimboeuf 2021-01-27  226  	ARCH_ADD_TRAMP_KEY(name)
73f44fe19d35963 Josh Poimboeuf 2021-01-27  227  

:::::: The code at line 223 was first introduced by commit
:::::: 73f44fe19d359635a607e8e8daa0da4001c1cfc2 static_call: Allow module use without exposing static_call_key

:::::: TO: Josh Poimboeuf <jpoimboe@redhat.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

