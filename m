Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 343E9B7BBB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 04:32:45 +1100 (EST)
Received: from crust.elkhashab.com ([24.28.25.36])
	by hrndva-omta02.mail.rr.com with ESMTP
	id <20091027172738886.YTRI24001@hrndva-omta02.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2009 17:27:41 +0000
Received: from [192.168.1.20] (millhouse.elkhashab.com [192.168.1.20])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	n9RHRYsQ019170
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2009 12:27:34 -0500
Message-ID: <4AE72D83.7000404@elkhashab.com>
Date: Tue, 27 Oct 2009 12:27:31 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: help with unhandled IRQ error with mpt2sas driver and powerpc 460EX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, I am using the mpt2sas driver on the canyonlands / 460EX board.  
I've already found and fixed one problem, but can't get past the 
unhandled IRQ.

The first problem I noticed is that the physical address is read into a 
32 bit variable, but the 460ex has a 36 bit bus so the ioremap would 
always fail.  I've change the defn of chip_phys in mpt2sas_base.h to u64 
and that cleared up that issue.   As soon as the unmask_interrupts 
method is called (or not long after), I get an interrupt -- presumably 
from the sas controller.  If I comment out the unmask, the interrupt 
never occurs.  If I unmask them, I get the interrupt.  I've traced the 
code through the interrupt handler all the way to ~ line 757.

 rpf = &ioc->reply_post_free[ioc->reply_post_host_index];

I've verified that at the end of this, IRQ_NONE is returned.  At this 
point the kernel prints the following -- the last statements lead me to 
think that the sas controller expected something but never got it.  I am 
unsure how to proceed at this point.  I am using a denx kernel head 
pulled from git today since there were some changes to thsi driver for 
endian issues.

irq 18: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[c0367df0] [c0005eac] show_stack+0x44/0x16c (unreliable)
[c0367e30] [c004eedc] __report_bad_irq+0x34/0xb8
[c0367e50] [c004f118] note_interrupt+0x1b8/0x224
[c0367e80] [c004ff50] handle_level_irq+0xa0/0x11c
[c0367e90] [c0018ba4] uic_irq_cascade+0xf8/0x12c
[c0367eb0] [c00041d0] do_IRQ+0x98/0xb4
[c0367ed0] [c000df40] ret_from_except+0x0/0x18
[c0367f90] [c0006ed8] cpu_idle+0x50/0xd8
[c0367fb0] [c000197c] rest_init+0x5c/0x70
[c0367fc0] [c0320848] start_kernel+0x224/0x2a0
[c0367ff0] [c0000200] skpinv+0x190/0x1cc
handlers:
[<c01aba98>] (_base_interrupt+0x0/0x8f8)
Disabling IRQ #18
mpt2sas0: _base_event_notification: timeout
mf:
        07000000 00000000 00000000 00000000 00000000 0f2f3fff fffffffc 
ffffffff
        ffffffff 00000000 00000000
mpt2sas0: sending diag reset !!
mpt2sas0: diag reset: SUCCESS
mpt2sas0: failure at 
drivers/scsi/mpt2sas/mpt2sas_scsih.c:5989/_scsih_probe()!

Thanks
Ayman
