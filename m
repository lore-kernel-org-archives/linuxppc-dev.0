Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.17.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95594DE517
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 18:57:57 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id n087vkJk018132
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 07:57:46 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id n087vkwB3752122
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 08:57:46 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n087vkSE004823
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 08:57:46 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BUG] hvc_console WARN() on current upstream
Date: Thu, 8 Jan 2009 08:57:44 +0100
References: <1231391897.2142.40.camel@pasglop>
In-Reply-To: <1231391897.2142.40.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200901080857.44090.borntraeger@de.ibm.com>
Cc: Milton Miller <miltonm@us.ibm.com>, Joe Peterson <joe@skyrush.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Donnerstag, 8. Januar 2009 schrieb Benjamin Herrenschmidt:
> ------------[ cut here ]------------
> Badness at /home/benh/kernels/linux-powerpc/kernel/mutex.c:135
> NIP: c0000000004fe0dc LR: c0000000004fe0c0 CTR: c0000000002c4304
> REGS: c00000000fffb660 TRAP: 0700   Not tainted  (2.6.28-test)
> MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 28000082  XER: 20000003
> TASK = c0000000007bd340[0] 'swapper' THREAD: c000000000874000 CPU: 0
> GPR00: 0000000000000000 c00000000fffb8e0 c000000000877438 0000000000000001 
> GPR04: 0000000000000000 c0000000225f0928 0000000000000003 0000000008000001 
> GPR08: cf3cf3cf3cf3cf3d c000000000e6edc0 c000000000787634 c0000000008d45ac 
> GPR12: 0000000028000082 c0000000008b7300 c00000002254db20 0000000000000001 
> GPR16: 0000000000000003 c00000002254d940 c00000002254da70 c0000000225f0828 
> GPR20: c0000000225f0929 0000000000000000 c00000002254dee8 0000000000000000 
> GPR24: 0000000000000000 c0000000002c2604 0000000000000003 c0000000007bd340 
> GPR28: c00000002254dee8 c00000002254d800 c0000000007ef2b8 c00000002254dee8 
> NIP [c0000000004fe0dc] .mutex_lock_nested+0x90/0x408
> LR [c0000000004fe0c0] .mutex_lock_nested+0x74/0x408
> Call Trace:
> [c00000000fffb9e0] [c0000000002c2604] .echo_set_canon_col+0x28/0x68
> [c00000000fffba70] [c0000000002c4db4] .n_tty_receive_buf+0xcbc/0xfe0
> [c00000000fffbc10] [c0000000002c80f8] .flush_to_ldisc+0x18c/0x24c
> [c00000000fffbcd0] [c0000000002dd02c] .hvc_poll+0x2d0/0x328
> [c00000000fffbde0] [c0000000002dd2e4] .hvc_handle_interrupt+0x14/0x3c
> [c00000000fffbe50] [c0000000000999a4] .handle_IRQ_event+0x50/0xc0
> [c00000000fffbef0] [c00000000009bdec] .handle_fasteoi_irq+0xf8/0x194
> [c00000000fffbf90] [c000000000025950] .call_handle_irq+0x1c/0x2c
> [c000000000877a30] [c00000000000cd18] .do_IRQ+0x104/0x1dc
> [c000000000877ae0] [c000000000004800] hardware_interrupt_entry+0x18/0x98
> --- Exception: 501 at .cpu_idle+0x104/0x190
>     LR = .cpu_idle+0x104/0x190
> [c000000000877dd0] [c000000000011e58] .cpu_idle+0xf8/0x190 (unreliable)
> [c000000000877e60] [c000000000500b24] .rest_init+0x7c/0x94
> [c000000000877ee0] [c000000000715aec] .start_kernel+0x3f4/0x414
> [c000000000877f90] [c000000000008368] .start_here_common+0x1c/0x34
> Instruction dump:
> 78290464 80090014 5409012f 41820028 4bd5ead5 60000000 2fa30000 419e0018 
> e93e8008 80090000 2f800000 409e0008 <0fe00000> 38000000 8b8d01da 980d01da 
> 
> The machine still boots, so it's not a show stopper.


Hmmm,

Seems that we are in interrupt, doing hvc_poll, which does
tty_flip_buffer_push
which calls
flush_to_ldisc
doing a
n_tty_receive_buf
and we will finally take a mutex in echo_set_canon_col 

my first guess is that the following patch triggered the Badness:
git show a88a69c9
commit a88a69c91256418c5907c2f1f8a0ec0a36f9e6cc
Author: Joe Peterson <joe@skyrush.com>
Date:   Fri Jan 2 13:40:53 2009 +0000

    n_tty: Fix loss of echoed characters and remove bkl from n_tty


I have no idea how to fix this.
Joe Peterson CCed.

Christian
