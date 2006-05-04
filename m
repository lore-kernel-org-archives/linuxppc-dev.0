Return-Path: <gautam@eisodus.com>
Received: from smtp1.iitb.ac.in (smtp1.iitb.ac.in [59.163.25.49])
	by ozlabs.org (Postfix) with SMTP id 8B2E567B1C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 17:44:16 +1000 (EST)
Message-ID: <4459B1CF.60909@eisodus.com>
Date: Thu, 04 May 2006 13:18:31 +0530
From: Gautam Borad <gautam@eisodus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: frequent sig 11 with malloc() on mpc8xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are having a frequent sig 11 problem on our custom mpc852t board
with linux kernel 2.6.14 and U-boot version 1.1.3
We have 32MB SDRAM.
I've written a test program that mallocs( 10k chunks ) and then zeros 
out the area
using bzero().This is repeated 1000 times.
The program crashes with a sig 11.
Given below is the dump of the crash :

$ free
                    total         used            free       shared      
buffers
Mem:        29988         3040        26948            0            0
Swap:               0               0                0
Total:        29988         3040        26948

$ ./malloctest 10
i=0  malloc'ed : 10k  at 0x10012010
i=1  malloc'ed : 10k  at 0x10014818
i=2  malloc'ed : 10k  at 0x10017020
........
i=222  malloc'ed : 10k  at 0x1023d700
i=223  malloc'ed : 10k  at 0x1023ff08
i=224  malloc'ed : 10Oops: kernel access of bad area, sig: 11 [#1]
NIP: C005AC48 LR: C005B158 SP: C1DB9EC0 REGS: c1db9e10 TRAP: 0300    Not 
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000000C8, DSISR: C0000000
TASK = c1d71bb0[651] 'malloctest' THREAD: c1db8000
Last syscall: 4
GPR00: C005B158 C1DB9EC0 C1D71BB0 00000001 00000000 C1DB9F20 00000003 
00000000
GPR08: 00000000 C1C34468 00000003 00000000 00000003 2EEDBEFB 01FFF000 
007FFF40
GPR16: 00000000 00000001 FFFFFFFF 7FB1BAA0 00000000 10068FDC 7FB1BAB8 
00000000
GPR24: 10000694 10000A48 7FC4EB30 C1DB9F20 30096288 00000003 C030EE88 
00000000
NIP [c005ac48] rw_verify_area+0x50/0xbc
LR [c005b158] vfs_write+0x94/0x1a0
Call trace:
 [c005b158] vfs_write+0x94/0x1a0
 [c005b348] sys_write+0x50/0x94
 [c0002b90] ret_from_syscall+0x0/0x44
k  at 0x10242710
i=225  malloc'ed : 10k  at 0x10244f18
i=226  malloc'ed : 10k  at 0x10247720
i=227  malloc'ed : 10k  at 0x102Oops: kernel access of bad area, sig: 11 
[#2]
NIP: C004E54C LR: C004E614 SP: C1DB9CF0 REGS: c1db9c40 TRAP: 0300    Not 
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000001A0, DSISR: C0000000
TASK = c1d71bb0[651] 'malloctest' THREAD: c1db8000
Last syscall: 4
GPR00: 000001A0 C1DB9CF0 C1D71BB0 C0228BAC C030E348 C022AF04 C1DA4174 
00000000
GPR08: 00000000 00000000 C0228BAC C1C34CBC 80004022 2EEDBEFB 01FFF000 
007FFF40
GPR16: 00000000 00000001 FFFFFFFF 7FB1BAA0 00000000 10068FDC 7FB1BAB8 
00000000
GPR24: 10000694 10000A48 7FC4EB30 0000000B C022AF34 C022AF04 C030E348 
C0228BAC
NIP [c004e54c] __remove_shared_vm_struct+0x28/0x94
LR [c004e614] remove_vm_struct+0x5c/0xd0
Call trace:
 [c004e614] remove_vm_struct+0x5c/0xd0
 [c0050adc] exit_mmap+0x11c/0x148
 [c000f9b8] mmput+0x54/0xd0
 [c00141cc] exit_mm+0x190/0x1f0
 [c0014b40] do_exit+0xec/0x3c8
 [c00035b0] _exception+0x0/0xc8
 [c000a47c] bad_page_fault+0x5c/0x60
 [c00030e0] handle_page_fault+0x7c/0x80
 [c022fa68] sysfs_init+0x34/0xd4
 [c005b158] vfs_write+0x94/0x1a0
 [c005b348] sys_write+0x50/0x94
 [c0002b90] ret_from_syscall+0x0/0x44

However if i call free() after bzero() i dont get the sig 11.
I had the same problem with 2.4 kernel and after posting the problem 
here, was asked to move to 2.6 kernel.
I've done so but the problem persists.

Thanking in advance.
