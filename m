Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 82E23DDE0F
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 03:45:18 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LERQU-0000sq-DW
	for linuxppc-dev@ozlabs.org; Sun, 21 Dec 2008 08:45:10 -0800
Message-ID: <21116726.post@talk.nabble.com>
Date: Sun, 21 Dec 2008 08:45:10 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Kernel crash on ohci-hcd unloading in 2.6.28-rc9
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


Hi,

I'm getting the following crash when unloading ohci-hcd module
on custom 460EX platform:

-bash-3.2# rmmod ohci-hcd
ppc-of-ohci 4bffd0000.usb: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-1: USB disconnect, address 2
ppc-of-ohci 4bffd0000.usb: USB bus 1 deregistered
Trying to install chip for IRQ-1
------------[ cut here ]------------
Badness at c0044dd8 [verbose debug info unavailable]
NIP: c0044dd8 LR: c0044dd8 CTR: c0106bb4
REGS: dfa27cf0 TRAP: 0700   Not tainted  (2.6.28-rc9)
MSR: 00029000 <EE,ME>  CR: 22000082  XER: 20000004
TASK = df874c30[468] 'rmmod' THREAD: dfa26000
GPR00: c0044dd8 dfa27da0 df874c30 00000024 00001a85 ffffffff c01071f0
00020000
GPR08: 00000001 c0232c74 00001a85 00000001 24000084 1004a180 00000000
00000000
GPR16: 101017e8 1009e4f0 100f0000 10043008 00000000 bfae0070 10001be4
bfae007c
GPR24: bfae0078 00000000 bfae0080 00000880 00000000 ffffffff e4fa79a8
00000000
NIP [c0044dd8] set_irq_chip+0x4c/0x98
LR [c0044dd8] set_irq_chip+0x4c/0x98
Call Trace:
[dfa27da0] [c0044dd8] set_irq_chip+0x4c/0x98 (unreliable)
[dfa27dc0] [c0044e84] set_irq_chip_and_handler+0x1c/0x40
[dfa27de0] [c0003570] irq_dispose_mapping+0x5c/0x158
[dfa27e00] [e4fa2d70] ohci_hcd_ppc_of_remove+0x34/0x70 [ohci_hcd]
[dfa27e20] [c011f9dc] of_platform_device_remove+0x30/0x44
[dfa27e30] [c010d4f0] __device_release_driver+0x84/0xb0
[dfa27e40] [c010d588] driver_detach+0x6c/0xa8
[dfa27e60] [c010c5b8] bus_remove_driver+0x9c/0xd8
[dfa27e80] [c010dacc] driver_unregister+0x48/0x5c
[dfa27ea0] [c011fae0] of_unregister_driver+0x14/0x24
[dfa27eb0] [e4fa4cc0] ohci_hcd_mod_exit+0x28/0x400 [ohci_hcd]
[dfa27ed0] [c0040b50] sys_delete_module+0x1ac/0x218
[dfa27f40] [c000cab8] ret_from_syscall+0x0/0x3c
Instruction dump:
7f830040 7c9f2378 409c0018 1c03003c 3d20c022 39291594 7fc04a15 40a20020
3c60c01d 7d645b78 3863fbe8 4bfd954d <0fe00000> 3860ffea 48000030 2f840000

This happens because by the moment irq_dispose_mapping(hcd->irq) is invoked
from
ohci_hcd_ppc_of_remove() (in drivers/usb/host/ohci-ppc-of.c) hcd->irq is set
to -1 by 
ohci_stop().

I'm not sure what is the correct way to fix the crash. I've modified
ohci_stop() 
not to free irq and set hcd->irq to -1 if CONFIG_USB_OHCI_HCD_PPC_OF is
defined, and that fixed the crash. But maybe this is not the best way to fix
it.

Felix.
-- 
View this message in context: http://www.nabble.com/Kernel-crash-on-ohci-hcd-unloading-in-2.6.28-rc9-tp21116726p21116726.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
