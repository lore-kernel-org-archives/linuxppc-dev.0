Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79746DE30F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 03:48:53 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l51HmnAi003548
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 10:48:49 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l51HmmMD021475
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 12:48:49 -0500 (CDT)
Subject: [PATCH 5/8] Set IDE in ULI1575 to not native mode.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180720128.14219.65.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 01 Jun 2007 12:48:48 -0500
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
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
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
