Return-Path: <wei.zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6243FDDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:31:47 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 5/5] Set IDE in ULI1575 to not native mode.
Date: Tue, 22 May 2007 11:38:30 +0800
Message-Id: <1179805110284-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11798051102051-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<11798051102051-git-send-email-wei.zhang@freescale.com>
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

Set IDE in ULI1575 to not 100% native mode, which forces
the IDE driver to probe the irq itself.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index eb2bc99..2a2dea7 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -314,6 +314,7 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 {
 	unsigned short temp;
 	pci_write_config_word(dev, 0x04, 0x0405);
+	dev->class &= ~0x5;
 	pci_read_config_word(dev, 0x4a, &temp);
 	temp |= 0x1000;
 	pci_write_config_word(dev, 0x4a, temp);
-- 
1.5.1
