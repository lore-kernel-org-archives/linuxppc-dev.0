Return-Path: <marcin.dawidowicz@kontron.pl>
Received: from postoffice.rnd.kontron.pl (unknown [217.153.25.242])
	by ozlabs.org (Postfix) with ESMTP id 7B4E52BF0B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Dec 2004 00:36:19 +1100 (EST)
Received: from linux.site (unknown [192.168.3.180])
	by postoffice.rnd.kontron.pl (Postfix) with ESMTP id 505FB3177
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 14:07:55 +0100 (CET)
From: Marcin Dawidowicz <marcin.dawidowicz@kontron.pl>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 14 Dec 2004 14:12:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200412141412.14616.marcin.dawidowicz@kontron.pl>
Subject: IBM750CXe 600MHz problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings all,

I have two boards that are very similar. They base on IBM750cx/cxe processor 
and XPC107A bridge/memory controller. Both are initialized in the same manner 
(the same bootloader).

One of them has IBM750cx 400MHz (PVR: 0x0008 2214) on that one everything 
works fine.

The other one has IBM750cxe 600MHz (PVR: 0x0008 3311) and here I have some 
strange behavior.
PCI doesn't work fine if it uses memory mapped IO. If driver uses PIO instead 
of MMIO it works fine  - I observed such situation with ethernet driver for 
i82553 (eepro100.c). I thought, there should be no difference on PPC between 
memory and io-ports.
The other strange thing is problem with loading modules. On 600MHz version 
trying loading module cause system hangup or kernel stack overflow oops - 
like following:
......
Kernel stack overflow in process dfad8000, r1=dfad8390
NIP: C000DFE4 XER: 20000000 LR: C000D80C SP: DFAD8390 REGS: dfad82e0 TRAP: 
0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000033, DSISR: 40000000
TASK = dfad8000[25] 'insmod' Last syscall: 128
last math dfad8000 last altivec 00000000
GPR00: FFFFFFFF DFAD8390 DFAD8000 00000000 00000033 0000000B DFA19008 C000DFE4
GPR08: FFFFFFFF FFFFFFFF FFFFFFF7 FFFFFFFF 48004482 100B0AFC 00000000 00000000
GPR16: 00000000 00000001 00000003 00000000 00009032 1FAD8450 00000000 C0003E54
GPR24: 00000000 C0156120 00030001 DFAD8460 40000000 00000033 0000000B DFAD8460
Call backtrace:
DFE41040 C000D6B4 C0003E54 00000000 C000D6B4 C0003E54 4BFFFEEC
C000D6B4 C0003E54 00000000 C000D6B4 C0003E54 00000000 C000D6B4
C0003E54 00000000 C000D6B4 C0003E54 00000000 C000D6B4 C0003E54
00000000 C000D6B4 C0003E54 0FFEDF88 C000D6B4 C0003E54 00000000
C000D6B4 C0003E54 00000000 C000D6B4 C0003E54
Kernel panic: kernel stack overflow
 <0>Rebooting in 180 seconds..
......
The module has just module_init function that only returns value and empty  
module_cleanup function. 

Additionally, I've disabled in HID_0 some features (SGE = 0, SPD = 1, BTIC = 
0, BHT = 0) during processor setup but it didn't help.
Running system has HID_0 as 0x8090c200

Does anyone have any idea what the problem may be? Thanks in advance for any 
suggestions.

Marcin
