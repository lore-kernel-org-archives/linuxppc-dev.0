Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8394DDF4A
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 07:53:46 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l42LrdU6015437
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 14:53:42 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l42Lrcrd018386
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 16:53:39 -0500 (CDT)
Subject: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1178142818.32136.51.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 02 May 2007 16:53:38 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jason Jin <jason.jin@freescale.com>

HD interface and AC97 interface share some pins and they are enabled at
the same time, In order to use AC97 interface, we need to disable the HD
interface first.

Signed-off-by:Jason Jin<jason.jin@freescale.com>
Acked-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 3d3d98f..13a14dd 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -168,7 +168,7 @@ static void __devinit quirk_uli1575(struct pci_dev *dev)
 {
 	unsigned short temp;
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned char irq2pin[16];
+	unsigned char irq2pin[16], c;
 	unsigned long pirq_map_word = 0;
 	u32 irq;
 	int i;
@@ -288,6 +288,11 @@ static void __devinit quirk_uli1575(struct pci_dev *dev)
 	outb(0x1e, 0x4d1);
 
 #undef ULI1575_SET_DEV_IRQ
+
+	/* Disable the HD interface and enable the AC97 interface. */
+	pci_read_config_byte(dev, 0xb8, &c);
+	c &= 0x7f;
+	pci_write_config_byte(dev, 0xb8, c);
 }
 
 static void __devinit quirk_uli5288(struct pci_dev *dev)
-- 
1.5.0.3
