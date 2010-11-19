Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id E1A1CB70B0
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Nov 2010 02:50:27 +1100 (EST)
Message-ID: <4CE69AF6.6090408@mlbassoc.com>
Date: Fri, 19 Nov 2010 08:42:46 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: Change in PCI behaviour
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm upgrading from 2.6.28 to 2.6.32 (yes, I know it's not the latest,
but it's the best I can do at the moment).  There seems to have been
a change in how the PCI bus is scanned/assigned which is causing me
some hardware problems.  My hardware is FSL MPC8347 and the problem
is likely specific to the FSL PCI code.

My system has 256MB RAM, fully mapped into the PCI export window.
There are an additional 2 devices on the PCI bus.  On 2.6.28, I
get this layout:

PCI: Probing PCI hardware
pci 0000:00:00.0: reg 10 32bit mmio: [0x000000-0x0fffff]
pci 0000:00:00.0: reg 18 64bit mmio: [0x000000-0xfffffff]
pci 0000:00:0b.0: reg 10 io port: [0x1000-0x1007]
pci 0000:00:0b.0: reg 14 io port: [0x1008-0x100b]
pci 0000:00:0b.0: reg 18 io port: [0x1010-0x1017]
pci 0000:00:0b.0: reg 1c io port: [0x1018-0x101b]
pci 0000:00:0b.0: reg 20 io port: [0x1020-0x102f]
pci 0000:00:0b.0: reg 24 32bit mmio: [0x100000-0x1001ff]
pci 0000:00:0b.0: reg 30 32bit mmio: [0x000000-0x07ffff]
pci 0000:00:0b.0: supports D1 D2
pci 0000:00:0c.0: reg 10 32bit mmio: [0x4000000-0x7ffffff]
PCI: Cannot allocate resource region 5 of device 0000:00:0b.0, will remap
PCI: Cannot allocate resource region 0 of device 0000:00:0c.0, will remap
bus: 00 index 0 io port: [0x00-0xfffff]
bus: 00 index 1 mmio: [0xc0000000-0xdfffffff]

There are no notices, but the key item is that device 0000:00:0c.0 gets
mapped at PCI address 0xD0000000.

On 2.6.32, I get this:

PCI: Probing PCI hardware
pci 0000:00:0b.0: reg 10: [io  0x1000-0x1007]
pci 0000:00:0b.0: reg 14: [io  0x1008-0x100b]
pci 0000:00:0b.0: reg 18: [io  0x1010-0x1017]
pci 0000:00:0b.0: reg 1c: [io  0x1018-0x101b]
pci 0000:00:0b.0: reg 20: [io  0x1020-0x102f]
pci 0000:00:0b.0: reg 24: [mem 0x00100000-0x001001ff]
pci 0000:00:0b.0: reg 30: [mem 0x00000000-0x0007ffff pref]
pci 0000:00:0b.0: supports D1 D2
pci 0000:00:0c.0: reg 10: [mem 0x04000000-0x07ffffff]
PCI: Cannot allocate resource region 5 of device 0000:00:0b.0, will remap
PCI: Cannot allocate resource region 0 of device 0000:00:0c.0, will remap
pci 0000:00:0c.0: BAR 0: assigned [mem 0xc0000000-0xc3ffffff]
pci 0000:00:0c.0: BAR 0: set to [mem 0xc0000000-0xc3ffffff] (PCI address [0xc0000000-0xc3ffffff]
pci 0000:00:0b.0: BAR 6: assigned [mem 0xc4000000-0xc407ffff pref]
pci 0000:00:0b.0: BAR 5: assigned [mem 0xc4080000-0xc40801ff]
pci 0000:00:0b.0: BAR 5: set to [mem 0xc4080000-0xc40801ff] (PCI address [0xc4080000-0xc40801ff]
pci_bus 0000:00: resource 0 [io  0x0000-0xfffff]
pci_bus 0000:00: resource 1 [mem 0xc0000000-0xdfffffff]

In this case, note that PCI device 0000:00:0c.0 is at 0xc0000000.
This causes problems because it's a truly stupid device that does
not work properly at PCI [relative] address 0x00000000.  It simply
does not respond at that address.  Pick anywhere else and it will
work fine!

On 2.6.28, I get this layout:
# ls -l /sys/bus/pci/devices
lrwxrwxrwx    1 root     root             0 Jan  1  1970 0000:00:00.0 -> ../../../devices/pci0000:00/0000:00:00.0
lrwxrwxrwx    1 root     root             0 Jan  1  1970 0000:00:0b.0 -> ../../../devices/pci0000:00/0000:00:0b.0
lrwxrwxrwx    1 root     root             0 Jan  1  1970 0000:00:0c.0 -> ../../../devices/pci0000:00/0000:00:0c.0
# cat /sys/bus/pci/devices/0000\:00\:0c.0/resource
0x00000000d0000000 0x00000000d3ffffff 0x0000000000020200
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000


On 2.6.32, the final layout looks like this:
# ls -l /sys/bus/pci/devices/
lrwxrwxrwx    1 root     root             0 Jan  1  1970 0000:00:0b.0 -> ../../../devices/pci0000:00/0000:00:0b.0
lrwxrwxrwx    1 root     root             0 Jan  1  1970 0000:00:0c.0 -> ../../../devices/pci0000:00/0000:00:0c.0
# cat /sys/bus/pci/devices/0000\:00\:0c.0/resource
0x00000000c0000000 0x00000000c3ffffff 0x0000000000020200
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000

Bottom line: how can I get this behaviour back (so as to get my
stupid graphics controller working again)??

Thanks for any ideas

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
