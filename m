Return-Path: <benh@ozlabs.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 02 Feb 2009 11:24:18 +1100
Subject: [PATCH] powerpc/44x: Fix address decoding setup of PCI 2.x cells
Message-Id: <20090202002429.ADA74DDF43@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCI 2.x cells used on some 44x SoCs only let us configure the decode
for the low 32-bit of the incoming PLB addresses. The top 4 bits (this
is a 36-bit bus) are hard wired to different values depending on the
specific SoC in use. Our code used to work "by accident" until I added
support for the ISA memory holes and while at it added more validity
checking of the addresses.

This patch should bring it back to working condition. It still relies
on the device-tree being correct but that's somewhat a pre-requisite
for anything to work anyway.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is untested. Geert, can you give it a go on Sequoia and let me
know if it fixes your problem ?

 arch/powerpc/sysdev/ppc4xx_pci.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- linux-work.orig/arch/powerpc/sysdev/ppc4xx_pci.c	2009-02-02 11:15:35.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/ppc4xx_pci.c	2009-02-02 11:19:03.000000000 +1100
@@ -204,6 +204,23 @@ static int __init ppc4xx_setup_one_pci_P
 {
 	u32 ma, pcila, pciha;
 
+	/* Hack warning ! The "old" PCI 2.x cell only let us configure the low
+	 * 32-bit of incoming PLB addresses. The top 4 bits of the 36-bit
+	 * address are actually hard wired to a value that appears to depend
+	 * on the specific SoC. For example, it's 0 on 440EP and 1 on 440EPx.
+	 *
+	 * The trick here is we just crop those top bits and ignore them when
+	 * programming the chip. That means the device-tree has to be right
+	 * for the specific part used (we don't print a warning if it's wrong
+	 * but on the other hand, you'll crash quickly enough), but at least
+	 * this code should work whatever the hard coded value is
+	 */
+	plb_addr &= 0xffffffffull;
+
+	/* Note: Due to the above hack, the test below doesn't actually test
+	 * if you address is above 4G, but it tests that address and
+	 * (address + size) are both contained in the same 4G
+	 */
 	if ((plb_addr + size) > 0xffffffffull || !is_power_of_2(size) ||
 	    size < 0x1000 || (plb_addr & (size - 1)) != 0) {
 		printk(KERN_WARNING "%s: Resource out of range\n",
