Return-Path: <fengguang.wu@intel.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTzs830dqzDqhc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 18:17:32 +1000 (AEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 3rTzs725B6z9t1P
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2016 18:17:30 +1000 (AEST)
Date: Wed, 15 Jun 2016 16:16:09 +0800
From: kbuild test robot <lkp@intel.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@ozlabs.org, mikey@neuling.org
Subject: Re: [PATCH 2/2] powerpc: tm: Always reclaim in start_thread() for
 exec() class syscalls
Message-ID: <201606151639.x1QEeIAr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
In-Reply-To: <20160615064457.8369-2-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.7-rc3 next-20160615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Cyril-Bur/selftests-powerpc-exec-with-suspended-transaction/20160615-144928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-tqm8560_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/processor.h:13:0,
                    from arch/powerpc/include/asm/thread_info.h:33,
                    from include/linux/thread_info.h:54,
                    from include/asm-generic/preempt.h:4,
                    from arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/uapi/linux/timex.h:56,
                    from include/linux/timex.h:56,
                    from include/linux/sched.h:19,
                    from arch/powerpc/kernel/process.c:18:
   arch/powerpc/kernel/process.c: In function 'start_thread':
>> arch/powerpc/include/asm/reg.h:64:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
>> arch/powerpc/include/asm/reg.h:116:18: note: in expansion of macro '__MASK'
    #define MSR_TS_T __MASK(MSR_TS_T_LG) /*  Transaction Transactional */
                     ^
>> arch/powerpc/include/asm/reg.h:117:22: note: in expansion of macro 'MSR_TS_T'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                         ^
>> arch/powerpc/include/asm/reg.h:121:37: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_SUSPENDED(x) (((x) & MSR_TS_MASK) == MSR_TS_S)
                                        ^
>> arch/powerpc/kernel/process.c:1517:6: note: in expansion of macro 'MSR_TM_SUSPENDED'
     if (MSR_TM_SUSPENDED(mfmsr()))
         ^
>> arch/powerpc/include/asm/reg.h:64:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
   arch/powerpc/include/asm/reg.h:115:18: note: in expansion of macro '__MASK'
    #define MSR_TS_S __MASK(MSR_TS_S_LG) /*  Transaction Suspended */
                     ^
>> arch/powerpc/include/asm/reg.h:117:33: note: in expansion of macro 'MSR_TS_S'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                                    ^
>> arch/powerpc/include/asm/reg.h:121:37: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_SUSPENDED(x) (((x) & MSR_TS_MASK) == MSR_TS_S)
                                        ^
>> arch/powerpc/kernel/process.c:1517:6: note: in expansion of macro 'MSR_TM_SUSPENDED'
     if (MSR_TM_SUSPENDED(mfmsr()))
         ^
>> arch/powerpc/include/asm/reg.h:64:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
   arch/powerpc/include/asm/reg.h:115:18: note: in expansion of macro '__MASK'
    #define MSR_TS_S __MASK(MSR_TS_S_LG) /*  Transaction Suspended */
                     ^
   arch/powerpc/include/asm/reg.h:121:53: note: in expansion of macro 'MSR_TS_S'
    #define MSR_TM_SUSPENDED(x) (((x) & MSR_TS_MASK) == MSR_TS_S)
                                                        ^
>> arch/powerpc/kernel/process.c:1517:6: note: in expansion of macro 'MSR_TM_SUSPENDED'
     if (MSR_TM_SUSPENDED(mfmsr()))
         ^
   cc1: all warnings being treated as errors

vim +/MSR_TM_SUSPENDED +1517 arch/powerpc/kernel/process.c

  1501	#endif
  1502	
  1503		/*
  1504		 * If we exec out of a kernel thread then thread.regs will not be
  1505		 * set.  Do it now.
  1506		 */
  1507		if (!current->thread.regs) {
  1508			struct pt_regs *regs = task_stack_page(current) + THREAD_SIZE;
  1509			current->thread.regs = regs - 1;
  1510		}
  1511	
  1512		/*
  1513		 * Clear any transactional state, we're exec()ing. The cause is
  1514		 * not important as there will never be a recheckpoint so it's not
  1515		 * user visible.
  1516		 */
> 1517		if (MSR_TM_SUSPENDED(mfmsr()))
  1518			tm_reclaim_current(0);
  1519	
  1520		memset(regs->gpr, 0, sizeof(regs->gpr));
  1521		regs->ctr = 0;
  1522		regs->link = 0;
  1523		regs->xer = 0;
  1524		regs->ccr = 0;
  1525		regs->gpr[1] = sp;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--45Z9DzgjV8m4Oswq
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
0D1jfNT/lRL0aPF3U6VI5P0gSOM/lZHqB9NrAAA=

--45Z9DzgjV8m4Oswq--
