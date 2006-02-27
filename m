Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D954679E0
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 01:53:05 +1100 (EST)
Date: Mon, 27 Feb 2006 15:52:59 +0100
From: Olaf Hering <olh@suse.de>
To: Linas Vepstas <linas@austin.ibm.com>, linuxppc-dev@ozlabs.org
Subject: fix NULL pointer in handle_eeh_events
Message-ID: <20060227145259.GA15955@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch fixes a crash in handle_eeh_events,
but ethtool -t still doesnt work right.

...
pepino:~ # cpu 0x3: Vector: 300 (Data Access) at [c00000005192bbe0]
    pc: c00000000004a380: .handle_eeh_events+0xe0/0x23c
    lr: c00000000004a374: .handle_eeh_events+0xd4/0x23c
    sp: c00000005192be60
   msr: 9000000000009032
   dar: 268
 dsisr: 40000000
  current = 0xc0000001fe7bf1a0
  paca    = 0xc00000000048b280
    pid   = 16322, comm = eehd
enter ? for help
[c00000005192bf00] c00000000004a808 .eeh_event_handler+0xcc/0x130
[c00000005192bf90] c000000000025e00 .kernel_thread+0x4c/0x68

...

(none):/# /usr/sbin/ethtool -i eth0
driver: e100
version: 3.5.10-k2-NAPI
firmware-version: N/A
bus-info: 0000:21:01.0
(none):/# /usr/sbin/ethtool -t eth0
Call Trace:
[C00000000F8DEFF0] [C00000000000F270] .show_stack+0x74/0x1b4 (unreliable)
[C00000000F8DF0A0] [C000000000049D04] .eeh_dn_check_failure+0x290/0x2d8
[C00000000F8DF150] [C000000000049E58] .eeh_check_failure+0x10c/0x138
[C00000000F8DF1E0] [C0000000002DFDB0] .e100_hw_reset+0x70/0xf4
[C00000000F8DF270] [C0000000002E1BBC] .e100_hw_init+0x2c/0x260
[C00000000F8DF310] [C0000000002E2464] .e100_loopback_test+0x8c/0x220
[C00000000F8DF3C0] [C0000000002E28DC] .e100_diag_test+0xdc/0x16c
[C00000000F8DF490] [C000000000420BE0] .dev_ethtool+0xf24/0x14f8
[C00000000F8DF8F0] [C00000000041F4A8] .dev_ioctl+0x5cc/0x740
[C00000000F8DFA20] [C00000000040FEFC] .sock_ioctl+0x3d0/0x404
[C00000000F8DFAC0] [C0000000000D513C] .do_ioctl+0x68/0x108
[C00000000F8DFB50] [C0000000000D56B0] .vfs_ioctl+0x4d4/0x510
[C00000000F8DFC10] [C0000000000D5740] .sys_ioctl+0x54/0x94
[C00000000F8DFCC0] [C0000000000FB6EC] .ethtool_ioctl+0x11c/0x150
[C00000000F8DFD60] [C0000000000F7E40] .compat_sys_ioctl+0x338/0x3bc
[C00000000F8DFE30] [C00000000000871C] syscall_exit+0x0/0x40
EEH: Detected PCI bus error on device 0000:21:01.0
EEH: This PCI device has failed 1 times since last reboot: <NULL> -

modprobe: FATAL: Could not load /lib/modules/2.6.16-rc4-git7/modules.dep: No such file or directory

Cannot get strings: No such device
(none):/#
(none):/# EEH: Unable to configure device bridge (-3) for /pci@400000000110/pci@2,2

(none):/# Call Trace:
[C00000000FA17940] [C00000000000F270] .show_stack+0x74/0x1b4 (unreliable)
[C00000000FA179F0] [C000000000049D04] .eeh_dn_check_failure+0x290/0x2d8
[C00000000FA17AA0] [C00000000001E114] .rtas_read_config+0x120/0x154
[C00000000FA17B40] [C000000000049664] .early_enable_eeh+0x274/0x2bc
[C00000000FA17C00] [C000000000049708] .eeh_add_device_early+0x5c/0x6c
[C00000000FA17C90] [C000000000049748] .eeh_add_device_tree_early+0x30/0x5c
[C00000000FA17D20] [C000000000046568] .pcibios_add_pci_devices+0x8c/0x1f8
[C00000000FA17DD0] [C00000000004A528] .eeh_reset_device+0xe0/0x110
[C00000000FA17E60] [C00000000004A698] .handle_eeh_events+0x140/0x250
[C00000000FA17F00] [C00000000004AC7C] .eeh_event_handler+0xe8/0x140
[C00000000FA17F90] [C000000000025784] .kernel_thread+0x4c/0x68
EEH: Detected PCI bus error on device <NULL>
EEH: This PCI device has failed 1 times since last reboot: <NULL> -
EEH: Unable to configure device bridge (-3) for /pci@400000000110/pci@2,2
Call Trace:
[C00000000FA17940] [C00000000000F270] .show_stack+0x74/0x1b4 (unreliable)
[C00000000FA179F0] [C000000000049D04] .eeh_dn_check_failure+0x290/0x2d8
[C00000000FA17AA0] [C00000000001E114] .rtas_read_config+0x120/0x154
[C00000000FA17B40] [C000000000049664] .early_enable_eeh+0x274/0x2bc
[C00000000FA17C00] [C000000000049708] .eeh_add_device_early+0x5c/0x6c
[C00000000FA17C90] [C000000000049748] .eeh_add_device_tree_early+0x30/0x5c
[C00000000FA17D20] [C000000000046568] .pcibios_add_pci_devices+0x8c/0x1f8
[C00000000FA17DD0] [C00000000004A528] .eeh_reset_device+0xe0/0x110
[C00000000FA17E60] [C00000000004A698] .handle_eeh_events+0x140/0x250
[C00000000FA17F00] [C00000000004AC7C] .eeh_event_handler+0xe8/0x140
[C00000000FA17F90] [C000000000025784] .kernel_thread+0x4c/0x68
EEH: Detected PCI bus error on device <NULL>
EEH: This PCI device has failed 1 times since last reboot: <NULL> -
EEH: Unable to configure device bridge (-3) for /pci@400000000110/pci@2,2
Call Trace:
[C00000000FA17940] [C00000000000F270] .show_stack+0x74/0x1b4 (unreliable)
[C00000000FA179F0] [C000000000049D04] .eeh_dn_check_failure+0x290/0x2d8
[C00000000FA17AA0] [C00000000001E114] .rtas_read_config+0x120/0x154
[C00000000FA17B40] [C000000000049664] .early_enable_eeh+0x274/0x2bc
[C00000000FA17C00] [C000000000049708] .eeh_add_device_early+0x5c/0x6c
[C00000000FA17C90] [C000000000049748] .eeh_add_device_tree_early+0x30/0x5c
[C00000000FA17D20] [C000000000046568] .pcibios_add_pci_devices+0x8c/0x1f8
[C00000000FA17DD0] [C00000000004A528] .eeh_reset_device+0xe0/0x110
[C00000000FA17E60] [C00000000004A698] .handle_eeh_events+0x140/0x250
[C00000000FA17F00] [C00000000004AC7C] .eeh_event_handler+0xe8/0x140
[C00000000FA17F90] [C000000000025784] .kernel_thread+0x4c/0x68
EEH: Detected PCI bus error on device <NULL>
and so on


Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/platforms/pseries/eeh_driver.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc5-olh/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.16-rc5-olh.orig/arch/powerpc/platforms/pseries/eeh_driver.c
+++ linux-2.6.16-rc5-olh/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -37,7 +37,7 @@
 
 static inline const char * pcid_name (struct pci_dev *pdev)
 {
-	if (pdev->dev.driver)
+	if (pdev && pdev->dev.driver)
 		return pdev->dev.driver->name;
 	return "";
 }
