Message-ID: <004701c1d44e$3d643700$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Memory map on custom MPC7400 board
Date: Mon, 25 Mar 2002 17:41:43 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am porting the kernel.org 2.4.18 kernel to a custom PowerPC board
based on the MPC7400 processor.  I am using the gnu.org gcc-2.95.3
and binutils-2.11.2 tools and cross-compiling on i686.

My questions deal with memory mapping in the machine dependent layer
in (my)_setup.c - platform_init().  To provide hardware support for the
RTC and IRQ functions I need to use two DBATs to map a range of
384Mb.  The rtc and irq hardware lies between phys 0xE000_0000
and 0xF800_0000.  I plan to use DBAT2 and DBAT3 to map this
memory 1:1.  DBAT0 and DBAT1 are used to map 16Mb of RAM
from 0x0 (phys) to 0xC000_0000 (virt) for the kernel (this is the way
it came from kernel.org). Does anyone foresee any problems with this
approach?

On our board, there is 256Mb RAM at physical 0x0. Is there any reason why
I should not change the kernel to map all 256Mb of RAM at phys 0x0 to virt
0xC000_0000 with a single IBAT and DBAT?  This would allow me to use
a DBAT to map additional PCI bus space.

Thanks in advance for your help.

Greg Griffes

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
