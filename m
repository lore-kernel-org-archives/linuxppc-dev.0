Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 11 Aug 2011 16:16:54 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Josh Boyer <jwboyer@gmail.com>
Subject: 44x/pci: Add __init annotations for *init_port_hw() functions.
Message-ID: <20110811061654.GD20597@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The various port_init_hw methods of ppc4xx_pciex_hwops should have been
marked __init and when I added ppc4xx_pciex_port_reset_sdr(), which is
__init.  This added many section mismatch warnings like:

WARNING: arch/powerpc/sysdev/built-in.o(.text+0x5c68): Section mismatch in reference from the function ppc440spe_pciex_init_port_hw() to the function .init.text:ppc4xx_pciex_port_reset_sdr()
The function ppc440spe_pciex_init_port_hw() references
the function __init ppc4xx_pciex_port_reset_sdr().
This is often because ppc440spe_pciex_init_port_hw lacks a __init
annotation or the annotation of ppc4xx_pciex_port_reset_sdr is wrong.

Trivial patch to silence those warnings.

Reported-By: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index dbfe96b..60541a6 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -834,7 +834,7 @@ static int __init ppc440spe_pciex_core_init(struct device_node *np)
 	return 3;
 }
 
-static int ppc440spe_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+static int __init ppc440spe_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 {
 	u32 val = 1 << 24;
 
@@ -872,12 +872,12 @@ static int ppc440spe_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 	return ppc4xx_pciex_port_reset_sdr(port);
 }
 
-static int ppc440speA_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+static int __init ppc440speA_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 {
 	return ppc440spe_pciex_init_port_hw(port);
 }
 
-static int ppc440speB_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+static int __init ppc440speB_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 {
 	int rc = ppc440spe_pciex_init_port_hw(port);
 
@@ -936,7 +936,7 @@ static int __init ppc460ex_pciex_core_init(struct device_node *np)
 	return 2;
 }
 
-static int ppc460ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+static int __init ppc460ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 {
 	u32 val;
 	u32 utlset1;
@@ -1122,7 +1122,7 @@ static int __init ppc460sx_pciex_core_init(struct device_node *np)
 	return 2;
 }
 
-static int ppc460sx_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+static int __init ppc460sx_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 {
 
 	if (port->endpoint)
@@ -1189,7 +1189,7 @@ static void ppc405ex_pcie_phy_reset(struct ppc4xx_pciex_port *port)
 	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET, 0x00101000);
 }
 
-static int ppc405ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+static int __init ppc405ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 {
 	u32 val;
 
Yours Tony
