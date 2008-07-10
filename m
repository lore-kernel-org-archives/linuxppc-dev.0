Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 0AE9DDDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 19:53:19 +1000 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id C7CEA3CC001
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 11:53:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 9CC65E762E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 11:52:14 +0200 (CEST)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 7E47EE762E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 11:52:14 +0200 (CEST)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id ECD302820
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 13:52:37 +0200 (CEST)
Message-ID: <4875DC0C.2060609@matrix-vision.de>
Date: Thu, 10 Jul 2008 11:53:16 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] MPC52xx PCI write combine timer
Content-Type: multipart/mixed; boundary="------------050504000108070109010000"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050504000108070109010000
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

On MPC52xx the PCI target control register (PCITCR) @ MBAR + 0xD6C is initialized with
only bit 7 (Latrule disable) set. The 8-Bit write combine timer (Bits 24..31) should be
also set to a reasonable value _greater zero_ (0x08 = default) since setting it to 0x00
leads to _very poor_ performance as a PCI target since external burst won't be possible
at all.

Setting the WCT to 0x08 (cache-line size) leads to good overall perfomance.

Signed-off-by: Andre Schwarz <andre.schwarz@matrix-vision.de>
---



MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------050504000108070109010000
Content-Type: text/plain;
 name="patch_mpc5200b_wct"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_mpc5200b_wct"

 arch/powerpc/platforms/52xx/mpc52xx_pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index e3428dd..5a382bb 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -63,6 +63,7 @@
 
 #define MPC52xx_PCI_TCR_P		0x01000000
 #define MPC52xx_PCI_TCR_LD		0x00010000
+#define MPC52xx_PCI_TCR_WCT8		0x00000008
 
 #define MPC52xx_PCI_TBATR_DISABLE	0x0
 #define MPC52xx_PCI_TBATR_ENABLE	0x1
@@ -313,7 +314,7 @@ mpc52xx_pci_setup(struct pci_controller *hose,
 	out_be32(&pci_regs->tbatr1,
 		MPC52xx_PCI_TBATR_ENABLE | MPC52xx_PCI_TARGET_MEM );
 
-	out_be32(&pci_regs->tcr, MPC52xx_PCI_TCR_LD);
+	out_be32(&pci_regs->tcr, MPC52xx_PCI_TCR_LD | MPC52xx_PCI_TCR_WCT8);
 
 	tmp = in_be32(&pci_regs->gscr);
 #if 0

--------------050504000108070109010000--
