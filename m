Date: Mon, 2 Jul 2001 09:17:18 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Well, those changes broke something
Message-ID: <Pine.LNX.3.95.1010702090104.4368F-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've spent today getting my three week old 2_4_devel tree up to date with
the new 2_4_devel boot structure. I think that I've amde all of the
appropriate changes (changed board_init() to platform_init(), added
platform_set_bat and platform_map_io() functions, and made various
makefile changes and the like). I have the kernel comiling and booting,
but I get very regular segfaults.

The kernel uncompresses and mounts the ramdisk just fine, and executes
a shell, init, or linuxrc script just fine- but it seems that when I start
another process I get a segfault (I say it seems because I am not sure of
this).

Anyhow, below are three characteristic suicide notes from the kernel. I am
unsure how to trace them, due to the odd addresses
{02000000,FFFF0001,00000000,7FFFFFDB,7FFFFF2C}. Perhaps those calls are
the cause of the segfaults? But why then are there calls after these odd
accesses? Also, all three of the below (and indeed, all that I have
encountered) have NIP= C0006000, which is __fluch_dcache_icache. Might
this be the problem?

And, what has changed over the past three weeks that could be causing
these failures? Or, what have I missed in compiling the kernel that could
be causing these failures?

Thanks- errors are below:

Oops: kernel access of bad area, sig: 11
NIP: C0006000 XER: 20000000 LR: C000C774 SP: C03B7810 REGS: c03b7760 TRAP:
0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000042A6, DSISR: 20000000
TASK = c03b6000[1] 'linuxrc' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C03B7810 C03B6000 C7C64000 07C64785 00000004 00000000
0000036C
GPR08: 82000000 00000000 C0130000 C0188034 44048048 00000000 00200000
002563E0
GPR16: 0029AC20 C03B7B1C 00000001 C03C0B40 00009032 003B7940 00000000
C0004024
GPR24: C000BB88 02000000 FFFFFFFF 3004DEBC C0955134 02000000 C0957220
C0398AC4
Call backtrace:
02000000 C0021D20 C0021DD4 C000BD18 C0004024 FFFF0001 C004FCCC
C005055C C003FC38 C004F568 C003FC38 C003FF90 C0006B9C C0003DBC
C0003BC0 C00064B0



Oops: kernel access of bad area, sig: 11
NIP: C0006000 XER: 00000000 LR: C000C774 SP: C03ADD40 REGS: c03adc90 TRAP:
0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000042A6, DSISR: 20000000
TASK = c03ac000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C03ADD40 C03AC000 C7C66000 07C66305 C03EB6A8 C7C66FFC
C01373DC
GPR08: C01373EC 0000004C C0130000 C0188034 000554C8 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 003ADE70 00000000
C0004024
GPR24: C000BB88 00000000 FFFFFFFF 1002F3F4 C01280BC 00000000 C012A160
C0398B4C
Call backtrace:
00000000 C0021D20 C0021DD4 C000BD18 C0004024 7FFFFFDB


Oops: kernel access of bad area, sig: 11
NIP: C0006000 XER: 20000000 LR: C0007CD0 SP: C03B7DA0 REGS: c03b7cf0 TRAP:
0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: FFFFFFF8, DSISR: 20000000
TASK = c03b6000[1] 'sh' Last syscall: 126
last math 00000000 last altivec 00000000
GPR00: 44000002 C03B7DA0 C03B6000 7FFFFC00 00000001 0000001F 7FFFFC00
00000000
GPR08: 00000000 7FFFFBEC 7FFFFBE8 00000000 00000002 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 003B7E70 00000000
C0004064
GPR24: C0003DA0 7FFFFF2C C03D06A4 C03B6388 7FFFFA00 7FFFFBE8 C03B7E80
7FFFFA20
Call backtrace:
7FFFFF2C C000844C C0004098 00218CC8 0020D3F0 0020C9A4 00203394
00202CB0 00201F90


--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
