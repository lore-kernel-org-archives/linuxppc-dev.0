Date: Sat, 3 Jan 2004 19:24:44 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org
Subject: [PATCH] kauai ATA for G4 windtunnel
Message-ID: <20040103182444.GA1309@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The kauai ATA support in the 2.5 linuxppc tree for the G4 windtunnel is currently
broken due to a missing PCI id. The pci_ids.h file defines PCI_DEVICE_ID_APPLE_KAUAI_ATA
to be 0x3b while the actual hardware (in my machine) has id 0x33.

The following patch fixes the problem (although the define should of course be pushed to
pci_ids.h).


===== drivers/ide/ppc/pmac.c 1.25 vs edited =====
--- 1.25/drivers/ide/ppc/pmac.c	Mon Sep  1 00:49:53 2003
+++ edited/drivers/ide/ppc/pmac.c	Sat Jan  3 18:27:32 2004
@@ -1439,8 +1439,10 @@
 	.resume		= pmac_ide_macio_resume,
 };

+#define PCI_DEVICE_ID_APPLE_KAUAI_G4WT_ATA 0x33
 static struct pci_device_id pmac_ide_pci_match[] __devinitdata = {
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_KAUAI_ATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_KAUAI_G4WT_ATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 };

 static struct pci_driver pmac_ide_pci_driver = {


/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
