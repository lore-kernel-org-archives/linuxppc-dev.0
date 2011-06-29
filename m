Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7BAF2B6F53
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 00:17:48 +1000 (EST)
Received: by wwj40 with SMTP id 40so1033071wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 07:17:43 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: enable access to HT Host-Bridge on Maple
Date: Wed, 29 Jun 2011 18:17:40 +0400
Message-Id: <1309357060-20872-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPC925/CPC945 use special window to access host bridge functionality of
u3-ht. Provide a way to access this device.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/maple/pci.c |   55 ++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index dd2e48b..401e3f3 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -207,6 +207,54 @@ static volatile void __iomem *u3_ht_cfg_access(struct pci_controller* hose,
 		return hose->cfg_data + u3_ht_cfa1(bus, devfn, offset);
 }
 
+static int u3_ht_root_read_config(struct pci_controller *hose, u8 offset,
+				  int len, u32 *val)
+{
+	volatile void __iomem *addr;
+
+	addr = hose->cfg_addr;
+	addr += ((offset & ~3) << 2) + (4 - len - (offset & 3));
+
+	switch (len) {
+	case 1:
+		*val = in_8(addr);
+		break;
+	case 2:
+		*val = in_be16(addr);
+		break;
+	default:
+		*val = in_be32(addr);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int u3_ht_root_write_config(struct pci_controller *hose, u8 offset,
+				  int len, u32 val)
+{
+	volatile void __iomem *addr;
+
+	addr = hose->cfg_addr + ((offset & ~3) << 2) + (4 - len - (offset & 3));
+
+	if (offset >= PCI_BASE_ADDRESS_0 && offset < PCI_CAPABILITY_LIST)
+		return PCIBIOS_SUCCESSFUL;
+
+	switch (len) {
+	case 1:
+		out_8(addr, val);
+		break;
+	case 2:
+		out_be16(addr, val);
+		break;
+	default:
+		out_be32(addr, val);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
 			     int offset, int len, u32 *val)
 {
@@ -217,6 +265,9 @@ static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	if (bus->number == hose->first_busno && devfn == PCI_DEVFN(0, 0))
+		return u3_ht_root_read_config(hose, offset, len, val);
+
 	if (offset > 0xff)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -252,6 +303,9 @@ static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	if (bus->number == hose->first_busno && devfn == PCI_DEVFN(0, 0))
+		return u3_ht_root_write_config(hose, offset, len, val);
+
 	if (offset > 0xff)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -428,6 +482,7 @@ static void __init setup_u3_ht(struct pci_controller* hose)
 	 * reg_property and using some accessor functions instead
 	 */
 	hose->cfg_data = ioremap(0xf2000000, 0x02000000);
+	hose->cfg_addr = ioremap(0xf8070000, 0x1000);
 
 	hose->first_busno = 0;
 	hose->last_busno = 0xef;
-- 
1.7.5.4
