Message-ID: <20040302185407.37614.qmail@web20726.mail.yahoo.com>
Date: Tue, 2 Mar 2004 10:54:07 -0800 (PST)
From: Shawn Jin <shawnxtech@yahoo.com>
Subject: breakpoints cause oops
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a custom MPC8245 board and have linux running on the board. When
trying to debug the kernel using BDI+GDB, I have some problems on
breakpoints. Each time a breakpoint is reached, an oops message is
generated and gdb never gets the control.

What I did is set a breakpoint at 'sys_sync'. So each time the shell
command 'sync' is executed, the kernel should stop at the breakpoint. But
it only generates an oops message. The decoded oops is as follows.

Do you have any idea why this occurs? There may be still some bugs in the
kernel I ported. Is it related to memory, or stack allocation? Any help is
greatly appreciated.

Oops: Exception in kernel mode, sig: 5
NIP: C003C040 XER: 00000000 LR: C0005C5C SP: C77BDF30 REGS: c77bde80 TRAP:
0700
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c77bc000[226] 'sync' Last syscall: 36
last math c77bc000 last altivec 00000000
GPR00: C0005C5C C77BDF30 C77BC000 00000001 7FFFFBD4 10002198 10002174
100021A0
GPR08: 100021A4 C77BDF50 C003C034 28000004 48000004 1001A768 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 077BDF40 00000000
C0005E90
GPR24: C0005C00 10002060 300251CC 00000001 7FFFFBD4 10000000 0FFE8714
7FFFFC28
Call backtrace:
10000000 C0005C5C 10000C68 0FECFF70 00000000
Warning (Oops_read): Code line not seen, dumping what data is available


>>???; c003c040 <sync_dev+c/48>   <=====

>>GPR0; c0005c5c <set_context+2640/288c>
>>GPR10; c003c034 <sync_dev+0/48>
>>GPR23; c0005e90 <set_context+2874/288c>
>>GPR24; c0005c00 <set_context+25e4/288c>

Trace; 10000000 Before first symbol
Trace; c0005c5c <set_context+2640/288c>
Trace; 10000c68 Before first symbol
Trace; 0fecff70 Before first symbol
Trace; 00000000 Before first symbol

-Shawn.

Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
