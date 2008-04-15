Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEAE7DDF25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 07:33:43 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JlsmY-0005in-MS
	for linuxppc-embedded@ozlabs.org; Tue, 15 Apr 2008 14:33:38 -0700
Message-ID: <16711066.post@talk.nabble.com>
Date: Tue, 15 Apr 2008 14:33:38 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: XLlTemac  soft lockup BUG
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I am trying to switch my design from the PLB Temac to the local link temac,
and i have a problem when trying to run ifconfig in my init script.  It
gives me a BUG: soft lockup - CPU#0 stuck for 11s! [ifconfig:208]
Here is the rest of the dump, thanks for your help in advance.
[  233.114960] eth0: XLlTemac: Options: 0x3fa

[  233.118449] eth0: XLlTemac: allocating interrupt 8 for fifo mode.

[  237.135029] eth0: XLlTemac: We renegotiated the speed to: 100

[  237.150339] eth0: XLlTemac: speed set to 100Mb/s

[  244.792140] BUG: soft lockup - CPU#0 stuck for 11s! [ifconfig:204]

[  244.797813] NIP: c0188a5c LR: c012d3d0 CTR: c016c3f8

[  244.803533] REGS: ceb1fbf0 TRAP: 1001   Not tainted  (2.6.24-rc8-xlnx)

[  244.811039] MSR: 00029030 <EE,ME,IR,DR>  CR: 22000444  XER: 20000000

[  244.818363] TASK = cf82f7f0[204] 'ifconfig' THREAD: ceb1e000

[  244.824673] GPR00: cebca800 ceb1fca0 cf82f7f0 cebc84a0 cf86c000 00000010
cebc8520 00000000 

[  244.834297] GPR08: 00000000 00000040 cebc84a0 00000001 c0248780 

[  244.841416] NIP [c0188a5c] eth_type_trans+0x10/0x114

[  244.847132] LR [c012d3d0] FifoRecvHandler+0x154/0x1dc

[  244.852945] Call Trace:

[  244.855758] [ceb1fca0] [c012d368] FifoRecvHandler+0xec/0x1dc (unreliable)

[  244.863579] [ceb1fcc0] [c0023b4c] tasklet_action+0x88/0xe4

[  244.869894] [ceb1fcd0] [c0023c20] __do_softirq+0x64/0xd4

[  244.876010] [ceb1fcf0] [c00064f4] do_softirq+0x40/0x58

[  244.881925] [ceb1fd00] [c0023a50] irq_exit+0x38/0x48

[  244.887640] [ceb1fd10] [c000673c] do_IRQ+0x88/0xa4

[  244.893154] [ceb1fd20] [c000325c] ret_from_except+0x0/0x18

[  244.899470] [ceb1fde0] [c0130804] xenet_open+0x24c/0x41c

[  244.905586] [ceb1fe10] [c017aa60] dev_open+0x88/0xf0

[  244.911300] [ceb1fe20] [c017a904] dev_change_flags+0xcc/0x1a0

[  244.917917] [ceb1fe40] [c01b9110] devinet_ioctl+0x298/0x6c0

[  244.924334] [ceb1fea0] [c01b965c] inet_ioctl+0xd0/0x104

[  244.930349] [ceb1feb0] [c016d12c] sock_ioctl+0x22c/0x268

[  244.936465] [ceb1fed0] [c006eb78] do_ioctl+0x38/0x84

[  244.942179] [ceb1fee0] [c006ef48] vfs_ioctl+0x384/0x3b8

[  244.948195] [ceb1ff10] [c006efbc] sys_ioctl+0x40/0x70

[  244.954010] [ceb1ff40] [c0002c10] ret_from_syscall+0x0/0x3c

[  244.960423] Instruction dump:

[  244.963832] 7d005379 3863012c 41820010 7d2534aa 7d2335aa 38c00000
7cc33378 4e800020 

[  244.972752] 81230054 80030090 2b89000d 7c6a1b78 <90030080> 90830018
409d002c 80030058 
-- 
View this message in context: http://www.nabble.com/XLlTemac--soft-lockup-BUG-tp16711066p16711066.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
