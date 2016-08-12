Return-Path: <fengguang.wu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s9V7n0S21zDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 13:03:16 +1000 (AEST)
Date: Fri, 12 Aug 2016 11:01:45 +0800
From: kbuild test robot <lkp@intel.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 wei.guo.simon@gmail.com, mikey@neuling.org, anton@samba.org
Subject: Re: [PATCH v2 02/20] powerpc: Always restore FPU/VEC/VSX if hardware
 transactional memory in use
Message-ID: <201608121121.AAIp28Wj%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
In-Reply-To: <20160811232819.11453-3-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Cyril,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.8-rc1 next-20160811]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Cyril-Bur/Consistent-TM-structures/20160812-075557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-sbc834x_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
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
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/uapi/linux/timex.h:56,
                    from include/linux/timex.h:56,
                    from include/linux/sched.h:19,
                    from arch/powerpc/kernel/process.c:18:
   arch/powerpc/kernel/process.c: In function 'restore_fp':
>> arch/powerpc/include/asm/reg.h:64:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
>> arch/powerpc/include/asm/reg.h:116:18: note: in expansion of macro '__MASK'
    #define MSR_TS_T __MASK(MSR_TS_T_LG) /*  Transaction Transactional */
                     ^
>> arch/powerpc/include/asm/reg.h:117:22: note: in expansion of macro 'MSR_TS_T'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                         ^
>> arch/powerpc/include/asm/reg.h:118:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^
>> arch/powerpc/kernel/process.c:211:29: note: in expansion of macro 'MSR_TM_ACTIVE'
     if (tsk->thread.load_fp || MSR_TM_ACTIVE(tsk->thread.regs->msr)) {
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
>> arch/powerpc/include/asm/reg.h:118:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^
>> arch/powerpc/kernel/process.c:211:29: note: in expansion of macro 'MSR_TM_ACTIVE'
     if (tsk->thread.load_fp || MSR_TM_ACTIVE(tsk->thread.regs->msr)) {
                                ^
   arch/powerpc/kernel/process.c: In function 'restore_math':
>> arch/powerpc/include/asm/reg.h:64:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
>> arch/powerpc/include/asm/reg.h:116:18: note: in expansion of macro '__MASK'
    #define MSR_TS_T __MASK(MSR_TS_T_LG) /*  Transaction Transactional */
                     ^
>> arch/powerpc/include/asm/reg.h:117:22: note: in expansion of macro 'MSR_TS_T'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                         ^
>> arch/powerpc/include/asm/reg.h:118:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^
   arch/powerpc/kernel/process.c:468:7: note: in expansion of macro 'MSR_TM_ACTIVE'
     if (!MSR_TM_ACTIVE(regs->msr) &&
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
>> arch/powerpc/include/asm/reg.h:118:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^
   arch/powerpc/kernel/process.c:468:7: note: in expansion of macro 'MSR_TM_ACTIVE'
     if (!MSR_TM_ACTIVE(regs->msr) &&
          ^
   cc1: all warnings being treated as errors

vim +/MSR_TM_ACTIVE +211 arch/powerpc/kernel/process.c

   195	EXPORT_SYMBOL_GPL(flush_fp_to_thread);
   196	
   197	void enable_kernel_fp(void)
   198	{
   199		WARN_ON(preemptible());
   200	
   201		msr_check_and_set(MSR_FP);
   202	
   203		if (current->thread.regs && (current->thread.regs->msr & MSR_FP)) {
   204			check_if_tm_restore_required(current);
   205			__giveup_fpu(current);
   206		}
   207	}
   208	EXPORT_SYMBOL(enable_kernel_fp);
   209	
   210	static int restore_fp(struct task_struct *tsk) {
 > 211		if (tsk->thread.load_fp || MSR_TM_ACTIVE(tsk->thread.regs->msr)) {
   212			load_fp_state(&current->thread.fp_state);
   213			current->thread.load_fp++;
   214			return 1;
   215		}
   216		return 0;
   217	}
   218	#else
   219	static int restore_fp(struct task_struct *tsk) { return 0; }

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--AhhlLboLdkugWU4S
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
z9H/B4q2yjYq9QAA

--AhhlLboLdkugWU4S--
