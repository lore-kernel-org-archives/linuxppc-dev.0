Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A72D5DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 09:18:34 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4LNIVmE019951
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 19:18:31 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4LNIVS9206914
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 17:18:31 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4LNIV02006708
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 17:18:31 -0600
Date: Mon, 21 May 2007 18:18:16 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] pseries: asm/pci-bridge.h CONFIG_ minor cleanup
Message-ID: <20070521231816.GH5921@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


Use the correct CONFIG_ option to mark off the EEH bits.
Move the EEH bits to the bottom of the struct.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 include/asm-powerpc/pci-bridge.h |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.22-rc1/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-2.6.22-rc1.orig/include/asm-powerpc/pci-bridge.h	2007-05-21 18:13:00.000000000 -0500
+++ linux-2.6.22-rc1/include/asm-powerpc/pci-bridge.h	2007-05-21 18:13:36.000000000 -0500
@@ -70,19 +70,20 @@ struct pci_dn {
 	int	devfn;			/* pci device and function number */
 	int	class_code;		/* pci device class */
 
-#ifdef CONFIG_PPC_PSERIES
-	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
-	int	eeh_config_addr;
-	int	eeh_pe_config_addr; /* new-style partition endpoint address */
-	int 	eeh_check_count;	/* # times driver ignored error */
-	int 	eeh_freeze_count;	/* # times this device froze up. */
-#endif
 	int	pci_ext_config_space;	/* for pci devices */
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 	struct	device_node *node;	/* back-pointer to the device_node */
+
+#ifdef CONFIG_EEH
+	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
+	int	eeh_config_addr;
+	int	eeh_pe_config_addr; /* new-style partition endpoint address */
+	int 	eeh_check_count;	/* # times driver ignored error */
+	int 	eeh_freeze_count;	/* # times this device froze up. */
 	u32	config_space[16];	/* saved PCI config space */
+#endif
 };
 
 /* Get the pointer to a device_node's pci_dn */
