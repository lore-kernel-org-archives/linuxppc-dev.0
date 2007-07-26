Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 301FADDE19
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 08:35:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6QMZfv4031296
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:35:41 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6QMZfEx256444
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:35:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6QMZeSe029893
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:35:41 -0600
Date: Thu, 26 Jul 2007 17:35:40 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3] powerpc/eeh: dump pci bridge status on event
Message-ID: <20070726223540.GC21552@austin.ibm.com>
References: <20070726222935.GJ9876@austin.ibm.com>
	<20070726223026.GA21552@austin.ibm.com>
	<20070726223358.GB21552@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070726223358.GB21552@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Gather bridge-specific data on EEH events.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/eeh.c	2007-07-25 16:41:42.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh.c	2007-07-25 16:42:20.000000000 -0500
@@ -169,6 +169,8 @@ static void rtas_slot_error_detail(struc
  */
 static size_t gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 {
+	struct device_node *dn;
+	struct pci_dev *dev = pdn->pcidev;
 	u32 cfg;
 	int cap, i;
 	int n = 0;
@@ -184,6 +186,17 @@ static size_t gather_pci_data(struct pci
 	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
 	printk(KERN_WARNING "EEH: PCI cmd/status register: %08x\n", cfg);
 
+	/* Gather bridge-specific registers */
+	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
+		rtas_read_config(pdn, PCI_SEC_STATUS, 2, &cfg);
+		n += scnprintf(buf+n, len-n, "sec stat:%x\n", cfg);
+		printk(KERN_WARNING "EEH: Bridge secondary status: %04x\n", cfg);
+
+		rtas_read_config(pdn, PCI_BRIDGE_CONTROL, 2, &cfg);
+		n += scnprintf(buf+n, len-n, "brdg ctl:%x\n", cfg);
+		printk(KERN_WARNING "EEH: Bridge control: %04x\n", cfg);
+	}
+
 	/* Dump out the PCI-X command and status regs */
 	cap = pci_find_capability(pdn->pcidev, PCI_CAP_ID_PCIX);
 	if (cap) {
@@ -209,7 +222,7 @@ static size_t gather_pci_data(struct pci
 			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
 		}
 
-		cap = pci_find_ext_capability(pdn->pcidev,PCI_EXT_CAP_ID_ERR);
+		cap = pci_find_ext_capability(pdn->pcidev, PCI_EXT_CAP_ID_ERR);
 		if (cap) {
 			n += scnprintf(buf+n, len-n, "pci-e AER:\n");
 			printk(KERN_WARNING
@@ -222,6 +235,18 @@ static size_t gather_pci_data(struct pci
 			}
 		}
 	}
+
+	/* Gather status on devices under the bridge */
+	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
+		dn = pdn->node->child;
+		while (dn) {
+			pdn = PCI_DN(dn);
+			if (pdn)
+				n += gather_pci_data(pdn, buf+n, len-n);
+			dn = dn->sibling;
+		}
+	}
+
 	return n;
 }
 
