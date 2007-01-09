Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61DE0DDE24
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 11:40:09 +1100 (EST)
Subject: Re: 2.6.20-rc4 Kernel Oops on Maple
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Owen Stampflee <ostampflee@terrasoftsolutions.com>
In-Reply-To: <1168289034.2610.214.camel@darkside.terraplex.com>
References: <1168289034.2610.214.camel@darkside.terraplex.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 11:40:02 +1100
Message-Id: <1168303202.22458.248.camel@localhost.localdomain>
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

On Mon, 2007-01-08 at 12:43 -0800, Owen Stampflee wrote:
> I'm seeing both a sig 5 and a sig 11 in two backtraces during boot on a
> Maple-based board... both vanilla 2.6.17.13 and 2.6.18.1 work fine on
> this board.
> 
> Anyone have any ideas on what got broken?
> 
> Thanks,
> Owen
> 
> Kernel BUG at c0000000001d68f0 [verbose debug info unavailable]

What was the line just before the one above ?

(Why do people think it's a good idea to trim the dmesg output ?
Grrrr...)

Ben.

> Oops: Exception in kernel mode, sig: 5 [#1]
> SMP NR_CPUS=32 NUMA
> Modules linked in:
> NIP: C0000000001D68F0 LR: C000000000022ED0 CTR: 0000000000000000
> REGS: c0000000008136b0 TRAP: 0700   Not tainted  (2.6.20-rc4.ydl.1)
> MSR: 9000000000021032 <ME,IR,DR>  CR: 845A2844  XER: 00000003
> TASK = c000000000724840[0] 'swapper' THREAD: c000000000810000 CPU: 0
> GPR00: 0000000000000001 C000000000813930 C00000000080E588 C00000007EFFAFC0
> GPR04: C0000000007C9498 0000000000000000 C000000000813AD0 0000000000000003
> GPR08: 0000000000010000 C000000000813AD0 0000000000000900 0000000000000000
> GPR12: C000000000813AC4 C000000000725100 00000000013F97D0 00000000013F97C0
> GPR16: 00000000013F97B0 000000000106BA90 0000000000003000 C000000000813AC4
> GPR20: C00000007EFFB8F8 0000000000000001 0000000000000018 C00000000072AB90
> GPR24: C00000000072AB90 0000000000000006 0000000000000003 0000000000000006
> GPR28: C00000007EFFB8F8 C00000000083A880 C0000000022EDA48 C00000007EFFAF60
> NIP [C0000000001D68F0] .kref_get+0xc/0x24
> LR [C000000000022ED0] .of_node_get+0x20/0x3c
> Call Trace:
> [C000000000813930] [C0000000008139D0] init_thread_union+0x39d0/0x4000 (unreliable)
> [C0000000008139B0] [C000000000022FC4] .of_get_parent+0x38/0x64
> [C000000000813A40] [C00000000001B7EC] .of_translate_address+0xf0/0x38c
> [C000000000813B50] [C00000000001BAC4] .__of_address_to_resource+0x3c/0xe0
> [C000000000813BF0] [C00000000001BBB0] .of_address_to_resource+0x48/0x68
> [C000000000813C90] [C0000000006E78E8] .maple_get_boot_time+0x40/0x12c
> [C000000000813D70] [C0000000000221C8] .get_boot_time+0x3c/0xb8
> [C000000000813E10] [C0000000006D7560] .time_init+0x27c/0x458
> [C000000000813EF0] [C0000000006CD774] .start_kernel+0x1a8/0x338
> [C000000000813F90] [C000000000008528] .start_here_common+0x54/0x12c
> Instruction dump:
> 4e800421 e8410028 38000001 38210080 7c030378 e8010010 ebc1fff0 7c0803a6
> 4e800020 80030000 7c000034 5400d97e <0b000000> 7c001828 30000001 7c00192d
>  <0>Kernel panic - not syncing: Attempted to kill the idle task!
>  <0>Rebooting in 180 seconds..<1>Unable to handle kernel paging request for data at address 0x00000010
> Faulting instruction address: 0xc000000000022528
> Oops: Kernel access of bad area, sig: 11 [#2]
> SMP NR_CPUS=32 NUMA
> Modules linked in:
> NIP: C000000000022528 LR: C000000000022510 CTR: C000000000061B18
> REGS: c000000000812c50 TRAP: 0300   Not tainted  (2.6.20-rc4.ydl.1)
> MSR: 9000000000001032 <ME,IR,DR>  CR: 285A2822  XER: 00000003
> DAR: 0000000000000010, DSISR: 0000000040000000
> TASK = c000000000724840[0] 'swapper' THREAD: c000000000810000 CPU: 0
> GPR00: 003D090000000000 C000000000812ED0 C00000000080E588 003D090000000000
> GPR04: C000000000724840 0000000000000008 0000000000000001 0000000000000008
> GPR08: 0000000000000000 0000000000000000 C00000000083A818 C000000000732348
> GPR12: 9000000000009032 C000000000725100 00000000013F97D0 00000000013F97C0
> GPR16: 00000000013F97B0 000000000106BA90 0000000000003000 C000000000813AC4
> GPR20: C00000007EFFB8F8 0000000000000001 0000000000000018 C00000000072AB90
> GPR24: C00000000072AB90 C000000000813020 0000000000000000 0000000000000000
> GPR28: C00000000083A7C0 C00000000081F000 C000000000725100 00000004189DD448
> NIP [C000000000022528] .timer_interrupt+0x148/0x480
> LR [C000000000022510] .timer_interrupt+0x130/0x480
> Call Trace:
> [C000000000812ED0] [C000000000022504] .timer_interrupt+0x124/0x480 (unreliable)
> [C000000000812FB0] [C000000000003608] decrementer_common+0x108/0x180
> --- Exception: 901 at .__delay+0x18/0x34
>     LR = .panic+0x12c/0x1b0
> [C0000000008132A0] [C000000000061F3C] .panic+0xe4/0x1b0 (unreliable)
> [C000000000813340] [C0000000000664D8] .do_exit+0x88/0x994
> [C000000000813400] [C000000000023F08] .die+0x1a8/0x1ac
> [C000000000813490] [C000000000024160] ._exception+0x40/0x134
> [C0000000008135A0] [C0000000005324A4] .program_check_exception+0x534/0x54c
> [C000000000813640] [C000000000004A7C] program_check_common+0xfc/0x100
> --- Exception: 700 at .kref_get+0xc/0x24
>     LR = .of_node_get+0x20/0x3c
> [C000000000813930] [C0000000008139D0] init_thread_union+0x39d0/0x4000 (unreliable)
> [C0000000008139B0] [C000000000022FC4] .of_get_parent+0x38/0x64
> [C000000000813A40] [C00000000001B7EC] .of_translate_address+0xf0/0x38c
> [C000000000813B50] [C00000000001BAC4] .__of_address_to_resource+0x3c/0xe0
> [C000000000813BF0] [C00000000001BBB0] .of_address_to_resource+0x48/0x68
> [C000000000813C90] [C0000000006E78E8] .maple_get_boot_time+0x40/0x12c
> [C000000000813D70] [C0000000000221C8] .get_boot_time+0x3c/0xb8
> [C000000000813E10] [C0000000006D7560] .time_init+0x27c/0x458
> [C000000000813EF0] [C0000000006CD774] .start_kernel+0x1a8/0x338
> [C000000000813F90] [C000000000008528] .start_here_common+0x54/0x12c
> Instruction dump:
> f81d0000 38600001 4804c185 60000000 ebfd0000 4805eff9 60000000 e94298e8
> e9229858 e80a0000 e9290038 7fa30000 <e9290010> 409e001c 3800ffff 7d29f850
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
