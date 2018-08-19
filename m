Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41tqdR1wmLzF1S4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 07:22:02 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: chzigotzky@xenosoft.de
Date: Sun, 19 Aug 2018 21:21:55 +0100 (BST)
Message-ID: <4c6da03cac4.3957dfc0@auth.smtp.1and1.co.uk>
Subject: [PATCH NEXT v2 1/4] powerpc/pasemi: Add PCI initialisation for
 Nemo board.
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c124c6035e4feb9.65"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c124c6035e4feb9.65
Content-Type: text/plain

The A-Eon Amigaone X1000's Nemo motherboard has an AMD SB600
connected to one of the PCI-e root ports on its PaSemi
Pwrficient 1628M SoC. Normally the SB600 southbridge would be
connected to a hidden PCI-e port on the system's northbridge,
and as a result doesn't fully comply with the PCI-e spec.
    
Add code to relax the PCI-e detection in both the root port
and the Linux kernel allowing on board devices to be detected.
    
Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---

Changes made:

v2: Replaced sb600_bus with a define, moved iob_mapbase into 
    sb600_set_flag()
    Created some register/Flag names (as I don't have the docs
    for the PA6T-1682M)

----=_BOUNDARY.6c124c6035e4feb9.65
Content-Type: text/plain;
	name="pci.patch"
Content-Disposition: attachment;
	filename="pci.patch";
	size=1664

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index c3c6417..116c0fe 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -108,6 +108,61 @@ static int workaround_5945(struct pci_bus *bus, unsigned int devfn,
 	return 1;
 }
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+#define PXP_ERR_CFG_REG	0x4
+#define PXP_IGNORE_PCIE_ERRORS	0x800
+#define SB600_BUS 5
+
+static void sb600_set_flag(int bus)
+{
+	static void __iomem *iob_mapbase = NULL;
+	struct resource res;
+	struct device_node *dn;
+	int err;
+
+	if (iob_mapbase == NULL) {
+		dn = of_find_compatible_node(NULL, "isa", "pasemi,1682m-iob");
+		if (!dn) {
+			pr_crit("NEMO SB600 missing iob node\n");
+			return;
+		}
+
+		err = of_address_to_resource(dn, 0, &res);
+		of_node_put(dn);
+
+		if (err) {
+			pr_crit("NEMO SB600 missing resource\n");
+			return;
+		}
+
+		pr_info("NEMO SB600 IOB base %08llx\n",res.start);
+
+		iob_mapbase = ioremap(res.start + 0x100, 0x94);
+	}
+
+	if (iob_mapbase != NULL) {
+		if (bus == SB600_BUS) {
+			/*
+			 * This is the SB600's bus, tell the PCI-e root port
+			 * to allow non-zero devices to enumerate.
+			 */
+			out_le32(iob_mapbase + PXP_ERR_CFG_REG, in_le32(iob_mapbase + PXP_ERR_CFG_REG) | PXP_IGNORE_PCIE_ERRORS);
+		} else {
+			/*
+			 * Only scan device 0 on other busses
+			 */
+			out_le32(iob_mapbase + PXP_ERR_CFG_REG, in_le32(iob_mapbase + PXP_ERR_CFG_REG) & ~PXP_IGNORE_PCIE_ERRORS);
+		}
+	}
+}
+
+#else
+
+static void sb600_set_flag(int bus)
+{
+}
+#endif
+
 static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
 			      int offset, int len, u32 *val)
 {

----=_BOUNDARY.6c124c6035e4feb9.65--
