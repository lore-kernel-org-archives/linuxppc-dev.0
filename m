Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 0F601DE41B
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 05:23:34 +1000 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	3234435069
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 15:23:30 -0400 (EDT)
Received: from thinkcentre (cpe-67-9-156-46.austin.res.rr.com [67.9.156.46])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPA id
	D284435068 for
	<linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 15:23:29 -0400 (EDT)
Date: Thu, 24 Jul 2008 14:23:00 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: lockdep badness
Message-ID: <20080724192300.GE9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm seeing warnings from the lockdep code itself in recent kernels on
a Power6 blade (v2.6.26 and benh's -next branch).

Something to do with powerpc's "lazy" interrupt-disabling, perhaps?

A couple of stack traces below, the first is from benh's tree, the
second is from 2.6.26.  The lockdep self-tests all pass at boot.

RTAS daemon started
RTAS: event: 295, Type: Dump Notification Event, Severity: 2
------------[ cut here ]------------
Badness at kernel/lockdep.c:2719
NIP: c0000000000b06dc LR: c0000000000b06c0 CTR: 0000000000000000
REGS: c0000000e787b9a0 TRAP: 0700   Not tainted  (2.6.26)
MSR: 8000000000029032 <EE,ME,IR,DR>  CR: 24000042  XER: 20000000
TASK = c0000000e91a6100[428] 'rtasd' THREAD: c0000000e7878000 CPU: 1
GPR00: 0000000000000000 c0000000e787bc20 c000000000a71270 0000000000000001 
GPR04: 0000000000000001 c00000000004d648 0000040100000000 0000040100000000 
GPR08: 0000000000000000 c000000000f1f858 0000000000000020 0000000000000001 
GPR12: 0000000000010000 c000000000aac600 00000000002146f4 0000000000214744 
GPR16: 4000000002040000 00000000029015b0 00000000002a3c00 c0000000008cc988 
GPR20: 0000000002901598 0000000000000000 0000000000000124 0000000000000002 
GPR24: 0000000000000001 0000000000000008 0000000000000001 c0000000009fdf00 
GPR28: c00000000004d648 c000000000943e98 c0000000009d9b40 c0000000e787bc20 
NIP [c0000000000b06dc] .check_flags+0x9c/0x174
LR [c0000000000b06c0] .check_flags+0x80/0x174
Call Trace:
[c0000000e787bc20] [c0000000e787bc70] 0xc0000000e787bc70 (unreliable)
[c0000000e787bca0] [c0000000000b5ac8] .lock_release+0x7c/0x208
[c0000000e787bd50] [c0000000005e12c0] ._spin_unlock_irqrestore+0x34/0x94
[c0000000e787bde0] [c00000000004d648] .pSeries_log_error+0x380/0x3f0
[c0000000e787bef0] [c00000000004d8e4] .rtasd+0x98/0x100
[c0000000e787bf90] [c000000000029d20] .kernel_thread+0x4c/0x68
Instruction dump:
e92d01b0 80090904 2f800000 40be002c 481ece4d 60000000 2fa30000 419e00c4 
e93e80c0 80090000 2f800000 409e00b4 <0fe00000> 480000ac 78290464 80090014 
possible reason: unannotated irqs-on.
irq event stamp: 20
hardirqs last  enabled at (19): [<c0000000000b405c>] .trace_hardirqs_on+0x1c/0x3
0
hardirqs last disabled at (20): [<c0000000000b0d80>] .trace_hardirqs_off+0x1c/0x
30
softirqs last  enabled at (0): [<c00000000008293c>] .copy_process+0x3c8/0x1040
softirqs last disabled at (0): [<0000000000000000>] 0x0

===============

ipr: IBM Power RAID SCSI Device Driver version: 2.4.1 (April 24, 2007)
ipr 0000:00:01.0: Found IOA with IRQ: 289
ipr 0000:00:01.0: Starting IOA initialization sequence.
ipr 0000:00:01.0: Adapter firmware version: 02200023
ipr 0000:00:01.0: IOA initialized.
------------[ cut here ]------------
Badness at kernel/lockdep.c:2037
NIP: c0000000000b29fc LR: c0000000000b29e0 CTR: 0000000000000000
REGS: c00000000fffb890 TRAP: 0700   Not tainted  (2.6.26)
MSR: 8000000000021032 <ME,IR,DR>  CR: 28000022  XER: 00000004
TASK = c000000000996730[0] 'swapper' THREAD: c000000000a60000 CPU: 0
GPR00: 0000000000000000 c00000000fffbb10 c000000000a61ad8 0000000000000001 
GPR04: 0000000000035112 c000000000426708 0000000000000000 0000000000000970 
GPR08: 0000000000000000 c000000000ec6ad0 0000000000000001 0000000000000001 
GPR12: 0000000000043bd8 c000000000a9d400 00000000002146f4 0000000000214744 
GPR16: 4000000002040000 00000000028f37a8 00000000002a3c00 c0000000008b3790 
GPR20: 00000000028f3790 0000000001a3f920 c0000000008b37a8 c0000000e6252000 
GPR24: c0000000e6454a48 0000000000100100 0000000000200200 c0000000005d8824 
GPR28: c000000000afba18 c000000000996730 c0000000009cb7f0 c00000000fffbb10 
NIP [c0000000000b29fc] .trace_hardirqs_on+0x120/0x1b0
LR [c0000000000b29e0] .trace_hardirqs_on+0x104/0x1b0
Call Trace:
[c00000000fffbb10] [c00000000fffbbb0] 0xc00000000fffbbb0 (unreliable)
[c00000000fffbbb0] [c0000000005d8824] ._spin_unlock_irq+0x40/0x68
[c00000000fffbc40] [c000000000426708] .ipr_ioa_reset_done+0x218/0x2ac
[c00000000fffbd00] [c00000000041bdb8] .ipr_reset_ioa_job+0xc8/0xf4
[c00000000fffbd90] [c000000000424ffc] .ipr_isr+0x280/0x628
[c00000000fffbe50] [c0000000000ccc70] .handle_IRQ_event+0x58/0xd4
[c00000000fffbef0] [c0000000000cef4c] .handle_fasteoi_irq+0x128/0x1c8
[c00000000fffbf90] [c000000000029918] .call_handle_irq+0x1c/0x2c
[c000000000a63a20] [c00000000000d9cc] .do_IRQ+0x138/0x248
[c000000000a63ad0] [c000000000004ca8] hardware_interrupt_entry+0x28/0x2c
--- Exception: 501 at .raw_local_irq_restore+0x8c/0xa4
    LR = .cpu_idle+0x140/0x210
[c000000000a63e60] [c0000000005da07c] .rest_init+0x7c/0x98
[c000000000a63ee0] [c000000000866f10] .start_kernel+0x488/0x4b0
[c000000000a63f90] [c000000000008584] .start_here_common+0x4c/0xc8
Instruction dump:
e92d01b0 80090954 2f800000 41be002c 481e61fd 60000000 2fa30000 419e0080 
e93e80c0 80090000 2f800000 409e0070 <0fe00000> 48000068 7fa3eb78 38800001 
scsi0 : IBM 572C Storage Adapter
scsi 0:3:0:0: Direct-Access     IBM-ESXS ST973402SS       B522 PQ: 0 ANSI: 5
