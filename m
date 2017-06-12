Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmN731WXhzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 16:20:30 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5C6JDuh099365
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 02:20:28 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b1m27bs2g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 02:20:28 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 16:20:24 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5C6KKN28323424
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 16:20:20 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5C6KItb003663
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 16:20:19 +1000
Subject: Re: [PATCH v10 09/10] powerpc/perf: Thread IMC PMU functions
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stewart@linux.vnet.ibm.com,
 eranian@google.com, benh@kernel.crashing.org, paulus@samba.org,
 sukadev@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, mikey@neuling.org,
 dja@axtens.net, anton@samba.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
References: <201706110405.SsDksZd2%fengguang.wu@intel.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 12 Jun 2017 11:50:09 +0530
MIME-Version: 1.0
In-Reply-To: <201706110405.SsDksZd2%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3b50b153-147f-bd0b-4d00-cdc538d4ca10@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sunday 11 June 2017 01:43 AM, kbuild test robot wrote:
> Hi Anju,
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.12-rc4 next-20170609]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Madhavan-Srinivasan/IMC-Instrumentation-Support/20170609-183528
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=powerpc
>
> Note: the linux-review/Madhavan-Srinivasan/IMC-Instrumentation-Support/20170609-183528 HEAD 32ada0705ff79986e8ceca5e83dba14c0b620751 builds fine.
>        It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>     In file included from include/linux/compiler.h:62:0,
>                      from include/uapi/linux/stddef.h:1,
>                      from include/linux/stddef.h:4,
>                      from include/uapi/linux/posix_types.h:4,
>                      from include/uapi/linux/types.h:13,
>                      from include/linux/types.h:5,
>                      from include/uapi/linux/perf_event.h:17,
>                      from include/linux/perf_event.h:17,
>                      from arch/powerpc/perf/imc-pmu.c:13:
>     arch/powerpc/perf/imc-pmu.c: In function 'cleanup_all_thread_imc_memory':
>>> arch/powerpc/perf/imc-pmu.c:863:31: error: 'cpu' undeclared (first use in this function)
Have fixed this issue in the next patch. Damn my bad.
Will wait for comments and if needed can respin just with this.

Maddy

>        if (per_cpu(thread_imc_mem, cpu))
>                                    ^
>     include/linux/compiler-gcc.h:53:26: note: in definition of macro 'RELOC_HIDE'
>       (typeof(ptr)) (__ptr + (off));     \
>                               ^~~
>     include/linux/percpu-defs.h:223:2: note: in expansion of macro 'SHIFT_PERCPU_PTR'
>       SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));   \
>       ^~~~~~~~~~~~~~~~
>     include/linux/percpu-defs.h:223:26: note: in expansion of macro 'per_cpu_offset'
>       SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));   \
>                               ^~~~~~~~~~~~~~
>     include/linux/percpu-defs.h:256:29: note: in expansion of macro 'per_cpu_ptr'
>      #define per_cpu(var, cpu) (*per_cpu_ptr(&(var), cpu))
>                                  ^~~~~~~~~~~
>     arch/powerpc/perf/imc-pmu.c:863:7: note: in expansion of macro 'per_cpu'
>        if (per_cpu(thread_imc_mem, cpu))
>            ^~~~~~~
>     arch/powerpc/perf/imc-pmu.c:863:31: note: each undeclared identifier is reported only once for each function it appears in
>        if (per_cpu(thread_imc_mem, cpu))
>                                    ^
>     include/linux/compiler-gcc.h:53:26: note: in definition of macro 'RELOC_HIDE'
>       (typeof(ptr)) (__ptr + (off));     \
>                               ^~~
>     include/linux/percpu-defs.h:223:2: note: in expansion of macro 'SHIFT_PERCPU_PTR'
>       SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));   \
>       ^~~~~~~~~~~~~~~~
>     include/linux/percpu-defs.h:223:26: note: in expansion of macro 'per_cpu_offset'
>       SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));   \
>                               ^~~~~~~~~~~~~~
>     include/linux/percpu-defs.h:256:29: note: in expansion of macro 'per_cpu_ptr'
>      #define per_cpu(var, cpu) (*per_cpu_ptr(&(var), cpu))
>                                  ^~~~~~~~~~~
>     arch/powerpc/perf/imc-pmu.c:863:7: note: in expansion of macro 'per_cpu'
>        if (per_cpu(thread_imc_mem, cpu))
>            ^~~~~~~
>
> vim +/cpu +863 arch/powerpc/perf/imc-pmu.c
>
>     857	
>     858	static void cleanup_all_thread_imc_memory(void)
>     859	{
>     860		int i;
>     861	
>     862		for_each_online_cpu(i) {
>   > 863			if (per_cpu(thread_imc_mem, cpu))
>     864				free_pages(per_cpu(thread_imc_mem, cpu), 0);
>     865		}
>     866	}
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
