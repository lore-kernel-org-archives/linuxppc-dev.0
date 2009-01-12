Return-Path: <dsd@gentoo.org>
Received: from queueout02-winn.ispmail.ntl.com
	(queueout02-winn.ispmail.ntl.com [81.103.221.56])
	by ozlabs.org (Postfix) with ESMTP id 27532DE108
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 22:46:36 +1100 (EST)
Message-ID: <496B2983.2030601@gentoo.org>
Date: Mon, 12 Jan 2009 11:29:07 +0000
From: Daniel Drake <dsd@gentoo.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: can't mmap PCI legacy_mem on Powerbook G4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, dliana@frontiernet.net,
	linux kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Dave reports a 2.6.28 regression here:
https://bugs.gentoo.org/show_bug.cgi?id=253149

X (server v1.5.3) no longer starts, it aborts with a mmap() error.


This is because X tries to use sysfs pci legacy_mem to map the VGA frame 
buffer if it is available, and this became available in 2.6.28 for ppc, 
but the mmap() fails with -ENXIO.

(Arguably, xserver should fallback on the old /proc approach when mmap 
fails, we're working on that too)

The memory map for the system is:
Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus 
number: 0->0
PCI host bridge /pci@f0000000  ranges:
   MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000
    IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
   MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000090000000
  Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus 
number: 0->0
PCI host bridge /pci@f2000000 (primary) ranges:
   MEM 0x00000000f3000000..0x00000000f3ffffff -> 0x00000000f3000000
    IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
   MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000
Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus 
number: 0->0
PCI host bridge /pci@f4000000  ranges:
   MEM 0x00000000f5000000..0x00000000f5ffffff -> 0x00000000f5000000
    IO 0x00000000f4000000..0x00000000f47fffff -> 0x0000000000000000

Full dmesg here:
https://bugs.gentoo.org/attachment.cgi?id=178141&action=view


strace excerpt from X:
open("/sys/class/pci_bus/0000:00/legacy_mem", O_RDWR) = 9
mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_SHARED, 9, 0xa0000) = -1 
ENXIO (No such device or address)


Confirmed with printk debugging, the code that produces the -ENXIO 
condition can be found in arch/powerpc/kernel/pci-common.c 
pci_mmap_legacy_page_range()

		if ((offset + size) > hose->isa_mem_size)
			return -ENXIO;

In this case, hose->isa_mem_size=0 (and offset=655360, size=65536)

As far as I can see, isa_mem_size only ever gets set if a PCI memory 
space is addressed to address 0, which it is not on this system (only IO 
regions get mapped there).

Is this a bug, or is mmap doing the correct thing by failing here?

Given the comment in pci-bridge.h:
	/* Some machines have a special region to forward the ISA
	 * "memory" cycles such as VGA memory regions. Left to 0
	 * if unsupported
	 */

Should this check instead be:
  if (hose->isa_mem_size && ((offset + size) > hose->isa_mem_size))  ?

cheers
Daniel
