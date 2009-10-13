Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id 9ABF9B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Oct 2009 14:32:49 +1100 (EST)
Received: from landley.net (localhost [127.0.0.1])
	by grelber.thyrsus.com (Postfix) with ESMTP id 840909F0357
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Oct 2009 23:39:43 -0400 (EDT)
From: Rob Landley <rob@landley.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Serial console under current qemu?
Date: Mon, 12 Oct 2009 22:32:32 -0500
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200910122232.33743.rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Has anybody gotten a serial console to work under current qemu (ala the 0.11.0 
release)?

I've tried the 2.6.30 and 2.6.31.4 kernels, and in both cases both the 
bootloader and the kernel's boot messages write to the serial console just 
fine, but as soon as userspace tries to write to /dev/console the kernel panics 
with:

ieee1394: raw1394: /dev/raw1394 device initialized
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 17
VFS: Mounted root (squashfs filesystem) readonly on device 3:0.
Freeing unused kernel memory: 168k init
Type exit when done.Unable to handle kernel paging request for data at address 
0x00000084
Faulting instruction address: 0xc012dc9c
Oops: Kernel access of bad area, sig: 11 [#1]
PowerMac
NIP: c012dc9c LR: c01467c0 CTR: c01467ac
REGS: cf831be0 TRAP: 0300   Not tainted  (2.6.31.4)
MSR: 00009032 <EE,ME,IR,DR>  CR: 42224022  XER: 00000000
DAR: 00000084, DSISR: 40000000
TASK = cf82f8f0[1] 'init.sh' THREAD: cf830000
GPR00: c01467c0 cf831c90 cf82f8f0 00000000 cf82f920 cf824e40 91a8bb6b 00000000 
GPR08: 00000001 00000001 c01467ac 00000000 90778e6b 100834dc 0127e698 1005b940 
GPR16: 100859a0 00000000 1007d074 100429a4 00000000 c02dc614 c0281678 c02dc498 
GPR24: 0000000a cf830000 c0321e00 00000005 00000014 c0321e00 c02dc638 00000000 
NIP [c012dc9c] tty_wakeup+0x14/0xa0
LR [c01467c0] uart_tasklet_action+0x14/0x24
Call Trace:
[cf831c90] [c012dcbc] tty_wakeup+0x34/0xa0 (unreliable)
[cf831ca0] [c01467c0] uart_tasklet_action+0x14/0x24
[cf831cb0] [c003123c] tasklet_action+0x80/0x104
[cf831cd0] [c0031368] __do_softirq+0xa8/0x120
[cf831d10] [c0006ea4] do_softirq+0x58/0x5c
[cf831d20] [c00311b8] irq_exit+0x98/0x9c
[cf831d30] [c0006f44] do_IRQ+0x9c/0xb4
[cf831d50] [c0012b60] ret_from_except+0x0/0x1c
--- Exception: 501 at uart_start+0x24/0x38
    LR = uart_start+0x20/0x38
[cf831e20] [c0148130] uart_write+0xc0/0xe4
[cf831e50] [c0130bc0] n_tty_write+0x1d4/0x430
[cf831eb0] [c012db30] tty_write+0x188/0x268
[cf831ef0] [c0082314] vfs_write+0xb4/0x188
[cf831f10] [c008287c] sys_write+0x4c/0x90
[cf831f40] [c0012494] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0x48039f8c
    LR = 0x4804c4bc
Instruction dump:
7c0803a6 4e800020 80010024 bba10014 38210020 7c0803a6 4bfffd24 9421fff0 
7c0802a6 bfc10008 7c7f1b78 90010014 <80030084> 70090020 4082002c 387f00e0 
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
[cf831b10] [c0008d74] show_stack+0x4c/0x16c (unreliable)
[cf831b50] [c002b600] panic+0x90/0x160
[cf831ba0] [c0010064] die+0x148/0x154
[cf831bc0] [c0015b34] bad_page_fault+0x90/0xd8
[cf831bd0] [c001294c] handle_page_fault+0x7c/0x80
--- Exception: 300 at tty_wakeup+0x14/0xa0
    LR = uart_tasklet_action+0x14/0x24
[cf831c90] [c012dcbc] tty_wakeup+0x34/0xa0 (unreliable)
[cf831ca0] [c01467c0] uart_tasklet_action+0x14/0x24
[cf831cb0] [c003123c] tasklet_action+0x80/0x104
[cf831cd0] [c0031368] __do_softirq+0xa8/0x120
[cf831d10] [c0006ea4] do_softirq+0x58/0x5c
[cf831d20] [c00311b8] irq_exit+0x98/0x9c
[cf831d30] [c0006f44] do_IRQ+0x9c/0xb4
[cf831d50] [c0012b60] ret_from_except+0x0/0x1c
--- Exception: 501 at uart_start+0x24/0x38
    LR = uart_start+0x20/0x38
[cf831e20] [c0148130] uart_write+0xc0/0xe4
[cf831e50] [c0130bc0] n_tty_write+0x1d4/0x430
[cf831eb0] [c012db30] tty_write+0x188/0x268
[cf831ef0] [c0082314] vfs_write+0xb4/0x188
[cf831f10] [c008287c] sys_write+0x4c/0x90
[cf831f40] [c0012494] ret_from_syscall+0x0/0x40
--- Exception: c01 at 0x48039f8c
    LR = 0x4804c4bc
Rebooting in 1 seconds..

I've reproduced this with my Firmware Linux project (download 
http://impactlinux.com/fwl/downloads/binaries/system-image-powerpc.tar.bz2 , 
extract it, run "sed -i 's@-hda @-hdc @' run-emulator.sh" because qemu's 
device tree layout changed betwee 0.10.0 and 0.11.0, and then ./run-
emulator.sh).

I've also reproduced it with debian's kernel .config and root filesystem image, 
details on that posted here:
  http://lists.gnu.org/archive/html/qemu-devel/2009-10/msg01056.html

(Oddly, with debian's kernel .config -hda sets /dev/hda instead of /dev/hdc, I 
need to track down why so I can fix it in my project's .config.)

The debian image boots fine with a graphics console, it's just trying to use 
the serial console that panics it.  I don't know if this is a qemu device 
emulation issue, a kernel issue, or maybe something to do with the device tree 
qemu's openbios is feeding in at boot time?  I'm stumped.

Er... Help?  Pretty please?

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
