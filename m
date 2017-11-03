Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySjJf1QD4zDr8Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 11:20:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/perf: Fix core-imc hotplug callback failure
 during imc initialization
In-Reply-To: <b0a3f5ac-0805-4fad-a81c-aa23890ce6df@linux.vnet.ibm.com>
References: <1509443398-26539-1-git-send-email-anju@linux.vnet.ibm.com>
 <87efpi95wb.fsf@concordia.ellerman.id.au>
 <b0a3f5ac-0805-4fad-a81c-aa23890ce6df@linux.vnet.ibm.com>
Date: Fri, 03 Nov 2017 11:19:58 +1100
Message-ID: <87lgjo6wnl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> On Wednesday 01 November 2017 06:22 AM, Michael Ellerman wrote:
>> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>>
>>> Call trace observed during boot:
>> What's the actual oops?
>
> I could recreate this in mambo with CPUS=3D2 and THREAD=3D2

That boots fine for me.

Presumably you've also done something to cause the CPU online to fail
and trigger the bug.

> Here is the complete stack trace.
>
> [=C2=A0=C2=A0=C2=A0 0.045367] core_imc memory allocation for cpu 2 failed
> [=C2=A0=C2=A0=C2=A0 0.045408] Unable to handle kernel paging request for =
data at=20
> address 0x7d20e2a6f92d03b8
> [=C2=A0=C2=A0=C2=A0 0.045443] Faulting instruction address: 0xc0000000000=
dde18
> cpu 0x0: Vector: 380 (Data Access Out of Range) at [c0000000fd1cb890]
>  =C2=A0=C2=A0=C2=A0 pc: c0000000000dde18: event_function_call+0x28/0x14c
>  =C2=A0=C2=A0=C2=A0 lr: c0000000000dde00: event_function_call+0x10/0x14c
>  =C2=A0=C2=A0=C2=A0 sp: c0000000fd1cbb10
>  =C2=A0=C2=A0 msr: 9000000000009033
>  =C2=A0=C2=A0 dar: 7d20e2a6f92d03b8
>  =C2=A0 current =3D 0xc0000000fd15da00
>  =C2=A0 paca=C2=A0=C2=A0=C2=A0 =3D 0xc00000000fff0000=C2=A0=C2=A0 softe: =
0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_happened: 0x01
>  =C2=A0=C2=A0=C2=A0 pid=C2=A0=C2=A0 =3D 11, comm =3D cpuhp/0
> Linux version 4.14.0-rc7-00014-g0a08377b127b (maddy@SrihariSrinidhi)=20
> (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1)) #5 SMP=20
> Wed Nov 1 14:12:27 IST 2017
> enter ? for help
> [c0000000fd1cbb10] 0000000000000000 (unreliable)
> [c0000000fd1cbba0] c0000000000de180 perf_remove_from_context+0x30/0x9c
> [c0000000fd1cbbe0] c0000000000e9108 perf_pmu_migrate_context+0x9c/0x224
> [c0000000fd1cbc60] c0000000000682e0 ppc_core_imc_cpu_offline+0xdc/0x144
> [c0000000fd1cbcb0] c000000000070568 cpuhp_invoke_callback+0xe4/0x244
> [c0000000fd1cbd10] c000000000070824 cpuhp_thread_fun+0x15c/0x1b0
> [c0000000fd1cbd60] c00000000008e8cc smpboot_thread_fn+0x1e0/0x200
> [c0000000fd1cbdc0] c00000000008ae58 kthread+0x150/0x158
> [c0000000fd1cbe30] c00000000000b464 ret_from_kernel_thread+0x5c/0x78
>
>
>>
>>> [c000000ff38ffb80] c0000000002ddfac perf_pmu_migrate_context+0xac/0x470
>>> [c000000ff38ffc40] c00000000011385c ppc_core_imc_cpu_offline+0x1ac/0x1e0
>>> [c000000ff38ffc90] c000000000125758 cpuhp_invoke_callback+0x198/0x5d0
>>> [c000000ff38ffd00] c00000000012782c cpuhp_thread_fun+0x8c/0x3d0
>>> [c000000ff38ffd60] c0000000001678d0 smpboot_thread_fn+0x290/0x2a0
>>> [c000000ff38ffdc0] c00000000015ee78 kthread+0x168/0x1b0
>>> [c000000ff38ffe30] c00000000000b368 ret_from_kernel_thread+0x5c/0x74
>>>
>>> While registering the cpuhoplug callbacks for core-imc, if we fails
>>> in the cpuhotplug online path for any random core (either because opal =
call to
>>> initialize the core-imc counters fails or because memory allocation fai=
ls for
>>> that core), ppc_core_imc_cpu_offline() will get invoked for other cpus =
who
>>> successfully returned from cpuhotplug online path.
>>>
>>> But in the ppc_core_imc_cpu_offline() path we are trying to migrate the=
 event
>>> context, when core-imc counters are not even initialized. Thus creating=
 the
>>> above stack dump.
>>>
>>> Add a check to see if core-imc counters are enabled or not in the cpuho=
tplug
>>> offline path before migrating the context to handle this failing scenar=
io.
>> Why do we need a bool to track this? Can't we just check the data
>> structure we're deinitialising has been initialised?
>
> My bad. yes we could do that. Something like this will work?
>
> @@ -606,6 +608,20 @@ static int ppc_core_imc_cpu_offline(unsigned int cpu)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpumask_test_and_clear_c=
pu(cpu, &core_imc_cpumask))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Check whether core_imc is r=
egistered. We could end up here
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if the cpuhotplug callback =
registration fails. i.e, callback
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * invokes the offline path fo=
r all sucessfully registered cpus.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * At this stage, core_imc pmu=
 will not be registered and we
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * should return here.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We return with a zero since=
 this is not a offline failure.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * And cpuhp_setup_state() ret=
urns the actual failure reason
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to the caller, which inturn=
 will call the cleanup routine.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!core_imc_pmu->pmu.event_init)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 0;
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Find any online cpu in tha=
t core except the current "cpu" */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ncpu =3D cpumask_any_but(cpu_=
sibling_mask(cpu), cpu);


That's not ideal, because you're grovelling into the details of the pmu
struct. But I guess it's OK for now.

cheers
