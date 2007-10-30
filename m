Return-Path: <torsten.demke@motorola.com>
Received: from mail153.messagelabs.com (mail153.messagelabs.com
	[216.82.253.51]) by ozlabs.org (Postfix) with SMTP id E35EBDE366
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 04:28:16 +1100 (EST)
Received: from az33exr02.mot.com (az33exr02.mot.com [10.64.251.232])
	by motgate2.mot.com (8.12.11/Motorola) with ESMTP id l9UHSDHn022380
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 10:28:13 -0700 (MST)
Received: from az10vts01 (az10vts01.mot.com [10.64.251.242])
	by az33exr02.mot.com (8.13.1/Vontu) with SMTP id l9UHSCNF014614
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 12:28:13 -0500 (CDT)
Received: from zuk35exm60.ds.mot.com (zuk35exm60.ea.mot.com [10.178.4.13])
	by az33exr02.mot.com (8.13.1/8.13.0) with ESMTP id l9UHSBWe014601
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 12:28:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Gianfar skb panic when bonding a VLAN interface
Date: Tue, 30 Oct 2007 17:28:09 -0000
Message-ID: <67194FEE6056B947B4EF756C9E497A2E01DB237A@zuk35exm60.ds.mot.com>
From: "Demke Torsten-atd012" <torsten.demke@motorola.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I tried to ping over a bonded VLAN tagged interface.
(e.g  -> ifenslave bond0 eth3.24)

This fails with following output:
root@myBoard:/root> ping 192.168.24.101
PING 192.168.24.skb_under_panic: text:c01bbdf8 len:50 put:8
head:dd27a3a0 data:dd27a39a tail:dd27a3cc end:dd27a3e0 dev:eth3
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C01E9110 LR: C01E9110 SP: C03479F0 REGS: c0347940 TRAP: 0700
Tainted: PF   =20
MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK =3D c03031a0[0] 'swapper' THREAD: c0346000
Last syscall: 120=20
GPR00: C01E9110 C03479F0 C03031A0 00000072 00002D03 FFFFFFFF 00000030
00003FFF=20
GPR08: C037D0AC C0340000 FFFFFFFF 00000000 65F51C00 60000000 0FFE3900
C0347A7C=20
GPR16: DFC1FD60 C0347DD0 C0B94800 0FFF3D0C C0347A80 00000000 007FD890
00000000=20
GPR24: 00000000 C0A81865 C0A81805 00000000 C0B94800 DFC1FD60 C0B94A40
DF10C128=20
NIP [c01e9110] skb_under_panic+0x50/0x64
LR [c01e9110] skb_under_panic+0x50/0x64
Call trace:
 [c01bbe0c] gfar_add_fcb+0x7c/0xb4
 [c01bbfc0] gfar_start_xmit+0x160/0x268
 [c01ffffc] qdisc_restart+0x100/0x1fc
 [c01f04c4] dev_queue_xmit+0xc88/0xde0
 [c02a9684] vlan_dev_hwaccel_hard_start_xmit+0x9c/0xb0
 [c01f054c] dev_queue_xmit+0xd10/0xde0
 [c01afaa8] bond_dev_queue_xmit+0x2a8/0x2c4
 [c01b4464] bond_xmit_roundrobin+0x94/0x108
 [c01f054c] dev_queue_xmit+0xd10/0xde0
 [c022f6cc] arp_xmit+0x5c/0x6c
 [c022f704] arp_send+0x28/0x38
 [c022ef48] arp_solicit+0x1a0/0x1c0
 [c01f81b0] neigh_timer_handler+0x294/0x31c
 [c0043310] run_timer_softirq+0xa7c/0xaec
 [c0039b68] __do_softirq+0xabc/0x15a0
101 (192.168.24.Kernel panic - not syncing: Aiee, killing interrupt
handler!
101) 56(84) byte s of data.
Call trace:
 [c0008258] dump_stack+0x18/0x28
 [c002fa50] panic+0xa8/0x190
 [c0033690] do_exit+0x3c/0xdec
 [c0002fb4] _exception+0x0/0x1558
 [c0002ff0] _exception+0x3c/0x1558
 [c0004d70] ProgramCheckException+0x11c/0x1c4
 [c00029ac] ret_from_except_full+0x0/0x4c
 [c01e9110] skb_under_panic+0x50/0x64
 [c01bbe0c] gfar_add_fcb+0x7c/0xb4
 [c01bbfc0] gfar_start_xmit+0x160/0x268
 [c01ffffc] qdisc_restart+0x100/0x1fc
 [c01f04c4] dev_queue_xmit+0xc88/0xde0
 [c02a9684] vlan_dev_hwaccel_hard_start_xmit+0x9c/0xb0
 [c01f054c] dev_queue_xmit+0xd10/0xde0
 [c01afaa8] bond_dev_queue_xmit+0x2a8/0x2c4
Rebooting in 180 seconds..

It seems that the skb headroom is to small. How can I solve this?
I could insert skb_realloc_headroom() call, but where it's the best
place then?
What about alignement?


Regards,
Torsten
