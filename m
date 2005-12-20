Return-Path: <tnt@246tNt.com>
Received: from outmx025.isp.belgacom.be (outmx025.isp.belgacom.be
	[195.238.2.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28F3468993
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 07:43:38 +1100 (EST)
Received: from outmx025.isp.belgacom.be (localhost [127.0.0.1])
	by outmx025.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id jBKKhRBQ014199
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 21:43:28 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <7.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
References: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
Date: Tue, 20 Dec 2005 21:43:33 +0100 (CET)
Cc: Tom Rini <trini@kernel.crashing.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 7/9] ppc32: Fix MPC52xx configuration space access
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Fix MPC52xx configuration space access

This patch takes care of an errata of the MPC5200 by avoiding 32 bits
access in type 1 configuration accesses. All others accesses are still
32 bits wide. It also adds some mb() since the simple out_be(...) are
not sufficient in this case.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

---
commit 20734ce8dc6fafd40c421bd275712d7bb6124d20
tree e53eeedbe423ecf718313dd2173031d456b4f3e8
parent 7834134483a1ae663b805714fcd741c1caf41171
author Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 14:52:51 +0100
committer Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 14:52:51 +0100

 arch/ppc/syslib/mpc52xx_pci.c |   81 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/arch/ppc/syslib/mpc52xx_pci.c b/arch/ppc/syslib/mpc52xx_pci.c
index e6cb3e2..2c5e6dd 100644
--- a/arch/ppc/syslib/mpc52xx_pci.c
+++ b/arch/ppc/syslib/mpc52xx_pci.c
@@ -24,6 +24,12 @@
 #include <asm/machdep.h>
 
 
+/* This macro is defined to activate the workaround for the bug
+   435 of the MPC5200 (L25R). With it activated, we don't do any
+   32 bits configuration access during type-1 cycles */
+#define MPC5200_BUG_435_WORKAROUND
+
+
 static int
 mpc52xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 				int offset, int len, u32 *val)
@@ -40,17 +46,39 @@ mpc52xx_pci_read_config(struct pci_bus *
 		((bus->number - hose->bus_offset) << 16) |
 		(devfn << 8) |
 		(offset & 0xfc));
+	mb();
 
-	value = in_le32(hose->cfg_data);
+#ifdef MPC5200_BUG_435_WORKAROUND
+	if (bus->number != hose->bus_offset) {
+		switch (len) {
+			case 1:
+				value = in_8(((u8 __iomem *)hose->cfg_data) + (offset & 3));
+				break;
+			case 2:
+				value = in_le16(((u16 __iomem *)hose->cfg_data) + ((offset>>1) & 1));
+				break;
+
+			default:
+				value = in_le16((u16 __iomem *)hose->cfg_data) |
+					(in_le16(((u16 __iomem *)hose->cfg_data) + 1) << 16);
+				break;
+		}
+	}
+	else
+#endif
+	{
+		value = in_le32(hose->cfg_data);
 
-	if (len != 4) {
-		value >>= ((offset & 0x3) << 3);
-		value &= 0xffffffff >> (32 - (len << 3));
+		if (len != 4) {
+			value >>= ((offset & 0x3) << 3);
+			value &= 0xffffffff >> (32 - (len << 3));
+		}
 	}
 
 	*val = value;
 
 	out_be32(hose->cfg_addr, 0);
+	mb();
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -71,21 +99,48 @@ mpc52xx_pci_write_config(struct pci_bus 
 		((bus->number - hose->bus_offset) << 16) |
 		(devfn << 8) |
 		(offset & 0xfc));
+	mb();
 
-	if (len != 4) {
-		value = in_le32(hose->cfg_data);
+#ifdef MPC5200_BUG_435_WORKAROUND
+	if (bus->number != hose->bus_offset) {
+		switch (len) {
+			case 1:
+				out_8(((u8 __iomem *)hose->cfg_data) +
+					(offset & 3), val);
+				break;
+			case 2:
+				out_le16(((u16 __iomem *)hose->cfg_data) +
+					((offset>>1) & 1), val);
+				break;
+
+			default:
+				out_le16((u16 __iomem *)hose->cfg_data,
+					(u16)val);
+				out_le16(((u16 __iomem *)hose->cfg_data) + 1,
+					(u16)(val>>16));
+				break;
+		}
+	}
+	else
+#endif
+	{
+		if (len != 4) {
+			value = in_le32(hose->cfg_data);
+
+			offset = (offset & 0x3) << 3;
+			mask = (0xffffffff >> (32 - (len << 3)));
+			mask <<= offset;
 
-		offset = (offset & 0x3) << 3;
-		mask = (0xffffffff >> (32 - (len << 3)));
-		mask <<= offset;
+			value &= ~mask;
+			val = value | ((val << offset) & mask);
+		}
 
-		value &= ~mask;
-		val = value | ((val << offset) & mask);
+		out_le32(hose->cfg_data, val);
 	}
-
-	out_le32(hose->cfg_data, val);
+	mb();
 
 	out_be32(hose->cfg_addr, 0);
+	mb();
 
 	return PCIBIOS_SUCCESSFUL;
 }
