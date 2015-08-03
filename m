Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22BC01A0631
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 11:35:04 +1000 (AEST)
In-Reply-To: <1437130018-3430-1-git-send-email-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, anton@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: powerpc/rtas: Introduce rtas_get_sensor_fast() for IRQ handlers
Message-Id: <20150803013504.0CDDD1402DE@ozlabs.org>
Date: Mon,  3 Aug 2015 11:35:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-17-07 at 10:46:58 UTC, Thomas Huth wrote:
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
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1c2cb594441d02815d30

cheers
