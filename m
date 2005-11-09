Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 81F2B686E0
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2005 18:23:22 +1100 (EST)
Date: Tue, 8 Nov 2005 23:22:28 -0800
To: akpm@osdl.org
Message-ID: <20051109072228.GA7983@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: add support for new powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This should be ready to go in now; we'll have to do with basic
enablement for now -- touchpad driver can come later.


Thanks,

Olof

---

Enablement patch for the new PowerBooks (late 2005 edition).

This enables the ATA controller, Gigabit ethernet and basic AGP setup.
Bluetooth works out-of-the box after running hid2hci.

Still remaining is to get the touchpad to work, the simple change of
just adding the new USB ids isn't enough.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: linux-2.6/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-2.6.orig/arch/ppc/platforms/pmac_feature.c	2005-11-08 22:06:20.000000000 -0800
+++ linux-2.6/arch/ppc/platforms/pmac_feature.c	2005-11-08 22:06:48.000000000 -0800
@@ -2317,6 +2317,14 @@ static struct pmac_mb_def pmac_mb_defs[]
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook5,8",			"PowerBook G4 15\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
+	{	"PowerBook5,9",			"PowerBook G4 17\"",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerBook6,1",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
Index: linux-2.6/drivers/ide/ppc/pmac.c
===================================================================
--- linux-2.6.orig/drivers/ide/ppc/pmac.c	2005-11-08 22:06:22.000000000 -0800
+++ linux-2.6/drivers/ide/ppc/pmac.c	2005-11-08 22:06:48.000000000 -0800
@@ -1667,11 +1667,16 @@ static struct macio_driver pmac_ide_maci
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
Index: linux-2.6/drivers/net/sungem.c
===================================================================
--- linux-2.6.orig/drivers/net/sungem.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6/drivers/net/sungem.c	2005-11-08 22:06:48.000000000 -0800
@@ -128,6 +128,8 @@ static struct pci_device_id gem_pci_tbl[
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_SUNGEM,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID2_GMAC,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{0, }
 };
 
Index: linux-2.6/include/linux/pci_ids.h
===================================================================
--- linux-2.6.orig/include/linux/pci_ids.h	2005-11-08 22:06:25.000000000 -0800
+++ linux-2.6/include/linux/pci_ids.h	2005-11-08 22:06:48.000000000 -0800
@@ -801,6 +803,10 @@
 #define PCI_DEVICE_ID_APPLE_SH_SUNGEM   0x0051
 #define PCI_DEVICE_ID_APPLE_U3L_AGP	0x0058
 #define PCI_DEVICE_ID_APPLE_U3H_AGP	0x0059
+#define PCI_DEVICE_ID_APPLE_IPID2_AGP	0x0066
+#define PCI_DEVICE_ID_APPLE_IPID2_ATA	0x0069
+#define PCI_DEVICE_ID_APPLE_IPID2_FW	0x006a
+#define PCI_DEVICE_ID_APPLE_IPID2_GMAC	0x006b
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073
Index: linux-2.6/drivers/char/agp/uninorth-agp.c
===================================================================
--- linux-2.6.orig/drivers/char/agp/uninorth-agp.c	2005-11-08 22:06:21.000000000 -0800
+++ linux-2.6/drivers/char/agp/uninorth-agp.c	2005-11-08 22:06:48.000000000 -0800
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
