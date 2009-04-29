Return-Path: <why@r54964-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2CC4DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 04:14:29 +1000 (EST)
From: Haiying Wang <Haiying.Wang@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 3/6] net/ucc_geth: update riscTx and riscRx in ucc_geth
Date: Wed, 29 Apr 2009 14:14:35 -0400
Message-Id: <12410288811793-git-send-email-Haiying.Wang@freescale.com>
In-Reply-To: <12410288792524-git-send-email-Haiying.Wang@freescale.com>
References: <1241028878175-git-send-email-Haiying.Wang@freescale.com>
	<12410288792524-git-send-email-Haiying.Wang@freescale.com>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the definition of riscTx and riscRx to unsigned integer instead of enum,
and change their values to support 4 risc allocation if the qe has 4 RISC
engines.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 drivers/net/ucc_geth.c |   14 +++++++++++---
 drivers/net/ucc_geth.h |    4 ++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index d3f39e8..3e003fe 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -270,7 +270,7 @@ static int fill_init_enet_entries(struct ucc_geth_private *ugeth,
 				  u8 num_entries,
 				  u32 thread_size,
 				  u32 thread_alignment,
-				  enum qe_risc_allocation risc,
+				  unsigned int risc,
 				  int skip_page_for_first_entry)
 {
 	u32 init_enet_offset;
@@ -307,7 +307,7 @@ static int fill_init_enet_entries(struct ucc_geth_private *ugeth,
 static int return_init_enet_entries(struct ucc_geth_private *ugeth,
 				    u32 *p_start,
 				    u8 num_entries,
-				    enum qe_risc_allocation risc,
+				    unsigned int risc,
 				    int skip_page_for_first_entry)
 {
 	u32 init_enet_offset;
@@ -342,7 +342,7 @@ static int dump_init_enet_entries(struct ucc_geth_private *ugeth,
 				  u32 __iomem *p_start,
 				  u8 num_entries,
 				  u32 thread_size,
-				  enum qe_risc_allocation risc,
+				  unsigned int risc,
 				  int skip_page_for_first_entry)
 {
 	u32 init_enet_offset;
@@ -2134,6 +2134,14 @@ static int ucc_struct_init(struct ucc_geth_private *ugeth)
 		return -ENOMEM;
 	}
 
+	/* read the number of risc engines, update the riscTx and riscRx
+	 * if there are 4 riscs in QE
+	 */
+	if (qe_get_num_of_risc() == 4) {
+		ug_info->riscTx = QE_RISC_ALLOCATION_FOUR_RISCS;
+		ug_info->riscRx = QE_RISC_ALLOCATION_FOUR_RISCS;
+	}
+
 	ugeth->ug_regs = ioremap(uf_info->regs, sizeof(*ugeth->ug_regs));
 	if (!ugeth->ug_regs) {
 		if (netif_msg_probe(ugeth))
diff --git a/drivers/net/ucc_geth.h b/drivers/net/ucc_geth.h
index 2f8ee7c..46bb1d2 100644
--- a/drivers/net/ucc_geth.h
+++ b/drivers/net/ucc_geth.h
@@ -1120,8 +1120,8 @@ struct ucc_geth_info {
 	enum ucc_geth_maccfg2_pad_and_crc_mode padAndCrc;
 	enum ucc_geth_num_of_threads numThreadsTx;
 	enum ucc_geth_num_of_threads numThreadsRx;
-	enum qe_risc_allocation riscTx;
-	enum qe_risc_allocation riscRx;
+	unsigned int riscTx;
+	unsigned int riscRx;
 };
 
 /* structure representing UCC GETH */
-- 
1.6.0.2
