Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 2 Apr 2009 09:34:33 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: PPC_CELL_NATIVE should select PCI
In-Reply-To: <1238583750.17330.125.camel@pasglop>
Message-ID: <alpine.LRH.2.00.0904020931520.11458@vixen.sonytel.be>
References: <alpine.LRH.2.00.0904011141550.13419@vixen.sonytel.be>
	<1238579652.17330.124.camel@pasglop>
	<200904011245.01483.arnd@arndb.de>
	<1238583750.17330.125.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 1 Apr 2009, Benjamin Herrenschmidt wrote:
> On Wed, 2009-04-01 at 12:45 +0200, Arnd Bergmann wrote:
> > On Wednesday 01 April 2009, Benjamin Herrenschmidt wrote:
> > > On Wed, 2009-04-01 at 11:42 +0200, Geert Uytterhoeven wrote:
> > > > PPC_CELL_NATIVE selects PPC_OF_PLATFORM_PCI, but not the underlying PCI,
> > > > causing build failures if PCI is not set.
> > > 
> > > Maybe it should only select it if PCI is enabled ? Is qpace using PCI ?
> > 
> > No, QPACE does not have any PCI devices whatsoever.
> 
> so something like select PPC_OF_PLATFORM_PCI if PCI would work you
> think ?

I gave it a try. Patch below.
But that is still not sufficient:

| arch/powerpc/platforms/built-in.o:(.toc1+0x4e8): undefined reference to `pci_io_base'

due to arch/powerpc/platforms/cell/io-workarounds.c. I guess this file
shouldn't be built when CONFIG_PCI=n?

As I don't have the hardware to test anyway, I'll give up.

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 40e24c3..fa604b1 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -13,7 +13,7 @@ config PPC_CELL_COMMON
 config PPC_CELL_NATIVE
 	bool
 	select PPC_CELL_COMMON
-	select PPC_OF_PLATFORM_PCI
+	select PPC_OF_PLATFORM_PCI if PCI
 	select MPIC
 	select IBM_NEW_EMAC_EMAC4
 	select IBM_NEW_EMAC_RGMII
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 5930536..628b21f 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -81,6 +81,7 @@ static void cell_progress(char *s, unsigned short hex)
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
+#ifdef CONFIG_PCI
 static void cell_fixup_pcie_rootcomplex(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
@@ -141,6 +142,7 @@ static int __devinit cell_setup_phb(struct pci_controller *phb)
 
 	return 0;
 }
+#endif /* CONFIG_PCI */
 
 static int __init cell_publish_devices(void)
 {
@@ -287,5 +289,7 @@ define_machine(cell) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= cell_progress,
 	.init_IRQ       	= cell_init_irq,
+#ifdef CONFIG_PCI
 	.pci_setup_phb		= cell_setup_phb,
+#endif
 };

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
