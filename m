Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySJfM2bD7zDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 19:48:58 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA28mgsJ070053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Nov 2017 04:48:56 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dyyfdj9du-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 04:48:55 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Thu, 2 Nov 2017 02:48:55 -0600
Subject: Re: [PATCH] powerpc/perf: Fix core-imc hotplug callback failure
 during imc initialization
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com
References: <1509443398-26539-1-git-send-email-anju@linux.vnet.ibm.com>
 <87efpi95wb.fsf@concordia.ellerman.id.au>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Thu, 2 Nov 2017 14:18:48 +0530
MIME-Version: 1.0
In-Reply-To: <87efpi95wb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <62edaba7-c5ff-3b0b-3f46-8f44cba2f6d5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


On Wednesday 01 November 2017 06:22 AM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>
>> Call trace observed during boot:
> What's the actual oops?

The actual oops is:

[    0.750749] PCI: CLS 0 bytes, default 128
[    0.750855] Unpacking initramfs...
[    1.570445] Freeing initrd memory: 23168K
[    1.571090] rtas_flash: no firmware flash support
[    1.573873] nest_capp0_imc performance monitor hardware support registered
[    1.574006] nest_capp1_imc performance monitor hardware support registered
[    1.579616] core_imc memory allocation for cpu 56 failed
[    1.579730] Unable to handle kernel paging request for data at address 0xffa400010
[    1.579797] Faulting instruction address: 0xc000000000bf3294
0:mon> e
cpu 0x0: Vector: 300 (Data Access) at [c000000ff38ff8d0]
     pc: c000000000bf3294: mutex_lock+0x34/0x90
     lr: c000000000bf3288: mutex_lock+0x28/0x90
     sp: c000000ff38ffb50
    msr: 9000000002009033
    dar: ffa400010
  dsisr: 80000
   current = 0xc000000ff383de00
   paca    = 0xc000000007ae0000	 softe: 0	 irq_happened: 0x01
     pid   = 13, comm = cpuhp/0
Linux version 4.11.0-39.el7a.ppc64le (mockbuild@ppc-058.build.eng.bos.redhat.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) ) #1 SMP Tue Oct 3 07:42:44 EDT 2017
0:mon> t
[c000000ff38ffb80] c0000000002ddfac perf_pmu_migrate_context+0xac/0x470
[c000000ff38ffc40] c00000000011385c ppc_core_imc_cpu_offline+0x1ac/0x1e0
[c000000ff38ffc90] c000000000125758 cpuhp_invoke_callback+0x198/0x5d0
[c000000ff38ffd00] c00000000012782c cpuhp_thread_fun+0x8c/0x3d0
[c000000ff38ffd60] c0000000001678d0 smpboot_thread_fn+0x290/0x2a0
[c000000ff38ffdc0] c00000000015ee78 kthread+0x168/0x1b0
[c000000ff38ffe30] c00000000000b368 ret_from_kernel_thread+0x5c/0x74


>> [c000000ff38ffb80] c0000000002ddfac perf_pmu_migrate_context+0xac/0x470
>> [c000000ff38ffc40] c00000000011385c ppc_core_imc_cpu_offline+0x1ac/0x1e0
>> [c000000ff38ffc90] c000000000125758 cpuhp_invoke_callback+0x198/0x5d0
>> [c000000ff38ffd00] c00000000012782c cpuhp_thread_fun+0x8c/0x3d0
>> [c000000ff38ffd60] c0000000001678d0 smpboot_thread_fn+0x290/0x2a0
>> [c000000ff38ffdc0] c00000000015ee78 kthread+0x168/0x1b0
>> [c000000ff38ffe30] c00000000000b368 ret_from_kernel_thread+0x5c/0x74
>>
>> While registering the cpuhoplug callbacks for core-imc, if we fails
>> in the cpuhotplug online path for any random core (either because opal call to
>> initialize the core-imc counters fails or because memory allocation fails for
>> that core), ppc_core_imc_cpu_offline() will get invoked for other cpus who
>> successfully returned from cpuhotplug online path.
>>
>> But in the ppc_core_imc_cpu_offline() path we are trying to migrate the event
>> context, when core-imc counters are not even initialized. Thus creating the
>> above stack dump.
>>
>> Add a check to see if core-imc counters are enabled or not in the cpuhotplug
>> offline path before migrating the context to handle this failing scenario.
> Why do we need a bool to track this? Can't we just check the data
> structure we're deinitialising has been initialised?
>
> Doesn't this also mean we won't cleanup the initialisation for any CPUs
> that have been initialised?
we do the cleanup in the failing case.




Thanks for the review.

Thanks,
Anju



> cheers
>
>> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
>> index 8812624..08139f9 100644
>> --- a/arch/powerpc/perf/imc-pmu.c
>> +++ b/arch/powerpc/perf/imc-pmu.c
>> @@ -30,6 +30,7 @@ static struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
>>   static cpumask_t nest_imc_cpumask;
>>   struct imc_pmu_ref *nest_imc_refc;
>>   static int nest_pmus;
>> +static bool core_imc_enabled;
>>   
>>   /* Core IMC data structures and variables */
>>   
>> @@ -607,6 +608,19 @@ static int ppc_core_imc_cpu_offline(unsigned int cpu)
>>   	if (!cpumask_test_and_clear_cpu(cpu, &core_imc_cpumask))
>>   		return 0;
>>   
>> +	/*
>> +	 * See if core imc counters are enabled or not.
>> +	 *
>> +	 * Suppose we reach here from core_imc_cpumask_init(),
>> +	 * since we failed at the cpuhotplug online path for any random
>> +	 * core (either because opal call to initialize the core-imc counters
>> +	 * failed  or because memory allocation failed).
>> +	 * We need to check whether core imc counters are enabled or not before
>> +	 * migrating the event context from cpus in the other cores.
>> +	 */
>> +	if (!core_imc_enabled)
>> +		return 0;
>> +
>>   	/* Find any online cpu in that core except the current "cpu" */
>>   	ncpu = cpumask_any_but(cpu_sibling_mask(cpu), cpu);
>>   
>> @@ -1299,6 +1313,7 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>>   			return ret;
>>   		}
>>   
>> +		core_imc_enabled = true;
>>   		break;
>>   	case IMC_DOMAIN_THREAD:
>>   		ret = thread_imc_cpu_init();
>> -- 
>> 2.7.4
