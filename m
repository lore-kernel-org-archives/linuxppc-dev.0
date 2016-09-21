Return-Path: <fengguang.wu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfG4b11kZzDsgg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 20:26:20 +1000 (AEST)
Date: Wed, 21 Sep 2016 18:25:27 +0800
From: kbuild test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild-all@01.org, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] percpu: improve generic percpu modify-return
 implementation
Message-ID: <201609211802.1qI9ekgl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
In-Reply-To: <20160921085137.862-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

[auto build test ERROR on asm-generic/master]
[also build test ERROR on v4.8-rc7 next-20160920]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/percpu-improve-generic-percpu-modify-return-implementation/20160921-170016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
config: blackfin-BF561-EZKIT-SMP_defconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All error/warnings (new ones prefixed by >>):

   mm/vmstat.c: In function 'refresh_cpu_vm_stats':
>> mm/vmstat.c:476:1: error: macro "raw_cpu_generic_xchg" requires 2 arguments, but only 1 given
       v = this_cpu_xchg(p->vm_stat_diff[i], 0);
    ^  ~~~~~~~~~~~~
   In file included from arch/blackfin/include/generated/asm/percpu.h:1:0,
                    from include/linux/percpu.h:12,
                    from include/linux/percpu-rwsem.h:6,
                    from include/linux/fs.h:30,
                    from mm/vmstat.c:12:
>> include/asm-generic/percpu.h:152:10: error: 'raw_cpu_generic_xchg' undeclared (first use in this function)
     __ret = raw_cpu_generic_xchg(pcp);    \
             ^
>> include/asm-generic/percpu.h:382:36: note: in expansion of macro 'this_cpu_generic_xchg'
    #define this_cpu_xchg_1(pcp, nval) this_cpu_generic_xchg(pcp, nval)
                                       ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:323:24: note: in expansion of macro 'this_cpu_xchg_1'
     case 1: pscr2_ret__ = stem##1(variable, __VA_ARGS__); break; \
                           ^~~~
>> include/linux/percpu-defs.h:500:34: note: in expansion of macro '__pcpu_size_call_return2'
    #define this_cpu_xchg(pcp, nval) __pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
                                     ^~~~~~~~~~~~~~~~~~~~~~~~
>> mm/vmstat.c:476:8: note: in expansion of macro 'this_cpu_xchg'
       v = this_cpu_xchg(p->vm_stat_diff[i], 0);
           ^~~~~~~~~~~~~
   include/asm-generic/percpu.h:152:10: note: each undeclared identifier is reported only once for each function it appears in
     __ret = raw_cpu_generic_xchg(pcp);    \
             ^
>> include/asm-generic/percpu.h:382:36: note: in expansion of macro 'this_cpu_generic_xchg'
    #define this_cpu_xchg_1(pcp, nval) this_cpu_generic_xchg(pcp, nval)
                                       ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:323:24: note: in expansion of macro 'this_cpu_xchg_1'
     case 1: pscr2_ret__ = stem##1(variable, __VA_ARGS__); break; \
                           ^~~~
>> include/linux/percpu-defs.h:500:34: note: in expansion of macro '__pcpu_size_call_return2'
    #define this_cpu_xchg(pcp, nval) __pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
                                     ^~~~~~~~~~~~~~~~~~~~~~~~
>> mm/vmstat.c:476:8: note: in expansion of macro 'this_cpu_xchg'
       v = this_cpu_xchg(p->vm_stat_diff[i], 0);
           ^~~~~~~~~~~~~
>> mm/vmstat.c:476:1: error: macro "raw_cpu_generic_xchg" requires 2 arguments, but only 1 given
       v = this_cpu_xchg(p->vm_stat_diff[i], 0);
    ^  ~~~~~~~~~~~~
>> mm/vmstat.c:476:1: error: macro "raw_cpu_generic_xchg" requires 2 arguments, but only 1 given
>> mm/vmstat.c:476:1: error: macro "raw_cpu_generic_xchg" requires 2 arguments, but only 1 given

vim +/raw_cpu_generic_xchg +476 mm/vmstat.c

ee99c71c KOSAKI Motohiro   2009-03-31  470  	for_each_populated_zone(zone) {
fbc2edb0 Christoph Lameter 2013-09-11  471  		struct per_cpu_pageset __percpu *p = zone->pageset;
2244b95a Christoph Lameter 2006-06-30  472  
fbc2edb0 Christoph Lameter 2013-09-11  473  		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
a7f75e25 Christoph Lameter 2008-02-04  474  			int v;
a7f75e25 Christoph Lameter 2008-02-04  475  
fbc2edb0 Christoph Lameter 2013-09-11 @476  			v = this_cpu_xchg(p->vm_stat_diff[i], 0);
fbc2edb0 Christoph Lameter 2013-09-11  477  			if (v) {
fbc2edb0 Christoph Lameter 2013-09-11  478  
a7f75e25 Christoph Lameter 2008-02-04  479  				atomic_long_add(v, &zone->vm_stat[i]);

:::::: The code at line 476 was first introduced by commit
:::::: fbc2edb05354480a88aa39db8a6acb5782fa1a1b vmstat: use this_cpu() to avoid irqon/off sequence in refresh_cpu_vm_stats

:::::: TO: Christoph Lameter <cl@linux.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k1lZvvs/B4yU6o8G
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k1lZvvs/B4yU6o8G--
