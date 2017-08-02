Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN7fy6n3QzDqs7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 08:49:45 +1000 (AEST)
Message-ID: <1501711052.2664.7.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/xive: fix the fuzz value in xive_pick_irq_target()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 03 Aug 2017 07:57:32 +1000
In-Reply-To: <1501692230-20789-1-git-send-email-clg@kaod.org>
References: <1501692230-20789-1-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-02 at 18:43 +0200, Cédric Le Goater wrote:
> If xive_find_target_in_mask() fails to find a cpu, the fuzz value used
> in xive_pick_irq_target() is decremented and reused in the last
> returning call to xive_find_target_in_mask(). This can result in such
> WARNINGs if the initial fuzz value is zero :

Ah indeed ... would have worked better if "fuzz" had been unsigned.

>    [    0.094480] WARNING: CPU: 10 PID: 1 at ../arch/powerpc/sysdev/xive/common.c:476 xive_find_target_in_mask+0x110/0x2f0
>    [    0.094486] Modules linked in:
>    [    0.094491] CPU: 10 PID: 1 Comm: swapper/0 Not tainted 4.12.0+ #3
>    [    0.094496] task: c0000003fae4f200 task.stack: c0000003fe108000
>    [    0.094501] NIP: c00000000008a310 LR: c00000000008a2e4 CTR: 000000000072ca34
>    [    0.094506] REGS: c0000003fe10b360 TRAP: 0700   Not tainted  (4.12.0+)
>    [    0.094510] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
>    [    0.094515]   CR: 88000222  XER: 20040008
>    [    0.094521] CFAR: c00000000008a2cc SOFTE: 0
>    [    0.094521] GPR00: c00000000008a274 c0000003fe10b5e0 c000000001428f00 0000000000000010
>    [    0.094521] GPR04: 0000000000000010 0000000000000010 0000000000000010 0000000000000099
>    [    0.094521] GPR08: 0000000000000010 0000000000000001 ffffffffffff0000 0000000000000000
>    [    0.094521] GPR12: 0000000000000000 c00000000fff2d00 c00000000000d4d8 0000000000000000
>    [    0.094521] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>    [    0.094521] GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000000b451e8
>    [    0.094521] GPR24: 00000000ffffffff c000000001462354 0000000000000800 00000000000007ff
>    [    0.094521] GPR28: c000000001462354 0000000000000010 c0000003f857e418 0000000000000010
>    [    0.094580] NIP [c00000000008a310] xive_find_target_in_mask+0x110/0x2f0
>    [    0.094585] LR [c00000000008a2e4] xive_find_target_in_mask+0xe4/0x2f0
>    [    0.094589] Call Trace:
>    [    0.094593] [c0000003fe10b5e0] [c00000000008a274] xive_find_target_in_mask+0x74/0x2f0 (unreliable)
>    [    0.094601] [c0000003fe10b690] [c00000000008abf0] xive_pick_irq_target.isra.1+0x200/0x230
>    [    0.094608] [c0000003fe10b830] [c00000000008b250] xive_irq_startup+0x60/0x180
>    [    0.094614] [c0000003fe10b8b0] [c0000000001608f0] irq_startup+0x70/0xd0
>    [    0.094620] [c0000003fe10b8f0] [c00000000015df7c] __setup_irq+0x7bc/0x880
>    [    0.094626] [c0000003fe10ba90] [c00000000015e30c] request_threaded_irq+0x14c/0x2c0
>    [    0.094632] [c0000003fe10baf0] [c0000000000aeb00] request_event_sources_irqs+0x100/0x180
>    [    0.094639] [c0000003fe10bc10] [c000000000e7d2f8] __machine_initcall_pseries_init_ras_IRQ+0x104/0x134
>    [    0.094646] [c0000003fe10bc40] [c00000000000cc88] do_one_initcall+0x68/0x1d0
>    [    0.094652] [c0000003fe10bd00] [c000000000e643c8] kernel_init_freeable+0x290/0x374
>    [    0.094658] [c0000003fe10bdc0] [c00000000000d4f4] kernel_init+0x24/0x170
>    [    0.094664] [c0000003fe10be30] [c00000000000b268] ret_from_kernel_thread+0x5c/0x74
>    [    0.094669] Instruction dump:
>    [    0.094673] 48586529 60000000 e8dc0002 393f0001 7f9b4800 7c7d07b4 7d3f07b4 409effcc
>    [    0.094682] 7f9d3000 7d26e850 79290fe0 69290001 <0b090000> 409c0194 3f620004 3b7b8ec8
> 
> Fix this problem by checking the fuzz value before decrementing it.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/sysdev/xive/common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index 6595462b1fc8..50ce48983340 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -516,7 +516,8 @@ static int xive_pick_irq_target(struct irq_data *d,
>  		free_cpumask_var(mask);
>  		if (cpu >= 0)
>  			return cpu;
> -		fuzz--;
> +		if (fuzz)
> +			fuzz--;
>  	}
>  
>  	/* No chip IDs, fallback to using the affinity mask */
