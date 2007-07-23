Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FAD3DDE34
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 08:06:27 +1000 (EST)
Subject: Re: 2.6.23-rc1 breaks on JS20 w/SLOF
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Reber <adrian@lisas.de>
In-Reply-To: <20070723144745.GA31329@lisas.de>
References: <20070723144745.GA31329@lisas.de>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 08:06:18 +1000
Message-Id: <1185228378.5439.144.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-23 at 16:47 +0200, Adrian Reber wrote:
> On a JS20 with SLOF (pretending to be Maple) 2.6.23-rc1 breaks with
> following oops. 2.6.22 is working. Let me know if I can help debug this.

That would be my fault... looks like it tries to access IO ports before
the IO space is mapped by the PCI code, and without a legacy ISA range.
The later is now the only case where IO ports are available before the
main PCI setup.

I can add some tweak to the maple code to map the ISA stuff even when
the "isa" node is missing...

Ben.


> Maple: Found RTC at IO 0x1070
> Unable to handle kernel paging request for data at address 0xd000080000001070
> Faulting instruction address: 0xc00000000004d948
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=32 Maple
> Modules linked in:
> NIP: c00000000004d948 LR: c00000000004d8e4 CTR: c000000000029308
> REGS: c00000000088b8e0 TRAP: 0300   Not tainted  (2.6.23-rc1)
> MSR: 9000000000001032 <ME,IR,DR>  CR: 24000022  XER: 000fffff
> DAR: d000080000001070, DSISR: 0000000042000000
> TASK = c00000000079db50[0] 'swapper' THREAD: c000000000888000 CPU: 0
> GPR00: d000080000000000 c00000000088bb60 c0000000008884a8 000000000000000a 
> GPR04: d000080000001070 0000000000000001 0000000000000000 0000000000000001 
> GPR08: 0000000000001070 d000080000001070 0000000000000000 c0000000008b33b0 
> GPR12: c00000000088bab4 c00000000079e480 0000000000000000 0000000000000000 
> GPR16: 0000000004000000 0000000000000000 0000000000000000 4000000001400000 
> GPR20: c000000000752370 0000000001b525e0 0000000000000000 c0000000008b47f0 
> GPR24: c00000000088be70 c0000000008b4820 000000003b9aca00 c0000000008b47f8 
> GPR28: 0000000000000000 000000000000000a c000000000821af8 c00000000088bcf0 
> NIP [c00000000004d948] .maple_clock_read+0x88/0x17c
> LR [c00000000004d8e4] .maple_clock_read+0x24/0x17c
> Call Trace:
> [c00000000088bb60] [c00000000088bbe0] init_thread_union+0x3be0/0x4000 (unreliable)
> [c00000000088bbf0] [c00000000004dc40] .maple_get_rtc_time+0x28/0x174
> [c00000000088bc80] [c000000000731000] .maple_get_boot_time+0xe4/0x12c
> [c00000000088bd60] [c000000000022694] .get_boot_time+0x3c/0xb8
> [c00000000088be00] [c000000000721088] .time_init+0x290/0x46c
> [c00000000088bee0] [c000000000716c18] .start_kernel+0x23c/0x3e4
> [c00000000088bf90] [c000000000008524] .start_here_common+0x54/0xb0
> Instruction dump:
> 419e0024 e80a0000 f8410028 7c0903a6 e96a0010 e84a0008 4e800421 e8410028 
> 4800001c 78892300 7929e002 7c0004ac <98690000> 38000001 980d01dc e97e8008 
> Kernel panic - not syncing: Attempted to kill the idle task!
> ------------[ cut here ]------------
> Badness at arch/powerpc/kernel/smp.c:202
> NIP: c000000000028ae0 LR: c000000000069410 CTR: c000000000029308
> REGS: c00000000088b2b0 TRAP: 0700   Tainted: G      D  (2.6.23-rc1)
> MSR: 9000000000021032 <ME,IR,DR>  CR: 28000022  XER: 000fffff
> TASK = c00000000079db50[0] 'swapper' THREAD: c000000000888000 CPU: 0
> GPR00: 0000000000000001 c00000000088b530 c0000000008884a8 c000000000841418 
> GPR04: 0000000000000000 0000000000000001 0000000000000000 0000000000000001 
> GPR08: 0000000000000001 c0000000008b4b88 c0000000008c1af8 c000000000841418 
> GPR12: c000000000008524 c00000000079e480 0000000000000000 0000000000000000 
> GPR16: 0000000004000000 0000000000000000 0000000000000000 4000000001400000 
> GPR20: c000000000752370 0000000001b525e0 0000000000000000 c0000000008b47f0 
> GPR24: c00000000088be70 000000000000000b 000000003b9aca00 000000000000000b 
> GPR28: c0000000006778f0 0000000000000000 c000000000822a98 0000000000000000 
> NIP [c000000000028ae0] .smp_call_function_map+0x30/0x2a4
> LR [c000000000069410] .panic+0x98/0x1b0
> Call Trace:
> [c00000000088b530] [c00000000082ebe8] gss_kerberos_pfs+0x16e18/0x25ff0 (unreliable)
> [c00000000088b5e0] [c000000000069410] .panic+0x98/0x1b0
> [c00000000088b680] [c00000000006dffc] .do_exit+0x8c/0xa60
> [c00000000088b750] [c000000000023dcc] .die+0x238/0x264
> [c00000000088b7f0] [c00000000002d2a8] .bad_page_fault+0xb8/0xd4
> [c00000000088b870] [c000000000005418] handle_page_fault+0x3c/0x58
> --- Exception: 300 at .maple_clock_read+0x88/0x17c
>     LR = .maple_clock_read+0x24/0x17c
> [c00000000088bb60] [c00000000088bbe0] init_thread_union+0x3be0/0x4000 (unreliable)
> [c00000000088bbf0] [c00000000004dc40] .maple_get_rtc_time+0x28/0x174
> [c00000000088bc80] [c000000000731000] .maple_get_boot_time+0xe4/0x12c
> [c00000000088bd60] [c000000000022694] .get_boot_time+0x3c/0xb8
> [c00000000088be00] [c000000000721088] .time_init+0x290/0x46c
> [c00000000088bee0] [c000000000716c18] .start_kernel+0x23c/0x3e4
> [c00000000088bf90] [c000000000008524] .start_here_common+0x54/0xb0
> Instruction dump:
> 7c0802a6 fba1ffe8 fbc1fff0 fbe1fff8 7c6b1b78 f8010010 f821ff51 7cdd3378 
> f8e10100 880d01da 7c000074 7800d182 <0b000000> e922a900 3860ffff e8090000 
> Rebooting in 180 seconds..
> 
> 
> 		Adrian
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
