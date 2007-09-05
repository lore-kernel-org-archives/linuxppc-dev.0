Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 44494DE15E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:01:59 +1000 (EST)
Date: Tue, 4 Sep 2007 21:08:50 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [POWERPC] pasemi: Add workaround for erratum 5945
Message-ID: <20070905020850.GC25900@lixom.net>
References: <20070905020733.GA25900@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905020733.GA25900@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit 3f7a4e905341e46e7b442a9326c3b31229e25209
Author: Olof Johansson <olof@lixom.net>
Date:   Mon Sep 3 00:11:49 2007 -0500

    [POWERPC] pasemi: Add workaround for erratum 5945
    
    Erratum 5945 causes some of the registers on the PCIe root ports to
    not read correctly.  Do a small dance to avoid this: Write an unused
    register, read the value and write it back. Thankfully this is not in
    a hot code path.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index fcfb3df..b6a0ec4 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -51,6 +51,61 @@ static void volatile __iomem *pa_pxp_cfg_addr(struct pci_controller *hose,
 	return hose->cfg_data + PA_PXP_CFA(bus, devfn, offset);
 }
 
+static inline int is_root_port(int busno, int devfn)
+{
+	return ((busno == 0) && (PCI_FUNC(devfn) < 4) &&
+		 ((PCI_SLOT(devfn) == 16) || (PCI_SLOT(devfn) == 17)));
+}
+
+static inline int is_5945_reg(int reg)
+{
+	return (((reg >= 0x18) && (reg < 0x34)) ||
+		((reg >= 0x158) && (reg < 0x178)));
+}
+
+static int workaround_5945(struct pci_bus *bus, unsigned int devfn,
+			   int offset, int len, u32 *val)
+{
+	struct pci_controller *hose;
+	void volatile __iomem *addr, *dummy;
+	int byte;
+	u32 tmp;
+
+	if (!is_root_port(bus->number, devfn) || !is_5945_reg(offset))
+		return 0;
+
+	hose = pci_bus_to_host(bus);
+
+	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset & ~0x3);
+	byte = offset & 0x3;
+
+	/* Workaround bug 5945: write 0 to a dummy register before reading,
+	 * and write back what we read. We must read/write the full 32-bit
+	 * contents so we need to shift and mask by hand.
+	 */
+	dummy = pa_pxp_cfg_addr(hose, bus->number, devfn, 0x10);
+	out_le32(dummy, 0);
+	tmp = in_le32(addr);
+	out_le32(addr, tmp);
+
+	switch (len) {
+	case 1:
+		*val = (tmp >> (8*byte)) & 0xff;
+		break;
+	case 2:
+		if (byte == 0)
+			*val = tmp & 0xffff;
+		else
+			*val = (tmp >> 16) & 0xffff;
+		break;
+	default:
+		*val = tmp;
+		break;
+	}
+
+	return 1;
+}
+
 static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
 			      int offset, int len, u32 *val)
 {
@@ -64,6 +119,9 @@ static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
 	if (!pa_pxp_offset_valid(bus->number, devfn, offset))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
+	if (workaround_5945(bus, devfn, offset, len, val))
+		return PCIBIOS_SUCCESSFUL;
+
 	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
 
 	/*
@@ -180,7 +238,7 @@ void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
 {
 	struct pci_controller *hose;
 
-	hose = pci_bus_to_host(bus);
+	hose = pci_bus_to_host(dev->bus);
 
-	return pa_pxp_cfg_addr(hose, hose->number, dev->devfn, int offset)
+	return (void __iomem *)pa_pxp_cfg_addr(hose, dev->bus->number, dev->devfn, offset);
 }
