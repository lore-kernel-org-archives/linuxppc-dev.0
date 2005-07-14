Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5CDD067C85
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 23:31:55 +1000 (EST)
In-Reply-To: <faba7798050714012370af5e74@mail.gmail.com>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
	<faba7798050714012370af5e74@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <EA68D741-EF23-461C-9ECB-49BB0D24367D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 14 Jul 2005 08:31:50 -0500
To: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ptrace on linux 2.6.12 causes oops
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What system is this on?

- kumar

On Jul 14, 2005, at 3:23 AM, Anton W=F6llert wrote:

> Hello
>
> when i try to run strace or gdbserver on a program, the following =20
> comes:
>
> Oops: kernel access of bad area, sig: 11 [#2]
> NIP: C000543C LR: C000B060 SP: C0F35DF0 REGS: c0f35d40 TRAP: =20
> 0300    Not tainted
> MSR: 00009022 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 10
> DAR: 00000010, DSISR: C2000000
> TASK =3D c0ea8430[761] 'gdbserver' THREAD: c0f34000
> Last syscall: 26
> GPR00: 00009022 C0F35DF0 C0EA8430 00F59000 00000100 FFFFFFFF =20
> 00F58000 00000001
> GPR08: C021DAEF C0270000 00009032 C0270000 22044024 10025428 =20
> 01000800 00000001
> GPR16: 007FFF3F 00000001 00000000 7FBC6AC0 00F61022 00000001 =20
> C0839300 C01E0000
> GPR24: 00CD0889 C082F568 3000AC18 C02A7A00 C0EA15C8 00F588A9 =20
> C02ACB00 C02ACB00
> NIP [c000543c] __flush_dcache_icache_phys+0x38/0x54
> LR [c000b060] flush_dcache_icache_page+0x20/0x30
> Call trace:
>  [c000b154] update_mmu_cache+0x7c/0xa4
>  [c005ae98] do_wp_page+0x460/0x5ec
>  [c005c8a0] handle_mm_fault+0x7cc/0x91c
>  [c005ccec] get_user_pages+0x2fc/0x65c
>  [c0027104] access_process_vm+0x9c/0x1d4
>  [c00076e0] sys_ptrace+0x240/0x4a4
>  [c0002bd0] ret_from_syscall+0x0/0x44
> mm/memory.c:2054: spin_lock(kernel/fork.c:c0ea1618) already locked =20
> by mm/memory.c/1306
>
> and strace or gdbserver of course says segmentation fault. with =20
> gdbserver, this happens every time. with strace, the first time it =20
> works nearly all time, but when i strace a second time program =20
> again, it segfaults. i think the access_process_vm is accessed =20
> trough PEEKDATA and PEEKTEXT in sys_ptrace. so here some more =20
> debug :) :
>
> DEBUG: peekdata @ 1006d4ec
> DEBUG: peektext @ 1006d4f0
> DEBUG: peekdata @ 1006d4f0
> DEBUG: peektext @ 1006d4f4
> DEBUG: peekdata @ 1006d4f4
> DEBUG: peektext @ 1006d4f8
> DEBUG: peekdata @ 1006d4f8
> DEBUG: peektext @ 1006d4fc
> DEBUG: peekdata @ 1006d4fc
> DEBUG: peektext @ 1006d500
> DEBUG: peekdata @ 1006d500
> DEBUG: peektext @ 1006d504
> DEBUG: peekdata @ 1006d504
> DEBUG: peektext @ 1006d508
> DEBUG: peekdata @ 1006d508
> DEBUG: peektext @ 1006d50c
> DEBUG: peekdata @ 1006d50c
> DEBUG: peektext @ 1006d510
> DEBUG: peekdata @ 1006d510
> DEBUG: peektext @ 1006d514
> DEBUG: peekdata @ 1006d514
> DEBUG: peektext @ 1006d518
> DEBUG: peekdata @ 1006d518
> DEBUG: peektext @ 1006d51c
> DEBUG: peekdata @ 1006d51c
> DEBUG: peektext @ 1006d520
> DEBUG: peekdata @ 1006d520
> DEBUG: peektext @ 1006d524
> DEBUG: peekdata @ 1006d524
> DEBUG: peektext @ 1006d528
> DEBUG: peekdata @ 1006d528
> DEBUG: peektext @ 1006d52c
> DEBUG: peekdata @ 1006d52c
> DEBUG: peektext @ 00000000
> DEBUG: peekdata @ 00000000
> DEBUG: peektext @ 3000ac18
> DEBUG: peekdata @ 3000ac18
> DEBUG: peektext @ 3000ac18
> DEBUG: peekdata @ 3000ac18
> DEBUG: flush_dcache_icache_page
> Oops: kernel access of bad area, sig: 11 [#2]
> NIP: C000543C LR: C000B060 SP: C0F35DF0 REGS: c0f35d40 TRAP: =20
> 0300    Not tainted
> MSR: 00009022 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 10
> DAR: 00000010, DSISR: C2000000
> TASK =3D c0ea8430[761] 'gdbserver' THREAD: c0f34000
> Last syscall: 26
> GPR00: 00009022 C0F35DF0 C0EA8430 00F59000 00000100 FFFFFFFF =20
> 00F58000 00000001
> GPR08: C021DAEF C0270000 00009032 C0270000 22044024 10025428 =20
> 01000800 00000001
> GPR16: 007FFF3F 00000001 00000000 7FBC6AC0 00F61022 00000001 =20
> C0839300 C01E0000
> GPR24: 00CD0889 C082F568 3000AC18 C02A7A00 C0EA15C8 00F588A9 =20
> C02ACB00 C02ACB00
> NIP [c000543c] __flush_dcache_icache_phys+0x38/0x54
> LR [c000b060] flush_dcache_icache_page+0x20/0x30
> Call trace:
>  [c000b154] update_mmu_cache+0x7c/0xa4
>  [c005ae98] do_wp_page+0x460/0x5ec
>  [c005c8a0] handle_mm_fault+0x7cc/0x91c
>  [c005ccec] get_user_pages+0x2fc/0x65c
>  [c0027104] access_process_vm+0x9c/0x1d4
>  [c00076e0] sys_ptrace+0x240/0x4a4
>  [c0002bd0] ret_from_syscall+0x0/0x44
> mm/memory.c:2054: spin_lock(kernel/fork.c:c0ea1618) already locked =20
> by mm/memory.c/1306
>
>
>
>
> <ATT11632593.txt>
>
