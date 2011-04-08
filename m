Return-Path: <ayman@elkhashab.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [207.114.241.63])
	by ozlabs.org (Postfix) with ESMTP id 833F1B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Apr 2011 04:34:54 +1000 (EST)
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] ppc4xx: Fix PCIe scanning for the 460SX
Date: Fri,  8 Apr 2011 13:22:10 -0500
Message-Id: <1302286930-9988-2-git-send-email-ayman@elkhashab.com>
In-Reply-To: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
Cc: Ayman El-Khashab <ayman@elkhashab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ayman El-Khashab <ayman@elkhashab.com>

The 460SX uses a different register set than previous 44x PCIe CPUs,
so some of the checks were not valid.  Added an enable for the TX
and RX.  For the 460SX only: Bypassed VCO check and added PLL check.
Bypassed the link check.  Changed to advertise gen 2 speeds.

Signed-off-by: Ayman El-Khashab <ayman@elkhashab.com>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 156aa7d..1c854a7 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1058,6 +1058,8 @@ static int __init ppc460sx_pciex_core_init(struct device_node *np)
 
 static int ppc460sx_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 {
+	/* 500ms should be long enough */
+	int timeout = 50000;
 
 	if (port->endpoint)
 		dcri_clrset(SDR0, port->sdr_base + PESDRn_UTLSET2,
@@ -1066,15 +1068,20 @@ static int ppc460sx_pciex_init_port_hw(struct ppc4xx_pciex_port *port)
 		dcri_clrset(SDR0, port->sdr_base + PESDRn_UTLSET2,
 				0, 0x01000000);
 
-	/*Gen-1*/
-	mtdcri(SDR0, port->sdr_base + PESDRn_460SX_RCEI, 0x08000000);
 
 	dcri_clrset(SDR0, port->sdr_base + PESDRn_RCSSET,
 			(PESDRx_RCSSET_RSTGU | PESDRx_RCSSET_RSTDL),
 			PESDRx_RCSSET_RSTPYN);
 
-	port->has_ibpre = 1;
 
+	/* Poll for the PHY reset */
+	while (timeout-- && !(mfdcr(port->sdr_base + PESDRn_RCSSTS) & 0x10000))
+		udelay(10);
+
+	if (!timeout)
+		return -1;
+
+	port->has_ibpre = 1;
 	return 0;
 }
 
@@ -1082,6 +1089,8 @@ static int ppc460sx_pciex_init_utl(struct ppc4xx_pciex_port *port)
 {
 	/* Max 128 Bytes */
 	out_be32 (port->utl_base + PEUTL_PBBSZ,   0x00000000);
+	out_be32 (port->utl_base + PEUTL_PCTL,	  0x80800000);
+
 	return 0;
 }
 
@@ -1308,6 +1317,7 @@ static int __init ppc4xx_pciex_port_init(struct ppc4xx_pciex_port *port)
 	 * config space accesses. That way, it will be easier to implement
 	 * hotplug later on.
 	 */
+#ifndef CONFIG_460SX
 	if (!port->has_ibpre ||
 	    !ppc4xx_pciex_wait_on_sdr(port, PESDRn_LOOP,
 				      1 << 28, 1 << 28, 100)) {
@@ -1325,6 +1335,10 @@ static int __init ppc4xx_pciex_port_init(struct ppc4xx_pciex_port *port)
 		}
 	} else
 		printk(KERN_INFO "PCIE%d: No device detected.\n", port->index);
+#else
+	/* XXX What DCR has the link status on the 460SX? */
+	port->link = 1;
+#endif
 
 	/*
 	 * Initialize mapping: disable all regions and configure
@@ -1344,8 +1358,9 @@ static int __init ppc4xx_pciex_port_init(struct ppc4xx_pciex_port *port)
 	if (ppc4xx_pciex_hwops->setup_utl)
 		ppc4xx_pciex_hwops->setup_utl(port);
 
+#ifndef CONFIG_460SX
 	/*
-	 * Check for VC0 active and assert RDY.
+	 * Check for VC0 active
 	 */
 	if (port->link &&
 	    ppc4xx_pciex_wait_on_sdr(port, PESDRn_RCSSTS,
@@ -1353,7 +1368,19 @@ static int __init ppc4xx_pciex_port_init(struct ppc4xx_pciex_port *port)
 		printk(KERN_INFO "PCIE%d: VC0 not active\n", port->index);
 		port->link = 0;
 	}
+#else
+	/*
+	 * Check for PLL Locked
+	 */
+	if (port->link &&
+	    ppc4xx_pciex_wait_on_sdr(port, PESDRn_RCSSTS,
+				     1 << 12, 1 << 12, 5000)) {
+		printk(KERN_INFO "PCIE%d: PLL not locked\n", port->index);
+		port->link = 0;
+	}
+#endif
 
+	/* Assert RDY */
 	dcri_clrset(SDR0, port->sdr_base + PESDRn_RCSSET, 0, 1 << 20);
 	msleep(100);
 
-- 
1.7.4.3
