Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44898B6F6B
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jul 2011 00:19:55 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p65EJoHR012939
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Jul 2011 16:19:51 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@ozlabs.org
Subject: Analysing a kernel panic
Date: Tue, 5 Jul 2011 16:19:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201107051619.50548.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
one of my drivers is causing a kernel panic and I _think_ it happens in the 1st call to the interrupt routine.
What kind of information can I extract from the following ?
Is it like a core dump that I can load with the executable in the debugger to know exactly what happened (I doubt it) ?

Oops: Exception in kernel mode, sig: 4 [#1]
Xilinx Virtex
last sysfs file:
Modules linked in: xad
NIP: c0002328 LR: c0011de8 CTR: c001d77c
REGS: c778de20 TRAP: 0700   Not tainted  (2.6.34)
MSR: 00021030 <ME,CE,IR,DR>  CR: 24000044  XER: 00000000
TASK = c6ce80a0[241] 'SoftNoy' THREAD: c778c000
GPR00: 00000000 c778ded0 c6ce80a0 00000026 c6dbe000 00000000 e146dcab 00000000
GPR08: 02134be0 00000000 000020e7 00000001 000020e6 100265d8 00000000 1007c600
GPR16: 100acd0c 100822e4 1009024d bfa39a48 c7452080 c05bf0e8 c05bf02c c0207d6c
GPR24: c778c03c 00000004 c6cc7040 c05c1b88 00000001 00000004 c6cc73c0 00000026
NIP [c0002328] set_context+0x0/0x10
LR [c0011de8] switch_mmu_context+0x194/0x1b8
Call Trace:
[c778ded0] [c001a810] pick_next_task_fair+0xec/0x130 (unreliable)
[c778def0] [c0203514] schedule+0x300/0x394
[c778df40] [c000f63c] recheck+0x0/0x24
Instruction dump:
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 <00000000> 00000000 00000000 00000000
Kernel stack overflow in process c6ce80a0, r1=c778c070
NIP: c000d270 LR: c000f3c8 CTR: c0017fd0
REGS: c778bfc0 TRAP: 0501   Tainted: G      D     (2.6.34)
MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 24000048  XER: 00000000
TASK = c6ce80a0[241] 'SoftNoy' THREAD: c778c000
GPR00: 00029030 c778c070 c6ce80a0 c778c090 08000000 ffff32d8 00000001 00000001
GPR08: ffff32da 00000000 00021032 c000d110 06ce82a8
NIP [c000d270] program_check_exception+0x160/0x228
LR [c000f3c8] ret_from_except_full+0x0/0x4c
Call Trace:
Instruction dump:
38090004 901f0080 480000d8 3ca00003 7fe4fb78 80df0080 60a50001 38600005
480000a8 7c0000a6 60008000 7c000124 <77c00c04> 41a20068 4bffef89 2f83fff2
Kernel panic - not syncing: kernel stack overflow
Call Trace:
Rebooting in 180 seconds..

My driver is xad.ko, though /dev/xps-acqui-data. The user program is SoftNoy.
The code for the ISR (note that this code works fine on the same driver for a slightly different piece of custom 
hardware):

static irqreturn_t XadIsr(int irq, void *dev_id) {
	Xad.control_reg->fin_in = 0;		
	Xad.interrupt_reg->ISR  = 1;		
	Xad.interrupt_IPIF_reg->ISR = 4;

	Xad.control_reg->flux_address[0] = BUFFER_PHY_BASE + BUF_SZ*(++Xad.Icnt % BUF_NB); 
	Xad.control_reg->flux_address[1] = Xad.control_reg->flux_address[0] + BUF_SZ/2;

	if (Xad.Icnt<Xad.Rcnt+BUF_NB) 
		Xad.control_reg->flux_start=255;	// Arm the next interrupt
	else {
		// There aren't any buffers available for the next read. We'll do the start in the read routine
		Xad.Suspended=1;
		Xad.OverflowsSinceLastRead++;
		Xad.Overflow++;
		DBG_ADD_CHAR('*');
		if (Verbose) printk(KERN_WARNING SD "%dth buffer overflow: %d-%d=%d>=%d\n" FL, 
			Xad.Overflow, Xad.Icnt, Xad.Rcnt, Xad.Icnt-Xad.Rcnt, BUF_NB);
	}

	wake_up_interruptible(&Xad.wait);
	return IRQ_HANDLED;
}

-- 
Guillaume Dargaud
http://www.gdargaud.net/
