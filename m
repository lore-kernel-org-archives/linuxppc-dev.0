Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 29C8D67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 01:37:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 5 Apr 2005 10:37:52 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859335@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've been running into the old problem of the kernel ip stack crasheing
the kernel, because of early packets again.

This has been mentioned on this list several times before, but the
worarounds that used to work doesn't seem to work anymore.
(like changing the order of things in ip_init())

As far as I can tell, it is because the FCC enet drivers starts to
receive packets way before the ip stack is initialized.

Does anybody have any good ideas on how to fix this?

Kernel: 2.6.12-rc2 on a MPC8265
I can almost reliably recreate this by flood-pinging the board while the
kernel is booting.


The crach is as follows:
eth0: FCC ENET Version 0.3, 00:30:d7:00:01:08
eth1: FCC ENET Version 0.3, 00:30:d7:00:01:09
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: A0141440 LR: A012ACA0 SP: AFFB1D80 REGS: affb1cd0 TRAP: 0300    Not
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 20000000
TASK =3D afde5ae0[1] 'swapper' THREAD: affb0000
Last syscall: 120
GPR00: 00000000 AFFB1D80 AFDE5AE0 A07069E0 AFF44000 A01E2C04 00001032
00000002
GPR08: A01E2C04 A0200000 AFFB0000 00000000 8010C082 000000B1 10000000
007FFF1E
GPR16: 00000000 00000001 007FFF00 0FFFA6F0 00000000 FFFFFFFF 00000003
0FFA0BD0
GPR24: 00000000 FFFB72C3 A01E1324 00000040 AFFB1DF8 A07069E0 A07069E0
A07069E0
Call trace: [a012aca0]  [a012ae58]  [a012afd8]  [a001b30c]  [a001b374]
[a001b464]  [a0005a60]  [a000480c]  [a01fcfcc]  [a01fd2bc]
[a01fddd0]  [a01ec718]  [a01ec7d8]  [a0003a20]  [a0006b44]
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..

Call trace:
$ call2sym
Ready for call trace list.  <ctrl-d> on a blank line when done.

[A0141440] [a012aca0]  [a012ae58]  [a012afd8]  [a001b30c]  [a001b374]
[a001b464]  [a0005a60]  [a000480c]  [a01fcfcc]  [a01fd2bc]
[a01fddd0]  [a01ec718]  [a01ec7d8]  [a0003a20]  [a0006b44]

Processing...

Address         Function

A0141440        ip_rcv
a012aca0        netif_receive_skb
a012ae58        process_backlog
a012afd8        net_rx_action
a001b30c        __do_softirq
a001b374        do_softirq
a001b464        irq_exit
a0005a60        do_IRQ
a000480c        ret_from_except
a01fcfcc        ip_rt_init
a01fd2bc        ip_init
a01ec718        do_initcalls
a01ec7d8        do_basic_setup
a0003a20        init
a0006b44        kernel_thread
[runet@pib linux-innsys]$

Gdb list of excact line=20

(gdb) list *0xA0141440
0xa0141440 is in ip_rcv (net/ipv4/ip_input.c:370).
365              * that it receives, do not try to analyse it.
366              */
367             if (skb->pkt_type =3D=3D PACKET_OTHERHOST)
368                     goto drop;
369
370             IP_INC_STATS_BH(IPSTATS_MIB_INRECEIVES);
371
372             if ((skb =3D skb_share_check(skb, GFP_ATOMIC)) =3D=3D =
NULL) {
373                     IP_INC_STATS_BH(IPSTATS_MIB_INDISCARDS);
374                     goto out;

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com
