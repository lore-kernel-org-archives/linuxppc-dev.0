Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y8xjl24SMzDr3n
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Oct 2017 19:43:39 +1100 (AEDT)
In-Reply-To: <1506657482-25196-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: rlippert@google.com, anton@samba.org
Subject: Re: powerpc/powernv: Make opal_event_shutdown() callable from IRQ
 context
Message-Id: <3y8xjk63QWz9t5Y@ozlabs.org>
Date: Sun,  8 Oct 2017 19:43:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-29 at 03:58:02 UTC, Michael Ellerman wrote:
> In opal_event_shutdown() we free all the IRQs hanging off the
> opal_event_irqchip. However it's not safe to do so if we're called
> from IRQ context, because free_irq() wants to synchronise versus IRQ
> context. This can lead to warnings and a stuck system.
> 
> For example from sysrq-b:
> 
>   Trying to free IRQ 17 from IRQ context!
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1461 __free_irq+0x398/0x8d0
>   ...
>   NIP __free_irq+0x398/0x8d0
>   LR __free_irq+0x394/0x8d0
>   Call Trace:
>     __free_irq+0x394/0x8d0 (unreliable)
>     free_irq+0xa4/0x140
>     opal_event_shutdown+0x128/0x180
>     opal_shutdown+0x1c/0xb0
>     pnv_shutdown+0x20/0x40
>     machine_restart+0x38/0x90
>     emergency_restart+0x28/0x40
>     sysrq_handle_reboot+0x24/0x40
>     __handle_sysrq+0x198/0x590
>     hvc_poll+0x48c/0x8c0
>     hvc_handle_interrupt+0x1c/0x50
>     __handle_irq_event_percpu+0xe8/0x6e0
>     handle_irq_event_percpu+0x34/0xe0
>     handle_irq_event+0xc4/0x210
>     handle_level_irq+0x250/0x770
>     generic_handle_irq+0x5c/0xa0
>     opal_handle_events+0x11c/0x240
>     opal_interrupt+0x38/0x50
>     __handle_irq_event_percpu+0xe8/0x6e0
>     handle_irq_event_percpu+0x34/0xe0
>     handle_irq_event+0xc4/0x210
>     handle_fasteoi_irq+0x174/0xa10
>     generic_handle_irq+0x5c/0xa0
>     __do_irq+0xbc/0x4e0
>     call_do_irq+0x14/0x24
>     do_IRQ+0x18c/0x540
>     hardware_interrupt_common+0x158/0x180
> 
> We can avoid that by using disable_irq_nosync() rather than
> free_irq(). Although it doesn't fully free the IRQ, it should be
> sufficient when we're shutting down, particularly in an emergency.
> 
> Add an in_interrupt() check and use free_irq() when we're shutting
> down normally. It's probably OK to use disable_irq_nosync() in that
> case too, but for now it's safer to leave that behaviour as-is.
> 
> Fixes: 9f0fd0499d30 ("powerpc/powernv: Add a virtual irqchip for opal events")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/c6baa077b784c3b37391a8c11f433e

cheers
