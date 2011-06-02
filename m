Return-Path: <dbaryshkov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DBCB2B6F97
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 22:25:04 +1000 (EST)
Received: by wyg36 with SMTP id 36so620289wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Jun 2011 05:24:59 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: bluesmoke-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] ppc/85xx: create a platform node for PCI EDAC device
Date: Thu,  2 Jun 2011 16:25:02 +0400
Message-Id: <1307017502-3965-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <20110601114823.2e57c691@schlenkerla.am.freescale.net>
References: <20110601114823.2e57c691@schlenkerla.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As a device for pci node isn't created, create a special platform_device
for PCI EDAC device on MPC85xx.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 68ca929..0e37259 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -381,6 +381,39 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	return 0;
 }
 
+int __init fsl_add_pci_err(void)
+{
+	struct device_node *np;
+
+	for_each_node_by_type(np, "pci") {
+		/* Only PCI, not PCI Express! */
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci")) {
+			struct resource r[2];
+
+			r[0].parent = NULL;
+			r[1].parent = NULL;
+
+			if (of_address_to_resource(np, 0, &r[0])) {
+				printk(KERN_WARNING
+						"Can't get register base for PCI EDAC!\n");
+				continue;
+			}
+			r[0].start += 0xe00;
+
+			if (of_irq_to_resource(np, 0, &r[1]) == NO_IRQ) {
+				printk(KERN_WARNING
+						"Can't get irq for PCI EDAC!\n");
+				continue;
+			}
+			platform_device_register_simple("mpc85xx_pci_err", -1,
+					r, ARRAY_SIZE(r));
+		}
+	}
+
+	return 0;
+}
+device_initcall(fsl_add_pci_err);
+
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8543E, quirk_fsl_pcie_header);
-- 
1.7.4.4
