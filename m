Message-ID: <386BF7B4.7DF02BEE@uswest.net>
Date: Thu, 30 Dec 1999 16:24:20 -0800
From: David Clear <davidc@uswest.net>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Alan Mimms <alanm@unforgettable.com>, linuxppc-embedded@lists.linuxppc.org,
        dclear@uswest.net
Subject: Re: Embedded planet 860T CLLF HELP!
References: <19991230.21564500@alanm.penguinpowered.com> <386BDEF1.8421A130@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

Thanks for your help.  I followed a different path to Alan, and came up
with different failures.

I ran 'make config' to set up the RPX CLLF.  The kernel built fine, but
then I found I had to edit the Makefile to make it build coffboot and
then mbxboot.  That gave me a zImage file that I could convert into
zi.cllf.

I got this to boot - it mounted its NFS filesystem fine.  But after a
while (typing ls -lR usually does the trick) it crashes with things like:

NIP: A000FD38 XER: A000FD39 LR: A000FD39 REGS: c0dc5cd0 TRAP: 0400
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0dc4000[7] 'ls' mm->pgd c0dc3000 Last syscall: 4
last math 00000000
GPR00: A000FD39 C0DC5D80 C0DC4000 00009032 00000000 00000002 00000020
C00BFC90
GPR08: 00000020 00000000 00000000 C0DC5D80 39000030 00254D6C C012B8A8
00000043
GPR16: FFF29664 00000000 0000003D 3000D000 C01E8BE8 C01F1B54 C009B7C8
3000D000
GPR24: C0DC5DD8 C0DC5DD8 C01E9060 C01E8000 00000FF0 00009032 20203139
00000000
Call backtrace:
A000FD39 C000CA7C C009B9FC C0096E58 C0025174 C00022D8 FFFFFFFF
3009D660 3009D9AC 3009E398 00204704 00203504 0020185C 002012B8
Kernel panic: kernel access of bad area pc a000fd38 lr a000fd39 address
A000FD38
 tsk ls/7

and

NIP: C0006AC4 XER: A000FD39 LR: C00A90D8 REGS: c0dc5a90 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0dc4000[13] 'ls' mm->pgd c0dc3000 Last syscall: 90
last math 00000000
GPR00: 00036150 C0DC5B40 C0DC4000 00000070 00000000 C0DC5BD0 C01F2920
00000000
GPR08: FA200000 00000129 00000000 FA200A00 95500033 00254D6C C012B8A8
00000043
GPR16: FFF29664 00000000 00000004 00000000 00001032 00DC5BC0 00000000
C0002544
GPR24: C00043A4 C01F26E8 00000000 00000002 C00CCC74 FA202890 00000000
C0135260
Scheduling in interrupt
page fault in interrupt handler, addr=0
NIP: C000CBF8 XER: 8000FD39 LR: C000CBF8 REGS: c0dc5950 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0dc4000[13] 'ls' mm->pgd c0dc3000 Last syscall: 90
last math 00000000
GPR00: C000CBF8 C0DC5A00 C0DC4000 00000018 00000001 00000018 C0138720
FA202830
GPR08: 00000018 C00E0000 FA202838 C0DC5940 0000000D 00254D6C C012B8A8
00000043
GPR16: FFF29664 00000000 00000004 00000000 00009032 00DC5A80 00000000
C0002544
GPR24: C00090F8 C01F26E8 C0DC5A38 C0DC5A38 C00D0000 00000000 00000000
C0DC5A00
Scheduling in interrupt
... forever.

Anyhow, I've pulled your CLLF sources and am trying it now.

Thanks for your help.

David.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
