Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 580781007D3
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 14:13:22 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bounces@nabble.com>) id 1Qgqp5-0008Vz-5w
	for linuxppc-dev@ozlabs.org; Tue, 12 Jul 2011 21:13:19 -0700
Message-ID: <32050889.post@talk.nabble.com>
Date: Tue, 12 Jul 2011 21:13:19 -0700 (PDT)
From: ps2k <ps2kumar@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: MPC8360RDK: Badness at kernel/softirq.c:122
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,
When we are writing to the flash while data traffic is on we do see the
target rebooting with the following messages. Could some body please explain
what's going on here?

Any help is greatly appreciated.

Regards
psk

Call Trace:"
LR [c0005ea4] do_softirq+0x58/0x5c"
Badness at c0051360 [verbose debug info unavailable]"
NIP [c0051360] _local_bh_enable+0x40/0x84"
TASK = d772d430[1343] 'cp' THREAD: dc916000"
MSR: 00021032 <ME,IR,DR>  CR: 44242482  XER: 20000000"
REGS: dc916860 TRAP: 0700   Not tainted  (2.6.24-pwn-0.5.0.XXXX)"
NIP: c0051360 LR: c0005ea4 CTR: c01c0098"
------------[ cut here ]------------"

----------------------------------------

[d715c900] [c00060c0] do_softirq+0x58/0x5c"
Badness at net/core/skbuff.c:317"
[d715c8e0] [c0052670] __do_softirq+0x84/0xf8"
[d715c8c0] [c01c36fc] net_tx_action+0x84/0x17c"
[d715c8b0] [c01b9b2c] __kfree_skb+0x18/0xe8"
[d715c8a0] [0000012c] 0x12c (unreliable)"
Call Trace:"
LR [c01b9b2c] __kfree_skb+0x18/0xe8"
NIP [c01ba584] skb_release_all+0x68/0x124"
TASK = dc54c850[856] 'cp' THREAD: d715c000"
MSR: 00029032 <EE,ME,IR,DR>  CR: 24242488  XER: 20000000"
REGS: d715c7f0 TRAP: 0700   Not tainted  (2.6.24-pwn-0.5.0.XXXX)"
NIP: c01ba584 LR: c01b9b2c CTR: c01c3678"
------------[ cut here ]------------"


-----------------------

Badness at kernel/softirq.c:122"
Call Trace:"
LR [c00060c0] do_softirq+0x58/0x5c"
NIP [c0051f78] _local_bh_enable+0x40/0x84"
TASK = dc5587d0[1763] 'cp' THREAD: dc7ee000"
MSR: 00021032 <ME,IR,DR>  CR: 44242482  XER: 00000000"
REGS: dc7ee850 TRAP: 0700   Not tainted  (2.6.24-pwn-0.5.0.XXXX)"
NIP: c0051f78 LR: c00060c0 CTR: c0062040"
------------[ cut here ]------------"


-------------------------
Badness at kernel/softirq.c:122"
[d7114930] [c001108c] ret_from_except+0x0/0x14"
[d7114920] [c00065d4] do_IRQ+0xa8/0xc8"
[d7114910] [c0052190] irq_exit+0x60/0x80"
[d7114900] [c00060c0] do_softirq+0x58/0x5c (unreliable)"
Call Trace:"
LR [c00060c0] do_softirq+0x58/0x5c"
NIP [c0051f78] _local_bh_enable+0x40/0x84"
TASK = dc01c430[2468] 'cp' THREAD: d7114000"
MSR: 00021032 <ME,IR,DR>  CR: 44242482  XER: 20000000"
REGS: d7114850 TRAP: 0700   Tainted: G      D  (2.6.24-pwn-0.5.0.XXXX)"
NIP: c0051f78 LR: c00060c0 CTR: c016b7f4"
------------[ cut here ]------------"
-- 
View this message in context: http://old.nabble.com/MPC8360RDK%3A-Badness-at-kernel-softirq.c%3A122-tp32050889p32050889.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
