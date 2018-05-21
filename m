Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qDnd6x7hzF13y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 20:01:25 +1000 (AEST)
In-Reply-To: <20180514155947.22753-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] powerpc/powernv: Fix opal_event_shutdown() called with
 interrupts disabled
Message-Id: <40qDnd65QKz9s3M@ozlabs.org>
Date: Mon, 21 May 2018 20:01:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-14 at 15:59:46 UTC, Nicholas Piggin wrote:
> A kernel crash in process context that calls emergency_restart from
> panic will end up calling opal_event_shutdown with interrupts disabled
> but not in interrupt. This causes a sleeping function to be called
> which gives the following warning with sysrq+c:
> 
>     Rebooting in 10 seconds..
>     BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
>     in_atomic(): 0, irqs_disabled(): 1, pid: 7669, name: bash
>     CPU: 20 PID: 7669 Comm: bash Tainted: G      D W         4.17.0-rc5+ #3
>     Call Trace:
>     dump_stack+0xb0/0xf4 (unreliable)
>     ___might_sleep+0x174/0x1a0
>     mutex_lock+0x38/0xb0
>     __free_irq+0x68/0x460
>     free_irq+0x70/0xc0
>     opal_event_shutdown+0xb4/0xf0
>     opal_shutdown+0x24/0xa0
>     pnv_shutdown+0x28/0x40
>     machine_shutdown+0x44/0x60
>     machine_restart+0x28/0x80
>     emergency_restart+0x30/0x50
>     panic+0x2a0/0x328
>     oops_end+0x1ec/0x1f0
>     bad_page_fault+0xe8/0x154
>     handle_page_fault+0x34/0x38
>     --- interrupt: 300 at sysrq_handle_crash+0x44/0x60
>     LR = __handle_sysrq+0xfc/0x260
>     flag_spec.62335+0x12b844/0x1e8db4 (unreliable)
>     __handle_sysrq+0xfc/0x260
>     write_sysrq_trigger+0xa8/0xb0
>     proc_reg_write+0xac/0x110
>     __vfs_write+0x6c/0x240
>     vfs_write+0xd0/0x240
>     ksys_write+0x6c/0x110
> 
> Fixes: 9f0fd0499d30 ("powerpc/powernv: Add a virtual irqchip for opal events")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c0beffc4f4c658fde86d52c837e784

cheers
