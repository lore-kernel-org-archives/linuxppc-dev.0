Return-Path: <fengguang.wu@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfGBH3fqmzDsgg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 20:31:19 +1000 (AEST)
Date: Wed, 21 Sep 2016 18:30:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild-all@01.org, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] percpu: improve generic percpu modify-return
 implementation
Message-ID: <201609211832.ExVaoD7t%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
In-Reply-To: <20160921085137.862-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

[auto build test WARNING on asm-generic/master]
[also build test WARNING on v4.8-rc7 next-20160920]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/percpu-improve-generic-percpu-modify-return-implementation/20160921-170016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
config: i386-randconfig-s0-201638 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/percpu.h:551:0,
                    from arch/x86/include/asm/preempt.h:5,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from arch/x86/kernel/nmi.c:13:
   arch/x86/kernel/nmi.c: In function 'do_nmi':
   include/asm-generic/percpu.h:138:17: warning: unused variable '__p' [-Wunused-variable]
     typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));   \
                    ^
   include/asm-generic/percpu.h:378:41: note: in expansion of macro 'this_cpu_generic_add_return'
    #define this_cpu_add_return_8(pcp, val) this_cpu_generic_add_return(pcp, val)
                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:326:24: note: in expansion of macro 'this_cpu_add_return_8'
     case 8: pscr2_ret__ = stem##8(variable, __VA_ARGS__); break; \
                           ^~~~
   include/linux/percpu-defs.h:499:39: note: in expansion of macro '__pcpu_size_call_return2'
    #define this_cpu_add_return(pcp, val) __pcpu_size_call_return2(this_cpu_add_return_, pcp, val)
                                          ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:511:34: note: in expansion of macro 'this_cpu_add_return'
    #define this_cpu_dec_return(pcp) this_cpu_add_return(pcp, -1)
                                     ^~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/nmi.c:544:6: note: in expansion of macro 'this_cpu_dec_return'
     if (this_cpu_dec_return(nmi_state))
         ^~~~~~~~~~~~~~~~~~~
--
   mm/vmstat.c: In function 'refresh_cpu_vm_stats':
   mm/vmstat.c:476:1: error: macro "raw_cpu_generic_xchg" requires 2 arguments, but only 1 given
       v = this_cpu_xchg(p->vm_stat_diff[i], 0);
    ^  ~~~~~~~~~~~~
   In file included from arch/x86/include/asm/percpu.h:551:0,
                    from arch/x86/include/asm/preempt.h:5,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/wait.h:8,
                    from include/linux/fs.h:5,
                    from mm/vmstat.c:12:
   include/asm-generic/percpu.h:152:10: error: 'raw_cpu_generic_xchg' undeclared (first use in this function)
     __ret = raw_cpu_generic_xchg(pcp);    \
             ^
   include/asm-generic/percpu.h:391:36: note: in expansion of macro 'this_cpu_generic_xchg'
    #define this_cpu_xchg_8(pcp, nval) this_cpu_generic_xchg(pcp, nval)
                                       ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:326:24: note: in expansion of macro 'this_cpu_xchg_8'
     case 8: pscr2_ret__ = stem##8(variable, __VA_ARGS__); break; \
                           ^~~~
   include/linux/percpu-defs.h:500:34: note: in expansion of macro '__pcpu_size_call_return2'
    #define this_cpu_xchg(pcp, nval) __pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   mm/vmstat.c:476:8: note: in expansion of macro 'this_cpu_xchg'
       v = this_cpu_xchg(p->vm_stat_diff[i], 0);
           ^~~~~~~~~~~~~
   include/asm-generic/percpu.h:152:10: note: each undeclared identifier is reported only once for each function it appears in
     __ret = raw_cpu_generic_xchg(pcp);    \
             ^
   include/asm-generic/percpu.h:391:36: note: in expansion of macro 'this_cpu_generic_xchg'
    #define this_cpu_xchg_8(pcp, nval) this_cpu_generic_xchg(pcp, nval)
                                       ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:326:24: note: in expansion of macro 'this_cpu_xchg_8'
     case 8: pscr2_ret__ = stem##8(variable, __VA_ARGS__); break; \
                           ^~~~
   include/linux/percpu-defs.h:500:34: note: in expansion of macro '__pcpu_size_call_return2'
    #define this_cpu_xchg(pcp, nval) __pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   mm/vmstat.c:476:8: note: in expansion of macro 'this_cpu_xchg'
       v = this_cpu_xchg(p->vm_stat_diff[i], 0);
           ^~~~~~~~~~~~~

vim +/this_cpu_dec_return +544 arch/x86/kernel/nmi.c

1d48922c Don Zickus       2011-09-30  528  	inc_irq_stat(__nmi_count);
1d48922c Don Zickus       2011-09-30  529  
1d48922c Don Zickus       2011-09-30  530  	if (!ignore_nmis)
1d48922c Don Zickus       2011-09-30  531  		default_do_nmi(regs);
1d48922c Don Zickus       2011-09-30  532  
1d48922c Don Zickus       2011-09-30  533  	nmi_exit();
228bdaa9 Steven Rostedt   2011-12-09  534  
9d050416 Andy Lutomirski  2015-07-15  535  #ifdef CONFIG_X86_64
9d050416 Andy Lutomirski  2015-07-15  536  	if (unlikely(this_cpu_read(update_debug_stack))) {
9d050416 Andy Lutomirski  2015-07-15  537  		debug_stack_reset();
9d050416 Andy Lutomirski  2015-07-15  538  		this_cpu_write(update_debug_stack, 0);
9d050416 Andy Lutomirski  2015-07-15  539  	}
9d050416 Andy Lutomirski  2015-07-15  540  #endif
9d050416 Andy Lutomirski  2015-07-15  541  
9d050416 Andy Lutomirski  2015-07-15  542  	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
9d050416 Andy Lutomirski  2015-07-15  543  		write_cr2(this_cpu_read(nmi_cr2));
9d050416 Andy Lutomirski  2015-07-15 @544  	if (this_cpu_dec_return(nmi_state))
9d050416 Andy Lutomirski  2015-07-15  545  		goto nmi_restart;
1d48922c Don Zickus       2011-09-30  546  }
9326638c Masami Hiramatsu 2014-04-17  547  NOKPROBE_SYMBOL(do_nmi);
1d48922c Don Zickus       2011-09-30  548  
1d48922c Don Zickus       2011-09-30  549  void stop_nmi(void)
1d48922c Don Zickus       2011-09-30  550  {
1d48922c Don Zickus       2011-09-30  551  	ignore_nmis++;
1d48922c Don Zickus       2011-09-30  552  }

:::::: The code at line 544 was first introduced by commit
:::::: 9d05041679904b12c12421cbcf9cb5f4860a8d7b x86/nmi: Enable nested do_nmi() handling for 64-bit kernels

:::::: TO: Andy Lutomirski <luto@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
n7ECYOxcgwMWqmD6TVUkhoOA/wG1jafFHboBAA==

--VbJkn9YxBvnuCH5J--
