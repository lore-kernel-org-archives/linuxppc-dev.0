Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56C0DDDE3F
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:36:25 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48NaM83004245
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:36:22 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l48NaMNY554116
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:36:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l48NaMRe011109
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:36:22 -0400
Date: Tue, 8 May 2007 18:36:21 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/4] powerpc: EEH: log all PCI-X and PCI-E AER registers
Message-ID: <20070508233621.GS4452@austin.ibm.com>
References: <20070508230952.GN4452@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508230952.GN4452@austin.ibm.com>
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


When an EEH event is detected, and after the device driver
has been notified, but before the device is reset, enable
MMIO to the adapter, and grab the contents of the PCI status 
and command registers, the PCI-X status and command, and the
PCI-E capability 10 and AER registers. Pass these up to the
RTAS error log, and also printk them.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |   48 +++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

Index: linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc7-mm2.orig/arch/powerpc/platforms/pseries/eeh.c	2007-04-26 16:19:28.000000000 -0500
+++ linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh.c	2007-04-26 16:19:32.000000000 -0500
@@ -160,14 +160,58 @@ static void rtas_slot_error_detail(struc
 static size_t gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 {
 	u32 cfg;
+	int cap, i;
 	int n = 0;
 
-	n += scnprintf(buf+n, len-n, "%s\n", pdn->node->name);
+	n += scnprintf(buf+n, len-n, "%s\n", pdn->node->full_name);
+	printk(KERN_WARNING "EEH: of node=%s\n", pdn->node->full_name);
+
 	rtas_read_config(pdn, PCI_VENDOR_ID, 4, &cfg);
-	n += scnprintf(buf+n, len-n, "dev/vend:%x\n", cfg);
+	n += scnprintf(buf+n, len-n, "dev/vend:%08x\n", cfg);
+	printk(KERN_WARNING "EEH: PCI device/vendor: %08x\n", cfg);
+
 	rtas_read_config(pdn, PCI_COMMAND, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
+	printk(KERN_WARNING "EEH: PCI cmd/status register: %08x\n", cfg);
+
+	/* Dump out the PCI-X command and status regs */
+	cap = pci_find_capability(pdn->pcidev, PCI_CAP_ID_PCIX);
+	if (cap) {
+		rtas_read_config(pdn, cap, 4, &cfg);
+		n += scnprintf(buf+n, len-n, "pcix-cmd:%x\n", cfg);
+		printk(KERN_WARNING "EEH: PCI-X cmd: %08x\n", cfg);
+
+		rtas_read_config(pdn, cap+4, 4, &cfg);
+		n += scnprintf(buf+n, len-n, "pcix-stat:%x\n", cfg);
+		printk(KERN_WARNING "EEH: PCI-X status: %08x\n", cfg);
+	}
+
+	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
+	cap = pci_find_capability(pdn->pcidev, PCI_CAP_ID_EXP);
+	if (cap) {
+		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
+		printk(KERN_WARNING
+		       "EEH: PCI-E capabilities and status follow:\n");
+
+		for (i=0; i<=8; i++) {
+			rtas_read_config(pdn, cap+4*i, 4, &cfg);
+			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
+			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
+		}
 
+		cap = pci_find_ext_capability(pdn->pcidev,PCI_EXT_CAP_ID_ERR);
+		if (cap) {
+			n += scnprintf(buf+n, len-n, "pci-e AER:\n");
+			printk(KERN_WARNING
+			       "EEH: PCI-E AER capability register set follows:\n");
+
+			for (i=0; i<14; i++) {
+				rtas_read_config(pdn, cap+4*i, 4, &cfg);
+				n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
+				printk(KERN_WARNING "EEH: PCI-E AER %02x: %08x\n", i, cfg);
+			}
+		}
+	}
 	return n;
 }
 
