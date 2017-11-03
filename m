Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySjNl6Cz8zDr8Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 11:23:35 +1100 (AEDT)
In-Reply-To: <1509624746-5632-1-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, anju@linux.vnet.ibm.com
Subject: Re: [v2] powerpc/perf: Fix core-imc hotplug callback failure during
 imc initialization
Message-Id: <3ySjNl4zyhz9t16@ozlabs.org>
Date: Fri,  3 Nov 2017 11:23:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-02 at 12:12:26 UTC, Anju T Sudhakar wrote:
> From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> 
> Call trace observed during boot:
> 
> [    0.750749] PCI: CLS 0 bytes, default 128
> [    0.750855] Unpacking initramfs...
> [    1.570445] Freeing initrd memory: 23168K
> [    1.571090] rtas_flash: no firmware flash support
> [    1.573873] nest_capp0_imc performance monitor hardware support registered
> [    1.574006] nest_capp1_imc performance monitor hardware support registered
> [    1.579616] core_imc memory allocation for cpu 56 failed
> [    1.579730] Unable to handle kernel paging request for data at address 0xffa400010
> [    1.579797] Faulting instruction address: 0xc000000000bf3294
> 0:mon> e
> cpu 0x0: Vector: 300 (Data Access) at [c000000ff38ff8d0]
>     pc: c000000000bf3294: mutex_lock+0x34/0x90
>     lr: c000000000bf3288: mutex_lock+0x28/0x90
>     sp: c000000ff38ffb50
>    msr: 9000000002009033
>    dar: ffa400010
>  dsisr: 80000
>   current = 0xc000000ff383de00
>   paca    = 0xc000000007ae0000	 softe: 0	 irq_happened: 0x01
>     pid   = 13, comm = cpuhp/0
> Linux version 4.11.0-39.el7a.ppc64le (mockbuild@ppc-058.build.eng.bos.redhat.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) ) #1 SMP Tue Oct 3 07:42:44 EDT 2017
> 0:mon> t
> [c000000ff38ffb80] c0000000002ddfac perf_pmu_migrate_context+0xac/0x470
> [c000000ff38ffc40] c00000000011385c ppc_core_imc_cpu_offline+0x1ac/0x1e0
> [c000000ff38ffc90] c000000000125758 cpuhp_invoke_callback+0x198/0x5d0
> [c000000ff38ffd00] c00000000012782c cpuhp_thread_fun+0x8c/0x3d0
> [c000000ff38ffd60] c0000000001678d0 smpboot_thread_fn+0x290/0x2a0
> [c000000ff38ffdc0] c00000000015ee78 kthread+0x168/0x1b0
> [c000000ff38ffe30] c00000000000b368 ret_from_kernel_thread+0x5c/0x74
> 
> 
> While registering the cpuhoplug callbacks for core-imc, if we fails
> in the cpuhotplug online path for any random core (either because opal call to
> initialize the core-imc counters fails or because memory allocation fails for
> that core), ppc_core_imc_cpu_offline() will get invoked for other cpus who
> successfully returned from cpuhotplug online path. 
> 
> But in the ppc_core_imc_cpu_offline() path we are trying to migrate the event
> context, when core-imc counters are not even initialized. Thus creating the
> above stack dump.
> 
> Add a check to see if core-imc counters are enabled or not in the cpuhotplug
> offline path before migrating the context to handle this failing scenario.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7ecb37f62fe58e3e4d9b03443b92d2

cheers
