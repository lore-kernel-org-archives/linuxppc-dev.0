Return-Path: <srs0=smtl=a6=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3Km60dHYzDsQ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 15:26:14 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y3Km5616Fz8vkk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 15:26:13 +1000 (AEST)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y3Km501m4z9t3R
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2017 15:26:12 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id j16so427684pga.2
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2017 22:26:12 -0700 (PDT)
Date: Fri, 29 Sep 2017 15:24:59 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, rlippert@google.com, anton@samba.org
Subject: Re: [PATCH] powerpc/powernv: Make opal_event_shutdown() callable
 from IRQ context
Message-ID: <20170929152459.78d35002@gmail.com>
In-Reply-To: <1506657482-25196-1-git-send-email-mpe@ellerman.id.au>
References: <1506657482-25196-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 29 Sep 2017 13:58:02 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

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
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
