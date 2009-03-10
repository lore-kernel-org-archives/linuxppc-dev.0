Return-Path: <jwboyer@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 04588DDF2E
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 11:12:54 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2063981wfd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Mar 2009 17:12:53 -0700 (PDT)
Date: Mon, 9 Mar 2009 20:05:59 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Oops with 2.6.29-rc7 on POWER5
Message-ID: <20090310000559.GD2256@yoda.jdub.homelinux.org>
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

I get the following oops on a ppc64 machine using a Fedora rawhide kernel,
which is very close to 2.6.29-rc7.

It's a POWER5, pSeries CHRP IBM,9123-710.

Haven't looked into it just quite yet, but I found it interesting and was
wondering if anyone had seen anything like this or could recreate.

josh

BUG: sleeping function called from invalid context at kernel/mutex.c:207
in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper
------------[ cut here ]------------
Badness at kernel/mutex.c:135
NIP: c0000000005fe54c LR: c0000000005fe530 CTR: 0000000000000001
REGS: c00000000fffb5b0 TRAP: 0700   Not tainted  (2.6.29-0.215.rc7.fc11.ppc64)
MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 28000082  XER: 0000000f
TASK = c000000000f69e90[0] 'swapper' THREAD: c000000001010000 CPU: 0
GPR00: 0000000000000000 c00000000fffb830 c0000000010106b8 0000000000000001 
GPR04: c000000000f69e90 0000000000000070 0000000000000000 0000000000000002 
GPR08: 0000000000000000 c00000000179a3b8 c00000000104cb58 c000000001086a10 
GPR12: 000000000000003c c000000001058400 c00000006f09b4d0 c00000006f09b270 
GPR16: c00000006f09b408 c00000000fffba60 0000000000000001 c00000006f09b3c8 
GPR20: 0000000000000001 c00000006e570129 0000000000000000 c00000006f09b8c0 
GPR24: 0000000000000000 c00000000039d520 c00000006f09b248 c000000000f69e90 
GPR28: c00000006f09b8c0 c00000006f09b8c0 c000000000fa15c0 c00000000fffb830 
NIP [c0000000005fe54c] .mutex_lock_nested+0xc0/0x4b0
LR [c0000000005fe530] .mutex_lock_nested+0xa4/0x4b0
Call Trace:
[c00000000fffb830] [c0000000005fe504] .mutex_lock_nested+0x78/0x4b0 (unreliable)
[c00000000fffb950] [c00000000039d520] .echo_char_raw+0x40/0x98
[c00000000fffb9f0] [c00000000039fd68] .n_tty_receive_buf+0xb48/0x1104
[c00000000fffbbb0] [c0000000003a3a08] .flush_to_ldisc+0x160/0x244
[c00000000fffbc80] [c0000000003a3b5c] .tty_flip_buffer_push+0x70/0x9c
[c00000000fffbd10] [c0000000003b9e94] .hvsi_interrupt+0x464/0x590
[c00000000fffbe50] [c000000000119168] .handle_IRQ_event+0x60/0xdc
[c00000000fffbef0] [c00000000011baf0] .handle_fasteoi_irq+0x108/0x1a8
[c00000000fffbf90] [c00000000002f1c4] .call_handle_irq+0x1c/0x2c
[c000000001013970] [c00000000000e0ac] .do_IRQ+0x144/0x258
[c000000001013a30] [c000000000004d28] hardware_interrupt_entry+0x28/0x2c
--- Exception: 501 at .raw_local_irq_restore+0xa4/0xc0
    LR = .cpu_idle+0x13c/0x1e0
[c000000001013d20] [c000000000f9af28] mv88e6131_switch_driver+0x8d08/0x275f8 (unreliable)
[c000000001013dc0] [c000000000014d34] .cpu_idle+0x13c/0x1e0
[c000000001013e60] [c0000000006062b8] .rest_init+0x94/0xb0
[c000000001013ee0] [c00000000088bd08] .start_kernel+0x4a4/0x4c8
[c000000001013f90] [c000000000008408] .start_here_common+0x2c/0xa4
Instruction dump:
78290464 80090014 5409012f 41a20028 4bcb199d 60000000 2fa30000 419e0018 
e93e8008 80090000 2f800000 409e0008 <0fe00000> 38000000 8b8d01da 980d01da 
