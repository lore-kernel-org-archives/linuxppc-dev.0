Date: Tue, 1 Oct 2002 15:21:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021001052121.GV10265@zax>
References: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com> <20020930040143.GF10265@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020930040143.GF10265@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 30, 2002 at 02:01:43PM +1000, David Gibson wrote:
>
> On Fri, Sep 27, 2002 at 08:27:35AM -0400, Ralph Blach wrote:
> >
> > Yesterday I discovered a minor 405GP vs 405GPr PCI difference.
> > IN the 405GP the ptm1ms bit 31, the enable bit for the region is set to 1
> > by the hardware and cannot be written.
> > On the 405GPr the bit is writable and this makes necessitates  a change in
> > walnut.c
> >
> > In walnut.c there is the line
> >
> > out_le32((void *) &(pcip->ptm1ms), 0x00000000);
> >
> > On the walnut, this would work fine because bit 31 cannot be written to a
> > 0,
> > On the GPr, this disables the regions and PCI no longer functions.
> > The line should be changed to
> >
> > out_le32((void*)&(pcip->ptm1ms),0x000000001);
> >
> > This will fix the 405GPr and make no difference to the 405GP since the bit
> > is permanently to 1.
>
> I would put it more strongly than that:  this is a bug, which we just
> happen to get away with because of the behaviour of the 405GP.
>
> The arrangement of the code in walnut.c suggests some confusion
> between the PLB->PCI and PCI->PLB windows, which is probably the
> origin of the bug (the fact that the 405GP numbers the former from 0
> and the latter from 1 probably didn't help).
>
> The fix you've suggested should be correct for Walnut, and probably
> the other places that that code has been copied.  I tend to think,
> though, that this configuration of the 4xx PCI bridge should be moved
> out of the board code and into ppc4xx_pci.c.  If we do that, though we
> should fully configure the PTMs, to wit:
> 	out_le32((void *) &(pcip->ptm1ms), 0x00000000);
> 	out_le32((void *) &(pcip->ptm1la), 0x00000000);
> 	out_le32((void *) &(pcip->ptm1ms), 0x80000001);
> 	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
>
> Which should configure the PCI bridge to match the comments in
> walnut.c (i.e. map PCI addresses 0x00000000-0x7fffffff to
> corresponding PLB addresses).

So, here is a patch to do that.  If there are no objections, I will
commit this to linuxppc-2.5 BK.

diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/kernel/4xx/ppc405_pci.c linux-bluefish/arch/ppc/kernel/4xx/ppc405_pci.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/kernel/4xx/ppc405_pci.c	2002-09-19 16:08:05.000000000 +1000
+++ linux-bluefish/arch/ppc/kernel/4xx/ppc405_pci.c	2002-10-01 15:14:57.000000000 +1000
@@ -53,7 +53,6 @@
 #include <asm/ibm_ocp_pci.h>


-extern void bios_fixup(struct pci_controller *, struct pcil0_regs *);
 extern int ppc405_map_irq(struct pci_dev *dev, unsigned char idsel,
 			  unsigned char pin);

@@ -112,6 +111,110 @@
 	return (bus == 0 && devfn == 0);
 }

+static void __init
+bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
+{
+#ifdef CONFIG_BIOS_FIXUP
+	unsigned int bar_response, bar;
+	/*
+	 * Expected PCI mapping:
+	 *
+	 *  PLB addr             PCI memory addr
+	 *  ---------------------       ---------------------
+	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
+	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
+	 *
+	 *  PLB addr             PCI io addr
+	 *  ---------------------       ---------------------
+	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
+	 *
+	 * The following code is simplified by assuming that the bootrom
+	 * has been well behaved in following this mapping.
+	 */
+
+#ifdef DEBUG
+	int i;
+
+	printk(KERN_DEBUG "ioremap PCLIO_BASE = 0x%p\n", pcip);
+	printk(KERN_DEBUG "PCI bridge regs before fixup \n");
+	for (i = 0; i <= 3; i++) {
+		printk(KERN_DEBUG " pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
+		printk(KERN_DEBUG " pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
+		printk(KERN_DEBUG " pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
+		printk(KERN_DEBUG " pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
+	}
+	printk(KERN_DEBUG " ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
+	printk(KERN_DEBUG " ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
+	printk(KERN_DEBUG " ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
+	printk(KERN_DEBUG " ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
+#endif
+
+	/* First set up the PLB->PCI window, we only use PMM0 */
+
+	/* Disable region first */
+	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
+	/* PLB starting addr, PCI: 0x80000000 */
+	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
+	/* PCI start addr, 0x80000000 */
+	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
+	/* 512MB range of PLB to PCI */
+	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
+	/* Enable no pre-fetch, enable region */
+	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
+						(PPC405_PCI_UPPER_MEM -
+						 PPC405_PCI_MEM_BASE)) | 0x01));
+
+	/* Disable region one */
+	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
+
+	/* Disable region two */
+	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
+
+	/* Now configure the PCI->PLB windows, we only use PTM1 */
+	out_le32((void *) &(pcip->ptm1ms), 0x00000000); /* first disable */
+	out_le32((void *) &(pcip->ptm1la), 0x00000000); /* base address */
+	out_le32((void *) &(pcip->ptm1ms), 0x80000001); /* re-enable */
+	out_le32((void *) &(pcip->ptm2ms), 0x00000000); /* disable PTM2 */
+
+	/* Zero config bars */
+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
+		early_write_config_dword(hose, hose->first_busno,
+					 PCI_FUNC(hose->first_busno), bar,
+					 0x00000000);
+		early_read_config_dword(hose, hose->first_busno,
+					PCI_FUNC(hose->first_busno), bar,
+					&bar_response);
+		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
+		    hose->first_busno, PCI_SLOT(hose->first_busno),
+		    PCI_FUNC(hose->first_busno), bar, bar_response);
+	}
+	/* end work arround */
+
+#ifdef DEBUG
+	printk(KERN_DEBUG "PCI bridge regs after fixup \n");
+	for (i = 0; i <= 3; i++) {
+		printk(KERN_DEBUG " pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
+		printk(KERN_DEBUG " pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
+		printk(KERN_DEBUG " pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
+		printk(KERN_DEBUG " pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
+	}
+	printk(KERN_DEBUG " ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
+	printk(KERN_DEBUG " ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
+	printk(KERN_DEBUG " ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
+	printk(KERN_DEBUG " ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
+
+#endif /* DEBUG */
+#endif /* CONFIG_BIOS_FIXUP */
+}
+
 void
 ppc4xx_find_bridges(void)
 {
@@ -143,10 +246,8 @@

 	pcip = ioremap((unsigned long) ocp_get_paddr(OCP_FUNC_PCI, 0), PAGE_SIZE);
 	if (pcip != NULL) {
-
-#if defined(CONFIG_BIOS_FIXUP)
 		bios_fixup(hose_a, pcip);
-#endif
+
 		new_pmm_min = 0xffffffff;
 		for (reg_index = 0; reg_index < 3; reg_index++) {
 			tmp_size = in_le32((void *) &(pcip->pmm[reg_index].ma));	// *_PMM0MA
diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/ash.c linux-bluefish/arch/ppc/platforms/4xx/ash.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/ash.c	2002-09-19 16:08:06.000000000 +1000
+++ linux-bluefish/arch/ppc/platforms/4xx/ash.c	2002-10-01 15:06:13.000000000 +1000
@@ -95,137 +95,6 @@
 }

 void __init
-bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
-{
-
-	unsigned int bar_response, bar;
-	/*
-	 * Expected PCI mapping:
-	 *
-	 *  PLB addr             PCI memory addr
-	 *  ---------------------       ---------------------
-	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
-	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
-	 *
-	 *  PLB addr             PCI io addr
-	 *  ---------------------       ---------------------
-	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
-	 *
-	 * The following code is simplified by assuming that the bootrom
-	 * has been well behaved in following this mapping.
-	 */
-
-#ifdef DEBUG
-	int i;
-
-	printk("ioremap PCLIO_BASE = 0x%x\n", pcip);
-	printk("PCI bridge regs before fixup \n");
-	for (i = 0; i <= 2; i++) {
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dla\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dpcila\t0x%x\n", i,
-		       in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dpciha\t0x%x\n", i,
-		       in_le32(&(pcip->pmm[i].pciha)));
-	}
-	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
-	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
-	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
-	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
-	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
-		early_read_config_dword(hose, hose->first_busno,
-					PCI_FUNC(hose->first_busno), bar,
-					&bar_response);
-		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
-		    hose->first_busno, PCI_SLOT(hose->first_busno),
-		    PCI_FUNC(hose->first_busno), bar, bar_response);
-	}
-
-#endif
-	if (ppc_md.progress)
-		ppc_md.progress("bios_fixup(): enter", 0x800);
-
-	/* added for IBM boot rom version 1.15 bios bar changes  -AK */
-
-	/* Disable region first */
-	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
-	/* PLB starting addr, PCI: 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
-	/* PCI start addr, 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
-	/* 512MB range of PLB to PCI */
-	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
-	/* Enable no pre-fetch, enable region */
-	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
-						(PPC405_PCI_UPPER_MEM -
-						 PPC405_PCI_MEM_BASE)) | 0x01));
-
-	/* Disable region one */
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-
-	/* Disable region two */
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-
-	/* Enable PTM1 and PTM2, mapped to PLB address 0. */
-
-	out_le32((void *) &(pcip->ptm1la), 0x00000000);
-	out_le32((void *) &(pcip->ptm1ms), 0x00000001);
-	out_le32((void *) &(pcip->ptm2la), 0x00000000);
-	out_le32((void *) &(pcip->ptm2ms), 0x00000001);
-
-	/* Write zero to PTM1 BAR. */
-
-	early_write_config_dword(hose, hose->first_busno,
-				 PCI_FUNC(hose->first_busno),
-				 PCI_BASE_ADDRESS_1,
-				 0x00000000);
-
-	/* Disable PTM2 (unused) */
-
-	out_le32((void *) &(pcip->ptm2la), 0x00000000);
-	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
-
-	/* end work arround */
-	if (ppc_md.progress)
-		ppc_md.progress("bios_fixup(): done", 0x800);
-
-#ifdef DEBUG
-	printk("PCI bridge regs after fixup \n");
-	for (i = 0; i <= 2; i++) {
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dla\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dpcila\t0x%x\n", i,
-		       in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dpciha\t0x%x\n", i,
-		       in_le32(&(pcip->pmm[i].pciha)));
-	}
-	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
-	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
-	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
-	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
-
-	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
-		early_read_config_dword(hose, hose->first_busno,
-					PCI_FUNC(hose->first_busno), bar,
-					&bar_response);
-		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
-		    hose->first_busno, PCI_SLOT(hose->first_busno),
-		    PCI_FUNC(hose->first_busno), bar, bar_response);
-	}
-
-
-#endif
-}
-
-void __init
 board_io_mapping(void)
 {
 	io_block_mapping(ASH_RTC_VADDR, ASH_RTC_PADDR, ASH_RTC_SIZE, _PAGE_IO);
diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/ep405.c linux-bluefish/arch/ppc/platforms/4xx/ep405.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/ep405.c	2002-09-19 16:08:06.000000000 +1000
+++ linux-bluefish/arch/ppc/platforms/4xx/ep405.c	2002-10-01 15:05:32.000000000 +1000
@@ -71,73 +71,6 @@
 }

 void __init
-bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
-{
-	unsigned int bar_response, bar;
-	/*
-	 * Expected PCI mapping:
-	 *
-	 *  PLB addr             PCI memory addr
-	 *  ---------------------       ---------------------
-	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
-	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
-	 *
-	 *  PLB addr             PCI io addr
-	 *  ---------------------       ---------------------
-	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
-	 *
-	 */
-
-	/* Disable region zero first */
-	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
-	/* PLB starting addr, PCI: 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
-	/* PCI start addr, 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
-	/* 512MB range of PLB to PCI */
-	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
-	/* Enable no pre-fetch, enable region */
-	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
-						(PPC405_PCI_UPPER_MEM -
-						 PPC405_PCI_MEM_BASE)) | 0x01));
-
-	/* Disable region one */
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm1ms), 0x00000000);
-
-	/* Disable region two */
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
-
-	/* Configure PTM (PCI->PLB) region 1 */
-	out_le32((void *) &(pcip->ptm1la), 0x00000000); /* PLB base address */
-	/* Disable PTM region 2 */
-	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
-
-	/* Zero config bars */
-	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
-		early_write_config_dword(hose, hose->first_busno,
-					 PCI_FUNC(hose->first_busno), bar,
-					 0x00000000);
-		early_read_config_dword(hose, hose->first_busno,
-					PCI_FUNC(hose->first_busno), bar,
-					&bar_response);
-		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
-		    hose->first_busno, PCI_SLOT(hose->first_busno),
-		    PCI_FUNC(hose->first_busno), bar, bar_response);
-	}
-	/* end work arround */
-}
-
-void __init
 board_io_mapping(void)
 {
 	bd_t *bip = (bd_t *) __res;
diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/rainier.c linux-bluefish/arch/ppc/platforms/4xx/rainier.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/rainier.c	2002-09-19 16:08:06.000000000 +1000
+++ linux-bluefish/arch/ppc/platforms/4xx/rainier.c	2002-10-01 15:05:42.000000000 +1000
@@ -109,90 +109,6 @@
 }

 void __init
-bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
-{
-	/*
-	 * Expected PCI mapping:
-	 *
-	 *  PLB addr             PCI memory addr
-	 *  ---------------------       ---------------------
-	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
-	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
-	 *
-	 *  PLB addr             PCI io addr
-	 *  ---------------------       ---------------------
-	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
-	 *
-	 * The following code is simplified by assuming that the bootrom
-	 * has been well behaved in following this mapping.
-	 */
-
-#ifdef DEBUG
-	int i;
-
-	printk("ioremap PCLIO_BASE = 0x%x\n", pcip);
-	printk("PCI bridge regs before fixup \n");
-	for (i = 0; i <= 3; i++) {
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
-	}
-	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
-	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
-	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
-	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
-
-#endif
-
-	/* Disable region first */
-	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
-	/* PLB starting addr, PCI: 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
-	/* PCI start addr, 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
-	/* 512MB range of PLB to PCI */
-	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
-	/* Enable no pre-fetch, enable region */
-	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
-						(PPC405_PCI_UPPER_MEM -
-						 PPC405_PCI_MEM_BASE)) | 0x01));
-
-	/*region one used bu rainier*/
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].la), 0x80000000);
-	out_le32((void *) &(pcip->pmm[1].pcila), 0x80000000);
-	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].ma), 0xFFFF8001);
-	out_le32((void *) &(pcip->ptm1ms), 0x00000000);
-
-	/* Disable region two */
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
-
-	/* end work arround */
-
-#ifdef DEBUG
-	printk("PCI bridge regs after fixup \n");
-	for (i = 0; i <= 3; i++) {
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
-	}
-	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
-	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
-	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
-	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
-
-#endif
-}
-
-void __init
 board_io_mapping(void)
 {
 	io_block_mapping(RAINIER_IO_PAGE_INTERPOSER_PADDR,
diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/sycamore.c linux-bluefish/arch/ppc/platforms/4xx/sycamore.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/sycamore.c	2002-09-19 16:08:06.000000000 +1000
+++ linux-bluefish/arch/ppc/platforms/4xx/sycamore.c	2002-10-01 15:05:55.000000000 +1000
@@ -168,108 +168,6 @@
 }

 void __init
-bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
-{
-#ifdef CONFIG_PCI
-	unsigned int bar_response, bar;
-	/*
-	 * Expected PCI mapping:
-	 *
-	 *  PLB addr             PCI memory addr
-	 *  ---------------------       ---------------------
-	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
-	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
-	 *
-	 *  PLB addr             PCI io addr
-	 *  ---------------------       ---------------------
-	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
-	 *
-	 * The following code is simplified by assuming that the bootrom
-	 * has been well behaved in following this mapping.
-	 */
-
-#ifdef DEBUG
-	int i;
-
-	printk("ioremap PCLIO_BASE = 0x%x\n", pcip);
-	printk("PCI bridge regs before fixup \n");
-	for (i = 0; i <= 3; i++) {
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
-	}
-	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
-	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
-	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
-	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
-
-#endif
-
-	/* added for IBM boot rom version 1.15 bios bar changes  -AK */
-
-	/* Disable region first */
-	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
-	/* PLB starting addr, PCI: 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
-	/* PCI start addr, 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
-	/* 512MB range of PLB to PCI */
-	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
-	/* Enable no pre-fetch, enable region */
-	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
-						(PPC405_PCI_UPPER_MEM -
-						 PPC405_PCI_MEM_BASE)) | 0x01));
-
-	/* Disable region one */
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm1ms), 0x00000000);
-
-	/* Disable region two */
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
-
-	/* Zero config bars */
-	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
-		early_write_config_dword(hose, hose->first_busno,
-					 PCI_FUNC(hose->first_busno), bar,
-					 0x00000000);
-		early_read_config_dword(hose, hose->first_busno,
-					PCI_FUNC(hose->first_busno), bar,
-					&bar_response);
-		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
-		    hose->first_busno, PCI_SLOT(hose->first_busno),
-		    PCI_FUNC(hose->first_busno), bar, bar_response);
-	}
-	/* end work arround */
-
-#ifdef DEBUG
-	printk("PCI bridge regs after fixup \n");
-	for (i = 0; i <= 3; i++) {
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
-	}
-	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
-	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
-	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
-	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
-
-#endif
-#endif
-
-}
-
-void __init
 board_io_mapping(void)
 {
 	io_block_mapping(SYCAMORE_RTC_VADDR,
diff -urN /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/walnut.c linux-bluefish/arch/ppc/platforms/4xx/walnut.c
--- /home/dgibson/kernel/linuxppc-2.5/arch/ppc/platforms/4xx/walnut.c	2002-09-19 16:08:06.000000000 +1000
+++ linux-bluefish/arch/ppc/platforms/4xx/walnut.c	2002-10-01 15:05:22.000000000 +1000
@@ -128,107 +128,6 @@
 }

 void __init
-bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
-{
-#ifdef (CONFIG_PCI)
-	unsigned int bar_response, bar;
-	/*
-	 * Expected PCI mapping:
-	 *
-	 *  PLB addr             PCI memory addr
-	 *  ---------------------       ---------------------
-	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
-	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
-	 *
-	 *  PLB addr             PCI io addr
-	 *  ---------------------       ---------------------
-	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
-	 *
-	 * The following code is simplified by assuming that the bootrom
-	 * has been well behaved in following this mapping.
-	 */
-
-#ifdef DEBUG
-	int i;
-
-	printk("ioremap PCLIO_BASE = 0x%x\n", pcip);
-	printk("PCI bridge regs before fixup \n");
-	for (i = 0; i <= 3; i++) {
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
-	}
-	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
-	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
-	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
-	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
-
-#endif
-
-	/* added for IBM boot rom version 1.15 bios bar changes  -AK */
-
-	/* Disable region first */
-	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
-	/* PLB starting addr, PCI: 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
-	/* PCI start addr, 0x80000000 */
-	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
-	/* 512MB range of PLB to PCI */
-	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
-	/* Enable no pre-fetch, enable region */
-	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
-						(PPC405_PCI_UPPER_MEM -
-						 PPC405_PCI_MEM_BASE)) | 0x01));
-
-	/* Disable region one */
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm1ms), 0x00000000);
-
-	/* Disable region two */
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
-	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
-	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
-
-	/* Zero config bars */
-	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
-		early_write_config_dword(hose, hose->first_busno,
-					 PCI_FUNC(hose->first_busno), bar,
-					 0x00000000);
-		early_read_config_dword(hose, hose->first_busno,
-					PCI_FUNC(hose->first_busno), bar,
-					&bar_response);
-		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
-		    hose->first_busno, PCI_SLOT(hose->first_busno),
-		    PCI_FUNC(hose->first_busno), bar, bar_response);
-	}
-	/* end work arround */
-
-#ifdef DEBUG
-	printk("PCI bridge regs after fixup \n");
-	for (i = 0; i <= 3; i++) {
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
-		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
-	}
-	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
-	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
-	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
-	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
-
-#endif
-#endif
-}
-
-void __init
 board_io_mapping(void)
 {
 	io_block_mapping(WALNUT_RTC_VADDR,


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
