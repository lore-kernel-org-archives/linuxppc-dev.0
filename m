Return-Path: <lkp@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416s2d23HxzF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 06:06:45 +1000 (AEST)
Date: Sat, 16 Jun 2018 04:06:31 +0800
From: kbuild test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 1/3] powerpc/tm: Remove msr_tm_active()
Message-ID: <201806160346.lDndh49W%fengguang.wu@intel.com>
References: <1529084262-16372-1-git-send-email-leitao@debian.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
In-Reply-To: <1529084262-16372-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Breno,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.17 next-20180615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Breno-Leitao/powerpc-tm-Remove-msr_tm_active/20180616-015124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-mpc8272_ads_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/processor.h:13:0,
                    from arch/powerpc/include/asm/thread_info.h:26,
                    from include/linux/thread_info.h:38,
                    from arch/powerpc/include/asm/ptrace.h:158,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:537,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:5,
                    from include/linux/rcupdate.h:38,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/powerpc/kernel/process.c:18:
   arch/powerpc/kernel/process.c: In function 'enable_kernel_fp':
>> arch/powerpc/include/asm/reg.h:65:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
>> arch/powerpc/include/asm/reg.h:117:18: note: in expansion of macro '__MASK'
    #define MSR_TS_T __MASK(MSR_TS_T_LG) /*  Transaction Transactional */
                     ^~~~~~
>> arch/powerpc/include/asm/reg.h:118:22: note: in expansion of macro 'MSR_TS_T'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                         ^~~~~~~~
>> arch/powerpc/include/asm/reg.h:119:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^~~~~~~~~~~
>> arch/powerpc/kernel/process.c:244:7: note: in expansion of macro 'MSR_TM_ACTIVE'
      if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
          ^~~~~~~~~~~~~
>> arch/powerpc/include/asm/reg.h:65:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
   arch/powerpc/include/asm/reg.h:116:18: note: in expansion of macro '__MASK'
    #define MSR_TS_S __MASK(MSR_TS_S_LG) /*  Transaction Suspended */
                     ^~~~~~
>> arch/powerpc/include/asm/reg.h:118:33: note: in expansion of macro 'MSR_TS_S'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                                    ^~~~~~~~
>> arch/powerpc/include/asm/reg.h:119:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^~~~~~~~~~~
>> arch/powerpc/kernel/process.c:244:7: note: in expansion of macro 'MSR_TM_ACTIVE'
      if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
          ^~~~~~~~~~~~~
>> arch/powerpc/include/asm/reg.h:65:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
>> arch/powerpc/include/asm/reg.h:117:18: note: in expansion of macro '__MASK'
    #define MSR_TS_T __MASK(MSR_TS_T_LG) /*  Transaction Transactional */
                     ^~~~~~
>> arch/powerpc/include/asm/reg.h:118:22: note: in expansion of macro 'MSR_TS_T'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                         ^~~~~~~~
>> arch/powerpc/include/asm/reg.h:119:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^~~~~~~~~~~
   arch/powerpc/kernel/process.c:244:32: note: in expansion of macro 'MSR_TM_ACTIVE'
      if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
                                   ^~~~~~~~~~~~~
>> arch/powerpc/include/asm/reg.h:65:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
   arch/powerpc/include/asm/reg.h:116:18: note: in expansion of macro '__MASK'
    #define MSR_TS_S __MASK(MSR_TS_S_LG) /*  Transaction Suspended */
                     ^~~~~~
>> arch/powerpc/include/asm/reg.h:118:33: note: in expansion of macro 'MSR_TS_S'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                                    ^~~~~~~~
>> arch/powerpc/include/asm/reg.h:119:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^~~~~~~~~~~
   arch/powerpc/kernel/process.c:244:32: note: in expansion of macro 'MSR_TM_ACTIVE'
      if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
                                   ^~~~~~~~~~~~~
   arch/powerpc/kernel/process.c: In function 'restore_math':
>> arch/powerpc/include/asm/reg.h:65:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
>> arch/powerpc/include/asm/reg.h:117:18: note: in expansion of macro '__MASK'
    #define MSR_TS_T __MASK(MSR_TS_T_LG) /*  Transaction Transactional */
                     ^~~~~~
>> arch/powerpc/include/asm/reg.h:118:22: note: in expansion of macro 'MSR_TS_T'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                         ^~~~~~~~
>> arch/powerpc/include/asm/reg.h:119:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^~~~~~~~~~~
   arch/powerpc/kernel/process.c:527:7: note: in expansion of macro 'MSR_TM_ACTIVE'
     if (!MSR_TM_ACTIVE(regs->msr) &&
          ^~~~~~~~~~~~~

vim +/MSR_TM_ACTIVE +244 arch/powerpc/kernel/process.c

   226	
   227	void enable_kernel_fp(void)
   228	{
   229		unsigned long cpumsr;
   230	
   231		WARN_ON(preemptible());
   232	
   233		cpumsr = msr_check_and_set(MSR_FP);
   234	
   235		if (current->thread.regs && (current->thread.regs->msr & MSR_FP)) {
   236			check_if_tm_restore_required(current);
   237			/*
   238			 * If a thread has already been reclaimed then the
   239			 * checkpointed registers are on the CPU but have definitely
   240			 * been saved by the reclaim code. Don't need to and *cannot*
   241			 * giveup as this would save  to the 'live' structure not the
   242			 * checkpointed structure.
   243			 */
 > 244			if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
   245				return;
   246			__giveup_fpu(current);
   247		}
   248	}
   249	EXPORT_SYMBOL(enable_kernel_fp);
   250	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--LQksG6bCIzRHxTLp--
