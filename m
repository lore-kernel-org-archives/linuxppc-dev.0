Date: Sat, 12 Aug 2000 00:16:20 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: netboot on CHRP B50
Message-ID: <20000812001620.A21670@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

while trying netboot with our machines we found a bug either in the
kernel or in the pcnet32 network driver.

If we boot with "boot net" from the OF prompt everything works fine.
Booting the same kernel with "boot net console=ttyS0[,9600]" kills the
network driver, in this case pcnet32.
There are 2 cards in the machine, only the first card was found. The
interface was up, but not network traffic. The TX line of ifconfig
contains errors but no transmitted packages.

The dmesg output contains no infos that something is wrong with the
card, no errors.

This is the normal output:

pcnet32.c: PCI bios is present, checking for devices...
PCI Master Bit has not been set. Setting...
Found PCnet/PCI at 0xbff400, irq 22.
eth0: PCnet/FAST 79C971 at 0xbff400, 00 04 ac 97 35 56
tx_start_pt(0x0400):  64 bytes, BCR18(6821):BurstWrEn NoUFlow
SRAMSIZE=0x7f00, SRAM_BND=0x4000, assigned IRQ 22.
pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de
PCI Master Bit has not been set. Setting...
Found PCnet/PCI at 0xbff800, irq 18.
eth1: PCnet/FAST 79C971 at 0xbff800, 00 04 ac de 53 bf
tx_start_pt(0x0400):  64 bytes, BCR18(6821):BurstWrEn NoUFlow
SRAMSIZE=0x7f00, SRAM_BND=0x4000, assigned IRQ 18.
pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de

This is the output with a boot arg:

pcnet32.c: PCI bios is present, checking for devices...
PCI Master Bit has not been set. Setting...
Found PCnet/PCI at 0xbff400, irq 22.
PCI Master Bit has not been set. Setting...
Found PCnet/PCI at 0xbff800, irq 18.
eth0: PCnet/FAST 79C971 at 0xbff800, 00 04 ac de 53 bf
tx_start_pt(0x0400):  64 bytes, BCR18(6821):BurstWrEn NoUFlow
SRAMSIZE=0x7f00, SRAM_BND=0x4000, assigned IRQ 18.
pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de


Hmm, that means that the eth0 is still active and the older eth1 becomes
eth0 now.
Looks like we have to shutdown the card first. I wonder why it works
without a bootarg.

Any hints?



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
