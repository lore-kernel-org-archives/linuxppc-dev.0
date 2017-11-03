Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySpDQ39s5zDr8p
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 15:01:42 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA33sEZF060397
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Nov 2017 00:01:40 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e07q8tu5c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Nov 2017 00:01:39 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 3 Nov 2017 04:01:37 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf: Fix core-imc hotplug callback failure
 during imc initialization
To: Michael Ellerman <mpe@ellerman.id.au>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1509443398-26539-1-git-send-email-anju@linux.vnet.ibm.com>
 <87efpi95wb.fsf@concordia.ellerman.id.au>
 <b0a3f5ac-0805-4fad-a81c-aa23890ce6df@linux.vnet.ibm.com>
 <87lgjo6wnl.fsf@concordia.ellerman.id.au>
Date: Fri, 3 Nov 2017 09:31:33 +0530
MIME-Version: 1.0
In-Reply-To: <87lgjo6wnl.fsf@concordia.ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="------------4F5FCE060787E4AF16242557"
Message-Id: <0b266f1e-04dc-08a0-6742-d553c9a161e5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------4F5FCE060787E4AF16242557
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On Friday 03 November 2017 05:49 AM, Michael Ellerman wrote:
> Madhavan Srinivasan<maddy@linux.vnet.ibm.com>  writes:
>
>> On Wednesday 01 November 2017 06:22 AM, Michael Ellerman wrote:
>>> Anju T Sudhakar<anju@linux.vnet.ibm.com>  writes:
>>>
>>>> Call trace observed during boot:
>>> What's the actual oops?
>> I could recreate this in mambo with CPUS=2 and THREAD=2
> That boots fine for me.
>
> Presumably you've also done something to cause the CPU online to fail
> and trigger the bug.

My bad. Yes, in the mem_init code for the second core,
i forced a fail in mambo with below hack.

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 38fdaee5c61f..11fac5d78324 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -548,6 +548,9 @@ static int core_imc_mem_init(int cpu, int size)
         rc = opal_imc_counters_init(OPAL_IMC_COUNTERS_CORE,
                                 __pa((void *)mem_info->vbase),
                                 get_hard_smp_processor_id(cpu));
+       if (cpu == 2)
+               rc = -1;
+
         if (rc) {
                 free_pages((u64)mem_info->vbase, get_order(size));
                 mem_info->vbase = NULL;


Sorry for missed this detail.

Maddy

>> Here is the complete stack trace.
>>
>> [    0.045367] core_imc memory allocation for cpu 2 failed
>> [    0.045408] Unable to handle kernel paging request for data at
>> address 0x7d20e2a6f92d03b8
>> [    0.045443] Faulting instruction address: 0xc0000000000dde18
>> cpu 0x0: Vector: 380 (Data Access Out of Range) at [c0000000fd1cb890]
>>       pc: c0000000000dde18: event_function_call+0x28/0x14c
>>       lr: c0000000000dde00: event_function_call+0x10/0x14c
>>       sp: c0000000fd1cbb10
>>      msr: 9000000000009033
>>      dar: 7d20e2a6f92d03b8
>>     current = 0xc0000000fd15da00
>>     paca    = 0xc00000000fff0000   softe: 0        irq_happened: 0x01
>>       pid   = 11, comm = cpuhp/0
>> Linux version 4.14.0-rc7-00014-g0a08377b127b (maddy@SrihariSrinidhi)
>> (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1)) #5 SMP
>> Wed Nov 1 14:12:27 IST 2017
>> enter ? for help
>> [c0000000fd1cbb10] 0000000000000000 (unreliable)
>> [c0000000fd1cbba0] c0000000000de180 perf_remove_from_context+0x30/0x9c
>> [c0000000fd1cbbe0] c0000000000e9108 perf_pmu_migrate_context+0x9c/0x224
>> [c0000000fd1cbc60] c0000000000682e0 ppc_core_imc_cpu_offline+0xdc/0x144
>> [c0000000fd1cbcb0] c000000000070568 cpuhp_invoke_callback+0xe4/0x244
>> [c0000000fd1cbd10] c000000000070824 cpuhp_thread_fun+0x15c/0x1b0
>> [c0000000fd1cbd60] c00000000008e8cc smpboot_thread_fn+0x1e0/0x200
>> [c0000000fd1cbdc0] c00000000008ae58 kthread+0x150/0x158
>> [c0000000fd1cbe30] c00000000000b464 ret_from_kernel_thread+0x5c/0x78
>>
>>
>>>> [c000000ff38ffb80] c0000000002ddfac perf_pmu_migrate_context+0xac/0x470
>>>> [c000000ff38ffc40] c00000000011385c ppc_core_imc_cpu_offline+0x1ac/0x1e0
>>>> [c000000ff38ffc90] c000000000125758 cpuhp_invoke_callback+0x198/0x5d0
>>>> [c000000ff38ffd00] c00000000012782c cpuhp_thread_fun+0x8c/0x3d0
>>>> [c000000ff38ffd60] c0000000001678d0 smpboot_thread_fn+0x290/0x2a0
>>>> [c000000ff38ffdc0] c00000000015ee78 kthread+0x168/0x1b0
>>>> [c000000ff38ffe30] c00000000000b368 ret_from_kernel_thread+0x5c/0x74
>>>>
>>>> While registering the cpuhoplug callbacks for core-imc, if we fails
>>>> in the cpuhotplug online path for any random core (either because opal call to
>>>> initialize the core-imc counters fails or because memory allocation fails for
>>>> that core), ppc_core_imc_cpu_offline() will get invoked for other cpus who
>>>> successfully returned from cpuhotplug online path.
>>>>
>>>> But in the ppc_core_imc_cpu_offline() path we are trying to migrate the event
>>>> context, when core-imc counters are not even initialized. Thus creating the
>>>> above stack dump.
>>>>
>>>> Add a check to see if core-imc counters are enabled or not in the cpuhotplug
>>>> offline path before migrating the context to handle this failing scenario.
>>> Why do we need a bool to track this? Can't we just check the data
>>> structure we're deinitialising has been initialised?
>> My bad. yes we could do that. Something like this will work?
>>
>> @@ -606,6 +608,20 @@ static int ppc_core_imc_cpu_offline(unsigned int cpu)
>>           if (!cpumask_test_and_clear_cpu(cpu, &core_imc_cpumask))
>>                   return 0;
>>
>> +       /*
>> +        * Check whether core_imc is registered. We could end up here
>> +        * if the cpuhotplug callback registration fails. i.e, callback
>> +        * invokes the offline path for all sucessfully registered cpus.
>> +        * At this stage, core_imc pmu will not be registered and we
>> +        * should return here.
>> +        *
>> +        * We return with a zero since this is not a offline failure.
>> +        * And cpuhp_setup_state() returns the actual failure reason
>> +        * to the caller, which inturn will call the cleanup routine.
>> +        */
>> +       if (!core_imc_pmu->pmu.event_init)
>> +               return 0;
>> +
>>           /* Find any online cpu in that core except the current "cpu" */
>>           ncpu = cpumask_any_but(cpu_sibling_mask(cpu), cpu);
> That's not ideal, because you're grovelling into the details of the pmu
> struct. But I guess it's OK for now.
>
> cheers
>


--------------4F5FCE060787E4AF16242557
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On Friday 03 November 2017 05:49 AM,
      Michael Ellerman wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:87lgjo6wnl.fsf@concordia.ellerman.id.au">
      <pre wrap="">Madhavan Srinivasan <a class="moz-txt-link-rfc2396E" href="mailto:maddy@linux.vnet.ibm.com">&lt;maddy@linux.vnet.ibm.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre wrap="">On Wednesday 01 November 2017 06:22 AM, Michael Ellerman wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Anju T Sudhakar <a class="moz-txt-link-rfc2396E" href="mailto:anju@linux.vnet.ibm.com">&lt;anju@linux.vnet.ibm.com&gt;</a> writes:

</pre>
          <blockquote type="cite">
            <pre wrap="">Call trace observed during boot:
</pre>
          </blockquote>
          <pre wrap="">What's the actual oops?
</pre>
        </blockquote>
        <pre wrap="">I could recreate this in mambo with CPUS=2 and THREAD=2
</pre>
      </blockquote>
      <pre wrap="">That boots fine for me.

Presumably you've also done something to cause the CPU online to fail
and trigger the bug.</pre>
    </blockquote>
    <br>
    My bad. Yes, in the mem_init code for the second core,<br>
    i forced a fail in mambo with below hack.<br>
    <br>
    diff --git a/arch/powerpc/perf/imc-pmu.c
    b/arch/powerpc/perf/imc-pmu.c<br>
    index 38fdaee5c61f..11fac5d78324 100644<br>
    --- a/arch/powerpc/perf/imc-pmu.c<br>
    +++ b/arch/powerpc/perf/imc-pmu.c<br>
    @@ -548,6 +548,9 @@ static int core_imc_mem_init(int cpu, int size)<br>
            rc = opal_imc_counters_init(OPAL_IMC_COUNTERS_CORE,<br>
                                    __pa((void *)mem_info-&gt;vbase),<br>
                                    get_hard_smp_processor_id(cpu));<br>
    +       if (cpu == 2)<br>
    +               rc = -1;<br>
    +<br>
            if (rc) {<br>
                    free_pages((u64)mem_info-&gt;vbase,
    get_order(size));<br>
                    mem_info-&gt;vbase = NULL;<br>
    <br>
    <br>
    Sorry for missed this detail.<br>
    <br>
    Maddy<br>
    <br>
    <blockquote type="cite"
      cite="mid:87lgjo6wnl.fsf@concordia.ellerman.id.au">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">Here is the complete stack trace.

[    0.045367] core_imc memory allocation for cpu 2 failed
[    0.045408] Unable to handle kernel paging request for data at 
address 0x7d20e2a6f92d03b8
[    0.045443] Faulting instruction address: 0xc0000000000dde18
cpu 0x0: Vector: 380 (Data Access Out of Range) at [c0000000fd1cb890]
     pc: c0000000000dde18: event_function_call+0x28/0x14c
     lr: c0000000000dde00: event_function_call+0x10/0x14c
     sp: c0000000fd1cbb10
    msr: 9000000000009033
    dar: 7d20e2a6f92d03b8
   current = 0xc0000000fd15da00
   paca    = 0xc00000000fff0000   softe: 0        irq_happened: 0x01
     pid   = 11, comm = cpuhp/0
Linux version 4.14.0-rc7-00014-g0a08377b127b (maddy@SrihariSrinidhi) 
(gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1)) #5 SMP 
Wed Nov 1 14:12:27 IST 2017
enter ? for help
[c0000000fd1cbb10] 0000000000000000 (unreliable)
[c0000000fd1cbba0] c0000000000de180 perf_remove_from_context+0x30/0x9c
[c0000000fd1cbbe0] c0000000000e9108 perf_pmu_migrate_context+0x9c/0x224
[c0000000fd1cbc60] c0000000000682e0 ppc_core_imc_cpu_offline+0xdc/0x144
[c0000000fd1cbcb0] c000000000070568 cpuhp_invoke_callback+0xe4/0x244
[c0000000fd1cbd10] c000000000070824 cpuhp_thread_fun+0x15c/0x1b0
[c0000000fd1cbd60] c00000000008e8cc smpboot_thread_fn+0x1e0/0x200
[c0000000fd1cbdc0] c00000000008ae58 kthread+0x150/0x158
[c0000000fd1cbe30] c00000000000b464 ret_from_kernel_thread+0x5c/0x78


</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">[c000000ff38ffb80] c0000000002ddfac perf_pmu_migrate_context+0xac/0x470
[c000000ff38ffc40] c00000000011385c ppc_core_imc_cpu_offline+0x1ac/0x1e0
[c000000ff38ffc90] c000000000125758 cpuhp_invoke_callback+0x198/0x5d0
[c000000ff38ffd00] c00000000012782c cpuhp_thread_fun+0x8c/0x3d0
[c000000ff38ffd60] c0000000001678d0 smpboot_thread_fn+0x290/0x2a0
[c000000ff38ffdc0] c00000000015ee78 kthread+0x168/0x1b0
[c000000ff38ffe30] c00000000000b368 ret_from_kernel_thread+0x5c/0x74

While registering the cpuhoplug callbacks for core-imc, if we fails
in the cpuhotplug online path for any random core (either because opal call to
initialize the core-imc counters fails or because memory allocation fails for
that core), ppc_core_imc_cpu_offline() will get invoked for other cpus who
successfully returned from cpuhotplug online path.

But in the ppc_core_imc_cpu_offline() path we are trying to migrate the event
context, when core-imc counters are not even initialized. Thus creating the
above stack dump.

Add a check to see if core-imc counters are enabled or not in the cpuhotplug
offline path before migrating the context to handle this failing scenario.
</pre>
          </blockquote>
          <pre wrap="">Why do we need a bool to track this? Can't we just check the data
structure we're deinitialising has been initialised?
</pre>
        </blockquote>
        <pre wrap="">My bad. yes we could do that. Something like this will work?

@@ -606,6 +608,20 @@ static int ppc_core_imc_cpu_offline(unsigned int cpu)
         if (!cpumask_test_and_clear_cpu(cpu, &amp;core_imc_cpumask))
                 return 0;

+       /*
+        * Check whether core_imc is registered. We could end up here
+        * if the cpuhotplug callback registration fails. i.e, callback
+        * invokes the offline path for all sucessfully registered cpus.
+        * At this stage, core_imc pmu will not be registered and we
+        * should return here.
+        *
+        * We return with a zero since this is not a offline failure.
+        * And cpuhp_setup_state() returns the actual failure reason
+        * to the caller, which inturn will call the cleanup routine.
+        */
+       if (!core_imc_pmu-&gt;pmu.event_init)
+               return 0;
+
         /* Find any online cpu in that core except the current "cpu" */
         ncpu = cpumask_any_but(cpu_sibling_mask(cpu), cpu);
</pre>
      </blockquote>
      <pre wrap="">
That's not ideal, because you're grovelling into the details of the pmu
struct. But I guess it's OK for now.

cheers

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------4F5FCE060787E4AF16242557--
