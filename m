MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: FCC ethernets not stable
Date: Fri, 18 Jun 2004 10:56:55 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB0A@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have notices that the FCC ethernet driver on 2.6.7 (linuxppc-2.5) is
not completely stable.
Once in a while I get a kernel oops when the driver starts.

Never had the problem on 2.6.5 and older.

CPM UART driver version 0.02
ttyS0 on SMC1 at 0x0000, BRG7
eth0: FCC ENET Version 0.3, 00:30:d7:00:01:09
eth1: FCC ENET Version 0.3, 00:30:d7:00:01:0a
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C015045C LR: C013C2A0 SP: DFF3DDA0 REGS: dff3dcf0 TRAP: 0300    Not
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 20000000
TASK = dff3f900[1] 'swapper' THREAD: dff3c000Last syscall: 120
GPR00: 00000000 DFF3DDA0 DFF3F900 C07B79E0 C076CC00 C01F3B0C 00001032
00000002
GPR08: C01F3B0C C0240000 DFF3C000 00000000 8010C082 1001D584 0FFCF000
007FFF74
GPR16: 00000000 00000001 007FFF00 0FFC9824 00000000 FFFFFFFF 00000002
0FF67BD0
GPR24: 00000000 FFFB7465 C01F24E0 00000040 DFF3DE18 C07B79E0 C07B79E0
C07B79E0
Call trace: [c013c2a0]  [c013c3ec]  [c013c56c]  [c001c4f4]  [c001c550]
[c00079d4]  [c000616c]  [c020c6e0]  [c020d0c0]  [c01fc62c]
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..


The call trace resolves to:
Address         Function

c013c2a0        netif_receive_skb
c013c3ec        process_backlog
c013c56c        net_rx_action
c001c4f4        __do_softirq
c001c550        do_softirq
c00079d4        do_IRQ
c000616c        ret_from_except
c020c6e0        tcp_init
c020d0c0        inet_init
c01fc62c        do_initcalls


Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
