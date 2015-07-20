Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0411C1A02B5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 01:11:42 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 20 Jul 2015 09:11:40 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 187771FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 09:02:48 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6KFAnD738011038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 08:10:49 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6KFBbxi011545
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 09:11:37 -0600
Message-ID: <55AD0FA8.4070107@linux.vnet.ibm.com>
Date: Mon, 20 Jul 2015 10:11:36 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
CC: kvm-ppc@vger.kernel.org, anton@samba.org, benh@kernel.crashing.org,
 paulus@samba.org
Subject: Re: [PATCH] powerpc/rtas: Introduce rtas_get_sensor_fast() for IRQ
 handlers
References: <1437130018-3430-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1437130018-3430-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2015 05:46 AM, Thomas Huth wrote:
> The EPOW interrupt handler uses rtas_get_sensor(), which in turn
> uses rtas_busy_delay() to wait for RTAS becoming ready in case it
> is necessary. But rtas_busy_delay() is annotated with might_sleep()
> and thus may not be used by interrupts handlers like the EPOW handler!
> This leads to the following BUG when CONFIG_DEBUG_ATOMIC_SLEEP is
> enabled:
> 
>  BUG: sleeping function called from invalid context at arch/powerpc/kernel/rtas.c:496
>  in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/1
>  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.2.0-rc2-thuth #6
>  Call Trace:
>  [c00000007ffe7b90] [c000000000807670] dump_stack+0xa0/0xdc (unreliable)
>  [c00000007ffe7bc0] [c0000000000e1f14] ___might_sleep+0x134/0x180
>  [c00000007ffe7c20] [c00000000002aec0] rtas_busy_delay+0x30/0xd0
>  [c00000007ffe7c50] [c00000000002bde4] rtas_get_sensor+0x74/0xe0
>  [c00000007ffe7ce0] [c000000000083264] ras_epow_interrupt+0x44/0x450
>  [c00000007ffe7d90] [c000000000120260] handle_irq_event_percpu+0xa0/0x300
>  [c00000007ffe7e70] [c000000000120524] handle_irq_event+0x64/0xc0
>  [c00000007ffe7eb0] [c000000000124dbc] handle_fasteoi_irq+0xec/0x260
>  [c00000007ffe7ef0] [c00000000011f4f0] generic_handle_irq+0x50/0x80
>  [c00000007ffe7f20] [c000000000010f3c] __do_irq+0x8c/0x200
>  [c00000007ffe7f90] [c0000000000236cc] call_do_irq+0x14/0x24
>  [c00000007e6f39e0] [c000000000011144] do_IRQ+0x94/0x110
>  [c00000007e6f3a30] [c000000000002594] hardware_interrupt_common+0x114/0x180
> 
> Fix this issue by introducing a new rtas_get_sensor_fast() function
> that does not use rtas_busy_delay() - and thus can only be used for
> sensors that do not cause a BUSY condition (which should be the case
> for the sensor that is queried by the EPOW IRQ handler).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/rtas.h      |  1 +
>  arch/powerpc/kernel/rtas.c           | 17 +++++++++++++++++
>  arch/powerpc/platforms/pseries/ras.c |  3 ++-
>  3 files changed, 20 insertions(+), 1 deletion(-)
