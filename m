Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA1B4DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 15:27:29 +1100 (EST)
Subject: Re: [PATCH] Fix RTAS watchdog driver temperature read functionality
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Reber <adrian@lisas.de>
In-Reply-To: <20090316123543.GG15530@lisas.de>
References: <20090316123543.GG15530@lisas.de>
Content-Type: text/plain
Date: Tue, 24 Mar 2009 15:27:18 +1100
Message-Id: <1237868838.25062.712.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-16 at 13:35 +0100, Adrian Reber wrote:
> Using the RTAS watchdog driver to read out the temperature crashes
> on a PXCAB:
> 
> Unable to handle kernel paging request for data at address 0xfe347b50
> Faulting instruction address: 0xc00000000001af64
> Oops: Kernel access of bad area, sig: 11 [#1]
> 
> This (removing "(void *)__pa") fixes it.

Looks correct, but why not use rtas_get_sensor() instead ? (Exported by
arch/powerpc/kernel/rtas.c

Cheers,
Ben.

> Signed-off-by: Adrian Reber <adrian@lisas.de>
> ---
>  drivers/watchdog/wdrtas.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> Fix for:
> 
> Unable to handle kernel paging request for data at address 0xfe347b50
> Faulting instruction address: 0xc00000000001af64
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=4 NUMA Cell
> Modules linked in:
> NIP: c00000000001af64 LR: c00000000001af28 CTR: c000000000281888
> REGS: c0000000fe3477a0 TRAP: 0300   Not tainted  (2.6.29-rc6-11955-g2450cf5)
> MSR: 9000000000001032 <ME,IR,DR>  CR: 22000422  XER: 00000000
> DAR: 00000000fe347b50, DSISR: 0000000042000000
> TASK = c0000000fe4886f0[1184] 'a.out' THREAD: c0000000fe344000 CPU: 1
> GPR00: 000000000000002a c0000000fe347a20 c000000000ab2160 c000000000007bc0 
> GPR04: 0000000022000422 c000000000281888 0000000000000000 00000400001e6138  
> GPR08: 0000000000000008 c000000000b23ce4 0000000000000008 00000000fe347b54 
> GPR12: 0000000082000424 c000000000b23680 c0000000003b37b0 c000000000441620 
> GPR16: c0000000004412e0 c000000000441130 000000000e154ec8 c0000000003b4580 
> GPR20: 0000000000000000 00000000100a0370 00000000100a0390 c000000000b23cc8 
> GPR24: 0000000000000001 0000000000000002 00000000fe347b50 0000000000000002 
> GPR28: 0000000000000010 c000000000b23cb0 c000000000a59588 0000000000000002 
> NIP [c00000000001af64] .rtas_call+0x1ac/0x1f8
> LR [c00000000001af28] .rtas_call+0x170/0x1f8
> Call Trace:
> [c0000000fe347a20] [c00000000001af28] .rtas_call+0x170/0x1f8 (unreliable)          
> [c0000000fe347ae0] [c0000000002812e8] .wdrtas_get_temperature+0x48/0xa8  
> [c0000000fe347b70] [c000000000281948] .wdrtas_ioctl+0xc0/0x300
> [c0000000fe347c00] [c0000000000f58a4] .vfs_ioctl+0x54/0x138
> [c0000000fe347c90] [c0000000000f5a20] .do_vfs_ioctl+0x98/0x738
> [c0000000fe347d80] [c0000000000f6114] .SyS_ioctl+0x54/0xc8
> [c0000000fe347e30] [c0000000000074b4] syscall_exit+0x0/0x40
> Instruction dump:
> 2fba0000 419e0034 3939fffe 39400004 79290020 39290002 79281764 e93d0070 
> 7d7a5214 7c09502e 394a0004 7faa4000 <900bfffc> 409effe8 e93d0070 ebe90002 
> ---[ end trace 084fb7ab3feda750 ]---
> 
> diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
> index 5d3b1a8..30ee1f2 100644
> --- a/drivers/watchdog/wdrtas.c
> +++ b/drivers/watchdog/wdrtas.c
> @@ -218,8 +218,7 @@ static int wdrtas_get_temperature(void)
>  	int temperature = 0;
>  
>  	result = rtas_call(wdrtas_token_get_sensor_state, 2, 2,
> -			   (void *)__pa(&temperature),
> -			   WDRTAS_THERMAL_SENSOR, 0);
> +			   &temperature, WDRTAS_THERMAL_SENSOR, 0);
>  
>  	if (result < 0)
>  		printk(KERN_WARNING "wdrtas: reading the thermal sensor "
