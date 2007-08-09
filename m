Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id ADF09DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 10:51:02 +1000 (EST)
Date: Wed, 8 Aug 2007 19:50:44 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH] remove gratuitous reads from maple pci config space
	methods
Message-ID: <20070809005044.GD10114@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The maple pci configuration space write methods read the written
location immediately after the write is performed, presumably in order
to flush the write.  However, configuration space writes are not
allowed to be posted, making these reads gratuitous.  Furthermore,
this behavior potentially causes us to violate the PCI PM spec when
changing between e.g. D0 and D3 states, because a delay of up to 10ms
may be required before the OS accesses configuration space after the
write which initiates the transition.  It definitely causes a system
hang for me with a Broadcom 5721 PCIE network adapter, which is fixed
by this change.

Remove the gratuitous reads from u3_agp_write_config,
u3_ht_write_config, and u4_pcie_write_config.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/maple/pci.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 2542403..b095eaa 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -169,15 +169,12 @@ static int u3_agp_write_config(struct pci_bus *bus, unsigned int devfn,
 	switch (len) {
 	case 1:
 		out_8(addr, val);
-		(void) in_8(addr);
 		break;
 	case 2:
 		out_le16(addr, val);
-		(void) in_le16(addr);
 		break;
 	default:
 		out_le32(addr, val);
-		(void) in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -268,15 +265,12 @@ static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
 	switch (len) {
 	case 1:
 		out_8(addr, val);
-		(void) in_8(addr);
 		break;
 	case 2:
 		out_le16(addr, val);
-		(void) in_le16(addr);
 		break;
 	default:
 		out_le32(addr, val);
-		(void) in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -376,15 +370,12 @@ static int u4_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
         switch (len) {
         case 1:
                 out_8(addr, val);
-                (void) in_8(addr);
                 break;
         case 2:
                 out_le16(addr, val);
-                (void) in_le16(addr);
                 break;
         default:
                 out_le32(addr, val);
-                (void) in_le32(addr);
                 break;
         }
         return PCIBIOS_SUCCESSFUL;
-- 
1.5.2.4
