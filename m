Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1BD2CDDFBA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:30:15 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l54MUBZC009169
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 15:30:11 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l54MUAVE021901
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 17:30:11 -0500 (CDT)
Subject: [PATCH v2 5/9] Set IDE in ULI1575 to not native mode.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180996210.9632.73.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 17:30:10 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

Set IDE in ULI1575 to not 100% native mode, which forces
the IDE driver to probe the irq itself.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 9259788..a82da4b 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -319,6 +319,7 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 {
 	unsigned short temp;
 	pci_write_config_word(dev, 0x04, 0x0405);
+	dev->class &= ~0x5;
 	pci_read_config_word(dev, 0x4a, &temp);
 	temp |= 0x1000;
 	pci_write_config_word(dev, 0x4a, temp);
-- 
1.5.0.3
