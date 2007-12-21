Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Dec 2007 15:39:36 +1100
Subject: [PATCH 19/21] [POWERPC] 4xx PCI-E Link setup improvements
Message-Id: <20071221043940.2C2B9DDED3@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This improves the way the 4xx PCI-E code handles checking for a link
and adds explicit testing of CRS result codes on config space accesses.

This should make it more reliable.

Also, bridges with no link are now still created, though config space
accesses beyond the root complex are filtered. This is one step toward
eventually supporting hotplug.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/sysdev/ppc4xx_pci.c |  222 +++++++++++++++++++++++----------------
 arch/powerpc/sysdev/ppc4xx_pci.h |    2 
 2 files changed, 134 insertions(+), 90 deletions(-)

--- linux-merge.orig/arch/powerpc/sysdev/ppc4xx_pci.c	2007-12-18 11:21:49.000000000 +1100
+++ linux-merge/arch/powerpc/sysdev/ppc4xx_pci.c	2007-12-19 15:45:19.000000000 +1100
@@ -16,6 +16,8 @@
  *
  */
 
+#undef DEBUG
+
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
@@ -531,10 +533,13 @@ struct ppc4xx_pciex_port
 	struct device_node	*node;
 	unsigned int		index;
 	int			endpoint;
+	int			link;
+	int			has_ibpre;
 	unsigned int		sdr_base;
 	dcr_host_t		dcrs;
 	struct resource		cfg_space;
 	struct resource		utl_regs;
+	void __iomem		*utl_base;
 };
 
 static struct ppc4xx_pciex_port *ppc4xx_pciex_ports;
@@ -706,29 +711,44 @@ static int ppc440spe_pciex_init_port_hw(
 	return 0;
 }
 
-static int ppc440speA_pciex_init_utl(struct ppc4xx_pciex_port *port)
+static int ppc440speA_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
+{
+	return ppc440spe_pciex_init_port_hw(port);
+}
+
+static int ppc440speB_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 {
-	void __iomem *utl_base;
+	int rc = ppc440spe_pciex_init_port_hw(port);
+
+	port->has_ibpre = 1;
+
+	return rc;
+}
 
+static int ppc440speA_pciex_init_utl(struct ppc4xx_pciex_port *port)
+{
 	/* XXX Check what that value means... I hate magic */
 	dcr_write(port->dcrs, DCRO_PEGPL_SPECIAL, 0x68782800);
 
-	utl_base = ioremap(port->utl_regs.start, 0x100);
-	BUG_ON(utl_base == NULL);
-
 	/*
 	 * Set buffer allocations and then assert VRB and TXE.
 	 */
-	out_be32(utl_base + PEUTL_OUTTR,   0x08000000);
-	out_be32(utl_base + PEUTL_INTR,    0x02000000);
-	out_be32(utl_base + PEUTL_OPDBSZ,  0x10000000);
-	out_be32(utl_base + PEUTL_PBBSZ,   0x53000000);
-	out_be32(utl_base + PEUTL_IPHBSZ,  0x08000000);
-	out_be32(utl_base + PEUTL_IPDBSZ,  0x10000000);
-	out_be32(utl_base + PEUTL_RCIRQEN, 0x00f00000);
-	out_be32(utl_base + PEUTL_PCTL,    0x80800066);
+	out_be32(port->utl_base + PEUTL_OUTTR,   0x08000000);
+	out_be32(port->utl_base + PEUTL_INTR,    0x02000000);
+	out_be32(port->utl_base + PEUTL_OPDBSZ,  0x10000000);
+	out_be32(port->utl_base + PEUTL_PBBSZ,   0x53000000);
+	out_be32(port->utl_base + PEUTL_IPHBSZ,  0x08000000);
+	out_be32(port->utl_base + PEUTL_IPDBSZ,  0x10000000);
+	out_be32(port->utl_base + PEUTL_RCIRQEN, 0x00f00000);
+	out_be32(port->utl_base + PEUTL_PCTL,    0x80800066);
 
-	iounmap(utl_base);
+	return 0;
+}
+
+static int ppc440speB_pciex_init_utl(struct ppc4xx_pciex_port *port)
+{
+	/* Report CRS to the operating system */
+	out_be32(port->utl_base + PEUTL_PBCTL,    0x08000000);
 
 	return 0;
 }
@@ -736,14 +756,15 @@ static int ppc440speA_pciex_init_utl(str
 static struct ppc4xx_pciex_hwops ppc440speA_pcie_hwops __initdata =
 {
 	.core_init	= ppc440spe_pciex_core_init,
-	.port_init_hw	= ppc440spe_pciex_init_port_hw,
+	.port_init_hw	= ppc440speA_pciex_init_port_hw,
 	.setup_utl	= ppc440speA_pciex_init_utl,
 };
 
 static struct ppc4xx_pciex_hwops ppc440speB_pcie_hwops __initdata =
 {
 	.core_init	= ppc440spe_pciex_core_init,
-	.port_init_hw	= ppc440spe_pciex_init_port_hw,
+	.port_init_hw	= ppc440speB_pciex_init_port_hw,
+	.setup_utl	= ppc440speB_pciex_init_utl,
 };
 
 
@@ -821,30 +842,21 @@ static int ppc405ex_pciex_init_port_hw(s
 
 static int ppc405ex_pciex_init_utl(struct ppc4xx_pciex_port *port)
 {
-	void __iomem *utl_base;
-
 	dcr_write(port->dcrs, DCRO_PEGPL_SPECIAL, 0x0);
 
-	utl_base = ioremap(port->utl_regs.start, 0x100);
-	BUG_ON(utl_base == NULL);
-
 	/*
 	 * Set buffer allocations and then assert VRB and TXE.
 	 */
-	out_be32(utl_base + PEUTL_OUTTR,   0x02000000);
-	out_be32(utl_base + PEUTL_INTR,    0x02000000);
-	out_be32(utl_base + PEUTL_OPDBSZ,  0x04000000);
-	out_be32(utl_base + PEUTL_PBBSZ,   0x21000000);
-	out_be32(utl_base + PEUTL_IPHBSZ,  0x02000000);
-	out_be32(utl_base + PEUTL_IPDBSZ,  0x04000000);
-	out_be32(utl_base + PEUTL_RCIRQEN, 0x00f00000);
-	out_be32(utl_base + PEUTL_PCTL,    0x80800066);
-
-	out_be32(utl_base + PEUTL_PBCTL,   0x0800000c);
-	out_be32(utl_base + PEUTL_RCSTA,
-		 in_be32(utl_base + PEUTL_RCSTA) | 0x000040000);
+	out_be32(port->utl_base + PEUTL_OUTTR,   0x02000000);
+	out_be32(port->utl_base + PEUTL_INTR,    0x02000000);
+	out_be32(port->utl_base + PEUTL_OPDBSZ,  0x04000000);
+	out_be32(port->utl_base + PEUTL_PBBSZ,   0x21000000);
+	out_be32(port->utl_base + PEUTL_IPHBSZ,  0x02000000);
+	out_be32(port->utl_base + PEUTL_IPDBSZ,  0x04000000);
+	out_be32(port->utl_base + PEUTL_RCIRQEN, 0x00f00000);
+	out_be32(port->utl_base + PEUTL_PCTL,    0x80800066);
 
-	iounmap(utl_base);
+	out_be32(port->utl_base + PEUTL_PBCTL,   0x08000000);
 
 	return 0;
 }
@@ -926,17 +938,29 @@ static void __init ppc4xx_pciex_port_ini
 	dcr_write(port->dcrs, DCRO_PEGPL_MSGMSK, 0);
 }
 
-static int __init ppc4xx_pciex_port_init(struct ppc4xx_pciex_port *port)
+static int __init ppc4xx_pciex_wait_on_sdr(struct ppc4xx_pciex_port *port,
+					   unsigned int sdr_offset,
+					   unsigned int mask,
+					   unsigned int value,
+					   int timeout_ms)
 {
-	int attempts, rc = 0;
 	u32 val;
 
-	/* Check if it's endpoint or root complex
-	 *
-	 * XXX Do we want to use the device-tree instead ? --BenH.
-	 */
-	val = mfdcri(SDR0, port->sdr_base + PESDRn_DLPSET);
-	port->endpoint = (((val >> 20) & 0xf) != PTYPE_ROOT_PORT);
+	while(timeout_ms--) {
+		val = mfdcri(SDR0, port->sdr_base + sdr_offset);
+		if ((val & mask) == value) {
+			pr_debug("PCIE%d: Wait on SDR %x success with tm %d (%08x)\n",
+				 port->index, sdr_offset, timeout_ms, val);
+			return 0;
+		}
+		msleep(1);
+	}
+	return -1;
+}
+
+static int __init ppc4xx_pciex_port_init(struct ppc4xx_pciex_port *port)
+{
+	int rc = 0;
 
 	/* Init HW */
 	if (ppc4xx_pciex_hwops->port_init_hw)
@@ -944,44 +968,40 @@ static int __init ppc4xx_pciex_port_init
 	if (rc != 0)
 		return rc;
 
-	/*
-	 * Notice: the following delay has critical impact on device
-	 * initialization - if too short (<50ms) the link doesn't get up.
-	 *
-	 * XXX FIXME: There are various issues with that link up thingy,
-	 * we could just wait for the link with a timeout but Stefan says
-	 * some cards need more time even after the link is up. I'll
-	 * investigate. For now, we keep a fixed 1s delay.
-	 *
-	 * Ultimately, it should be made asynchronous so all ports are
-	 * brought up simultaneously though.
-	 */
-	printk(KERN_INFO "PCIE%d: Waiting for link to go up...\n",
+	printk(KERN_INFO "PCIE%d: Checking link...\n",
 	       port->index);
-	msleep(1000);
-
-	/*
-	 * Check that we exited the reset state properly
-	 */
-	val = mfdcri(SDR0, port->sdr_base + PESDRn_RCSSTS);
-	if (val & (1 << 20)) {
-		printk(KERN_WARNING "PCIE%d: PGRST failed %08x\n",
-		       port->index, val);
-		return -1;
-	}
 
-	/*
-	 * Verify link is up
-	 */
-	val = mfdcri(SDR0, port->sdr_base + PESDRn_LOOP);
-	if (!(val & 0x00001000)) {
-		printk(KERN_INFO "PCIE%d: link is not up !\n",
+	/* Wait for reset to complete */
+	if (ppc4xx_pciex_wait_on_sdr(port, PESDRn_RCSSTS, 1 << 20, 0, 10)) {
+		printk(KERN_WARNING "PCIE%d: PGRST failed\n",
 		       port->index);
 		return -1;
 	}
 
-	printk(KERN_INFO "PCIE%d: link is up !\n",
-	       port->index);
+	/* Check for card presence detect if supported, if not, just wait for
+	 * link unconditionally.
+	 *
+	 * note that we don't fail if there is no link, we just filter out
+	 * config space accesses. That way, it will be easier to implement
+	 * hotplug later on.
+	 */
+	if (!port->has_ibpre ||
+	    !ppc4xx_pciex_wait_on_sdr(port, PESDRn_LOOP,
+				      1 << 28, 1 << 28, 100)) {
+		printk(KERN_INFO
+		       "PCIE%d: Device detected, waiting for link...\n",
+		       port->index);
+		if (ppc4xx_pciex_wait_on_sdr(port, PESDRn_LOOP,
+					     0x1000, 0x1000, 2000))
+			printk(KERN_WARNING
+			       "PCIE%d: Link up failed\n", port->index);
+		else {
+			printk(KERN_INFO
+			       "PCIE%d: link is up !\n", port->index);
+			port->link = 1;
+		}
+	} else
+		printk(KERN_INFO "PCIE%d: No device detected.\n", port->index);
 
 	/*
 	 * Initialize mapping: disable all regions and configure
@@ -990,12 +1010,13 @@ static int __init ppc4xx_pciex_port_init
 	ppc4xx_pciex_port_init_mapping(port);
 
 	/*
-	 * Setup UTL registers - but only on revA!
-	 * We use default settings for revB chip.
-	 *
-	 * To be reworked. We may also be able to move that to
-	 * before the link wait
-	 * --BenH.
+	 * Map UTL
+	 */
+	port->utl_base = ioremap(port->utl_regs.start, 0x100);
+	BUG_ON(port->utl_base == NULL);
+
+	/*
+	 * Setup UTL registers --BenH.
 	 */
 	if (ppc4xx_pciex_hwops->setup_utl)
 		ppc4xx_pciex_hwops->setup_utl(port);
@@ -1003,15 +1024,13 @@ static int __init ppc4xx_pciex_port_init
 	/*
 	 * Check for VC0 active and assert RDY.
 	 */
-	attempts = 10;
-	while (!(mfdcri(SDR0, port->sdr_base + PESDRn_RCSSTS) & (1 << 16))) {
-		if (!(attempts--)) {
-			printk(KERN_INFO "PCIE%d: VC0 not active\n",
-			       port->index);
-			return -1;
-		}
-		msleep(1000);
+	if (port->link &&
+	    ppc4xx_pciex_wait_on_sdr(port, PESDRn_RCSSTS,
+				     1 << 16, 1 << 16, 5000)) {
+		printk(KERN_INFO "PCIE%d: VC0 not active\n", port->index);
+		port->link = 0;
 	}
+
 	mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
 	       mfdcri(SDR0, port->sdr_base + PESDRn_RCSSET) | 1 << 20);
 	msleep(100);
@@ -1048,6 +1067,10 @@ static int ppc4xx_pciex_validate_bdf(str
 	    PCI_SLOT(devfn) != 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	/* Check if we have a link */
+	if ((bus->number != port->hose->first_busno) && !port->link)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	return 0;
 }
 
@@ -1092,6 +1115,9 @@ static int ppc4xx_pciex_read_config(stru
 	gpl_cfg = dcr_read(port->dcrs, DCRO_PEGPL_CFG);
 	dcr_write(port->dcrs, DCRO_PEGPL_CFG, gpl_cfg | GPL_DMER_MASK_DISA);
 
+	/* Make sure no CRS is recorded */
+	out_be32(port->utl_base + PEUTL_RCSTA, 0x00040000);
+
 	switch (len) {
 	case 1:
 		*val = in_8((u8 *)(addr + offset));
@@ -1109,6 +1135,14 @@ static int ppc4xx_pciex_read_config(stru
 		 bus->number, hose->first_busno, hose->last_busno,
 		 devfn, offset, len, addr + offset, *val);
 
+	/* Check for CRS (440SPe rev B does that for us but heh ..) */
+	if (in_be32(port->utl_base + PEUTL_RCSTA) & 0x00040000) {
+		pr_debug("Got CRS !\n");
+		if (len != 4 || offset != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		*val = 0xffff0001;
+	}
+
 	dcr_write(port->dcrs, DCRO_PEGPL_CFG, gpl_cfg);
 
 	return PCIBIOS_SUCCESSFUL;
@@ -1278,8 +1312,11 @@ static void __init ppc4xx_pciex_port_set
 	void __iomem *mbase = NULL, *cfg_data = NULL;
 
 	/* XXX FIXME: Handle endpoint mode properly */
-	if (port->endpoint)
+	if (port->endpoint) {
+		printk(KERN_WARNING "PCIE%d: Port in endpoint mode !\n",
+		       port->index);
 		return;
+	}
 
 	/* Check if primary bridge */
 	if (of_get_property(port->node, "primary", NULL))
@@ -1424,6 +1461,9 @@ static void __init ppc4xx_probe_pciex_br
 	}
 	port->sdr_base = *pval;
 
+	/* XXX Currently, we only support root complex mode */
+	port->endpoint = 0;
+
 	/* Fetch config space registers address */
 	if (of_address_to_resource(np, 0, &port->cfg_space)) {
 		printk(KERN_ERR "%s: Can't get PCI-E config space !",
@@ -1447,8 +1487,10 @@ static void __init ppc4xx_probe_pciex_br
 	port->dcrs = dcr_map(np, dcrs, dcr_resource_len(np, 0));
 
 	/* Initialize the port specific registers */
-	if (ppc4xx_pciex_port_init(port))
+	if (ppc4xx_pciex_port_init(port)) {
+		printk(KERN_WARNING "PCIE%d: Port init failed\n", port->index);
 		return;
+	}
 
 	/* Setup the linux hose data structure */
 	ppc4xx_pciex_port_setup_hose(port);
Index: linux-merge/arch/powerpc/sysdev/ppc4xx_pci.h
===================================================================
--- linux-merge.orig/arch/powerpc/sysdev/ppc4xx_pci.h	2007-12-18 11:21:49.000000000 +1100
+++ linux-merge/arch/powerpc/sysdev/ppc4xx_pci.h	2007-12-18 11:21:56.000000000 +1100
@@ -330,6 +330,8 @@
 /*
  * Config space register offsets
  */
+#define PECFG_ECRTCTL		0x074
+
 #define PECFG_BAR0LMPA		0x210
 #define PECFG_BAR0HMPA		0x214
 #define PECFG_BAR1MPA		0x218
