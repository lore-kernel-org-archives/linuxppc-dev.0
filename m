Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8A3267B99
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 10:37:45 +1000 (EST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat
	Linux)) id 1GQvWX-0002e6-Pg
	for linuxppc-dev@ozlabs.org; Sat, 23 Sep 2006 01:37:41 +0100
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] maple/pci iomem annotations
Message-Id: <E1GQvWX-0002e6-Pg@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2006 01:37:41 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/maple/pci.c |   60 ++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 63a1670..141d172 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -90,14 +90,14 @@ #define U3_AGP_CFA1(bus, devfn, off)	\
 	|(((unsigned long)(off)) & 0xFCUL) \
 	|1UL)
 
-static unsigned long u3_agp_cfg_access(struct pci_controller* hose,
+static volatile void __iomem *u3_agp_cfg_access(struct pci_controller* hose,
 				       u8 bus, u8 dev_fn, u8 offset)
 {
 	unsigned int caddr;
 
 	if (bus == hose->first_busno) {
 		if (dev_fn < (11 << 3))
-			return 0;
+			return NULL;
 		caddr = U3_AGP_CFA0(dev_fn, offset);
 	} else
 		caddr = U3_AGP_CFA1(bus, dev_fn, offset);
@@ -108,14 +108,14 @@ static unsigned long u3_agp_cfg_access(s
 	} while (in_le32(hose->cfg_addr) != caddr);
 
 	offset &= 0x07;
-	return ((unsigned long)hose->cfg_data) + offset;
+	return hose->cfg_data + offset;
 }
 
 static int u3_agp_read_config(struct pci_bus *bus, unsigned int devfn,
 			      int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -130,13 +130,13 @@ static int u3_agp_read_config(struct pci
 	 */
 	switch (len) {
 	case 1:
-		*val = in_8((u8 *)addr);
+		*val = in_8(addr);
 		break;
 	case 2:
-		*val = in_le16((u16 *)addr);
+		*val = in_le16(addr);
 		break;
 	default:
-		*val = in_le32((u32 *)addr);
+		*val = in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -146,7 +146,7 @@ static int u3_agp_write_config(struct pc
 			       int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -161,16 +161,16 @@ static int u3_agp_write_config(struct pc
 	 */
 	switch (len) {
 	case 1:
-		out_8((u8 *)addr, val);
-		(void) in_8((u8 *)addr);
+		out_8(addr, val);
+		(void) in_8(addr);
 		break;
 	case 2:
-		out_le16((u16 *)addr, val);
-		(void) in_le16((u16 *)addr);
+		out_le16(addr, val);
+		(void) in_le16(addr);
 		break;
 	default:
-		out_le32((u32 *)addr, val);
-		(void) in_le32((u32 *)addr);
+		out_le32(addr, val);
+		(void) in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -190,22 +190,22 @@ #define U3_HT_CFA1(bus, devfn, off)	\
 		+ (((unsigned long)bus) << 16) \
 		+ 0x01000000UL)
 
-static unsigned long u3_ht_cfg_access(struct pci_controller* hose,
+static volatile void __iomem *u3_ht_cfg_access(struct pci_controller* hose,
 				      u8 bus, u8 devfn, u8 offset)
 {
 	if (bus == hose->first_busno) {
 		if (PCI_SLOT(devfn) == 0)
-			return 0;
-		return ((unsigned long)hose->cfg_data) + U3_HT_CFA0(devfn, offset);
+			return NULL;
+		return hose->cfg_data + U3_HT_CFA0(devfn, offset);
 	} else
-		return ((unsigned long)hose->cfg_data) + U3_HT_CFA1(bus, devfn, offset);
+		return hose->cfg_data + U3_HT_CFA1(bus, devfn, offset);
 }
 
 static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
 			     int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -221,13 +221,13 @@ static int u3_ht_read_config(struct pci_
 	 */
 	switch (len) {
 	case 1:
-		*val = in_8((u8 *)addr);
+		*val = in_8(addr);
 		break;
 	case 2:
-		*val = in_le16((u16 *)addr);
+		*val = in_le16(addr);
 		break;
 	default:
-		*val = in_le32((u32 *)addr);
+		*val = in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -237,7 +237,7 @@ static int u3_ht_write_config(struct pci
 			      int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -252,16 +252,16 @@ static int u3_ht_write_config(struct pci
 	 */
 	switch (len) {
 	case 1:
-		out_8((u8 *)addr, val);
-		(void) in_8((u8 *)addr);
+		out_8(addr, val);
+		(void) in_8(addr);
 		break;
 	case 2:
-		out_le16((u16 *)addr, val);
-		(void) in_le16((u16 *)addr);
+		out_le16(addr, val);
+		(void) in_le16(addr);
 		break;
 	default:
-		out_le32((u32 *)addr, val);
-		(void) in_le32((u32 *)addr);
+		out_le32(addr, val);
+		(void) in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -301,7 +301,7 @@ static void __init setup_u3_ht(struct pc
 	 * the reg address cell, we shall fix that by killing struct
 	 * reg_property and using some accessor functions instead
 	 */
-	hose->cfg_data = (volatile unsigned char *)ioremap(0xf2000000, 0x02000000);
+	hose->cfg_data = ioremap(0xf2000000, 0x02000000);
 
 	hose->first_busno = 0;
 	hose->last_busno = 0xef;
-- 
1.4.2.GIT
