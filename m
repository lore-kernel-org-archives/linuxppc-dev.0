Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AC9536861E
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Oct 2005 16:00:00 +1100 (EST)
Date: Sat, 29 Oct 2005 23:42:56 -0500
To: linuxppc-dev@ozlabs.org
Message-ID: <20051030044256.GA10863@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] PPC: Basic enablement for new 15" PowerBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Partial enablement patch for the new PowerBooks (hires revisions).

This enables the ATA controller, Gigabit ethernet and basic AGP setup.

Still remaining is to get the touchpad to work, the simple change of
just adding the new USB ids isn't enough. Sleep isn't working quite yet
either but this will give a kernel that can be used for installation
and basic use for now.

It's a qualified guess that the new 17" is PowerBook5,9, but until it's
confirmed there's not much use in adding it to the pmac_feature table.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: linux-2.6.14/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-2.6.14.orig/arch/ppc/platforms/pmac_feature.c	2005-10-29 23:07:09.000000000 -0500
+++ linux-2.6.14/arch/ppc/platforms/pmac_feature.c	2005-10-29 23:26:33.000000000 -0500
@@ -2317,6 +2317,10 @@ static struct pmac_mb_def pmac_mb_defs[]
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook5,8",			"PowerBook G4 15\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerBook6,1",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
Index: linux-2.6.14/drivers/ide/ppc/pmac.c
===================================================================
--- linux-2.6.14.orig/drivers/ide/ppc/pmac.c	2005-10-29 23:07:09.000000000 -0500
+++ linux-2.6.14/drivers/ide/ppc/pmac.c	2005-10-29 23:13:44.000000000 -0500
@@ -1664,11 +1664,16 @@ static struct macio_driver pmac_ide_maci
 };
 
 static struct pci_device_id pmac_ide_pci_match[] = {
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_ATA,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID2_ATA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 };
 
 static struct pci_driver pmac_ide_pci_driver = {
Index: linux-2.6.14/drivers/net/sungem.c
===================================================================
--- linux-2.6.14.orig/drivers/net/sungem.c	2005-10-29 23:07:09.000000000 -0500
+++ linux-2.6.14/drivers/net/sungem.c	2005-10-29 23:12:58.000000000 -0500
@@ -128,6 +128,8 @@ static struct pci_device_id gem_pci_tbl[
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_SUNGEM,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID2_GMAC,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{0, }
 };
 
Index: linux-2.6.14/include/linux/pci_ids.h
===================================================================
--- linux-2.6.14.orig/include/linux/pci_ids.h	2005-10-29 23:07:09.000000000 -0500
+++ linux-2.6.14/include/linux/pci_ids.h	2005-10-29 23:12:58.000000000 -0500
@@ -913,6 +915,10 @@
 #define PCI_DEVICE_ID_APPLE_SH_FW       0x0052
 #define PCI_DEVICE_ID_APPLE_U3L_AGP	0x0058
 #define PCI_DEVICE_ID_APPLE_U3H_AGP	0x0059
+#define PCI_DEVICE_ID_APPLE_IPID2_AGP	0x0066
+#define PCI_DEVICE_ID_APPLE_IPID2_ATA	0x0069
+#define PCI_DEVICE_ID_APPLE_IPID2_FW	0x006a
+#define PCI_DEVICE_ID_APPLE_IPID2_GMAC	0x006b
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073
Index: linux-2.6.14/drivers/char/agp/uninorth-agp.c
===================================================================
--- linux-2.6.14.orig/drivers/char/agp/uninorth-agp.c	2005-10-29 23:07:09.000000000 -0500
+++ linux-2.6.14/drivers/char/agp/uninorth-agp.c	2005-10-29 23:12:58.000000000 -0500
@@ -557,6 +557,10 @@ static struct agp_device_ids uninorth_ag
 		.device_id	= PCI_DEVICE_ID_APPLE_U3H_AGP,
 		.chipset_name	= "U3H",
 	},
+	{
+		.device_id	= PCI_DEVICE_ID_APPLE_IPID2_AGP,
+		.chipset_name	= "UniNorth/Intrepid2",
+	},
 };
 
 static int __devinit agp_uninorth_probe(struct pci_dev *pdev,
