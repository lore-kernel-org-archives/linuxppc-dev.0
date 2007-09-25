Return-Path: <nmx@fromtheshadows.net>
Received: from alnrmhc14.comcast.net (alnrmhc14.comcast.net [204.127.225.94])
	by ozlabs.org (Postfix) with ESMTP id 5D15CDDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 03:07:07 +1000 (EST)
Message-ID: <46F93E7A.4070306@fromtheshadows.net>
Date: Tue, 25 Sep 2007 12:59:38 -0400
From: Mike Nuss <nmx@fromtheshadows.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Book-E watchdog driver questions
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have a PPC440EPx and I am testing out the builtin watchdog. I have a
couple of questions:

Is there a reason that booke_wdt.c does not specify a MODULE_LICENSE?
>From the copyright notice at the top it appears to be GPL. As written,
it taints the kernel.

Also, if I test out the driver by killing my process that's doing the
pinging, I get a kernel panic:

 Bad trap at PC: c0009268, MSR: 29000, vector=1022    Tainted: P
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C0009268 LR: C00092C4 CTR: C002F6E4
REGS: c02d7f50 TRAP: 1022   Tainted: P        (2.6.21-rc4-ts-1-ppc)
MSR: 00029000 <EE,ME>  CR: 24D12582  XER: 00000000
TASK = c02809d0[0] 'swapper' THREAD: c029c000
GPR00: 00000000 C029DF90 C02809D0 00000000 C0008294 00000000 00072951
00000000
GPR08: 00002D0F C02D9800 22044288 00000000 00005196 00000000 0FFB2C00
00000001
GPR16: 007FFF23 00000000 00800000 FFFFFFFF 007FFF00 0FFAE6A0 00000000
00000001
GPR24: 00000000 007FFE70 C02D8000 C02D0000 C02E0000 C029C028 00000010
C029C000
NIP [C0009268] cpu_idle+0x64/0xd0
LR [C00092C4] cpu_idle+0xc0/0xd0
Call Trace:
[C029DF90] [C00092C4] cpu_idle+0xc0/0xd0 (unreliable)
[C029DFB0] [C00012B4] rest_init+0x28/0x38
[C029DFC0] [C029E720] start_kernel+0x220/0x29c
[C029DFF0] [C0000200] skpinv+0x1a8/0x1e4
Instruction dump:
38000010 7d20e828 7d290378 7d20e92d 40a2fff4 801f0028 393c9800 700b0008
40820064 80090030 3bc00010 2f800000 <419e0060> 7c00e828 7c00f078 7c00e92d
Bad trap at PC: c0003408, MSR: 21000, vector=1022    Tainted: P
Oops: Exception in kernel mode, sig: 5 [#2]
NIP: C0003408 LR: C0002100 CTR: 00000000
REGS: c02d7f50 TRAP: 1022   Tainted: P        (2.6.21-rc4-ts-1-ppc)
MSR: 00021000 <ME>  CR: 44D12522  XER: 00000000
TASK = c02809d0[0] 'swapper' THREAD: c029c000
GPR00: 08000000 C02D7DD0 C02809D0 C02D7DE0 00000001 00000001 00000000
00004000
GPR08: C02D0000 C0002100 00021002 C0003408 C0280B80 00000000 0FFB2C00
00000001
GPR16: 007FFF23 00000000 00800000 FFFFFFFF 007FFF00 0FFAE6A0 00000000
00000001
GPR24: 00000000 007FFE70 C02D8000 C02D0000 C02E0000 00000000 00000005
C02D7F50
NIP [C0003408] timer_interrupt+0x0/0x224
LR [C0002100] ret_from_except+0x0/0x18
Call Trace:
Instruction dump:
7d0b4378 7d635b78 4e800020 3d20c02d 800950bc 7c1603a6 7d4c42e6 3d20c02e
3d60c02d 9149f384 914b50b4 4e800020 <7c0802a6> 9421ffc0 be810010 90010044
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 seconds..Bad trap at PC: c00066b8, MSR: 21000,
vector=1022    Tainted: P
Oops: Exception in kernel mode, sig: 5 [#3]
NIP: C00066B8 LR: C0002100 CTR: 00033C76
REGS: c02d7f50 TRAP: 1022   Tainted: P        (2.6.21-rc4-ts-1-ppc)
MSR: 00021000 <ME>  CR: 44D12588  XER: 00000000
TASK = c02809d0[0] 'swapper' THREAD: c029c000
GPR00: 00182000 C02D7CF0 C02809D0 C02D7D00 00000001 00000001 00000000
00000030
GPR08: C02DB2E4 C0002100 00021002 C00066B8 C0280B80 00000000 0FFB2C00
00000001
GPR16: 007FFF23 00000000 00800000 FFFFFFFF 007FFF00 0FFAE6A0 00000000
00000001
GPR24: 00000000 007FFE70 C02D8000 C02D0000 00487AB0 00003311 C0290000
C02D0000
NIP [C00066B8] do_IRQ+0x0/0xb8
LR [C0002100] ret_from_except+0x0/0x18
Call Trace:
Instruction dump:
7fc3f378 3880000a 48073311 4bfffea0 3d20c024 38a97e9c 4bffff30 3c80c024
38847e84 7fc3f378 48073321 4bffff08 <7c0802a6> 9421fff0 90010014 bfc10008
Bad trap at PC: c00066b8, MSR: 21000, vector=1022    Tainted: P
Oops: Exception in kernel mode, sig: 5 [#4]
NIP: C00066B8 LR: C0002100 CTR: 00000000
REGS: c02d7f50 TRAP: 1022   Tainted: P        (2.6.21-rc4-ts-1-ppc)
MSR: 00021000 <ME>  CR: 44D12522  XER: 00000000
TASK = c02809d0[0] 'swapper' THREAD: c029c000
GPR00: C0002810 C02D7DD0 C02809D0 C02D7DE0 00000001 00000001 00000000
00004000
GPR08: C02D0000 C0002100 00021002 C00066B8 C0280B80 00000000 0FFB2C00
00000001
GPR16: 007FFF23 00000000 00800000 FFFFFFFF 007FFF00 0FFAE6A0 00000000
00000001
GPR24: 00000000 007FFE70 C02D8000 C02D0000 00487AB0 00000000 00000005
C02D7F50
NIP [C00066B8] do_IRQ+0x0/0xb8
LR [C0002100] ret_from_except+0x0/0x18
Call Trace:
Instruction dump:
7fc3f378 3880000a 48073311 4bfffea0 3d20c024 38a97e9c 4bffff30 3c80c024
38847e84 7fc3f378 48073321 4bffff08 <7c0802a6> 9421fff0 90010014 bfc10008
Bad trap at PC: c00066b8, MSR: 21000, vector=1022    Tainted: P
Oops: Exception in kernel mode, sig: 5 [#5]
NIP: C00066B8 LR: C0002100 CTR: 00000000
REGS: c02d7f50 TRAP: 1022   Tainted: P        (2.6.21-rc4-ts-1-ppc)
MSR: 00021000 <ME>  CR: 44D12522  XER: 00000000
TASK = c02809d0[0] 'swapper' THREAD: c029c000
GPR00: C0002810 C02D7DD0 C02809D0 C02D7DE0 00000001 00000001 00000000
00004000
GPR08: C02D0000 C0002100 00021002 C00066B8 C0280B80 00000000 0FFB2C00
00000001
GPR16: 007FFF23 00000000 00800000 FFFFFFFF 007FFF00 0FFAE6A0 00000000
00000001
GPR24: 00000000 007FFE70 C02D8000 C02D0000 00487AB0 00000000 00000005
C02D7F50
NIP [C00066B8] do_IRQ+0x0/0xb8
LR [C0002100] ret_from_except+0x0/0x18
Call Trace:
Instruction dump:
7fc3f378 3880000a 48073311 4bfffea0 3d20c024 38a97e9c 4bffff30 3c80c024
38847e84 7fc3f378 48073321 4bffff08 <7c0802a6> 9421fff0 90010014 bfc10008

This goes on for a while until it eventually reboots. Is that the
expected behavior?

Mike
