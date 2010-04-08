Return-Path: <SSparks@aclara.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id C4C5EB7D2A
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Apr 2010 07:30:37 +1000 (EST)
Received: from mail126-va3 (localhost.localdomain [127.0.0.1])	by
	mail126-va3-R.bigfish.com (Postfix) with ESMTP id CB3C9750106	for
	<linuxppc-dev@ozlabs.org>; Thu,  8 Apr 2010 21:15:27 +0000 (UTC)
Received: from VA3EHSMHS015.bigfish.com (unknown [10.7.14.240])	by
	mail126-va3.bigfish.com (Postfix) with ESMTP id 562411AB8053	for
	<linuxppc-dev@ozlabs.org>; Thu,  8 Apr 2010 21:15:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Upgrade to 2.6.26 results in Oops during request_irq
Date: Thu, 8 Apr 2010 16:14:54 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A835560860170783A@mail.twacs.com>
From: "Sparks, Sam" <SSparks@aclara.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Howdy All,

I have (almost) successfully upgraded from Linux 2.6.22 to 2.6.26 (both
downloaded from debian) on my mpc8347 powerpc, but I think I may be
missing a required change to my dts regarding the IPIC or maybe a change
in how my driver requests IRQs.

I have several modules that are maintained outside the kernel tree, and
all but one is working correctly. The offending driver is attempting to
register IRQ 23, and is accessing an invalid memory location. I am
currently getting the following stack dump:

# insmod /tmp/cpld.ko
# insmod /tmp/dig_display.ko=20
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT SCPA-G2
Modules linked in: dig_display(+) cpld immr_misc immr [last unloaded:
cpld]
NIP: 00000000 LR: c00496e8 CTR: 00000000
REGS: dfafbdb0 TRAP: 0400   Not tainted  (2.6.26-twacs-100.0.0)
MSR: 20001032 <ME,IR,DR>  CR: 24002422  XER: 20000000
TASK =3D df9d9800[579] 'insmod' THREAD: dfafa000
GPR00: 00000000 dfafbe60 df9d9800 00000017 00000002 00000020 c00498d0
c06fe640=20
GPR08: 00000008 00000000 00000017 00000000 84002428 10073f68 1ffcb000
007ffeb0=20
GPR16: 00000000 00000000 00800000 00000000 bffff7f0 00000000 1006e3e4
00000000=20
GPR24: 00000002 e90cffd0 00000000 00009032 dfa3aca0 00000017 dfafa000
c02d0e78=20
NIP [00000000] 0x0
LR [c00496e8] setup_irq+0x2d4/0x2e0
Call Trace:
[dfafbe60] [c00496b0] setup_irq+0x29c/0x2e0 (unreliable)
[dfafbe90] [c0049904] request_irq+0xb8/0xe8
[dfafbec0] [e107e174] init_module+0x174/0x320 [dig_display]
[dfafbf10] [c0046e68] sys_init_module+0x14c/0x1d8
[dfafbf40] [c0010008] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff27bb0
    LR =3D 0x10019ca8
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
Kernel panic - not syncing: Fatal exception
Rebooting in 1 seconds..<0>------------[=20

I have traced the offending code through the setup_irq() call down to
kernel/irq/manage.c, where desc->chip->enable(irq) is being called.
However, enable is NULL resulting in the Oops.

I have verified enable and disable are set to valid addresses when
set_irq() is entered. However desc->chip->set_type() references
ipic_set_irq_type(), which overwrites enable and disable by setting
desc->chip to &ipic_edge_irq_chip.

At this point, I am at a loss. Does some additional step need to be
taken prior to calling request_irq() when upgrading from 2.6.22 to
2.6.26? Please let me know if you would like any additional information.
I don't want this email to get too difficult to follow.

Thanks for the help!
Sam

=20
