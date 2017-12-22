Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2wqt2DsjzDsNJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 15:43:22 +1100 (AEDT)
In-Reply-To: <1512667407-30067-1-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 anju@linux.vnet.ibm.com
Subject: Re: powerpc/perf: Fix kfree memory allocated for nest pmus
Message-Id: <3z2wqt0t3mz9s7f@ozlabs.org>
Date: Fri, 22 Dec 2017 15:43:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-12-07 at 17:23:27 UTC, Anju T Sudhakar wrote:
> imc_common_cpuhp_mem_free() is the common function for all IMC (In-memory
> Collection counters) domains to unregister cpuhotplug callback and free memory.
> Since kfree of memory allocated for nest-imc (per_nest_pmu_arr) is in the common
> code, all domains (core/nest/thread) can do the kfree in the failure case.
> 
> This could potentially create a call trace as shown below, where core(/thread/nest)
> imc pmu initialization fails and in the failure path imc_common_cpuhp_mem_free()
> free the memory(per_nest_pmu_arr), which is allocated by successfully registered
> nest units.
> 
> 
> The call trace is generated in a scenario where core-imc initialization is
> made to fail and a cpuhotplug is performed in a p9 system.
> During cpuhotplug ppc_nest_imc_cpu_offline() tries to access per_nest_pmu_arr,
> which is already freed by core-imc.
> 
> [  136.563618] NIP [c000000000cb6a94] mutex_lock+0x34/0x90
> [  136.563653] LR [c000000000cb6a88] mutex_lock+0x28/0x90
> [  136.563687] Call Trace:
> [  136.563707] [c0000016b7a93b90] [c000000000cb6a88] mutex_lock+0x28/0x90 (unreliable)
> [  136.563762] [c0000016b7a93bc0] [c0000000002bc720] perf_pmu_migrate_context+0x90/0x3a0
> [  136.563814] [c0000016b7a93c60] [c0000000000f7a40] ppc_nest_imc_cpu_offline+0x190/0x1f0
> [  136.563867] [c0000016b7a93cb0] [c000000000108140] cpuhp_invoke_callback+0x160/0x820
> [  136.563918] [c0000016b7a93d30] [c00000000010939c] cpuhp_thread_fun+0x1bc/0x270
> [  136.563970] [c0000016b7a93d60] [c00000000013d2b0] smpboot_thread_fn+0x250/0x290
> [  136.564022] [c0000016b7a93dc0] [c000000000136f18] kthread+0x1a8/0x1b0
> [  136.564067] [c0000016b7a93e30] [c00000000000b4e8] ret_from_kernel_thread+0x5c/0x74
> 
> To address this scenario do the kfree(per_nest_pmu_arr) only in case of
> nest-imc initialization failure, and when there is no other nest units registered.
> 
> 
> Fixes: 73ce9aec65b1 ("powerpc/perf: Fix IMC_MAX_PMU macro")
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/110df8bd3e418b3476cae80babe8ad

cheers
