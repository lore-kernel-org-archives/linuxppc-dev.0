Message-ID: <7283DE19D141D111AD0E00A0C95B195502D968E1@mail2.aiinet.com>
From: "Dayton, Dean" <dean@aiinet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: device memory mapping
Date: Fri, 14 Apr 2000 16:45:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm in the process of porting Linux to a proprietary board that has run pSOS
in the past. The board has an MPC860, one ethernet on SCC1, another ethernet
using a Sonic chip, and 4 quad Cirrus Logic CD2401 serial chips.

I started with mpc8xx-2.2.13.tgz. The console and the SCC base ethernet came
up easily. Now I'm trying to port the Sonic driver (which appears to have
been intended for a MIPs machine). Under pSOS, with a flat address space, we
mapped the Sonic base to 0x40000000.

How do I map this address in Linux. Whenever I try to read from the Sonic I
get the following error:

	NIP: C00A7148 XER: 0000FF01 LR: C00A7148 REGS: c048fd90 TRAP: 0300
	MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
	TASK = c048e000[1] 'swapper' mm->pgd c00c7000 Last syscall: 120 last
math 00000000
	GPR00: C00A7148 C048FE40 C048E000 00000019 00000001 00000019
00000001 C0490720
	GPR08: FF002830 C00E0000 00000019 C048FD80 88400022 00012FF0
0009C101 C1062840
	GPR16: C3A67D1B 00101800 C3A67D1B 00100000 00900000 001001C4
00210000 00002C78
	GPR24: 00000000 00E00000 00000001 0020000D 40000000 C00D6510
40000000 C00D6890
	Call backtrace:
	C00A7148 C00A70EC C00A6C64 C00A6D38 C00631A4 C00988CC C00032EC
	C0003408 C000783C 7C0802A6
	Kernel panic: kernel access of bad area pc c00a7148 lr c00a7148
address 400000A0 tsk swapper/1

I suspect I need to tell the MMU about the Sonic. But I don't know how. I'm
also a little confused about whether I need to worry about physical/virtual
address mapping. Any help would be appreciated.

Thanks
 Dean Dayton - dean@aiinet.com

PS: Are there any good HOWTO/guides to writing device drivers on a LinuxPPC
port?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
