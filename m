Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39AC0B7D05
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 00:27:52 +1100 (EST)
Received: from bzq-79-176-44-225.red.bezeqint.net ([79.176.44.225]:50590
	helo=felix-laptop.lan)
	by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1NmS8Z-0000Aa-LH
	for linuxppc-dev@ozlabs.org; Tue, 02 Mar 2010 08:27:48 -0500
Message-ID: <4B8D125B.8030503@embedded-sol.com>
Date: Tue, 02 Mar 2010 15:27:55 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Problem with PCI bus rescan on 460EX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm running linux-2.6.33 on a custom board based on 460EX.
There's a PCI-PCI bridge on this board, PLX 6254, and a single
hot-pluggable device behind the bridge.

When this device is plugged in before system boots everything works
fine: bridge and device are properly recognized by kernel, resources are
allocated and device memory regions are accessible. Below is relevant
kernel messages and lspci output:

PCI: Probing PCI hardware
pci_bus 0000:00: scanning bus
pci 0000:00:02.0: found [3388:0020] class 000604 header type 01
pci 0000:00:02.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:00:02.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:00:02.0: calling quirk_resource_alignment+0x0/0x200
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 0
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: found [1575:0002] class 00ff00 header type 00
pci 0000:01:00.0: reg 10: [mem 0x80000000-0x800fffff]
pci 0000:01:00.0: reg 14: [mem 0x84000000-0x87ffffff]
pci 0000:01:00.0: reg 18: [mem 0x88000000-0x8bffffff]
pci 0000:01:00.0: reg 1c: [mem 0x8c000000-0x8c003fff]
pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:01:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:01:00.0: calling quirk_resource_alignment+0x0/0x200
pci_bus 0000:01: fixups for bus
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [mem 0x80000000-0x8c0fffff]
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:02.0: BAR 8: assigned [mem 0xd80000000-0xd89ffffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0xd80000000-0xd83ffffff]
pci 0000:01:00.0: BAR 1: set to [mem 0xd80000000-0xd83ffffff] (PCI 
address [0x80000000-0x83ffffff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xd84000000-0xd87ffffff]
pci 0000:01:00.0: BAR 2: set to [mem 0xd84000000-0xd87ffffff] (PCI 
address [0x84000000-0x87ffffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xd88000000-0xd880fffff]
pci 0000:01:00.0: BAR 0: set to [mem 0xd88000000-0xd880fffff] (PCI 
address [0x88000000-0x880fffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xd88100000-0xd88103fff]
pci 0000:01:00.0: BAR 3: set to [mem 0xd88100000-0xd88103fff] (PCI 
address [0x88100000-0x88103fff]
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [io  disabled]
pci 0000:00:02.0:   bridge window [mem 0xd80000000-0xd89ffffff]
pci 0000:00:02.0:   bridge window [mem pref disabled]
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0xd80000000-0xdffffffff]
pci_bus 0000:01: resource 1 [mem 0xd80000000-0xd89ffffff]

00:02.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (transparent 
mode) (rev 04)
00: 88 33 20 00 87 00 b0 02 04 00 04 06 08 80 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f1 01 a0 02
20: 00 80 f0 89 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00


The problem arises when device is plugged in after boot. After doing
echo 1 > /sys/bus/pci/rescan
the device is identified, but bridge memory window is not allocated,
and reads from device memory regions return 0xffffffff. Below is
relevant output:

PCI: Probing PCI hardware
pci_bus 0000:00: scanning bus
pci 0000:00:02.0: found [3388:0020] class 000604 header type 01
pci 0000:00:02.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:00:02.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:00:02.0: calling quirk_resource_alignment+0x0/0x200
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 0
pci_bus 0000:01: scanning bus
pci_bus 0000:01: fixups for bus
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:02.0: PCI bridge to [bus 01-01]
pci 0000:00:02.0:   bridge window [io  disabled]
pci 0000:00:02.0:   bridge window [mem disabled]
pci 0000:00:02.0:   bridge window [mem pref disabled]
pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
pci_bus 0000:00: resource 1 [mem 0xd80000000-0xdffffffff]
pci 0000:00:02.0: calling quirk_cardbus_legacy+0x0/0x54
pci 0000:00:02.0: calling quirk_usb_early_handoff+0x0/0x6cc
PCI: CLS 32 bytes, default 32

pci_bus 0000:00: scanning bus
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 0
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: found [1575:0002] class 00ff00 header type 00
pci 0000:01:00.0: reg 10: [mem 0x00000000-0x000fffff]
pci 0000:01:00.0: reg 14: [mem 0x00000000-0x03ffffff]
pci 0000:01:00.0: reg 18: [mem 0x00000000-0x03ffffff]
pci 0000:01:00.0: reg 1c: [mem 0x00000000-0x00003fff]
pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0xf4
pci 0000:01:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0000:01:00.0: calling quirk_resource_alignment+0x0/0x200
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:02.0: BAR 8: assigned [mem 0xd80000000-0xd89ffffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0xd80000000-0xd83ffffff]
pci 0000:01:00.0: BAR 1: set to [mem 0xd80000000-0xd83ffffff] (PCI 
address [0x80000000-0x83ffffff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xd84000000-0xd87ffffff]
pci 0000:01:00.0: BAR 2: set to [mem 0xd84000000-0xd87ffffff] (PCI 
address [0x84000000-0x87ffffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xd88000000-0xd880fffff]
pci 0000:01:00.0: BAR 0: set to [mem 0xd88000000-0xd880fffff] (PCI 
address [0x88000000-0x880fffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xd88100000-0xd88103fff]
pci 0000:01:00.0: BAR 3: set to [mem 0xd88100000-0xd88103fff] (PCI 
address [0x88100000-0x88103fff]

00:02.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (transparent 
mode) (rev 04)
00: 88 33 20 00 87 00 b0 02 04 00 04 06 08 80 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f1 01 a0 02
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

As you can see, the PLX BAR at address 0x20 is not properly configured.
Writing the value 0x89f08000 using setpci fixes access to hot-plugged 
device.

Any idea why PCI bus rescan fails to allocate bridge memory window ?

Thanks a lot.

Felix.
