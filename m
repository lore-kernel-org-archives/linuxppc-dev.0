Return-Path: <anton@samba.org>
Date: Thu, 17 Oct 2013 23:19:43 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, tony@bakeyournoodle.com
Subject: powerpc: Fix little endian issue in OF PCI scan
Message-ID: <20131017231943.5bf24559@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    
This issue was causing the QEMU emulated USB device to fail dring
PCI probe.
    
Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 4368ec6..ac0b034 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -302,7 +302,7 @@ static struct pci_dev *of_scan_pci_dev(struct pci_bus *bus,
 			    struct device_node *dn)
 {
 	struct pci_dev *dev = NULL;
-	const u32 *reg;
+	const __be32 *reg;
 	int reglen, devfn;
 
 	pr_debug("  * %s\n", dn->full_name);
@@ -312,7 +312,7 @@ static struct pci_dev *of_scan_pci_dev(struct pci_bus *bus,
 	reg = of_get_property(dn, "reg", &reglen);
 	if (reg == NULL || reglen < 20)
 		return NULL;
-	devfn = (reg[0] >> 8) & 0xff;
+	devfn = (of_read_number(reg, 1) >> 8) & 0xff;
 
 	/* Check if the PCI device is already there */
 	dev = pci_get_slot(bus, devfn);
