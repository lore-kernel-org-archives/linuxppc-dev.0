To: linuxppc-dev@lists.linuxppc.org
Subject: Oops on core dumping
From: Vincent Bernat <bernat@free.fr>
Date: Tue, 30 Dec 2003 01:17:27 -0800
Message-ID: <m3isjyoeag.fsf@neo.loria>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello !

I am trying to get a dump for an application (vlc) that got a sig kill
each time I try  to use it. When setting   to limit for the core  dump
size to something different of 0 (8 MB or 88 MB), I get an oops :

Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0008FDC LR: C00803B4 SP: C1995CC0 REGS: c1995c10 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000084, DSISR: 40000000
TASK = c3273540[14134] 'vlc' Last syscall: 125
GPR00: C00803B4 C1995CC0 C3273540 00000000 D616C118 00000001 0000010C D616C008
GPR08: 00000000 0000010C 00000000 00000000 175C8940
Call trace:
 [c00803b4] elf_dump_thread_status+0xbc/0x130
 [c0080568] elf_core_dump+0x140/0x75c
 [c006354c] do_coredump+0x1d8/0x1f4
 [c002b63c] get_signal_to_deliver+0x244/0x314
 [c000a4b0] do_signal+0x30/0x24c
 [c0006098] do_user_signal+0x74/0xc4
Oops: kernel access of bad area, sig: 11 [#2]
NIP: C0008FDC LR: C00803B4 SP: D4663CC0 REGS: d4663c10 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000084, DSISR: 40000000
TASK = c79179e0[14223] 'vlc' Last syscall: 119
GPR00: C00803B4 D4663CC0 C79179E0 00000000 D154B918 00000001 0000010C D154B808
GPR08: 00000000 0000010C 00000000 00000000 15651298
Call trace:
 [c00803b4] elf_dump_thread_status+0xbc/0x130
 [c0080568] elf_core_dump+0x140/0x75c
 [c006354c] do_coredump+0x1d8/0x1f4
 [c002b63c] get_signal_to_deliver+0x244/0x314
 [c000a4b0] do_signal+0x30/0x24c
 [c0006098] do_user_signal+0x74/0xc4
Oops: kernel access of bad area, sig: 11 [#3]
NIP: C0008FDC LR: C00803B4 SP: CB4CDCC0 REGS: cb4cdc10 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000084, DSISR: 40000000
TASK = c92110a0[14251] 'vlc' Last syscall: 119
GPR00: C00803B4 CB4CDCC0 C92110A0 00000000 C6041D18 00000001 0000010C C6041C08
GPR08: 00000000 0000010C 00000000 00000000 158395E8
Call trace:
 [c00803b4] elf_dump_thread_status+0xbc/0x130
 [c0080568] elf_core_dump+0x140/0x75c
 [c006354c] do_coredump+0x1d8/0x1f4
 [c002b63c] get_signal_to_deliver+0x244/0x314
 [c000a4b0] do_signal+0x30/0x24c
 [c0006098] do_user_signal+0x74/0xc4
Oops: kernel access of bad area, sig: 11 [#4]
NIP: C0008FDC LR: C00803B4 SP: C73EFCC0 REGS: c73efc10 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000084, DSISR: 40000000
TASK = c768e0e0[14282] 'vlc' Last syscall: 37
GPR00: C00803B4 C73EFCC0 C768E0E0 00000000 D154B118 00000001 0000010C D154B008
GPR08: 00000000 0000010C 00000000 00000000 138C1F40
Call trace:
 [c00803b4] elf_dump_thread_status+0xbc/0x130
 [c0080568] elf_core_dump+0x140/0x75c
 [c006354c] do_coredump+0x1d8/0x1f4
 [c002b63c] get_signal_to_deliver+0x244/0x314
 [c000a4b0] do_signal+0x30/0x24c
 [c0006098] do_user_signal+0x74/0xc4
Oops: kernel access of bad area, sig: 11 [#5]
NIP: C0008FDC LR: C00803B4 SP: CB613CC0 REGS: cb613c10 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000084, DSISR: 40000000
TASK = c7941ae0[14338] 'vlc' Last syscall: 119
GPR00: C00803B4 CB613CC0 C7941AE0 00000000 C6041118 00000001 0000010C C6041008
GPR08: 00000000 0000010C 00000000 00000000 124BBC78
Call trace:
 [c00803b4] elf_dump_thread_status+0xbc/0x130
 [c0080568] elf_core_dump+0x140/0x75c
 [c006354c] do_coredump+0x1d8/0x1f4
 [c002b63c] get_signal_to_deliver+0x244/0x314
 [c000a4b0] do_signal+0x30/0x24c
 [c0006098] do_user_signal+0x74/0xc4

(one for each attempt)

The kernel is a 2.6.0-ben2.
--
die_if_kernel("Whee... Hello Mr. Penguin", current->tss.kregs);
	2.2.16 /usr/src/linux/arch/sparc/kernel/traps.c


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
