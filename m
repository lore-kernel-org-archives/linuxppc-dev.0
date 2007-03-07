Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Mar 2007 11:27:45 +0100
Subject: [PATCH 2/3] powerpc: Fix warning in powermac feature.c
Message-Id: <20070307102755.74E38DE169@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes a warning due to unused return from pci_enable_device() in
powermac feature.c core99_ata100_enable() function.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/platforms/powermac/feature.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-tika/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-tika.orig/arch/powerpc/platforms/powermac/feature.c	2007-03-05 14:22:31.000000000 +0100
+++ linux-tika/arch/powerpc/platforms/powermac/feature.c	2007-03-05 14:22:54.000000000 +0100
@@ -810,6 +810,7 @@
 	unsigned long flags;
 	struct pci_dev *pdev = NULL;
 	u8 pbus, pid;
+	int rc;
 
 	if (uninorth_rev < 0x24)
 		return -ENODEV;
@@ -828,7 +829,9 @@
 			pdev = pci_find_slot(pbus, pid);
 		if (pdev == NULL)
 			return 0;
-		pci_enable_device(pdev);
+		rc = pci_enable_device(pdev);
+		if (rc)
+			return rc;
 		pci_set_master(pdev);
 	}
 	return 0;
