Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F2379B7B98
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 03:36:01 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 974BDDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 03:36:00 +1000 (EST)
Date: Thu, 27 Aug 2009 21:35:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 4/5] ucc_geth: Remove UGETH_MAGIC_PACKET Kconfig symbol and
	code
Message-ID: <20090827173556.GD1580@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch removes currently unused UGETH_MAGIC_PACKET Kconfig symbol
and code, i.e. magic_packet_detection_{enable,disable} functions.

The two functions each contain just two steps that we'll place into
suspend/resume code path under CONFIG_PM.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/Kconfig    |    4 ----
 drivers/net/ucc_geth.c |   32 --------------------------------
 2 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 5f6509a..d171131 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2367,10 +2367,6 @@ config UCC_GETH
 	  This driver supports the Gigabit Ethernet mode of the QUICC Engine,
 	  which is available on some Freescale SOCs.
 
-config UGETH_MAGIC_PACKET
-	bool "Magic Packet detection support"
-	depends on UCC_GETH
-
 config UGETH_TX_ON_DEMAND
 	bool "Transmit on Demand support"
 	depends on UCC_GETH
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 488b591..d4e51ee 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -437,38 +437,6 @@ static void hw_add_addr_in_hash(struct ucc_geth_private *ugeth,
 		     QE_CR_PROTOCOL_ETHERNET, 0);
 }
 
-#ifdef CONFIG_UGETH_MAGIC_PACKET
-static void magic_packet_detection_enable(struct ucc_geth_private *ugeth)
-{
-	struct ucc_fast_private *uccf;
-	struct ucc_geth __iomem *ug_regs;
-
-	uccf = ugeth->uccf;
-	ug_regs = ugeth->ug_regs;
-
-	/* Enable interrupts for magic packet detection */
-	setbits32(uccf->p_uccm, UCC_GETH_UCCE_MPD);
-
-	/* Enable magic packet detection */
-	setbits32(&ug_regs->maccfg2, MACCFG2_MPE);
-}
-
-static void magic_packet_detection_disable(struct ucc_geth_private *ugeth)
-{
-	struct ucc_fast_private *uccf;
-	struct ucc_geth __iomem *ug_regs;
-
-	uccf = ugeth->uccf;
-	ug_regs = ugeth->ug_regs;
-
-	/* Disable interrupts for magic packet detection */
-	clrbits32(uccf->p_uccm, UCC_GETH_UCCE_MPD);
-
-	/* Disable magic packet detection */
-	clrbits32(&ug_regs->maccfg2, MACCFG2_MPE);
-}
-#endif /* MAGIC_PACKET */
-
 static inline int compare_addr(u8 **addr1, u8 **addr2)
 {
 	return memcmp(addr1, addr2, ENET_NUM_OCTETS_PER_ADDRESS);
-- 
1.6.3.3
