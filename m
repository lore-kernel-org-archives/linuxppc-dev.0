Return-Path: <fengguang.wu@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZl0v6qpSzDsY0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 02:55:58 +1000 (AEST)
Date: Fri, 16 Sep 2016 00:55:13 +0800
From: kbuild test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org,
 anton@samba.org, npiggin@gmail.com
Subject: Re: [PATCH 13/13] powerpc: rewrite local_t using soft_irq
Message-ID: <201609160048.vfgWdJuW%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
In-Reply-To: <1473944523-624-14-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Madhavan,

[auto build test ERROR on v4.8-rc6]
[cannot apply to powerpc/next kvm-ppc/kvm-ppc-next mpe/next next-20160915]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Madhavan-Srinivasan/powerpc-paca-soft_enabled-based-local-atomic-operation-implementation/20160915-215652
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:57:0,
                    from include/linux/trace_events.h:9,
                    from include/trace/syscall.h:6,
                    from include/linux/syscalls.h:81,
                    from init/main.c:18:
   arch/powerpc/include/asm/local.h: In function 'local_add':
>> arch/powerpc/include/asm/local.h:25:2: error: implicit declaration of function 'local_irq_pmu_save' [-Werror=implicit-function-declaration]
     local_irq_pmu_save(flags);
     ^
>> arch/powerpc/include/asm/local.h:32:2: error: implicit declaration of function 'local_irq_pmu_restore' [-Werror=implicit-function-declaration]
     local_irq_pmu_restore(flags);
     ^
   cc1: some warnings being treated as errors

vim +/local_irq_pmu_save +25 arch/powerpc/include/asm/local.h

    19	
    20	static __inline__ void local_add(long i, local_t *l)
    21	{
    22		long t;
    23		unsigned long flags;
    24	
  > 25		local_irq_pmu_save(flags);
    26		__asm__ __volatile__(
    27		PPC_LL" %0,0(%2)\n\
    28		add     %0,%1,%0\n"
    29		PPC_STL" %0,0(%2)\n"
    30		: "=&r" (t)
    31		: "r" (i), "r" (&(l->a.counter)));
  > 32		local_irq_pmu_restore(flags);
    33	}
    34	
    35	static __inline__ void local_sub(long i, local_t *l)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--8t9RHnE3ZwKMSgU+
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--8t9RHnE3ZwKMSgU+--
