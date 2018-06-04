Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxfs5ffNzF0dm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:45 +1000 (AEST)
In-Reply-To: <20180504171935.25410-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [01/11] powerpc/64: irq_work avoid interrupt when called with
 hardware irqs enabled
Message-Id: <40zxfs0Y5Zz9s5b@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-04 at 17:19:25 UTC, Nicholas Piggin wrote:
> irq_work_raise should not cause a decrementer exception unless it is
> called from NMI context. Doing so often just results in an immediate
> masked decrementer interrupt:
> 
>    <...>-550    90d...    4us : update_curr_rt <-dequeue_task_rt
>    <...>-550    90d...    5us : dbs_update_util_handler <-update_curr_rt
>    <...>-550    90d...    6us : arch_irq_work_raise <-irq_work_queue
>    <...>-550    90d...    7us : soft_nmi_interrupt <-soft_nmi_common
>    <...>-550    90d...    7us : printk_nmi_enter <-soft_nmi_interrupt
>    <...>-550    90d.Z.    8us : rcu_nmi_enter <-soft_nmi_interrupt
>    <...>-550    90d.Z.    9us : rcu_nmi_exit <-soft_nmi_interrupt
>    <...>-550    90d...    9us : printk_nmi_exit <-soft_nmi_interrupt
>    <...>-550    90d...   10us : cpuacct_charge <-update_curr_rt
> 
> The soft_nmi_interrupt here is the call into the watchdog, due to the
> decrementer interrupt firing with irqs soft-disabled. This is
> harmless, but sub-optimal.
> 
> When it's not called from NMI context or with interrupts enabled, mark
> the decrementer pending in the irq_happened mask directly, rather than
> having the masked decrementer interupt handler do it. This will be
> replayed at the next local_irq_enable. See the comment for details.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ebb37cf3ffd39fdb6ec5b07111f8bb

cheers
