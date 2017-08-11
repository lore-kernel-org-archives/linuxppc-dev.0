Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPG30sMfzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:55 +1000 (AEST)
In-Reply-To: <20170802180322.8245.55722.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: danielhb@linux.vnet.ibm.com
Subject: Re: powerpc/pseries: Check memory device state before
 onlining/offlining
Message-Id: <3xTPG26zrYz9t2W@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-02 at 18:03:22 UTC, Nathan Fontenot wrote:
> When DLPAR adding or removing memory we need to check the device
> offline status before trying to online/offline the memory. This is
> needed because calls device_online() and device_offline() will return
> non-zero for memory that is already online and offline respectively.
> 
> This update resolves two scenarios. First, for kernel built with
> auto-online memory enabled, memory will be onlined as part of calls
> to add_memory(). After adding the memory the pseries dlpar code tries
> to online it and fails since the memory is already online. The dlpar
> code then tries to remove the memory which produces the oops message
> below because the memory is not offline.
> 
> The second scenario occurs when removing memory that is already offline,
> i.e. marking memory offline (via sysfs) and the trying to remove that
> memory. This doesn't work because offlining the already offline memory
> does not succeed and the dlpar code then fails the dlpar remove operation.
> 
> The fix for both scenarios is to check the device.offline status before
> making the calls to device_online() or device_offline().
> 
> kernel BUG at mm/memory_hotplug.c:2189!
> Oops: Exception in kernel mode, sig: 5 [#1]
> SMP NR_CPUS=2048
> NUMA
> pSeries
> CPU: 0 PID: 5 Comm: kworker/u129:0 Not tainted 4.12.0-rc3 #272
> Workqueue: pseries hotplug workque .pseries_hp_work_fn
> task: c0000003f9c89200 task.stack: c0000003f9d10000
> NIP: c0000000002ca428 LR: c0000000002ca3cc CTR: c000000000ba16a0
> REGS: c0000003f9d13630 TRAP: 0700   Not tainted  (4.12.0-rc3)
> MSR: 800000000282b032 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI>
>   CR: 22002024  XER: 0000000a
> CFAR: c0000000002ca3d0 SOFTE: 1
> GPR00: c0000000002ca3cc c0000003f9d138b0 c000000001bb0200 0000000000000001
> GPR04: c0000003fb143c80 c0000003fef21630 0000000000000003 0000000000000002
> GPR08: 0000000000000003 0000000000000003 0000000000000003 00000000000031b1
> GPR12: 0000000028002042 c00000000fd80000 c000000000118ae0 c0000003fb170180
> GPR16: 0000000000000000 0000000000000004 0000000000000010 c0000003ffff79c8
> GPR20: c0000003ffff7b68 c0000003f728ff84 0000000000000002 0000000000000010
> GPR24: 0000000000000002 c0000003f728ff80 0000000000000002 0000000000000001
> GPR28: c0000003fb143c38 0000000000000002 0000000010000000 0000000020000000
> NIP [c0000000002ca428] .remove_memory+0xb8/0xc0
> LR [c0000000002ca3cc] .remove_memory+0x5c/0xc0
> Call Trace:
> [c0000003f9d138b0] [c0000000002ca3cc] .remove_memory+0x5c/0xc0 (unreliable)
> [c0000003f9d13940] [c0000000000938a4] .dlpar_add_lmb+0x384/0x400
> [c0000003f9d13a30] [c00000000009456c] .dlpar_memory+0x5dc/0xca0
> [c0000003f9d13af0] [c00000000008ce84] .handle_dlpar_errorlog+0x74/0xe0
> [c0000003f9d13b70] [c00000000008cf1c] .pseries_hp_work_fn+0x2c/0x90
> [c0000003f9d13bf0] [c000000000110a5c] .process_one_work+0x17c/0x460
> [c0000003f9d13c90] [c000000000110dc8] .worker_thread+0x88/0x500
> [c0000003f9d13d70] [c000000000118c3c] .kthread+0x15c/0x1a0
> [c0000003f9d13e30] [c00000000000ba18] .ret_from_kernel_thread+0x58/0xc0
> Instruction dump:
> 7fe3fb78 4bd7c845 60000000 7fa3eb78 4bfdd3c9 38210090 e8010010 eba1ffe8
> ebc1fff0 ebe1fff8 7c0803a6 4bfdc2ac <0fe00000> 00000000 7c0802a6 fb01ffc0
> 
> Fixes: 943db62c316c ("powerpc/pseries: Revert 'Auto-online hotplugged memory'")
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1a367063ca0c1c6f6f54b5abd7b483

cheers
