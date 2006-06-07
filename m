Return-Path: <moilanen@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 507E467B7F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 07:23:32 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k57LNTfh011110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 17:23:29 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k57LNSSd290216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 15:23:28 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k57LNS0X009459
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 15:23:28 -0600
Date: Wed, 7 Jun 2006 16:15:10 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] MSI power abstraction
Message-Id: <20060607161510.00ecc442.moilanen@austin.ibm.com>
In-Reply-To: <20060607160212.1203d9ea.moilanen@austin.ibm.com>
References: <20060607160212.1203d9ea.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead of trying to make PPC64 MSI fit in a Intel-centric MSI layer, a
simple short-term solution is to hook the pci_{en/dis}able_msi() calls
and make a machdep call.

The rest of the MSI functions are superfluous for what is needed at this
time.  Many of which can have machdep calls added as needed.

Ben and Michael Ellerman are looking into rewrite the MSI layer to be
more generic.  However, in the meantime this works as a interim
solution.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

Index: 2.6/arch/powerpc/kernel/irq.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/irq.c	2006-06-07 15:23:41.000000000 -0500
+++ 2.6/arch/powerpc/kernel/irq.c	2006-06-07 15:29:32.000000000 -0500
@@ -47,6 +47,7 @@
 #include <linux/cpumask.h>
 #include <linux/profile.h>
 #include <linux/bitops.h>
+#include <linux/pci.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -436,6 +437,30 @@
 }
 EXPORT_SYMBOL(do_softirq);
 
+#ifdef CONFIG_PCI_MSI
+int pci_enable_msi(struct pci_dev * pdev)
+{
+	if (ppc_md.enable_msi)
+		return ppc_md.enable_msi(pdev);
+	else
+		return -1;
+}
+
+void pci_disable_msi(struct pci_dev * pdev)
+{
+	if (ppc_md.disable_msi)
+		ppc_md.disable_msi(pdev);
+}
+
+void pci_scan_msi_device(struct pci_dev *dev) {}
+int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec) {return -1;}
+void pci_disable_msix(struct pci_dev *dev) {}
+void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
+void disable_msi_mode(struct pci_dev *dev, int pos, int type) {}
+void pci_no_msi(void) {}
+
+#endif
+
 #ifdef CONFIG_PPC64
 static int __init setup_noirqdistrib(char *str)
 {
Index: 2.6/include/asm-powerpc/machdep.h
===================================================================
--- 2.6.orig/include/asm-powerpc/machdep.h	2006-06-07 15:23:41.000000000 -0500
+++ 2.6/include/asm-powerpc/machdep.h	2006-06-07 15:24:48.000000000 -0500
@@ -238,6 +238,11 @@
 	 */
 	void (*machine_kexec)(struct kimage *image);
 #endif /* CONFIG_KEXEC */
+
+#ifdef CONFIG_PCI_MSI
+	int (*enable_msi)(struct pci_dev *pdev);
+	void (*disable_msi)(struct pci_dev *pdev);
+#endif /* CONFIG_PCI_MSI */
 };
 
 extern void power4_idle(void);
