Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yD6Ym1S7SzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 23:32:44 +1100 (AEDT)
In-Reply-To: <1507874381-11264-1-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 anju@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [V2] powerpc/perf: Fix IMC initialization crash
Message-Id: <3yD6Yl6n8hz9sRm@ozlabs.org>
Date: Fri, 13 Oct 2017 23:32:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-10-13 at 05:59:41 UTC, Anju T Sudhakar wrote:
> Call trace observed with latest firmware, and upstream kernel.
> 
> [   14.499938] NIP [c0000000000f318c] init_imc_pmu+0x8c/0xcf0
> [   14.499973] LR [c0000000000f33f8] init_imc_pmu+0x2f8/0xcf0
> [   14.500007] Call Trace:
> [   14.500027] [c000003fed18f710] [c0000000000f33c8] init_imc_pmu+0x2c8/0xcf0 (unreliable)
> [   14.500080] [c000003fed18f800] [c0000000000b5ec0] opal_imc_counters_probe+0x300/0x400
> [   14.500132] [c000003fed18f900] [c000000000807ef4] platform_drv_probe+0x64/0x110
> [   14.500185] [c000003fed18f980] [c000000000804b58] driver_probe_device+0x3d8/0x580
> [   14.500236] [c000003fed18fa10] [c000000000804e4c] __driver_attach+0x14c/0x1a0
> [   14.500302] [c000003fed18fa90] [c00000000080156c] bus_for_each_dev+0x8c/0xf0
> [   14.500353] [c000003fed18fae0] [c000000000803fa4] driver_attach+0x34/0x50
> [   14.500397] [c000003fed18fb00] [c000000000803688] bus_add_driver+0x298/0x350
> [   14.500449] [c000003fed18fb90] [c00000000080605c] driver_register+0x9c/0x180
> [   14.500500] [c000003fed18fc00] [c000000000807dec] __platform_driver_register+0x5c/0x70
> [   14.500552] [c000003fed18fc20] [c00000000101cee0] opal_imc_driver_init+0x2c/0x40
> [   14.500603] [c000003fed18fc40] [c00000000000d084] do_one_initcall+0x64/0x1d0
> [   14.500654] [c000003fed18fd00] [c00000000100434c] kernel_init_freeable+0x280/0x374
> [   14.500705] [c000003fed18fdc0] [c00000000000d314] kernel_init+0x24/0x160
> [   14.500750] [c000003fed18fe30] [c00000000000b4e8] ret_from_kernel_thread+0x5c/0x74
> [   14.500799] Instruction dump:
> [   14.500827] 4082024c 2f890002 419e054c 2e890003 41960094 2e890001 3ba0ffea 419602d8 
> [   14.500884] 419e0290 2f890003 419e02a8 e93e0118 <e8690018> 2fa30000 419e0010 4827ba41 
> [   14.500945] ---[ end trace 27b734ad26f1add4 ]---
> [   15.908719] 
> [   16.908869] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
> [   16.908869] 
> [   18.125813] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007]
> 
> While registering nest imc at init, cpu-hotplug callback `nest_pmu_cpumask_init()`
> makes an opal call to stop the engine. And if the OPAL call fails, 
> imc_common_cpuhp_mem_free() is invoked to cleanup memory and cpuhotplug setup.
> 
> But when cleaning up the attribute group, we were dereferencing the attribute
> element array without checking whether the backing element is not NULL. This
> causes the kernel panic.
> 
> Add a check for the backing element prior to dereferencing the attribute element,
> to handle the failing case gracefully.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/0d8ba16278ec30a262d931875018ab

cheers
