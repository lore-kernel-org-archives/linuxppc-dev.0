Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 642B9DE198
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 05:37:28 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n3FJbOJh010276
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 14:37:25 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Refactor board check for quirk
Date: Wed, 15 Apr 2009 14:37:24 -0500
Message-Id: <1239824244-11443-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Refactor the check to determine if the quirk is applicable to the boards
into one inline function so we only have to change one place to add more
boards that the quirks might be applicable to.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/fsl_uli1575.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 1db6b9e..4e5ae0a 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -51,13 +51,19 @@ u8 uli_pirq_to_irq[8] = {
 	ULI_8259_NONE,		/* PIRQH */
 };
 
+static inline bool is_quirk_valid(void)
+{
+	return (machine_is(mpc86xx_hpcn) || 
+		machine_is(mpc8544_ds) ||
+		machine_is(mpc8572_ds))
+}
+
 /* Bridge */
 static void __devinit early_uli5249(struct pci_dev *dev)
 {
 	unsigned char temp;
 
-	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
-			!machine_is(mpc8572_ds))
+	if (!is_quirk_valid())
 		return;
 
 	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_IO |
@@ -80,8 +86,7 @@ static void __devinit quirk_uli1575(struct pci_dev *dev)
 {
 	int i;
 
-	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
-			!machine_is(mpc8572_ds))
+	if (!is_quirk_valid())
 		return;
 
 	/*
@@ -149,8 +154,7 @@ static void __devinit quirk_final_uli1575(struct pci_dev *dev)
 	 * IRQ 14: Edge
 	 * IRQ 15: Edge
 	 */
-	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
-			!machine_is(mpc8572_ds))
+	if (!is_quirk_valid())
 		return;
 
 	outb(0xfa, 0x4d0);
@@ -176,8 +180,7 @@ static void __devinit quirk_uli5288(struct pci_dev *dev)
 	unsigned char c;
 	unsigned int d;
 
-	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
-			!machine_is(mpc8572_ds))
+	if (!is_quirk_valid())
 		return;
 
 	/* read/write lock */
@@ -201,8 +204,7 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 {
 	unsigned short temp;
 
-	if (!machine_is(mpc86xx_hpcn) && !machine_is(mpc8544_ds) &&
-			!machine_is(mpc8572_ds))
+	if (!is_quirk_valid())
 		return;
 
 	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE |
-- 
1.6.0.6
