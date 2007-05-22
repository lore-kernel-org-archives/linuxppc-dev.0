Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 887FCDDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 04:18:13 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4MHG2F5007730
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:16:02 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4MII5wg541966
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 14:18:05 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4MII5iJ020208
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 14:18:05 -0400
Date: Tue, 22 May 2007 13:18:04 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] (revised) pseries: asm/pci-bridge.h CONFIG_ minor cleanup
Message-ID: <20070522181804.GK5921@austin.ibm.com>
References: <20070521231816.GH5921@austin.ibm.com>
	<1179794459.7189.2.camel@concordia.ozlabs.ibm.com>
	<20070522170058.GJ5921@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070522170058.GJ5921@austin.ibm.com>
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
The config_space array is used by EEH only; it does not
need to be part of the struct for non-pseries machines.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
Revised patch, per commments from Michael Ellerman.

 include/asm-powerpc/pci-bridge.h |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: linux-2.6.22-rc1/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-2.6.22-rc1.orig/include/asm-powerpc/pci-bridge.h	2007-05-21 18:13:00.000000000 -0500
+++ linux-2.6.22-rc1/include/asm-powerpc/pci-bridge.h	2007-05-22 12:03:50.000000000 -0500
@@ -70,19 +70,21 @@ struct pci_dn {
 	int	devfn;			/* pci device and function number */
 	int	class_code;		/* pci device class */
 
-#ifdef CONFIG_PPC_PSERIES
+	struct  pci_controller *phb;	/* for pci devices */
+	struct	iommu_table *iommu_table;	/* for phb's or bridges */
+	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
+	struct	device_node *node;	/* back-pointer to the device_node */
+
+	int	pci_ext_config_space;	/* for pci devices */
+
+#ifdef CONFIG_EEH
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
 	int	eeh_pe_config_addr; /* new-style partition endpoint address */
 	int 	eeh_check_count;	/* # times driver ignored error */
 	int 	eeh_freeze_count;	/* # times this device froze up. */
-#endif
-	int	pci_ext_config_space;	/* for pci devices */
-	struct  pci_controller *phb;	/* for pci devices */
-	struct	iommu_table *iommu_table;	/* for phb's or bridges */
-	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
-	struct	device_node *node;	/* back-pointer to the device_node */
 	u32	config_space[16];	/* saved PCI config space */
+#endif
 };
 
 /* Get the pointer to a device_node's pci_dn */
