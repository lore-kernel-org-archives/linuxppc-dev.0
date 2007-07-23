Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47382DDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:50:58 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 12/25] [POWERPC] 85xx: Add quirk to ignore bogus FPGA on CDS
Date: Mon, 23 Jul 2007 15:49:59 -0500
Message-Id: <1185223830411-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238283648-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The newer Arcadia boards for CDS have an FPGA that shows up on PCI
however isn't a real PCI device.  Add a quirk to just ignore the
FPGA.

This is based on the following patch from Andy & York:

http://ozlabs.org/pipermail/linuxppc-dev/2007-February/032042.html

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 9b559eb..71200bd 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -108,6 +108,16 @@ static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 	}
 }
 
+static void __devinit skip_fake_bridge(struct pci_dev *dev)
+{
+	/* Make it an error to skip the fake bridge
+	 * in pci_setup_device() in probe.c */
+	dev->hdr_type = 0x7f;
+}
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x3fff, skip_fake_bridge);
+DECLARE_PCI_FIXUP_EARLY(0x3fff, 0x1957, skip_fake_bridge);
+DECLARE_PCI_FIXUP_EARLY(0xff3f, 0x5719, skip_fake_bridge);
+
 #ifdef CONFIG_PPC_I8259
 #warning The i8259 PIC support is currently broken
 static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
-- 
1.5.2.2
