Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18848B6F81
	for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2011 23:25:21 +1000 (EST)
Received: by qwi4 with SMTP id 4so1289987qwi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2011 06:25:17 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
Date: Fri, 27 May 2011 15:25:17 +0200
Message-ID: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
Subject: Mapping an executable page
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

To cover a specific reset scenario, I need to jump back to the reset
vector of a powerpc processor (e500mc core). In order to be able to
jump there directly, the code where I jump to should have a TLB
mapping associated with it.

I tried achieving this as follows:

                typedef void (*funcptr)(void);

                void __iomem *vaddr = __ioremap(0xfffff000, 0x1000,
(_PAGE_BASE | _PAGE_KERNEL_RWX));
                printk(KERN_ERR "reboot_helper: 0xfffff000 mapped to
%p\n", vaddr);

                /* Disable interrupts to avoid the boot code to be
interrupted */
                local_irq_disable();

                funcptr resetvector = (funcptr)(vaddr + 0xfec);
                resetvector();

Unfortunately, I'm experiencing problems with this approach. I get :

[   23.384639] reboot_helper: event: val=1
[   23.384699] reboot_helper: 0xfffff000 mapped to f127e000
[   23.384781] reboot_helper: 0xfffe1000 mapped to f1420000
[   23.384856] Unable to handle kernel paging request for instruction fetch
[   23.384949] Faulting instruction address: 0xf126b8d0
[   23.385021] Oops: Kernel access of bad area, sig: 11 [#1]
[   23.385096] P4080 DS
[   23.385129] last sysfs file: /sys/class/uio/uio0/name
[   23.385200] Modules linked in: reboot_helper
[   23.385310] NIP: f126b8d0 LR: f127a190 CTR: f127efec
[   23.385382] REGS: ec459cf0 TRAP: 0400   Not tainted  (2.6.34.6-hg378747c1a102
-dirty)
[   23.385489] MSR: 00029002 <EE,ME,CE>  CR: 22002082  XER: 20000000
[   23.385591] TASK = ec08a590[1094] 'init' THREAD: ec458000
[   23.385664] GPR00: 00000001 ec459da0 ec08a590 00000042 0000388b ffffffff c01e
4388 00000000
[   23.385800] GPR08: 00000001 c0490000 00000001 c04972d8 0fffffff 100bea58 0000
0000 00000201
[   23.385936] GPR16: ff800002 ff80003f 00000000 00000000 00000001 effff000 c04b
8000 00000000
[   23.386072] GPR24: bfdb9be8 100891a4 bfdb9d7c 00000000 00000000 fffffffe 0000
0001 f127efec
[   23.386216] NIP [f126b8d0] 0xf126b8d0
[   23.386275] LR [f127a190] isam_reboot_handler+0xa0/0xc4 [reboot_helper]
[   23.386366] Call Trace:
[   23.386410] [ec459da0] [f127a168] isam_reboot_handler+0x78/0xc4 [reboot_helpe
r] (unreliable)
[   23.386534] [ec459db0] [c00422a0] notifier_call_chain+0x5c/0xc8
[   23.386624] [ec459dd0] [c00426d4] __blocking_notifier_call_chain+0x5c/0x88
[   23.386725] [ec459e00] [c0036850] kernel_restart_prepare+0x20/0x44
[   23.386816] [ec459e10] [c00368c4] kernel_restart+0x18/0x5c
[   23.386899] [ec459e20] [c0036a94] sys_reboot+0x184/0x1cc
[   23.386980] [ec459f40] [c000fbe0] ret_from_syscall+0x0/0x3c
[   23.387059] Instruction dump:
[   23.387104] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XX
XXXXXX
[   23.387228] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XX
XXXXXX
[   23.387355] ---[ end trace 48808de79275a83d ]---


Although I realize that what I need to achieve is unconventional, what
is the correct way of mapping a certain address range into memory, and
be able to execute from it?

Thanks,
Thomas
