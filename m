Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfm0v2HFPzDsgc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 15:54:55 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8M5rEY0023665
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:54:53 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ktaag9h9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:54:52 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Thu, 22 Sep 2016 11:24:47 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8467CE0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 11:24:07 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8M5sitH18874574
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 11:24:44 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8M5sf2U003048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 11:24:44 +0530
Date: Thu, 22 Sep 2016 13:54:30 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kbuild test robot <lkp@intel.com>
CC: kbuild-all@01.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, peterz@infradead.org,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 6/6] powerpc: pSeries: Add pv-qspinlock build
 config/make
References: <201609191651.3BF51xRa%fengguang.wu@intel.com>
In-Reply-To: <201609191651.3BF51xRa%fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <57E37216.1030505@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi, all
	ok, this patch set depends on
https://patchwork.kernel.org/patch/8953981/ [V4] powerpc: Implement {cmp}xchg for u8 and u16

sorry.

On 2016年09月19日 16:58, kbuild test robot wrote:
> Hi Pan,
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.8-rc7 next-20160916]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
>
> url:    https://github.com/0day-ci/linux/commits/Pan-Xinhui/Implement-qspinlock-pv-qspinlock-on-ppc/20160919-133130
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-allyesconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=powerpc
>
> All errors (new ones prefixed by >>):
>
>     include/linux/compiler.h:491:2: note: in expansion of macro '_compiletime_assert'
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>       ^~~~~~~~~~~~~~~~~~~
>     include/linux/bug.h:51:37: note: in expansion of macro 'compiletime_assert'
>      #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                          ^~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/cmpxchg.h:326:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg");
>       ^~~~~~~~~~~~~~~~
>     In function '__cmpxchg',
>         inlined from 'pv_wait_node' at kernel/locking/qspinlock_paravirt.h:328:3,
>         inlined from '__pv_queued_spin_lock_slowpath' at kernel/locking/qspinlock.c:538:3:
>     include/linux/compiler.h:491:38: error: call to '__compiletime_assert_326' declared with attribute error: Unsupported size for __cmpxchg
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                           ^
>     include/linux/compiler.h:474:4: note: in definition of macro '__compiletime_assert'
>         prefix ## suffix();    \
>         ^~~~~~
>     include/linux/compiler.h:491:2: note: in expansion of macro '_compiletime_assert'
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>       ^~~~~~~~~~~~~~~~~~~
>     include/linux/bug.h:51:37: note: in expansion of macro 'compiletime_assert'
>      #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                          ^~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/cmpxchg.h:326:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg");
>       ^~~~~~~~~~~~~~~~
>     In function '__cmpxchg',
>         inlined from 'pv_wait_head_or_lock' at kernel/locking/qspinlock_paravirt.h:109:10,
>         inlined from '__pv_queued_spin_lock_slowpath' at kernel/locking/qspinlock.c:573:5:
>     include/linux/compiler.h:491:38: error: call to '__compiletime_assert_326' declared with attribute error: Unsupported size for __cmpxchg
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                           ^
>     include/linux/compiler.h:474:4: note: in definition of macro '__compiletime_assert'
>         prefix ## suffix();    \
>         ^~~~~~
>     include/linux/compiler.h:491:2: note: in expansion of macro '_compiletime_assert'
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>       ^~~~~~~~~~~~~~~~~~~
>     include/linux/bug.h:51:37: note: in expansion of macro 'compiletime_assert'
>      #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                          ^~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/cmpxchg.h:326:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg");
>       ^~~~~~~~~~~~~~~~
>     In function '__xchg_relaxed',
>         inlined from 'pv_wait_head_or_lock' at kernel/locking/qspinlock_paravirt.h:442:8,
>         inlined from '__pv_queued_spin_lock_slowpath' at kernel/locking/qspinlock.c:573:5:
>     include/linux/compiler.h:491:38: error: call to '__compiletime_assert_113' declared with attribute error: Unsupported size for __xchg_local
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                           ^
>     include/linux/compiler.h:474:4: note: in definition of macro '__compiletime_assert'
>         prefix ## suffix();    \
>         ^~~~~~
>     include/linux/compiler.h:491:2: note: in expansion of macro '_compiletime_assert'
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>       ^~~~~~~~~~~~~~~~~~~
>     include/linux/bug.h:51:37: note: in expansion of macro 'compiletime_assert'
>      #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                          ^~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/cmpxchg.h:113:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_local");
>       ^~~~~~~~~~~~~~~~
>     In function '__cmpxchg',
>         inlined from 'pv_kick_node' at kernel/locking/qspinlock_paravirt.h:366:6,
>         inlined from '__pv_queued_spin_lock_slowpath' at kernel/locking/qspinlock.c:616:2:
>     include/linux/compiler.h:491:38: error: call to '__compiletime_assert_326' declared with attribute error: Unsupported size for __cmpxchg
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                           ^
>     include/linux/compiler.h:474:4: note: in definition of macro '__compiletime_assert'
>         prefix ## suffix();    \
>         ^~~~~~
>     include/linux/compiler.h:491:2: note: in expansion of macro '_compiletime_assert'
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>       ^~~~~~~~~~~~~~~~~~~
>     include/linux/bug.h:51:37: note: in expansion of macro 'compiletime_assert'
>      #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                          ^~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/cmpxchg.h:326:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg");
>       ^~~~~~~~~~~~~~~~
>     In function '__xchg_relaxed',
>         inlined from '__pv_queued_spin_lock_slowpath' at kernel/locking/qspinlock.c:184:14:
>     include/linux/compiler.h:491:38: error: call to '__compiletime_assert_113' declared with attribute error: Unsupported size for __xchg_local
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                           ^
>     include/linux/compiler.h:474:4: note: in definition of macro '__compiletime_assert'
>         prefix ## suffix();    \
>         ^~~~~~
>     include/linux/compiler.h:491:2: note: in expansion of macro '_compiletime_assert'
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>       ^~~~~~~~~~~~~~~~~~~
>     include/linux/bug.h:51:37: note: in expansion of macro 'compiletime_assert'
>      #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                          ^~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/cmpxchg.h:113:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_local");
>       ^~~~~~~~~~~~~~~~
>     In function '__cmpxchg_relaxed',
>         inlined from '__pv_queued_spin_unlock' at kernel/locking/qspinlock_paravirt.h:547:11:
>>> include/linux/compiler.h:491:38: error: call to '__compiletime_assert_358' declared with attribute error: Unsupported size for __cmpxchg_relaxed
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                           ^
>     include/linux/compiler.h:474:4: note: in definition of macro '__compiletime_assert'
>         prefix ## suffix();    \
>         ^~~~~~
>     include/linux/compiler.h:491:2: note: in expansion of macro '_compiletime_assert'
>       _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>       ^~~~~~~~~~~~~~~~~~~
>     include/linux/bug.h:51:37: note: in expansion of macro 'compiletime_assert'
>      #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                          ^~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/cmpxchg.h:358:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_relaxed");
>       ^~~~~~~~~~~~~~~~
>
> vim +/__compiletime_assert_358 +491 include/linux/compiler.h
>
> 9a8ab1c3 Daniel Santos  2013-02-21  475  		__compiletime_error_fallback(__cond);			\
> 9a8ab1c3 Daniel Santos  2013-02-21  476  	} while (0)
> 9a8ab1c3 Daniel Santos  2013-02-21  477
> 9a8ab1c3 Daniel Santos  2013-02-21  478  #define _compiletime_assert(condition, msg, prefix, suffix) \
> 9a8ab1c3 Daniel Santos  2013-02-21  479  	__compiletime_assert(condition, msg, prefix, suffix)
> 9a8ab1c3 Daniel Santos  2013-02-21  480
> 9a8ab1c3 Daniel Santos  2013-02-21  481  /**
> 9a8ab1c3 Daniel Santos  2013-02-21  482   * compiletime_assert - break build and emit msg if condition is false
> 9a8ab1c3 Daniel Santos  2013-02-21  483   * @condition: a compile-time constant condition to check
> 9a8ab1c3 Daniel Santos  2013-02-21  484   * @msg:       a message to emit if condition is false
> 9a8ab1c3 Daniel Santos  2013-02-21  485   *
> 9a8ab1c3 Daniel Santos  2013-02-21  486   * In tradition of POSIX assert, this macro will break the build if the
> 9a8ab1c3 Daniel Santos  2013-02-21  487   * supplied condition is *false*, emitting the supplied error message if the
> 9a8ab1c3 Daniel Santos  2013-02-21  488   * compiler has support to do so.
> 9a8ab1c3 Daniel Santos  2013-02-21  489   */
> 9a8ab1c3 Daniel Santos  2013-02-21  490  #define compiletime_assert(condition, msg) \
> 9a8ab1c3 Daniel Santos  2013-02-21 @491  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> 9a8ab1c3 Daniel Santos  2013-02-21  492
> 47933ad4 Peter Zijlstra 2013-11-06  493  #define compiletime_assert_atomic_type(t)				\
> 47933ad4 Peter Zijlstra 2013-11-06  494  	compiletime_assert(__native_word(t),				\
> 47933ad4 Peter Zijlstra 2013-11-06  495  		"Need native word sized stores/loads for atomicity.")
> 47933ad4 Peter Zijlstra 2013-11-06  496
> 9c3cdc1f Linus Torvalds 2008-05-10  497  /*
> 9c3cdc1f Linus Torvalds 2008-05-10  498   * Prevent the compiler from merging or refetching accesses.  The compiler
> 9c3cdc1f Linus Torvalds 2008-05-10  499   * is also forbidden from reordering successive instances of ACCESS_ONCE(),
>
> :::::: The code at line 491 was first introduced by commit
> :::::: 9a8ab1c39970a4938a72d94e6fd13be88a797590 bug.h, compiler.h: introduce compiletime_assert & BUILD_BUG_ON_MSG
>
> :::::: TO: Daniel Santos <daniel.santos@pobox.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
