Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 6805067A2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 08:52:33 +1100 (EST)
Date: Fri, 11 Feb 2005 15:52:15 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0502111546100.29653@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Fix PCI2 support on MPC8555/41 CDS systems
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

The following patch fixes an issue related to the second PCI host 
controller working on MPC8555/41 systems.  If possible we should get this 
in before 2.6.11.

Keep track of the last PCI bus number on PCI1 so that the PCI2 host
controller can properly exclude itself at the right time, exclusion should
occur after initial setup so that the early pci config cycles in setting 
PCI2 actually get to the controller.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--- 
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-10 18:33:44 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-10 18:33:44 -06:00
@@ -281,16 +281,17 @@
 #define ARCADIA_HOST_BRIDGE_IDSEL     17
 #define ARCADIA_2ND_BRIDGE_IDSEL     3
 
+extern int mpc85xx_pci1_last_busno;
+
 int
 mpc85xx_exclude_device(u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 #ifdef CONFIG_85xx_PCI2
-	/* With the current code we know PCI2 will be bus 2, however this may
-	 * not be guarnteed */
-	if (bus == 2 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (mpc85xx_pci1_last_busno) 
+		if (bus == (mpc85xx_pci1_last_busno + 1) && PCI_SLOT(devfn) == 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
 #endif
 	/* We explicitly do not go past the Tundra 320 Bridge */
 	if (bus == 1)
diff -Nru a/arch/ppc/syslib/ppc85xx_setup.c b/arch/ppc/syslib/ppc85xx_setup.c
--- a/arch/ppc/syslib/ppc85xx_setup.c	2005-02-10 18:33:44 -06:00
+++ b/arch/ppc/syslib/ppc85xx_setup.c	2005-02-10 18:33:44 -06:00
@@ -243,6 +243,8 @@
 }
 #endif /* CONFIG_85xx_PCI2 */
 
+int mpc85xx_pci1_last_busno = 0;
+
 void __init
 mpc85xx_setup_hose(void)
 {
@@ -341,6 +343,9 @@
 			IORESOURCE_IO, "PCI2 host bridge");
 
 	hose_b->last_busno = pciauto_bus_scan(hose_b, hose_b->first_busno);
+
+	/* let board code know what the last bus number was on PCI1 */
+	mpc85xx_pci1_last_busno = hose_a->last_busno;
 #endif
 	return;
 }
