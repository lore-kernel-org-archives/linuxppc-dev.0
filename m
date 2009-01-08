Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4B7CDE3AC
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 16:18:31 +1100 (EST)
Subject: [BUG] hvc_console WARN() on current upstream
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 16:18:17 +1100
Message-Id: <1231391897.2142.40.camel@pasglop>
Mime-Version: 1.0
Cc: Milton Miller <miltonm@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Firing that off here in case I don't get a chance to investigate this
week... latest upstream with whatever I'm about to push into
powerpc-next (but I doubt it's the pending stuff that's causing it)
gives me that on a pseries machine:

------------[ cut here ]------------
Badness at /home/benh/kernels/linux-powerpc/kernel/mutex.c:135
NIP: c0000000004fe0dc LR: c0000000004fe0c0 CTR: c0000000002c4304
REGS: c00000000fffb660 TRAP: 0700   Not tainted  (2.6.28-test)
MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 28000082  XER: 20000003
TASK = c0000000007bd340[0] 'swapper' THREAD: c000000000874000 CPU: 0
GPR00: 0000000000000000 c00000000fffb8e0 c000000000877438 0000000000000001 
GPR04: 0000000000000000 c0000000225f0928 0000000000000003 0000000008000001 
GPR08: cf3cf3cf3cf3cf3d c000000000e6edc0 c000000000787634 c0000000008d45ac 
GPR12: 0000000028000082 c0000000008b7300 c00000002254db20 0000000000000001 
GPR16: 0000000000000003 c00000002254d940 c00000002254da70 c0000000225f0828 
GPR20: c0000000225f0929 0000000000000000 c00000002254dee8 0000000000000000 
GPR24: 0000000000000000 c0000000002c2604 0000000000000003 c0000000007bd340 
GPR28: c00000002254dee8 c00000002254d800 c0000000007ef2b8 c00000002254dee8 
NIP [c0000000004fe0dc] .mutex_lock_nested+0x90/0x408
LR [c0000000004fe0c0] .mutex_lock_nested+0x74/0x408
Call Trace:
[c00000000fffb9e0] [c0000000002c2604] .echo_set_canon_col+0x28/0x68
[c00000000fffba70] [c0000000002c4db4] .n_tty_receive_buf+0xcbc/0xfe0
[c00000000fffbc10] [c0000000002c80f8] .flush_to_ldisc+0x18c/0x24c
[c00000000fffbcd0] [c0000000002dd02c] .hvc_poll+0x2d0/0x328
[c00000000fffbde0] [c0000000002dd2e4] .hvc_handle_interrupt+0x14/0x3c
[c00000000fffbe50] [c0000000000999a4] .handle_IRQ_event+0x50/0xc0
[c00000000fffbef0] [c00000000009bdec] .handle_fasteoi_irq+0xf8/0x194
[c00000000fffbf90] [c000000000025950] .call_handle_irq+0x1c/0x2c
[c000000000877a30] [c00000000000cd18] .do_IRQ+0x104/0x1dc
[c000000000877ae0] [c000000000004800] hardware_interrupt_entry+0x18/0x98
--- Exception: 501 at .cpu_idle+0x104/0x190
    LR = .cpu_idle+0x104/0x190
[c000000000877dd0] [c000000000011e58] .cpu_idle+0xf8/0x190 (unreliable)
[c000000000877e60] [c000000000500b24] .rest_init+0x7c/0x94
[c000000000877ee0] [c000000000715aec] .start_kernel+0x3f4/0x414
[c000000000877f90] [c000000000008368] .start_here_common+0x1c/0x34
Instruction dump:
78290464 80090014 5409012f 41820028 4bd5ead5 60000000 2fa30000 419e0018 
e93e8008 80090000 2f800000 409e0008 <0fe00000> 38000000 8b8d01da 980d01da 

The machine still boots, so it's not a show stopper.

Cheers,
Ben.
