Return-Path: <wei.zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D62FDDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:31:47 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 4/5] Set RC of mpc8641 to transparent bridge for transfer
	legacy I/O access.
Date: Tue, 22 May 2007 11:38:29 +0800
Message-Id: <11798051102051-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <1179805110278-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Set RC of mpc8641 to transparent bridge for transfer legacy I/O access.
Now, the children bus could use the I/O resource of the host bridge.

Note: The 0x7010 is the device ID of host bridge for MPC8641 and
0x7011 is the device ID of host bridge fro MPC8641D.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 2dacc33..eb2bc99 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -319,6 +319,11 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 	pci_write_config_word(dev, 0x4a, temp);
 }
 
+static void __devinit quirk_mpc8641_transparent(struct pci_dev *dev)
+{
+	dev->transparent = 1;
+}
+
 static void __devinit early_uli5249(struct pci_dev *dev)
 {
 	unsigned char temp;
@@ -333,6 +338,8 @@ static void __devinit early_uli5249(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+DECLARE_PCI_FIXUP_HEADER(0x1957, 0x7010, quirk_mpc8641_transparent);
+DECLARE_PCI_FIXUP_HEADER(0x1957, 0x7011, quirk_mpc8641_transparent);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
 #endif /* CONFIG_PCI */
 
-- 
1.5.1
