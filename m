Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 47A5DDDEFD
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 07:43:36 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] remove gratuitous reads from powermac pci config space methods
Date: Thu,  9 Aug 2007 16:43:28 -0500
Message-Id: <11866958083866-git-send-email-ntl@pobox.com>
In-Reply-To: 1186620933.938.211.camel@localhost.localdomain
References: 1186620933.938.211.camel@localhost.localdomain
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powermac pci configuration space write methods read the written
location immediately after the write is performed, presumably in order
to flush the write.  However, configuration space writes are not
allowed to be posted, making these reads gratuitous.  Furthermore,
this behavior potentially causes us to violate the PCI PM spec when
changing between e.g. D0 and D3 states, because a delay of up to 10ms
may be required before the OS accesses configuration space after the
write which initiates the transition.

Remove the unnecessary reads from macrisc_write_config,
u3_ht_write_config, and u4_pcie_write_config.


Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/powermac/pci.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 92586db..bf1f5d1 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -209,15 +209,12 @@ static int macrisc_write_config(struct pci_bus *bus, unsigned int devfn,
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
@@ -440,15 +437,12 @@ static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
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
 		out_le32((u32 __iomem *)addr, val);
-		(void) in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -545,15 +539,12 @@ static int u4_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
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
-- 
1.5.2.4
