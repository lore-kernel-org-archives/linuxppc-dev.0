Return-Path: <tony@bakeyournoodle.com>
Date: Fri, 1 Jul 2011 16:44:24 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] 4xx: Add check_link to struct ppc4xx_pciex_hwops
Message-ID: <20110701064424.GE13483@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ayman El-Khashab <ayman@elkhashab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All current pcie controllers unconditionally use SDR to check the link and
poll for reset.

Refactor the code to include device reset in the port_init_hw() op and add a new
check_link() op.

This will make room fro new controllers that do not use SDR for these
operations.

Tested on 460ex.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>


diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 156aa7d..ad330fe 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -650,12 +650,75 @@ struct ppc4xx_pciex_hwops
 	int (*core_init)(struct device_node *np);
 	int (*port_init_hw)(struct ppc4xx_pciex_port *port);
 	int (*setup_utl)(struct ppc4xx_pciex_port *port);
+	void (*check_link)(struct ppc4xx_pciex_port *port);
 };
 
 static struct ppc4xx_pciex_hwops *ppc4xx_pciex_hwops;
 
 #ifdef CONFIG_44x
 
+static int __init ppc4xx_pciex_wait_on_sdr(struct ppc4xx_pciex_port *port,
+					   unsigned int sdr_offset,
+					   unsigned int mask,
+					   unsigned int value,
+					   int timeout_ms)
+{
+	u32 val;
+
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
+static int __init ppc4xx_pciex_port_reset_sdr(struct ppc4xx_pciex_port *port)
+{
+	printk(KERN_INFO "PCIE%d: Checking link...\n",
+	       port->index);
+
+	/* Wait for reset to complete */
+	if (ppc4xx_pciex_wait_on_sdr(port, PESDRn_RCSSTS, 1 << 20, 0, 10)) {
+		printk(KERN_WARNING "PCIE%d: PGRST failed\n",
+		       port->index);
+		return -1;
+	}
+	return 0;
+}
+
+static void __init ppc4xx_pciex_check_link_sdr(struct ppc4xx_pciex_port *port)
+{
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
+}
+
 /* Check various reset bits of the 440SPe PCIe core */
 static int __init ppc440spe_pciex_check_reset(struct device_node *np)
 {
@@ -806,7 +869,7 @@ static int ppc440spe_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 	dcri_clrset(SDR0, port->sdr_base + PESDRn_RCSSET,
 			(1 << 24) | (1 << 16), 1 << 12);
 
-	return 0;
+	return ppc4xx_pciex_port_reset_sdr(port);
 }
 
 static int ppc440speA_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
@@ -856,6 +919,7 @@ static struct ppc4xx_pciex_hwops ppc440speA_pcie_hwops __initdata =
 	.core_init	= ppc440spe_pciex_core_init,
 	.port_init_hw	= ppc440speA_pciex_init_port_hw,
 	.setup_utl	= ppc440speA_pciex_init_utl,
+	.check_link	= ppc4xx_pciex_check_link_sdr,
 };
 
 static struct ppc4xx_pciex_hwops ppc440speB_pcie_hwops __initdata =
@@ -863,6 +927,7 @@ static struct ppc4xx_pciex_hwops ppc440speB_pcie_hwops __initdata =
 	.core_init	= ppc440spe_pciex_core_init,
 	.port_init_hw	= ppc440speB_pciex_init_port_hw,
 	.setup_utl	= ppc440speB_pciex_init_utl,
+	.check_link	= ppc4xx_pciex_check_link_sdr,
 };
 
 static int __init ppc460ex_pciex_core_init(struct device_node *np)
@@ -944,7 +1009,7 @@ static int ppc460ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 
 	port->has_ibpre = 1;
 
-	return 0;
+	return ppc4xx_pciex_port_reset_sdr(port);
 }
 
 static int ppc460ex_pciex_init_utl(struct ppc4xx_pciex_port *port)
@@ -972,6 +1037,7 @@ static struct ppc4xx_pciex_hwops ppc460ex_pcie_hwops __initdata =
 	.core_init	= ppc460ex_pciex_core_init,
 	.port_init_hw	= ppc460ex_pciex_init_port_hw,
 	.setup_utl	= ppc460ex_pciex_init_utl,
+	.check_link	= ppc4xx_pciex_check_link_sdr,
 };
 
 static int __init ppc460sx_pciex_core_init(struct device_node *np)
@@ -1075,7 +1141,7 @@ static int ppc460sx_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 
 	port->has_ibpre = 1;
 
-	return 0;
+	return ppc4xx_pciex_port_reset_sdr(port);
 }
 
 static int ppc460sx_pciex_init_utl(struct ppc4xx_pciex_port *port)
@@ -1089,6 +1155,7 @@ static struct ppc4xx_pciex_hwops ppc460sx_pcie_hwops __initdata = {
 	.core_init	= ppc460sx_pciex_core_init,
 	.port_init_hw	= ppc460sx_pciex_init_port_hw,
 	.setup_utl	= ppc460sx_pciex_init_utl,
+	.check_link	= ppc4xx_pciex_check_link_sdr,
 };
 
 #endif /* CONFIG_44x */
@@ -1154,7 +1221,7 @@ static int ppc405ex_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 
 	port->has_ibpre = 1;
 
-	return 0;
+	return ppc4xx_pciex_port_reset_sdr(port);
 }
 
 static int ppc405ex_pciex_init_utl(struct ppc4xx_pciex_port *port)
@@ -1183,11 +1250,11 @@ static struct ppc4xx_pciex_hwops ppc405ex_pcie_hwops __initdata =
 	.core_init	= ppc405ex_pciex_core_init,
 	.port_init_hw	= ppc405ex_pciex_init_port_hw,
 	.setup_utl	= ppc405ex_pciex_init_utl,
+	.check_link	= ppc4xx_pciex_check_link_sdr,
 };
 
 #endif /* CONFIG_40x */
 
-
 /* Check that the core has been initied and if not, do it */
 static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
 {
@@ -1261,26 +1328,6 @@ static void __init ppc4xx_pciex_port_init_mapping(struct ppc4xx_pciex_port *port
 	dcr_write(port->dcrs, DCRO_PEGPL_MSGMSK, 0);
 }
 
-static int __init ppc4xx_pciex_wait_on_sdr(struct ppc4xx_pciex_port *port,
-					   unsigned int sdr_offset,
-					   unsigned int mask,
-					   unsigned int value,
-					   int timeout_ms)
-{
-	u32 val;
-
-	while(timeout_ms--) {
-		val = mfdcri(SDR0, port->sdr_base + sdr_offset);
-		if ((val & mask) == value) {
-			pr_debug("PCIE%d: Wait on SDR %x success with tm %d (%08x)\n",
-				 port->index, sdr_offset, timeout_ms, val);
-			return 0;
-		}
-		msleep(1);
-	}
-	return -1;
-}
-
 static int __init ppc4xx_pciex_port_init(struct ppc4xx_pciex_port *port)
 {
 	int rc = 0;
@@ -1291,40 +1338,8 @@ static int __init ppc4xx_pciex_port_init(struct ppc4xx_pciex_port *port)
 	if (rc != 0)
 		return rc;
 
-	printk(KERN_INFO "PCIE%d: Checking link...\n",
-	       port->index);
-
-	/* Wait for reset to complete */
-	if (ppc4xx_pciex_wait_on_sdr(port, PESDRn_RCSSTS, 1 << 20, 0, 10)) {
-		printk(KERN_WARNING "PCIE%d: PGRST failed\n",
-		       port->index);
-		return -1;
-	}
-
-	/* Check for card presence detect if supported, if not, just wait for
-	 * link unconditionally.
-	 *
-	 * note that we don't fail if there is no link, we just filter out
-	 * config space accesses. That way, it will be easier to implement
-	 * hotplug later on.
-	 */
-	if (!port->has_ibpre ||
-	    !ppc4xx_pciex_wait_on_sdr(port, PESDRn_LOOP,
-				      1 << 28, 1 << 28, 100)) {
-		printk(KERN_INFO
-		       "PCIE%d: Device detected, waiting for link...\n",
-		       port->index);
-		if (ppc4xx_pciex_wait_on_sdr(port, PESDRn_LOOP,
-					     0x1000, 0x1000, 2000))
-			printk(KERN_WARNING
-			       "PCIE%d: Link up failed\n", port->index);
-		else {
-			printk(KERN_INFO
-			       "PCIE%d: link is up !\n", port->index);
-			port->link = 1;
-		}
-	} else
-		printk(KERN_INFO "PCIE%d: No device detected.\n", port->index);
+	if (ppc4xx_pciex_hwops->check_link)
+		ppc4xx_pciex_hwops->check_link(port);
 
 	/*
 	 * Initialize mapping: disable all regions and configure
@@ -1347,14 +1362,17 @@ static int __init ppc4xx_pciex_port_init(struct ppc4xx_pciex_port *port)
 	/*
 	 * Check for VC0 active and assert RDY.
 	 */
-	if (port->link &&
-	    ppc4xx_pciex_wait_on_sdr(port, PESDRn_RCSSTS,
-				     1 << 16, 1 << 16, 5000)) {
-		printk(KERN_INFO "PCIE%d: VC0 not active\n", port->index);
-		port->link = 0;
+	if (port->sdr_base) {
+		if (port->link &&
+		    ppc4xx_pciex_wait_on_sdr(port, PESDRn_RCSSTS,
+					     1 << 16, 1 << 16, 5000)) {
+			printk(KERN_INFO "PCIE%d: VC0 not active\n", port->index);
+			port->link = 0;
+		}
+
+		dcri_clrset(SDR0, port->sdr_base + PESDRn_RCSSET, 0, 1 << 20);
 	}
 
-	dcri_clrset(SDR0, port->sdr_base + PESDRn_RCSSET, 0, 1 << 20);
 	msleep(100);
 
 	return 0;


Yours Tony
