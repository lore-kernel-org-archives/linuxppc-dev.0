Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F1D0DDF1F
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 01:55:17 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: don't disable SATA interrupts on Freescale MPC8610
	HPCD
Date: Mon, 20 Apr 2009 10:54:35 -0500
Message-Id: <1240242875-3247-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ULI 1575 PCI quirk function for the Freescale MPC8610 HPCD was disabling
the SATA INTx interrupt, even when SATA support was enabled.  This was safe,
because the SATA driver re-enabled it.  But with commit a5bfc471 ("ahci: drop
intx manipulation on msi enable"), the driver no longer does this, and so SATA
support on the 8610 HPCD is broken.

The original quirk function disabled INTx because it caused some other
interrupt problem during early development on this board, but no one remembers
any more what that problem was, and it doesn't seem to occur any more.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/fsl_uli1575.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 1db6b9e..65a35f3 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -275,11 +275,6 @@ static void __devinit hpcd_quirk_uli5288(struct pci_dev *dev)
 	if (!machine_is(mpc86xx_hpcd))
 		return;
 
-	/* Interrupt Disable, Needed when SATA disabled */
-	pci_read_config_word(dev, PCI_COMMAND, &temp);
-	temp |= 1<<10;
-	pci_write_config_word(dev, PCI_COMMAND, temp);
-
 	pci_read_config_byte(dev, 0x83, &c);
 	c |= 0x80;
 	pci_write_config_byte(dev, 0x83, c);
-- 
1.6.0.6
