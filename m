Date: Mon, 13 May 2002 10:55:19 -0400
From: Bill Fink <billfink@mindspring.com>
To: Linux IEEE1394 Developers <linux1394-devel@lists.sourceforge.net>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Firewire Disk Broken in 2.4.19-pre8-ben0 kernel (was working fine with 2.4.18-ben0)
Message-Id: <20020513105519.7cb1daf8.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I was successfully using my LaCie 80 GB firewire disk drive with the
2.4.18-ben0 kernel on a dual 500 MHz G4 PPC system (with a UP kernel).
However, it no longer works with the 2.4.19-pre8-ben0 kernel.  I tried
using the ieee1394-473 tarball but that didn't help.  I also tried going
back to the ieee1394-444 tarball, but that didn't help either.  Here are
the dmesg messages from when I modprobe ieee1394/ohci1394 (these are
from using the 444 tarball):

ohci1394: $Revision: 1.101 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 02:0a.0 (0010 -> 0012)
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[63]  MMIO=[80080000-80080800]  Max Packet=[2048]
ieee1394: received packet during reset; ignoring
ohci1394_0: Unexpected tcode 0xf(0x6001c1ff) in AR ctx=0, length=-1: dma prg stopped
ieee1394: ConfigROM quadlet transaction error for node 00:1023
ieee1394: Host added: Node[01:1023]  GUID[00000000feeb324a]  [Linux OHCI-1394]

For now, I am using the 2.4.18 ieee1394 code with the 2.4.19-pre8 kernel.
For the record, here is the dmesg output from this working case:

ohci1394: $Revision: 1.98 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[63]  MMIO=[80080000-80080800]  Max Packet=[2048]
ieee1394: NodeMgr: hotplug policy returned -2
ieee1394: Device added: Node[00:1023]  GUID[00000000204027a1]  [LaCie Group SA  ]
ieee1394: Host added: Node[01:1023]  GUID[00000000feeb324a]  [Linux OHCI-1394]

The working 2.4.18 ieee1394 code is dated February 26 while the broken
444 tarball code is dated April 4.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
