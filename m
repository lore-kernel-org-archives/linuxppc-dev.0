Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41j7RJ3mYNzF3GC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2018 12:39:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/opal: Use standard interrupts property
 when available
In-Reply-To: <1523344570.11062.65.camel@kernel.crashing.org>
References: <1523344570.11062.65.camel@kernel.crashing.org>
Date: Sat, 04 Aug 2018 12:39:38 +1000
Message-ID: <87y3dmg8id.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
...
> diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
> index 9d1b8c0aaf93..46785eaf625d 100644
> --- a/arch/powerpc/platforms/powernv/opal-irqchip.c
> +++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
> @@ -174,24 +175,21 @@ void opal_event_shutdown(void)
>  
>  	/* First free interrupts, which will also mask them */
>  	for (i = 0; i < opal_irq_count; i++) {
> -		if (!opal_irqs[i])
> +		if (!opal_irqs || !opal_irqs[i].start)
>  			continue;
>  
>  		if (in_interrupt())
> -			disable_irq_nosync(opal_irqs[i]);
> +			disable_irq_nosync(opal_irqs[i].start);
>  		else
> -			free_irq(opal_irqs[i], NULL);
> -
> -		opal_irqs[i] = 0;

This             ^^^^^^^^^^^^^^

> +			free_irq(opal_irqs[i].start, NULL);
>  	}

causes:

  ------------[ cut here ]------------
  Trying to free already-free IRQ 22
  WARNING: CPU: 0 PID: 1295 at ../kernel/irq/manage.c:1583 __free_irq+0xe0/0x420
  Modules linked in:
  CPU: 0 PID: 1295 Comm: init Tainted: G        W         4.18.0-rc3-gcc-7.3.1-00187-g46a3659b3791-dirty #80
  NIP:  c00000000017ca90 LR: c00000000017ca8c CTR: c000000000771a90
  REGS: c00000007552b810 TRAP: 0700   Tainted: G        W          (4.18.0-rc3-gcc-7.3.1-00187-g46a3659b3791-dirty)
  MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 28000222  XER: 20000000
  CFAR: c000000000106f10 IRQMASK: 1 
  GPR00: c00000000017ca8c c00000007552ba90 c000000000fd1600 0000000000000022 
  GPR04: 0000000000000001 000000000000015e 9000000000009033 0000000000000000 
  GPR08: 000000007ef50000 c000000000ef0bf0 c000000000ef0bf0 9000000000001003 
  GPR12: 0000000000000000 c000000001160000 0000000000000000 0000000000000000 
  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  GPR24: 00000000100c0828 0000000000000000 0000000000000016 c000000077118094 
  GPR28: c000000077118148 0000000000000000 c000000077118000 0000000000000000 
  NIP [c00000000017ca90] __free_irq+0xe0/0x420
  LR [c00000000017ca8c] __free_irq+0xdc/0x420
  Call Trace:
  [c00000007552ba90] [c00000000017ca8c] __free_irq+0xdc/0x420 (unreliable)
  [c00000007552bb30] [c00000000017ced8] free_irq+0x78/0xe0
  [c00000007552bb60] [c0000000000a7c48] opal_event_shutdown+0x158/0x160
  [c00000007552bbf0] [c00000000009d150] pnv_prepare_going_down+0x20/0x80
  [c00000007552bc10] [c00000000009d1d4] pnv_power_off+0x24/0x70
  [c00000007552bc40] [c00000000009d240] pnv_restart+0x0/0x70
  [c00000007552bc60] [c00000000002c2a0] machine_halt+0x60/0x70
  [c00000007552bc80] [c000000000139f74] kernel_halt+0x84/0xa0
  [c00000007552bce0] [c00000000013a36c] sys_reboot+0x28c/0x2c0
  [c00000007552be30] [c00000000000b9e4] system_call+0x5c/0x70
  Instruction dump:
  e93f0008 7fa9e840 419e0098 7feafb78 ebea0018 2fbf0000 409effe8 3c62ffd0 
  7f44d378 386326c8 4bf8a421 60000000 <0fe00000> 7f24cb78 7f63db78 48952bdd 
  ---[ end trace 926f8007a9952304 ]---


Because we're calling opal_event_shutdown() twice, via opal_shutdown()
and then pnv_prepare_going_down().

Did you drop that line on purpose, or was it just collateral damage?

The obvious fix does work:

+	opal_irqs[i].start = 0;


cheers
