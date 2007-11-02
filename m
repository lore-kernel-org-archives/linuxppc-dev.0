Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F82EDDE03
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 07:29:05 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA2KT2NR019578
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 16:29:02 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA2KT2q3116460
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 14:29:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA2KT2ri007869
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 14:29:02 -0600
Date: Fri, 2 Nov 2007 15:29:01 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3]: powerpc eeh: avoid crash on null device.
Message-ID: <20071102202901.GC13828@austin.ibm.com>
References: <20071102201957.GU2183@austin.ibm.com>
	<20071102202555.GA13828@austin.ibm.com>
	<20071102202750.GB13828@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071102202750.GB13828@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Bugfix: avoid crash if there's no pci device for a given
openfirmware node.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
----
 arch/powerpc/platforms/pseries/eeh.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/arch/powerpc/platforms/pseries/eeh.c	2007-10-16 13:55:03.000000000 -0500
+++ linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/eeh.c	2007-10-16 14:04:39.000000000 -0500
@@ -186,6 +186,11 @@ static size_t gather_pci_data(struct pci
 	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
 	printk(KERN_WARNING "EEH: PCI cmd/status register: %08x\n", cfg);
 
+	if (!dev) {
+		printk(KERN_WARNING "EEH: no PCI device for this of node\n");
+		return n;
+	}
+
 	/* Gather bridge-specific registers */
 	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
 		rtas_read_config(pdn, PCI_SEC_STATUS, 2, &cfg);
@@ -198,7 +203,7 @@ static size_t gather_pci_data(struct pci
 	}
 
 	/* Dump out the PCI-X command and status regs */
-	cap = pci_find_capability(pdn->pcidev, PCI_CAP_ID_PCIX);
+	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
 	if (cap) {
 		rtas_read_config(pdn, cap, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-cmd:%x\n", cfg);
@@ -210,7 +215,7 @@ static size_t gather_pci_data(struct pci
 	}
 
 	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
-	cap = pci_find_capability(pdn->pcidev, PCI_CAP_ID_EXP);
+	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
 	if (cap) {
 		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
 		printk(KERN_WARNING
@@ -222,7 +227,7 @@ static size_t gather_pci_data(struct pci
 			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
 		}
 
-		cap = pci_find_ext_capability(pdn->pcidev, PCI_EXT_CAP_ID_ERR);
+		cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 		if (cap) {
 			n += scnprintf(buf+n, len-n, "pci-e AER:\n");
 			printk(KERN_WARNING
