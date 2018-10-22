Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C62C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 10:50:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A2020671
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 10:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A2020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fVXS2NStzF1Pl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 21:50:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=31.15.61.139; helo=smtp.transmode.se;
 envelope-from=mathias.thore@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=infinera.com
X-Greylist: delayed 303 seconds by postgrey-1.36 at bilbo;
 Tue, 23 Oct 2018 00:01:46 AEDT
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 42dxVf0qgBzDrhS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 00:01:46 +1100 (AEDT)
Received: from se-math-lx.infinera.com (se-math-lx.infinera.com [10.210.72.58])
 by smtp.transmode.se (Postfix) with ESMTP id 061C31186FBC;
 Mon, 22 Oct 2018 14:56:30 +0200 (CEST)
Received: from se-math-lx.infinera.com (se-math-lx.infinera.com [127.0.0.1])
 by se-math-lx.infinera.com (8.14.9/8.14.9) with ESMTP id w9MCuThm031224;
 Mon, 22 Oct 2018 14:56:29 +0200
Received: (from math@localhost)
 by se-math-lx.infinera.com (8.14.9/8.14.9/Submit) id w9MCuThv031222;
 Mon, 22 Oct 2018 14:56:29 +0200
From: Mathias Thore <mathias.thore@infinera.com>
To: qiang.zhao@nxp.com, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 joakim.tjernlund@infinera.com, david.gounaris@infinera.com
Subject: [PATCH] net/wan/fsl_ucc_hdlc: error counters
Date: Mon, 22 Oct 2018 14:55:50 +0200
Message-Id: <20181022125550.31170-1-mathias.thore@infinera.com>
X-Mailer: git-send-email 2.18.1
X-Mailman-Approved-At: Tue, 23 Oct 2018 21:48:35 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mathias Thore <mathias.thore@infinera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Extract error information from rx and tx buffer descriptors,
and update error counters.

Signed-off-by: Mathias Thore <mathias.thore@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 51 +++++++++++++++++++++++++++++-----
 include/soc/fsl/qe/ucc_fast.h  |  8 +++++-
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 5f0366a125e2..934fc149c6b3 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -36,6 +36,7 @@
 #define DRV_NAME "ucc_hdlc"
 
 #define TDM_PPPOHT_SLIC_MAXIN
+#define RX_BD_ERRORS (R_CD_S | R_OV_S | R_CR_S | R_AB_S | R_NO_S | R_LG_S)
 
 static struct ucc_tdm_info utdm_primary_info = {
 	.uf_info = {
@@ -420,12 +421,25 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static int hdlc_tx_restart(struct ucc_hdlc_private *priv)
+{
+	u32 cecr_subblock;
+
+	cecr_subblock =
+		ucc_fast_get_qe_cr_subblock(priv->ut_info->uf_info.ucc_num);
+
+	qe_issue_cmd(QE_RESTART_TX, cecr_subblock,
+		     QE_CR_PROTOCOL_UNSPECIFIED, 0);
+	return 0;
+}
+
 static int hdlc_tx_done(struct ucc_hdlc_private *priv)
 {
 	/* Start from the next BD that should be filled */
 	struct net_device *dev = priv->ndev;
 	struct qe_bd *bd;		/* BD pointer */
 	u16 bd_status;
+	int tx_restart = 0;
 
 	bd = priv->dirty_tx;
 	bd_status = ioread16be(&bd->status);
@@ -434,6 +448,15 @@ static int hdlc_tx_done(struct ucc_hdlc_private *priv)
 	while ((bd_status & T_R_S) == 0) {
 		struct sk_buff *skb;
 
+		if (bd_status & T_UN_S) { /* Underrun */
+			dev->stats.tx_fifo_errors++;
+			tx_restart = 1;
+		}
+		if (bd_status & T_CT_S) { /* Carrier lost */
+			dev->stats.tx_carrier_errors++;
+			tx_restart = 1;
+		}
+
 		/* BD contains already transmitted buffer.   */
 		/* Handle the transmitted buffer and release */
 		/* the BD to be used with the current frame  */
@@ -465,6 +488,9 @@ static int hdlc_tx_done(struct ucc_hdlc_private *priv)
 	}
 	priv->dirty_tx = bd;
 
+	if (tx_restart)
+		hdlc_tx_restart(priv);
+
 	return 0;
 }
 
@@ -483,11 +509,22 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 
 	/* while there are received buffers and BD is full (~R_E) */
 	while (!((bd_status & (R_E_S)) || (--rx_work_limit < 0))) {
-		if (bd_status & R_OV_S)
-			dev->stats.rx_over_errors++;
-		if (bd_status & R_CR_S) {
-			dev->stats.rx_crc_errors++;
-			dev->stats.rx_dropped++;
+		if (bd_status & (RX_BD_ERRORS)) {
+			dev->stats.rx_errors++;
+
+			if (bd_status & R_CD_S)
+				dev->stats.collisions++;
+			if (bd_status & R_OV_S)
+				dev->stats.rx_fifo_errors++;
+			if (bd_status & R_CR_S)
+				dev->stats.rx_crc_errors++;
+			if (bd_status & R_AB_S)
+				dev->stats.rx_over_errors++;
+			if (bd_status & R_NO_S)
+				dev->stats.rx_frame_errors++;
+			if (bd_status & R_LG_S)
+				dev->stats.rx_length_errors++;
+
 			goto recycle;
 		}
 		bdbuffer = priv->rx_buffer +
@@ -535,7 +572,7 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 		netif_receive_skb(skb);
 
 recycle:
-		iowrite16be(bd_status | R_E_S | R_I_S, &bd->status);
+		iowrite16be((bd_status & R_W_S) | R_E_S | R_I_S, &bd->status);
 
 		/* update to point at the next bd */
 		if (bd_status & R_W_S) {
@@ -611,7 +648,7 @@ static irqreturn_t ucc_hdlc_irq_handler(int irq, void *dev_id)
 
 	/* Errors and other events */
 	if (ucce >> 16 & UCC_HDLC_UCCE_BSY)
-		dev->stats.rx_errors++;
+		dev->stats.rx_missed_errors++;
 	if (ucce >> 16 & UCC_HDLC_UCCE_TXE)
 		dev->stats.tx_errors++;
 
diff --git a/include/soc/fsl/qe/ucc_fast.h b/include/soc/fsl/qe/ucc_fast.h
index 3ee9e7c1a7d7..dcd6b865b590 100644
--- a/include/soc/fsl/qe/ucc_fast.h
+++ b/include/soc/fsl/qe/ucc_fast.h
@@ -41,8 +41,12 @@
 #define R_L_S	0x0800	/* last */
 #define R_F_S	0x0400	/* first */
 #define R_CM_S	0x0200	/* continuous mode */
+#define R_LG_S  0x0020  /* frame length */
+#define R_NO_S  0x0010  /* nonoctet */
+#define R_AB_S  0x0008  /* abort */
 #define R_CR_S	0x0004	/* crc */
-#define R_OV_S	0x0002	/* crc */
+#define R_OV_S	0x0002	/* overrun */
+#define R_CD_S  0x0001  /* carrier detect */
 
 /* transmit BD's status */
 #define T_R_S	0x8000	/* ready bit */
@@ -51,6 +55,8 @@
 #define T_L_S	0x0800	/* last */
 #define T_TC_S	0x0400	/* crc */
 #define T_TM_S	0x0200	/* continuous mode */
+#define T_UN_S  0x0002  /* hdlc underrun */
+#define T_CT_S  0x0001  /* hdlc carrier lost */
 
 /* Rx Data buffer must be 4 bytes aligned in most cases */
 #define UCC_FAST_RX_ALIGN			4
-- 
2.18.1

