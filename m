Return-Path: <fengguang.wu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHmcf14WjzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 18:16:33 +1000 (AEST)
Date: Mon, 22 Aug 2016 16:15:16 +0800
From: kbuild test robot <lkp@intel.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, mikey@neuling.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: Re: [PATCH] powerpc: signals: Discard transaction state from signal
 frames
Message-ID: <201608221605.3YKBtjiA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
In-Reply-To: <20160822051501.24534-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Cyril,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.8-rc3 next-20160819]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Cyril-Bur/powerpc-signals-Discard-transaction-state-from-signal-frames/20160822-131843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-c2k_defconfig (attached as .config)
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
                    from arch/powerpc/kernel/signal_32.c:20:
   arch/powerpc/kernel/signal_32.c: In function 'sys_rt_sigreturn':
>> arch/powerpc/include/asm/reg.h:64:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
   arch/powerpc/include/asm/reg.h:116:18: note: in expansion of macro '__MASK'
    #define MSR_TS_T __MASK(MSR_TS_T_LG) /*  Transaction Transactional */
                     ^
   arch/powerpc/include/asm/reg.h:117:22: note: in expansion of macro 'MSR_TS_T'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                         ^
   arch/powerpc/include/asm/reg.h:118:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^
>> arch/powerpc/kernel/signal_32.c:1232:6: note: in expansion of macro 'MSR_TM_ACTIVE'
     if (MSR_TM_ACTIVE(mfmsr()))
         ^
>> arch/powerpc/include/asm/reg.h:64:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
    #define __MASK(X) (1UL<<(X))
                          ^
   arch/powerpc/include/asm/reg.h:115:18: note: in expansion of macro '__MASK'
    #define MSR_TS_S __MASK(MSR_TS_S_LG) /*  Transaction Suspended */
                     ^
   arch/powerpc/include/asm/reg.h:117:33: note: in expansion of macro 'MSR_TS_S'
    #define MSR_TS_MASK (MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
                                    ^
   arch/powerpc/include/asm/reg.h:118:34: note: in expansion of macro 'MSR_TS_MASK'
    #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
                                     ^
>> arch/powerpc/kernel/signal_32.c:1232:6: note: in expansion of macro 'MSR_TM_ACTIVE'
     if (MSR_TM_ACTIVE(mfmsr()))
         ^
   cc1: all warnings being treated as errors

vim +/MSR_TM_ACTIVE +1232 arch/powerpc/kernel/signal_32.c

  1216	#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
  1217		struct ucontext __user *uc_transact;
  1218		unsigned long msr_hi;
  1219		unsigned long tmp;
  1220		int tm_restore = 0;
  1221	#endif
  1222	
  1223		/*
  1224		 * We always send the user to their signal handler non
  1225		 * transactionally. If there is a transactional/suspended state
  1226		 * then throw it away. The purpose of a sigreturn is to destroy
  1227		 * all traces of the signal frame, this includes any transactional
  1228		 * state created within in.
  1229		 * The cause is not important as there will never be a
  1230		 * recheckpoint so it's not user visible.
  1231		 */
> 1232		if (MSR_TM_ACTIVE(mfmsr()))
  1233			tm_reclaim_current(0);
  1234	
  1235		/* Always make any pending restarted system calls return -EINTR */
  1236		current->restart_block.fn = do_no_restart_syscall;
  1237	
  1238		rt_sf = (struct rt_sigframe __user *)
  1239			(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
  1240		if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wac7ysb48OaltWcw
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--wac7ysb48OaltWcw--
