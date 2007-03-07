Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 26BADDDF96
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 05:35:44 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l27IZgCZ008800
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 11:35:42 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l27IZfC8004715
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 12:35:41 -0600 (CST)
Subject: [PATCH] Do not skip PCI Express to PCI bridge when scanning OF node
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1173292541.23776.125.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 07 Mar 2007 12:35:41 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Haiying Wang <haiying.wang@freescale.com>

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Haiying Wang <haiying.wang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/kernel/prom_parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index ea6fd55..0809977 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -267,7 +267,7 @@ int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
 		ppdev = pdev->bus->self;
 
 		/* Ouch, it's a host bridge... */
-		if (ppdev == NULL) {
+		if (ppdev == NULL || ppdev->devfn == 0) {
 #ifdef CONFIG_PPC64
 			ppnode = pci_bus_to_OF_node(pdev->bus);
 #else
-- 
1.5.0.1.213.g509b
