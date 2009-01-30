Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id DC3ADDE0E0
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 23:35:43 +1100 (EST)
Date: Fri, 30 Jan 2009 13:35:22 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Broken PCI on Sequoia
In-Reply-To: <1233281333.18767.15.camel@pasglop>
Message-ID: <alpine.LRH.2.00.0901301334220.13283@vixen.sonytel.be>
References: <alpine.LRH.2.00.0901291819440.22142@vixen.sonytel.be>
	<1233267061.18767.5.camel@pasglop>
	<20090130001842.GB3943@zod.rchland.ibm.com>
	<1233281333.18767.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 Jan 2009, Benjamin Herrenschmidt wrote:
> > Yeah.  In fact, I think you have that bug in almost every board.  You only
> > updated Bamboo and Canyonlands with the initial patch and the changelog
> > says "other boards can be updated separately."  Nobody did that.  So not
> > so weird after all.
> 
> I still don't see off hand what's wrong in the code..
> 
> Geert, any chance you can sprinkle printk's in
> ppc4xx_configure_pci_PMMs() ? I'd like to see the arguments to the
> various calls to ppc4xx_setup_one_pci_PMM(), and the value of
> hose->pci_mem_offset and hose->isa_mem_phys & size.

| PCI host bridge /plb/pci@1ec000000 (primary) ranges:
|  MEM 0x0000000180000000..0x00000001bfffffff -> 0x0000000080000000 
|   IO 0x00000001e8000000..0x00000001e800ffff -> 0x0000000000000000
|   IO 0x00000001e8800000..0x00000001ebffffff -> 0x0000000000000000
|  \--> Skipped (too many) !
| 4xx PCI DMA offset set to 0x00000000
| ppc4xx_configure_pci_PMMs: i = 0, hose->pci_mem_offset = 0x100000000
| ppc4xx_setup_one_pci_PMM:     hose = 0xcf825000
| ppc4xx_setup_one_pci_PMM:     reg = 0xd1000000
| ppc4xx_setup_one_pci_PMM:     plb_addr = 0x180000000
| ppc4xx_setup_one_pci_PMM:     pci_addr = 0x80000000
| ppc4xx_setup_one_pci_PMM:     size = 0x40000000
| ppc4xx_setup_one_pci_PMM:     flags = 0x200
| ppc4xx_setup_one_pci_PMM:     index = 0
| /plb/pci@1ec000000: Resource out of range
                      ^^^^^^^^^^^^^^^^^^^^^
because plb_addr + size lies outside 32-bit space.

| ppc4xx_configure_pci_PMMs: hose->isa_mem_phys = 0x0, hose->isa_mem_size = 0x0
| PCI: Probing PCI hardware
| PCI: Hiding 4xx host bridge resources 0000:00:00.0
| pci 0000:00:0a.0: PME# supported from D0 D1 D2 D3hot
| pci 0000:00:0a.0: PME# disabled
| pci 0000:00:0a.1: PME# supported from D0 D1 D2 D3hot
| pci 0000:00:0a.1: PME# disabled
| pci 0000:00:0a.2: PME# supported from D0 D1 D2 D3hot
| pci 0000:00:0a.2: PME# disabled

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 77fae5f..70684ee 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -16,6 +16,8 @@
  *
  */
 
+#define pr_fmt(fmt)  "%s: " fmt, __func__
+
 #undef DEBUG
 
 #include <linux/kernel.h>
@@ -204,6 +206,13 @@ static int __init ppc4xx_setup_one_pci_PMM(struct pci_controller	*hose,
 {
 	u32 ma, pcila, pciha;
 
+pr_info("    hose = 0x%p\n", hose);
+pr_info("    reg = 0x%p\n", reg);
+pr_info("    plb_addr = 0x%llx\n", plb_addr);
+pr_info("    pci_addr = 0x%llx\n", pci_addr);
+pr_info("    size = 0x%llx\n", size);
+pr_info("    flags = 0x%x\n", flags);
+pr_info("    index = %d\n", index);
 	if ((plb_addr + size) > 0xffffffffull || !is_power_of_2(size) ||
 	    size < 0x1000 || (plb_addr & (size - 1)) != 0) {
 		printk(KERN_WARNING "%s: Resource out of range\n",
@@ -244,6 +253,7 @@ static void __init ppc4xx_configure_pci_PMMs(struct pci_controller *hose,
 		}
 
 		/* Configure the resource */
+pr_info("i = %d, hose->pci_mem_offset = 0x%llx\n", i, hose->pci_mem_offset);
 		if (ppc4xx_setup_one_pci_PMM(hose, reg,
 					     res->start,
 					     res->start - hose->pci_mem_offset,
@@ -260,6 +270,7 @@ static void __init ppc4xx_configure_pci_PMMs(struct pci_controller *hose,
 		}
 	}
 
+pr_info("hose->isa_mem_phys = 0x%llx, hose->isa_mem_size = 0x%llx\n", hose->isa_mem_phys, hose->isa_mem_size);
 	/* Handle ISA memory hole if not already covered */
 	if (j <= 2 && !found_isa_hole && hose->isa_mem_size)
 		if (ppc4xx_setup_one_pci_PMM(hose, reg, hose->isa_mem_phys, 0,

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
