Return-Path: <moilanen@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5175967A2E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 04:20:58 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6RIKtbD003062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 14:20:55 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6RIKssZ180428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 12:20:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6RIKrlI007342
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 12:20:53 -0600
Subject: [PATCH][1/2] export msi symbols
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1154024154.29826.229.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 13:17:25 -0500
Message-Id: <1154024245.29826.231.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Forgot to export symbols for MSI.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

 arch/powerpc/kernel/irq.c |    5 +++++
 1 files changed, 5 insertions(+)

Index: 2.6-msi/arch/powerpc/kernel/irq.c
===================================================================
--- 2.6-msi.orig/arch/powerpc/kernel/irq.c
+++ 2.6-msi/arch/powerpc/kernel/irq.c
@@ -52,6 +52,7 @@
 #include <linux/radix-tree.h>
 #include <linux/mutex.h>
 #include <linux/bootmem.h>
+#include <linux/pci.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -818,12 +819,14 @@ int pci_enable_msi(struct pci_dev * pdev
 	else
 		return -1;
 }
+EXPORT_SYMBOL(pci_enable_msi);
 
 void pci_disable_msi(struct pci_dev * pdev)
 {
 	if (ppc_md.disable_msi)
 		ppc_md.disable_msi(pdev);
 }
+EXPORT_SYMBOL(pci_disable_msi);
 
 void pci_scan_msi_device(struct pci_dev *dev) {}
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries,
int nvec) {return -1;}
@@ -831,6 +834,8 @@ void pci_disable_msix(struct pci_dev *de
 void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
 void disable_msi_mode(struct pci_dev *dev, int pos, int type) {}
 void pci_no_msi(void) {}
+EXPORT_SYMBOL(pci_enable_msix);
+EXPORT_SYMBOL(pci_disable_msix);
 
 #endif
 
