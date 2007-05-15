Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 15 May 2007 14:16:35 +1000
Subject: [PATCH] powerpc: Fix warning in pci_64.c
Message-Id: <20070515041705.CCC00DDFC9@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a warning due to unused result from device_create_file
in arch/powerpc/kernel/pci_64.c

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/pci_64.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-cell/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_64.c	2007-05-15 14:14:15.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/pci_64.c	2007-05-15 14:14:54.000000000 +1000
@@ -878,7 +878,8 @@ static DEVICE_ATTR(devspec, S_IRUGO, pci
 
 void pcibios_add_platform_entries(struct pci_dev *pdev)
 {
-	device_create_file(&pdev->dev, &dev_attr_devspec);
+	int rc = device_create_file(&pdev->dev, &dev_attr_devspec);
+	WARN_ON(rc != 0);
 }
 
 #define ISA_SPACE_MASK 0x1
